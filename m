Return-Path: <linux-pm+bounces-12343-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28295471D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8262875D1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2DA1AD9D9;
	Fri, 16 Aug 2024 10:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="niBTVg22"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16E1AB530
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 10:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805696; cv=none; b=WC+vx8zX3va8JvTxt45H2kME1d31PqHvp9qtL9nEEMbFv2oaL6FwQXMOlXNfd9RfoezvUPgRl0oOKUSsRcK4c6SAl5a12loWWz7FUWy/HiKQqlM9bgLkPrXLqBzJ+Q7gApjn17LfamF05Lv6E4LoC5SePF2Bn9FEzuDTv4D2Ek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805696; c=relaxed/simple;
	bh=G2yPrpxBXb4PKw54ECzRtlVki76Ov9GcRLuKMdvmvH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxUX7fRLnlRJfO0TBD7CtpDbebaZJs+1iTlMjUSXNHL6TbMY2a0jNLIDr20YrQEv3zk2Dh7JEq54vvLHudxfxvEoKgxJBkj/p7AcNImiP9ERHS0ACLadZ/SZoxfhh0iNjgadmBdfFOkHOs0l/2ZyQYRyZxWNySy277bWfhdmo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=niBTVg22; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3718eaf4046so758336f8f.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 03:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805693; x=1724410493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7xWelpTr/XRUqKFM91cNQuNNebnp+T2/XDk25EhyUnU=;
        b=niBTVg22lY9aUZImJgPjv0lk/YKpJ/RapBh9iJBWUSJuPRH7c3nZ47x7DT5wUuEKfj
         w2VezXX+hT9SPd263L+DOJ8UGRmkVNj8gNpZxDVli4msOgavqZeC1hfSaZAlfWDIH2iC
         hjl66DusiZAg32ssKROwmmVEvHKPOeBa+gRznn3jmdMn7n6IUW6yl7GyXfg29vFYd8CO
         50hSbg5vvnN9939P2l7DfIUVA9+iej1uKXSakGaN3Cm97yjTxMn+No843+A79Dvs8w60
         4LG54cHEFeJHM969yJhJ1LacGZhvfYNJpjYLfUQ32O+Ernj93fKi2kHRmY6hyDSfn7LZ
         QLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805693; x=1724410493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xWelpTr/XRUqKFM91cNQuNNebnp+T2/XDk25EhyUnU=;
        b=M5jdRuYkNLoXl82wJk+NQHk6IQGLOh26R7to6GZcclkH2Iyqb6ac7ru93Pj4rrXoXh
         MjxXzljaACNeJCWgc10yXGe+TDeIx6yxjvl54ljKzLo2Uh7HeDhopZD/fgDOUlsNNquN
         H5wDwpTQHpGTxH2xOAJovtF//LxIT8rlqSxhvZtoY3wBpiq22HMqgxau83blQaDA0wVS
         JihHio/3TgUQr1S7nGMecvZLvKZe81WvAXJZLxjv/iH9VdbJSqk+ot6fToKAM0HyxkEJ
         6FXYgI5K6CpWa3nAoC84HTvhwd0TSN4hy6q3A/PR27C1AfNgCH/2ENYbw4XKdAgB1rIK
         4upg==
X-Forwarded-Encrypted: i=1; AJvYcCWIryCh68MCPDzL9ZoQBHic0ZLbQn/dzrcJa/Q2wDJxlfe2sVmCSbvoffXFrYUg6nahCH2WFYSezQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUB8V3oTFLyPVC9M5bF8FIOiKYPTAe50zYb8ZWJYbuXoBP3aUM
	6iVfClgMDj/Kf2yl71QLYr177s53OlAL8Jd7QhHNR9FFzLfz0Uq9Dd9v3M+V9yI=
X-Google-Smtp-Source: AGHT+IHD6wj7Dw8hXlamLzfXLE0YX9yxmT0kZMl6frJAfF1JNE4GaKBDulB0vb8SdWVJZ+hZ4bUsCA==
X-Received: by 2002:a05:6000:1368:b0:368:6f64:307c with SMTP id ffacd0b85a97d-371943285e6mr2028271f8f.15.1723805693032;
        Fri, 16 Aug 2024 03:54:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:29 +0200
Subject: [PATCH v2 05/13] memory: stm32-fmc2-ebi: simplify with scoped for
 each OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-5-9eed0ee16b78@linaro.org>
References: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
In-Reply-To: <20240816-cleanup-h-of-node-put-memory-v2-0-9eed0ee16b78@linaro.org>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1947;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=G2yPrpxBXb4PKw54ECzRtlVki76Ov9GcRLuKMdvmvH8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/rb4znf7Gc13+IjmByAMk6RS/9zPzPfxYqw
 7Z6nvJ1sLGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v6wAKCRDBN2bmhouD
 18MYD/oCLaJmWOWxy5n36CttxJFqbO51zWjtlcst6hRwuUgHToAatzCC4rqdYj6BqW6udSiOq2x
 MaCjbbXPxz3iOpxzfwcKWbg19No+lmlb1qk/33S3x0U9G2QJPvwticKeSkQ8rVKoCQ0axG/Jk64
 d59f87Oj+o4vvSe7bsarfpHSoxwEgjUVHG5/GvzVue/zwwfqsjCGsyd4eXS+7TCNWhyCIn5arMy
 d8Na9fDtC0X96Vjb5Pz/N289yVyYzZMtPrRDhdCQf0mxVKutUKhovg+VIGQwfBYJn8zh/ZGk66X
 DnuFEXvtDvlbr3h9lprlTzxCx/NRlVE/inFAV0lmj0GkErB0jire5a0G8+2/TMBDPuOTQu67sWA
 AZbrnvBUiv4vNpo9dtFviLw8KmYvUiZQ9VJCtwrVDwAYjtaKvWwu5pUiODcp98nbefbrm3pI2Rd
 THvcNlzPdoge696l78CgQUFoI5nxUVT8pPm4jjf82IsTJTWP2SWRg6NIldGL9doI71w+PQe6u+I
 dn4MAXawWNYuqEYgnvKY6sKASV82gYBZRe+W8jWBdobXx46WliBPxQqeY5WU5WaZe8OQpG7haL8
 DtnPg9H5b0Fdv+igpVtGJ1c7G6tDzTSUiatX/wgxRi1EO61LToCYLGG6PmXswqAUADLuNbXmpWd
 5flfqJkZrR5Iblg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/stm32-fmc2-ebi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/memory/stm32-fmc2-ebi.c b/drivers/memory/stm32-fmc2-ebi.c
index 1c63eeacd071..7167e1da56d3 100644
--- a/drivers/memory/stm32-fmc2-ebi.c
+++ b/drivers/memory/stm32-fmc2-ebi.c
@@ -1573,29 +1573,25 @@ static int stm32_fmc2_ebi_setup_cs(struct stm32_fmc2_ebi *ebi,
 static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 {
 	struct device *dev = ebi->dev;
-	struct device_node *child;
 	bool child_found = false;
 	u32 bank;
 	int ret;
 
-	for_each_available_child_of_node(dev->of_node, child) {
+	for_each_available_child_of_node_scoped(dev->of_node, child) {
 		ret = of_property_read_u32(child, "reg", &bank);
 		if (ret) {
 			dev_err(dev, "could not retrieve reg property: %d\n",
 				ret);
-			of_node_put(child);
 			return ret;
 		}
 
 		if (bank >= FMC2_MAX_BANKS) {
 			dev_err(dev, "invalid reg value: %d\n", bank);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
 		if (ebi->bank_assigned & BIT(bank)) {
 			dev_err(dev, "bank already assigned: %d\n", bank);
-			of_node_put(child);
 			return -EINVAL;
 		}
 
@@ -1603,7 +1599,6 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 			ret = ebi->data->check_rif(ebi, bank + 1);
 			if (ret) {
 				dev_err(dev, "bank access failed: %d\n", bank);
-				of_node_put(child);
 				return ret;
 			}
 		}
@@ -1613,7 +1608,6 @@ static int stm32_fmc2_ebi_parse_dt(struct stm32_fmc2_ebi *ebi)
 			if (ret) {
 				dev_err(dev, "setup chip select %d failed: %d\n",
 					bank, ret);
-				of_node_put(child);
 				return ret;
 			}
 		}

-- 
2.43.0


