Return-Path: <linux-pm+bounces-21626-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD480A2E3DC
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 06:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 787F73A8441
	for <lists+linux-pm@lfdr.de>; Mon, 10 Feb 2025 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F1F191F77;
	Mon, 10 Feb 2025 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UzqmXGbN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206418E361
	for <linux-pm@vger.kernel.org>; Mon, 10 Feb 2025 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167116; cv=none; b=JTc2poO6LjGF1O7Eaf9b53XaVxgIeSUdnykCf0U+mPYJsarML+ug8CQS1Sk7G5pLlwpZUWxhPbodVkDCCC5sYvWwk1nqhmfR8rAWIZgidi/SmNV4jdn5bLd1fbCz76ifIfSCem1QVhZU2fVmZmUY+FdlSidfsScl7zv3IbGeZZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167116; c=relaxed/simple;
	bh=P6ZIjOcrVGSddzFqkeN9Se9GTO1nq5yLuU1kZ4p08iM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ni2dMRKsKz2DAaLbKDUNTP9VC0PF1mAXExFBtyRAhqa5EMvOQA8h9jkSiXUtGWpdFuVp+RJyNibRu7omsuvUHZUJjk1NO8N/0uDrUyPhfxMn6hucyJS51wP6CBdLGWYmyqTvbFQ/G/3GxxzqB4TLjrcRhUtgD4S57AmMY+myZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UzqmXGbN; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21f7671a821so26153645ad.1
        for <linux-pm@vger.kernel.org>; Sun, 09 Feb 2025 21:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739167114; x=1739771914; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2Dv5Ac6SPOdtGgS0tmgxnxoVXUMjLjqcjHEmAbg0F2U=;
        b=UzqmXGbNZ48VqB06pUERCXZro4aYyIa7HUyltaILxa1BzdI1CLpElgllG70XL5RGKW
         OYY2XflOG1FRjBzoPs36G2N7Mmi7n9Y2vCrwl8qU0dH0apRPnYDvYiv92v6DPJOZJCtn
         M2mkgkJLVOk72PCSQWcdRJKS3x9+Re6PldzDxeMaZjENOHK/XXG8ldzFW/FxRTkhQnP+
         coUo6X1w9LJ9UqQAy/7xr2nRuBN/MjQXWTtJRkm2npTGaGzhV1P3ijMjI+maulb+UMBr
         8QjvpSvNDRF0UTdSBOZMxSlz+cGxeBYoSLu1Vvr0IseouxvIjr/QJX7lySAK3UUSNOjz
         tEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739167114; x=1739771914;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Dv5Ac6SPOdtGgS0tmgxnxoVXUMjLjqcjHEmAbg0F2U=;
        b=Z+zuwt5t/eDIe5eYz6kGJ4Cc7+mBHcmXJ262YBfk1HQcLTHCvE9Bc1VTNK6eOPWthD
         XJh3P72chKc23clv6LCMSpqZNqOXZy3+BU95ObLrN+e6BlQPqoLkwtEEE9U1CbOjjWAp
         mKoGqf7MGw0/xi1M6bEbmIqmJ5S6RpswkFwsmduAefC55PmlwQtJnq6/u4srN4/JukgI
         Q7MuRpEiUISL3GZ47yESPtaCTDGzkJJK9ZlHTXi7SbMG/fzI3d3QwxqmsqxyW4NMK3D+
         OjTaEpKLfDD+Acip/h3YhBOxVMx6qsJGzItkuXU9uuWwUa7KRXuFyKtP6wKQqRi53yAB
         si+g==
X-Forwarded-Encrypted: i=1; AJvYcCXi7FnYiEnwXfC3aMppd2/9NLMwxoa0GGXItRa9OQDQVwRBIpVBCKVDGQdsqgDsdJiLipMNLQEjXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwwEtezEJbrt/vTaPz8WIYkiKL9cwmrtvokmEE5t4CnxbTMnPB
	UCK5uXCEjZkHjDq01nO51bo5Twy9keYHSDSufaxJaWQrl0Gmb0d69SWj+u5upLfIjBE4tQ==
X-Google-Smtp-Source: AGHT+IG9+tJP7rcVhYR2srzYJXFwTOg0EBXRqoEhYIHwOJw5Kqc+b20iAmM0LQw/LoJ0TYVsQm3UCyyp
X-Received: from plwh12.prod.google.com ([2002:a17:902:f7cc:b0:21f:314b:a317])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40d0:b0:216:6769:9ed7
 with SMTP id d9443c01a7336-21f4e73bca0mr220424795ad.40.1739167114209; Sun, 09
 Feb 2025 21:58:34 -0800 (PST)
Date: Mon, 10 Feb 2025 13:58:28 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Message-ID: <20250210055828.1875372-1-keyz@google.com>
Subject: [PATCH v5 RESEND] cpuidle: psci: Add trace for PSCI domain idle
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

