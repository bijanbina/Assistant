#/bin/sh
x_text_fa="265"
x_text_en="38"
y_text_fa="-762"
y_text_en="-760"
line_num=1
line_fa=""
line_en=""
cp base.svg 5.svg
while [[ `echo "scale=1;($y_text_fa)<-80" | bc` == "1" ]]; do
   line_fa=`sed "$line_num""q;d" phrasebook | awk -F " , " '{print $2}'`
   echo "<text transform=\"scale(1,-1)\" sodipodi:linespacing=\"120%\" id=\"text14283\" y=\"$y_text_fa\" x=\"$x_text_fa\" style=\"color:#000000;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:11.19999981px;line-height:120.00000477%;font-family:'Adobe Arabic';-inkscape-font-specification:'Adobe Arabic'text-indent:0;text-align:end;text-decoration:none;text-decoration-line:none;text-decoration-style:solid;text-decoration-color:#000000;letter-spacing:0px;word-spacing:0px;text-transform:none;direction:ltr;block-progression:tb;writing-mode:lr-tb;baseline-shift:baseline;text-anchor:end;white-space:normal;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:1.25px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate\" xml:space=\"preserve\"><tspan y=\"$y_text_fa\" x=\"$x_text_fa\" id=\"tspan14285\" sodipodi:role=\"line\">$line_fa</tspan></text>" >> 5.svg
   y_text_fa=`echo "scale=1;($y_text_fa+13.8)" | bc`
   #echo $line_fa
   line_en=`sed "$line_num""q;d" phrasebook | awk -F " , " '{print $1}'`
   echo "<text transform=\"scale(1,-1)\" sodipodi:linespacing=\"120%\" id=\"text14283\" y=\"$y_text_en\" x=\"$x_text_en\" style=\"color:#000000;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:10.39999962px;line-height:120.00000477%;font-family:'Helvetica LT Std';-inkscape-font-specification:'Helvetica LT Std';text-indent:0;text-align:start;text-decoration:none;text-decoration-line:none;text-decoration-style:solid;text-decoration-color:#000000;letter-spacing:0px;word-spacing:0px;text-transform:none;direction:ltr;block-progression:tb;writing-mode:lr-tb;baseline-shift:baseline;text-anchor:start;white-space:normal;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:1.25px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate\" xml:space=\"preserve\"><tspan y=\"$y_text_en\" x=\"$x_text_en\" id=\"tspan14285\" sodipodi:role=\"line\">$line_en</tspan></text>" >> 5.svg
   y_text_en=`echo "scale=1;($y_text_en+13.8)" | bc`
   line_num=$((line_num+1))
   #echo $y_text_fa
done

x_text_fa="550"
x_text_en="323.5"
y_text_fa="-762"
y_text_en="-760"

while [[ `echo "scale=1;($y_text_fa)<-80" | bc` == "1" ]]; do
   line_fa=`sed "$line_num""q;d" phrasebook | awk -F " , " '{print $2}'`
   echo "<text transform=\"scale(1,-1)\" sodipodi:linespacing=\"120%\" id=\"text14283\" y=\"$y_text_fa\" x=\"$x_text_fa\" style=\"color:#000000;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:11.19999981px;line-height:120.00000477%;font-family:'Adobe Arabic';-inkscape-font-specification:'Adobe Arabic'text-indent:0;text-align:end;text-decoration:none;text-decoration-line:none;text-decoration-style:solid;text-decoration-color:#000000;letter-spacing:0px;word-spacing:0px;text-transform:none;direction:ltr;block-progression:tb;writing-mode:lr-tb;baseline-shift:baseline;text-anchor:end;white-space:normal;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:1.25px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate\" xml:space=\"preserve\"><tspan y=\"$y_text_fa\" x=\"$x_text_fa\" id=\"tspan14285\" sodipodi:role=\"line\">$line_fa</tspan></text>" >> 5.svg
   y_text_fa=`echo "scale=1;($y_text_fa+13.8)" | bc`
   #echo $line_fa
   line_en=`sed "$line_num""q;d" phrasebook | awk -F " , " '{print $1}'`
   echo "<text transform=\"scale(1,-1)\" sodipodi:linespacing=\"120%\" id=\"text14283\" y=\"$y_text_en\" x=\"$x_text_en\" style=\"color:#000000;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:10.39999962px;line-height:120.00000477%;font-family:'Helvetica LT Std';-inkscape-font-specification:'Helvetica LT Std';text-indent:0;text-align:start;text-decoration:none;text-decoration-line:none;text-decoration-style:solid;text-decoration-color:#000000;letter-spacing:0px;word-spacing:0px;text-transform:none;direction:ltr;block-progression:tb;writing-mode:lr-tb;baseline-shift:baseline;text-anchor:start;white-space:normal;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#000000;solid-opacity:1;fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:1.25px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate\" xml:space=\"preserve\"><tspan y=\"$y_text_en\" x=\"$x_text_en\" id=\"tspan14285\" sodipodi:role=\"line\">$line_en</tspan></text>" >> 5.svg
   y_text_en=`echo "scale=1;($y_text_en+13.8)" | bc`
   line_num=$((line_num+1))
   #echo $y_text_fa
done
echo "</g></svg>" >> 5.svg
inkscape 5.svg --export-pdf=t.pdf
