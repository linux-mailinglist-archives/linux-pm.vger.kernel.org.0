Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB213B2A8
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 20:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgANTGn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 14:06:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44985 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgANTG3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 14:06:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id 62so382381pfu.11;
        Tue, 14 Jan 2020 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4vSJnMnRQY5K8VIAp/CMpFrjM8LQtV7YQuTT5kLVa2Q=;
        b=b1oRWQ+ofqnyI9P+5iPLK8xjCoJZqwsNkEhaJlpnvxZb+H/Q+SE4o8hARWqr6XiIYX
         ip7DfS9hlMSocjKd8dd02V+XeGog6u8mDa4sJH6+/wlbZrLaYIy1hPaTiz0mZjP+PPTS
         QAsPrC4tcJzFiURmrG9Qp55ycpqJfuSfa4q342neqf72FaJeb4YvFPyxZ3szZppoLjNA
         oGjp1RysfqC5G4aJZiDgRwJ7uws+3jQhNNXa6WQcvu4NTfI9hZTHi9UwIuLjGeCLMEiO
         V7ytPmFE3PF7HATjoX7+Jd8kgl5lfjr7hstsADOOdZ/d9c7obW2YjcE0asOP6EEtV3hB
         C84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4vSJnMnRQY5K8VIAp/CMpFrjM8LQtV7YQuTT5kLVa2Q=;
        b=ebVd1wEA6gAqj093wb+uEutqes4PjFdIhg78ZrVe6wJSU0P7GwELam6CyRRAnv2V2R
         OD5MJMdSmJrlRmLKKiBEWpQgkdj6xwXNUTJWKrshltdoSE0QLF+Et59r5hoZbyxhm2qA
         QEFFJuRNnBdR1xxQaO04+5VVITqg2Q6e48Jgm6lKmJ2l/+M2JtCQawG5WYm2QfQHJKVo
         0LM84XuQZKdJNSTpbpw1pSL8+2Bdhkv2xRqkFra7I2gie1O1JWjzqaEsRfayAyflq2MP
         0kK1+SSckADOliXPSFwIS7WqriRgl18p6qY7dbQWzAjfP/U7kX8uNlr1rGw9K9wfZNDQ
         Muaw==
X-Gm-Message-State: APjAAAW/rKG3Q5Lr4PI9WJqnn7OTfx2ibQoWvhdRZUXJD0P4XXQxFjXc
        l5FINgdKJ8Naxw1FpQ+LvwMxSmnZ
X-Google-Smtp-Source: APXvYqxs2+XlUU2WqQPZYVIaJ6IXhF2aeaBA+8K/Ho1GQddwh7hY3UO+5LROxkyrOAxroGfhjjTbSw==
X-Received: by 2002:a63:f901:: with SMTP id h1mr28558196pgi.445.1579028788518;
        Tue, 14 Jan 2020 11:06:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a195sm19284528pfa.120.2020.01.14.11.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:06:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH v3 5/6] thermal: brcmstb_thermal: Restructure interrupt registration
Date:   Tue, 14 Jan 2020 11:06:06 -0800
Message-Id: <20200114190607.29339-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114190607.29339-1-f.fainelli@gmail.com>
References: <20200114190607.29339-1-f.fainelli@gmail.com>
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
index 4b328586959f..6ded4b9c53be 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -343,16 +343,15 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
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

