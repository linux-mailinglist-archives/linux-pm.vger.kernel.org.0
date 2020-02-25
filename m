Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7607116BC5F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2020 09:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgBYIvx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Feb 2020 03:51:53 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46386 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729205AbgBYIvx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Feb 2020 03:51:53 -0500
Received: by mail-lj1-f193.google.com with SMTP id x14so13060855ljd.13;
        Tue, 25 Feb 2020 00:51:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Kvje0WIw7KFHi5eXdBrKsbSHw9Uloy6b5E6xrY+Sd2Y=;
        b=lRZUa9Kb6gO9KF75mdpX7XpLp+8KEQbH5WR5dCLu1CfYrlcEVvM8YADmF8ZWof/2dP
         10Ah5WEbHcUsbdrJdYciM/+1l7OwzEy5yXTPvSolOkqcBQx5hUex9Cj63dYsdxeLT2eM
         IL4FZ46crP4nSXLU8sSgNyR2ORpn1LQq6ktr2rQ/o2h4ObbkzkvodxeGAbVDDckVqPj9
         FD67Wxq2Qd4gvVx8e48XY6k6CpEMNXQTx00/CsRuLglyBGqH88kOPumcgDDikGhP0VR0
         CNu3/eGaBHunSG5YFFeLLsPe3xH+KTafSFcr0MKScRGztTJydOT1InngEtDeBldVJbOV
         dDtw==
X-Gm-Message-State: APjAAAXwk55lA7FELf0qPU7ACsTgQompkxs8b4cy4FpOT9zlind2r+iQ
        FFCY0PhZibYwf8qqGaSmU6U=
X-Google-Smtp-Source: APXvYqz7uZdBXFV64Wz9Uhk6CHJuqHjdgYBSYtnPSe438XEGhZW7urMt4TKhbEmaDjed40LoEOMtSQ==
X-Received: by 2002:a2e:9d0f:: with SMTP id t15mr32683526lji.171.1582620710301;
        Tue, 25 Feb 2020 00:51:50 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q10sm7408725ljj.60.2020.02.25.00.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 00:51:49 -0800 (PST)
Date:   Tue, 25 Feb 2020 10:51:36 +0200
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
        linux-pm@vger.kernel.org, patches@opensource.cirrus.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>
Subject: [PATCH v4 0/9] Support ROHM BD99954 charger IC
Message-ID: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
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
suspect this is useful also for power subsystem and possibly for clk.

This version of series introduces new battry DT binding entries and
adds the parsing in power_supply_get_battery_info().

Please note that regulator drivers have been compile tested (but not
linked) after patch 5.

Please also note that only the BD71847 based regulator testing has
been performed after the patch 6 - all testing is highly appreciated.

Changelog v4:
 generic:
   - rebase and drop RFC.
 DT-bindings:
   - add I2C node address-cells and size-cells to fix yaml check errors
   - uncomment multipleOf:
 bd70528:
   - add patch which renames driver internal linear_range struct to
     avoid collision when regulator/driver.h (which gets included from
     rohm generic header) introduces the linear_range struct.
 regulators:
   - rebase to v5.6-rc2 and convert also the two newly introduced
     drivers to use linear_range struct instead of
     regulator_linear_range.
 linear_ranges:
   - Fix kerneldoc.

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
	Rename driver internal struct linear_range from bd70528-power
Patch 5:
	Rename struct regulator_linear_range to struct linear_range and
	convert regulator drivers to use renamed struct
Patch 6:
	Use linear-ranges helpers in regulator framework
Patch 7:
	Use linear-ranges helpers in bd70528 driver
Patch 8:
	Parsing of new battery parameters
Patch 9:
	ROHM BD99954 charger IC driver

---

Matti Vaittinen (9):
  dt-bindings: battery: add new battery parameters
  dt_bindings: ROHM BD99954 Charger
  drivers: base: add linear ranges helpers
  power: supply: bd70528: rename linear_range to avoid collision
  regulator: rename regulator_linear_range to linear_range
  regulator: use linear_ranges helper
  power: supply: bd70528: use linear ranges
  power: supply: add battery parameters
  power: supply: Support ROHM bd99954 charger

 .../bindings/power/supply/battery.txt         |    6 +
 .../bindings/power/supply/rohm,bd9995x.yaml   |  155 +++
 drivers/base/Kconfig                          |    3 +
 drivers/base/Makefile                         |    1 +
 drivers/base/linear_ranges.c                  |  246 ++++
 drivers/power/supply/Kconfig                  |   11 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bd70528-charger.c        |  140 +-
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
 drivers/regulator/bd71828-regulator.c         |   10 +-
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
 drivers/regulator/mp8859.c                    |    2 +-
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
 60 files changed, 3007 insertions(+), 344 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd9995x.yaml
 create mode 100644 drivers/base/linear_ranges.c
 create mode 100644 drivers/power/supply/bd99954-charger.c
 create mode 100644 include/linux/linear_range.h
 create mode 100644 include/linux/power/bd99954-charger.h


base-commit 11a48a5a18c6 ("Linux 5.6-rc2")
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
