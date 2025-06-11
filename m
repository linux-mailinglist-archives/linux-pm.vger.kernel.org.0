Return-Path: <linux-pm+bounces-28431-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CD4AD4946
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 05:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFCF17A3B7
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 03:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B2517A300;
	Wed, 11 Jun 2025 03:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbqNeZ3E"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B76E35968;
	Wed, 11 Jun 2025 03:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612199; cv=none; b=iJB69QJ2AVEQepuBVFRNnz6rpeyP1J10tTW8nVZ2OtvicQn8zC8OvOsMoPO7nnOoDFCMWC9+a3o7DuDGUXGdhZ+dsM0o4QAp7ZUKUtzlfHHse7wyJPfpTMHkAyybkPNUQrPLxcxabG98ydEhwlKgS5Hckf1eUgW21jspjCHLe2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612199; c=relaxed/simple;
	bh=DT3xhTrEpNyyEmwRD93HnFf0aQFO0HQD1DP7C+LzMbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rf5Ww6XWdZHRyIihBihLolaFVmXFeZ7tqAZY3NIQfBTtb+IA627QEHC71I57ZqqmIDEJKBVzeJRmr3wE4ccuSNwCCecWaq1uHr3DZ5SQLjZUVG5V40nn/9V/RVPWh2NPnmRFgnFUb3XUw0iojj9JJFNpxjf3LuSk03kcYOvGstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbqNeZ3E; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-235f9e87f78so56642975ad.2;
        Tue, 10 Jun 2025 20:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749612196; x=1750216996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j8M59GVJK+m+6scfgTZEGFhkXYH4wMwQFS/55/hIcrM=;
        b=ZbqNeZ3E4iPZKCCmgymR3t8ZG8e1Q9L5b7J8VIwe38DU2DmEaDUfyqwtqmUHodYyN9
         JtTCjGCdcNTzdPo3YKtv7yIqPiCVVZM/gsr2d/KbU+lihpx624gk+QvAQ5VuBeNI1Ch9
         6oKOXplzmMWOWiFdXEvmti5iCM2y22OUyFJCyiu2mlEG6IOxLd6LN3XXemuR3SePqv8r
         gH9tXjgaMF9O269W6BYmC8CylvWtBFnzATapQA4qxCfKOeDqPpv/eqtlvY9m1lXZZDml
         U0AaQUrOHgDK5NP6R8gs54X2Nk9jyTiARZ8EVLRbPb97FmL+UBFc7Z/ahV1/CbCQqhyw
         i+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749612196; x=1750216996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j8M59GVJK+m+6scfgTZEGFhkXYH4wMwQFS/55/hIcrM=;
        b=Bfmt0YUs6xXeOu0Y3UGUQ3JcBbQB0aeeWO6C+LvnIBDAae8TrelKGGTSwBh/2ATLhg
         K64I9lk8mMZnYLBF/aKzxclDsWgHOQ+oxHI022LsiPuf37KbOKTVKzzqImtr4E1ggwsY
         A3toWBMl7l0P0U9fIwCDqxsXrECqSVOLdTEkTR9OZmwfVkJM0VtFL+bLLv0iQbG9seut
         jK/TJ2D2VRrUX9i0qQxNYExNs2wnoA8yKR/WVU69R6jY84dUl8z6W0FVlwNe944l7YrK
         bR3bMLZoDK/hZebZ9IKhCvdANtw4DIIdYJ84mXSQzOjMHmNwdCgxZBZQMpagQIeMU/dC
         pq0g==
X-Forwarded-Encrypted: i=1; AJvYcCVhClGukmZyY96Qrj4SUUVhheLEoywOpzPLz+KihiNRk+d7dpUnthJpA3r9W1czT44uEUbspfUimHkZDtPUyZs9gto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Vlyf0nH75bQyVhJ9ck2wFN3raKIJUONcQ+ouuAFKYLIhXQ9o
	GHpnOLOmU3F1CmpCwAqJxdtjy9BwfBMDG2giG3ZjsoY9GBOAfdQuILsm
X-Gm-Gg: ASbGncsSgvDZXB2jAbMoEcSsSL5+xdkGZnENXpPHXCoell2LtCOb4aADwdhHRQjKqSt
	ck/nheZKc3DfI1W5rZlWJk9j4T30Y6C05FQkiEJjvKuYN+3u7kiQi1XmLnDbkH7W2HXn0z9u8e0
	s0EWq81fUFYyTmmZP0bzyJw64d1PhC3AvLOMC6aQ6sEg7+J+gvCW84qVsTqnXFR0JeQLviBvYll
	5dAI4LH/Y5GJW1rGIy2YK2w3SUXC9TRCYI5V/KZX8bQmPAaS6ir17q7sJTQewRn97HjRgWl47QD
	5KkNmTwCkF9dAMGPdFGsPLghHdflyK8S0BF2XO+AvQNcutIxfXzPZCEhNqVu2IOGtUY0owU=
X-Google-Smtp-Source: AGHT+IEYvVxSEokXxXfUmmUN/xGq0Z4cxg3uLBeIHKJNoD4X5pLXSHSHTw50yYbQaikjFY1sapLuuw==
X-Received: by 2002:a17:902:da86:b0:235:cbcb:48b7 with SMTP id d9443c01a7336-236426a012fmr17785455ad.34.1749612195703;
        Tue, 10 Jun 2025 20:23:15 -0700 (PDT)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034109cfsm78156015ad.200.2025.06.10.20.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 20:23:15 -0700 (PDT)
From: "qiwu.chen" <qiwuchen55@gmail.com>
X-Google-Original-From: "qiwu.chen" <qiwu.chen@transsion.com>
To: rafael@kernel.org,
	daniel.lezcano@linaro.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: [RESEND PATCH] cpuidle: Add find_deepest_state trace event
Date: Wed, 11 Jun 2025 11:23:10 +0800
Message-Id: <20250611032310.10610-1-qiwu.chen@transsion.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new trace event namely cpuidle_find_deepest_state to trace
the found deepest idle state during CPUidle flow.

The new trace event will help developers debug CPUidle issues by
providing more detailed information about the CPUidle states.

Signed-off-by: qiwu.chen <qiwu.chen@transsion.com>
---
 drivers/cpuidle/cpuidle.c    |  2 ++
 include/trace/events/power.h | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0835da449db8..9065aa396892 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -103,6 +103,8 @@ static int find_deepest_state(struct cpuidle_driver *drv,
 		latency_req = s->exit_latency_ns;
 		ret = i;
 	}
+	trace_cpuidle_find_deepest_state(dev->cpu, s2idle, ret);
+
 	return ret;
 }
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 9253e83b9bb4..82b5ac8c46e6 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -62,6 +62,30 @@ TRACE_EVENT(cpu_idle_miss,
 		(unsigned long)__entry->state, (__entry->below)?"below":"above")
 );
 
+TRACE_EVENT(cpuidle_find_deepest_state,
+
+	TP_PROTO(unsigned int cpu_id, bool s2idle, unsigned int deepest_state),
+
+	TP_ARGS(cpu_id, s2idle, deepest_state),
+
+	TP_STRUCT__entry(
+		__field(u32,            cpu_id)
+		__field(bool,           s2idle)
+		__field(u32,            deepest_state)
+	),
+
+	TP_fast_assign(
+		__entry->cpu_id = cpu_id;
+		__entry->s2idle = s2idle;
+		__entry->deepest_state = deepest_state;
+	),
+
+	TP_printk("cpu_id=%lu is_s2idle=%s deepest_state=%lu",
+		 (unsigned long)__entry->cpu_id,
+		 (__entry->s2idle)?"yes":"no",
+		 (unsigned long)__entry->deepest_state)
+);
+
 DECLARE_EVENT_CLASS(psci_domain_idle,
 
 	TP_PROTO(unsigned int cpu_id, unsigned int state, bool s2idle),
-- 
2.25.1


