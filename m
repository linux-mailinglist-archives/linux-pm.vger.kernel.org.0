Return-Path: <linux-pm+bounces-20928-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0250A1B232
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 10:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224343AEA2E
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F621CA0B;
	Fri, 24 Jan 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HsnfOOv4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992121C9FB
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709150; cv=none; b=DcHnlrxDYSARNsLvW2eaK8arvYsC1Km2IBPuEi8n4h68n0qny4BHSp4FIOHidXUdRRirjG2xFJoHfpImzqnn1xqnUCkQEOgRK07ddpoKqienYYq+8BmynkgKFINX3WiJn73tfii/LptyhOifa9VZUz2KRoX0Y0B4sTFjs/BGlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709150; c=relaxed/simple;
	bh=NLORqzd35DVESYWY8n/o0RhRe7T7py6pVm8BHGxPOaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFMHNrYPFtn+s1j9r+T1cyfx82NlijR6BjLZ2zdpSX5ca13tUFxV2F5cNkZgoJDSCz16VxmxXtYR7G6VwnorLOcFFVfGlvRX5rSJLuTqKZeWGO2n2NyCrB4e6qOg4TuutBW2s68eOqnR3hFJWqSskoYUvXrOSwHobQjvD1zh/4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HsnfOOv4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2164b1f05caso31546625ad.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709148; x=1738313948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lzQ5jAgJPMOysDkyB7FBY4kIjh3CZ6BVNPDK8eFRq4=;
        b=HsnfOOv4K+rr0NVVkwoAWRR1eXorhoyLyeZFbl13o0LyDn2C1qMJM0oMMsA2JbJqRQ
         G5BcslORGTCDOSBZ/mDZsfPzfnQm0KSaJeUKJNr43/UP1VxApYj+cahQrmP/O33OaqZi
         M0l/5507yLQj8z/twAr0at7J9HU4d/vmMepvG8BUO5VHfEVx+1u5bIZf9tfuDc+jS9pj
         yZIbwN67Kat93Q4CQUvPFUMWnsaJ9qYyxCzmNQ5+t4U67JQRjCbQxNllojJDpUr0AbFY
         URqeWyPUV3Rslf3Edfr/b3uuq+fykH0CvpbvE+f2rZy3pk4wYoCd3ifBVwb2FhUI2G2J
         0HzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709148; x=1738313948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lzQ5jAgJPMOysDkyB7FBY4kIjh3CZ6BVNPDK8eFRq4=;
        b=w2ZXbWUtII9n5GFWUbctqV57fpu7i4RxQvYW0w04A5nicYZKiUCoqms4RTx3o9g4MJ
         7fAz3V1IduXwq2CqzBb4yI9qm5mBjP60qjEhMXpBvfFQW+j+qXLtKP8Yx0M339cDUqPB
         l7vBrpZDYw6iFvfaukU8Bzqs79d9VQ20OzNysxPJktFfv/TteNfvLrh2dK+zpYtP/YTQ
         IFcrK1sP4Lbe7JCHK8RMxi8JlUniOgRmO5UxBvtar1G37rAGGqw928ICa+wFRuKTRGAG
         T6ofAhgM/XtrRglxvvLB3NucxSwX8Y1mYu9Jajf6QC6+cfsW3Z+ZlaoljGsw4kPOwBPR
         nstQ==
X-Gm-Message-State: AOJu0Ywh0/wxNobGiRRL/SGpqFf/zFJxIAs8n+5tqM2nz4yMDWe3oCDw
	EEnMxonpayhNWCOrTZwHfQQ1fxskr8OuHCdUfaYtINxlVVOaxn1MUxp3wPNcDFA=
X-Gm-Gg: ASbGncsjkae1w82UBlSlZkpJJdEzuKI0t1blDXlI0SGUbBKpZOGy6tX7Bpq+Mrk4At1
	PKlOI86OrqPaXCOua47tiJ/3oZhEMDVhDfiAGgY7jxlH0S+Ty23Dv14y0dPRrQGdv9qDAKHjA+L
	lLfjPem14mL+e7k4ARlz63wyS4HYnHgIFw0FFOZsBWqQ+Jk/23RVDn7rJR6RmG50UqTAvTM8JGJ
	6SE/GhLnpr9nIlLoCYUNNZb0Z/olacufEBytw+c4a9qzn+dtyRwjrZ0jYPVjEqR4j1nLiLsf1cu
	0ZSk8NM=
X-Google-Smtp-Source: AGHT+IFW/BLYxcm27YoFLdxNsrAZiy/t9OXPfZRg22Xfepty1UtE6fjh27SK8kn9i9L/O6GYWvG4GQ==
X-Received: by 2002:a17:902:cf0b:b0:216:2af7:a2a3 with SMTP id d9443c01a7336-21c3560726cmr494020895ad.53.1737709147994;
        Fri, 24 Jan 2025 00:59:07 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3d9c55dsm11824845ad.10.2025.01.24.00.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:59:07 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] cpufreq: scmi: Set .set_boost directly
Date: Fri, 24 Jan 2025 14:28:15 +0530
Message-Id: <ec27aef491c1b71ef5f1240480c52d051cdd821d.1737707712.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/scmi-cpufreq.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 4a3ee59cb771..ff2897789797 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -297,16 +297,6 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	policy->transition_delay_us =
 		scmi_get_rate_limit(domain, policy->fast_switch_possible);
 
-	if (policy_has_boost_freq(policy)) {
-		ret = cpufreq_enable_boost_support();
-		if (ret) {
-			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
-			goto out_free_table;
-		} else {
-			scmi_cpufreq_driver.boost_enabled = true;
-		}
-	}
-
 	ret = freq_qos_add_request(&policy->constraints, &priv->limits_freq_req, FREQ_QOS_MAX,
 				   FREQ_QOS_MAX_DEFAULT_VALUE);
 	if (ret < 0) {
@@ -394,6 +384,7 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.init	= scmi_cpufreq_init,
 	.exit	= scmi_cpufreq_exit,
 	.register_em	= scmi_cpufreq_register_em,
+	.set_boost	= cpufreq_boost_set_sw,
 };
 
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
-- 
2.31.1.272.g89b43f80a514


