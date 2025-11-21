Return-Path: <linux-pm+bounces-38347-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D384C78642
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C55B4E8E24
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4008345CC3;
	Fri, 21 Nov 2025 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIAeuc8k"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949583451BF
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719427; cv=none; b=nJM37lX5bumSqB/gUOxRekmplvTO6IVuUcKSVSZOOdXDRtotMmPCROD/uAjWFw6ud26Ec4s92SuVXBGjU1ngfM5KEWiVUd0ZCb+T4/9eBg/y4eO1neECK2wKrZsnJrWbcNbymY9r1bM3bMYnC0bPfvj6VaRNBH4B6txcxm9z4wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719427; c=relaxed/simple;
	bh=K3MxTv90njG8ObrSi5Q0KC7YVJRI9TsyV3oJl0B8R7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TcV9udSc6ZqBLr1bSdsm0rysOferRQRaAbSZcR8NkEcr1X7gq5CNsoQQ5RLLXtjs2Cp8t308VNbHaZUijAfEXo3mSoYCxhg0dfJveuDGQu4J6hvlzPuiX//AcQl+LG5dfbeD3M8q2rD2JLK6TkO8tad92h1aAsjbcu3aqRltk7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qIAeuc8k; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-37b97e59520so12183441fa.2
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 02:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763719423; x=1764324223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wc4a0PHuDmrPqR556Ou7IBfq8uevDM9S8fV5JzT1uPs=;
        b=qIAeuc8kArqRHlcMD++i7dCCQTOp7fQ4pyhPodrkpVYGfk+FR7/AslYHzg7Bg/2QzN
         /X/5opMVqvVXhsJbCwNsRpHGiSsiCbz6GTtF4Xa1zcT4sda+u8Ms7/UKNsKLu862F288
         uMAHYEu1Wis9cFBTneJ71FEi9mYy5atj3vgpejcAP63MfPgbgmBUzob4HHDzzE0BHFr9
         XjmoMekOF4An6IsA9xLe2QjoP3oBmpgUBcprTUgbT385e9jPfUiZLsqXx3Mci2k1GjF0
         xk+xxFh8yODFYfgGm1oS9aOoid3r+W62hB4lFA9EvryfWrd6Y4KOIHECyoR7jgBVOEZL
         Z2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719423; x=1764324223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wc4a0PHuDmrPqR556Ou7IBfq8uevDM9S8fV5JzT1uPs=;
        b=dFZ70xRvVDVdFzst49zCtinAP0CTwjSNom9yN7GB9Ul4y/feTAbicVHueE920bkxNu
         314pnCejIzlJMwbrJOjHi1Pm90IMP3Pb1ydaFodZ8SgK7B8UosPGPvUbDZYgDLIPJSIu
         tRYRSF2lq+UaFgj6xKYcpxvAiHmXQiPcaowJYR38ZzW35ar0jlLBclhUwwI2adICU4LC
         FCi/J/9pT+ewRrUPl0hSxL/y+6K4GVHCI1KbM3LhLQjKeRQPMiO+DZ3gUX21Mo5f/SqB
         /ndYXw9pNVxq+YS0eQKqMOQ1bJOlC7ZbYb3iOJlv75OT9cEMNMAzzE3Sl64RVAcB5zRP
         4FNg==
X-Forwarded-Encrypted: i=1; AJvYcCVpJeFK2EhViW2KRrWtfiHzO5wqh6wDa/CkKg7kvbiK4tyGrFb6LZUGoZo4pGgphp6nEj6gy6AzZA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCvNdn6pdrvKhzVUY++M48dVdGhjBArRoIqOPHWKsGpUR3Fbf
	5NsW7b9x9AxC9ah+SX0Yigsv6bAosXuxmwz937bkMXF+P2jTYXuZpedrnhRdRD0xNTM=
X-Gm-Gg: ASbGncv5wSwtei8lzvuGHCgC46BboyhhxXF9lPSYNcSwU2Mb3966FWWxpFo/WkAOZGG
	+yBBrjp/RdFg3GMAr6He5jOnem+IyGb0PW4QBbRHpjpbw67jMtKDfHI3jjniSR9uR/TCoVL/++U
	3PJlnZXlozxxo6QT1i7sOaoAP+ewptecEnCWttMRtpKtfRybp9K1fWjmHN8I3dX4cEdea4gtAUw
	qqtR+T+wRSdRonPKvRGPxlDnHQ7Q7K4RIAL9JtdSVl5oqHk3IR1Ob8A9p7aYg5v6panWkg/75GM
	cbNJt/Qz2+RrO0DH0VzP2XcdRuv+CCdTPACNCEnkBDCmCxKSZvfvLkSV9gB7mcmJY2/tZvcX99G
	9848zua0HrgcsvOyKZDOwMvqfp31wsqgzyXKTuAmWEolfylNwJ+ziZvthJqHPypvHh270ldCMTV
	etuB8SoMHTCa79ojWnbfuQlgsI1rHOsL9phN9vrxZlm7t5AWQN94BWSGQz+5Gj
X-Google-Smtp-Source: AGHT+IHqTYQeVPe88r/RF7U4BUGHstho8L55Y/bCN09qnK5NUE1fa5dy2Zd0wMboPTMi78eqXpiy+w==
X-Received: by 2002:a05:651c:25c5:10b0:37b:a4e2:43fa with SMTP id 38308e7fff4ca-37cd92bf090mr3845761fa.43.1763719422602;
        Fri, 21 Nov 2025 02:03:42 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b597b2sm11056181fa.12.2025.11.21.02.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:03:41 -0800 (PST)
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
Subject: [PATCH v3 4/6] sched: idle: Respect the CPU system wakeup QoS limit for s2idle
Date: Fri, 21 Nov 2025 11:03:10 +0100
Message-ID: <20251121100315.316300-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121100315.316300-1-ulf.hansson@linaro.org>
References: <20251121100315.316300-1-ulf.hansson@linaro.org>
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
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

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


