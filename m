Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2198629FEB9
	for <lists+linux-pm@lfdr.de>; Fri, 30 Oct 2020 08:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgJ3HmJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 30 Oct 2020 03:42:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgJ3HlG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:06 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBDD124124;
        Fri, 30 Oct 2020 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043664;
        bh=7PCvqYXC5ML2vix9Gp7G4GlJhwEuCM/vJUI8pbqFTEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTO7VCUO1KnhgYoLRZrLva8riG0EdimGryt9UYaQLrkG3haipz1bZgZpQYv4UQYF8
         B9qvqc23tzBVMSKCGEFk9g3+QBGdazbQUwKVeAzkfJdgiXlB7Q+Qs0MgD5rMt7E+S/
         sW8IH6kBq4NaXNlE1P56ovOfYSxExrY2z2lMWPm4=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1x-004Ogr-V1; Fri, 30 Oct 2020 08:41:01 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 35/39] docs: ABI: sysfs-class-power: unify duplicated properties
Date:   Fri, 30 Oct 2020 08:40:54 +0100
Message-Id: <bcdf5f76326ea48a990a7cac612af216c387537d.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ABI is not supposed to have duplicated entries, as warned
by get_abi.pl:

	$ ./scripts/get_abi.pl validate 2>&1|grep sysfs-class-power
	Warning: /sys/class/power_supply/<supply_name>/current_avg is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:108  Documentation/ABI/testing/sysfs-class-power:391
	Warning: /sys/class/power_supply/<supply_name>/current_max is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:121  Documentation/ABI/testing/sysfs-class-power:404
	Warning: /sys/class/power_supply/<supply_name>/current_now is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:130  Documentation/ABI/testing/sysfs-class-power:414
	Warning: /sys/class/power_supply/<supply_name>/temp is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:281  Documentation/ABI/testing/sysfs-class-power:493
	Warning: /sys/class/power_supply/<supply_name>/temp_alert_max is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:291  Documentation/ABI/testing/sysfs-class-power:505
	Warning: /sys/class/power_supply/<supply_name>/temp_alert_min is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:306  Documentation/ABI/testing/sysfs-class-power:521
	Warning: /sys/class/power_supply/<supply_name>/temp_max is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:322  Documentation/ABI/testing/sysfs-class-power:537
	Warning: /sys/class/power_supply/<supply_name>/temp_min is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:333  Documentation/ABI/testing/sysfs-class-power:547
	Warning: /sys/class/power_supply/<supply_name>/voltage_max is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:356  Documentation/ABI/testing/sysfs-class-power:571
	Warning: /sys/class/power_supply/<supply_name>/voltage_min is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:367  Documentation/ABI/testing/sysfs-class-power:581
	Warning: /sys/class/power_supply/<supply_name>/voltage_now is defined 2 times:  Documentation/ABI/testing/sysfs-class-power:378  Documentation/ABI/testing/sysfs-class-power:591

Yet, both USB and Battery share a common set of charging-related
properties.

Unify the entries for such properties in order to avoid
duplication, while preserving the battery and USB-specific
data properly documented.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/testing/sysfs-class-power | 486 +++++++++-----------
 1 file changed, 223 insertions(+), 263 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index d68ad528a8e5..ca830c6cd809 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -36,7 +36,229 @@ Description:
 		Access: Read
 		Valid values: "Battery", "UPS", "Mains", "USB", "Wireless"
 
-===== Battery Properties =====
+**Battery and USB properties**
+
+What:		/sys/class/power_supply/<supply_name>/current_avg
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Reports an average IBAT current reading for the battery, over
+		  a fixed period. Normally devices will provide a fixed interval
+		  in which they average readings to smooth out the reported
+		  value.
+
+		USB:
+
+		  Reports an average IBUS current reading over a fixed period.
+		  Normally devices will provide a fixed interval in which they
+		  average readings to smooth out the reported value.
+
+		Access: Read
+
+		Valid values: Represented in microamps. Negative values are
+		used for discharging batteries, positive values for charging
+		batteries and for USB IBUS current.
+
+What:		/sys/class/power_supply/<supply_name>/current_max
+Date:		October 2010
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Reports the maximum IBAT current allowed into the battery.
+
+		USB:
+
+		  Reports the maximum IBUS current the supply can support.
+
+		Access: Read
+		Valid values: Represented in microamps
+
+What: 		/sys/class/power_supply/<supply_name>/current_now
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+
+		Battery:
+
+		  Reports an instant, single IBAT current reading for the
+		  battery. This value is not averaged/smoothed.
+
+		  Access: Read
+
+		USB:
+
+		  Reports the IBUS current supplied now. This value is generally
+		  read-only reporting, unless the 'online' state of the supply
+		  is set to be programmable, in which case this value can be set
+		  within the reported min/max range.
+
+		  Access: Read, Write
+
+		Valid values: Represented in microamps. Negative values are
+		used for discharging batteries, positive values for charging
+		batteries and for USB IBUS current.
+
+What:		/sys/class/power_supply/<supply_name>/temp
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Reports the current TBAT battery temperature reading.
+
+		USB:
+
+		  Reports the current supply temperature reading. This would
+		  normally be the internal temperature of the device itself
+		  (e.g TJUNC temperature of an IC)
+
+		Access: Read
+
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_max
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Maximum TBAT temperature trip-wire value where the supply will
+		  notify user-space of the event.
+
+		USB:
+
+		  Maximum supply temperature trip-wire value where the supply
+		  will notify user-space of the event.
+
+		This is normally used for the charging scenario where
+		user-space needs to know if the temperature has crossed an
+		upper threshold so it can take appropriate action (e.g. warning
+		user that the temperature is critically high, and charging has
+		stopped).
+
+		Access: Read
+
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_alert_min
+Date:		July 2012
+Contact:	linux-pm@vger.kernel.org
+Description:
+
+		Battery:
+
+		  Minimum TBAT temperature trip-wire value where the supply will
+		  notify user-space of the event.
+
+		USB:
+
+		  Minimum supply temperature trip-wire value where the supply
+		  will notify user-space of the event.
+
+		This is normally used for the charging scenario where user-space
+		needs to know if the temperature has crossed a lower threshold
+		so it can take appropriate action (e.g. warning user that
+		temperature level is high, and charging current has been
+		reduced accordingly to remedy the situation).
+
+		Access: Read
+
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_max
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Reports the maximum allowed TBAT battery temperature for
+		  charging.
+
+		USB:
+
+		  Reports the maximum allowed supply temperature for operation.
+
+		Access: Read
+
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/temp_min
+Date:		July 2014
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Reports the minimum allowed TBAT battery temperature for
+		  charging.
+
+		USB:
+
+		  Reports the minimum allowed supply temperature for operation.
+
+		Access: Read
+
+		Valid values: Represented in 1/10 Degrees Celsius
+
+What:		/sys/class/power_supply/<supply_name>/voltage_max,
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Reports the maximum safe VBAT voltage permitted for the
+		  battery, during charging.
+
+		USB:
+
+		  Reports the maximum VBUS voltage the supply can support.
+
+		Access: Read
+
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_min,
+Date:		January 2008
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Reports the minimum safe VBAT voltage permitted for the
+		  battery, during discharging.
+
+		USB:
+
+		  Reports the minimum VBUS voltage the supply can support.
+
+		Access: Read
+
+		Valid values: Represented in microvolts
+
+What:		/sys/class/power_supply/<supply_name>/voltage_now,
+Date:		May 2007
+Contact:	linux-pm@vger.kernel.org
+Description:
+		Battery:
+
+		  Reports an instant, single VBAT voltage reading for the
+		  battery. This value is not averaged/smoothed.
+
+		  Access: Read
+
+		USB:
+
+		  Reports the VBUS voltage supplied now. This value is generally
+		  read-only reporting, unless the 'online' state of the supply
+		  is set to be programmable, in which case this value can be set
+		  within the reported min/max range.
+
+		  Access: Read, Write
+
+		Valid values: Represented in microvolts
+
+**Battery Properties**
 
 What:		/sys/class/power_supply/<supply_name>/capacity
 Date:		May 2007
@@ -106,40 +328,6 @@ Description:
 			      "Unknown", "Critical", "Low", "Normal", "High",
 			      "Full"
 
-What:		/sys/class/power_supply/<supply_name>/current_avg
-Date:		May 2007
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports an average IBAT current reading for the battery, over a
-		fixed period. Normally devices will provide a fixed interval in
-		which they average readings to smooth out the reported value.
-
-		Access: Read
-
-		Valid values: Represented in microamps. Negative values are used
-		for discharging batteries, positive values for charging batteries.
-
-What:		/sys/class/power_supply/<supply_name>/current_max
-Date:		October 2010
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the maximum IBAT current allowed into the battery.
-
-		Access: Read
-		Valid values: Represented in microamps
-
-What:		/sys/class/power_supply/<supply_name>/current_now
-Date:		May 2007
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports an instant, single IBAT current reading for the battery.
-		This value is not averaged/smoothed.
-
-		Access: Read
-
-		Valid values: Represented in microamps. Negative values are used
-		for discharging batteries, positive values for charging batteries.
-
 What:		/sys/class/power_supply/<supply_name>/charge_control_limit
 Date:		Oct 2012
 Contact:	linux-pm@vger.kernel.org
@@ -279,68 +467,6 @@ Description:
 			      "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
 			      "NiCd", "LiMn"
 
-What:		/sys/class/power_supply/<supply_name>/temp
-Date:		May 2007
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the current TBAT battery temperature reading.
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
-What:		/sys/class/power_supply/<supply_name>/temp_alert_max
-Date:		July 2012
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Maximum TBAT temperature trip-wire value where the supply will
-		notify user-space of the event. This is normally used for the
-		battery charging scenario where user-space needs to know the
-		battery temperature has crossed an upper threshold so it can
-		take appropriate action (e.g. warning user that battery level is
-		critically high, and charging has stopped).
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
-What:		/sys/class/power_supply/<supply_name>/temp_alert_min
-Date:		July 2012
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Minimum TBAT temperature trip-wire value where the supply will
-		notify user-space of the event. This is normally used for the
-		battery charging scenario where user-space needs to know the
-		battery temperature has crossed a lower threshold so it can take
-		appropriate action (e.g. warning user that battery level is
-		high, and charging current has been reduced accordingly to
-		remedy the situation).
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
-What:		/sys/class/power_supply/<supply_name>/temp_max
-Date:		July 2014
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the maximum allowed TBAT battery temperature for
-		charging.
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
-What:		/sys/class/power_supply/<supply_name>/temp_min
-Date:		July 2014
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the minimum allowed TBAT battery temperature for
-		charging.
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
 
 What:		/sys/class/power_supply/<supply_name>/voltage_avg,
 Date:		May 2007
@@ -354,77 +480,8 @@ Description:
 
 		Valid values: Represented in microvolts
 
-What:		/sys/class/power_supply/<supply_name>/voltage_max,
-Date:		January 2008
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the maximum safe VBAT voltage permitted for the battery,
-		during charging.
-
-		Access: Read
-
-		Valid values: Represented in microvolts
-
-What:		/sys/class/power_supply/<supply_name>/voltage_min,
-Date:		January 2008
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the minimum safe VBAT voltage permitted for the battery,
-		during discharging.
-
-		Access: Read
-
-		Valid values: Represented in microvolts
-
-What:		/sys/class/power_supply/<supply_name>/voltage_now,
-Date:		May 2007
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports an instant, single VBAT voltage reading for the battery.
-		This value is not averaged/smoothed.
-
-		Access: Read
-
-		Valid values: Represented in microvolts
-
 **USB Properties**
 
-What:		/sys/class/power_supply/<supply_name>/current_avg
-Date:		May 2007
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports an average IBUS current reading over a fixed period.
-		Normally devices will provide a fixed interval in which they
-		average readings to smooth out the reported value.
-
-		Access: Read
-
-		Valid values: Represented in microamps
-
-
-What: 		/sys/class/power_supply/<supply_name>/current_max
-Date:		October 2010
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the maximum IBUS current the supply can support.
-
-		Access: Read
-
-		Valid values: Represented in microamps
-
-What: 		/sys/class/power_supply/<supply_name>/current_now
-Date:		May 2007
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the IBUS current supplied now. This value is generally
-		read-only reporting, unless the 'online' state of the supply
-		is set to be programmable, in which case this value can be set
-		within the reported min/max range.
-
-		Access: Read, Write
-
-		Valid values: Represented in microamps
-
 What:		/sys/class/power_supply/<supply_name>/input_current_limit
 Date:		July 2014
 Contact:	linux-pm@vger.kernel.org
@@ -491,70 +548,6 @@ Description:
 			2: Online Programmable - Programmable Voltage Supply
 			== ==================================================
 
-What:		/sys/class/power_supply/<supply_name>/temp
-Date:		May 2007
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the current supply temperature reading. This would
-		normally be the internal temperature of the device itself (e.g
-		TJUNC temperature of an IC)
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
-What:		/sys/class/power_supply/<supply_name>/temp_alert_max
-Date:		July 2012
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Maximum supply temperature trip-wire value where the supply will
-		notify user-space of the event. This is normally used for the
-		charging scenario where user-space needs to know the supply
-		temperature has crossed an upper threshold so it can take
-		appropriate action (e.g. warning user that the supply
-		temperature is critically high, and charging has stopped to
-		remedy the situation).
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
-What:		/sys/class/power_supply/<supply_name>/temp_alert_min
-Date:		July 2012
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Minimum supply temperature trip-wire value where the supply will
-		notify user-space of the event. This is normally used for the
-		charging scenario where user-space needs to know the supply
-		temperature has crossed a lower threshold so it can take
-		appropriate action (e.g. warning user that the supply
-		temperature is high, and charging current has been reduced
-		accordingly to remedy the situation).
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
-What:		/sys/class/power_supply/<supply_name>/temp_max
-Date:		July 2014
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the maximum allowed supply temperature for operation.
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
-What:		/sys/class/power_supply/<supply_name>/temp_min
-Date:		July 2014
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the mainimum allowed supply temperature for operation.
-
-		Access: Read
-
-		Valid values: Represented in 1/10 Degrees Celsius
-
 What: 		/sys/class/power_supply/<supply_name>/usb_type
 Date:		March 2018
 Contact:	linux-pm@vger.kernel.org
@@ -569,39 +562,6 @@ Description:
 			      "Unknown", "SDP", "DCP", "CDP", "ACA", "C", "PD",
 			      "PD_DRP", "PD_PPS", "BrickID"
 
-What: 		/sys/class/power_supply/<supply_name>/voltage_max
-Date:		January 2008
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the maximum VBUS voltage the supply can support.
-
-		Access: Read
-
-		Valid values: Represented in microvolts
-
-What: 		/sys/class/power_supply/<supply_name>/voltage_min
-Date:		January 2008
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the minimum VBUS voltage the supply can support.
-
-		Access: Read
-
-		Valid values: Represented in microvolts
-
-What: 		/sys/class/power_supply/<supply_name>/voltage_now
-Date:		May 2007
-Contact:	linux-pm@vger.kernel.org
-Description:
-		Reports the VBUS voltage supplied now. This value is generally
-		read-only reporting, unless the 'online' state of the supply
-		is set to be programmable, in which case this value can be set
-		within the reported min/max range.
-
-		Access: Read, Write
-
-		Valid values: Represented in microvolts
-
 **Device Specific Properties**
 
 What:		/sys/class/power/ds2760-battery.*/charge_now
-- 
2.26.2

