Return-Path: <linux-pm+bounces-25889-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9786BA96528
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 11:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4613BB24A
	for <lists+linux-pm@lfdr.de>; Tue, 22 Apr 2025 09:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2115821B9D9;
	Tue, 22 Apr 2025 09:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUKu4uJY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67D217701
	for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745315663; cv=none; b=MR1JOs2CmLHa6q1Cn4xlOmKkAisBScTqtTGJtnmrH44lFQeTQ5riIp2Pk9IHzaolpAS7kRmL5vTaxDf1bFlgDn6rXKnQgEdZ+LzdEWsoPDLLMyQP4FJ9BNrhnvrsfNlxRqoeUMLy3ImGovDxJN3LsDzjLwIwUZpF5BeayiLjSMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745315663; c=relaxed/simple;
	bh=cVq4c4NXGO0/VRDBrGImjhxsKCiirGO3AQu1B/IYzYM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=joabf1ytxz5/XSppZsPytjQ3QEWS3WufsNnQW3OAz3MPkkjM+RweiSjcY7lW4h+1JVnvsMTYZdhBNk/KlG8HdtpVv5xtW7lguHW3GmEjRirq3DI97e8hfyIuWZloaO0MVxh9M6+zcwGJkwrTu1g95OxinNUtgsPLg0jqGpp18M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUKu4uJY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22c33e5013aso55314565ad.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Apr 2025 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745315661; x=1745920461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL1kGrQ7pxuW+GJmcKXt495d/ijkj0h7CpDbYSylQOg=;
        b=fUKu4uJY24/vIz/k4INH6gCfqJeNyaN0tICWa+SEpHetPJTnUteeSFdY4HBemKdDdq
         MeKB9u6H5M0W4QqypC2MRtgQHszrccpmBnbHvuxGHvDOwnCTgNzcIiRInqdVt8xpeC3Q
         AHCsb5GG1wrvX5ds4Jukl2EoC+WH5yvccZ6o5mJH1rblYHmfGLITT9TTPglcW8jRgm39
         iEl2dK7PjGk5+YDC5mE6DPRY7XvnQw5+qf8wiJuPWRB6+2YP9RIhpdusCsm5dR8SobkZ
         tgJ8wCpV9G7rulpbOUboFOfHwxxN7yu1Fb9gauyJkQ3jw5X93sWM2u4xYMspP1Wo3Z4e
         M7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745315661; x=1745920461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL1kGrQ7pxuW+GJmcKXt495d/ijkj0h7CpDbYSylQOg=;
        b=SVuyJ58OFez2xLgh1gb8MnqVZe7XEY9RQISwr0koVCx3gROgcHYnrTNh/kBiQApKTm
         yg9kYv1P0YYmUPHitQ2GTkIhVw27RcXN19ak5T4/nCWQ2n5xPQRl7twC/dZT0sv9u7/S
         3sJVvP9WJQMwSUD9/fEocnk4mvuCPAjVgEChpbqm/bLklj/BB/1JgQQD9qFaLcHi5M7a
         E/AvhsvOwkxuvJ3BaphiKgPdlF1lPiC/KTSu21xobZfFoo7+2lnsBABxQfDOEgChK8t4
         jN+e3DV6xG1Wj4FpI10qgp3NI9MxHTbY7GrAYNewY2PkKQMM/sybTOUUe4nlHA66IbRt
         OA2A==
X-Gm-Message-State: AOJu0Yw/dJFD8BHlKXIO+djjDskgMDgOLmyvXHYrdQuqKDB0TH4vS6gF
	okJuW19qw/AETSxxKFTkJEvhkAr1PenW5A/OoUPdhoNtk1sVpzwBUJhsY2Lp7io=
X-Gm-Gg: ASbGncv2YVwGhzPHtVT9OLmAI8YWtyB/N7ZmXMzinj0jyc+P+RU+HlgVytooiI+M6se
	q39Gwv8CgQs2PzaVlmcbgBQjAyJ2V8lbw0VvexEUc1L3mjaCbN2KsnCUMYZ2HjYfbdtRGEMGSS8
	xJAO43zwC2D2CAlPhqo656UJTU0DaXqNT0rz+8rJw+y7N1LbulZHYhg6uIC0tw7azUHBjRySFne
	8kZ6oawnMWhGlX7PKL8pY3XuaKLdJYZz+Yyehj0srIGQP5MWGVMS9CwyPQplV/QmcTDQ+XTGd5s
	qng6O7TKHJkH6ryiLMz8cmgZ87Syz16JGU183PQN8A==
X-Google-Smtp-Source: AGHT+IE/mIyh+fwUIcGlS3NjRNjJYXWPWCmv1heiExkWyxbfPD18Am5wJjrUdBt38apOdY3phcgTJw==
X-Received: by 2002:a17:903:986:b0:224:e33:889b with SMTP id d9443c01a7336-22c5359a406mr246903215ad.12.1745315660864;
        Tue, 22 Apr 2025 02:54:20 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bf2548sm81060525ad.64.2025.04.22.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 02:54:20 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] cpufreq: Preserve policy's boost state after resume
Date: Tue, 22 Apr 2025 15:23:55 +0530
Message-Id: <c4b9640ab104690c78766bcac6b047f72374b09b.1745315548.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745315548.git.viresh.kumar@linaro.org>
References: <cover.1745315548.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the global boost flag was enabled and policy boost flag was disabled
before a suspend resume cycle, cpufreq_online() will enable the policy
boost flag on resume.

While it is important for the policy boost flag to mirror the global
boost flag when a policy is first created, it should be avoided when the
policy is reinitialized (for example after a suspend resume cycle).

Though, if the global boost flag is disabled at this point of time, we
want to make sure policy boost flag is disabled too.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 24745088403b..0ad459bc8f84 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1626,8 +1626,13 @@ static int cpufreq_online(unsigned int cpu)
 	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
-	/* Let the per-policy boost flag mirror the cpufreq_driver boost during init */
-	if (cpufreq_driver->set_boost && policy->boost_supported) {
+	/*
+	 * Let the per-policy boost flag mirror the cpufreq_driver boost during
+	 * initialization for a new policy. For an existing policy, maintain the
+	 * previous boost value unless global boost is disabled.
+	 */
+	if (cpufreq_driver->set_boost && policy->boost_supported &&
+	    (new_policy || !cpufreq_boost_enabled())) {
 		ret = policy_set_boost(policy, cpufreq_boost_enabled());
 		if (ret) {
 			/* If the set_boost fails, the online operation is not affected */
-- 
2.31.1.272.g89b43f80a514


