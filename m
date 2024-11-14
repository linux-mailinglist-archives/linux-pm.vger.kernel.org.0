Return-Path: <linux-pm+bounces-17585-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFC39C950D
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 23:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646A81F212C4
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 22:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A905F1B3949;
	Thu, 14 Nov 2024 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sv9YPr3n"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8E61B3930
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622192; cv=none; b=X0KtjMRpcbIvJDei4zZz4b3d551UAy3wm/U+v9id2Z/bX5CPFB9zsrqN8rUXbm+lWLHi0D5+FGeve4ENOjEV6tjJtNbe7aqQ8M+0CChvaaHa24C8o6x80wOdCjnW516pTZT5ZXI6tHUltqXoiYjPUbUZ96O5QDBknsYan5cf42s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622192; c=relaxed/simple;
	bh=erE7x5UyBXgceNKubyiTOJ7BXeO3c7MeYHV9axV0DZw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=FmKV2MtpKj35g0ByIannH1TUrQOKDOWOMXt0gdvb58VrrzL0sOT2FMDvlzyf8lnGgC973WGNZ0dIqJd8CgvQX3xEGOwpZZHrcctFfJr99WE68Unm9xU3N/t67m0pPi47udsp9wKMV2nvixL4+UH8kphSBI2itKsDeGlKSz7rBQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sv9YPr3n; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e381d10dd2aso1327793276.2
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731622190; x=1732226990; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix2aZjNEV5v90Kyb9lVYbv1gl/XRVKcqFa1DVAk8aZ0=;
        b=Sv9YPr3nuqoK8Mxj0uLy67ZQrYPVOEVW2/3nXGcHvyTg1E/5s3tSEuPMSbT2CEOTc9
         esgkJJ7B31K4XcSsZbYDDYrXjz5AJbY3qhwIkoPl4aokj3mJLOw5sCfxw7sWLRjj0MKF
         JbDSbQOZLJSJPmQS4X5F9XCg6/ISxwv0Cn0kZ+HPKxl8gzE/GkqZl1btVVQDwbRoB3Gq
         XLfqXKFyk8eg7681tdMDpQbA2E+5L+R+1S2V0me/3DH1mQ6nukegp8uXWKMwiHFZRY8K
         HmgDOHYLvg8ufhQJKQla302wM8T4M2rfqKFczo1+N9wVXrUO1t67KhqJu3OGeee5vJtJ
         kGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622190; x=1732226990;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ix2aZjNEV5v90Kyb9lVYbv1gl/XRVKcqFa1DVAk8aZ0=;
        b=V8btdyMXpJ656RdZiRt8Ng2wkZdVNfAsWLIGCmkMpqgrlaAUTMwxOL5dbN7RuZF5Qq
         zfPtwWRhXnPtoBGbxWH+TxVnL8jMAAuC6DB02jaH5PUlN2DzfEDKRzW8KfHbHQApaaF4
         jxJDXqdZVbTm/SubnoukbEupIGdYka3lx/Kcbgsc6ygig7pmgGSFtRvkMQaCG5L4zUyC
         MPnxOowaovMngA42wE9De11FgD+bOSpCcJbbHoLNr5Z/pWx9+iItJtJAWz8vOWjBJqmj
         St15puK3FytphHXd49K+fe0MsVz7ELVYPcaq/nZwKUh/nm38Hdo6mDZC4hRptzqmDD/h
         sf4g==
X-Forwarded-Encrypted: i=1; AJvYcCVFgCnPIE9+lmQC/PKRggEhxfzMox0rNgLKrJFsskBtlGYuY0ahk8jCqD8Igm4rWSctAO+FDSssxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDOsirr8E2VfIGC+mloqmXU9Y8vbv5EPO+M+6JuaAVK7QKl94a
	me0gIjmkA+DK3cvbbIhHJRNoVuGaVcx3GrE+E5NqDiXtprYMzlftLO9PMN6TrYFuZzdfyxQb4rz
	bt/wCAK2judqm/g==
X-Google-Smtp-Source: AGHT+IF8VfOz6LQsMr/CGI8GCQ4S/zLj7Vdday2+nUG/rZc9SbBgXM0Sf7829fpe/0ZP6BT+O+UG5Ot4zG8sR2g=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:3e23:8355:c37:686e])
 (user=saravanak job=sendgmr) by 2002:a25:ce05:0:b0:e38:25b5:e33 with SMTP id
 3f1490d57ef6-e38263d5d0dmr314276.7.1731622190059; Thu, 14 Nov 2024 14:09:50
 -0800 (PST)
Date: Thu, 14 Nov 2024 14:09:19 -0800
In-Reply-To: <20241114220921.2529905-1-saravanak@google.com>
Message-Id: <20241114220921.2529905-6-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 5/5] PM: sleep: Spread out async kworker threads during
 dpm_resume*() phases
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marex@denx.de>, Bird@google.com, Tim <Tim.Bird@sony.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

As of today, the scheduler doesn't spread out all the kworker threads
across all the available CPUs during suspend/resume. This causes
significant resume latency during the dpm_resume*() phases.

System resume latency is a very user-visible event. Reducing the
latency is more important than trying to be energy aware during that
period.

Since there are no userspace processes running during this time and
this is a very short time window, we can simply disable EAS during
resume so that the parallel resume of the devices is spread across all
the CPUs.

On a Pixel 6, averaging over 100 suspend/resume cycles, the new logic
plus disabling EAS for resume yields significant improvements:
+---------------------------+-----------+------------+------------------+
| Phase			    | Old full sync | New full async | % change |
|			    |		    | + EAS disabled |		|
+---------------------------+-----------+------------+------------------+
| Total dpm_suspend*() time |        107 ms |          62 ms |     -42% |
+---------------------------+-----------+------------+------------------+
| Total dpm_resume*() time  |         75 ms |          61 ms |     -19% |
+---------------------------+-----------+------------+------------------+
| Sum			    |        182 ms |         123 ms |     -32% |
+---------------------------+-----------+------------+------------------+

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 kernel/power/suspend.c  | 16 ++++++++++++++++
 kernel/sched/topology.c | 13 +++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..7304dc39958f 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -393,6 +393,12 @@ void __weak arch_suspend_enable_irqs(void)
 	local_irq_enable();
 }
 
+/*
+ * Intentionally not part of a header file to avoid risk of abuse by other
+ * drivers.
+ */
+void sched_set_energy_aware(unsigned int enable);
+
 /**
  * suspend_enter - Make the system enter the given sleep state.
  * @state: System sleep state to enter.
@@ -468,6 +474,15 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 
  Platform_wake:
 	platform_resume_noirq(state);
+	/*
+	 * We do this only for resume instead of suspend and resume for these
+	 * reasons:
+	 * - Performance is more important than power for resume.
+	 * - Power spent entering suspend is more important for suspend. Also,
+	 *   stangely, disabling EAS was making suspent a few milliseconds
+	 *   slower in my testing.
+	 */
+	sched_set_energy_aware(0);
 	dpm_resume_noirq(PMSG_RESUME);
 
  Platform_early_resume:
@@ -520,6 +535,7 @@ int suspend_devices_and_enter(suspend_state_t state)
  Resume_devices:
 	suspend_test_start();
 	dpm_resume_end(PMSG_RESUME);
+	sched_set_energy_aware(1);
 	suspend_test_finish("resume devices");
 	trace_suspend_resume(TPS("resume_console"), state, true);
 	resume_console();
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..c069c0b17cbf 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -284,6 +284,19 @@ void rebuild_sched_domains_energy(void)
 	mutex_unlock(&sched_energy_mutex);
 }
 
+void sched_set_energy_aware(unsigned int enable)
+{
+	int state;
+
+	if (!sched_is_eas_possible(cpu_active_mask))
+		return;
+
+	sysctl_sched_energy_aware = enable;
+	state = static_branch_unlikely(&sched_energy_present);
+	if (state != sysctl_sched_energy_aware)
+		rebuild_sched_domains_energy();
+}
+
 #ifdef CONFIG_PROC_SYSCTL
 static int sched_energy_aware_handler(const struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos)
-- 
2.47.0.338.g60cca15819-goog


