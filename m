Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5454042E98
	for <lists+linux-pm@lfdr.de>; Wed, 12 Jun 2019 20:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbfFLSZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Jun 2019 14:25:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:35416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727249AbfFLSZW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Jun 2019 14:25:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E0C22AFFA;
        Wed, 12 Jun 2019 18:25:20 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, linux-kernel@vger.kernel.org
Cc:     mbrugger@suse.de, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        sboyd@kernel.org, eric@anholt.net, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, ptesarik@suse.com,
        linux-rpi-kernel@lists.infradead.org, ssuloev@orpaltech.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mturquette@baylibre.com, linux-pm@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 5/7] clk: raspberrypi: register platform device for raspberrypi-cpufreq
Date:   Wed, 12 Jun 2019 20:24:57 +0200
Message-Id: <20190612182500.4097-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612182500.4097-1-nsaenzjulienne@suse.de>
References: <20190612182500.4097-1-nsaenzjulienne@suse.de>
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

Changes since v2:
  - Use raspberrypi_clk struct to store cpufreq platform_device

 drivers/clk/bcm/clk-raspberrypi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index fef1f7caee4f..1654fd0eedc9 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -34,6 +34,7 @@
 struct raspberrypi_clk {
 	struct device *dev;
 	struct rpi_firmware *firmware;
+	struct platform_device *cpufreq;
 
 	unsigned long min_rate;
 	unsigned long max_rate;
@@ -272,6 +273,7 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 
 	rpi->dev = dev;
 	rpi->firmware = firmware;
+	platform_set_drvdata(pdev, rpi);
 
 	ret = raspberrypi_register_pllb(rpi);
 	if (ret) {
@@ -283,6 +285,18 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	rpi->cpufreq = platform_device_register_data(dev, "raspberrypi-cpufreq",
+						     -1, NULL, 0);
+
+	return 0;
+}
+
+static int raspberrypi_clk_remove(struct platform_device *pdev)
+{
+	struct raspberrypi_clk *rpi = platform_get_drvdata(pdev);
+
+	platform_device_unregister(rpi->cpufreq);
+
 	return 0;
 }
 
@@ -291,6 +305,7 @@ static struct platform_driver raspberrypi_clk_driver = {
 		.name = "raspberrypi-clk",
 	},
 	.probe          = raspberrypi_clk_probe,
+	.remove		= raspberrypi_clk_remove,
 };
 module_platform_driver(raspberrypi_clk_driver);
 
-- 
2.21.0

