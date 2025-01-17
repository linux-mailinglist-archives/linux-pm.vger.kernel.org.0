Return-Path: <linux-pm+bounces-20595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF8FA148AB
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 05:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23335188B1F6
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 04:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749241F63E6;
	Fri, 17 Jan 2025 04:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UoKuGe2V"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B076C61
	for <linux-pm@vger.kernel.org>; Fri, 17 Jan 2025 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737086506; cv=none; b=b/vo4mYqqIh8LmO2nGgsRQgS/5994Qip2NrzYtiBISdtvBzyI+h0wOjeakr+wg4qin18rHTx9O2Ou3C/Azmkgsw4pK18Wd/fmSLzLCcnh7rUHHB9JXrTiS2bgWa4Mz/5AzpyGTaxpk/LCaNY44613DJWGR3KvtNpX0XuCsRTwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737086506; c=relaxed/simple;
	bh=oPexBCHXLUBrYCkSK7CxljpUzgYwKpWEPaYZxRbgJRo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NFqQ8SvSisSk1kNQZm89XQB4vg+cYdciw0U2gLsGHtb0r1to3dn/MmNz+cnsUNZoEGHDEafkgrBaq7tQDNovKaeeIZQ3Km7ot5XF3e9hcTAwLAp6I++lV4UwwHH2QroXPIKeo3twrZkFjRIpC/mmkk1hz2lNZVVVUQDZrwg7+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UoKuGe2V; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--keyz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216750b679eso22654215ad.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jan 2025 20:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737086504; x=1737691304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CEiGuXqFpFvTFCSS6OS61iJ4F2JfCdl4C1VFaJs2q6g=;
        b=UoKuGe2Vt/j0fsq/mUajXBO0o2kgUDli7cvuBYR4+l/Tg9hSDCtJeYMZyd/8V3/efW
         rZc+326zUxoMPUyCQ4e+1DEhiu2Z5QhWUB5RAiGy+zc/3fMBDa0Rg9jUbimc0hahWdAs
         O+wDKC02IGhrU0BRvZTYCDdLDgfC7Ytw2iTXuLOS9K1bCZC8HtI4m7JAr3CXLJultjzU
         T/Mq//6LQue1Tgvmpy8FX+EbzHq94QLyIXHsR6Iv32v53EhyVAPB7Rg9LeGILtHltEjp
         2TSKcmUxGKo8IrDCXVcCW/dBqGKsA/LA5O4gI0KmaMZgYIXZHHfWXpTUh6PXwEHqH/Di
         pLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737086504; x=1737691304;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CEiGuXqFpFvTFCSS6OS61iJ4F2JfCdl4C1VFaJs2q6g=;
        b=pTC0fUBc7LZLJBMjNU/Sez141J8l7pVza/Zl2NtQDpqWzKkCyL6vnZTyvBY+gwISPK
         /OBaD1N3RQustX3przo/dfLqJReOfPqNXt1Elyq7WcSE1dJl+7RqOQrbkGgchRiXJvbu
         kxONgLB8TUhDBxsDdlSlXW1o9Mk3MYqsdjb3Seu0IRVMyhM/qWQy+EFLohymr0ixA4SP
         pxAWo3aCJ+pokpSGl16Ej/YYW3K/AdyrabzwvcK6Cfx/QNphnaJ2+pFsDOgX0fKcllzr
         tRpWhyC9wKm/EkkpIC9iYAtJX9UIAVMBmnStKtEc/WfKBRH0bd2ZtjbQSPzDuub+KA/I
         t4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+8PSafViLUyLnhdN6oVTnO58mSh935sLceuV6d3OnZp1W4bI/+ZGhSbZnq5dKZAicGO0spfm69g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxV4AUZRtbUaLEPWeRj6NrIA4f/V+QbVvraZPHRxqPd0Smu47UT
	Tu+fJ67T4WnBPDkBMsk0DNIm4msBOC7iQ7a9gAYwfOCAucWvFg9inXRElxsaOJvQoRJQIw==
X-Google-Smtp-Source: AGHT+IGDb+9WYwTzYDxn0Re4JPH7eopPvdlHxZjnk8qGZpF8HIzrHPuv1NxuJhAfSQuice83Hn/+/EvB
X-Received: from pgbds10.prod.google.com ([2002:a05:6a02:430a:b0:7fd:483d:9d10])
 (user=keyz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9983:b0:1e2:2e4:6b2a
 with SMTP id adf61e73a8af0-1eb2145dc2emr1465893637.5.1737086504222; Thu, 16
 Jan 2025 20:01:44 -0800 (PST)
Date: Fri, 17 Jan 2025 12:01:32 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Message-ID: <20250117040132.3237808-1-keyz@google.com>
Subject: [PATCH] cpuidle: psci: Add trace for PSCI domain idle
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
CPUidle states the power domain has.

Add a new trace named psci_domain_idle with a determined idle state info
before the state entry, and after the state exit.

This new trace event will help developers debug CPUidle issues on ARM
systems using PSCI by providing more detailed information about the
requested idle states.

Signed-off-by: Keita Morisaki <keyz@google.com>
---
 drivers/cpuidle/cpuidle-psci.c |  3 +++
 include/trace/events/power.h   | 25 +++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 2562dc001fc1..5888d4511787 100644
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
 
+	trace_psci_domain_idle(dev->cpu, state, true, s2idle);
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
+	trace_psci_domain_idle(dev->cpu, state, false, s2idle);
 
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index d2349b6b531a..82ad8bb1c477 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -62,6 +62,31 @@ TRACE_EVENT(cpu_idle_miss,
 		(unsigned long)__entry->state, (__entry->below)?"below":"above")
 );
 
+TRACE_EVENT(psci_domain_idle,
+
+	TP_PROTO(unsigned int cpu_id, unsigned int state, bool enter, bool s2idle),
+
+	TP_ARGS(cpu_id, state, enter, s2idle),
+
+	TP_STRUCT__entry(
+		__field(u32,		cpu_id)
+		__field(u32,		state)
+		__field(bool,		enter)
+		__field(bool,		s2idle)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->state = state;
+		__entry->enter = enter;
+		__entry->s2idle = s2idle;
+	),
+
+	TP_printk("cpu_id=%lu state=0x%lx type=%s, is_s2idle=%s",
+		  (unsigned long)__entry->cpu_id, (unsigned long)__entry->state,
+		  (__entry->enter)?"enter":"exit", (__entry->s2idle)?"yes":"no")
+);
+
 TRACE_EVENT(powernv_throttle,
 
 	TP_PROTO(int chip_id, const char *reason, int pmax),

base-commit: 9bffa1ad25b8b3b95d8f463e5c24dabe3c87d54d
-- 
2.48.0.rc2.279.g1de40edade-goog


