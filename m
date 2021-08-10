Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD95B3E5473
	for <lists+linux-pm@lfdr.de>; Tue, 10 Aug 2021 09:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhHJHh4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Aug 2021 03:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbhHJHhx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Aug 2021 03:37:53 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8471C061798
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:37:31 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lw7-20020a17090b1807b029017881cc80b7so3077322pjb.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Aug 2021 00:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0ESkgRNa4vkozA2GQvSw915d4fLi0hlNoHicBPRN6s=;
        b=Nyujgk1yu+B3QJtPf5p7mSBmBFCEaQpPsLB59ms9WRoRqV3eLEa842gRWTBEv2X1U9
         DHA9hNmS8GqvMQpR9KcSDwQctHDJvWygUdbdyvUwIH39Qrl56Gv2LQAFWty1biwLcA0J
         G0lWIQpVq5raGE8mPlFoc0Dr0x3dhAUUE+J5ja+wEgxMVjirZjxt2GMMq3/4G5g8r/+G
         +/a4XwLO9LfacMwqbUusG6SKOWuGz37wADkRImTe7GlkGCF98b6tqr3orw8QMocBaF88
         IrSwTVMYqvBxotei9lxjwdLUcqk1ovA3aj3bEUfdo4IGlDXf1JyM76tcRYC0LwL7jvDb
         VPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0ESkgRNa4vkozA2GQvSw915d4fLi0hlNoHicBPRN6s=;
        b=MTx+OskMadcBu1w80dWvJX/XoR3+QZ4mqgHJdsAlOtSLWeORsKwPCxHTRhTWPS23/h
         maydpaUf8UZoWyry8AxkafC9wdvSq9WeDH7rPZoMhfcZnewqnjSljYTdVRq4gZoxk+YG
         7I3tsJew7MY7ilfLicbMD8h9Z+gFvFMtKjqnxuZ2s4CpfD0wrQXKPiYAODCJbIIX8rIH
         CkveQnCvub9roWrdbs+/gAINpL5od33ckYlCKsMMb/UPVi22Z33nSeHhyDF+xzuWGlao
         NVb778lyvMhPiY3M5PEMmUrYcvQRPzY1FeDkEWXAh6EWWjSCJePtSEzOArHOkZfV0ghA
         rCAw==
X-Gm-Message-State: AOAM533zEV0jZQBmaDP5zKQ8XGAf/BTDpSSm668PUgjf+xhY35DVb9Af
        wR/i1XBqnpVc8lvJHsqTN7PEVw==
X-Google-Smtp-Source: ABdhPJwVRmgoKnt3ij3/5KYJru9Y5sSV2ApKUBdMorjsp0bG8BMtxxQoHU07A2PF+eLCjDkZxSE+XA==
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr3445658pjb.222.1628581051473;
        Tue, 10 Aug 2021 00:37:31 -0700 (PDT)
Received: from localhost ([122.172.201.85])
        by smtp.gmail.com with ESMTPSA id q1sm23396172pfn.6.2021.08.10.00.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 00:37:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        lukasz.luba@arm.com, Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 8/8] cpufreq: vexpress: Use auto-registration for energy model
Date:   Tue, 10 Aug 2021 13:06:55 +0530
Message-Id: <87fecd84e3f6ff6f153be14b0d53de93c0b04ae6.1628579170.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1628579170.git.viresh.kumar@linaro.org>
References: <cover.1628579170.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the CPUFREQ_REGISTER_WITH_EM flag to allow cpufreq core to
automatically register with the energy model.

This allows removal of boiler plate code from the driver and fixes the
unregistration part as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index 51dfa9ae6cf5..28c4c3254337 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -442,8 +442,6 @@ static int ve_spc_cpufreq_init(struct cpufreq_policy *policy)
 	policy->freq_table = freq_table[cur_cluster];
 	policy->cpuinfo.transition_latency = 1000000; /* 1 ms */
 
-	dev_pm_opp_of_register_em(cpu_dev, policy->cpus);
-
 	if (is_bL_switching_enabled())
 		per_cpu(cpu_last_req_freq, policy->cpu) =
 						clk_get_cpu_rate(policy->cpu);
@@ -487,7 +485,8 @@ static void ve_spc_cpufreq_ready(struct cpufreq_policy *policy)
 static struct cpufreq_driver ve_spc_cpufreq_driver = {
 	.name			= "vexpress-spc",
 	.flags			= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
-					CPUFREQ_NEED_INITIAL_FREQ_CHECK,
+				  CPUFREQ_NEED_INITIAL_FREQ_CHECK |
+				  CPUFREQ_REGISTER_WITH_EM,
 	.verify			= cpufreq_generic_frequency_table_verify,
 	.target_index		= ve_spc_cpufreq_set_target,
 	.get			= ve_spc_cpufreq_get_rate,
-- 
2.31.1.272.g89b43f80a514

