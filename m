Return-Path: <linux-pm+bounces-12352-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F8954743
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B51F24398
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B20D1B9B5A;
	Fri, 16 Aug 2024 10:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KZRn6+op"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F041BB6B9
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 10:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805709; cv=none; b=SgF7Y/a2eiTTSxj31Mzia05h9g7QBIw6gdgHi8qSWwusqXeewTbmfFI4xChEQNXPJYkdqrFQKuZh34kmp37zEkW0tep51EAtWFhRKkwAqJyi0WDCok+9FkufPfm3btHNcuzxX9aI2zcf1S14mZX0c+BggSuIIzl6zAO6XSCh59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805709; c=relaxed/simple;
	bh=XVq1bAp1DPzbReC84gkm7B7jCsUc7V7wiEW2r5jKKFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXm/1xcGw3rkfiaPhMn8lCDmJmTbq/LZvUKGs+wredMo+oZF+sskSsvRh3XX2EJ8U3QTsn0H3fL50aJ3frxRPSkOJXLBPvaxjH1KxSkdPL4Lo96eFchJJOdvYhtJtgIlw1pTtZmd8nA1XfFeHH83gX9lQkMIB/TP3ATlUKlJsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KZRn6+op; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-428243f928fso18663105e9.0
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 03:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805705; x=1724410505; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzZC0M9EYFXrRYfn9TDzsNDqOMCKTr68cWUMx7V2XT4=;
        b=KZRn6+opKv1rX7QwuZfaN4+JWsagBSk88vsI8bSJKVWdhq7c3t4ZPl7bP8tY0hBLD4
         DCp+KtbrPX2T1aMxr1jKu3Puhb5ff8wOlktdaMHaw32efycibL+qIrib0d3lOdHqhS7X
         dCSVLTnVTB2Hu7NenfuSE1aKGEXzCHsbvbvHeh3gUWmkMhZCKY178wbxH3WR++hgb2Bz
         7PwRfg7b3Z3uMYueQBXjArkvvedfAO5LKkUvaX7DG8KgDCafC7ol1eP726Dhy7RYrN9A
         +TL70pDSmHuz/dtjMxJ44g5nDFuvKS289LbfyInfY4ik/eyXSdg21QaiZfHDbfkpTOLO
         JpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805705; x=1724410505;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzZC0M9EYFXrRYfn9TDzsNDqOMCKTr68cWUMx7V2XT4=;
        b=OUZxuR15z7Zt7sM+zB0pFoBtiLyRGCM0Lrpe9XDxMzyj6NhVawXBQEBWstA3rJkCUG
         UYOnEGFcb61p34ksPROWztXDNR6eFNrasmD8UejZQQOIhSIo5VqqTLglBqN3gVOjmXdH
         eC8Cg35/UyFIaJQPk95U6hdvnPvpcP8fo28ngyBHc4KVuatQ3eOmeiYrxnHLNSJ/6xl2
         KpQn6X1banKbbRT2lxCiRXY+/M/7AiLnWOUAQbtL4A8qfnnZUxTu8sQ50rKBwjx2leqm
         tx01rQi8yG9NPWBWVhPBi3LTngysof4VymzLp96CsiJ5kLT9lo1TUYgdBCoOhKs075mp
         IrSA==
X-Forwarded-Encrypted: i=1; AJvYcCVBXs1wkkB8yIR1OmV+yGlfh1E27UbQs+595vG5tOrRnHk628efaXpU3a/oUtbeffqKTM1WvgM6hJkBJslwwItQ64uY+8HNM5Q=
X-Gm-Message-State: AOJu0Yx9kIwpquyWrTcgRhA5oI6cTV43GRHq4FKlkZ7RZd+jYxMPkn17
	purVihTjqj29E0Z276yJpb3boz6f550Qt7mUEzA1XHmpisSEjvpUwXfjvUjAwfgDfDEOW7BFb0b
	tQqQ=
X-Google-Smtp-Source: AGHT+IHjZHJdqi78iF456VbGb6wR7RxT96NknEiGEFoYeO6BRf1QVX7lFBSfHR9ooukIBdApMHs1NQ==
X-Received: by 2002:a05:600c:208:b0:426:59fe:ac27 with SMTP id 5b1f17b1804b1-429ed7d6481mr18549855e9.26.1723805705202;
        Fri, 16 Aug 2024 03:55:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:55:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:37 +0200
Subject: [PATCH v2 13/13] memory: ti-aemif: simplify with scoped for each
 OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-13-9eed0ee16b78@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1869;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XVq1bAp1DPzbReC84gkm7B7jCsUc7V7wiEW2r5jKKFs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/yjJOSs+fjUCguca37Fmp1Np6bS/o8AycYV
 q1DSeQLoR6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v8gAKCRDBN2bmhouD
 1z3+D/4vIO8HONcnYaJfvUTePd6DMbBbn9F/+h5JlkVZ9zuC6/FNYFAdsOVvol0buCd7GaQWZvB
 xkVBikxYPZ/SpZ/juDJ1odkOaVuG+6NFpphe6DNYNdwhio6ejIUqUcPYrgF88Lkc315GuP4WaHh
 LQrpEtjlApG1WaiWbwIyWH2Pe6aYg6XG2Qt5641TUI4xcOu9mdemiA6giWEpFo8OS1fA3vgDolp
 YQWUT5h/oXmzvUoFRt6nTrOWpdPc0cUcectO/1sJxCzVAn6+idbkM/UCEF6dxovgd0Xq1rbtS8Y
 HSlVMFGLgkJ1ujF1QHVdPYR8Ms0Qgsk3cJUMNbvRKw4BWCyPBa9GM+1gp8V+5O4ozHdWYpNwdNJ
 WTVSTv3lSokPa/71tY2WlqDaLwd5Wz/5Cd3NxPrCYKSIti5jI5aF2DkO5fF1NES8LHwVKhwiBPh
 1GDrE73cb3PgoZQaGrPa8bA6QZNnFoZ0Isw68JLrfs8DvnyGnS0kJmGZsxZvO10+6iu7fv3BMeP
 /yJ5siDXH5HJP4f8bqPef8kK6KkDxp25JKag4raVN91XG1UeuBdgU+0dIOlTfpGHsfvIgcvemJ6
 N8nBHo+dkh0vyPbMITPZEbJASGRHeSS++0db3mzSmkBWtUYQx4Abnd2BV8WH1C0z24W+pTT3FS9
 U08Yg6h2nsqgtDA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/ti-aemif.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/memory/ti-aemif.c b/drivers/memory/ti-aemif.c
index bb9c8132d8c0..7b48303f183b 100644
--- a/drivers/memory/ti-aemif.c
+++ b/drivers/memory/ti-aemif.c
@@ -330,7 +330,6 @@ static int aemif_probe(struct platform_device *pdev)
 	int ret = -ENODEV;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *child_np;
 	struct aemif_device *aemif;
 	struct aemif_platform_data *pdata;
 	struct of_dev_auxdata *dev_lookup;
@@ -366,12 +365,10 @@ static int aemif_probe(struct platform_device *pdev)
 		 * functions iterate over these nodes and update the cs data
 		 * array.
 		 */
-		for_each_available_child_of_node(np, child_np) {
+		for_each_available_child_of_node_scoped(np, child_np) {
 			ret = of_aemif_parse_abus_config(pdev, child_np);
-			if (ret < 0) {
-				of_node_put(child_np);
+			if (ret < 0)
 				return ret;
-			}
 		}
 	} else if (pdata && pdata->num_abus_data > 0) {
 		for (i = 0; i < pdata->num_abus_data; i++, aemif->num_cs++) {
@@ -394,13 +391,11 @@ static int aemif_probe(struct platform_device *pdev)
 	 * child will be probed after the AEMIF timing parameters are set.
 	 */
 	if (np) {
-		for_each_available_child_of_node(np, child_np) {
+		for_each_available_child_of_node_scoped(np, child_np) {
 			ret = of_platform_populate(child_np, NULL,
 						   dev_lookup, dev);
-			if (ret < 0) {
-				of_node_put(child_np);
+			if (ret < 0)
 				return ret;
-			}
 		}
 	} else if (pdata) {
 		for (i = 0; i < pdata->num_sub_devices; i++) {

-- 
2.43.0


