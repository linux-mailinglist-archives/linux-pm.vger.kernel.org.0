Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D463E901D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbhHKMHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbhHKMHE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:07:04 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5801C06179C
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d17so2377424plr.12
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufOzb/yHm+Yy0muA4H19fAJdjtQW7OC7JUKwWc/tDWo=;
        b=C9FEmgjFCyHEUOJxkqjYRENiWra7tJpf8wDbmNI1upCMG/ARVHHAifgv/ZnJhTgg3R
         UaSyeUK7cR6CUQ7gEIpyBEmz0yZJronlHOtiOkhy8HTJD7HDIC2Egbkj2df8jpcjkiM6
         Z2lZ7INFiaX+paBNzkqx3ShGy+TEq9OidaoBaI7yyGw5VFP3//0mZJf5QJzBy++KNoO2
         002Y3ulPb+Sdez2kGgqsqteBtAqnSe5lBczDjfBDRIIc+8OkzvfMCAfZ7zSYCdT0TMhr
         9m5xhlK7Fhg1DzjpVeItxBu4kC1BGD145jv9p4RGy6I9KJPaTRPDi0ssLbPznIw88f89
         dWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufOzb/yHm+Yy0muA4H19fAJdjtQW7OC7JUKwWc/tDWo=;
        b=VBPWsiWp6/CL4+23D41cQEhSzyjP4u+UmmJLCGSg3vW+118D5OgzNqYnh8ZpwUmYG3
         x0N3Bbvp+g8CMHODIh/ch4qdZilUnU/RRFWJL90GhTUbTtF/Xg81Gtr1XU+k7APugFcv
         P8/oYtefn7Bq1wIj0STMtbY9JZwKrzpIYIgKcduutXln7z69ylGBRxlYc6hwAWXjrd9m
         TqO+wBDMKqEDO0K6QkcDcppzhy9XaXrn/05iHJjEQnHJzNaXonZ+GL8+YzSMC7kidYMq
         6nUVI8v1XB333OReJCF1escOZRZ1lJPzLC829/wtGEV8uFqwz8EWFa1PDUM5L5xc01Im
         Eg5w==
X-Gm-Message-State: AOAM532rEa9ggieR7l0qoX3QYdNN8UCeqRGTQ7YKTYG6/r+o4JTynB0e
        HXZSBwJUBL5dWXjrv/9R6IeB9g==
X-Google-Smtp-Source: ABdhPJxvHr2moebqTWeOc7YEmfRnU0PSE/Fg2Y67L6NrwCW1hpUZBTGwvdnIfENauclz5a7ivS6BNw==
X-Received: by 2002:aa7:8d0c:0:b029:3e0:2e32:3148 with SMTP id j12-20020aa78d0c0000b02903e02e323148mr2128487pfe.23.1628683600347;
        Wed, 11 Aug 2021 05:06:40 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id j18sm17649389pfc.98.2021.08.11.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 8/9] cpufreq: vexpress: Use auto-registration for energy model
Date:   Wed, 11 Aug 2021 17:28:46 +0530
Message-Id: <0bc6387893ea7215da658943ddaa2208f5f3e239.1628682874.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628682874.git.viresh.kumar@linaro.org>
References: <cover.1628682874.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Set the newly added .register_em() callback with
cpufreq_register_em_with_opp() to automatically register with the EM
core.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index ab56813b7256..284b6bd040b1 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -440,8 +440,6 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 	policy->freq_table = freq_table[cur_cluster];
 	policy->cpuinfo.transition_latency = 1000000; /* 1 ms */
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) =
 						clk_get_cpu_rate(policy->cpu);
@@ -475,6 +473,7 @@ static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.get			= ve_spc_cpufreq_get_rate,
 	.init			= ve_spc_cpufreq_init,
 	.exit			= ve_spc_cpufreq_exit,
+	.register_em		= cpufreq_register_em_with_opp,
 	.attr			= cpufreq_generic_attr,
 };
 
-- 
2.31.1.272.g89b43f80a514

