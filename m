Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22E376C3
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2019 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfFFObO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Jun 2019 10:31:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:49886 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727133AbfFFObO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 6 Jun 2019 10:31:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 537DCAFDB;
        Thu,  6 Jun 2019 14:31:12 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 5/7] clk: raspberrypi: register platform device for raspberrypi-cpufreq
Date:   Thu,  6 Jun 2019 16:22:58 +0200
Message-Id: <20190606142255.29454-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606142255.29454-1-nsaenzjulienne@suse.de>
References: <20190606142255.29454-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

As 'clk-raspberrypi' depends on RPi's firmware interface, which might be
configured as a module, the cpu clock might not be available for the
cpufreq driver during it's init process. So we register the
'raspberrypi-cpufreq' platform device after the probe sequence succeeds.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Eric Anholt <eric@anholt.net>
---
 drivers/clk/bcm/clk-raspberrypi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index b1365cf19f3a..052296b5fbe4 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -63,6 +63,8 @@ struct raspberrypi_firmware_prop {
 	__le32 disable_turbo;
 } __packed;
 
+static struct platform_device *rpi_cpufreq;
+
 static int raspberrypi_clock_property(struct rpi_firmware *firmware, u32 tag,
 				      u32 clk, u32 *val)
 {
@@ -285,6 +287,17 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	rpi_cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
+						    -1, NULL, 0);
+
+	return 0;
+}
+
+static int raspberrypi_clk_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(rpi_cpufreq);
+	rpi_cpufreq = NULL;
+
 	return 0;
 }
 
@@ -293,6 +306,7 @@ static struct platform_driver raspberrypi_clk_driver = {
 		.name = "raspberrypi-clk",
 	},
 	.probe          = raspberrypi_clk_probe,
+	.remove		= raspberrypi_clk_remove,
 };
 module_platform_driver(raspberrypi_clk_driver);
 
-- 
2.21.0

