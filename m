Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B42376AA
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 16:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfFFO2T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 10:28:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:49340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbfFFO2T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 10:28:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87E17AFD1;
        Thu,  6 Jun 2019 14:28:17 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 3/7] firmware: raspberrypi: register clk device
Date:   Thu,  6 Jun 2019 16:22:54 +0200
Message-Id: <20190606142255.29454-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606142255.29454-1-nsaenzjulienne@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since clk-raspberrypi is tied to the VC4 firmware instead of particular
hardware it's registration should be performed by the firmware driver.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Eric Anholt <eric@anholt.net>
---
 drivers/firmware/raspberrypi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 61be15d9df7d..da26a584dca0 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -20,6 +20,7 @@
 #define MBOX_CHAN_PROPERTY		8
 
 static struct platform_device *rpi_hwmon;
+static struct platform_device *rpi_clk;
 
 struct rpi_firmware {
 	struct mbox_client cl;
@@ -207,6 +208,12 @@ rpi_register_hwmon_driver(struct device *dev, struct rpi_firmware *fw)
 						  -1, NULL, 0);
 }
 
+static void rpi_register_clk_driver(struct device *dev)
+{
+	rpi_clk = platform_device_register_data(dev, "raspberrypi-clk",
+						-1, NULL, 0);
+}
+
 static int rpi_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -234,6 +241,7 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 
 	rpi_firmware_print_firmware_revision(fw);
 	rpi_register_hwmon_driver(dev, fw);
+	rpi_register_clk_driver(dev);
 
 	return 0;
 }
@@ -254,6 +262,8 @@ static int rpi_firmware_remove(struct platform_device *pdev)
 
 	platform_device_unregister(rpi_hwmon);
 	rpi_hwmon = NULL;
+	platform_device_unregister(rpi_clk);
+	rpi_clk = NULL;
 	mbox_free_channel(fw->chan);
 
 	return 0;
-- 
2.21.0

