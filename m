Return-Path: <linux-pm+bounces-20926-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E71A8A1B22C
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865373AF4C9
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741D221A44A;
	Fri, 24 Jan 2025 08:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGlxnFQS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A874B21A446
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709145; cv=none; b=VtFGeaBeg5oZ7ue5NwqLZJta1qQaknuEpNl/fk/aaSfEmC2ousP/LCSDIrtgr8WSspgoM4hfagPfaEgqGHtlgCAKUq+tAr+q8v/W5HTxn1pVNqY8ShLWWTUZaO3XGaafyS5PHMAgmSMR8b5dfjBKhpxbzOJ4nM2Tw2EoLSf9vZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709145; c=relaxed/simple;
	bh=DNyXYLNqnDGTpYMMmN2+u7aiSbjZBEJB+HjmmWjpP64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=er4EIrdpxXgk0J0GwmkQl9uOWMUc/XhQx8KHSk6oiYxQmo9b2wVzke0wmW2Eu1Ikn+jhAYKk5kjQ44+uxNF3moVFKHEc+ew+baNQaQwjT1mEHoCicu1zIGEa0MMfmL9E7hdbTYcNU0Wk1cOQBkmHZ9/7mN0Xj6QfUSTF74SFXk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xGlxnFQS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f78a4ca5deso2608576a91.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709143; x=1738313943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlxTGa2NoXf0U2Bhx3PIAC2y2IpE66IWBZ2zi6Nlb6w=;
        b=xGlxnFQSsZpVy8xWaWD/2p0Yd4KDfVu8md/hwNpnNhWxOfe9kSAzuv0WoSn9zJKmYZ
         5e+UNGoobEyaBdsYxLyA9Ser3Hd+4leenDs9hCG/tHHnLkDYsx2qUNmVxIxESnBGW2Ya
         /LyCpSAc3vzMEFtIeEHlhxGwBtg9KXAiLUeDn8Tymm260CYQ8IPUREQk+r7GgOjJVQm9
         1p7B7xF9a+InhlACE8n0mP1plVb4K67hQej9h45TKctWPJXF+P6WIBeuFrlmFvn0sUnU
         X2pLJKrb+Qa0XUoynEq+WTZdy+FZvOHoRdWs1g//mZ8nDzgUOIrAfG+2iHAmDHzrIoOz
         TL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709143; x=1738313943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlxTGa2NoXf0U2Bhx3PIAC2y2IpE66IWBZ2zi6Nlb6w=;
        b=YWBblpVyZedajGNpNQ3vVOAMwSDcgg0INmX7A/t6OjtkuYhW8aKL/qCwEcdWByxVy0
         oo3vJCNp6jvWWv2g0ADuhvB9EmvvPpH0ueHpHPmrzN4epqZoOQBVSn3E6Ke8ayIf93Cp
         uTFP72TgetSkl/oFQSn2U2LLNk64qg7aPrv+UNYCeF6KU1CR58kj/fNgYmFK8ZcieNqB
         Yn/ujeRX6Li4cMc0q5HgzCTOVun4Z7hdHwVtHae+AXG1JIIzP9jhhEcFlkynxnfsvufA
         /d2NgovLuDbky2e8QY6KBwYGJY+TdOq3cl+eL3oCtXI7dHBSi9s51e9Ko9+fcPkiM64A
         dU7A==
X-Gm-Message-State: AOJu0Yyg0DE5ZcXeeh0cx7JBL1Y1JFG5x+Phnr9qJf9jY7kFHYe4uxlM
	ccZh9K03La5xIuBLbXkFVSNZ2fqci/8QQHxpg7s9LIRYwo/KODcu7WEB7lQrXrM=
X-Gm-Gg: ASbGncvfNQDN8Boqa7/1F/47iggqhAWohMdF7IiAYLqWr4RGnHCXDOZBifcebg9FwUz
	BRTgT2bxOM33jieUnfsbOv5Zld024J0A07Ydcat+jqz3FXkWDj8uBcdVQAmxojaPktpG3/Fl+Kq
	Nf+bVw1g1bG6ldu7Fbbd2W/lbFj4ESOX9yFOL6fCZppADCFxZkB7y3+l4DHd1rtuo/S0IP4pNHZ
	AAEqBhYHp0oZfI1wz35vsStMryi4H7OYoTNi7XIeOAJiUPupDaRnBqj7Ykqn+CbSRzbHAouhcvI
	2RcYRs4=
X-Google-Smtp-Source: AGHT+IEIQFAd+nDcE1KZztHOLcwIZcsISxikWrtqikmaVDwNIDlSGV8IHx2h7CCPFEPGAtyydYzt+A==
X-Received: by 2002:a05:6a00:4c0a:b0:725:e015:9082 with SMTP id d2e1a72fcca58-72daf92bee2mr36684993b3a.5.1737709141450;
        Fri, 24 Jan 2025 00:59:01 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a78e3cesm1322652b3a.168.2025.01.24.00.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:59:00 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] cpufreq: loongson: Set .set_boost directly
Date: Fri, 24 Jan 2025 14:28:13 +0530
Message-Id: <0cef4a792391f50463fb1e72a96645e34eafbc89.1737707712.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737707712.git.viresh.kumar@linaro.org>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The boost feature can be controlled at two levels currently, driver
level (applies to all policies) and per-policy.

Currently the driver enables driver level boost support from the
per-policy ->init() callback, which isn't really efficient as that gets
called for each policy and then there is online/offline path too where
this gets done unnecessarily.

Instead set the .set_boost field directly and always enable the boost
support. If a policy doesn't support boost feature, the core will not
enable it for that policy.

Keep the initial state of driver level boost to disabled and let the
user enable it if required as ideally the boost frequencies must be used
only when really required.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson3_cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
index ea516b939c44..1e8715ea1b77 100644
--- a/drivers/cpufreq/loongson3_cpufreq.c
+++ b/drivers/cpufreq/loongson3_cpufreq.c
@@ -299,15 +299,6 @@ static int loongson3_cpufreq_cpu_init(struct cpufreq_policy *policy)
 			per_cpu(freq_data, i) = per_cpu(freq_data, cpu);
 	}
 
-	if (policy_has_boost_freq(policy)) {
-		ret = cpufreq_enable_boost_support();
-		if (ret < 0) {
-			pr_warn("cpufreq: Failed to enable boost: %d\n", ret);
-			return ret;
-		}
-		loongson3_cpufreq_driver.boost_enabled = true;
-	}
-
 	return 0;
 }
 
@@ -338,6 +329,7 @@ static struct cpufreq_driver loongson3_cpufreq_driver = {
 	.get = loongson3_cpufreq_get,
 	.target_index = loongson3_cpufreq_target,
 	.verify = cpufreq_generic_frequency_table_verify,
+	.set_boost = cpufreq_boost_set_sw,
 	.suspend = cpufreq_generic_suspend,
 };
 
-- 
2.31.1.272.g89b43f80a514


