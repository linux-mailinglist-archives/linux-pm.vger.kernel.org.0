Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51CA283136
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 09:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgJEH4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 03:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJEH4p (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 03:56:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149AC0613CE
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 00:56:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gm14so5534675pjb.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jct6+w41xsh8CGOaC++VC9dJ8A2Tl3u2I+mZjVCHvk8=;
        b=mbbRT7rBAgV6ecbWTKavQBOpoE061Jv30DV4WDRfOKAEwqdwF2OmQOEmOaDICv1BJT
         +Gvz93OLc6VYyBmQg5LXqc7llRYR/YvUBFRKZHn2iAwyv1edkhWl9T2ExRO68EliXHVW
         O4958C1O5gJs2OMZJ8GnFeOltptVtvQAeCzh3WI+BzOafBdWckIt+bpnvAsFNAWljAI7
         p4oRUsDPTQm6Dc5ImYfWwLdqLCL4d57nMeaZieNC3j7Dwlggj1824G2i/Gdfx334VWt/
         r4WWaZIMZivJQtTTdqSan9qOjgLnPKfpUd+Aowb8+fzZJvN9n5hB85M50jGDEtlz/Ndl
         XypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jct6+w41xsh8CGOaC++VC9dJ8A2Tl3u2I+mZjVCHvk8=;
        b=jwCerBAEJRGBSxeVHlGC6/SLGXPaoiPCHt+8kB9d8ut9yzflAbfdtUlMfdtoyCpVN/
         JiK0ZaipO1v2benLILP1AOTutpUcUGlIEfYO+zU92xXeRNjSfDWkWB/twGDsW0/exswb
         4f4ZvDFgpK+LuPf1b09bNtR5pdgIbbvtoDkquFIpHNJn1H/AdAhZaHreWIJ9JUoyZugh
         Gq5eUPEVxbEtjZ2bOSNrN1cwgynAtk4XP0lS3/wY3nb0wldz4XqXGyCETLTotARM6Ny1
         5e2RqaUnSMAD8vuWRq9oinplrk+8neToN/UHMfN8XvAixdC84b9RYtzpj4D/YF+1WbPn
         614A==
X-Gm-Message-State: AOAM533zNYrbDVstkALPOdhpxgjj2dbd0o2AWQF/Bu0R2x6PS9MA05G6
        mFPr4/e+gLXQ5ABHFWBJXHiOyg==
X-Google-Smtp-Source: ABdhPJwKZw+tKzueEcGgKMntoiwcfsTBTbjXiDNLJVhPXK9CMi28XfybBWUwf7tDphMpOuDMzYDZOw==
X-Received: by 2002:a17:90b:1902:: with SMTP id mp2mr16335709pjb.176.1601884604738;
        Mon, 05 Oct 2020 00:56:44 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id j12sm9792366pjd.36.2020.10.05.00.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 00:56:44 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V3 4/5] cpufreq: stats: Enable stats for fast-switch as well
Date:   Mon,  5 Oct 2020 13:26:04 +0530
Message-Id: <2773c97ebdbd86b58b5577f6d060110a21b23e29.1601884370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1601884370.git.viresh.kumar@linaro.org>
References: <cover.1601884370.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that all the blockers are gone for enabling stats in fast-switching
case, enable it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c       | 4 ++++
 drivers/cpufreq/cpufreq_stats.c | 6 ------
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 2ea245a6c0c0..2d0e2e464b14 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2072,8 +2072,12 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
 	freq = cpufreq_driver->fast_switch(policy, target_freq);
 
+	if (!freq)
+		return 0;
+
 	arch_set_freq_scale(policy->related_cpus, freq,
 			    policy->cpuinfo.max_freq);
+	cpufreq_stats_record_transition(policy, freq);
 
 	return freq;
 }
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index bba04da3a278..8e7d64f34041 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -69,9 +69,6 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i;
 
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	for (i = 0; i < stats->state_num; i++) {
 		if (pending) {
 			if (i == stats->last_index)
@@ -115,9 +112,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i, j, count;
 
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-- 
2.25.0.rc1.19.g042ed3e048af

