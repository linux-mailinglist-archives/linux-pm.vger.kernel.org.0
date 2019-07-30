Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABD997B18F
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 20:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbfG3SQf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 30 Jul 2019 14:16:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39615 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388067AbfG3SQe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jul 2019 14:16:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so30477070pgi.6
        for <linux-pm@vger.kernel.org>; Tue, 30 Jul 2019 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eK4LqccbexBbFwqN6Jv75UZiA5HD108HkeIAaMcaoSk=;
        b=EeipzuZUgBBHDP2m+SB0YDxqn3NNwmT9E+BBw37WtV1keN0d+FirRsAehrjHIIdrRu
         sTo+j3ADlw6xCRXXqiUe7x+YdqidUOQTLwQdf//CvX7cvcvu+MigUapFC3Fb+GikoW9V
         7xpLH4IkurfaDjtVNMPl0YG4lXWTXlMLMsN0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eK4LqccbexBbFwqN6Jv75UZiA5HD108HkeIAaMcaoSk=;
        b=M6hHNFvQL+gqVfdIiKuVN06prqFcHailUniMrHT8oi6CyNpJ+K0/Ku+XKsgmRcoaqH
         Lqx2t3NLazsKpo8lKPSGbRJGTf6bXa0ScQgISNnP9WfoBCjPljSeqQuyaRgcSPfecbQU
         I1UB+m+Sm574qnV1U02vVEs7AuV28YcnAnE5RIcG6KvnK6KD5PsOZmXQQamuESgDGwun
         qDhg+sy1tBxzAB+83Nm5mR+CUhLUwbaqiAel6FqiReITvfOQ6vARpLhClj90UPMTmWjE
         JYGVzjzBFVzOvNolnh4VvcIJgVZxEP9c5NF9B36Jvj4QgPR9xXiJxcAtgoI9KDqfBnfl
         J8sQ==
X-Gm-Message-State: APjAAAVRvtKwbLEMc1rTR/98F7hbBF7eLhEMbZWIyMjXKdaT7vogKBEK
        Wa02GgfYM0yC6Goo4mLj901fXx6pZzKG5A==
X-Google-Smtp-Source: APXvYqxkh5jvsKtB7zLA6qKpix95JeAIwIFrX0WRqlAuCLmFQpKrKljFdeMBb/DMKUIjAIXMzawtlQ==
X-Received: by 2002:a63:7c0d:: with SMTP id x13mr70206332pgc.360.1564510594054;
        Tue, 30 Jul 2019 11:16:34 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.33
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:33 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 43/57] thermal: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:43 -0700
Message-Id: <20190730181557.90391-44-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/thermal/broadcom/brcmstb_thermal.c  | 4 +---
 drivers/thermal/da9062-thermal.c            | 4 +---
 drivers/thermal/db8500_thermal.c            | 2 --
 drivers/thermal/rockchip_thermal.c          | 4 +---
 drivers/thermal/st/st_thermal_memmap.c      | 4 +---
 drivers/thermal/st/stm_thermal.c            | 4 +---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 4 +---
 7 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 5825ac581f56..619ad86dbdbc 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -331,10 +331,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	priv->thermal = thermal;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					brcmstb_tmon_irq_thread, IRQF_ONESHOT,
 					DRV_NAME, priv);
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index c32709badeda..2917b1cee1e9 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -254,10 +254,8 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 		thermal->zone->passive_delay);
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
+	if (ret < 0)
 		goto err_zone;
-	}
 	thermal->irq = ret;
 
 	ret = request_threaded_irq(thermal->irq, NULL,
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index b71a999d17d6..e391b5687147 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -408,7 +408,6 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
 	if (low_irq < 0) {
-		dev_err(&pdev->dev, "Get IRQ_HOTMON_LOW failed.\n");
 		ret = low_irq;
 		goto out_unlock;
 	}
@@ -423,7 +422,6 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0) {
-		dev_err(&pdev->dev, "Get IRQ_HOTMON_HIGH failed.\n");
 		ret = high_irq;
 		goto out_unlock;
 	}
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 343c2f5c5a25..00169e5a719a 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1229,10 +1229,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return -ENXIO;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	thermal = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_thermal_data),
 			       GFP_KERNEL);
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index a824b78dabf8..a0114452d11f 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -94,10 +94,8 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 	int ret;
 
 	sensor->irq = platform_get_irq(pdev, 0);
-	if (sensor->irq < 0) {
-		dev_err(dev, "failed to register IRQ\n");
+	if (sensor->irq < 0)
 		return sensor->irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, sensor->irq,
 					NULL, st_mmap_thermal_trip_handler,
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index cf9ddc52f30e..4697849de1ca 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -487,10 +487,8 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 	int ret;
 
 	sensor->irq = platform_get_irq(pdev, 0);
-	if (sensor->irq < 0) {
-		dev_err(dev, "%s: Unable to find IRQ\n", __func__);
+	if (sensor->irq < 0)
 		return sensor->irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, sensor->irq,
 					stm_thermal_alarm_irq,
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f738568..1747dcaba365 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -787,10 +787,8 @@ static int ti_bandgap_talert_init(struct ti_bandgap *bgp,
 	int ret;
 
 	bgp->irq = platform_get_irq(pdev, 0);
-	if (bgp->irq < 0) {
-		dev_err(&pdev->dev, "get_irq failed\n");
+	if (bgp->irq < 0)
 		return bgp->irq;
-	}
 	ret = request_threaded_irq(bgp->irq, NULL,
 				   ti_bandgap_talert_irq_handler,
 				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
-- 
Sent by a computer through tubes

