Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B8E7E0ED8
	for <lists+linux-pm@lfdr.de>; Sat,  4 Nov 2023 12:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjKDK7X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 4 Nov 2023 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjKDK7U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Nov 2023 06:59:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DFAD44
        for <linux-pm@vger.kernel.org>; Sat,  4 Nov 2023 03:59:16 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c6ed1b9a1cso38655721fa.3
        for <linux-pm@vger.kernel.org>; Sat, 04 Nov 2023 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699095555; x=1699700355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkZaHixUrwPrJIZcMAT2UI1CVMoJazwhG5L/qYNHDpM=;
        b=OLJZ/NAf4ZEf45K0m9be9tlxklipxKiEah3Lfiw9MRb55oJkvQevIb88wp9EAb2egV
         ZlzaMnhwvzTIl/PpPCD9eNcJAv6QEb0PimPNwsV7wGNPZ+zGz6HqUj5ZaIJdcRDe4U2n
         n33vMenx3zLynMJvznF38JJXbmc90bRyw4vYBufEza0/Wafj5aMcmYn83AVXJ3QsaUgL
         D4AUVBUS39tmQZd8mHslkvW5yZNqbsEx2svupRPqvgeMbkJsMI84dp5rAtyr8FkxZDWd
         mNwb63WHrjHrSpKHSPEWQ4fm07zIGKGIn2XJvmucFkIO7AKhLIyLbYwY24f8af0Bh8RO
         wQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699095555; x=1699700355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkZaHixUrwPrJIZcMAT2UI1CVMoJazwhG5L/qYNHDpM=;
        b=P7r4w5iYVimpRncVqBXAwMImujaw3irl3V3J/0qwd94Vr2MY9GfNyZtqjINu3ZW/xm
         x1w7JuCqmlJQ4RunMGJv195mA3zDZzeala04kpCCiysFHRJDjZ/q6Rm0qfqw/brqeMv3
         iT+fGLa8SiiX/4H+RF0xShEoyq2OKnzSRbOe67DKohXmAKlt0zB0wISPjMVE6t3g9skM
         jK3AVkNBhxzoawcAeRL5yAl3iGQYGx9gPa6PQs35XW09eCd8L+/2ZiMgITig93TdYD69
         aJdjrU4vv6BfH6e3u4JJarronW98cg9Os6rGLJVV3mxaTnykFMPOsfpsV04v511UdhCO
         E9ug==
X-Gm-Message-State: AOJu0YyVi3m2OUIo0dhTvD+qU7+T9vXwOrPYv2cqyPChUWRrnPnzfSMH
        nmLzoQNUQaEM9LxQXUF9AMot+g==
X-Google-Smtp-Source: AGHT+IGatMiVkHBmtEgXSS+pWzzTWU/5QphnZgu+ruqZQUWWzvRdCWO28Yzol+5QNvFneAB53ahKPA==
X-Received: by 2002:a2e:7a17:0:b0:2c2:a337:5ea with SMTP id v23-20020a2e7a17000000b002c2a33705eamr19234202ljc.27.1699095555017;
        Sat, 04 Nov 2023 03:59:15 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b004053a6b8c41sm5315809wmq.12.2023.11.04.03.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 03:59:14 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, beata.michalska@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 2/7] cpufreq: Use the fixed and coherent frequency for scaling capacity
Date:   Sat,  4 Nov 2023 11:59:02 +0100
Message-Id: <20231104105907.1365392-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104105907.1365392-1-vincent.guittot@linaro.org>
References: <20231104105907.1365392-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different from the frequency that has been
used to compute the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent frequency
that can be used to compute the capacity for a given frequency.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 include/linux/cpufreq.h   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 60ed89000e82..8c4f9c2f9c44 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 
 	arch_set_freq_scale(policy->related_cpus,
 			    policy->cur,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 
 	spin_lock(&policy->transition_lock);
 	policy->transition_ongoing = false;
@@ -2174,7 +2174,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 
 	policy->cur = freq;
 	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 	cpufreq_stats_record_transition(policy, freq);
 
 	if (trace_cpu_frequency_enabled()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 71d186d6933a..738dcddf3cfe 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1211,6 +1211,7 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.34.1

