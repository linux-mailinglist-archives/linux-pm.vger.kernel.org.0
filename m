Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95D5165875
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 08:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgBTHdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 02:33:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41955 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgBTHdc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 02:33:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so2243312lfp.8;
        Wed, 19 Feb 2020 23:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wiE1MVBAq+dtJZbD9QhDjogT10xMsxH3KrA52tzGEaE=;
        b=IXrN53CXFWXmXKd55kyidobMuN9OB0hTpHHKqQrEUbv/XSolBUPOcsLKt18/FASetM
         YVscCd80FZs0X83NZU9lt/LEOiCcJP1vrrCh7+Sq/H7dVMh9SWMCrrX8SUHa2aoODt4v
         w2g6tDib4eMyK0/GaVpihdKbq0cDoLzc5gh/QZW/LnmIW9ostQE5c79TZjwXmI11bmhY
         v1AdVRgCDpLxJvx32GaLQoLoVlGv27upx0/0YJEyRzaSKFTvINE394a8G5JTOMQkhF08
         2xn1VdvxYHGeVjFyVgMxZ5AARizeZKel0k1tyCOL5LTYY0FgPLSPDh9KaxtF0NzVxNBs
         xung==
X-Gm-Message-State: APjAAAUmX9+7myDMwgh0uzh8Vd1nBPpbUig8l+iGja7YxclZs4oux2CW
        CrJ2I9NPxXcrJYUDcA7oxSc=
X-Google-Smtp-Source: APXvYqydig+xF2Ywm6Iv7YBB1hG2cbKXIzbm+c80mkOrc6fpXIb3jtHpbOGYiojY8rsNm8HRCIfnww==
X-Received: by 2002:a19:6445:: with SMTP id b5mr15432764lfj.187.1582184007747;
        Wed, 19 Feb 2020 23:33:27 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id w6sm1256991lfq.95.2020.02.19.23.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 23:33:27 -0800 (PST)
Date:   Thu, 20 Feb 2020 09:33:14 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Milo Kim <milo.kim@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [RFC PATCH v3 0/8] Support ROHM BD99954 charger IC
Message-ID: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Support ROHM BD99954 Battery Management IC

ROHM BD99954 is a Battery Management IC for 1-4 cell Lithium-Ion
secondary battery. BD99954 is intended to be used in space-constraint
equipment such as Low profile Notebook PC, Tablets and other
applications.

Series extracts a "linear ranges" helper out of the regulator
framework. Linear ranges helper is intended to help converting
real-world values to register values when conversion is linear. I
suspect this is usefull also for power subsystem and possibly for clk.

This version of series introduces new battry DT binding entries and
adds the parsing in power_supply_get_battery_info(). These properties
can be converted to ROHM specific properties and parsing can be moved
to the BD99954 driver if this does not seem like a right thing to do.
I just have a feeling the the BD99954 is not the only charger which
could utilize these.

We also add ROHM specific charger parameters for limiting the input
current(s). I think these parameters are pretty common and maybe the
"rohm,"-prefix should be dropped and we should try having common
input limiting properties for different chips?

Series is based on v5.5-rc7

Changelog RFC-v3:
 DT-bindings:
   - fix the BD99954 binding (the *-microvolt Vs. *-microvolts issue is
     still there. Not sure which one is correct)
   - renabe tricklecharge-* binding to trickle-charge-* as suggested by
     Rob.
   - drop the linear-ranges helper which was written for BD70528 and
     extract the linear-range code from regulator framework instead.
   - refactor regulator framework to utilize extracted linear-ranges
     code.
   - change the struct regulator_linear_range to linear_range from
     regulator drivers.
   - refactor BD70528 to use regulator framework originated
     linear-ranges code.
   - change BD99954 to use linear-ranges code from regulator framework

Changelog RFC-v2:
 DT-bindings:
   - Used the battery parameters described in battery.txt
   - Added few new parameters to battery.txt
   - Added ASCII art charging profile chart for BD99954 to explain
     states and limits.
 Linear ranges:
   - Fixed division by zero error from linear-ranges code if step 0 is
     used.
 Power-supply core:
   - Added parsing of new battery parameters.
 BD99954 driver:
   - converted to use battery parameters from battery node
   - Added step 0 ranges for reg values which do not change voltage
   - added dt-node to psy-config

Patch 1:
	DT binding docs for the new battery parameters
Patch 2:
	BD99954 charger DT binding docs
Patch 3:
	Linear ranges helpers
Patch 4:
	Rename struct regulator_linear_range to struct linear_range and
	convert regulator drivers to use renamed struct
Patch 5:
	Use linear-ranges helpers in regulator framework
Patch 6:
	Use linear-ranges helpers in bd70528 driver
Patch 7:
	Parsing of new battery parameters
Patch 8:
	ROHM BD99954 charger IC driver

---

Matti Vaittinen (8):
  dt-bindings: battry: add new battery parameters
  dt_bindings: ROHM BD99954 Charger
  drivers: base: add linear ranges helpers
  regulator: rename regulator_linear_range to linear_range
  regulator: use linear_ranges helper
  power: supply: bd70528: use linear ranges
  power: supply: add battery parameters
  power: supply: Support ROHM bd99954 charger

 .../bindings/power/supply/battery.txt         |    6 +
 .../bindings/power/supply/rohm,bd9995x.yaml   |  153 +++
 drivers/base/Kconfig                          |    3 +
 drivers/base/Makefile                         |    1 +
 drivers/base/linear_ranges.c                  |  246 ++++
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bd70528-charger.c        |  142 +-
 drivers/power/supply/bd99954-charger.c        | 1171 +++++++++++++++++
 drivers/power/supply/power_supply_core.c      |    8 +
 drivers/regulator/88pg86x.c                   |    4 +-
 drivers/regulator/88pm800-regulator.c         |    4 +-
 drivers/regulator/Kconfig                     |    1 +
 drivers/regulator/act8865-regulator.c         |    4 +-
 drivers/regulator/act8945a-regulator.c        |    2 +-
 drivers/regulator/arizona-ldo1.c              |    2 +-
 drivers/regulator/arizona-micsupp.c           |    4 +-
 drivers/regulator/as3711-regulator.c          |    6 +-
 drivers/regulator/as3722-regulator.c          |    4 +-
 drivers/regulator/axp20x-regulator.c          |   16 +-
 drivers/regulator/bcm590xx-regulator.c        |    8 +-
 drivers/regulator/bd70528-regulator.c         |    8 +-
 drivers/regulator/bd718x7-regulator.c         |   26 +-
 drivers/regulator/da903x.c                    |    2 +-
 drivers/regulator/helpers.c                   |  130 +-
 drivers/regulator/hi6421-regulator.c          |    4 +-
 drivers/regulator/lochnagar-regulator.c       |    4 +-
 drivers/regulator/lp873x-regulator.c          |    4 +-
 drivers/regulator/lp87565-regulator.c         |    2 +-
 drivers/regulator/lp8788-buck.c               |    2 +-
 drivers/regulator/max77650-regulator.c        |    2 +-
 drivers/regulator/mcp16502.c                  |    4 +-
 drivers/regulator/mt6323-regulator.c          |    6 +-
 drivers/regulator/mt6358-regulator.c          |    8 +-
 drivers/regulator/mt6380-regulator.c          |    6 +-
 drivers/regulator/mt6397-regulator.c          |    6 +-
 drivers/regulator/palmas-regulator.c          |    4 +-
 drivers/regulator/qcom-rpmh-regulator.c       |    2 +-
 drivers/regulator/qcom_rpm-regulator.c        |   14 +-
 drivers/regulator/qcom_smd-regulator.c        |   70 +-
 drivers/regulator/rk808-regulator.c           |   10 +-
 drivers/regulator/s2mps11.c                   |   14 +-
 drivers/regulator/sky81452-regulator.c        |    2 +-
 drivers/regulator/stpmic1_regulator.c         |   18 +-
 drivers/regulator/tps65086-regulator.c        |   10 +-
 drivers/regulator/tps65217-regulator.c        |    4 +-
 drivers/regulator/tps65218-regulator.c        |    6 +-
 drivers/regulator/tps65912-regulator.c        |    4 +-
 drivers/regulator/twl-regulator.c             |    4 +-
 drivers/regulator/twl6030-regulator.c         |    2 +-
 drivers/regulator/wm831x-dcdc.c               |    2 +-
 drivers/regulator/wm831x-ldo.c                |    4 +-
 drivers/regulator/wm8350-regulator.c          |    2 +-
 drivers/regulator/wm8400-regulator.c          |    2 +-
 include/linux/linear_range.h                  |   48 +
 include/linux/power/bd99954-charger.h         | 1075 +++++++++++++++
 include/linux/power_supply.h                  |    4 +
 include/linux/regulator/driver.h              |   27 +-
 58 files changed, 3000 insertions(+), 339 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
 create mode 100644 drivers/base/linear_ranges.c
 create mode 100644 drivers/power/supply/bd99954-charger.c
 create mode 100644 include/linux/linear_range.h
 create mode 100644 include/linux/power/bd99954-charger.h


base-commit def9d2780727 ("Linux 5.5-rc7")
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
