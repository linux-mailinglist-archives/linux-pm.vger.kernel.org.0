Return-Path: <linux-pm+bounces-20931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6FA1B236
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D373816DAC3
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF821D58B;
	Fri, 24 Jan 2025 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xowX1gjQ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807721ADA7
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709160; cv=none; b=Sc0wVZsb6pUpstg1XXRGSdDOzKPpikOeGkM9ojBoCQQQrH6Likyw0ryOYefEdQrWgdXzPEmYzw4SBjuaV1IARYse4tjjOtOKdEq0hz7Kjw2VRxcSv7+Kz4Yt08Tat2NhZzvUVhfnZOnsmUciTUkr6JH6xQJNiUpw3qt5XySZqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709160; c=relaxed/simple;
	bh=/D0wEY8VdyUkeWsPm6hW6l3uuIlRBiW1w21cWrdjAPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pC8/h8jWFxgQR8UhPE2pw6MMhE9GRbE6WC97S74sTur6sy6LT3VK+Nok5/s6dfAr/MW8yeitZKQfB4M9BEt0T/9hYdTBjfZacNDAvOZrOxzqFUqc3JUxJZGgl5xSQSIa4BJLP/dV0awQAjO6xFv5xBV0CM8stVWSqt/fWfSym6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xowX1gjQ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so3315854a91.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709158; x=1738313958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VdfuIG9tkRoWMs45pN6MvWj7AvWDsc8epda9DxPI0Fs=;
        b=xowX1gjQC2USzCqyC9sXHS2mIvS1iUqz3q2G71awSOmHMTlNF7A2kX1xko/bLqbkVq
         JIWgoPGFV/9I6TiorK7+bSZmXCf2oCNTZ1ocAEPE8hCcu2TdUM8GJCGsAQtxVh5jt1Z2
         nqSoyEouc7xZWYM8jBO5KOXdmYuyMb4In6C4YZx5LmZhEG0k+4gGin4GZsrsQS5pr3li
         sqato9av/vL5Cvfo5Cx6DZD0Tq42XqhByIvXds+SJVgZw76azpX8QDCsthWoPvl1SpUn
         on/K9xttlvyLHUiWGnn7qggwHadX4NpuGT//mLL3Dwjf2cTBscmufVdaWDLmkl/q0mVo
         EOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709159; x=1738313959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdfuIG9tkRoWMs45pN6MvWj7AvWDsc8epda9DxPI0Fs=;
        b=sJqDOBZXRmRh8dD3coBBe8AYJmrWP6vq5W3FE5QRcLeHHsjZib/FYGeCzr5Q2CXYxr
         0958TdMS7KGvEGUtY6rrliAcKMSELPEWG/ksZAS4Gh4IysYMlu75kFT+P+Ti9EHEb/X4
         St8B2JZCdWaOnBqQ/ThJuhOyz33y1142x4Ykn3Tx1MAkHy4J2qTTJJy7/+Ap7eS2cZEr
         2RGcEq+vwrdh4MX9uw9QeM7sSWQHctSF31AduXGwcFBZns0na4ZcAbemiIaEYvvisFzj
         M+XHbYRvXGWxiekvWrIcmjUfYnebCFuoPN6hEqLkT/3CuWYLZerQJtbXyhO2TXKVz+XX
         YogA==
X-Gm-Message-State: AOJu0YzEZ3qRZXCi+tNPbjIWbZBqbxNB2+tnEBXrh0B9pxFfIoh38Lgf
	TkYIE5K3PP+jtofjvCQwU38gg6mBFiTdZ6bOIQMRyE+QUFee7kazDS0nRPQmzy8=
X-Gm-Gg: ASbGnctXOuqW5t57NzdE2hyASmRC2Z7NquHusD741ruI43mfle5o4tVakdMh/mm862m
	8rzZDBIwOgzDc9Ok42be6F5uLHpE2I+Uwj/HVAanifODQIrRVPIG0VkkWJAgY5P8XazNFVoSUeA
	d7wy0CZRv78TWCnViBxXq1Wthym2dN94pbeOGFyBZubqct7QStwdC3TrcbhPTYYKeoK7ed4aeXq
	Q92+EH3Y7hkU0spWlY5gTLUE3sTATq2ARf5EIKL/jqhShMT5XaeK7na+c6QtvFQx4plZk4P3vRP
	eID/kGA=
X-Google-Smtp-Source: AGHT+IFyETTLRpIP2DcDtY8Wno03W5rknQHs2W31kpnLpgPIWSJmax8BGf/jcQf027eMdfYyAmkCiw==
X-Received: by 2002:a17:90b:4c06:b0:2ee:7862:1b10 with SMTP id 98e67ed59e1d1-2f782c701f7mr44177780a91.11.1737709158729;
        Fri, 24 Jan 2025 00:59:18 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffaf80d1sm1246694a91.35.2025.01.24.00.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:59:18 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/15] cpufreq: staticize policy_has_boost_freq()
Date: Fri, 24 Jan 2025 14:28:18 +0530
Message-Id: <d03eed3f051a7694bbee89a7269813e78c12bcaa.1737707712.git.viresh.kumar@linaro.org>
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

policy_has_boost_freq() isn't used outside of freq_table.c now, mark it
static.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c | 3 +--
 include/linux/cpufreq.h      | 6 ------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 185070052b41..c03a91502f84 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -14,7 +14,7 @@
  *                     FREQUENCY TABLE HELPERS                       *
  *********************************************************************/
 
-bool policy_has_boost_freq(struct cpufreq_policy *policy)
+static bool policy_has_boost_freq(struct cpufreq_policy *policy)
 {
 	struct cpufreq_frequency_table *pos, *table = policy->freq_table;
 
@@ -27,7 +27,6 @@ bool policy_has_boost_freq(struct cpufreq_policy *policy)
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(policy_has_boost_freq);
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table)
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index b017af4398b9..466d186166da 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -783,7 +783,6 @@ ssize_t cpufreq_show_cpus(const struct cpumask *mask, char *buf);
 #ifdef CONFIG_CPU_FREQ
 bool cpufreq_boost_enabled(void);
 int cpufreq_enable_boost_support(void);
-bool policy_has_boost_freq(struct cpufreq_policy *policy);
 int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state);
 
 /* Find lowest freq at or above target in a table in ascending order */
@@ -1163,11 +1162,6 @@ static inline int cpufreq_enable_boost_support(void)
 	return -EINVAL;
 }
 
-static inline bool policy_has_boost_freq(struct cpufreq_policy *policy)
-{
-	return false;
-}
-
 static inline int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 {
 	return -EOPNOTSUPP;
-- 
2.31.1.272.g89b43f80a514


