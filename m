Return-Path: <linux-pm+bounces-38564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F802C84BB6
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 12:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09E273AE952
	for <lists+linux-pm@lfdr.de>; Tue, 25 Nov 2025 11:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36529314D1B;
	Tue, 25 Nov 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GURsFWKs"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F1315D22
	for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 11:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764070023; cv=none; b=C3fsUMM4GopoPo+MwPV794Q4360JiGiIb/ZqySxa1sk80rFPtE4QHvzJ9BjwMpRajvXi2Be+psEVX3ESXxf54FulKytWGvv6YXXBtVH0AHk6/b+Y3r1t45hZV2gOKnO+zTpXbtZnJbltrrNQBPjTZ9VdNT10W9TawHuBxXz9xIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764070023; c=relaxed/simple;
	bh=qWZZt0EJ5EGhQp+jROsS7jIaWHMmW8TPlU611Gbd3ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVKSNCyIA/966oOXQNsGLMrrjPs6+lOMXUdNs+9bp/Bh4jeoWcmfGva1I6STX6BUIIhMLNr7fCY3qHIJAgrH+QeC3kAzkNPF8NZhtPFbk3Y21QZpN8NjISg5U/x3KsuUYjaLi9qFbBzLB6usuj9vcxSH8cbGiH1cLpv486qgZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GURsFWKs; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5959105629bso5188045e87.2
        for <linux-pm@vger.kernel.org>; Tue, 25 Nov 2025 03:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764070018; x=1764674818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkBdbnO/aTuh3Uyl4FaE6iA6IZG4p2hYiXFE9xVcIHM=;
        b=GURsFWKs2o/H6SYDHodny8XQ0QX+t5IW/HwszqcHo6e3VchnKaKAmmBJgL82du085z
         e6SuFq2kpHJZvZqgbJAYFGXROF9zSCeGTnwFd7nSQIIcqYBIMEUq55196MobW09eIRx4
         pnbAgHCqc+y2r3IkbKK/73pI8lJn4PZjN5ClsgcPX1ZEHxpV1PB9aSIpM+RheKvC1i5V
         69NaNpKZc8LUmeHLi4IceUV1nd0KOwrr3cUzj4NMhGQ9kZlbmDOVEAjRGL6qSYgk7Yw8
         T8y8ZsBs8jqA6oqEwUVUfiLPuxsN7Ii8UPeoZ9nHE7XfHboQKAoSwRL6WV8Q0q9O3ztM
         hpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764070018; x=1764674818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YkBdbnO/aTuh3Uyl4FaE6iA6IZG4p2hYiXFE9xVcIHM=;
        b=skODwzEyKrwx7AtdU9Vw/kPczNJH3hGC9pYoRzsnQxCaXKiNqCt1NuX+4ghQ2smMMs
         dIahcj8lZGTCUkziGIKSFCDM5lQHkQfvdMwShgG3uvo753h9D9l8ZnHjZtmYtVu1SkEe
         zqh6hTfXjq41YOylxU8LYg01lqsXyWIJGAotwcXEFv3qBGWwMAPAi/H3kCjIFChlsfmN
         cuGe8TbS9erwrXuD3mjHb/JsctuvF9PGDkjCIpPnW/C+IhhhxGeoDmk/GjIbTkNzD7rj
         5+bPP5roWhybFPdqEWNxY+ya86jcxmu/GucSKEx6vAyenZ3cm1sbS9Bp5NJ1SEVS6keK
         rRVg==
X-Forwarded-Encrypted: i=1; AJvYcCX78GiMKYNpWayUbihYbjra68gI8GAulZTwfNZD/bvJDi9uZNGALzkl5qHclPU7srpSz+/3W340gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ29veldIVo9+Ya2oDt4Cqotm3LV4ZXEBQp9s7kzPbHGnXv1o3
	fnCakWfLEul4whJ1UQOXD79uhCpAWcM4g2Hb0Kg+MR3+GeTANzieEX6qfeyxFRD/xxQ=
X-Gm-Gg: ASbGncu4uug/k/0rprRNE3FS2gyxEpFbVJBI++shn0V+XEEa+ROjMsqhf9d+N714AEG
	ldEWPaN3Ruy11HF80nviJC81/mFExaEtmO9SbgMPZZMLdHnQ1rpZaVE9g61qNrnXYQ3sSPkUIel
	eZKizaYyKZEqRdRRp3ML+9zw3DSPixHu1SR9hYNF05nr0fnI0DOnW+oHnXok1H2W8onlSpwcjw1
	oA+AKpPA8Uv/fG7mLnt2PdCAMg4+A8xoN7UYmvxVhyLoCEvGI4w/rLt7PrQDGa59HaUWIqx08zl
	/WpY1zDRf8jQqzoQ2fGppx88BCjnXBPJLtlZUVAPMHJOeWp9V+tyN0k5nk+0LprmH7kT/ZhALWz
	nZNl7NYfbbOG6e5YAfcHm1JQAxaHTIjM9SlrdyNcedPqjXSsyE96FaGjFqphZkF/GXO1y83d823
	yYqkKdI+QLf2B9/sEz9LCkGiwU7s56p5etf6FH99lFcrSSxm6ABp28NFI0A/cl
X-Google-Smtp-Source: AGHT+IF5/zPRqq5Gc8LX/DzP5wRoX37ptDORDPlLBcwihZhjQ8Hod/OKSQTB4ujkPlnaRcuFpIKOGw==
X-Received: by 2002:a05:6512:3a82:b0:594:27dd:2701 with SMTP id 2adb3069b0e04-596b529d662mr891658e87.49.1764070018227;
        Tue, 25 Nov 2025 03:26:58 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5969db7563fsm4993526e87.2.2025.11.25.03.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 03:26:56 -0800 (PST)
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
Subject: [PATCH v4 2/6] pmdomain: Respect the CPU system wakeup QoS limit for s2idle
Date: Tue, 25 Nov 2025 12:26:43 +0100
Message-ID: <20251125112650.329269-3-ulf.hansson@linaro.org>
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
s2idle through genpd, let's extend the corresponding genpd governor for
CPUs. More precisely, during s2idle let the genpd governor select a
suitable domain idle state, by taking into account the QoS limit.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Reviewed-by: Kevin Hilman (TI) <khilman@baylibre.com>
Tested-by: Kevin Hilman (TI) <khilman@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v4:
	- Added tags.

Changes in v3:
	- Updated the commit message.

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


