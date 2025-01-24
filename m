Return-Path: <linux-pm+bounces-20925-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B65A1B228
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86BF37A1917
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942E321C182;
	Fri, 24 Jan 2025 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBph0jhM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4D221B8F7
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709140; cv=none; b=I/CoCAf+aiOEn/iYZZr+pUavFvbZRt2YexrwCmG8fzxDxkfGc59moZiqDPwS0F72nJE1QUTKaK8vXsTywydNUdR1L5FC/xoWEvYZKYgJI3N0tXyyG4X8+kB3QfeIIZplFPrXCLdTq8l0zwGr9mZccsQXVdkaxVK/EroAMLMATSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709140; c=relaxed/simple;
	bh=5Wt+y1kfE0SNlUgZf8XNj9qMfwaP2g0NAvwYLLYwYqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HKIMAic9hQS1SAVOZdre0aV9Pc+hGVMGsoetmv8DUTonHYe2+ZOgu46gOUKeRjrTDpIG7qDhJW34ahwQqdu6n6yBBzL69rnM8Ta2ckQrTouEOTGMeSIlhM6Urpk9LewiJU0QzSvujRSkDzivFLV2sO0z8P+2KSp/ECUNhm9A/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zBph0jhM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ef72924e53so3369442a91.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709138; x=1738313938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMlqr/+/x/eRJJM9d3zjLn1HVC6jDi6vYxdaFPI1JRA=;
        b=zBph0jhMLru2QlHOOLTnMuc5zL1Fs+Zzy9OIJ4Z5fGdo9QHjJvSuE4fqaiZh/TmUBI
         Pd+uPEbE/itsbr1zxuFPbhlaS1/jJImBHDCoenUg89uMnbIQfFDHqcpQiNbV8lGFN1cF
         eh0dk7suhbeSPx3e2JiVHhnSrz8QInHYvoCGxknrFIC+4dB2gbRUaWor8aRpvbzc0QsM
         10eiJfYg90Q6HeijhE6BLQVqQLqCJJzbtFTFJomZSn3GZCYCckV5TBUNm+udF0A+DAD2
         gWfZ2qzc+DWuNvCAQ+lqY/zOy59pkvOZqcYe0iPojop0q2SQodH/iZAwk+hMK5T71BPK
         pMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709138; x=1738313938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMlqr/+/x/eRJJM9d3zjLn1HVC6jDi6vYxdaFPI1JRA=;
        b=gaqacW8byFUsQef6wO7SvxcVbJsiyV9ZSFBxszOvtwEX+J5SPulzwxcLyO7MLeKF5O
         ayn14y2TPdW9CieWbeHZBB56UKlVdw2Hwn4SVMFqUPflaALp4eO/Dij4Y8XAjeEU2dP7
         UiyXgKWJSZrEkhp0uGk/DCklmVmzegSfuzizT7jiD8eNH92IhCBBo+UuGqPxm2L8X4d6
         wLUYsKC1pU0vcECqFi//JeiHxN7Xv1mhUZ6iR19hqpapvn02W49jmL5CkQjhtlxQ5UlG
         pGGqLhk2ua3Bj7ceaKWrowa9WIjobeMkdXYnGOsveucLgt2BFi3/8E/1gIUF1895VtSo
         s4UA==
X-Gm-Message-State: AOJu0YyzM7xk7OvlA2n55KLjuqk1WHIY5QTJdtdq9szekNFYLVrqNtWQ
	wUlEQJ2jiA/QfzRYs73lffdxsfBsQ68kaMCRmVEeZHQuJBii5OD7k9OTisrOtbA=
X-Gm-Gg: ASbGnctHWFxQK64UR3Hx8Mv0nSJ+GMNLOXWZyx+LSu8evJJuKTg9JTOs9PctftT01sV
	mg7QdYsFPXHeXx1gasIgRSLjt/1FmQhsNtEnk1hrgQHjqUn6XCkwWxyeTyT3SCOTH9LGrVV8Qtg
	mtq02hGW5YQBFtje5QSBsrY3wa2Z22IP4vS/IjvBEHjn/w6z7YIJmoxXlL/LYQk6eUAcyP3IsTx
	b/IGXOORs6WralKwB0S4mG0HXFj44IDoQOV0PkYksLvqjvs0DEgEpEAGpgz+f8Yrt4x4xLcPo/7
	pVws21E=
X-Google-Smtp-Source: AGHT+IFw8pe4tFyZIYNOF9s8Ywp9EEDR1mTMV9kBrefpwpJLLbKS7BB6GQPOd2o0T5Xa7ofgRk6iIw==
X-Received: by 2002:a05:6a00:ad8a:b0:72a:bc54:84f7 with SMTP id d2e1a72fcca58-72dafa03117mr40695468b3a.12.1737709138233;
        Fri, 24 Jan 2025 00:58:58 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6d234fsm1337263b3a.77.2025.01.24.00.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:57 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/15] cpufreq: apple: Set .set_boost directly
Date: Fri, 24 Jan 2025 14:28:12 +0530
Message-Id: <417fcceae52d5173cc2606dcaafe9886fd4cfeb3.1737707712.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/apple-soc-cpufreq.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
index 6ff604a0fe79..4994c86feb57 100644
--- a/drivers/cpufreq/apple-soc-cpufreq.c
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -310,15 +310,6 @@ static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
 	policy->fast_switch_possible = true;
 	policy->suspend_freq = freq_table[0].frequency;
 
-	if (policy_has_boost_freq(policy)) {
-		ret = cpufreq_enable_boost_support();
-		if (ret) {
-			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
-		} else {
-			apple_soc_cpufreq_driver.boost_enabled = true;
-		}
-	}
-
 	return 0;
 
 out_free_cpufreq_table:
@@ -353,6 +344,7 @@ static struct cpufreq_driver apple_soc_cpufreq_driver = {
 	.target_index	= apple_soc_cpufreq_set_target,
 	.fast_switch	= apple_soc_cpufreq_fast_switch,
 	.register_em	= cpufreq_register_em_with_opp,
+	.set_boost	= cpufreq_boost_set_sw,
 	.suspend	= cpufreq_generic_suspend,
 };
 
-- 
2.31.1.272.g89b43f80a514


