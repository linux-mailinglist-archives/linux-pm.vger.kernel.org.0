Return-Path: <linux-pm+bounces-20658-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBF8A1652D
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 02:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CB47A1811
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 01:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907E68BEC;
	Mon, 20 Jan 2025 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yaUsNjJZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA3F63CB
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737337052; cv=none; b=sCK0SxkxWmVOs2uvxQHfsd9Q7lYF4SI9bYk8hibU0Gjr2TVSHaPcZBcQyX3wjZohI7npjjGpRQu7Y23xD6tfX3l25qfajr1aJ8mazESbYx9L/6HcFIwKEt5zkR6IP+svLAwLt0ai3tXRHMvysoHqvTYDhq1bTTP1KUNp3dRKDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737337052; c=relaxed/simple;
	bh=rCmnMKKFzku7FqSoKaR5AwFfRv2POEJpFQrVLWFD+Fw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mbDUth3MqsZgrMFGDJUE+G3K/NbjS2+EkFM1hqMTwQ8EMN3SWsXPI7GVteAHsbMcjtU7OkFphUvVFSrXK8wk+KDJxz1Ho2iyReQxaG09x6MKoqlVK5MaCR+PaUVA77BhU6ngZ3p61V/dQlxMeOyGrDnaeMwBbUgcOWG+EE8moJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yaUsNjJZ; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216717543b7so108928355ad.0
        for <linux-pm@vger.kernel.org>; Sun, 19 Jan 2025 17:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737337050; x=1737941850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y6VQnIfvZ/lup9D+mQ3Zzp+UehiZWo7JVkyFBohiYU=;
        b=yaUsNjJZNXzjriprtBzovkDrLjlwtd2qOoUghY9pNKiS+hW+d8nKFOhYDH3bs49W2R
         51FDwBHrmSuzeY6f5SRDu+NEi4z8Ta/F9RHoJE0XH2lIgtQcAcz5x+IFl0laIpRnNdTz
         wDtNkUdppzU0UeYDfYyXAxw6gSoL4Z2mrjmUCjFiVS7w9kAiDZ6RatotpCainuEiA987
         GbtQV0CBs31pG89McWbSfmPFy4V1Z5QCq3gkdUopgSHL9MBWGKmy5LUGyiH7L6T8r0eE
         8sWYgm2kZRhEEByxZ4rekuR87xqiKPuTrfnwD2t7XH3/RUEKob+h9QAbCTixyeRVCrEm
         5Diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737337050; x=1737941850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Y6VQnIfvZ/lup9D+mQ3Zzp+UehiZWo7JVkyFBohiYU=;
        b=jvQropOIcI/e4GtzmM65Pld3acJ7ZTXDP6TeH1VPex1xgODEHijpdSrNObYDaGx2Ed
         nzD5kph5q9bEJwNZavz1b7hb3CIF8YBKQK9/iz8ojA2CIPAEscksoqQpK1Gavohy8u1X
         rSwGT6lyckmfCBoAX3eSHnNQLJ5u8hAzIG60FShz//NXooDOfFzUL3AJBBOvwt8KBh7x
         ZRV55HwIv0MoYHlaTFpNOVYfwX0b9ie/RZtrPu+dcLOkoyjNTpV1YX3m7UaiKNb9DIfP
         TX5LQ8+46c+ZI9AHJbkJSV80NyLsMk+O3X+dWGP7CMpliqPNQ5PEJSEF1LVQbCF32tvJ
         hMmA==
X-Forwarded-Encrypted: i=1; AJvYcCXM82K90x1ukFmVS2S9pT4W51zwan6ri6G55vBa6TeQ/8ehZuh1t3TLV+CXCbuR02UXTZIDeCtgQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKUhawoHynLjmQyynfMaV6CMWNQN9g1qNHV4JVLYl86D/kFls
	EY3p2ZXQI0pHkPA2xVpmHxEc2+dJGJMURkGZIkH/CKrc0fIhmW54vHfjtQr5W8uhU0NEbw==
X-Google-Smtp-Source: AGHT+IFSAReJ7jfnKMa4zOYU8azU3lnxfGKU541snA6s900oDc0E7ZeapZxnmGB+S+Ca2EEFShI7I57O
X-Received: from pgbbm27.prod.google.com ([2002:a65:6e9b:0:b0:7fd:5722:fd50])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:564c:b0:1e1:b183:2243
 with SMTP id adf61e73a8af0-1eb2160f8c8mr12995970637.39.1737337050122; Sun, 19
 Jan 2025 17:37:30 -0800 (PST)
Date: Mon, 20 Jan 2025 09:36:16 +0800
In-Reply-To: <20250118072438.3647805-1-keyz@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250118072438.3647805-1-keyz@google.com>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250120013616.1116126-1-keyz@google.com>
Subject: [PATCH v2] cpuidle: psci: Add trace for PSCI domain idle
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
---
v1->v2: Split the ftrace event into two (psci_domain_idle_(enter|exit))
		and rephrase the commit message accordingly. Rebased onto the latest.

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
2.48.0.rc2.279.g1de40edade-goog

