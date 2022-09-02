Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA325AB7E1
	for <lists+linux-pm@lfdr.de>; Fri,  2 Sep 2022 20:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236098AbiIBSAv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 2 Sep 2022 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiIBSAt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 2 Sep 2022 14:00:49 -0400
Received: from vorpal.se (vorpal.se [IPv6:2a01:7e00::f03c:91ff:fe73:398e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ED2E3408;
        Fri,  2 Sep 2022 11:00:48 -0700 (PDT)
Received: by vorpal.se (Postfix) with ESMTPSA id C2577147F2;
        Fri,  2 Sep 2022 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vorpal.se; s=2019;
        t=1662141647; bh=F3WrPzFr5RHWdLaHfaNc3+319/6twJSoBEWMGZH1cws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dpoyJO/pYllpBU8P3NkzpKJrMNzm+fn0ntNe3Q6EfaIuOb83O9UqtBzcdVqWJXD/k
         YFgNXUQCui9zsQfXv6Bg72IW/2pv1CczhgtyVjOXb534+n4ZVA+lQs7zl1TE+9Wt89
         C9Lv4jYEwGkCmFL6e2t9wvNKmc+Foq1dMyc5cy0LgHxsKWIdxQ9ortTnnSdWbUy+3A
         jV2GwCP0bIYMaXWmQjUrQLYFDTYPAvZvZWOL2dgn402rwi+dDIJvU+TLobKZ0w3mda
         zueoXTZrokpT0HJWVQXBtA+zJDltiib1YTwP5+ViWVfz3sGexZIM0VX551OWdmix3G
         gQf86o+SZN5UA==
From:   Arvid Norlander <lkml@vorpal.se>
To:     platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Arvid Norlander <lkml@vorpal.se>
Subject: [PATCH 1/3] platform/x86: Battery charge mode in toshiba_acpi (internals)
Date:   Fri,  2 Sep 2022 20:00:35 +0200
Message-Id: <20220902180037.1728546-2-lkml@vorpal.se>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902180037.1728546-1-lkml@vorpal.se>
References: <20220902180037.1728546-1-lkml@vorpal.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,RCVD_IN_XBL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
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
2.37.3

