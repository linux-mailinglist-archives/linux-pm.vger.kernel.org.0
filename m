Return-Path: <linux-pm+bounces-36275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25304BE42FD
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 17:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F0DA506A87
	for <lists+linux-pm@lfdr.de>; Thu, 16 Oct 2025 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672B434AB1C;
	Thu, 16 Oct 2025 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="moP1n3Ng"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B523314CC
	for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 15:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760627987; cv=none; b=ip5zvCcjFPFnt0WbH66vkMrm5QWPPSz/TCDTgVoAvhNaRf1GGkjgHU2PjAU38AKDFifR3aa7FNHCeWRDHYNJgUCTEC+oRRsEH+oRNA7Xot6FhSDOUJLlJD5CNpxt6ckIE3SP8je8CtGbz++5q5fsD2QNi5jS2Oz1nMGRB2wouAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760627987; c=relaxed/simple;
	bh=QfTmQDOc1pDn+Jv1CASWybdMSC/xCqrK8wzzxyN33ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh7qZO+qa86Pivj7zC6wtrznftmfOp2hE6ih4X0WddeyHU0jdCbF5DKXBndTErjzhwwxgrlMlNmg6UzGJ1We48+ZvVP6zaMATT21fYec/R6C6rQuFlF3VGAOboZv4AMV+frkC1l8S42S35NL4pnIpPAVR1FCQ8bmUccF6EvisWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=moP1n3Ng; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-57ea78e0618so1092810e87.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Oct 2025 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760627983; x=1761232783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCBJWiwmmJTUNM0j8C8szqE8iwROCYTEd9fYpRnBY7g=;
        b=moP1n3NgvqW+gWYkeznwT6xVCkt86tIJPFIO7c0N+rGw3IjlRErMIq9p3v372Glu9j
         ik73Cs5pxQAUu75iRLa3axtXQF4GpKDG6m1/dZ/7x0yQ2g45/vca5jDmoug4kTt5mGGr
         zbf+YauGjUB37Roatp8t7Km9xUHIcFyvt23gKRLoRqILzqnYCK/NoHMa/GqBFqxMCoEe
         Os1OlyUHlVP1XjEgBv8+RQW+8efnjv6gYjtkWyyWTKRKjF4qVA+IMU4h9cbca2KEx/yY
         xHnrhGIXUNodQtlSJdWwCNBzHbA0UudrwgwfiQUvD/2kuZKDIuB/eWI4AF9VumpMoqtY
         kWwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760627983; x=1761232783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCBJWiwmmJTUNM0j8C8szqE8iwROCYTEd9fYpRnBY7g=;
        b=sAUhDNBGJ+v7z3AVCp0aceKiXTR0RDHEyLcFHvgRz1PRWpwOKMYXsos4OKqmpo8jgt
         rrNHwa1gzsRHCYpN5KaZ2jsoyhYyHqHg2ypO3JJlK1S9T33WfABScY1Ux2d3QrjU0gaC
         L+4z0ETTFnVeJTqSvxA3Nu8cfus+Stx2vEypJjR7FyxlIvG8EK22n2BB8TxsSmvhym4p
         xJhb80eFbBevwvMsEgxKim5E+usjHSaz/A/6whzR3Wo5KSP1HClK52RZPTEE1JS3bMb2
         Bph4rZYQMGETw+yY3mf/TZ9P3G6EaRijJsvwITDEnz/rc8eWCD8YNlFp8kb97a1WH7Un
         pWzg==
X-Forwarded-Encrypted: i=1; AJvYcCU/xFCyeHZULkYdCUblt37hnU7LObU3mVALJ4+Xanc18BnKaM/fBRUo8kZ/33uTFpoyrjz/nZQSVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl37BRcwyUcGlP4JkePuaphgMfAPNV3VByImaHBnt9/B8Yx1Hq
	kDn6OnW2XgkNOmV3tQGU0xHxVkpeDwCdJI2gYm7UN4LxONAXkalA5XsON1t87ZfE/c6i4UvHLRA
	T0Ag3
X-Gm-Gg: ASbGnctJO0VOGHaYDXEK0VZ4IQOu+QxLHdb6SXWRefDpWXeQVwJmUUsK8RHXeCSOb/8
	9gE3Xvpq018aOfpVGstDZCafkEq1IaJeKF6yDbxzvKLdevv/6rTR97ZwRytXcvBMhttVJaemtSx
	Bl+LW3Fy2VZYmDwGnKweUtEQC0tsGotgs5vH8D1vaNgBn6gjs005pLlW8k1+s6uzJIQZaVEknV8
	ulH5jgDc3m98kEz+dZr9D7TN+TS/JkG/8EX+mpCELm/hz713AB55QdlelaM55n0Dr5lom0XMxVa
	xu0dbY81dXslaYwpns4vm5jZu/LkiUEzNpngZcnogujNyAWwFLZ1hJeeZ9dPl5qC+uQ0zIt58uL
	v+/VCi5OT4Oc2s3QorjAh9TxKnIxbNeOqycCANwvkDAUPYLxjx/+QJAfOzmklRPdE4tfd7q9YJO
	+WidMcxzo7GvZZep2dBQTNtunwOth36xapomKLU8ZHaWWZp+D12RkhTeDdn8Ze
X-Google-Smtp-Source: AGHT+IF5oCdaBh84LKLSVZ51c8p7Jct0vsWdmbZ3Nwl6dlWGi8PUK/GV6A2horTszFBvye+XnNBgqg==
X-Received: by 2002:a05:6512:b89:b0:578:ed03:7b5f with SMTP id 2adb3069b0e04-591d8589d9dmr133097e87.26.1760627981949;
        Thu, 16 Oct 2025 08:19:41 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5908856397csm7150663e87.75.2025.10.16.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:19:41 -0700 (PDT)
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
Subject: [PATCH v2 2/4] pmdomain: Respect the CPU system-wakeup QoS limit during s2idle
Date: Thu, 16 Oct 2025 17:19:22 +0200
Message-ID: <20251016151929.75863-3-ulf.hansson@linaro.org>
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
s2idle through genpd, let's extend the corresponding genpd governor for
CPUs. More precisely, during s2idle let the genpd governor select a
suitable low-power state, by taking into account the QoS limit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Limite the change to the genpd governor for CPUs.

---
 drivers/pmdomain/core.c     | 10 ++++++++--
 drivers/pmdomain/governor.c | 27 +++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index 61c2277c9ce3..4fd546ef0448 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1425,8 +1425,14 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
 			return;
 	}
 
-	/* Choose the deepest state when suspending */
-	genpd->state_idx = genpd->state_count - 1;
+	if (genpd->gov && genpd->gov->system_power_down_ok) {
+		if (!genpd->gov->system_power_down_ok(&genpd->domain))
+			return;
+	} else {
+		/* Default to the deepest state. */
+		genpd->state_idx = genpd->state_count - 1;
+	}
+
 	if (_genpd_power_off(genpd, false)) {
 		genpd->states[genpd->state_idx].rejected++;
 		return;
diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 39359811a930..bd1b9d66d4a5 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -415,9 +415,36 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	return false;
 }
 
+static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
+{
+	s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	int state_idx = genpd->state_count - 1;
+
+	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
+		genpd->state_idx = state_idx;
+		return true;
+	}
+
+	/* Find the deepest state for the latency constraint. */
+	while (state_idx >= 0) {
+		s64 latency_ns = genpd->states[state_idx].power_off_latency_ns +
+				 genpd->states[state_idx].power_on_latency_ns;
+
+		if (latency_ns <= constraint_ns) {
+			genpd->state_idx = state_idx;
+			return true;
+		}
+		state_idx--;
+	}
+
+	return false;
+}
+
 struct dev_power_governor pm_domain_cpu_gov = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = cpu_power_down_ok,
+	.system_power_down_ok = cpu_system_power_down_ok,
 };
 #endif
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index f67a2cb7d781..93ba0143ca47 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -153,6 +153,7 @@ enum genpd_sync_state {
 };
 
 struct dev_power_governor {
+	bool (*system_power_down_ok)(struct dev_pm_domain *domain);
 	bool (*power_down_ok)(struct dev_pm_domain *domain);
 	bool (*suspend_ok)(struct device *dev);
 };
-- 
2.43.0


