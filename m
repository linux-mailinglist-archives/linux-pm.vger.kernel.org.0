Return-Path: <linux-pm+bounces-38567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E76C84BAD
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 128EB4E8E0F
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D577314D3B;
	Tue, 25 Nov 2025 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ux8eod0u"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82140319852
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070029; cv=none; b=ATfBFf9qOXsPwxEy0SeEPUcc7bQyIAzGMgZPUSafKpnXzkdnrQ6Qmc9CRj9dV0fBpl1JgU3TkO84mM8JUf7TpUQdvazWaPbl5dqwwEqFEoOzp1MnQpK42terp75u6SQJMUJ+G5gY7mgJ3wStKPEIPDAvwDUDHGurim47OtK6PbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070029; c=relaxed/simple;
	bh=VU9S2gTiBfBqPpLuX8g7itKZUK/ev7QCKE78FGsGaTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG54Kn2M0FPnxR/UeuMsFV7SDJJSkGcjAu9nXOrA0iLXbzR2rpwXCackjE295owfGBjU7ICAbDjfjrGy//dVB7osP2rHDufF3XMy0BZ5ZvXX0jZ4C45ATUSiWmeNDw3UPmfHq2lBkowK+sWEci3Nje9qQnQQVb3VxLeZRJrodhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ux8eod0u; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-595825c8eb3so5443929e87.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764070026; x=1764674826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXSNim2QNAEfMWA0bqcIei0hGjp8YF0YF97p3EaO60o=;
        b=Ux8eod0u+Fy8rtcdbn8XIk9YEHpLbVTxHkQxPwGD5Rp0W5PTMR1qbtlLVB+pXojzMu
         nzIf1HKsrgtE3VL9gtS4fcmxZBj3H8iEdD6LcV4WyfBwSGFVtoQO1ndMQGGCstlzzcdG
         Tk0Sk8KvSEH5G5iVojvQo9jsRUqWDZXdlx439MWqV4jt+WDOtG2AXVwWVLzomYErJjKp
         UYe0ynJ7a9AWuwgCBk37jSNba7fNoj4f6nhxW9M//j+U2ofyifmSNOUfMKd0a91QvmFR
         1hajsQpHZ1FiQduR2+tB44LtKxDRm4bQqp3EFC+BhjeYAcI3slAX3Cmvxii+e2mxAz3x
         Ktmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070026; x=1764674826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXSNim2QNAEfMWA0bqcIei0hGjp8YF0YF97p3EaO60o=;
        b=wWdPbbkGazPqxU8t2ry6p1+qU1PoIl/h3tVuixK5b+nVLfDMjurRHAFVqo7CQMWSjh
         IPhdOMRoWU13mHpkhl1o8iA/Aicsm1pp+zGK4XsLX1BN6vEMYHL99Snn/zphkHZ+kbZH
         Cl1OXmwyYyAUz4uvRxNEJmy+Ogod8Vr5jemXrEwv4e6SZHvQogfV5Ro3ppz0UssBGqBs
         1cccE8KcMMegigoDQNkGaUjWWRQpep3lq6ee7/B8JXOljx3+XZlztGYqnfVRsCU3Wjv/
         TZTPFghAiVHOG1Ii2drP6GZhb+883yp5Vmnz+iqqvwUqeyBy71qZn/6f2zp81LrmyZ7W
         Ax2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8NdEPsRrbglWg+AG1MfVJ4DMx8bEzz5Z7En3fqvFwLwpWwg+tvOigs8RKbOF4kO3yBbRlzWm2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYj8tmoZOi2T5OfqWZLXPBLfa0o3EC1n9VMXhR1+2GFxO2Jynz
	Zs2+devJJs57Dc0qRtSASd3uhEWsPNxxp2TG14s385B7coSOx3sEfoeV0QIUuLNTQy4=
X-Gm-Gg: ASbGncuMDo3hAtjNpOQYcYiheX+qLO42T5Hua5NpdZdB6TL1s0zlXCYIqHRFAcJDzB1
	buy2k402BdlMCjQwRgxCU/B7RY5/W6Be43JA7mMXvqTCOyfLB64hU0MwWFAEk+PiQuTHBxzH4br
	dawiwdSArBr44xaGV1jYHm5bIlw8v99ByiLixUEbAefKvhAVE2JCAptL9s9TcP5d/xPbgB5rwu8
	JEf7OB1HhbcAcTiJtKjZeWNLfJiUmLQfgg/aRV3Lrru8CMg0ClXwJT+7ww50akSaz8LrZE5uVna
	E3USmLxN+lCwJbjEoAJh0nkUGfzgrhLhTgqZYwBj0M3GZdQqzuCB4J6hong73prmBnNcSN8N4BC
	4wI+hc9V8fAtP2oWMqu1WOeUEGH4ZT6wwI6I7ShUkFfeCTkGaw1eZDquCwSkXwrfG1/CRf9YIT3
	cuQiOg7/CZ2x9rhmWaqz3Z6p3n1Bu1ia7RRKbKjZEpIF1CV/1L9HWIBn2rmhqy
X-Google-Smtp-Source: AGHT+IH0spmvYE7vsLYvU6CWBQu+9dSmSus9W4Lq8aSvY9tGf9JRWtAh5DwE7Z4KHFl6BrOxsXpyVw==
X-Received: by 2002:a05:6512:b0f:b0:594:2b58:ab83 with SMTP id 2adb3069b0e04-596b528d61amr1089814e87.40.1764070025793;
        Tue, 25 Nov 2025 03:27:05 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db7563fsm4993526e87.2.2025.11.25.03.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:27:04 -0800 (PST)
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
Subject: [PATCH v4 5/6] cpuidle: Respect the CPU system wakeup QoS limit for cpuidle
Date: Tue, 25 Nov 2025 12:26:46 +0100
Message-ID: <20251125112650.329269-6-ulf.hansson@linaro.org>
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

The CPU system wakeup QoS limit must be respected for the regular cpuidle
state selection. Therefore, let's extend the common governor helper
cpuidle_governor_latency_req(), to take the constraint into account.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kevin Hilman (TI) <khilman@baylibre.com>
Tested-by: Kevin Hilman (TI) <khilman@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Added tags.

Changes in v3:
	- New patch.

---
 drivers/cpuidle/governor.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
index 0d0f9751ff8f..5d0e7f78c6c5 100644
--- a/drivers/cpuidle/governor.c
+++ b/drivers/cpuidle/governor.c
@@ -111,6 +111,10 @@ s64 cpuidle_governor_latency_req(unsigned int cpu)
 	struct device *device = get_cpu_device(cpu);
 	int device_req = dev_pm_qos_raw_resume_latency(device);
 	int global_req = cpu_latency_qos_limit();
+	int global_wake_req = cpu_wakeup_latency_qos_limit();
+
+	if (global_req > global_wake_req)
+		global_req = global_wake_req;
 
 	if (device_req > global_req)
 		device_req = global_req;
-- 
2.43.0


