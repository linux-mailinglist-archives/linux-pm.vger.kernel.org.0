Return-Path: <linux-pm+bounces-14313-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B79797E7
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 19:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE51F21778
	for <lists+linux-pm@lfdr.de>; Sun, 15 Sep 2024 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028271C7B8A;
	Sun, 15 Sep 2024 17:23:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from sxb1plsmtpa01-05.prod.sxb1.secureserver.net (sxb1plsmtpa01-05.prod.sxb1.secureserver.net [188.121.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB43175BF
	for <linux-pm@vger.kernel.org>; Sun, 15 Sep 2024 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726421014; cv=none; b=Y48/HVyYgEDRtEu48KrvQ6vlJq1h+74z9r9BMO2LYusRg8ekkeeGgsMwL2+scOTgv/+GbIk+SVwD1iqqGxeLmYnfK1kDsj63tV/heIKSluIDOHxFxMAYGIk6F3X5NmOQqlt/k9VxknGVNN/vP7k7j7Bf2SXWYG4pgYJG6KSuBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726421014; c=relaxed/simple;
	bh=vD9P3RGWrlR1rbjW26aVavZcKLRZKYv2qFie7DlQksI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mFNMSKJOvJ0wLxCfjlCs3i1PPfx+H2J/nl8rwPS98RYnkj0AW4PaRJcZi4847i7a9ePgPSfT3hu+was6vHDBJBekt96UwJCoa07wUhbdF1iG6vudcQhwYuFlXlMaUtY7nNYjts10rvbpk8wixMrgwbZLD+/1KKdZ8MMVKz+5Ehc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net; spf=pass smtp.mailfrom=piie.net; arc=none smtp.client-ip=188.121.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=piie.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=piie.net
Received: from localhost ([109.90.180.58])
	by :SMTPAUTH: with ESMTPSA
	id psvoshzr6AYPppsvps7Os1; Sun, 15 Sep 2024 10:21:06 -0700
X-CMAE-Analysis: v=2.4 cv=UrSoNPwB c=1 sm=1 tr=0 ts=66e71783
 a=ujCVow8R4Y5jPCx6COW8WA==:117 a=ujCVow8R4Y5jPCx6COW8WA==:17
 a=IkcTkHD0fZMA:10 a=t3YNmgBSAAAA:8 a=aLrKE835u3E0sd5uawgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ctH_qozkpUrkr3SVbfwb:22
X-SECURESERVER-ACCT: peter@piie.net
From: Peter Kaestle <peter@piie.net>
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net,
	daniel.lezcano@linaro.org,
	linux-kernel@vger.kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	Peter Kaestle <peter@piie.net>
Subject: [PATCH 1/1] acerhdf: clean-up and remove interval parameter
Date: Sun, 15 Sep 2024 19:19:53 +0200
Message-ID: <20240915171953.163220-2-peter@piie.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240915171953.163220-1-peter@piie.net>
References: <20240915171953.163220-1-peter@piie.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfI/lf5KR3v0/w+2pdIFEMVD2As05QmTAuOPGBo0ZMaJqR84GJ9LGb2G4Z2Rjhpiv3pj6ISsLAJ6seaM24+hX6JLz3HPENNAd5OlWuqFCdMPM6hVTyN61
 7z5b9mYrTF7oBGYJIrO46sBTnm0dcRGoG+bpt3kX9jRaxie9wxwb9yPJBezlJzELmV1Nyc4Keyz2x+zJnU3eOPP4Mila5lwIzy+33UUJ7dvvQBPJBrR79b8f
 2vP5SdkoNnTkDbEjD867rUu0ZshF2w8my2oA2Pmhd7wqdzyZQdxf3IntkqUfKG02yBxYSiibnmB4+sBevjY50ko1hgYBvK+hOeEDvnGtZSL14mQQJD+841rY
 rdAQJCRuSvFUbE2EGP/gYvDXYW/WVg==

refactoring and cleaning up:
 * calling acerhdf_check_param() inside acerhdf_register_thermal()
   to ensure the trip points are setup according the values given
   for fanon/fanoff parameters when doing modprobe.
 * remove dynamical kernelmode handling, as users anyhow enable
   kernelmode already at insmod / modprobe and it simplifies the
   code and testing a lot.
 * beautify return code handling in acerhdf_register_thermal().
 * removal of interval parameter as the thermal layer is handling
   it differently now and the original intention of lowering the
   temperature polling frequency does not work the same anymore.

Signed-off-by: Peter Kästle <peter@piie.net>
---
 drivers/platform/x86/acerhdf.c | 95 +++++-----------------------------
 1 file changed, 12 insertions(+), 83 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 018c48429616..e3e9c2cb73a7 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -4,7 +4,7 @@
  *           of the aspire one netbook, turns on/off the fan
  *           as soon as the upper/lower threshold is reached.
  *
- * (C) 2009 - Peter Kaestle     peter (a) piie.net
+ * (C) 2024 - Peter Kaestle     peter (a) piie.net
  *                              https://piie.net
  *     2009 Borislav Petkov	bp (a) alien8.de
  *
@@ -37,7 +37,7 @@
  */
 #undef START_IN_KERNEL_MODE
 
-#define DRV_VER "0.7.0"
+#define DRV_VER "1.0.0"
 
 /*
  * According to the Atom N270 datasheet,
@@ -51,6 +51,7 @@
 #define ACERHDF_TEMP_CRIT 89000
 #define ACERHDF_FAN_OFF 0
 #define ACERHDF_FAN_AUTO 1
+#define ACERHDF_INTERVAL 1000
 
 /*
  * No matter what value the user puts into the fanon variable, turn on the fan
@@ -58,20 +59,12 @@
  */
 #define ACERHDF_MAX_FANON 80000
 
-/*
- * Maximum interval between two temperature checks is 15 seconds, as the die
- * can get hot really fast under heavy load (plus we shouldn't forget about
- * possible impact of _external_ aggressive sources such as heaters, sun etc.)
- */
-#define ACERHDF_MAX_INTERVAL 15
-
 #ifdef START_IN_KERNEL_MODE
 static int kernelmode = 1;
 #else
 static int kernelmode;
 #endif
 
-static unsigned int interval = 10;
 static unsigned int fanon = ACERHDF_DEFAULT_TEMP_FANON;
 static unsigned int fanoff = ACERHDF_DEFAULT_TEMP_FANOFF;
 static unsigned int verbose;
@@ -328,7 +321,7 @@ static void acerhdf_change_fanstate(int state)
 	}
 }
 
-static void acerhdf_check_param(struct thermal_zone_device *thermal)
+static void acerhdf_check_param(void)
 {
 	if (fanon > ACERHDF_MAX_FANON) {
 		pr_err("fanon temperature too high, set to %d\n",
@@ -344,24 +337,10 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
 
 	trips[0].temperature = fanon;
 	trips[0].hysteresis  = fanon - fanoff;
-
-	if (kernelmode) {
-		if (interval > ACERHDF_MAX_INTERVAL) {
-			pr_err("interval too high, set to %d\n",
-			       ACERHDF_MAX_INTERVAL);
-			interval = ACERHDF_MAX_INTERVAL;
-		}
-
-		if (verbose)
-			pr_notice("interval changed to: %d\n", interval);
-	}
 }
 
 /*
- * This is the thermal zone callback which does the delayed polling of the fan
- * state. We do check /sysfs-originating settings here in acerhdf_check_param()
- * as late as the polling interval is since we can't do that in the respective
- * accessors of the module parameters.
+ * Thermal zone callback used to poll the temperature
  */
 static int acerhdf_get_ec_temp(struct thermal_zone_device *thermal, int *t)
 {
@@ -410,33 +389,9 @@ static int acerhdf_unbind(struct thermal_zone_device *thermal,
 static inline void acerhdf_revert_to_bios_mode(void)
 {
 	acerhdf_change_fanstate(ACERHDF_FAN_AUTO);
-	kernelmode = 0;
 
 	pr_notice("kernel mode fan control OFF\n");
 }
-static inline void acerhdf_enable_kernelmode(void)
-{
-	kernelmode = 1;
-
-	pr_notice("kernel mode fan control ON\n");
-}
-
-/*
- * set operation mode;
- * enabled: the thermal layer of the kernel takes care about
- *          the temperature and the fan.
- * disabled: the BIOS takes control of the fan.
- */
-static int acerhdf_change_mode(struct thermal_zone_device *thermal,
-			       enum thermal_device_mode mode)
-{
-	if (mode == THERMAL_DEVICE_DISABLED && kernelmode)
-		acerhdf_revert_to_bios_mode();
-	else if (mode == THERMAL_DEVICE_ENABLED && !kernelmode)
-		acerhdf_enable_kernelmode();
-
-	return 0;
-}
 
 static int acerhdf_get_crit_temp(struct thermal_zone_device *thermal,
 				 int *temperature)
@@ -450,7 +405,6 @@ static struct thermal_zone_device_ops acerhdf_dev_ops = {
 	.bind = acerhdf_bind,
 	.unbind = acerhdf_unbind,
 	.get_temp = acerhdf_get_ec_temp,
-	.change_mode = acerhdf_change_mode,
 	.get_crit_temp = acerhdf_get_crit_temp,
 };
 
@@ -584,13 +538,11 @@ static int __init acerhdf_check_hardware(void)
 	if (force_bios[0]) {
 		version = force_bios;
 		pr_info("forcing BIOS version: %s\n", version);
-		kernelmode = 0;
 	}
 
 	if (force_product[0]) {
 		product = force_product;
 		pr_info("forcing BIOS product: %s\n", product);
-		kernelmode = 0;
 	}
 
 	if (verbose)
@@ -627,10 +579,8 @@ static int __init acerhdf_check_hardware(void)
 	 * if started with kernel mode off, prevent the kernel from switching
 	 * off the fan
 	 */
-	if (!kernelmode) {
-		pr_notice("Fan control off, to enable do:\n");
-		pr_notice("echo -n \"enabled\" > /sys/class/thermal/thermal_zoneN/mode # N=0,1,2...\n");
-	}
+	if (!kernelmode)
+		pr_notice("Fan control off, to enable insmod/modprobe with 'kernelmode=1'\n");
 
 	return 0;
 }
@@ -669,7 +619,7 @@ static void acerhdf_unregister_platform(void)
 
 static int __init acerhdf_register_thermal(void)
 {
-	int ret;
+	int ret = 0;
 
 	cl_dev = thermal_cooling_device_register("acerhdf-fan", NULL,
 						 &acerhdf_cooling_ops);
@@ -677,10 +627,12 @@ static int __init acerhdf_register_thermal(void)
 	if (IS_ERR(cl_dev))
 		return -EINVAL;
 
+	acerhdf_check_param();
+
 	thz_dev = thermal_zone_device_register_with_trips("acerhdf", trips, ARRAY_SIZE(trips),
 							  NULL, &acerhdf_dev_ops,
 							  &acerhdf_zone_params, 0,
-							  (kernelmode) ? interval*1000 : 0);
+							  ACERHDF_INTERVAL);
 	if (IS_ERR(thz_dev))
 		return -EINVAL;
 
@@ -688,10 +640,8 @@ static int __init acerhdf_register_thermal(void)
 		ret = thermal_zone_device_enable(thz_dev);
 	else
 		ret = thermal_zone_device_disable(thz_dev);
-	if (ret)
-		return ret;
 
-	return 0;
+	return ret;
 }
 
 static void acerhdf_unregister_thermal(void)
@@ -769,24 +719,3 @@ MODULE_ALIAS("dmi:*:*Acer*:pnExtensa*5420*:");
 
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
-
-static int interval_set_uint(const char *val, const struct kernel_param *kp)
-{
-	int ret;
-
-	ret = param_set_uint(val, kp);
-	if (ret)
-		return ret;
-
-	acerhdf_check_param(thz_dev);
-
-	return 0;
-}
-
-static const struct kernel_param_ops interval_ops = {
-	.set = interval_set_uint,
-	.get = param_get_uint,
-};
-
-module_param_cb(interval, &interval_ops, &interval, 0000);
-MODULE_PARM_DESC(interval, "Polling interval of temperature check");
-- 
2.46.1


