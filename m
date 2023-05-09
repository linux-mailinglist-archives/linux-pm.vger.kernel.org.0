Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970A06FD148
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 23:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjEIVYk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 17:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbjEIVYJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 17:24:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58FF6A64;
        Tue,  9 May 2023 14:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 985066375D;
        Tue,  9 May 2023 21:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1498C433A4;
        Tue,  9 May 2023 21:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683667238;
        bh=3kq19NGPAGANm2mDx5FnD8IA4XA59hAw2umhEq1N1WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VJs9+DDr0kOEWAOQ4qOD4ZeJ7NbDEZs594JT6NYOx6s1JHHzPocIxpFY6ZsYp1tiU
         IwXRAvtm/U/4vtY0wsFvOO+VN44LTLJHo4Rnim3B2uuI+L0y50d9kIgSkPW89CBG7I
         +utnmva79T6Cb1bVO5qGVDJUiq2aCEooJ7MAHq5diJfiw0uXHpTIyJsPewPPkchN7F
         cr10fo1Pj1eq4eNNnASscp0rTrIzI75jaJ8vKrytEMw/LJHqwViyULbjhbZ8KA9rIp
         QcpLUIejMt4fOULwVuQWqLHZRevim/eU3Jjgf+IIMmMxKKN941jEnq+TxBGrXdJ+4E
         o1X8SEyqYt2mg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org, wens@csie.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 12/13] power: supply: axp288_charger: Use alt usb-id extcon on some x86 android tablets
Date:   Tue,  9 May 2023 17:20:20 -0400
Message-Id: <20230509212023.22105-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509212023.22105-1-sashal@kernel.org>
References: <20230509212023.22105-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ce38f3fc0f87a358a9560a3815265a94f1b38c37 ]

x86 ACPI boards which ship with only Android as their factory image may
have pretty broken ACPI tables. This includes broken _AEI ACPI GPIO event
handlers, which are normally used to listen to the micro-USB ID pin and:

1. Switch the USB-mux to the host / device USB controllers
2. Disable Vbus path before enabling the 5V boost (AXP reg 0x30 bit 7)
3. Turn 5V Vboost on / off

On non broken systems where this is not done through an ACPI GPIO event
handler, there is an ACPI INT3496 device describing the involved GPIOs
which are handled by the extcon-intel-int3496 driver; and axp288-charger.ko
listens to this extcon-device and disables the Vbus path when necessary.

On x86 Android boards, with broken ACPI GPIO event handlers, these are
disabled by acpi_quirk_skip_gpio_event_handlers() and an intel-int3496
extcon device is manually instantiated by x86-android-tablets.ko .

Add support to the axp288-charger code for this setup, so that it
properly disables the Vbus path when necessary. Note this uses
acpi_quirk_skip_gpio_event_handlers() to identify these systems,
to avoid the need to add a separate DMI match table for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/axp288_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 22378dad4d9fc..a52e01676fbcc 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -811,6 +811,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
 	struct power_supply_config charger_cfg = {};
+	const char *extcon_name = NULL;
 	unsigned int val;
 
 	/*
@@ -839,8 +840,18 @@ static int axp288_charger_probe(struct platform_device *pdev)
 		return PTR_ERR(info->cable.edev);
 	}
 
-	if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1)) {
-		info->otg.cable = extcon_get_extcon_dev(USB_HOST_EXTCON_NAME);
+	/*
+	 * On devices with broken ACPI GPIO event handlers there also is no ACPI
+	 * "INT3496" (USB_HOST_EXTCON_HID) device. x86-android-tablets.ko
+	 * instantiates an "intel-int3496" extcon on these devs as a workaround.
+	 */
+	if (acpi_quirk_skip_gpio_event_handlers())
+		extcon_name = "intel-int3496";
+	else if (acpi_dev_present(USB_HOST_EXTCON_HID, NULL, -1))
+		extcon_name = USB_HOST_EXTCON_NAME;
+
+	if (extcon_name) {
+		info->otg.cable = extcon_get_extcon_dev(extcon_name);
 		if (IS_ERR(info->otg.cable)) {
 			dev_err_probe(dev, PTR_ERR(info->otg.cable),
 				      "extcon_get_extcon_dev(%s) failed\n",
-- 
2.39.2

