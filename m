Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BC27D90A1
	for <lists+linux-pm@lfdr.de>; Fri, 27 Oct 2023 10:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbjJ0IEf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 Oct 2023 04:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbjJ0IET (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Oct 2023 04:04:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95A9D44
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 01:04:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so23454681fa.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Oct 2023 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393849; x=1698998649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/qdhwYexgC4eelalZMREFYWDVhGmAVpyIy4h5YJd+Y=;
        b=UwG/4VS2MSxnkHtnsQpx9o/IPbZw1SxCBiaWXkPAhvhzizTMzCCoLnLGF4IHzjENat
         p41YfyeuOalrUJevD4TBvRf890ua3fFIJoTyZdQDjvv8D3qHL11Ntu/6ji8O9I0mp7zt
         anztlSB/tAGfuE/cy2m4NgHBbFDhm39MQhI8VLPBWD5W2qjTAfJNX3MP05Aj4SXC2SAS
         +dCFxr2+vbXfCASS4kYKZoZNlXyQU9TnhvA64gvJV3qmfKdLXvk+vaXI5ZjbAUWy5cMN
         DS/HtrOHsQ1DBTnsFgr4/qM8B1P5gFIn8msWC/ZrDXdhoMwFttPih9Gy5hZU7d19DQed
         Sgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393849; x=1698998649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/qdhwYexgC4eelalZMREFYWDVhGmAVpyIy4h5YJd+Y=;
        b=l6UvQk5wGyX3ericolke/MK/KGHOkbgJb4s1zNhM/b/hrrGOSyNkBVuzUawCI+JxpQ
         ddKXCizrFFCoN6bDghq6Lvjj+w3m/NoG27BkqppoKgbUwHU+26XHIv46HGpo2ocvixyE
         avg4ivQYgojciblb3bYLE5YkqQPh4EeW0x8Npo5R4SZGVwp07vt4UT6dLm/bPUkIzc9Y
         lZ3rpxZev3zvq1h8YbF9/adX3diBLEzj6yuZ7bEM3d89x4mhM3MGJMEGB7WmrI2NiAAw
         myssBRqEvYwG94G52DgQamy/kJ/+39gXhadp6P8AdpNKub+KNRDPuv4TQhKuZfl/Ui3s
         gW8g==
X-Gm-Message-State: AOJu0YwawINpYpTDUZantz6/h+LA/9E6MNnjHNI3uFxkZNk8vnIfr4z6
        ccfzvCqSTm2ChDmupqA97GS3ew==
X-Google-Smtp-Source: AGHT+IGXugARg3H3+vIzNim0kJhoC4UBCl4/dUe/XX18rWVm78ZhMKD3Vu64iuuup/7qbp3srdsKEQ==
X-Received: by 2002:a2e:8217:0:b0:2c5:1eb6:bd1e with SMTP id w23-20020a2e8217000000b002c51eb6bd1emr1414040ljg.43.1698393849239;
        Fri, 27 Oct 2023 01:04:09 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:08 -0700 (PDT)
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
Subject: [PATCH v2 2/7] cpufreq: use the fixed and coherent frequency for scaling capacity
Date:   Fri, 27 Oct 2023 10:03:55 +0200
Message-Id: <20231027080400.56703-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027080400.56703-1-vincent.guittot@linaro.org>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

