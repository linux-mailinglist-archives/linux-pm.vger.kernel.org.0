Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B427E6794
	for <lists+linux-pm@lfdr.de>; Thu,  9 Nov 2023 11:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbjKIKPI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Nov 2023 05:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjKIKPG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Nov 2023 05:15:06 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F32D7C
        for <linux-pm@vger.kernel.org>; Thu,  9 Nov 2023 02:14:53 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32f70391608so364805f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Nov 2023 02:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524892; x=1700129692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8u+U/9u4ohr5MnGNG/ipD+T+tLh/PNcKnY6Yu8ixWw=;
        b=PpSbnRMVClcVCq7PxMg71+AnKN7hK0FrYIohngsI4P6PFOOh1MqbWWwQKkFPvt8XWi
         g2qDWb8opx5p+U7mtBOtiMHX3VWz5X9qugns5VaH+noBdExOA76oWa26tGHV7XtWa4rF
         epu7BVSF9Lew6K/jC8vFe2kZ9o/sMwwPFyq8TpFIAwob5uDkz/pk/GZ33QZ0GtSQeKO/
         /Nv9P7VWzBeyAqNuPUKfrIFtQbAiA3+k8Q4pZqES2p3nAQLrzRzMvtB6UKrAjfSkTjJ5
         zPO7pzg3wrMsO3NKMmThfuRrz8GX/u2EpHmR9V5yX08tOBFXUcFF4xBiXqhRH7hukxrS
         Rwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524892; x=1700129692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8u+U/9u4ohr5MnGNG/ipD+T+tLh/PNcKnY6Yu8ixWw=;
        b=sEsDhjtaMM9m72Z03NuYuCCbbK2HYG7YyIErOwo7i2pnjOB8wum7XEIj7i1FtpncaT
         zwFlw+1suX++4vlY4R+M9NFkYTSwpSda/KIwaE5X6CHjtIk5FIIAPSd/APLOjBR52KQM
         bPAoIqcHiMQlq7ZdCkQGLfYXmhd9xXZ0ND28Aigb9SS5xSstU9EiGteaJb1MmJ1JGbzm
         /YluAZI1FlJ7XkvuX1gYgZPhkb7h9jdJ9VrIu2TdtxyKo5ETWWlVZxStJLFKUj3nKUpa
         ZsrsyfEHU9Fz0bZYjBXD8+3dlYtSb+iJ3DyyO/g7lyREn0XMF3cdarR29lhSk/OxF0Fh
         /rfA==
X-Gm-Message-State: AOJu0Yykmshbh7iD65xC9gWcrr7tPw4gKjiOmAEPTLE7Jb/j6FA19JEz
        td3JO5XPVt2CnXoAF6wQ1ofi6Q==
X-Google-Smtp-Source: AGHT+IHnOiUcy8JXKcoEvGEFJjBuKV8KQLk7xv3UY4lyz6ACLBnBr+ZIXmzvc3YVmB2uAO7FfkCoEw==
X-Received: by 2002:a05:600c:a49:b0:409:5d7d:b26d with SMTP id c9-20020a05600c0a4900b004095d7db26dmr3556372wmq.15.1699524892326;
        Thu, 09 Nov 2023 02:14:52 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:51 -0800 (PST)
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
Subject: [PATCH v6 3/7] cpufreq/schedutil: Use a fixed reference frequency
Date:   Thu,  9 Nov 2023 11:14:34 +0100
Message-Id: <20231109101438.1139696-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109101438.1139696-1-vincent.guittot@linaro.org>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different than the one that has been
used when computing the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent reference
frequency that can be used when computing a frequency based on utilization.

Use this arch_scale_freq_ref() when available and fallback to
policy otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 458d359f5991..f3a87fa16332 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 	}
 }
 
+/**
+ * get_capacity_ref_freq - get the reference frequency that has been used to
+ * correlate frequency and compute capacity for a given cpufreq policy. We use
+ * the CPU managing it for the arch_scale_freq_ref() call in the function.
+ * @policy: the cpufreq policy of the CPU in question.
+ *
+ * Return: the reference CPU frequency to compute a capacity.
+ */
+static __always_inline
+unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
+{
+	unsigned int freq = arch_scale_freq_ref(policy->cpu);
+
+	if (freq)
+		return freq;
+
+	if (arch_scale_freq_invariant())
+		return policy->cpuinfo.max_freq;
+
+	return policy->cur;
+}
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -140,10 +162,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int freq;
 
 	util = map_util_perf(util);
+	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
-- 
2.34.1

