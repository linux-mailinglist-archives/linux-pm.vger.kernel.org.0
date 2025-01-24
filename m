Return-Path: <linux-pm+bounces-20922-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE56A1B222
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD141889E15
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 08:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F0D21ADBC;
	Fri, 24 Jan 2025 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WdFB/YXQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202C21B199
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709130; cv=none; b=jkq0VkT94rc7DENL544ieiWvnH3txagNc2VjAlN51VCmsPPx9Dwwn+hKPXUEVR9DZ8Ca/Ib/O6UkZaHuSekvd/B0jlUk+p5AUo9qczT2ADIgrP5jcJDg8HLjbMzhdwfWfmB5cIO3zlNUzzOXCqD1wVw1xoN5cAiKsz27eSG/oLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709130; c=relaxed/simple;
	bh=6mXBnkUYkeuCFPL7Gkqa0yz5ytnNiILKmJ2qkF9krL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V6wwWAltLZfxJsFRReS0o/kvWWmapePfui0/kbla549aOZSV0OzrAemNMlAOyJJ/XlJ+j1ZqPzRj+5PaxhCPcdX1Nq9lzHtMTM3AsvU3Vzu63tlJbibwHXVrgVA7ehqdu86nt61j7T5+JLYFi9fddUXIjn+GZmZGKNivdKGYG+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WdFB/YXQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso2633432a91.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709128; x=1738313928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+Dv/xS0EPUQsWWYtMVVK6x6Cs/IySXp4CbRL6B8jQM=;
        b=WdFB/YXQ0kkJTEmk2xUwV5E9L4kl/R1ym9xPVxXhfIcNdgC8smu6Xze/1frkY4N0JB
         rHl92JRpyT3BDpB3QCx5txTfjKJ/8A6t8+LpVYnYVeURVP2OCVcfkEYtI/bnN4mQ32PN
         DOyGJV+yw9y6+76hjeAbecsemYbh5E9udP8O5+F0JFcQIf8TL2yi0p4a9tQE7cnFJubw
         qIyOrDXoehmyH3dfrDxeoospZdbONZs03NNXtolTKfA8pmiNONINMSCQFEBMA+3dHUHV
         UFpqD19WRySx8INQNzdriYDtKlSzQRUDuGza0sUcEWQVU1kHDAoRaabG25nCbJlpqyZL
         bamw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709128; x=1738313928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+Dv/xS0EPUQsWWYtMVVK6x6Cs/IySXp4CbRL6B8jQM=;
        b=X3OTSLE8iTNe/t5Pb1BK0o2RUbgAj3MdW7B7nLd2EHG3kcPTOtRZlXupFDzZbL/3By
         2vocbrLM+M6CIdpOaDWtoyLVYbCMAPXr+SX2cdG1WQkG+5H3Ooy8kjctc4XcoROq3Pvr
         XuGUqLT1SLpI4p3kW7CAeoiT6+zxgm0cZl47tplOgm2NNJO1Oo6b4eQxgQ0mdkyjKvs3
         LU9UKYkVvp+n4AFg1ZoAEKBQYS6oQgI0XojHhJ+M8oTcrgOkcXYyWbjH/LF22JSKOPj3
         RUbR2YJXAllVZkrtB7QDlTLFB9JOpSkLhCsrC/5dHK0sNiEKdl6+NyisRX9ONJaRTzhj
         SiLQ==
X-Gm-Message-State: AOJu0Yxsj+jFgw/1OTyBv6x3I9M1V7dOs/SvsDZMrlc0oNwc1PTO5Vy6
	ZRrgnE8l4JaBSNKcKpckXRXQjpQM/4pN3SUzBYUnF+F9WhvqfHSzmYN8l1UxcRk=
X-Gm-Gg: ASbGncsUg4iGUTH4cP9HP6WYvKeTKmDyWIsT4sy2MSLL88qdjcdqUwUKjH5LYU3i3gj
	gqBNPavLexBOhN1Jyco67xkNtbe6wHPSEMEdcl4gReIsPTfZbk/Y5EnkeeQQZAvLnbpbU5qDDuH
	G6q/BEnuP4msJ3aTDcri6XsIJkHuTzlKGkW3EfwdTt1vYxMN9itnoE+/VIfSoX0wSkPUI3BO+FT
	ZKuQ1uD5QW/DewVr7Kxy3VSiZVxuwYw2NlDv+BPUO3muUKN1e9AaO2ccHqVWY93ENc6EMvOmWJh
	qcpINHA=
X-Google-Smtp-Source: AGHT+IFgVqVjXeoB+9lH1lr6zg3WDC0Dl91MBuKayllLk60pxLtupa56Fvtz004QWNAnoT5ZmnXGvA==
X-Received: by 2002:a17:90b:3cd0:b0:2ea:4578:46d8 with SMTP id 98e67ed59e1d1-2f782c77989mr43705871a91.9.1737709128279;
        Fri, 24 Jan 2025 00:58:48 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7e3672e1bsm1454047a91.0.2025.01.24.00.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:47 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] cpufreq: amd: Set policy->boost_supported
Date: Fri, 24 Jan 2025 14:28:09 +0530
Message-Id: <e16c06d4b8ffdb20e802ffe648f14dc515e60426.1737707712.git.viresh.kumar@linaro.org>
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

The policy->boost_enabled flag is set by the cpufreq core once the
policy is initialized, don't set it anymore.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/amd-pstate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7630bab2516..8d3cc494c92c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -995,7 +995,7 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.min_freq = min_freq;
 	policy->cpuinfo.max_freq = max_freq;
 
-	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
+	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
 
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
@@ -1480,7 +1480,7 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	policy->min = policy->cpuinfo.min_freq;
 	policy->max = policy->cpuinfo.max_freq;
 
-	policy->boost_enabled = READ_ONCE(cpudata->boost_supported);
+	policy->boost_supported = READ_ONCE(cpudata->boost_supported);
 
 	/*
 	 * Set the policy to provide a valid fallback value in case
-- 
2.31.1.272.g89b43f80a514


