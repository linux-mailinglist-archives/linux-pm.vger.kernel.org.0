Return-Path: <linux-pm+bounces-36276-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752F6BE42EB
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06C923BC936
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15434BA21;
	Thu, 16 Oct 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCQvoQeU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431BF34AB0A
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627987; cv=none; b=A8NyZwr5zc5jyNzHr5QC/UdmRstWdcIOX0QRHqhtEL1oph6cDzw1sv94s6Kb2gc9XL3XP6kWjzGYUx/hnr/5ov03AIFilLuM0i9q2zMTRNknujmTadmiII8v6oVZsfd3FEZX7RHjhkbgGN0qejjIvLhLCQQMD0TW9v5uduQZD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627987; c=relaxed/simple;
	bh=o5HEvZCwSuySR1jmKB8nhGyW1NxQC5ADbI+U76W6bP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+Y/WlUqfGf16GOr8cK3UIMJysosB20y7AAxzzSNsmtHtOYItzbttvZ9+M7iI8HtOUaZDHbr9OU2CMoal2SPNjNz8nmeBCZBfMd38zkFScVAffPh1X0urc7232MCX1oj0ew/bh8mNT8+FbyQrHruAGKFgZVbpNB8rDVTJiROgU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JCQvoQeU; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-586883eb9fbso1083723e87.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627983; x=1761232783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxV71jdmV/ByebbrIUZHic+K8dLTxGDirB2bOa0abyc=;
        b=JCQvoQeUGcxacX2D/AnYo3Dzm6vlttJoJjw8Kc3UEUKY2CMHSVy93nHE4vFx7OQ78W
         EdsaJ8UBLjOeSUG9R4+J5n8RtUGUhRZsF84bpy7wjtrwyGAliorbghL/8USrWbPx8ooV
         8AsydmcdifIGzanyUk/pKVTWK1p8IXYx1DaH1vu8y8hYVn75n/je7H0HdGzYCve1j+wY
         fvKcU1Zva4eBmUkkmz52Aebo44KaU+th4GKUV2DWQJLGv98KhT0+0Nb0dGHSnaE39x7A
         zF8uF9gYq9QCDlUW0+Mpsn45AOoBF/2hafMH8TfxHY95Al7AHmYZw7ZcbLkmP3VaXmHg
         PdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627983; x=1761232783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IxV71jdmV/ByebbrIUZHic+K8dLTxGDirB2bOa0abyc=;
        b=m0ug956FPuUPIYHdwxe8SsS/B5qEwIBpAv9yDlK0tDIqxTLKnRb3BE2hYrfjO5Ylia
         piV2vzdtn+/0gNYL85FMSgLL08Zq1ydxf9pPLovazcbbrgQC+kqQWJLGlnuNL/rX0n1k
         xnuHRdlx+XT/iRebUjFlfn2Dbxh0DWKv3VFlOFEpxIe1yoRoZyUn5CjhouDsv557FwT+
         ZOOA73UoezYe3B0e0uB1IdQJcweeSHMD8+kLGRVkQ4CrB9OGY7fAiSV+MWjIwFIYov+I
         cMBhCi11ihgrOJ2JXXWYi5QcnxhpE54F8GzaLusuICn+DzcTFOYYtXKRGqxcfxJ0zBBy
         CMFw==
X-Forwarded-Encrypted: i=1; AJvYcCUQu91WZvJBnSqTAEl1D6xAwMATeRN8/3DRvodS6NIzdaQnFPnDBLcrhQkxBRx+V8raGBJD+Pq5jQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzypZutuzoYnIvU4IfH77dT+z1k9j749JMDIWH7anXgYK0xGq/
	/60UuTA7ypxgPTHNuiTlA10Nbr7KCz/aS9xGcYW59kXnIWPwX8srv2lPZqFnuCzV49I=
X-Gm-Gg: ASbGncvuOP7JOGzUcmVg/iRGj718tbHMcr7TBTR8N5W5wT4tEfnsWijjDsfBsh7GYeX
	h7zmI7WPxnoKpsmlmW6mFF1X/V2aFGwNT3iuL+iqoaWS1COb+jL6rMIL7IoWWUBwpC3RUIchhAL
	hcc+LyjBuV2CiAW+i4IAxLTmNkRvWSji1Qs14B+zeTyryZ/bZiZrRZCCcKJ3HDbEJiFCFHAogOX
	6R/aXe7CCX1S39T+mTzIs7nbQRPCIc7Jzfl7qp+rhAH6EEG+8FP6mGKwzn+c8HPNRBuIFvafDVa
	CsDYieZ4eOPH0cQyPQT3lMstFfbR4MHNskKhv8VVT/96DU5+s9yt+q7wR6WzfYiDDIL3ZZ5BDzE
	ApwdQxPuy8yvAFGOMw+n45hp3fUDPAzAj1Y0YfNNa4zkuYyTwmmgUYc2njMQJ9+j/mF2/xCWbbx
	Zl9qjIOyDuOaEpO023VWTyFYFoyyD+PGHMkevcHk5ehXdG9SmBBCzLjKFZEGDzsS+TlBHgzUU=
X-Google-Smtp-Source: AGHT+IGvjg5uCswfR+tN9GifXO55mjU6KM6v0+HQbxwAe6xg9Y/5B3QZKxZkKucPhWtwh9KJ7o0QpQ==
X-Received: by 2002:a05:6512:ba1:b0:55f:5245:d695 with SMTP id 2adb3069b0e04-591d84cf610mr190387e87.10.1760627983295;
        Thu, 16 Oct 2025 08:19:43 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856397csm7150663e87.75.2025.10.16.08.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:19:42 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Dhruva Gole <d-gole@ti.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] sched: idle: Respect the CPU system-wakeup QoS limit for s2idle
Date: Thu, 16 Oct 2025 17:19:23 +0200
Message-ID: <20251016151929.75863-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251016151929.75863-1-ulf.hansson@linaro.org>
References: <20251016151929.75863-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A CPU system-wakeup QoS limit may have been requested by user-space. To
avoid breaking this constraint when entering a low-power state during
s2idle, let's start to take into account the QoS limit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

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


