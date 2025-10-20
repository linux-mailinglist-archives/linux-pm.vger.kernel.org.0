Return-Path: <linux-pm+bounces-36467-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A240BF1CB4
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BAC3BAF90
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 14:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FA03277B1;
	Mon, 20 Oct 2025 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YOY0t+JE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7347F31DDB7
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969856; cv=none; b=qu/FAEEjAnRhP1YEjA+hzYQFW6gOr6iDWkBHLBbo2apTNtMGMp6eu/p8ZZyuZNeX4R2NC3MZNpHc7QoIr0MHVJS49m7zQcs6MvQNvbOVpfhY/TbWEWmb5kDlX+z6HB9nd6YEzddCSNEuaEDeWRdW5ymyAoLn6aOQ9XfVIEHl16g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969856; c=relaxed/simple;
	bh=eCdD6Rchcv/zsQaGx/OdGmxf9oXHMxScoB0zys5/ino=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPeoRcVtJheA7/Y5jpe4ZgfF8QkpAHuC0ZId01yU6+VR45FNun8CXmMPEx/2wQHBM02TFcVvaHaLG9hsntF0VWxPO+zCUuBFDiw3ICW2hAw5oZEYWmMfk6nnTRxZrEhY8kSesNQgouk1boOYwVymd9ejBSJWI33n6H0yBUC7tZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YOY0t+JE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-58afb2f42e3so5052511e87.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 07:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760969852; x=1761574652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dIjv4MSR8RQ0lSEv7ckZWWm3B4P0BM3xvQjsLdtr2E=;
        b=YOY0t+JEj8PqO5EFgR4xi0QBd7AcusZkLFxxW4pc0J7eWCApyj9nUw0YGQdtXIvAYv
         Rm2QcopQfIZM9tGz4XNgh4F0uw3UVx45xC5U+X5ucNjDwDFycGMjlQBdsVSx28SzMFvT
         qmiAfxS9kDHbdefUtDhPteV5882doBDbvSxSCfWUWD8FUNeHHou6WO2Ib6ULqiXolsCO
         7+wjTTTCOXyA1Tw22pXjc4av92F5OMO4JmXctM499UIBFSX3V+Trzhw3/439RdsZHOX9
         tT0mpi77bE4aOywFGqpXRanb0csZ0G5PgH1diJ672Gfiol6+Eek3wCMjp68k+m4Xgt4d
         s+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969853; x=1761574653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dIjv4MSR8RQ0lSEv7ckZWWm3B4P0BM3xvQjsLdtr2E=;
        b=onFnXePZF6vV3sSRjdrDECUKCfVBEOtg3I7hKzDJZQZD0/UcYIC9joIUfJ3SbVk4UD
         E/VDfUxSul2EXLQl0VMpNOeFiswKDCy6VaqJIP/JX0hOpcRaixG1coT2hw4tQRpk2QQx
         fEs53uplgH92UM8qZ+HYprbUpIT4FcsBgekwH5j9N1aVMjeYfQ+x9SUXcRaY/zoR+OJE
         uaDbHO1n/8Y2ObKakpvOEFom54nnW8zbpjc6Z08MPVvxzFiV7NUs6ZTVuwFQMTf8kZ2I
         bmnLeOD6jjpM+OlPYI7pOF6xuo1Pl9N1NnEeWOzJCyTWvWOxDRx9JomwurUk2LOQQsum
         8O2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZu+uW+E6LVfvhX9nV9geTKpYdpSSwvpVRVgMr8vxoZgxENXYZkAHKXzzYRrgTjCMYveB2d/USlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEMOMpgJYGisGKufxWLhQb7xho2pbROih0aVwu89vTxz4/lW5J
	j5fOVZ47rYwcBqZsbDs2b7jRsYUaTJwQkyoJg4/M2xgZseNauHUz+bBwhowLQoktXBM=
X-Gm-Gg: ASbGncuGGb3qXo/R27rY9gEaZY0l+3Dv8qU5k2jiz9P0LLzfXSiYyNyB624BkwaqOIj
	UmN7GTrel1uB0CpXWZZOL4A0ry5DKPxzNNVuII/VX2hap8BuI8jitpf7WhHRghWm6kIjQuQi/S3
	BtJOEKofy/bJYiW3kFj/SJymu5eS/SlzuxjwYTeq4bwbos6ibLZ8esoWIuXJhTyVyAl6dd+2mc7
	rbj+nkbARHyWNdOsjwnudhi9tI30C8XfZ9MX3JkBcSe05PTYNulpLkSUgN2ovggAxhyq9Yuz4D1
	Niy8tkAW5QaCq8f6N8JpCD6jsMNZluL/b9nLoS9gy+06OypsWMTFoP0CYXKwXcA8nVMAaucL1BR
	UztqQAIznV03sg79nYCdGGOzx2Nb7rvuKvy5ez8969e6MlojtpqwbaE7v9doK0pVrcvA/KWY5cP
	Xx1pNU3RJUrMCr83WPvvxqiDxIz8Z4o2GeCRMwqpqbYyii0lYBpw==
X-Google-Smtp-Source: AGHT+IFC52orDQWOlIL6EQhuSMEzlEpPeXgxvFXygwzJXEOK1ypBXTxDyX/2RUJkJkcU3BSkgxWjfw==
X-Received: by 2002:a05:651c:892:b0:36b:b0eb:9d65 with SMTP id 38308e7fff4ca-37797815ebfmr36900691fa.10.1760969852425;
        Mon, 20 Oct 2025 07:17:32 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a950a284sm20797191fa.36.2025.10.20.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:17:31 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 1/2] smp: Introduce a helper function to check for pending IPIs
Date: Mon, 20 Oct 2025 16:17:11 +0200
Message-ID: <20251020141718.150919-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020141718.150919-1-ulf.hansson@linaro.org>
References: <20251020141718.150919-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When governors used during cpuidle, tries to find the most optimal
idlestate for a CPU or a group of CPUs, they are known to quite often fail.
One reason for this, is that we are not taking into account whether there
has been an IPI scheduled for any of the CPUs that are affected by the
selected idlestate.

To enable pending IPIs to be taken into account for cpuidle decisions,
let's introduce a new helper function, cpus_may_have_pending_ipi().

Note that, the implementation is intentionally as lightweight as possible,
in favor of always providing the correct information. For cpuidle decisions
this is good enough.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Implemented a common function, rather than making it arch-specific. As
	suggested by Thomas and Marc.
	- Renamed the function to indicate that it doesn't provide correctness.
	- Clarified function description and commit message.

---
 include/linux/smp.h |  5 +++++
 kernel/smp.c        | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 18e9c918325e..093e5458493e 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -168,6 +168,7 @@ int smp_call_function_any(const struct cpumask *mask,
 
 void kick_all_cpus_sync(void);
 void wake_up_all_idle_cpus(void);
+bool cpus_may_have_pending_ipi(const struct cpumask *mask);
 
 /*
  * Generic and arch helpers
@@ -216,6 +217,10 @@ smp_call_function_any(const struct cpumask *mask, smp_call_func_t func,
 
 static inline void kick_all_cpus_sync(void) {  }
 static inline void wake_up_all_idle_cpus(void) {  }
+static inline bool cpus_may_have_pending_ipi(const struct cpumask *mask)
+{
+	return false;
+}
 
 #define setup_max_cpus 0
 
diff --git a/kernel/smp.c b/kernel/smp.c
index 02f52291fae4..775f90790935 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -1087,6 +1087,30 @@ void wake_up_all_idle_cpus(void)
 }
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
 
+/**
+ * cpus_may_have_pending_ipi - Check for pending IPIs for CPUs
+ * @mask: The CPU mask for the CPUs to check.
+ *
+ * This function walks through the @mask to check if there are any pending IPIs
+ * scheduled, for any of the CPUs in the @mask.
+ *
+ * It's important for the caller to know that this function does not guarantee
+ * correctness, as the intent is to be as lightweight as possible.
+ *
+ * Returns true if there is a pending IPI scheduled and false otherwise.
+ */
+bool cpus_may_have_pending_ipi(const struct cpumask *mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask) {
+		if (!llist_empty(per_cpu_ptr(&call_single_queue, cpu)))
+			return true;
+	}
+
+        return false;
+}
+
 /**
  * struct smp_call_on_cpu_struct - Call a function on a specific CPU
  * @work: &work_struct
-- 
2.43.0


