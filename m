Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92BB644317D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Nov 2021 16:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbhKBPZB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Nov 2021 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbhKBPZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Nov 2021 11:25:01 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B3C061767;
        Tue,  2 Nov 2021 08:22:26 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id k24so16116152ljg.3;
        Tue, 02 Nov 2021 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbTjM42dgn5znxpAJxpViMxj9q04jMH0pVgaJHislBE=;
        b=EhPsEs0phIHs7egi40UpSR7z2Vena1c61+UoDWEhW18IIRX5R6/klpcYZbzLBcGYQT
         K3Jfl9KUUcTVBIisWbw7qiMMfFYmr7y1tSNEHl12guJkIWiWboIJ/YmQpSZG/Xmn+DF3
         roqUQ7+V01HQhmG12eYHOy1IeJA5NfxTuIDf1tJjYeLwF2hEt77evPj0l1Xb9g/7hJgw
         8ekNeNQqxqDFAxu+l89AS++xbBQ0sPQrCcWOgf7PmWcTe4LQXBNXUZWbQTsS6dqrfmcq
         usrFxAjJ5wcJJhMGjE33mGy7WBzkBcTT2F217CZjYwXfbkx1iUtRvAxSysu234tzSTqf
         p70g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbTjM42dgn5znxpAJxpViMxj9q04jMH0pVgaJHislBE=;
        b=EhelqSjfSLC8uvwxDjzfr3DyGc6TS32KZo0aAfm9uYXhMEV86PtQHZz9z/Vk2jt4N1
         0kPQz3NFLBcUWzxWKtJ7XoXi6rhiNiJGE3WTtRWbbECBIpjTV3LBcBqL7tS+kfrAzHgT
         dIlEt+lPCLnTA+A8GqxLex63xog1+d4l4c1oHwRCVyWvaJSSbSXDT8bYaybXrNr1r3WV
         wtpVkzC2l/6FhuVMuJ7Xa4gXbqy4pXumg+GKd1/1OlZCz2ZpgMXhkEYoGpK13XtkLFg5
         NLrgW0wyl5yHWNaHyDXiF9XiNc8CudgvRdOX2DfHq3MuejOrRe9KuWPY4Cky4LTV2cWQ
         eN2w==
X-Gm-Message-State: AOAM530cxga6d8CHqQ0UZb19lm19oEm7ALV4gDPBaJ0DF4/8vXIY9VfJ
        ofBFiwzBhPxCjjAQK9b7OYM=
X-Google-Smtp-Source: ABdhPJx0eCQNwvHDIFM+gK0yjLlN5Li6Z6x62rWTlJAR0vYyBk31rUJiZc39mCuCSL2hEoMthVSdhQ==
X-Received: by 2002:a05:651c:10b2:: with SMTP id k18mr17896959ljn.359.1635866544506;
        Tue, 02 Nov 2021 08:22:24 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a24sm250952lfr.151.2021.11.02.08.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:22:24 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH RFC 3/3] power: reset: syscon-reboot: support "reg" property
Date:   Tue,  2 Nov 2021 16:22:07 +0100
Message-Id: <20211102152207.11891-4-zajec5@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211102152207.11891-1-zajec5@gmail.com>
References: <20211102152207.11891-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This follows binding update to use "reg" for reading regmap offset.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/power/reset/syscon-reboot.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/syscon-reboot.c b/drivers/power/reset/syscon-reboot.c
index 510e363381ca..a0999bac503e 100644
--- a/drivers/power/reset/syscon-reboot.c
+++ b/drivers/power/reset/syscon-reboot.c
@@ -44,6 +44,7 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 	struct syscon_reboot_context *ctx;
 	struct device *dev = &pdev->dev;
 	int mask_err, value_err;
+	bool is_child = false;
 	int err;
 
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
@@ -55,10 +56,14 @@ static int syscon_reboot_probe(struct platform_device *pdev)
 		ctx->map = syscon_node_to_regmap(dev->parent->of_node);
 		if (IS_ERR(ctx->map))
 			return PTR_ERR(ctx->map);
+		is_child = true;
 	}
 
-	if (of_property_read_u32(pdev->dev.of_node, "offset", &ctx->offset))
-		return -EINVAL;
+	if (!is_child ||
+	    of_property_read_u32(dev->of_node, "reg", &ctx->offset)) {
+		if (of_property_read_u32(dev->of_node, "offset", &ctx->offset))
+			return -EINVAL;
+	}
 
 	value_err = of_property_read_u32(pdev->dev.of_node, "value", &ctx->value);
 	mask_err = of_property_read_u32(pdev->dev.of_node, "mask", &ctx->mask);
-- 
2.31.1

