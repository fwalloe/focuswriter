#!/bin/bash

APP='FocusWriter'
BUNDLE="$APP.app"
VERSION='1.2.2'

# Create disk folder
echo -n 'Copying application bundle... '
rm -f "${APP}_$VERSION.dmg"
rm -rf "$APP"
mkdir "$APP"
cp -pf COPYING "$APP/"
cp -pf README "$APP/"
cp -Rpf "$BUNDLE" "$APP/"
echo 'Done'

# Copy icons
echo -n 'Copying icons... '
ICONS="$APP/$BUNDLE/Contents/Resources/icons"
mkdir $ICONS
cp -Rf icons/oxygen/hicolor $ICONS
echo 'Done'

# Copy dictionary
echo -n 'Copying English dictionary... '
DICTIONARIES="$APP/$BUNDLE/Contents/Resources/Dictionaries"
mkdir $DICTIONARIES
cp -f dict/en_US.aff $DICTIONARIES
cp -f dict/en_US.dic $DICTIONARIES
echo 'Done'

# Copy frameworks and plugins
echo -n 'Copying frameworks and plugins... '
macdeployqt "$APP/$BUNDLE"
echo 'Done'

# Create disk image
echo -n 'Creating disk image... '
hdiutil create -quiet -ov -srcfolder "$APP" -format UDBZ -volname "$APP" "${APP}_$VERSION.dmg"
hdiutil internet-enable -quiet -yes "${APP}_$VERSION.dmg"
echo 'Done'

# Clean up disk folder
echo -n 'Cleaning up... '
rm -rf "$APP"
echo 'Done'
