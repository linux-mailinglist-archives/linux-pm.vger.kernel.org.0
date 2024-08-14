Return-Path: <linux-pm+bounces-12234-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33E2952342
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 22:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5BA61C213EC
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 20:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEBD1C8FDD;
	Wed, 14 Aug 2024 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qvg0l7ga"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E721C9DD3
	for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666696; cv=none; b=V4MrQOuQVVbDgWb3wwIUjlp+DLAZpXV/7tEQCqMxYFMUU9PxUrqiqoJb3IgFly6pN658BrdRA/f9uLkNSo6OFSC2sGQFSwlv2Xy0znbNsaKRM9xtNVNnkJ/IsAJZKQkxbhyYU5aQMAnw50fSAL9d5leAlodlY9BTkvyTM852iSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666696; c=relaxed/simple;
	bh=qjB1r7xWZkiqepaZBKt71uec8dzopsPxrHTPtf78T+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mpbFeSoh5ftKqA7ojO3N4i+LyKaBehKVsPKh7xCZRw3HKVEhEAzQt9uq7en/KkRYsGto7KA1tpB9I3gguYoNB3u6nEypKgWj8BIqGzSZ9aiQXwq0H1GpFfoKSFSMJuhRWwuh/YSmrhGy+U/3h6jK857gzhR5QO8v17ImPoEhZlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qvg0l7ga; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42816ca797fso1052835e9.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Aug 2024 13:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723666693; x=1724271493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkMza/iQJ0QUiOTZWS7zmA9N7fZVP+GD4cxhszqTjVw=;
        b=qvg0l7gah/aSSQEQzeV0Tz0yB01+9NpwgychFuBe7kAcnohwfSW/fYIrtyrWm9O0rb
         ELEY7i7fOzIKw5BEtQClnV+jeOwSaDZql+rWuzHnhdaJujphJHauLSlwPkRMVHMYXhKT
         h/4v+RH3HGcn702MFjF2Ffc8BWxsN6ed5XKAzSc73VGyMebg1WiimMG+YEaPn5KthmMS
         dsys4P8UJvaAWVEk5ZJbVgO7LwVukwTeumbUYHKzlunzuZ+7NNampu0rG5S8my/I+XzH
         /5XibjPV85C8+PK7BJ2NO6B8URQAUU5ZpPiAGICbv7nIpD7i+wy1rn++UlOc7eaDqgQy
         uLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666693; x=1724271493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkMza/iQJ0QUiOTZWS7zmA9N7fZVP+GD4cxhszqTjVw=;
        b=JrbR+hQ/2PlTerJzCrl0byUsgZFndMJOXGmAyhkCM3oM3q29+GIy1B5T/kif2c4zhc
         T+sPTQTXjUQSCxVV+a+kDQ1eLOgGLHpWFFWyIhQyYtWpqP59H793cahqwYLLpuUx6Bvd
         NzaSgJjRMm4hJCRUxTGEDe+auJa7NRJEP2ApdFnpcogp4zR6EPHYEQgfUh9PU41JJRQW
         KPW9l5ctNC0atKAX3Gz0ihhe6YtaaJ61tvwRNQw9pLQNmHtm4Ow2tdWcyDP1/bTPk30G
         lwE9VbnlDeoRShngpUVmGt09G2ddpbQsTfFuoV/4HNtFfvNA7DVuojghcXmN53vDFejC
         cBQA==
X-Gm-Message-State: AOJu0Yz/iq5XeyeNTP+AZF41R4tB4t/00JgmG3OAQ1hZbHZwp6Gp0T68
	mxqw5NQhGveD2rJ86Kw3leayX2OkGLoTd9UlSRHQm+WIFop1Lcx7O7lY2RZmajY=
X-Google-Smtp-Source: AGHT+IGnTWLywH9MaoyhJRh9e6rqTQpuA5DArTXIC0CU3PtawcT4ViUxduJrjccfNP+6pW3j7swlVg==
X-Received: by 2002:adf:e702:0:b0:369:ba89:a577 with SMTP id ffacd0b85a97d-371777b1bd1mr2864629f8f.34.1723666693157;
        Wed, 14 Aug 2024 13:18:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4ebd3631sm13623519f8f.110.2024.08.14.13.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 13:18:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 14 Aug 2024 22:17:53 +0200
Subject: [PATCH 7/7] thermal: sun8i: Use scoped device node handling to
 simplify error paths
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-b4-cleanup-h-of-node-put-thermal-v1-7-7a1381e1627e@linaro.org>
References: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
In-Reply-To: <20240814-b4-cleanup-h-of-node-put-thermal-v1-0-7a1381e1627e@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Vasily Khoruzhick <anarsoul@gmail.com>, Yangtao Li <tiny.windzz@gmail.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1690;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=qjB1r7xWZkiqepaZBKt71uec8dzopsPxrHTPtf78T+A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvRD1tu+OfU0AIMkIy7rwyVDG9h4CyZBJq2lx9
 T9f0OzUoMWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr0Q9QAKCRDBN2bmhouD
 1+c6D/9L71ii7X8SXP+hER4rvtyMdzBnxiA9V6HcUp4+DoljLDog0tR7F9bq8L6vfBfgJrUClwB
 l1BVN5h89/Nq0ZXHFkTZysFdiBmTrSUJiaCbHRhA8EEEGmxZVyARP6yTAOxy5nSIP3RapG0kZPa
 sCn1XVWO6zFIg3hYsZga906bNygVn+vaw1eSkNWmdj1IyNlvXGoyncGt4gGBHszuA3V7NUwplXL
 xUFYvwGZoE6MDswhKkYs2Mzd/2444ochaXS8mooZDTpOefionTRgovxfXlcAoi+qGsdmEPe3WPG
 uumzRLm4iwQ4aUkhVSygpRVh9eK0Qt+adknlmqWQROyiW7i1rdhF5jkzVwONHNolQDQjUhp+qfV
 WAXfmTI1sx2pPmSgEtrnmvJCz7z+6qxfDxXqnzcMluf2pZjn6GMyh6zcmimIDnlfRgi+lf84E12
 IMmZ7UEX7spYVxwaTsWizJd10bPP8LPk3tQiwBy7LrZ27d8NLlrb7LJbPp4ukO4P4jPCRrr1s1R
 E0D0QDeC9mZNZrhwTx+GSfood/gTRLj55h3tz78QkMXT9jMkWPnF8MYMXWbWpDbez5q+Ibb/L1x
 FomdxaFfQIkSN3Q6NRtv78555UJxK6REVC8guvyyfhFFFu5fI/+AnnVGddvsx8vv9gUrEVgoAr/
 8szxukJ5Iy1aydg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Obtain the device node reference with scoped/cleanup.h to reduce error
handling and make the code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/sun8i_thermal.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 3203d8bd13a8..22674790629a 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/bitmap.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
@@ -348,19 +349,18 @@ static void sun8i_ths_reset_control_assert(void *data)
 
 static struct regmap *sun8i_ths_get_sram_regmap(struct device_node *node)
 {
-	struct device_node *sram_node;
 	struct platform_device *sram_pdev;
 	struct regmap *regmap = NULL;
 
-	sram_node = of_parse_phandle(node, "allwinner,sram", 0);
+	struct device_node *sram_node __free(device_node) =
+		of_parse_phandle(node, "allwinner,sram", 0);
 	if (!sram_node)
 		return ERR_PTR(-ENODEV);
 
 	sram_pdev = of_find_device_by_node(sram_node);
 	if (!sram_pdev) {
 		/* platform device might not be probed yet */
-		regmap = ERR_PTR(-EPROBE_DEFER);
-		goto out_put_node;
+		return ERR_PTR(-EPROBE_DEFER);
 	}
 
 	/* If no regmap is found then the other device driver is at fault */
@@ -369,8 +369,7 @@ static struct regmap *sun8i_ths_get_sram_regmap(struct device_node *node)
 		regmap = ERR_PTR(-EINVAL);
 
 	platform_device_put(sram_pdev);
-out_put_node:
-	of_node_put(sram_node);
+
 	return regmap;
 }
 

-- 
2.43.0


