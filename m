Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751525A3F75
	for <lists+linux-pm@lfdr.de>; Sun, 28 Aug 2022 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiH1TaP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Aug 2022 15:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiH1TaM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Aug 2022 15:30:12 -0400
Received: from vorpal.se (vorpal.se [151.236.221.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419BD18B29;
        Sun, 28 Aug 2022 12:30:02 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id ADE8A147F2;
        Sun, 28 Aug 2022 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1661715001; bh=FaOvQr79TG5ATDewzu8RG5QTZhCequRtKc7TeqIozvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mom5Ku7OfM4U4pC/QzCjT5ML1nHgQfgbV+cHgNB4CGdggPp6NtqoMhGD1Tb9SKvQO
         9uMAx3X1MsuTGeyx/0pPQJxDZ7ZfmMG/jwIHfh4InEuRZcWIRmlsu7LiSa1fBxR/Gl
         DziGfluUdZph5YJcuwCBGpsI0XGEPK+6FVYaCgPN919nwko+eH5M3Bm/K7bvh5kJU0
         b2nXRMW3zhKTnn8Bmdu6gFj0yqCvCa8mFa7f+tiAajFvxgIY/pGXFBmEwPQcSXHtTV
         FK9jMfY4hG1VqurrkcP5UVYoPqssoJNICDjvuz5sx8Dx4IseU5vmBQ2PquCtd2jl1J
         AA8NXkDjr8fNg==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH 1/3] platform/x86: Battery charge mode in toshiba_acpi (internals)
Date:   Sun, 28 Aug 2022 21:29:18 +0200
Message-Id: <20220828192920.805253-2-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220828192920.805253-1-lkml@vorpal.se>
References: <20220828192920.805253-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This commit adds the internal functions to control the Toshiba laptop.

Unlike for example ThinkPads where this control is granular here it is
just off/on. When off it charges to 100%. When on it charges to about 80%.

Controlling this setting is done via HCI register 0x00ba. Setting to value
1 will result in limiting the charing to 80% of the battery capacity,
while setting it to 0 will allow charging to 100%.

Reading the current state is a bit weird, and needs a 1 set in the last
position of the query for whatever reason. In addition, the read may
return 0x8d20 (Data not available) rarely, so a retry mechanism is needed.

According to the Windows program used to control the feature the setting
will not take effect until the battery has been discharged to around 50%.
However, in my testing it takes effect as soon as the charge drops below
80%. On Windows Toshiba branded this feature as "Eco charging".

Signed-off-by: Arvid Norlander <lkml@vorpal.se>
---
 drivers/platform/x86/toshiba_acpi.c | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index 0fc9e8b8827b..c927d5d0f8cd 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -112,6 +112,7 @@ MODULE_LICENSE("GPL");
 #define HCI_KBD_ILLUMINATION		0x0095
 #define HCI_ECO_MODE			0x0097
 #define HCI_ACCELEROMETER2		0x00a6
+#define HCI_BATTERY_CHARGE_MODE		0x00ba
 #define HCI_SYSTEM_INFO			0xc000
 #define SCI_PANEL_POWER_ON		0x010d
 #define SCI_ILLUMINATION		0x014e
@@ -201,6 +202,7 @@ struct toshiba_acpi_dev {
 	unsigned int usb_three_supported:1;
 	unsigned int wwan_supported:1;
 	unsigned int cooling_method_supported:1;
+	unsigned int battery_charge_mode_supported:1;
 	unsigned int sysfs_created:1;
 	unsigned int special_functions;
 
@@ -1282,6 +1284,69 @@ static int toshiba_cooling_method_set(struct toshiba_acpi_dev *dev, u32 state)
 	return (result == TOS_SUCCESS || result == TOS_SUCCESS2) ? 0 : -EIO;
 }
 
+/* Battery charge control */
+static void toshiba_battery_charge_mode_available(struct toshiba_acpi_dev *dev)
+{
+	u32 in[TCI_WORDS] = { HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 0 };
+	u32 out[TCI_WORDS];
+	acpi_status status;
+
+	dev->battery_charge_mode_supported = 0;
+
+	status = tci_raw(dev, in, out);
+	if (ACPI_FAILURE(status)) {
+		pr_err("ACPI call to get Battery Charge Mode failed\n");
+		return;
+	}
+
+	if (out[0] != TOS_SUCCESS && out[0] != TOS_SUCCESS2)
+		return;
+
+	dev->battery_charge_mode_supported = 1;
+}
+
+static int toshiba_battery_charge_mode_get(struct toshiba_acpi_dev *dev, u32 *state)
+{
+	u32 in[TCI_WORDS] = { HCI_GET, HCI_BATTERY_CHARGE_MODE, 0, 0, 0, 0x1 };
+	u32 out[TCI_WORDS];
+	int retries = 3;
+
+	do {
+		acpi_status status = tci_raw(dev, in, out);
+
+		if (ACPI_FAILURE(status))
+			pr_err("ACPI call to get Battery Charge Mode failed\n");
+		switch (out[0]) {
+		case TOS_SUCCESS:
+		case TOS_SUCCESS2:
+			*state = out[2];
+			return 0;
+		case TOS_NOT_SUPPORTED:
+			return -ENODEV;
+		case TOS_DATA_NOT_AVAILABLE:
+			retries--;
+			break;
+		default:
+			return -EIO;
+		}
+	} while (retries);
+
+	return -EIO;
+}
+
+static int toshiba_battery_charge_mode_set(struct toshiba_acpi_dev *dev, u32 state)
+{
+	u32 result = hci_write(dev, HCI_BATTERY_CHARGE_MODE, state);
+
+	if (result == TOS_FAILURE)
+		pr_err("ACPI call to set Battery Charge Mode failed\n");
+
+	if (result == TOS_NOT_SUPPORTED)
+		return -ENODEV;
+
+	return (result == TOS_SUCCESS || result == TOS_SUCCESS2) ? 0 : -EIO;
+}
+
 /* Transflective Backlight */
 static int get_tr_backlight_status(struct toshiba_acpi_dev *dev, u32 *status)
 {
@@ -2956,6 +3021,8 @@ static void print_supported_features(struct toshiba_acpi_dev *dev)
 		pr_cont(" wwan");
 	if (dev->cooling_method_supported)
 		pr_cont(" cooling-method");
+	if (dev->battery_charge_mode_supported)
+		pr_cont(" battery-charge-mode");
 
 	pr_cont("\n");
 }
@@ -3163,6 +3230,8 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 
 	toshiba_cooling_method_available(dev);
 
+	toshiba_battery_charge_mode_available(dev);
+
 	print_supported_features(dev);
 
 	ret = sysfs_create_group(&dev->acpi_dev->dev.kobj,
-- 
2.37.2

