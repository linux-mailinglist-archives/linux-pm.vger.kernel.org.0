Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1D0C876A
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 13:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfJBLgJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 07:36:09 -0400
Received: from hermes.aosc.io ([199.195.250.187]:42753 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbfJBLgJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 07:36:09 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Oct 2019 07:36:09 EDT
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id DE8DE82D37;
        Wed,  2 Oct 2019 11:26:45 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 1/2] power: supply: axp20x_usb_power: enable USB BC detection on AXP813
Date:   Wed,  2 Oct 2019 19:25:44 +0800
Message-Id: <20191002112545.58481-2-icenowy@aosc.io>
In-Reply-To: <20191002112545.58481-1-icenowy@aosc.io>
References: <20191002112545.58481-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The AXP813 PMIC has support for detection of USB Battery Charging
specification, and it will limit the current to 500mA by default when
the detection is not enabled or the detection result is SDP.

Enable the BC detection to allow correctly selection of the current.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/power/supply/axp20x_usb_power.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index dc4c316eff81..5f0a5722b19e 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -48,6 +48,8 @@
 
 #define AXP20X_VBUS_MON_VBUS_VALID	BIT(3)
 
+#define AXP813_BC_EN		BIT(0)
+
 /*
  * Note do not raise the debounce time, we must report Vusb high within
  * 100ms otherwise we get Vbus errors in musb.
@@ -495,6 +497,12 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (power->axp20x_id == AXP813_ID) {
+		/* Enable USB Battery Charging specification detection */
+		regmap_update_bits(axp20x->regmap, AXP288_BC_GLOBAL,
+				   AXP813_BC_EN, AXP813_BC_EN);
+	}
+
 	psy_cfg.of_node = pdev->dev.of_node;
 	psy_cfg.drv_data = power;
 
-- 
2.21.0

