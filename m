Return-Path: <linux-pm+bounces-20947-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A128A1C046
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 02:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067EC3ACF51
	for <lists+linux-pm@lfdr.de>; Sat, 25 Jan 2025 01:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651BA1EEA2A;
	Sat, 25 Jan 2025 01:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F69o3Ych"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33643273FE
	for <linux-pm@vger.kernel.org>; Sat, 25 Jan 2025 01:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768752; cv=none; b=HbbPicIMM0cRYyAHKQEdEUdRDYEv5PPWaet/4xHRLAnzPj+ETyycOIrD0UdhpytFhSruQBO113la6UCcI7txjKNuXs5ADus6yPnpCSVpziKhqS2ZwA2Fe0gj8C1mzIg6j56TdRdAq7b77sL2efFEvLBb5NUvUJD7Mg85KrE0Vbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768752; c=relaxed/simple;
	bh=V7mBH0zJXZMiBcNCDofsvjZ4JjQO1U/hqcyQs79rpD4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CZWvCQRzJavxUSHmjA6nzUsGt6GYv+/Gsvx+HN6RR+AzREvyzZeo8b12I+0iDmJydHAiGLJd5pOJekQrhblBr8nkOLzH18ArpF8/fFxQXmU1n/4xtyxYQ9aMCKcLb4VWAdXdTQjYG7zP9ZLa9xIDOaaRG/fjo4cNwrr0t2SAmGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F69o3Ych; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2166855029eso52130405ad.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 17:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737768749; x=1738373549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DfQLw6braW4NPzP7u1BdMZ/MqPhU6oi4TECCrySv6tY=;
        b=F69o3Ychn1uPhWtKoILwGAPqsJ2ZizKQbYlaYCHxiRhRXk7ohSptvk7wXS34hDg+y2
         gchJHZmG9P7VaDHm2yTjEzzWoxZanZ2rY0j1FJt0CssryUODj1ycBEkySWb4qKvMJ6hb
         9eGyYctYJXxqzFmXCaQMN+7JqAdTavehen1SKwvTSHpENeW7Qk4GQtzZbacbMwKh0Qrz
         8zQ3IdB7jHeGBqyoz04PFhPNRssuDkd1gY2PZmPg6beyq4x23xZzr8XdpNRtMCeesp7i
         VbwggE6/sN3c+7NIpz9I1JMtbeuCPAGPPn5Zkfmm7VOHx9BboU0QN5PxaI8Jga+QecFr
         uveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768749; x=1738373549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfQLw6braW4NPzP7u1BdMZ/MqPhU6oi4TECCrySv6tY=;
        b=b6CpQiZhsFJaq5obY1NBHdW8jvtkIWUkPmfOqiKPS9znwwxbXIFip03mvZsEjb/jBP
         DwGa/MD5aU+RPgHYXfC+QNYwin3JHyUGI9/E1CpcMJkwNtDnKa9Pl5/64GgsILbYUqNw
         DxtZRQtG5Wo3q8ubrXiDWQujAY50CkV8X5dkAQHWO7avqjkLcbFv0AABP8jnnQ62EGsk
         wJrnm9l4zIqryvPi/QPnNEGpZwwAJjE989D50tai9Bil/wy9wc6FZxl90AV3EWBj3CHG
         Sdgh83B10LOurg1Rv0awMZSOeQdkIF5Am1LvCwwK8GqOCjgypR026b+HTSQjQAN3kV6x
         96RA==
X-Forwarded-Encrypted: i=1; AJvYcCWnTRbnCqJ7ZwTSKZmEC4rTjTS5U5EdDIelj3yMnxmcPtV10a21gYn9r8Fj4ZuKEpn6j2/yarThfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/8WOb2nNR312hLOvWWIQP7JzhjYmvy2ZZ8gaEkjxpM9a70Ig
	XA5vfgrSnN928QUK91sBun0/k9vDvkeVuHeJUQbBmDtfc7cXHekunUJU9hVZ3ANjWkgEpg==
X-Google-Smtp-Source: AGHT+IEwhj43ji4o+0SxJAKElNbTnJvGB8JU2Dt1FOH3ilcjaICPkucWw2Xnsu+q12dk5Vy9F3ksFGEO
X-Received: from pgbbk3.prod.google.com ([2002:a05:6a02:283:b0:7fd:55d9:1f1a])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8cca:b0:1eb:367f:7a48
 with SMTP id adf61e73a8af0-1eb367f7e2cmr51366488637.34.1737768749476; Fri, 24
 Jan 2025 17:32:29 -0800 (PST)
Date: Sat, 25 Jan 2025 09:31:45 +0800
In-Reply-To: <20250125012734.1661860-1-keyz@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250125012734.1661860-1-keyz@google.com>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250125013145.1664062-1-keyz@google.com>
Subject: [PATCH v3] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: aarontian@google.com, yimingtseng@google.com, 
	Keita Morisaki <keyz@google.com>
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
---
v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
        and rephrase the commit message accordingly. Rebased onto the latest.
v2->v3: Add the Reviewed-by label

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
2.48.1.262.g85cc9f2d1e-goog

