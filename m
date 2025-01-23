Return-Path: <linux-pm+bounces-20868-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F73A1A375
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF1E3AFF32
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D556217F5C;
	Thu, 23 Jan 2025 11:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZzezXR6B"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B94F2185B4
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632392; cv=none; b=QFKBLsi8RMY58tsCcm5RAaf9BH6IFk3ePanp8qPIXGRgGEZxE0F8QN1mZ8DvPscX1kcO3lSLe5egeNlx9cXPSyAQ3CgXVS4VMz7s2iD2z4mD48Bc6oZnzLo7hJzOJE/TZdPvxwXWNk8NLx3IP5Jl/M8okeeSLiYG70Qx3U4y73A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632392; c=relaxed/simple;
	bh=g+5UVqausj/S8woGbcTzNjS7nHTJDZhAgMiqGXmWZmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CC1WZfkS8PS3O3BUnVnWvD5YWUlX0/5EsP7Z9D8v7PlPKNSjGMIQAmPAWuIGbAnoF/Dh5wKide2E79VIBgcEpsW4smCXSJJJkqhWzN1uNiNARjYvdYcWEVL4f/o2I3hPzpfgoaWCzkazrChGtWML77+o/7cD4TxzeU7vLtlEaVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZzezXR6B; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2f44353649aso1177503a91.0
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632390; x=1738237190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xwCpKJU9BK4nLoeDO8+WP0VYX3zsmqzC41yjD4cUd20=;
        b=ZzezXR6BPa/iKZTmBD4hmgNHukexJmybhX672kjnnMxLf4NFODTbBvZe+1E7QNj6Tz
         m72o80h4JubbFX3icdYAg81SZ03Y9g8UYKvvF+MAn0HS/QrLMJrC1JMNuYW7xIjJT0of
         RY1emHo0Zk/ln1QyBE4A/FafbjEGptj6r2Zjm7NEHQZoy3ZKo7U6vlnN66Yx4FQNodW+
         3P/re0U3JNpAgNNP9GD9Qbiyxdn1SN0gc82maYJ9nhveMRIrw+Nm08g9Wuw2ekatooA4
         1W2fGh7ff+JVccJBgzwYlDQASmAaR0lsJW8srGeRn7bJJ7Vu/hNSPfDJKAYdFuffGUrg
         c6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632390; x=1738237190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwCpKJU9BK4nLoeDO8+WP0VYX3zsmqzC41yjD4cUd20=;
        b=N6xwScvI5tCCpunWGi8LErgbmH12koZI2NNU52AcyKOnGRoio5B5w12aLpyWEWhCIS
         Cr0sh53OX2dae0syAtoXsW/RclNdSQ6X/wIR7xZsy8mO8UbAD5vzRSAe+SSb0B01msKX
         tKi02oZGzo/6vxv/pn1bRjI6gsHlCx3mj194sXNhRhQrU5NgPYtysnkjF7o+AxP5dhZI
         nEJtU2is4idmshY7XFjJqfnGCPqLr5qEDD2WXQjR3CbCesYfLvhLub8mSW/bgn87QCRp
         BVu8nJJ/pbeMRPs8SBK9vYT8mQUsiXNGQSdCINkKGP7FIeSu5+41qSUmdVI6sssYI//P
         2AEQ==
X-Gm-Message-State: AOJu0YxlK+XwJK1MDosDO4l/b/sHLFLvg8XqOrw9iioPudWhogRFOXVR
	8LXolC84cOz0Cb75/CROGlD/3wQAe5btDu/cfbE3CS3TxMrrXVlyjDL9uFYKtYOba87taNRyS5I
	K
X-Gm-Gg: ASbGncu6suW2Q4pB/VR3NmHN0jyoR/OcqVKWkbt269MpDexW5wW+LFRPFabYSqerBtd
	n34m+DxbPpht9QYcK50AbbfQDZAJO15/I6dSa46JeGljU8uAi6n7/xWBj/LT1ELniT6dwqJVCXJ
	p0A7PFCYI8Ksbr2Z0R4odQfkOPAOcOERXmwp/nekC7EWERzhrm16oGqZrkk9/HKOTJIVvQWfpKC
	X2fdcXBJgZLWl6QZ1rz+SIHjgg8QBB0Hl/Dx/AhQFRjJ1IcnYmbrLPzSIb7gjsPcmrVdZvcxTM2
	SKMvZLo=
X-Google-Smtp-Source: AGHT+IFnn97+a1tkcc7DZeADa5XTR/Mpm+78sHyqxcLkkY3EK29mqG5VL6REvWToDBoEwVhzHSt/FQ==
X-Received: by 2002:a05:6a00:1813:b0:729:cc5:fa42 with SMTP id d2e1a72fcca58-72dafbaa1c1mr38126960b3a.20.1737632389842;
        Thu, 23 Jan 2025 03:39:49 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab817a4dsm13161894b3a.61.2025.01.23.03.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:49 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 32/33] cpufreq: Remove cpufreq_generic_attrs
Date: Thu, 23 Jan 2025 17:06:08 +0530
Message-Id: <07c4420e1f3e7956e77dba34e35427f156d23c5c.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of cpufreq_generic_attr are migrated now, remove it. While at
it, also stop exporting attributes for available and boost frequencies
as they are only used by cpufreq core now.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/freq_table.c | 8 --------
 include/linux/cpufreq.h      | 1 -
 2 files changed, 9 deletions(-)

diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 10e80d912b8d..16e56f2fcee4 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -276,7 +276,6 @@ static ssize_t scaling_available_frequencies_show(struct cpufreq_policy *policy,
 	return show_available_freqs(policy, buf, false);
 }
 cpufreq_attr_available_freq(scaling_available);
-EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
 
 /*
  * scaling_boost_frequencies_show - show available boost frequencies for
@@ -288,13 +287,6 @@ static ssize_t scaling_boost_frequencies_show(struct cpufreq_policy *policy,
 	return show_available_freqs(policy, buf, true);
 }
 cpufreq_attr_available_freq(scaling_boost);
-EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_boost_freqs);
-
-struct freq_attr *cpufreq_generic_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	NULL,
-};
-EXPORT_SYMBOL_GPL(cpufreq_generic_attr);
 
 static int set_freq_table_sorted(struct cpufreq_policy *policy)
 {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 7fe0981a7e46..d237ef91d1f1 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1198,7 +1198,6 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-extern struct freq_attr *cpufreq_generic_attr[];
 int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy);
 
 unsigned int cpufreq_generic_get(unsigned int cpu);
-- 
2.31.1.272.g89b43f80a514


