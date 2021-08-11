Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE683E9013
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 14:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbhHKMGp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbhHKMGo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Aug 2021 08:06:44 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2EFC061765
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id l11so2407722plk.6
        for <linux-pm@vger.kernel.org>; Wed, 11 Aug 2021 05:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjqWWeUctts4V9t7V1TVNNowsy6/ZHXWitYbSRTUDSc=;
        b=GDcrWYD/meMGdmLUcwRP+ZSS1yHCTBfETzpliLc0BUmSRq1VDCDFIdqogWXghBAXhy
         GGpoLbqpYOnvSOL70DilcmuBjmb7CQV+pUCwpHHftCTKSy30gAZv+ksKZPLnUACmonjQ
         t5Out2pAzeJpd3jQEunHadrC0ZZVPadZyLS+UfVDzTIOC+UxnZHvJwYDK19eVfvQQh44
         az45xkP3tRAD8a4eJIRfA2Qq83zJ1pab59IGeIUCUIBkrlU1fsm/HREzVPTGgW/JLLaB
         sdIHBvnVWgFslF2UDmdbia8Rmnp2Hm/jkH6/IkgTv37+QdCX35BzvaujNkenzDVcAfu3
         ADOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjqWWeUctts4V9t7V1TVNNowsy6/ZHXWitYbSRTUDSc=;
        b=W2Vn/y2JL8bwxn0DkOQTbSnoOY3sM/POugfTnIaIeVmHLsESX8h86kTi4Loc2ANvON
         i4xDMt+eQ2pvN9sFDBco3hMtjaypzZ68ygi5SXeZmQ44+N3cnRh5HXVYiQe3LThTYC3T
         99JgahBoKu2jOCA/0pLsTWpHfXP0GipZLn8phAN8de1fi+HBmJAmQdjq+lzMLy0RGoGW
         XUVPqAXehnWDod+JhsQ5lRbc9CgRIi7Nj2ZubNDzRSwzThjpw3bF6cGT8GYcLahnvjX0
         NwdDM1zP5BrPPIA3xhfQ6DizBLNlcAjP+zYyuAQeKA1zsDFQSSw8vXx11VmS7ILSJ5af
         qQPQ==
X-Gm-Message-State: AOAM530yZkdglNmzVgE+IfPf+VQtSwKX25F4GfbKBQ9zzKcMrz9xQtx/
        HysPWSqxvBwToVeIjC9OxO34zbjnkmY9oA==
X-Google-Smtp-Source: ABdhPJz8YJaqy0c5L6KSSSTQodTYJuUwWHYvMebuQ86pMTvGyEC4+mDDEuRI3DxvTqT1kzuWmVDn6A==
X-Received: by 2002:a65:5bc9:: with SMTP id o9mr107174pgr.24.1628683580894;
        Wed, 11 Aug 2021 05:06:20 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id s31sm33016791pgm.27.2021.08.11.05.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 05:06:20 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Quentin Perret <qperret@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/9] cpufreq: dt: Use auto-registration for energy model
Date:   Wed, 11 Aug 2021 17:28:40 +0530
Message-Id: <8c7478a9aa26740448539e9fdaba22789cb28287.1628682874.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/cpufreq-dt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index ece52863ba62..8fcaba541539 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -143,8 +143,6 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		cpufreq_dt_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
 	}
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	return 0;
 
 out_clk_put:
@@ -184,6 +182,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.exit = cpufreq_exit,
 	.online = cpufreq_online,
 	.offline = cpufreq_offline,
+	.register_em = cpufreq_register_em_with_opp,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.31.1.272.g89b43f80a514

