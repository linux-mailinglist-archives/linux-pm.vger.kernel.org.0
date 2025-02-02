Return-Path: <linux-pm+bounces-21218-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F81FA24D9B
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 11:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9455E162BB6
	for <lists+linux-pm@lfdr.de>; Sun,  2 Feb 2025 10:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064F61D5CF9;
	Sun,  2 Feb 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dlw7/kx0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f73.google.com (mail-oa1-f73.google.com [209.85.160.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0AE1C2DB2
	for <linux-pm@vger.kernel.org>; Sun,  2 Feb 2025 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738493187; cv=none; b=B1+TcAatMFcEfkLnp9u6R18u+rv4Yqwqi3wdL7Or8O3BeiALV7y+nH6yGpR3bbMLHfYZbpX779zewZdsOkelipywlLoEIVKADTGKYeTpkCBCMnxGTMMnY1mwCS+bxOIIDsMVwXCjI/fqxfIwmQx56DsS+x1zm3Gpa5RLq1zkTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738493187; c=relaxed/simple;
	bh=V91tXNzAdXqNESSuCcPWWbIczRsNrhkliP4NWdtOxqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fBgEZ7pMoVtt+Uf48GVVdiGqV3p5rWfe/6IvGYyie232gAkZgYS9tOTFpaSh15qzM6/R+RJQvt7VCfGTv/TZXm/ElOmXFg9OK3vum4CZUvQibavSNotRj25PPcEXraYIPPxFG9SU37Z0Ljt/ckWy+qO93WdkGNFtriNNU54oueU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dlw7/kx0; arc=none smtp.client-ip=209.85.160.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-oa1-f73.google.com with SMTP id 586e51a60fabf-29f7ae58e1dso2832560fac.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Feb 2025 02:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738493185; x=1739097985; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3C2xLoRMIfh9guNa3H0W/wWSSoS/cl6gF3LZgXvK/eg=;
        b=Dlw7/kx00Z4+0QULrgp6XMlXsS9PQ3FIAS2p4ruV4f1DAs89WgCJFlSGkRmdQTxQZV
         W+EZpql/lZ4RctImaglJG8OdgVULAiMd6wYmI+pYv4T7lPI3CKkfiDs9CVHlwSzBQ09X
         79iPnxsgMvM/YDeSE8H8xIex1Pyn/DXFEll3Wyn+u74Ft8ZA1R1QKJKvTcUDe/3suHld
         rpugDiaa/Syu/IJBmKuhuvUKussl0Dtn/gCva6nk/xmE8zAZF14L3Rgp34UZri1Ehu82
         IC/u9mVXw9hwQe9LSO07kKd3iekoAFMnPgpoL3J0JCSF3e0zuyYmdnTDqP5PsWArWLuZ
         AL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738493185; x=1739097985;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3C2xLoRMIfh9guNa3H0W/wWSSoS/cl6gF3LZgXvK/eg=;
        b=CB3+0RLzVkehp53alvd3aFKoQ0nBeGzshMuvKARcqEhkGZ587zhvZW4+cynuhgQ2nQ
         FwLiIyoNAXIqyh5cCQYduLCx82UwaFYE/1f7FirFy1pNP+HM5nesWVLmx14/AXwQAza8
         q/ELimeaq07UWb9nDWjkPBcQiGuN8HYl33VK4bkxCv079wwmnq9rXO0fLGbjqA+4oUsL
         RCBlOmhIVr+ipOnyj8wOobLLYvyhdU72jR9WCRday+v5E/zsK+isnFM8zeoXDCFhvd7d
         ioV6AFa26j6tt+daNuJa2g0jRwsRCVYfk5HyLrJboqZWvWol9RgQKh78oOH842pxlIKR
         xuQw==
X-Forwarded-Encrypted: i=1; AJvYcCVcEiw/V4SQp/o1Eh3MVqKatEu5tVgbJVtSUAxuzW3E3/gvsAjkFq9AxHs8mDOQmGAFQjyIdGQPig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmkyaqg8R8Iw9UbvqzxkFDmykD+bJ8/NW4V846QqAvtXpeQWr
	jYOrQ5pcxnTbjPsIh66hHU3trAhwBmzCu1U6TDxxJ30sWpyn1AF1KFXLsQumZOAS69JZ0A==
X-Google-Smtp-Source: AGHT+IFA7EeeMSaBv9+TD1KewKhwzOrN3yAWQrZnYxLJhkkZPZQV/mXMgHU8IDLgNyajd2csxqRgpEsc
X-Received: from oabti2.prod.google.com ([2002:a05:6871:8902:b0:29f:b0d9:2922])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:a513:b0:29e:37af:a943
 with SMTP id 586e51a60fabf-2b350002b1emr11294523fac.18.1738493185421; Sun, 02
 Feb 2025 02:46:25 -0800 (PST)
Date: Sun,  2 Feb 2025 18:46:08 +0800
In-Reply-To: <20250202104211.2764016-1-keyz@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250202104211.2764016-1-keyz@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250202104608.2766080-1-keyz@google.com>
Subject: [PATCH v4] cpuidle: psci: Add trace for PSCI domain idle
From: Keita Morisaki <keyz@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	lpieralisi@kernel.org, sudeep.holla@arm.com, rafael@kernel.org, 
	daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Cc: aarontian@google.com, yimingtseng@google.com, 
	Keita Morisaki <keyz@google.com>, Kevin Hilman <khilman@baylibre.com>
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
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
        and rephrase the commit message accordingly. Rebased onto the latest.
v2->v3: Add the Reviewed-by label
v3->v4: Add the Tested-by label

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

