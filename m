Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F047CE2B8
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjJRQ0B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 12:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbjJRQZy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 12:25:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87D7FA
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 09:25:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40806e40fccso14301915e9.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697646348; x=1698251148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z47rGwNrqDmeGZQL2+O4h6n0CW6ulSbmPrUuoIVrkg=;
        b=f85jNDyj+YCeVocfqQ9Wnfs6HCEUPsoxfnev59jx74f0GdAE6LnN6JA1kxfwn44r0M
         QcVN7Ajxs4kNGmRdV91XHS5Bf1UALo7T1EguSZOqENx96Qe2d/+ExLpKKIhs1JBk3B59
         o3ekzF3iMtipAtwxwcYx0KL1AyMDSdwQTJq7oqTJ3tOhAyatLMYYLUYmHLhxBBD8dKI9
         +LMqXKotmIDdJLSjCVO4QvGu8lpa1JlnfYYDR5ST9NPaVElWRC6o31ezWTF0ZX3PwgMi
         xg09U1UdhUXKCtLMlM71gEnWP4mF4zSN0KvGVwUJUkfUQQbHe0NCpUnRzRYHibAr29Tk
         7PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646348; x=1698251148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z47rGwNrqDmeGZQL2+O4h6n0CW6ulSbmPrUuoIVrkg=;
        b=DvE/ZTc4ZkHOr+/D8+AMoDA0kB7S5pFIkn6WLyhQA+RAOQN529d/DBOQi/Cf9KagMi
         LFO0RFq/kArMsb+9RhgCpfRxmsZq7rfRBYiko4MkfB+kwnXqsI8Kx34FE//LqB15eskc
         3sridDPLSi8ANPMgIPAzYLCVSpVoE24aXAq9BBr8QR+oozozN3D6b+6u2jfhKNfi1o0J
         4vBmU33aIPAA4dzj2+go3MDj842cERgEX5c84lc4mdMYrzvlFW4zKG0D+Rj6j6kwjUeB
         ZAqYk/LMZWgdd9eV0/qNmF/ZH7RIa/F1Jea+R6mAH4vOSVQ8mPNkEb30VeoIzZzI6Irq
         i+Ng==
X-Gm-Message-State: AOJu0YyTGzgzeYHg9j8kcl13WzyeAG1Q3R05aifLOEcnd8+Jq0Qwhp+w
        qXwgzYGjGtCJt54NBJYT78tLeA==
X-Google-Smtp-Source: AGHT+IEFZf427eGHrOOELv98mOJEzuRAUylMVQKBwFbh9aeFtmb3e8o2V3eMOH20VJR0QjYnkJDkZQ==
X-Received: by 2002:a05:600c:4f15:b0:401:bdd7:49ae with SMTP id l21-20020a05600c4f1500b00401bdd749aemr4828030wmq.18.1697646348170;
        Wed, 18 Oct 2023 09:25:48 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:fcf4:9d83:8d0d:39aa])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm2033503wmf.39.2023.10.18.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:25:47 -0700 (PDT)
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
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 2/6] cpufreq: use the fixed and coherent frequency for scaling capacity
Date:   Wed, 18 Oct 2023 18:25:36 +0200
Message-Id: <20231018162540.667646-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018162540.667646-1-vincent.guittot@linaro.org>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

---
 drivers/cpufreq/cpufreq.c | 4 ++--
 include/linux/cpufreq.h   | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index 71d186d6933a..bbc483b4b6e5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1211,6 +1211,15 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
+#ifndef arch_scale_freq_ref
+static __always_inline
+unsigned int arch_scale_freq_ref(int cpu)
+{
+	return 0;
+}
+#endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.34.1

