Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2871D1E21
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390369AbgEMS4d (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 14:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390362AbgEMS4d (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 14:56:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B77C061A0E;
        Wed, 13 May 2020 11:56:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id DAE132A2521
Received: by jupiter.universe (Postfix, from userid 1000)
        id 63EF24800F8; Wed, 13 May 2020 20:56:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 00/19] Improve SBS battery support
Date:   Wed, 13 May 2020 20:55:56 +0200
Message-Id: <20200513185615.508236-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patchset improves support for SBS compliant batteries. Due to
the changes, the battery now exposes 32 power supply properties and
(un)plugging it generates a backtrace containing the following message
without the first patch in this series:

---------------------------
WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0xd4/0x104
add_uevent_var: too many keys
---------------------------

For references this is what an SBS battery status looks like after
the patch series has been applied:

cat /sys/class/power_supply/sbs-0-000b/uevent 
POWER_SUPPLY_NAME=sbs-0-000b
POWER_SUPPLY_TYPE=Battery
POWER_SUPPLY_STATUS=Discharging
POWER_SUPPLY_CAPACITY_LEVEL=Normal
POWER_SUPPLY_HEALTH=Good
POWER_SUPPLY_PRESENT=1
POWER_SUPPLY_TECHNOLOGY=Li-ion
POWER_SUPPLY_CYCLE_COUNT=12
POWER_SUPPLY_VOLTAGE_NOW=11441000
POWER_SUPPLY_CURRENT_NOW=-26000
POWER_SUPPLY_CURRENT_AVG=-24000
POWER_SUPPLY_CAPACITY=76
POWER_SUPPLY_CAPACITY_ERROR_MARGIN=1
POWER_SUPPLY_TEMP=198
POWER_SUPPLY_TIME_TO_EMPTY_AVG=438600
POWER_SUPPLY_TIME_TO_FULL_AVG=3932100
POWER_SUPPLY_SERIAL_NUMBER=0000
POWER_SUPPLY_VOLTAGE_MIN_DESIGN=10800000
POWER_SUPPLY_VOLTAGE_MAX_DESIGN=10800000
POWER_SUPPLY_ENERGY_NOW=31090000
POWER_SUPPLY_ENERGY_FULL=42450000
POWER_SUPPLY_ENERGY_FULL_DESIGN=41040000
POWER_SUPPLY_CHARGE_NOW=2924000
POWER_SUPPLY_CHARGE_FULL=3898000
POWER_SUPPLY_CHARGE_FULL_DESIGN=3800000
POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=3000000
POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=12300000
POWER_SUPPLY_MANUFACTURE_YEAR=2017
POWER_SUPPLY_MANUFACTURE_MONTH=7
POWER_SUPPLY_MANUFACTURE_DAY=3
POWER_SUPPLY_MANUFACTURER=UR18650A
POWER_SUPPLY_MODEL_NAME=GEHC

-- Sebastian

Jean-Francois Dagenais (1):
  power: supply: sbs-battery: add ability to disable charger broadcasts

Sebastian Reichel (18):
  kobject: increase allowed number of uevent variables
  power: supply: core: add capacity error margin property
  power: supply: core: add manufacture date properties
  power: supply: core: add POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED
  power: supply: sbs-battery: Add TI BQ20Z65 support
  power: supply: sbs-battery: add
    POWER_SUPPLY_PROP_CAPACITY_ERROR_MARGIN support
  power: supply: sbs-battery: simplify read_read_string_data
  power: supply: sbs-battery: add PEC support
  power: supply: sbs-battery: add POWER_SUPPLY_PROP_CURRENT_AVG support
  power: supply: sbs-battery: Improve POWER_SUPPLY_PROP_TECHNOLOGY
    support
  power: supply: sbs-battery: add
    POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT/VOLTAGE_MAX support
  power: supply: sbs-battery: add MANUFACTURE_DATE support
  power: supply: sbs-battery: add
    POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED support
  power: supply: sbs-battery: fix idle battery status
  power: supply: sbs-battery: switch from of_property_* to
    device_property_*
  power: supply: sbs-battery: switch to i2c's probe_new
  power: supply: sbs-battery: constify power-supply property array
  dt-bindings: power: sbs-battery: Convert to yaml

 Documentation/ABI/testing/sysfs-class-power   |  45 ++-
 .../power/supply/sbs,sbs-battery.yaml         |  83 +++++
 .../bindings/power/supply/sbs_sbs-battery.txt |  27 --
 drivers/power/supply/power_supply_sysfs.c     |   5 +
 drivers/power/supply/sbs-battery.c            | 348 +++++++++++++-----
 include/linux/kobject.h                       |   2 +-
 include/linux/power_supply.h                  |   5 +
 7 files changed, 404 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-battery.yaml
 delete mode 100644 Documentation/devicetree/bindings/power/supply/sbs_sbs-battery.txt

-- 
2.26.2

