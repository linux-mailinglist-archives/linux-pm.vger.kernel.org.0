Return-Path: <linux-pm+bounces-12072-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5951794EE59
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 15:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 124BA280CAC
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2024 13:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49619183063;
	Mon, 12 Aug 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tA/IspX3"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3141F1802AB
	for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469666; cv=none; b=kivCNdfSNyCs1kx5Z/xTOsMqwQE1CDk/iYNoLkfHX7vkFIimOkmAtHNp1AICVkmkpo9maQTFqy5iW6k80A+qUQ7ryDnadCqZ3JTknAVq5ABG64WpgXbyY77NRfwZmD7GvPglm+bokoHge88qa9G4N/pfniUFpL2kALS+D1A35n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469666; c=relaxed/simple;
	bh=gmw7sdXN++0ul8rDzvdEpJ8YQFeG56dlD4XcPKrvG+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcpuOa0RBNWWMg/2rQcyVxNiF5QZSfLS2v802Qy6dg0EzClpBbK+XVe0CQy8aKPFQZhPsSs8U6a+mhUum9TPwQJq8Gj8qxMsGo5XWf52FgUN2pct23IvRbQ/sPByI5ftgFwzd+SoOKP+N5COMhmd/qDXGIRW23XP88mB/M4/XpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tA/IspX3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42816ca797fso32252595e9.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2024 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723469662; x=1724074462; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lgTXsPloyXfID4jwvyIhu24dRWJVHUfhWh9HifazGOU=;
        b=tA/IspX3w4/C7hCvLciY9JOjCNz/Z+KX9nal8rPo7Vx9zBl2t8RMQWOTDZw/aoHqot
         LuZYf30nD4HtYFtReos3XMet9o6c04kjeBGj6S4REmSd1+UP0Ht2fBSMy1tJ/rQGqcq1
         RCaGdQNd4Ivk4+RGaghWWPeowShcAh6V6hoRZjC/oQSL2n0pVvfo0D7pWG14Y6P5mnXG
         AguHiwotV7iJpmDKGgAAhoLxibZWjZQDd4G0qugJAOExKCOEWBEZuixC7ymJr/NPXpMV
         UJl7LRVEubW+mBU19fu5DITTAG+cwrHIc7LTv66zHAp7OeFph/hZ4+/pL1PuDV9Xh+zi
         ZxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469662; x=1724074462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lgTXsPloyXfID4jwvyIhu24dRWJVHUfhWh9HifazGOU=;
        b=GBzqridWYesS/nRvavtPohSp1FqybzOFh5ykFWJtkEulS04ZWPiTOYto5UN5ArVbRA
         KjTalX3uq8oXM85ycziIEUBLCq5GwHySeX4Xi1BJA4M9dMT0fLd0K+NbeZGPwvDal59R
         f4kUUHH1U0m6/XIRabniGiB8voi4PH2NydLEW05dV0m29bpCw3i7w/sIv7L2AxnSIeZE
         zg4y/Pi2VvZiVkOwqtBBK6yRjYrTfYrr0i52wiP6NX9U1Lia6ZEqdQvsM7pO1r1LM9IH
         J+ct0p/5CIlMFNtj5AuXbxT4QwBexMas05mGXBnQljEv9yJnVRr8iQwOPSRbU46r+fg3
         7XPw==
X-Forwarded-Encrypted: i=1; AJvYcCU0+VMVwJEm/OPrMvOqVC/ozEgItlQYwgrAB3hFOBi5FdbcfynSylUAiSULwBmhrrcak+uC0TOfRA2x6GBabGgqpms9E7G0G5A=
X-Gm-Message-State: AOJu0YyxPE86XSbzf/A2mzh2mYsRV+oVQ4OCaXU271MMkzNUx+Sw1/2P
	36xx8K/0XjmplGN4KloASgDLRs6vJwXtloDZUP1ibwghymuLDEfB0b0GGNKOw7M=
X-Google-Smtp-Source: AGHT+IG2U+2ivgdNzf99p2ylaUjGb2UicWlTptEg4n0FqVE6AqYOjcDIhqYbh/ow3uzGl5LVUnouOg==
X-Received: by 2002:a05:600c:154d:b0:426:602d:a246 with SMTP id 5b1f17b1804b1-429d48976c4mr3808995e9.32.1723469662493;
        Mon, 12 Aug 2024 06:34:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c7737c64sm102733975e9.31.2024.08.12.06.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:34:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 12 Aug 2024 15:33:56 +0200
Subject: [PATCH 2/9] memory: atmel-ebi: simplify with scoped for each OF
 child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-cleanup-h-of-node-put-memory-v1-2-5065a8f361d2@linaro.org>
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
In-Reply-To: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=gmw7sdXN++0ul8rDzvdEpJ8YQFeG56dlD4XcPKrvG+o=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmug9SBLK2/VucpJF/zx5ZBYvmfrRBNn21ar0oB
 3a/Cv0noJqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZroPUgAKCRDBN2bmhouD
 1+yYD/4qcA8Bj3tzEWx6jyRjX8fDvf+bTdrauIEu4tdm0NhBSOPEGsMhDXH6CgHSvmu29T1Kvz4
 ZwZ+2AAdDjZmdWXiU9FiAnN0Q33OjNkDRlCR8sEXjyPyOmXnjgzL40SEALgNKIZi4bpTvB8XX2L
 X1RJgqy8kocB79a8itpXzdUz9K6D9nHmPXj31YzY8qhiq3bGZrMX0UayHyFFwZXzC4+MvpXbxpE
 0IGsNG3fZTX84XsBX8bMvnV/Dz6Qh52B2e5+3gd9szOpKHYQjmw8sqJO+VzdNJ8WexnOV1SJE7I
 qd4gUgPlThSU/cCUNWlsl0UmvrA2ksWUVvqU0BKHOj/SEmh6VCnJ0sCtEB9v3sjVC0uH/KDQedm
 1gwdxLTsFJugS6pDjZd3lpOH26QeWPz35qwz2kWyoFTFFhMDtygj7NtFrX/rXbXI2P/ykR8PKo5
 TYETYdEEHdUE+q6d8/kWbMERlzyuEcyKeCTWOndMO1tmQOyoV2g2JgD4a1ubtmwr/LSLRU4YldQ
 mAqYO/LNC3hE9xUwtG4Zyb+KI3NZLLfTdEOYgTIIA6HLUEPlN3wrmq/7UsP+t1+DPndJVaruZn0
 t50YYT/Qalyd0LGdIKkExmcImtEVJs7HbFZn784DibyT6IaArLfY99yM9caNxxgpedYMxOdsMT9
 lDEND5PW7HyCZAw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/atmel-ebi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index fcbfc2655d8d..abc6c067b5f1 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -518,7 +518,7 @@ static int atmel_ebi_dev_disable(struct atmel_ebi *ebi, struct device_node *np)
 static int atmel_ebi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *child, *np = dev->of_node;
+	struct device_node *np = dev->of_node;
 	struct atmel_ebi *ebi;
 	int ret, reg_cells;
 	struct clk *clk;
@@ -592,7 +592,7 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 
 	reg_cells += val;
 
-	for_each_available_child_of_node(np, child) {
+	for_each_available_child_of_node_scoped(np, child) {
 		if (!of_property_present(child, "reg"))
 			continue;
 
@@ -602,10 +602,8 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 				child);
 
 			ret = atmel_ebi_dev_disable(ebi, child);
-			if (ret) {
-				of_node_put(child);
+			if (ret)
 				return ret;
-			}
 		}
 	}
 

-- 
2.43.0


