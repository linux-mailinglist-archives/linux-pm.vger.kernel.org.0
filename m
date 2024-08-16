Return-Path: <linux-pm+bounces-12349-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C965954734
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 12:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BCF6B21227
	for <lists+linux-pm@lfdr.de>; Fri, 16 Aug 2024 10:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432F91BA87C;
	Fri, 16 Aug 2024 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfWx4xOO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4951AD3EF
	for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 10:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805704; cv=none; b=piBQOPyLNHoBdszubMqVdgZm/d4E0Redr30j+brDT4ba8h1jDCEwvuaQdKlw2VjwClJ5LRLEv6Y6pTQu3RMQga4hyPoqHEHKz0VMYluf1KnETca+jwboaG4BcPXDEZZFWTBlP1eB/s+2WD+Va0jJRVh0wGULXZ4jkhR/45Km/FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805704; c=relaxed/simple;
	bh=Qm8I2XYrN4e568eaRkgeUjoCW+fRdkjecwXHEHRljxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkvoMVs9DSfI3gd5dySyKhQKQpgDdyMyJj3xYZ7OYKNwpGjemeKWtaTva27IUUfL4BkmM1ui0PokMRwSXpNUwljdeBCW6WCt7ET1ckpR0Y5XGE9WXDg0St/1VDQ1VYZrOau9JALgN51dWKl8rWh+AFvJJj4WwtW6H01hK7qyplU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SfWx4xOO; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42808071810so13274635e9.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Aug 2024 03:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723805701; x=1724410501; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAYRAyLvoG4oyvTDF3Z4505Z3pwRnY5SCeviwv8U1gY=;
        b=SfWx4xOOTt8NSDuKb9Z8PfUCeDdNt247yOgCnO6aT7yT8Bz0miaPgy2LYSnHc4ZTpb
         6qz4/WTeLgoOQFpRO6APV4Jczb3i+HAECO5NFSsCPFpRrgna4f4UhAMuc+6WEtDso31o
         QlJ/CzG3sXSHHGu/WKIIqjaLaw/qv+LR/bpweXmeP9uxDuhU7j8uogBOy9GuC+Zsjvkf
         zPY0NV0C6rzlICoZMbk1POcJkR8hQZT8CJ0WJLR495Lhk/VmKzUedmEjZX14dGPS8bV/
         kXEMltVAMEaDif5f8mgpDheLFJCw5ahFgxMQOmDvAa+ZLO4ywrECNMxlzyzSjxBdMnWz
         bJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723805701; x=1724410501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAYRAyLvoG4oyvTDF3Z4505Z3pwRnY5SCeviwv8U1gY=;
        b=pcIb0pYCPMrcGe8rrxULRmAW0vo+s8NGTfGSbpGmirJsd0Q6HNX02JKGjNDcwIasyn
         pT5PEo9EwGgNaowgoVnmP1/WPGIZCoxbyLmDLb+VmBZRUiLE6HhhW2qG/1tGImRIpn1M
         7RaTz3H432RQyKgcXh4CJcDv5/QUGLlATYmrjCHIfsgmW29Z9qQE3fB7e7tx8QrZLWxx
         JNC5uqQqnJl1hfyWzk6uT2c75Icsw8rcYuCYS9AavMf/IX2aNMGr/xXKo+vB4qane6wl
         /Ev/rW8cpb/uZ4MoOnSp4+afwciC6TNlmyhKCgtJn6mMpExS4lXKSQtuc66MO/CMzZy8
         2RJw==
X-Forwarded-Encrypted: i=1; AJvYcCXALE1BW5RQsVT1QKgxnFjLGeaV4gBDv15GClK/+m+twWZjQxi1fNZPy04AJYDm6LYnbed9MdCInOKnza5xVlZPdvOyjOVvUcU=
X-Gm-Message-State: AOJu0Yz6MhdyvZ+6TTRwjpJTAbsUPro7No5eVsqOT4Tv/EdJmGzLjWJe
	Pc7ZonGafYnfS9BMAuzToCVdFZVmI404Gzpw1bEGd7XxoK6hlZSxbhEGpGSVIbU=
X-Google-Smtp-Source: AGHT+IFUFl3LQZH8vi3ztVQty6MRmIGJqwYCsBA71b8YZWr3zj41X4UgzipPWDyIskK7OaUErYWEjA==
X-Received: by 2002:a05:600c:5101:b0:427:abf6:f0e6 with SMTP id 5b1f17b1804b1-429ed794e83mr19346385e9.9.1723805700849;
        Fri, 16 Aug 2024 03:55:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed7945cesm19461935e9.40.2024.08.16.03.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 03:55:00 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 16 Aug 2024 12:54:34 +0200
Subject: [PATCH v2 10/13] memory: tegra30-emc: simplify with scoped for
 each OF child loop
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-cleanup-h-of-node-put-memory-v2-10-9eed0ee16b78@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1224;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Qm8I2XYrN4e568eaRkgeUjoCW+fRdkjecwXHEHRljxk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmvy/vcqoU62xWOzA1Uh1XhtoPiUJ6/p082Y6tV
 /NdOgZszgKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZr8v7wAKCRDBN2bmhouD
 1wTED/91/aMKQySe34DvngSXlprbbqVy6N5seV1kcoB1yChmNG0FsMDP8UW9rQzbmi9E2LC9gvo
 93BdO6pP3JQTRaEvxG3bDLyFWuENgrfLBLw74JQI0x0ph+OHns7cxJfxiG/0gLhSPsfA5s8Y5U7
 cjBNMhBLld9JvKkhu4vketv8eiWTxu4aQ2u8dVwfqXQadDhAqfEGFzctPWipkWQoHlkZdXOTYGw
 ty/HFh/Q6mTWG2EFRNxEQ8OAVgK2d7s6CkTRdi82rdRn8aAlhQHqH2M0V68PS0Yr0QhbpV5g9nd
 eb/Xn+8Dtz80s8P8RoHX7nqhZuGEXjoLwTmWoO0LfUGpUEXB3Mzxap0OdBYMHLkMyDtF60rv7V8
 Hkc3LU9yZ+InrVgGK3WWYcrJI1lQhZH7obEFJjuPaCxQ9NefcMJiryO/30ctIdU5go0XSAgqgCt
 tTyKtsLD997xfQT2GMAxAzCjQ+CJ50MQS+h2pJjs3QT+LKbr7aMKEyLCQpVEyNtOgqYlqkd/AyC
 Z5jHXbA1Q0ThDYTURtwDz08/yMB/VYpCtqbYuHGhWVetzB8ndOMbJqVl0AulziVSLPjwZOE/M35
 WV/hGezQJCAHALZ7CxOXO3EXB3aXTC6PJQGTSl3qAJfUwvYBpMOCbU54aWOnGSJoe/t5Mt5Cxw0
 joPKpZTK0fVMryA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra30-emc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index d7b0a23c2d7d..921dce1b8bc6 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -979,7 +979,6 @@ static int emc_check_mc_timings(struct tegra_emc *emc)
 static int emc_load_timings_from_dt(struct tegra_emc *emc,
 				    struct device_node *node)
 {
-	struct device_node *child;
 	struct emc_timing *timing;
 	int child_count;
 	int err;
@@ -998,12 +997,10 @@ static int emc_load_timings_from_dt(struct tegra_emc *emc,
 	emc->num_timings = child_count;
 	timing = emc->timings;
 
-	for_each_child_of_node(node, child) {
+	for_each_child_of_node_scoped(node, child) {
 		err = load_one_timing_from_dt(emc, timing++, child);
-		if (err) {
-			of_node_put(child);
+		if (err)
 			return err;
-		}
 	}
 
 	sort(emc->timings, emc->num_timings, sizeof(*timing), cmp_timings,

-- 
2.43.0


