Return-Path: <linux-pm+bounces-12555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA4F958300
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 11:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1391C210B0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6EA18DF63;
	Tue, 20 Aug 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCn7YXbK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3997118CC19
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146831; cv=none; b=O6J1teQF7ZQ0qfgeDfvjMtZd8hiUGIr0MgTxZ8Q7DwKba6Tib2gMeoarTO5f0S3Zi8CQNoBO08ghCqjaRmG1HgrdyddN6FdRT/DzAvKft4cyPXLacg8+dqCVa5cBQIphu0BwV95KjOFHpAQrLxkpI9Q27O7aKsa27vUhuXfX4bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146831; c=relaxed/simple;
	bh=H/85Dy5COYZB9qMaqlUeCg4Y7LWkvndb2zLPGbCpOxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVvu0aphYN3GBi0w9BW7ZNBWEPrJHlcyDLw2MvqGJAUnFbzTgYkcwIt2Hn/58XiQVwV6+ZOiDYI7RKRoE3/8MWT59LPqbRJyGVFVdQ5GYK1fLRFTD8JY4zXI7vSBHnMGJimwrerIhbG0SGMRF9AcwPKOB7tGITTS0JA19CbK7T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCn7YXbK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a83562f9be9so476319866b.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 02:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146828; x=1724751628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZY/iGek7oJwLxPJ1JKwoSRK1o1gPKN3vGl9eBXs8wms=;
        b=aCn7YXbKsBWuxmWshX9Rx7VSkMFLFMltE11Hj374T0LbMCmNHSfjSftUE6z+aGzSb7
         NeSQ1bjUk6QPr/F1ZqYWuyZlYIpfkZPZPUhxCN0Kdj4YJW9MYSvdzy/vxipxw0Erv9rq
         VrQ51DX/kSXjQwG2/hp7qgqqXkkxlpblkVRXG8FLIhUGH56S1nwHWLLdaA/25E6ae9PB
         RF3NLPknjq8uI0P67xuNWBfs83+pOtkxhiHHvJlPbarGgeGej8bXuyljwK4TnVYf1FJx
         8VrijD1FkhUOgrP6hE6tRBHFxhRmigzC4TUAbOMY8UtmReGhHcJTBShuPKUZ1cMDyzlT
         BerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146828; x=1724751628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZY/iGek7oJwLxPJ1JKwoSRK1o1gPKN3vGl9eBXs8wms=;
        b=agEEjWuDBXtiTwXjitEtwyXAa9XwGjbDjHyprZFz7fDV1p4yuaAfQUhSQDNCLXbIeP
         AY/+NJGY/xgSfbSRwOuiQQj/0ODjj7+cF833MMhEGcFUO+CDyYbHbL1OvaNYkY/q2Ok3
         ZtKek5jVLtTamzpBGdOfm6gKSmiGYHiwd6mqXoR3ljTu3wyHQKwMu3fpfxNq9QlshjAl
         upghZvFKVyTpEjYGPks7puZ+WNZhYYG8xp2ataEFS1/z4v/A1aAWIPuFgb5yTvIcou+K
         aaP33f9RNiRz5Zqr/Z0Z8fT5X5GQzBdq2Gx3PjlauXXZhW63WdAen1olz3vQWAg8awBZ
         hyGA==
X-Forwarded-Encrypted: i=1; AJvYcCVNKsnA8cLLXQJFkJVcjMNJc2OQeBVVmVstp25yQjDdJifmETq0ueS404p8lZrO/JTBevKei5Qrmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCy4CX+Q/RfgeIkG5dDugpeg9xXKXJrct47q2n5SV6owWJb4/j
	HvYHbHUi43T2h5966kZNkjeZGhwGiMVuEBxDdKhDKDf5bK46u5WB7j7j838wg1U=
X-Google-Smtp-Source: AGHT+IG+nLIH5fnCkD0hF9cIx7+KS2wkkUp+2yCqq4ti9srWQVHwWsENFCJzq2xptsWju6FvoZxRiQ==
X-Received: by 2002:a17:907:70a:b0:a83:a85b:ed40 with SMTP id a640c23a62f3a-a83a85bedb0mr774398566b.6.1724146828420;
        Tue, 20 Aug 2024 02:40:28 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838d023dsm733613366b.64.2024.08.20.02.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:40:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Anup Patel <anup@brainfault.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Atish Patra <atishp@rivosinc.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 2/2] cpuidle: riscv-sbi: Simplify with scoped for each OF child loop
Date: Tue, 20 Aug 2024 11:40:23 +0200
Message-ID: <20240820094023.61155-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org>
References: <20240820094023.61155-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. None, only Rb tag.

Other patches from the set were applied.
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 5bb3401220d2..d228b4d18d56 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -448,7 +448,6 @@ static void sbi_pd_remove(void)
 
 static int sbi_genpd_probe(struct device_node *np)
 {
-	struct device_node *node;
 	int ret = 0, pd_count = 0;
 
 	if (!np)
@@ -458,13 +457,13 @@ static int sbi_genpd_probe(struct device_node *np)
 	 * Parse child nodes for the "#power-domain-cells" property and
 	 * initialize a genpd/genpd-of-provider pair when it's found.
 	 */
-	for_each_child_of_node(np, node) {
+	for_each_child_of_node_scoped(np, node) {
 		if (!of_property_present(node, "#power-domain-cells"))
 			continue;
 
 		ret = sbi_pd_init(node);
 		if (ret)
-			goto put_node;
+			goto remove_pd;
 
 		pd_count++;
 	}
@@ -480,8 +479,6 @@ static int sbi_genpd_probe(struct device_node *np)
 
 	return 0;
 
-put_node:
-	of_node_put(node);
 remove_pd:
 	sbi_pd_remove();
 	pr_err("failed to create CPU PM domains ret=%d\n", ret);
-- 
2.43.0


