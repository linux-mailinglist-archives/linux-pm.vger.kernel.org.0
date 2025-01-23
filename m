Return-Path: <linux-pm+bounces-20857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A85A1A358
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C5E163F0F
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DE321638B;
	Thu, 23 Jan 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlMEm15d"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170E2215F4F
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632354; cv=none; b=doRz6ClyU7LtzD/ik0xDOqpgcfSzEhGo4jMVcypQiTjFu0cyOr0Fsk7c5l62BesL3w3cKgPrGpi+P45Ka7tjzgt8HF2GDtmvPaYMRtWBXfBCzHF24QOQy7mizVZTRXUuQ6wDluIcNRQJzswS+h/kMhX5Wy+ku1Pt/sq6YzL93LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632354; c=relaxed/simple;
	bh=0vuFyrpowJWXJ+EgmQo075OCUAokbqO688arZlJgNwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZuFX72xgwYEjNOsw5PO57lBBFmpRYkc917QPXyquuAkh4zUWUjGWalt4ibYTbsSOcsWl60cPfB2reFTIKgQPXoJMHuXwE6WQTmUqxIQQ7zHvqautxP7nrcBS5DxFvbMj/R1CGXjX8pBM1BIXeDmeh0XCAOrjNfoL17Lv9F3nujA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HlMEm15d; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21628b3fe7dso11907425ad.3
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632352; x=1738237152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfFWpe84qglq/TtVYEMV6ZHL0gX6mGnPHNUCBfXIIJs=;
        b=HlMEm15dy4WZlJDIFyZD3ccFVVQ8zml48ro3I4mFTiykgduqdehXhBkf50wkI6lDyR
         tUXp1EpGnwNGRs/1sD98wnosfM/CT4CgLF7StQE7/MF+U0B4B97xyxfTGqj04lSFfmSh
         oA9mt3ONYLMMGYWwtEVyIlLviAuFB3gOAbVu1SwBRwtIbG7191lRpubwP1G6Iomhp07S
         UOi06IDJNlN/Q0cOuQOA1cJkwnc9QOwAINH1Th/l3f75AGgcOzCacgM5TrI+pVaFWmPJ
         7oAWddiKxJOrVEKPiyA1UyvjGzyJLuaEv0AU5WjQmD+zG6iDNBvnLi4wGcuKOGH89oc0
         ZVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632352; x=1738237152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfFWpe84qglq/TtVYEMV6ZHL0gX6mGnPHNUCBfXIIJs=;
        b=IZKrSw7Tc61N8bFZCwS4QeflRCKw4Ilv8iKH1EXhR6Y6Ks+Ol/eavnar+we5XgTty0
         mhRNMP2uarFlyfD6fcNHh4SqrEPRyDmSBtZbSQgEGpM6h+ts3CZwWFPOmQbfINRlmH32
         yoyCFkUGlRj882GhzAJD1HD4T1Zvccy1y8ox9vkrdJR0T6Mll84b27R0sYFrdQNdv8ZV
         ksgp7wx8VWpaMg2Thp5cy4+WuRNTvT/t3/v/tjg1X6uULfqbysAEtvAl2MwNCfKI2cZB
         8QqDq9cUvQkT9StrjLDOUafnKubhw0y7cKlrD2PerfEcL5W0VfKhg2tPLW0PYfSVmFOc
         3kCA==
X-Gm-Message-State: AOJu0YzNRAEySKHewVlGw3+VfvVwujMq5au0N9mR4q+DNPZc62+bMY7L
	0/xaA/gJDKEY1RnGO8Ae6OxNgqNGFdPNNx639KDtfSJX7ynxUCm/uKETCtI7KXQ=
X-Gm-Gg: ASbGncvctE4wuB+jJhX6qErCej4VQK991SZHf69phs+lSSF/zjv4/o7OAXVT20TAuj7
	CRBjy4onHkc2VhyaXFPP0i4OA2GQGLCdxAi4eHNbsYoTuV5W1cYS5VmFeUbT8xFEK3RUIG5mrX9
	+WD01VcXDYsRi7A16myToU7+n/7X/dyj+8jqh78/gH6Qq6NIJl1g+q5nxGupBxCEvEJt0CVO8GU
	Hh2UfyFb6v5NzvLdVrAqiWbN7fnm6KITMWwmOPOWEreomEpv5Aw8tmPmZPqos2uyxPqMICu0T3m
	1n55Ga0=
X-Google-Smtp-Source: AGHT+IHlclUl4YrIQK3CJ0/Pzuudje5vfVTFEO6w99Udj/Vlk9RQblNRiPVYs/2jxiDc+XWZQoS5zQ==
X-Received: by 2002:a05:6a00:2e9e:b0:725:e1de:c0bf with SMTP id d2e1a72fcca58-72daf9483fdmr33058325b3a.9.1737632352436;
        Thu, 23 Jan 2025 03:39:12 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f1ae0sm12995670b3a.24.2025.01.23.03.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:11 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/33] cpufreq: qcom: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:05:57 +0530
Message-Id: <2e582722386a1ea89ecd8b174e758e054da86555.1737631669.git.viresh.kumar@linaro.org>
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

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index b2e7e89feaac..7d83d7d2ccc8 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -595,12 +595,6 @@ static void qcom_cpufreq_ready(struct cpufreq_policy *policy)
 		enable_irq(data->throttle_irq);
 }
 
-static struct freq_attr *qcom_cpufreq_hw_attr[] = {
-	&cpufreq_freq_attr_scaling_available_freqs,
-	&cpufreq_freq_attr_scaling_boost_freqs,
-	NULL
-};
-
 static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.flags		= CPUFREQ_NEED_INITIAL_FREQ_CHECK |
 			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
@@ -615,7 +609,6 @@ static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.register_em	= cpufreq_register_em_with_opp,
 	.fast_switch    = qcom_cpufreq_hw_fast_switch,
 	.name		= "qcom-cpufreq-hw",
-	.attr		= qcom_cpufreq_hw_attr,
 	.ready		= qcom_cpufreq_ready,
 };
 
-- 
2.31.1.272.g89b43f80a514


