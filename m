Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470801C81F8
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 08:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGGEn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 02:04:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37212 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgEGGEn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 02:04:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id t11so3410865lfe.4;
        Wed, 06 May 2020 23:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yg86lNUJtaO2OALTMAoBcXWuVDjDz1cz2LE5Df3qyAI=;
        b=T5wypKIWyxJK+re9kzkn2zus/NJPwXniO6WLvP5cI8YETj+wfsgMCLO+wpbr0MsDi3
         k4FT4TGtl2yaZO2AX06wh9H9xBatIJAVsCZMJMhAqMtat92Ln49hmTTkLAGH4x+NLh0d
         6W00HdOV2jehSsSsPU/jYrhiqFPnf9mmWEhyMuMx7CmH3jHBPaDfJ7ETtpgoQQgpLcAf
         WyVnJwprSuJo2IlyVk/k2UjowPCShsuf/CQ6t+tqk+rCyiNNOjEHUftoHTnbhi4xuyG3
         6irX63dzbQCGxyqNJ9slfxm7tEQvGJDfR+tJ61hlH6sGw73UpCehW2Y2zRsydE3hes9x
         lRKA==
X-Gm-Message-State: AGi0PuYXyr32nIbgPAZnXx+dtp5GJ+HD7P8hcqcdGnhcNYj6Uv5wUTlE
        NeDIDv57ZwT0BpLrjbnMRBI=
X-Google-Smtp-Source: APiQypL57Ch1NnIB3iK+pLJbD16xSUoAhGXqLM8R2H1tz1Asxwtw9wW6dykcUmYQMXoRKz5DdzcZWw==
X-Received: by 2002:a19:7418:: with SMTP id v24mr7643016lfe.15.1588831479014;
        Wed, 06 May 2020 23:04:39 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a10sm2636617ljp.16.2020.05.06.23.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 23:04:38 -0700 (PDT)
Date:   Thu, 7 May 2020 09:03:06 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 00/11] Support ROHM BD99954 charger IC
Message-ID: <cover.1588829892.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Sorry folks for excessive amount of emails. I am resending this once
more (I already resent v10 and v11 has no changes but was just rebased)
because I am afraid the previous version did not reach Mark. If this is
true - I am the one to blame. I see I sent original v10 to all other
recipients and lists - except the LKML. So perhaps it evaded Mark's
email filters. And the resend was also sent with the same message-id as
original v10 so even though it did include the LKML it might still have
gone unnoticed. I send this version to limited audience as it has no
changes compared to original v10 - and it already has pretty much all
the acks.


Support ROHM BD99954 Battery Management IC

ROHM BD99954 is a Battery Management IC for 1-4 cell Lithium-Ion
secondary battery. BD99954 is intended to be used in space-constraint
equipment such as Low profile Notebook PC, Tablets and other
applications.

Series extracts a "linear ranges" helper out of the regulator
framework. Linear ranges helper is intended to help converting
real-world values to register values when conversion is linear. I
suspect this is useful also for power subsystem and possibly for clk.

Current implementation does not support inversely proportional ranges
but adding support for that could be helpful.

This version of series introduces new battry DT binding entries and
adds the parsing in power_supply_get_battery_info().

Changelog v11:
 - Rebased on top of v5.7-rc4

Changelog v10:
 - Add patch 11 which removes the "default n" from power/supply KConfig
   (Please just drop from series if you disagree)
 - Fix the regulator_linear_ranges added to qcom_smd-regulator.c at
   v5.7-rc1
 - Minor styling to BD70528 power/supply driver as suggested by Andy

Changelog v9:
 General:
   - rebased on top of v5.7-rc1
   - re-ordered patches as suggested by Sebastian Reichel
   - added few acks
 BD99954 driver:
   - Moved bd99954-charger.h to drivers/power/supply
   - fixed a typo from print
   - used devm_add_action_or_reset and removed remove callback

Changelog v8:
 Linear ranges
   - small improvements suggested by Andy Shevchenko, no functional changes

Changelog v7:
 General:
   - rebased on top of v5.6
 bd99954 driver:
   - fixed bunch of styling issues spotted by Andy Shevchenko
   - dropped ACPI table as ACPI properties are not supported at this
     version of driver.
   - added few acks

Changelog v6:
 generic:
   - rebased on top of 5.6-rc7.
 linear ranges:
   - moved to lib as requested by Greg KH
   - EXPORT_SYMBOL => EXPORT_SYMBOL_GPL
   - licence GPL-2.0, not later
   - added KUnit test for linear ranges

Changelog v5:
 generic:
   - rebased on top of 5.6-rc6.
 DT-bindings:
   - Dropped -charger extension from compatible and removed wildcard x.
 regulators:
   - squashed the regulator changes in one patch.
 power-supply KConfig:
   - fixed indentiation
   - dropped unnecessary 'default N' from BD99954.

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
	Linear ranges helpers
Patch 2:
	Test for linear ranges helpers
Patch 3:
	Rename driver internal struct linear_range from bd70528-power
Patch 4:
	Use linear-ranges helpers in regulator framework and
	convert regulator drivers to use new linear_range struct.
Patch 5:
	Use linear-ranges helpers in bd70528 driver
Patch 6:
	DT binding docs for the new battery parameters
Patch 7:
	Parsing of new battery parameters
Patch 8:
	BD99954 charger DT binding docs
Patch 9:
	ROHM BD99954 charger IC driver
Patch 10:
	Fix Kconfig help text indentiation for other entries as well.
Patch 11:
	Fix Kconfig by removing the "default n".

---


Matti Vaittinen (11):
  lib: add linear ranges helpers
  lib/test_linear_ranges: add a test for the 'linear_ranges'
  power: supply: bd70528: rename linear_range to avoid collision
  regulator: use linear_ranges helper
  power: supply: bd70528: use linear ranges
  dt-bindings: battery: add new battery parameters
  power: supply: add battery parameters
  dt_bindings: ROHM BD99954 Charger
  power: supply: Support ROHM bd99954 charger
  power: supply: Fix Kconfig help text indentiation
  power: supply: KConfig cleanup default n

 .../bindings/power/supply/battery.txt         |    6 +
 .../bindings/power/supply/rohm,bd99954.yaml   |  155 +++
 drivers/power/supply/Kconfig                  |   36 +-
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/bd70528-charger.c        |  140 +-
 drivers/power/supply/bd99954-charger.c        | 1142 +++++++++++++++++
 drivers/power/supply/bd99954-charger.h        | 1075 ++++++++++++++++
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
 drivers/regulator/qcom_smd-regulator.c        |   78 +-
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
 include/linux/power_supply.h                  |    4 +
 include/linux/regulator/driver.h              |   27 +-
 lib/Kconfig                                   |    3 +
 lib/Kconfig.debug                             |   11 +
 lib/Makefile                                  |    2 +
 lib/linear_ranges.c                           |  241 ++++
 lib/test_linear_ranges.c                      |  228 ++++
 62 files changed, 3228 insertions(+), 362 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/rohm,bd99954.yaml
 create mode 100644 drivers/power/supply/bd99954-charger.c
 create mode 100644 drivers/power/supply/bd99954-charger.h
 create mode 100644 include/linux/linear_range.h
 create mode 100644 lib/linear_ranges.c
 create mode 100644 lib/test_linear_ranges.c


base-commit: 0e698dfa282211e414076f9dc7e83c1c288314fd
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
