Return-Path: <linux-pm+bounces-20923-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9396CA1B225
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176513AF5F2
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 08:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67A321B196;
	Fri, 24 Jan 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxOkKQCm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520CA21B1B4
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709133; cv=none; b=uFJMTtgZF1qwAHDqEC3GdJDIPmFvAdUsGbAwbgCVqBBz8uKHq5O6w4gm9RYcoMByyfoyxyo1g+Tb77tDCJUubZ5SWkNarEGWin7PpYm4/UkRgwdtw4C1mHI5/vQdj6lJTJQZAR6gIojIb9YTc/4HSYBTYL9X6sgDAX6PCcQy8xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709133; c=relaxed/simple;
	bh=bXRFxc8mF6V5TgGKJMgWIksw91YHqbMB+UstyP1aTGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKI6j3XK4Cvpe4cvidwe4pvZL0ekgJuNwnjOLDcVDN+n6Ea4u98+2zjTkUyLlLf5VQEJdMPxHJJ76YjrouDLsASqlBEawnKpbfOKzEhuh2ivWR4KHwRgZZshY0ceb3nU4PbMPw5qlmLRWTfWOsJp+nIf7URPQSusmWUalRP+2Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GxOkKQCm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2166360285dso32994515ad.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709132; x=1738313932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMoNvFkgp1qWLsX17FcDuwLCN8OyZaPo8LJZUOBX12E=;
        b=GxOkKQCmN64sAQBrURY/UX3/rTlcOpjQu9QkW7ktzBaiNDZsAp5IaXIULOYk00GmFY
         fqnKhbrMf00/rywIkf5SBBmusZooCqymVaMuTCrYgq33XxPYC72zqvooHCnaYjs1dY2n
         29ojGscsaHE6Wlk12Nd4aVX++Ep4TqXjem4sA9ApsaBZd9t7dsR/Ji1VAJQfzL1Hoglt
         C+JvfJHXOb4fFjQagsloJGCftur8P+vbt1KOaQ8KZ+3Wg4rVUy7gAmMqHKV8DTVA9MR1
         eC9dHYa3W/Po/NtLP0q86Y0D9qmbz53aY/ZZYcRmEFzobQ3s4YkVLR5k1vGYatuFiS2X
         VF/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709132; x=1738313932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fMoNvFkgp1qWLsX17FcDuwLCN8OyZaPo8LJZUOBX12E=;
        b=fgL/L/l43IcF1fXGqip2T7OcFMIqEjnvQZAdOwtJa/4l/bpJh1wbKu8D9OTdg9SDYL
         PyFnn8wJtK/zBG4sPvSN1QWUWbEx2r5rD7cCwWedV0sjkFzXVCdwZqfdSERlAHtuSJDh
         R7gHC2QGB++AV5H3TAh7zRGxCf5hbrYfESXtFBOxy+WWM2v5nuCfzdcVrYCPHiSWyWOz
         PczdnPFIU19ehoFD9a5O3FM+7jb8NOkMmsqWe++xL11wxfHnazSLc5aD83slwP5pHcNq
         Kx/fNCEzRh1R5N1aJ8saI1xe1cVqfc/8mci6+fMBQNy2ZskZK10pO43ykud3jC+f9jAQ
         MYEA==
X-Gm-Message-State: AOJu0YwgA8iF44vWqP7ZtuwMu+4Lv5wTmvVkzqBj55sdsuLpcttY0+co
	kkjAg1T1UzsH2jQMSPWEFwGG1gc4f79UI6l33yIZaGS965RD6Oq/6WhcKApQonI=
X-Gm-Gg: ASbGncvPk0DkwQvqrFT6ty8BNfQd5GF09zuvrPS16d00QXBXqy5dU6n8SwIMp8TDvbz
	Fc/7R2QzcCxoLmWw1ulBKFpGs86RA6+p0UiOXGdgrnVpJCAyDxZSQUh/V9/jFXsYFe65XMrM4NT
	A3gdK6Y8jqA9uRsEs8Ff8rP7o6f/KDSuSXxdCE+FOIW1vlKDruVewXi06PdXTxUpPmhoYWDxk0G
	rRkvUYUNwDajy9wh/2wmuE6tluccg8TMMAXr/KhUHLIc4WyrCqZ+CCO9rNCJa686ar4rPqu3SZR
	WQ7sasA=
X-Google-Smtp-Source: AGHT+IF2An5pDAZVb9/MWyUP0DaYrumqgTX24QmkS+YPaDLqPFaLEbPC4ywZvWfU/YeOBmq2oXhZoQ==
X-Received: by 2002:a05:6a20:3d86:b0:1e1:b1bb:87a0 with SMTP id adf61e73a8af0-1eb21591728mr52880822637.34.1737709131715;
        Fri, 24 Jan 2025 00:58:51 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ac48f897339sm979618a12.19.2025.01.24.00.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:51 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] cpufreq: cppc: Set policy->boost_supported
Date: Fri, 24 Jan 2025 14:28:10 +0530
Message-Id: <c744751c8f61cae509959270176ebdef77326ba2.1737707712.git.viresh.kumar@linaro.org>
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

With a later commit, the cpufreq core will call the ->set_boost()
callback only if the policy supports boost frequency. The
boost_supported flag is set by the cpufreq core if policy->freq_table is
set and one or more boost frequencies are present.

For other drivers, the flag must be set explicitly.

With this, the local variable boost_supported isn't required anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 7fa89b601d2a..08117fb9c1eb 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -34,8 +34,6 @@
  */
 static LIST_HEAD(cpu_data_list);
 
-static bool boost_supported;
-
 static struct cpufreq_driver cppc_cpufreq_driver;
 
 #ifdef CONFIG_ACPI_CPPC_CPUFREQ_FIE
@@ -653,7 +651,7 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	 * is supported.
 	 */
 	if (caps->highest_perf > caps->nominal_perf)
-		boost_supported = true;
+		policy->boost_supported = true;
 
 	/* Set policy->cur to max now. The governors will adjust later. */
 	policy->cur = cppc_perf_to_khz(caps, caps->highest_perf);
@@ -791,11 +789,6 @@ static int cppc_cpufreq_set_boost(struct cpufreq_policy *policy, int state)
 	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
 	int ret;
 
-	if (!boost_supported) {
-		pr_err("BOOST not supported by CPU or firmware\n");
-		return -EINVAL;
-	}
-
 	if (state)
 		policy->max = cppc_perf_to_khz(caps, caps->highest_perf);
 	else
-- 
2.31.1.272.g89b43f80a514


