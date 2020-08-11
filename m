Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE6241AFB
	for <lists+linux-pm@lfdr.de>; Tue, 11 Aug 2020 14:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgHKMbo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Aug 2020 08:31:44 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:48782 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728622AbgHKMbn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2020 08:31:43 -0400
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id 6A8D5EC6FA;
        Tue, 11 Aug 2020 20:31:33 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31766T140662640989952S1597149092697840_;
        Tue, 11 Aug 2020 20:31:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ce0762416ef844ab3f3891c498f4d4c5>
X-RL-SENDER: finley.xiao@rock-chips.com
X-SENDER: xf@rock-chips.com
X-LOGIN-NAME: finley.xiao@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Finley Xiao <finley.xiao@rock-chips.com>
To:     heiko@sntech.de, rui.zhang@intel.com, daniel.lezcano@linaro.org,
        robh+dt@kernel.org
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        huangtao@rock-chips.com, tony.xie@rock-chips.com,
        cl@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH v1] thermal/of: Introduce k-po, k-pu and k-i for a thermal zone
Date:   Tue, 11 Aug 2020 20:31:15 +0800
Message-Id: <20200811123115.8144-1-finley.xiao@rock-chips.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The default value for k_pu is:
    2 * sustainable_power / (desired_temperature - switch_on_temp)
The default value for k_po is:
    sustainable_power / (desired_temperature - switch_on_temp)
The default value for k_i is 10.

Even though these parameters of the PID controller can be changed
by the following sysfs files:
    /sys/class/thermal/thermal_zoneX/k_pu
    /sys/class/thermal/thermal_zoneX/k_po
    /sys/class/thermal/thermal_zoneX/k_i

But it's still more convenient to change the default values by devicetree,
so introduce these three optional properties. If provided these properties,
they will be parsed and associated with the thermal zone via the thermal
zone parameters.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 Documentation/devicetree/bindings/thermal/thermal.txt | 14 ++++++++++++++
 drivers/thermal/thermal_of.c                          |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/thermal.txt b/Documentation/devicetree/bindings/thermal/thermal.txt
index f78bec19ca35..ebe936b57ded 100644
--- a/Documentation/devicetree/bindings/thermal/thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/thermal.txt
@@ -165,6 +165,20 @@ Optional property:
 			2000mW, while on a 10'' tablet is around
 			4500mW.
 
+- k-po:			Proportional parameter of the PID controller when
+			current temperature is above the target.
+  Type: signed
+  Size: one cell
+
+- k-pu:			Proportional parameter of the PID controller when
+			current temperature is below the target.
+  Type: signed
+  Size: one cell
+
+- k-i:			Integral parameter of the PID controller.
+  Type: signed
+  Size: one cell
+
 Note: The delay properties are bound to the maximum dT/dt (temperature
 derivative over time) in two situations for a thermal zone:
 (i)  - when passive cooling is activated (polling-delay-passive); and
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index ddf88dbe7ba2..b2a9f92cd8d2 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -1089,6 +1089,7 @@ int __init of_parse_thermal_zones(void)
 		struct thermal_zone_params *tzp;
 		int i, mask = 0;
 		u32 prop;
+		s32 sval;
 
 		tz = thermal_of_build_thermal_zone(child);
 		if (IS_ERR(tz)) {
@@ -1113,6 +1114,12 @@ int __init of_parse_thermal_zones(void)
 
 		if (!of_property_read_u32(child, "sustainable-power", &prop))
 			tzp->sustainable_power = prop;
+		if (!of_property_read_s32(child, "k-po", &sval))
+			tzp->k_po = sval;
+		if (!of_property_read_s32(child, "k-pu", &sval))
+			tzp->k_pu = sval;
+		if (!of_property_read_s32(child, "k-i", &sval))
+			tzp->k_i = sval;
 
 		for (i = 0; i < tz->ntrips; i++)
 			mask |= 1 << i;
-- 
2.11.0



