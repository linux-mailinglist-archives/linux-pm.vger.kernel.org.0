Return-Path: <linux-pm+bounces-12347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3795472D
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB7BB235CD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F441B86F6;
	Fri, 16 Aug 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QG1hDsll"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3381B3F3D
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 10:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805701; cv=none; b=NoDTWgaXXo5BGeUr1oq46nZ9CstY3MTWm3kbJ4Tdao/F3sIulNCodhdAGuXngWsIt4mwPB36hObsnvDtvHOXaruw/tl8QHt/xT/aqtIArABOAnfi0nkf1UeqmNiTO32xapU20iTyNvDrNF13iD3cQsfi0SICfdon8IXCbvAzRj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805701; c=relaxed/simple;
	bh=rDsZLo3wwoaidFkJYFptVSgVV4IV53Wsuj2KZiIUK6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s01g7eFLTGKCw0GBMFxvP3r1XyGhUBTFYz9Lhi2AKWdkyRt9LW01+QQ+NCqbEljZELfeMEm5E+gju1ComT4cKKjU4oKg01EOb7dn/mAV8AflFThX5n1KSkg1FP4iDPon1StENhAbOLjs9R7FFZfMaKe2vxxLnR22DMCd9DeRe38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QG1hDsll; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428243f928cso13278635e9.3
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805698; x=1724410498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JOgxzZUvrtpq2BMDuicgWPsp2jimj6KEDspxwy4BQUg=;
        b=QG1hDsll35WHl638J2EDuxdoDUGRjooRjO5pzydgedeTPcYQFqfyVfme80xsoqb7MR
         W0GudeMaJzKOd0jzgKOoEqUmXIHMNw8CwAzZmLZIucYEhjl6d+hpkB0W1ozwlrb0/Exy
         hVZmdOaXXnZT/yCUP0i8Urov6TTIO6rfrPFudJCIy6Nh56rGi7crtk6VXTib8wN69Be+
         BQXLR90g/Fko+VYWBu815oGL5og3ZDE0/gqfwMZg1GtY0aW629ci/Yd7MBnSfAGTO76N
         KiII22wHnb6lY3ehiq/3z+5PgrFSz5YkhdhZiXkjq54e0HhJ3y4C3X6LylKkSti0uHK7
         udEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805698; x=1724410498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOgxzZUvrtpq2BMDuicgWPsp2jimj6KEDspxwy4BQUg=;
        b=WVhds88XoA85+UXxKZNT345t5UTO/IC4dnIeCKGEiE3ssTNE73DUbyax8KOaf/enzD
         BSXqlUoqqODJCZX0ZsGyYinvFoXjwW9UDFPAExQKRTEWR1A+RlnDyQgfXlF8mqI8hQP7
         rxLkpOaFuhx/eoN6AgUgfu+pYIkMVndVbYRX9J8r7ymN29RKpIpdpboL5GMUwEf/bs/T
         Bxh+zl0VVYISctPuoz49duRcAyKRhoByX2LwGZh4AGy24mMzeAlEv1w31u4s6zXPW6yd
         qPrDXl/I0qiE8jthHNTJhFLiKehIqoPnMqWz1aVGOIZ8NG8K+J4bScRReIoL5N4kd1xH
         HQWw==
X-Forwarded-Encrypted: i=1; AJvYcCVlg1gKGPSa1yIcoJLYQNauah5AyCed/ODoTz3lJT7dQcvoEVQaixwVaqzoODEhXwgAuupInJDAvcxWGVxtv5nYDFrWp3Gtf9c=
X-Gm-Message-State: AOJu0YyHXhO445m3tuL22PxXZq1pscuWPcyjrF0L68wqujLvTccgdEEW
	VWo0x+h53z8/5CMiqbeF1IDCSQE14vXz0o8R9OWdJ7c8nFQu8kOz+u1osAOkzyg=
X-Google-Smtp-Source: AGHT+IHMPxUtjfGRn7ZG1qPQZ/Tx/a2kVQMSOXnBcUVsMZ+mh2g/UkrF5oZy92ASETKVrsM2pu1Eew==
X-Received: by 2002:a05:600c:a45:b0:426:6edb:7e14 with SMTP id 5b1f17b1804b1-429ed7d34fdmr15301545e9.35.1723805697665;
        Fri, 16 Aug 2024 03:54:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:54:57 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:32 +0200
Subject: [PATCH v2 08/13] memory: tegra124-emc: simplify with scoped for
 each OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-8-9eed0ee16b78@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=rDsZLo3wwoaidFkJYFptVSgVV4IV53Wsuj2KZiIUK6I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/tahceV7TKEor8UTYOHOw8XO+MpwcWse5dr
 Yc5OT5M1QeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v7QAKCRDBN2bmhouD
 15qVD/4temSVQ0ngkzMHbEIkNQhXO194h+2fYYACqxi8kpkiZBvmRpBRXJviVipghRhO9K5i3Pi
 bCLujgzzk3lAnUlRAUWLFE1ZwJwbNorN3L2wMvDiAH4xWtexjXHdpJU6Frbq9hf41oMf8To3yn4
 mpYNezq1J3BvH5AvfuNV2cG707DvNk/mGOfYyG6818en+8wWeI8gQFsjusd7PtdWmnq7fSRVcE2
 qQnN3nCq4uBAvghWHM9zN7GmmkLtIP2jAC02NIDPVBw9QNZHaSjGb+Z9DeasEOErDeYzxS7cu2e
 /4AZKgZkHgu3Wa9veJOuUOYhwlovzdflxQo1yd725cwJs0PVSUmX5wmplqc46JaxKNQPgZ5k5EX
 G/23vekqpdTc22RLBtafVW47vW+Jequ/eSCV9ObE/b2j5HXdd93G2wESc2roklzvr5qnEL6cX4b
 S6SQZ5j3yrxo21XrBloI7KTj+XaiRG27QrJ5CqxN/dnQ77vGOJPY/vhmZHpf0YjELoI2vylKP+l
 KKinczj+fDN9OL162qEJnOn58KSFvQviNx0Is1TPt2LoYk30l2I/5Ga72W+SflJCAWYMPBEBwkT
 rwjTv2CqWkebZjiE16onqrwHk9gkdH9/Wyon/lJMXW9lb/Xm29+jK3AcBi+OPK3OljwHqayB2X0
 j8CvAwe+7cD/yXg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra124-emc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 47c0c19e13fd..03f1daa2d132 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -992,7 +992,6 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 					  struct device_node *node)
 {
 	int child_count = of_get_child_count(node);
-	struct device_node *child;
 	struct emc_timing *timing;
 	unsigned int i = 0;
 	int err;
@@ -1004,14 +1003,12 @@ static int tegra_emc_load_timings_from_dt(struct tegra_emc *emc,
 
 	emc->num_timings = child_count;
 
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		timing = &emc->timings[i++];
 
 		err = load_one_timing_from_dt(emc, timing, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}
 
 	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,

-- 
2.43.0


