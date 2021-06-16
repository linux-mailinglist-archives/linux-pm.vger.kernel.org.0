Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB6F3A9306
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 08:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbhFPGuZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 02:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhFPGuY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 02:50:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E5C061574
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:48:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s17-20020a17090a8811b029016e89654f93so3380692pjn.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G2o9MLJnJsw+6A1+/Voo6W0MsEPUjxURc0icFdbia4A=;
        b=o3ZGRm+0PhR57FZeE69PXo3qtAMRcOMhbEPnUNPCmO6a3bopp2N37v+kmO19XhecJk
         d3fAwvpax0VF0gdRK99Gg4WeuW8tMXK7i/gICzuT6F+LczfGHLkIDT840edL0ZLQBuDq
         YCpzFBNxvRYhinwex9s/GmHopX+OQ7YH2HlsKvPIbmpp0ICcVQm/fzAo3DUcy3JkN0TV
         MwKlKRz8wqfI4Vv82WBDRXlMTO93AKiAYh5Bx2YPL/ValHsZQ9U7fINE4lqsxaIczaDo
         tcjkTMqK0LBuaT+RcZkqhbcpFfEFCbYlDiBOf2q1jktpKcLMXiGdXDUy0yezAqW15yO+
         QgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G2o9MLJnJsw+6A1+/Voo6W0MsEPUjxURc0icFdbia4A=;
        b=qxujnsPwcVxl6OTV0iXAobblnbbr5nR4VoKkMKdHPkeW/gfYP4ZXuOT6+wb3V7j93H
         B0gjIQoI1RP3QTXKC2yqL6u6hgpMstlHYgFO5RVVIApoRqqN214Hw8iYz8yFGRVhL+4N
         KgYfW9huPw1zr2erS08XWcEYwRawZHAE4586jcQ7aMVJKB2RBe1bWiUjTfnsFpSMXifW
         NNFrZvKEWgMrxBgs83JGuk7zCdTFdr/ey9qFDMtgQ9MbHZl+/vrJ7ZAv8KgCN6NIJo4x
         rH366PDdPpB3WTrWivxkQ+cOJvzdvpjM+leminJ2py/+R7xQ1sbRwe4blXpUHQIqzvQb
         As1w==
X-Gm-Message-State: AOAM532W/sIaPZBW1B5Fq4GI3qBbZxELxTWtSiw4Rx2Gzla6oHuFzQf2
        A0BMcsIm5kmKdqxJxSVNjhU1Yw==
X-Google-Smtp-Source: ABdhPJxpzad74jam2+j2zJsuqJEtQzcp85IAyX1hiOrexHl514pCD7fFd/TmWVot90x4+5TugFFUsw==
X-Received: by 2002:a17:902:b609:b029:118:8a66:6963 with SMTP id b9-20020a170902b609b02901188a666963mr7854149pls.65.1623826097975;
        Tue, 15 Jun 2021 23:48:17 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id d8sm1127995pfq.198.2021.06.15.23.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:48:17 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Qian Cai <quic_qiancai@quicinc.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] cpufreq: Add start_cpu() and stop_cpu() callbacks
Date:   Wed, 16 Jun 2021 12:18:07 +0530
Message-Id: <2ffbaf079a21c2810c402cb5bba4e9c14c4a0ff4.1623825725.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623825725.git.viresh.kumar@linaro.org>
References: <cover.1623825725.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On CPU hot-unplug, the cpufreq core doesn't call any driver specific
callback unless all the CPUs of a policy went away, in which case we
call stop_cpu() callback.

For the CPPC cpufreq driver, we need to perform per-cpu init/exit work
which that can't be performed from policy specific init()/exit()
callbacks.

This patch adds a new callback, start_cpu() and modifies the stop_cpu()
callback, to perform such CPU specific work.

These routines are called whenever a CPU is added or removed from a
policy.

Note that this also moves the setting of policy->cpus to online CPUs
only, outside of rwsem as we needed to call start_cpu() for online CPUs
only. This shouldn't have any side effects.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/cpu-freq/cpu-drivers.rst |  7 +++++--
 drivers/cpufreq/cpufreq.c              | 19 +++++++++++++++----
 include/linux/cpufreq.h                |  5 ++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/cpu-freq/cpu-drivers.rst b/Documentation/cpu-freq/cpu-drivers.rst
index a697278ce190..15cfe42b4075 100644
--- a/Documentation/cpu-freq/cpu-drivers.rst
+++ b/Documentation/cpu-freq/cpu-drivers.rst
@@ -71,8 +71,11 @@ And optionally
  .exit - A pointer to a per-policy cleanup function called during
  CPU_POST_DEAD phase of cpu hotplug process.
 
- .stop_cpu - A pointer to a per-policy stop function called during
- CPU_DOWN_PREPARE phase of cpu hotplug process.
+ .start_cpu - A pointer to a per-policy per-cpu start function called
+ during CPU online phase.
+
+ .stop_cpu - A pointer to a per-policy per-cpu stop function called
+ during CPU offline phase.
 
  .suspend - A pointer to a per-policy suspend function which is called
  with interrupts disabled and _after_ the governor is stopped for the
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 802abc925b2a..128dfb1b0cdf 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1119,6 +1119,10 @@ static int cpufreq_add_policy_cpu(struct cpufreq_policy *policy, unsigned int cp
 
 	cpumask_set_cpu(cpu, policy->cpus);
 
+	/* Do CPU specific initialization if required */
+	if (cpufreq_driver->start_cpu)
+		cpufreq_driver->start_cpu(policy, cpu);
+
 	if (has_target()) {
 		ret = cpufreq_start_governor(policy);
 		if (ret)
@@ -1375,13 +1379,19 @@ static int cpufreq_online(unsigned int cpu)
 		cpumask_copy(policy->related_cpus, policy->cpus);
 	}
 
-	down_write(&policy->rwsem);
 	/*
 	 * affected cpus must always be the one, which are online. We aren't
 	 * managing offline cpus here.
 	 */
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
 
+	/* Do CPU specific initialization if required */
+	if (cpufreq_driver->start_cpu) {
+		for_each_cpu(j, policy->cpus)
+			cpufreq_driver->start_cpu(policy, j);
+	}
+
+	down_write(&policy->rwsem);
 	if (new_policy) {
 		for_each_cpu(j, policy->related_cpus) {
 			per_cpu(cpufreq_cpu_data, j) = policy;
@@ -1581,6 +1591,10 @@ static int cpufreq_offline(unsigned int cpu)
 		policy->cpu = cpumask_any(policy->cpus);
 	}
 
+	/* Do CPU specific de-initialization if required */
+	if (cpufreq_driver->stop_cpu)
+		cpufreq_driver->stop_cpu(policy, cpu);
+
 	/* Start governor again for active policy */
 	if (!policy_is_inactive(policy)) {
 		if (has_target()) {
@@ -1597,9 +1611,6 @@ static int cpufreq_offline(unsigned int cpu)
 		policy->cdev = NULL;
 	}
 
-	if (cpufreq_driver->stop_cpu)
-		cpufreq_driver->stop_cpu(policy);
-
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 353969c7acd3..c281b3df4e2f 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -371,7 +371,10 @@ struct cpufreq_driver {
 	int		(*online)(struct cpufreq_policy *policy);
 	int		(*offline)(struct cpufreq_policy *policy);
 	int		(*exit)(struct cpufreq_policy *policy);
-	void		(*stop_cpu)(struct cpufreq_policy *policy);
+
+	/* CPU specific start/stop */
+	void		(*start_cpu)(struct cpufreq_policy *policy, unsigned int cpu);
+	void		(*stop_cpu)(struct cpufreq_policy *policy, unsigned int cpu);
 	int		(*suspend)(struct cpufreq_policy *policy);
 	int		(*resume)(struct cpufreq_policy *policy);
 
-- 
2.31.1.272.g89b43f80a514

