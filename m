Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 48B43EA335
	for <lists+linux-pm@lfdr.de>; Wed, 30 Oct 2019 19:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfJ3SWR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Oct 2019 14:22:17 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45819 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfJ3SWR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Oct 2019 14:22:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1so1990304pgj.12;
        Wed, 30 Oct 2019 11:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=otlqAInALZr2P9dty8XUUL6zB6HI1wPTVfKnXgrgDz0=;
        b=pEEW2f30nRHch1s2EgqqRpTUyvDRjLA9w9GBytO7Iw7WGg74ykAWtVnXm+1cP6BNtm
         1mZF181hfY9IbKuci1v4a3VeACfmv4FpXcXMcwSypF1tBsNJWotuP7sN+4Wdojq3NzFM
         lkGzXXf5YVCclaf7qH/X2d2FAFMTbvvJD7hCPoZnx6o8FzriL3hBjpsiEO1a/bXJKcG+
         s5kFzBta7vgBbyXUtBcw2om6ScDUWrSGvn2l+eKVoMlBYEg+OVu9h30wNIM2EdTZq1Vw
         ISn/w/OD8N0iGySp/i2MduBFT/UipcSQXv80fKEpxchF7keX0MXQ7ricV0tlvH5gyYmd
         mdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=otlqAInALZr2P9dty8XUUL6zB6HI1wPTVfKnXgrgDz0=;
        b=ZqGbI16HhNlUBdISNq+BfewS/TcYIDMyy1S4UfqTcDyDBbXp/Ts6hP904SffOtm8aC
         XmNkZGyHpNAnbAUP7TAeJ+6j7y1TZLytodRmmEcgx+EBrSs6BspReLT6a5U5CE58k0Sj
         raTg0y5nKfmvR9PtxKL36bjXV+KiwpFI6LW0D0xSCsVKekFs0ikpIOm13Pfh5zypqGY7
         M25MjCtaRlMucjXT3IQaxtCmHISfbdD5fNWU49Z+uD367w5tPzjGn2GR1EplU89Gq002
         EOCJ4AtNlMc6wBR5fRknOaWTz85Z6snVw5yq80/5WEG1Jix3QZ/4jguaGSWlryjYxKO6
         m2uw==
X-Gm-Message-State: APjAAAUmfL97ZUXKILi5PxfZKSRBSykvBuH4Oedg+B6hmr2Bd7eQHz07
        90geYE4aBwXk69MMqywtktbBWIis
X-Google-Smtp-Source: APXvYqxk/HB2PwWsDYa2sz7k6NPxepTRZ9yjvxvqoyqYJW22soLktVzEJMlRx6lO+FPLQKHqV+cFoQ==
X-Received: by 2002:a63:4081:: with SMTP id n123mr888165pga.444.1572459735810;
        Wed, 30 Oct 2019 11:22:15 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z5sm521637pgi.19.2019.10.30.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:22:15 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM STB AVS TMON
        DRIVER), Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-pm@vger.kernel.org (open list:BROADCOM STB AVS TMON DRIVER),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX
        ARM ARCHITECTURE)
Subject: [PATCH 5/6] thermal: brcmstb_thermal: Restructure interrupt registration
Date:   Wed, 30 Oct 2019 11:21:31 -0700
Message-Id: <20191030182132.25763-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191030182132.25763-1-f.fainelli@gmail.com>
References: <20191030182132.25763-1-f.fainelli@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If we are successful grabbing the interrupt resource, then register an
interrupt handler, this makes it easier to support the interrupt as
being optional, which is it for 7216.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/thermal/broadcom/brcmstb_thermal.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 41d4a142707c..64f715053ce9 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -339,16 +339,15 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
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

