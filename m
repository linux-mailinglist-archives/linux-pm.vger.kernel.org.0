Return-Path: <linux-pm+bounces-21284-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABC7A25677
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 10:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D590167980
	for <lists+linux-pm@lfdr.de>; Mon,  3 Feb 2025 09:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79458200118;
	Mon,  3 Feb 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I6xwDM4e"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A97101E6
	for <linux-pm@vger.kernel.org>; Mon,  3 Feb 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738576622; cv=none; b=fOsdeQI5euGphSi9dFMFNxCN9hpnahVmUH5/xZDaqd2XWor/qZ6wXrjcRKGVDXD2YcH0IYujjaZqDwC7jM+MsDajdbh2ybqmh4PMcv56Ptw75WtCkZeIjY8K4LRuppp758cK9KlycEhn0vmny9M0sGKxh8AA4eDez7l2fC/ZFwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738576622; c=relaxed/simple;
	bh=P6ZIjOcrVGSddzFqkeN9Se9GTO1nq5yLuU1kZ4p08iM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I4vJVFASjXcywDyJ6ORsGZc9Px2ZxYeP7g+LM6Uf+IBKR0j4PABWaY74gjTPlFbA6msTXdx2o8H/N5Wt6OLuN38Mf/8uGa1ExoPrIBIjStpUxLv8abRR0wa2wH9a+q4uoStTx4XHhIHZ3VPraaa6qPnu+akv4uxCqkV6UKctKiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I6xwDM4e; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2b3f1eb8cso36528707b3.2
        for <linux-pm@vger.kernel.org>; Mon, 03 Feb 2025 01:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738576619; x=1739181419; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Dv5Ac6SPOdtGgS0tmgxnxoVXUMjLjqcjHEmAbg0F2U=;
        b=I6xwDM4e56Ouw7DZvCsF2W+JzxcS0icQkVSpVzugPmBniiP7iWCM6clFimA3h99hha
         7OLNskmONMf2klDI6Vw3ucS/8hAMltMndnePvLu03pbr+ai0lkxcheGUN2kSyO9ys3s/
         5/wZ6YesOhCqzqyKpY3gz+s3mfixpF7EzcDjmSyMnnDumyyXZkGGykAMUukGVANyKsIk
         CxdpSQOaETE+zTxYimIkDB1/NNsFyYra41l+gFEosv2pdKemnjBreALD7xJjFGd+QwIu
         unp7ZCZlUwq1DvxLn8fAuABAJNGtLe+uIi4cQ+IJYbH2DuppUKRbCoXMDmZPb/uDKrOS
         /xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738576619; x=1739181419;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Dv5Ac6SPOdtGgS0tmgxnxoVXUMjLjqcjHEmAbg0F2U=;
        b=BNd3P4Bgn2G912+TSqVy5BWKNTsSP/nts2zc1bRO51P4e1d6pU+C+BwxP7Oov4Uk/g
         b5bw6Av7UWpYxj5rBCp5cUOxE2rjJSGquqT2mJtQ1uxhuSbI1czTijPsqiyW3DGMjH3z
         dwW1zXI8NWOtCe9CGv4JCusiJ7VC8/3nspgF6jgmYCk574fi2Bw1g9r/hLENY6KI1ZOC
         mr6Bxtn4Q7LPNL7xqzhAaWoNWLsQPx5/ZRNlqv3u3WhpohxKvNGIfqEmHMkFZwJPxrc4
         uAPRPm0osqUet/otfPlBb2O7OGVrj2S6cd0PeSL28Zoqp3ndTK5mm3lBcrHRD7AdLSOx
         lbHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf1w1v4gshafBtXTmicYlK3riaqf5yRGoGXWFv//qlg6siADhFPQrDu5gY2I0QnNejZ+NtYkIVqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyLhio9VzN5JGr85lZyrk/3TSq2HiNDfOlDOcS9YZXS9q9opF
	JPgGNrCdZyJ2CqTECW6nMPc8im6b55HKPbbz/qQ59GFOFR/jzLQX2cthSUTsxJMfGBxxVg==
X-Google-Smtp-Source: AGHT+IECB4t9+nxA9LWLIFfRwRwZsyYuUUH4xiSxgCR5XbY+fu38QoXLmO5+/gf/KeL9xbqGeB9WRgfz
X-Received: from ywbhl13.prod.google.com ([2002:a05:690c:620d:b0:6f5:278e:e957])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:74ca:b0:6ef:81c0:5b56
 with SMTP id 00721157ae682-6f7a8355a9amr168753257b3.14.1738576619752; Mon, 03
 Feb 2025 01:56:59 -0800 (PST)
Date: Mon,  3 Feb 2025 17:56:53 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203095653.4085118-1-keyz@google.com>
Subject: [PATCH v5] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: linux-kernel@vger.kernel.org, lpieralisi@kernel.org, sudeep.holla@arm.com, 
	rafael@kernel.org, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, aarontian@google.com, 
	yimingtseng@google.com, Keita Morisaki <keyz@google.com>, Dhruva Gole <d-gole@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"

The trace event cpu_idle provides insufficient information for debugging
PSCI requests due to lacking access to determined PSCI domain idle
states. The cpu_idle usually only shows -1, 0, or 1 regardless how many
idle states the power domain has.

Add new trace events namely psci_domain_idle_enter and
psci_domain_idle_exit to trace enter and exit events with a determined
idle state.

These new trace events will help developers debug CPUidle issues on ARM
systems using PSCI by providing more detailed information about the
requested idle states.

Signed-off-by: Keita Morisaki <keyz@google.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
        and rephrase the commit message accordingly. Rebased onto the latest.
v2->v3: Add "Reviewed-by: Steven Rostedt"
v3->v4: Add the Tested-by label
v4->v5: Add "Reviewed-by: Dhruva Gole"

Hopefully this patch gets attention from maintainers of
drivers/cpuidle/cpuidle-psci.c too.

 drivers/cpuidle/cpuidle-psci.c |  3 +++
 include/trace/events/power.h   | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 2562dc001fc1..dd8d776d6e39 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -25,6 +25,7 @@
 #include <linux/syscore_ops.h>

 #include <asm/cpuidle.h>
+#include <trace/events/power.h>

 #include "cpuidle-psci.h"
 #include "dt_idle_states.h"
@@ -74,7 +75,9 @@ static __cpuidle int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 	if (!state)
 		state = states[idx];

+	trace_psci_domain_idle_enter(dev->cpu, state, s2idle);
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
+	trace_psci_domain_idle_exit(dev->cpu, state, s2idle);

 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index d2349b6b531a..9253e83b9bb4 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -62,6 +62,43 @@ TRACE_EVENT(cpu_idle_miss,
 		(unsigned long)__entry->state, (__entry->below)?"below":"above")
 );

+DECLARE_EVENT_CLASS(psci_domain_idle,
+
+	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
+
+	TP_ARGS(cpu_id, state, s2idle),
+
+	TP_STRUCT__entry(
+		__field(u32,		cpu_id)
+		__field(u32,		state)
+		__field(bool,		s2idle)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->state = state;
+		__entry->s2idle = s2idle;
+	),
+
+	TP_printk("cpu_id=%lu state=0x%lx is_s2idle=%s",
+		  (unsigned long)__entry->cpu_id, (unsigned long)__entry->state,
+		  (__entry->s2idle)?"yes":"no")
+);
+
+DEFINE_EVENT(psci_domain_idle, psci_domain_idle_enter,
+
+	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
+
+	TP_ARGS(cpu_id, state, s2idle)
+);
+
+DEFINE_EVENT(psci_domain_idle, psci_domain_idle_exit,
+
+	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
+
+	TP_ARGS(cpu_id, state, s2idle)
+);
+
 TRACE_EVENT(powernv_throttle,

 	TP_PROTO(int chip_id, const char *reason, int pmax),

base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
--
2.48.1.362.g079036d154-goog

