Return-Path: <linux-pm+bounces-38348-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9214AC78639
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 080673562BE
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D8B3469E2;
	Fri, 21 Nov 2025 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lu8tBGuf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF5345750
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719429; cv=none; b=Qlx1QtnGYF4We39L4VKhXHctuXPRLoL48zHgzx4/6UK2kTmbeytznx9XkhJcO+0NyGMe8vO2OV17z06E3Di85phZZDHK6Ntb5IZNK4HTtI5ZzuhgrBbOO+6dnxmr2KUTFiyf/lM6/QNEh994RO/n6vAOpM8gKWbZpieLqzm/U8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719429; c=relaxed/simple;
	bh=a/PdidFVEmt+TuSU7dq0QFOPXPbHQ7yt6nQ8TU7n0i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMvtkAo8qfAap4RB6TrZFZxKipAEPE7dRkdNY0LQRkHKYttmaZspq+ubP+LtVzUIzB7V52NU9kXJNthS9/rl3jQzq5pA63yWth1FhlB0j2cspwhZOmgeCT/cLV+1++RMgGmDYP/r1CzKcdnFwXhp8itrBUbvsVPxV4R6EefXhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Lu8tBGuf; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37a56a475e8so14501301fa.3
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 02:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763719424; x=1764324224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPQNRRhubvM7zCEF89wCepqwWloD8O95karvM5Uhkuc=;
        b=Lu8tBGuftnjRYk4hnFzE9ePfDfGGBDbhz5Ze4eQKpeKDnpkHAqCxOpy03q6G2WOGY9
         K5mDbO7vGoNe5rvAVsvpYjolTdFmIByWdkxplZy0VyleiRmUQxK+PZNojsaWxK19YSyW
         /i2sBni0yom35+v8LE5q+kegq+YXPdXsptG7VrgNLltEXvko67l4E2q0LHaZwLzmrUuR
         jbvJUT65WZ0HWAEs+u2DFiV1mfU+f9ks7bqMowd58k5oYC65hKWZwZDT2l74KthOr/Ct
         lZEku2O1rFvLtKc+aLVQ9U2XooSmLVLkSOcuXMYjLY036CMyAwZhtx1YFt1NInNvAJV/
         07IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719424; x=1764324224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tPQNRRhubvM7zCEF89wCepqwWloD8O95karvM5Uhkuc=;
        b=I5E0DmqzNLaEc+I+b3rl48Fh1zalvFQzJIiZP7rPqSGArnEXh9YQQLdnPO99Fk3ygN
         07602ghSH4tdqGeUOpdWjKlHBXJ9j7W0/RN+alhEMDzSQDFA+PBvupjzyZuyuHMWPZVa
         +5kDXvvgJHS/8uh9QtcgIaNDZsQdVqk036XkAtmp32jktsYiQhnmSA+EYAX+qj08J8KS
         iv4tYGbVKjp4hG8VZ3sUY6dPANkD8kb4EF9gIOwWaex4dLNO0wBncqFf4YeZhzOjyuvT
         A3WOBOImVM0iD8Z1Xxaq4Hj0+lrJwAS0Y7OrJJaHKxS1PAcyqRRLNzeo8Rt/9IzJJrvX
         hZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCVYTmhcuxHeHv+Rbm3qni9JI/E84RciMorGCZzJxGHf7GJXOWMq73h5p+lCyoRth7eV/eBO/D319A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLLHT5Y0WMDSaDBl1TlZSt2EaBTUeVOLTis4qk4FKkD+Z2+aG
	2+O6QX66vIy1gbpfIA+8xRYccMm8o4vrw7ugsUBnk1XaNmAJXJUZ/tVg5ujkhURnWQY=
X-Gm-Gg: ASbGncvHn8ffueG6+bxrbAQsTp9QewXzId5M+NsoPTa/2llBLcOmmgAR1SaoW3LKeH2
	2RJPx4Qi7AJTUTe/ez5O6RjFdvycFVNPYubU/iAU876XeD5sukV3AZ4m5Zo5mOKvucGeI2YGcNt
	WIhLgrZ+XUmzZmAhm4c1MzzXDp/343XrG/nUunn2rD9SFuwTuJar+glhL8UzvgiqNEGMwNwwbdd
	+8mMdIFUm2n2GSgz1UnofCj/YvkTA96GE+YudXkaxOco0sEVHRIpJF9iU1R2G313svep68rUjLW
	shbalkke9JP6ZNA8bZEPTry+vDoOwwDSC7gVJNgD3f3u+rl83HBvmQaTgjisqSyZDhtQafElPEh
	1leyDEbe0LjXyyYREalIt2agHCxyjaltVxAt7iEYjKt1T7spC6TFNuUcXbkl1bbKas0ETB7xnzP
	vt7IWTHGi9hqhJXfM4xEt0ZTAdHl3sXXsrPnvMrI+sTHfnTCIQdV7dGwyUil+t
X-Google-Smtp-Source: AGHT+IFISa9cfZTTIz+eUqSav3hIVAT0BH25bsjw5d2hau3oEJPHc+1ORTWBIYfnYnjwEksZlYryKg==
X-Received: by 2002:a05:651c:25d7:10b0:372:9131:3a82 with SMTP id 38308e7fff4ca-37cd917531bmr3665691fa.2.1763719423914;
        Fri, 21 Nov 2025 02:03:43 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b597b2sm11056181fa.12.2025.11.21.02.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:03:43 -0800 (PST)
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
Subject: [PATCH v3 5/6] cpuidle: Respect the CPU system wakeup QoS limit for cpuidle
Date: Fri, 21 Nov 2025 11:03:11 +0100
Message-ID: <20251121100315.316300-6-ulf.hansson@linaro.org>
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

The CPU system wakeup QoS limit must be respected for the regular cpuidle
state selection. Therefore, let's extend the common governor helper
cpuidle_governor_latency_req(), to take the constraint into account.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

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


