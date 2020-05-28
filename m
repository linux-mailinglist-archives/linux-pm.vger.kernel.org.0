Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1151E6955
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 20:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405836AbgE1Saj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 14:30:39 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:60396 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405803AbgE1Sai (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 14:30:38 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 67F1730D922;
        Thu, 28 May 2020 11:20:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 67F1730D922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590690022;
        bh=xTLN0Ne8/Unwvxj7vRuoFM8k4HSoC2gvxWr7h+2Ueic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CE98I9F+YpFVK5YhkoZsPrHDWVftEaJJvhZrl8D8zUkEmwKeBjEyTaat+gultQOOA
         vfDwwRUcIdQ7Q9J5Q2yMHxtHH2DRTt03GpitZRG+UmzbmFo8JZB13wQaaUdMOKMTyZ
         pMFG8jLc/dUk80lQ83Edj3h/xEJDNggoLNUN652E=
Received: from lbrmn-mmayer.ric.broadcom.net (lbrmn-mmayer.ric.broadcom.net [10.136.28.150])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id F2492140069;
        Thu, 28 May 2020 11:20:21 -0700 (PDT)
From:   Markus Mayer <markus.mayer@broadcom.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Power Management List <linux-pm@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Markus Mayer <markus.mayer@broadcom.com>
Subject: [PATCH 2/3] cpufreq: brcmstb-avs-cpufreq: Support polling AVS firmware
Date:   Thu, 28 May 2020 11:20:13 -0700
Message-Id: <20200528182014.20021-2-mmayer@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528182014.20021-1-mmayer@broadcom.com>
References: <20200528182014.20021-1-mmayer@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

In case the interrupt towards the host is never raised, yet the AVS
firmware responds correctly within the alloted time, allow supporting a
polling mode.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 47 +++++++++++++++++++--------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index c8b754694a5e..79a0538a531a 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -42,6 +42,7 @@
  */
 
 #include <linux/cpufreq.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -178,6 +179,7 @@ struct private_data {
 	struct completion done;
 	struct semaphore sem;
 	struct pmap pmap;
+	int host_irq;
 };
 
 static void __iomem *__map_region(const char *name)
@@ -195,12 +197,36 @@ static void __iomem *__map_region(const char *name)
 	return ptr;
 }
 
+static unsigned long wait_for_avs_command(struct private_data *priv,
+					  unsigned long timeout)
+{
+	unsigned long time_left = 0;
+	u32 val;
+
+	/* Event driven, wait for the command interrupt */
+	if (priv->host_irq >= 0)
+		return wait_for_completion_timeout(&priv->done,
+						   msecs_to_jiffies(timeout));
+
+	/* Polling for command completion */
+	do {
+		time_left = timeout;
+		val = readl(priv->base + AVS_MBOX_STATUS);
+		if (val)
+			break;
+
+		usleep_range(1000, 2000);
+	} while (--timeout);
+
+	return time_left;
+}
+
 static int __issue_avs_command(struct private_data *priv, unsigned int cmd,
 			       unsigned int num_in, unsigned int num_out,
 			       u32 args[])
 {
-	unsigned long time_left = msecs_to_jiffies(AVS_TIMEOUT);
 	void __iomem *base = priv->base;
+	unsigned long time_left;
 	unsigned int i;
 	int ret;
 	u32 val;
@@ -238,7 +264,7 @@ static int __issue_avs_command(struct private_data *priv, unsigned int cmd,
 	writel(AVS_CPU_L2_INT_MASK, priv->avs_intr_base + AVS_CPU_L2_SET0);
 
 	/* Wait for AVS co-processor to finish processing the command. */
-	time_left = wait_for_completion_timeout(&priv->done, time_left);
+	time_left = wait_for_avs_command(priv, AVS_TIMEOUT);
 
 	/*
 	 * If the AVS status is not in the expected range, it means AVS didn't
@@ -509,7 +535,7 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 {
 	struct private_data *priv;
 	struct device *dev;
-	int host_irq, ret;
+	int ret;
 
 	dev = &pdev->dev;
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -536,19 +562,14 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 		goto unmap_base;
 	}
 
-	host_irq = platform_get_irq_byname(pdev, BRCM_AVS_HOST_INTR);
-	if (host_irq < 0) {
-		dev_err(dev, "Couldn't find interrupt %s -- %d\n",
-			BRCM_AVS_HOST_INTR, host_irq);
-		ret = host_irq;
-		goto unmap_intr_base;
-	}
+	priv->host_irq = platform_get_irq_byname(pdev, BRCM_AVS_HOST_INTR);
 
-	ret = devm_request_irq(dev, host_irq, irq_handler, IRQF_TRIGGER_RISING,
+	ret = devm_request_irq(dev, priv->host_irq, irq_handler,
+			       IRQF_TRIGGER_RISING,
 			       BRCM_AVS_HOST_INTR, priv);
-	if (ret) {
+	if (ret && priv->host_irq >= 0) {
 		dev_err(dev, "IRQ request failed: %s (%d) -- %d\n",
-			BRCM_AVS_HOST_INTR, host_irq, ret);
+			BRCM_AVS_HOST_INTR, priv->host_irq, ret);
 		goto unmap_intr_base;
 	}
 
-- 
2.17.1

