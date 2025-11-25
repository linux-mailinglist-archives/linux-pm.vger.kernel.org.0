Return-Path: <linux-pm+bounces-38566-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5513BC84BB0
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1A1834FE23
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F663164CE;
	Tue, 25 Nov 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="da2a8GT8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D93195E3
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070027; cv=none; b=qn5XNBchOPsF3DfJgnd7OmhNJWUGXu8giBRPmoFUjrg6ymtwUggxJBlHSGZgIOzeWGKWyCfQTBXuofsFblTBRrn1UiFJDCOFhvI/IvKLksymvJuHUN8v9ieWh8b4Bxoyq8JOJo4EOFHgPbPOdrzgYmXtHvCq1ILFdlIaAXH1rks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070027; c=relaxed/simple;
	bh=a/jMPuNL0LXh8mbOwFnvXiyONNtTPYp9ciUcBqd+xDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuzRfLBKipl6+NwNqlqPhjka4RmX2GWRBNLpDswTK9kVDdNqPx9r2HGonQTjnkXF5mhw5flxAwcIZQtYuCXGW0W9Hecm0Ua9VaiK44RtGmp92LxkbgNL6zLl2ZqPY+wj0ZWEUT4uv/QPgua+yYJfugJMmWSsIV6ys5fmuyB3Kog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=da2a8GT8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59578e38613so6222782e87.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764070023; x=1764674823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SsQjAUBc4I4Ftomg4p9T07PlaUDAMfxP/280o2pMx8=;
        b=da2a8GT8Q/R45NwSk4mrwYahro3DCk5W3ATU8pvMb+HgD2OjPj0RUlSKSKTGPTqQZl
         JXRsha9MMwebxH4O6jRwLRyFm4Q/otynOJTV0hFpaO/aS+v+hWLoo/9icvx5/XsFrlX8
         vwBMB1E4LNeDAj489Et+dB6tkpCo3lE+dBY8i+X8Y4YYtH68t2T9yRv9ckO7NSPi6uBa
         VwP4fjLwOeaMNixcXr7/cwLNL/N/KQ1MMoco+wGKnM/Uxrn3kimdzI8tujd8AvjIvZAZ
         KpZzU9MHgPzGinlOC/TYAmd1pUjhKxsI4aX+MLWp6z+BpnTLCxW+xHpdAm5p4pf9Qv3c
         VBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070023; x=1764674823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0SsQjAUBc4I4Ftomg4p9T07PlaUDAMfxP/280o2pMx8=;
        b=v+1dyLIqNzV8wKsqlAw6UMI9WbppJ+Ou4jDhvKaWsUypt/a3PpobOXVFIA551EHtbu
         eNFBhQduyD3ARD6cqqQB5kawjbp8x1Xlc7l5anPWBgo61QPxmbu68yLHDpHhvBlUE3iv
         EHmEvEDB0bnxl4EVIriwNuINoCzj7zuxiLwczbz2xEpv6RZm2G9lehms8scZlLdFQi0P
         Vhmh85GoGhe3Azi77qTAxCMu0iE/lPAQth3deHJ739hsEr5PNfdoPID6OAq28EfqcfjT
         CGM4AcCYhHKV23j7IMwyzGXsw/kVHaeC17Hi89PRr07aD61mgFi9HrG/0358c1ybvgRR
         Gu5g==
X-Forwarded-Encrypted: i=1; AJvYcCWyqE8QeWgrpJDl0THiJF5xIwsBjryCa6OmLDsss9/FLJKJlqrb6ooIr2upZTaOx6pTv7zysIlNiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvm4UYmgCIYj3vVOHtn41yc0GKlnRr2E3q6xgomXPKGfMpVN6t
	HYECK81rgDV8rXAK+Qa+kZO35osXNNfyNJp22fkJhNV13nUOCS3GiQsTi0gPLGVktcU=
X-Gm-Gg: ASbGncteY0MSItrKVISE8A3BWZRxMvlGDbTzN2rzV9uaPgctaPd17m2uDuU9G1Yx1gg
	na075TcL7W3sK7mouzk8EzGkehH2JmO6AX4JwqOF5DPuYNdV1a1mF68CbCNIls8b0tdcym8H32f
	dStIDe0+4CImoUFC2MDAZYsmLVzYgCXyARyizG2os7yS8jEefivY4bPVSLey1tYDucEk56eS7/a
	E7M85CAa3GUcgY1/9HhY1URBJY+/oYD84qopZs8ntgMjpaMYeYuhn06fYFkrohaM3HqrSqYoSFB
	yWXrWnHpHsBcsA/jFEi9xHk+EN8zQxBjllBKrwhxbbe4Z1HQDbhQDSC1PesQTscgZ38wSDQAMKs
	eTMfdq1918pO6nowcfm5uBdFU6wugiudUEJw7izC6/Kdt4d7/iEc1/N6RlvflKNuXfHiOVuFtks
	T/TxSBU6sjmIjQSvLmePEyeM4mvfDTr5cG10Fj0IwUka9TKIHbuT0V8ak5NkKr
X-Google-Smtp-Source: AGHT+IEFmutfa/ZxoF2Ngxs2HZf0XLR/CkiEIKyvnVme49BuzM4cktsh/YOqq0q7xYeTdoknxiJRAA==
X-Received: by 2002:a05:6512:3d91:b0:594:2f72:2fa2 with SMTP id 2adb3069b0e04-596b4e4b868mr949083e87.5.1764070022707;
        Tue, 25 Nov 2025 03:27:02 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db7563fsm4993526e87.2.2025.11.25.03.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:27:01 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Deepti Jaggi <quic_djaggi@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] sched: idle: Respect the CPU system wakeup QoS limit for s2idle
Date: Tue, 25 Nov 2025 12:26:45 +0100
Message-ID: <20251125112650.329269-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125112650.329269-1-ulf.hansson@linaro.org>
References: <20251125112650.329269-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU system wakeup QoS limit may have been requested by user space. To
avoid breaking this constraint when entering a low power state during
s2idle, let's start to take into account the QoS limit.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kevin Hilman (TI) <khilman@baylibre.com>
Tested-by: Kevin Hilman (TI) <khilman@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Added tags.

Changes in v3:
	- Updated commit message and added ack from Peter.

Changes in v2:
	- Rework the code to take into account the failure/error path, when we
	don't find a s2idle specific state.

---
 drivers/cpuidle/cpuidle.c | 12 +++++++-----
 include/linux/cpuidle.h   |  6 ++++--
 kernel/sched/idle.c       | 12 +++++++-----
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 56132e843c99..c7876e9e024f 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -184,20 +184,22 @@ static noinstr void enter_s2idle_proper(struct cpuidle_driver *drv,
  * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
  * @drv: cpuidle driver for the given CPU.
  * @dev: cpuidle device for the given CPU.
+ * @latency_limit_ns: Idle state exit latency limit
  *
  * If there are states with the ->enter_s2idle callback, find the deepest of
  * them and enter it with frozen tick.
  */
-int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
+int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+			 u64 latency_limit_ns)
 {
 	int index;
 
 	/*
-	 * Find the deepest state with ->enter_s2idle present, which guarantees
-	 * that interrupts won't be enabled when it exits and allows the tick to
-	 * be frozen safely.
+	 * Find the deepest state with ->enter_s2idle present that meets the
+	 * specified latency limit, which guarantees that interrupts won't be
+	 * enabled when it exits and allows the tick to be frozen safely.
 	 */
-	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
+	index = find_deepest_state(drv, dev, latency_limit_ns, 0, true);
 	if (index > 0) {
 		enter_s2idle_proper(drv, dev, index);
 		local_irq_enable();
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index a9ee4fe55dcf..4073690504a7 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -248,7 +248,8 @@ extern int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 				      struct cpuidle_device *dev,
 				      u64 latency_limit_ns);
 extern int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev);
+				struct cpuidle_device *dev,
+				u64 latency_limit_ns);
 extern void cpuidle_use_deepest_state(u64 latency_limit_ns);
 #else
 static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
@@ -256,7 +257,8 @@ static inline int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 					     u64 latency_limit_ns)
 {return -ENODEV; }
 static inline int cpuidle_enter_s2idle(struct cpuidle_driver *drv,
-				       struct cpuidle_device *dev)
+				       struct cpuidle_device *dev,
+				       u64 latency_limit_ns)
 {return -ENODEV; }
 static inline void cpuidle_use_deepest_state(u64 latency_limit_ns)
 {
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index c39b089d4f09..c1c3d0166610 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -131,12 +131,13 @@ void __cpuidle default_idle_call(void)
 }
 
 static int call_cpuidle_s2idle(struct cpuidle_driver *drv,
-			       struct cpuidle_device *dev)
+			       struct cpuidle_device *dev,
+			       u64 max_latency_ns)
 {
 	if (current_clr_polling_and_test())
 		return -EBUSY;
 
-	return cpuidle_enter_s2idle(drv, dev);
+	return cpuidle_enter_s2idle(drv, dev, max_latency_ns);
 }
 
 static int call_cpuidle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
@@ -205,12 +206,13 @@ static void cpuidle_idle_call(void)
 		u64 max_latency_ns;
 
 		if (idle_should_enter_s2idle()) {
+			max_latency_ns = cpu_wakeup_latency_qos_limit() *
+					 NSEC_PER_USEC;
 
-			entered_state = call_cpuidle_s2idle(drv, dev);
+			entered_state = call_cpuidle_s2idle(drv, dev,
+							    max_latency_ns);
 			if (entered_state > 0)
 				goto exit_idle;
-
-			max_latency_ns = U64_MAX;
 		} else {
 			max_latency_ns = dev->forced_idle_latency_limit_ns;
 		}
-- 
2.43.0


