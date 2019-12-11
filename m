Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 083F811BDE5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 21:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfLKUcE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 15:32:04 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37527 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfLKUcD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 15:32:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so41167plz.4;
        Wed, 11 Dec 2019 12:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=afURWFdN1dU/KLmm8O/X/Jsvd7WfBwUp3PbxBXxbEO8=;
        b=WQFmipXruI1fTRuJSFGA+UtCvg+t0311Lztvvzz25V1GaOT4jVXqbMxAyysv9OySUw
         +9/7WI7+1RxSFI33RYHQoPAqQh5XAaPGfMu3YtTBLXVGRu7k8WQ4COQ06ahaIoVgih8/
         vz/1vVaDWE/4sgwwZZfbXOoBD1eYiG15pgQJzhG29xp3jbQrfrj86j8okGfVlpyuayaf
         DfGm7gN6BOebb9VuiwqOzjDCIb1TUmsUkLZZReSofeOeD7z7UVyI+mNOj9fXp9rO2wz/
         jwkW1lQx5uNhpKixZxW499CvK54iXIorUAuS2+PaBbNf4yB3J28mq3eVxcJIBlUN+HHu
         butA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=afURWFdN1dU/KLmm8O/X/Jsvd7WfBwUp3PbxBXxbEO8=;
        b=AtSg19HVcrE3XZj7a4sTaFttsV4/kBbzVX6UUp4pOyuy1k3SghLrmBnBwoXDtzxrP4
         IYFj5Lqw1e4wVRC954xPoZsGiIhOVOG9idjxT13CwA8slnldqiuN4Q2LgXAKxN+lBPuK
         hJVRt+l1P+btQhxhhUEXMeC6VMa8HTPnUgPw0uUzPltt4AwRIr9og08uU2nU0/p/zjeL
         8978U2szPp/2s6jM4OQeYOyLfnx6JXJXOtzr9Rqd29IgjLImzVBuMO27Bh19Vl7k8fhx
         rGPCkoq28FELa4OXqHCWHD3pBKbXiiFeAA7nTOyaP7GBmXI6yS/5SRODmHlJMo74GHIT
         KcwA==
X-Gm-Message-State: APjAAAXiMCTarb2mdMMmqXi+smJN+fHewBj/Vxa7uebeB61IHZENIyLm
        zn/KhGywLjElSwCPVkIMCBk=
X-Google-Smtp-Source: APXvYqxGSB+7FmWepthU7M3pDNil4kYRJ30rzs2NUAnzV5QbV9rl9uHOAx0+aLP5WZBmSwJeGCpilA==
X-Received: by 2002:a17:90a:b301:: with SMTP id d1mr5568198pjr.20.1576096322353;
        Wed, 11 Dec 2019 12:32:02 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19sm917570pju.11.2019.12.11.12.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 12:32:01 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 5/6] thermal: brcmstb_thermal: Restructure interrupt registration
Date:   Wed, 11 Dec 2019 12:31:42 -0800
Message-Id: <20191211203143.2952-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191211203143.2952-1-f.fainelli@gmail.com>
References: <20191211203143.2952-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If we are successful grabbing the interrupt resource, then register an
interrupt handler, this makes it easier to support the interrupt as
being optional, which is it for 7216.

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 74d94f01b1b9..47b622f33900 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -348,16 +348,15 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	priv->thermal = thermal;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get IRQ\n");
-		return irq;
-	}
-	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					brcmstb_tmon_irq_thread, IRQF_ONESHOT,
-					DRV_NAME, priv);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
-		return ret;
+	if (irq >= 0) {
+		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
+						brcmstb_tmon_irq_thread,
+						IRQF_ONESHOT,
+						DRV_NAME, priv);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "could not request IRQ: %d\n", ret);
+			return ret;
+		}
 	}
 
 	dev_info(&pdev->dev, "registered AVS TMON of-sensor driver\n");
-- 
2.17.1

