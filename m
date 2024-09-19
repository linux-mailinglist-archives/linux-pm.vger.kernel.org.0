Return-Path: <linux-pm+bounces-14479-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A097CCFB
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 19:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE1E1C22270
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6110F1A0B1E;
	Thu, 19 Sep 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="UN2i3Kn8"
X-Original-To: linux-pm@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0145191F74;
	Thu, 19 Sep 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726766432; cv=none; b=kVhwQs4E8zxNWpv5MkzrDcEYD+o4eeRUPWbRbQ5xP3Pd27KB8uBvui+MlfeRcI32sZGGsp7BVEs0inJ2VXKvJN1ng8nhK6hlrKtQSR1kN+p39r4xEjGN1aJObhLyqJL/lhPDXzsNdRXCbqRiprdBjXuONl7rbTUVup11jpWzaCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726766432; c=relaxed/simple;
	bh=WDe/894nXLWPbl0OsXmviqdGw3HVdOZGv8ikt38PbBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfvRvxy7EOjb4SXScroxtW4xxsSurAQMgZoPYRNllYdycDW7rM07k5RSWq9h4IDvC4lFO4PRE/6+o7OfwRnZWmzOEiXty7Nea/akyxblTNjcIvzzaIWvgpUHjq5kut4hDezJeG7rmtAp38IsLUWaz12FWIPFehKJUj/ChzbkJeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=UN2i3Kn8; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:6813:1156:549c:fa23])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 6FBE02E09C21;
	Thu, 19 Sep 2024 20:20:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1726766426;
	bh=2A2rAgoAhMY4S+LBirNVsSlPtMJXO/HWDrAVx+jjdvk=; h=From:To:Subject;
	b=UN2i3Kn8osXzxkLZtU9dix+u0qv86XsVcVqUeFyGwtjoN1jyR1xY6DbVc3l0RYQSI
	 IiokavFx03JkiliepM1qFMYpWBEzZbYiNttVchqJZfrhPqARu5TwuwlG9Le4NrBAM9
	 SA15pPVgdUss5UVv6LxqCy1DNXR90g6U1NGFv7l0=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:6813:1156:549c:fa23) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: linux-pm@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	Mario.Limonciello@amd.com,
	luke@ljones.dev,
	me@kylegospodneti.ch
Subject: [PATCH v1 4/4] platform/x86: asus-wmi: remove Ally (1st gen) and Ally
 X suspend quirk
Date: Thu, 19 Sep 2024 19:19:52 +0200
Message-ID: <20240919171952.403745-5-lkml@antheas.dev>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919171952.403745-1-lkml@antheas.dev>
References: <20240919171952.403745-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <172676642625.27078.12809531855910783380@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

By moving the Display On/Off calls outside of the suspend sequence,
the racing conditions that made the Ally controller suspend unreliable
are completely fixed. This includes both when mcu_powersave is enabled
and disabled. Therefore, remove the quirk that fixes them only when
mcu_powersave is disabled.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/asus-wmi.c | 54 ---------------------------------
 1 file changed, 54 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 37636e5a38e3..2c9656e0afda 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -137,29 +137,10 @@ module_param(fnlock_default, bool, 0444);
 #define ASUS_MINI_LED_2024_STRONG	0x01
 #define ASUS_MINI_LED_2024_OFF		0x02
 
-/* Controls the power state of the USB0 hub on ROG Ally which input is on */
-#define ASUS_USB0_PWR_EC0_CSEE "\\_SB.PCI0.SBRG.EC0.CSEE"
-/* 300ms so far seems to produce a reliable result on AC and battery */
-#define ASUS_USB0_PWR_EC0_CSEE_WAIT 1500
-
 static const char * const ashs_ids[] = { "ATK4001", "ATK4002", NULL };
 
 static int throttle_thermal_policy_write(struct asus_wmi *);
 
-static const struct dmi_system_id asus_ally_mcu_quirk[] = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "RC72L"),
-		},
-	},
-	{ },
-};
-
 static bool ashs_present(void)
 {
 	int i = 0;
@@ -269,9 +250,6 @@ struct asus_wmi {
 	u32 tablet_switch_dev_id;
 	bool tablet_switch_inverted;
 
-	/* The ROG Ally device requires the MCU USB device be disconnected before suspend */
-	bool ally_mcu_usb_switch;
-
 	enum fan_type fan_type;
 	enum fan_type gpu_fan_type;
 	enum fan_type mid_fan_type;
@@ -4698,8 +4676,6 @@ static int asus_wmi_add(struct platform_device *pdev)
 	asus->egpu_enable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_EGPU);
 	asus->dgpu_disable_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_DGPU);
 	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
-	asus->ally_mcu_usb_switch = acpi_has_method(NULL, ASUS_USB0_PWR_EC0_CSEE)
-						&& dmi_check_system(asus_ally_mcu_quirk);
 
 	if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE))
 		asus->mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
@@ -4892,34 +4868,6 @@ static int asus_hotk_resume(struct device *device)
 	return 0;
 }
 
-static int asus_hotk_resume_early(struct device *device)
-{
-	struct asus_wmi *asus = dev_get_drvdata(device);
-
-	if (asus->ally_mcu_usb_switch) {
-		/* sleep required to prevent USB0 being yanked then reappearing rapidly */
-		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB8)))
-			dev_err(device, "ROG Ally MCU failed to connect USB dev\n");
-		else
-			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
-	}
-	return 0;
-}
-
-static int asus_hotk_prepare(struct device *device)
-{
-	struct asus_wmi *asus = dev_get_drvdata(device);
-
-	if (asus->ally_mcu_usb_switch) {
-		/* sleep required to ensure USB0 is disabled before sleep continues */
-		if (ACPI_FAILURE(acpi_execute_simple_method(NULL, ASUS_USB0_PWR_EC0_CSEE, 0xB7)))
-			dev_err(device, "ROG Ally MCU failed to disconnect USB dev\n");
-		else
-			msleep(ASUS_USB0_PWR_EC0_CSEE_WAIT);
-	}
-	return 0;
-}
-
 static int asus_hotk_restore(struct device *device)
 {
 	struct asus_wmi *asus = dev_get_drvdata(device);
@@ -4964,8 +4912,6 @@ static const struct dev_pm_ops asus_pm_ops = {
 	.thaw = asus_hotk_thaw,
 	.restore = asus_hotk_restore,
 	.resume = asus_hotk_resume,
-	.resume_early = asus_hotk_resume_early,
-	.prepare = asus_hotk_prepare,
 };
 
 /* Registration ***************************************************************/
-- 
2.46.1


