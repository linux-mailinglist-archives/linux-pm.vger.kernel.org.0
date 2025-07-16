Return-Path: <linux-pm+bounces-30902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDE2B075C2
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 14:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D14508253
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 12:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B92F5C4E;
	Wed, 16 Jul 2025 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAd9aiKD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B292F5C3B
	for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669230; cv=none; b=EkaXw3j/lliBm0MZtslystQXFsmbCjKcZnPOy4dg+TSTD5gxJ2YvJRCG9BGnDx6w/w1/dZzBoP+hE1HSHTPKuQDLrGRXZTwu6Y1Dhog7V6zxE5fB2j4FHEd8XnXFUD19JYNMExBWwllWuDzsV7h4HdmZGi1yuNPM1wCCPheHfM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669230; c=relaxed/simple;
	bh=uMr5ewtwM88NHPIIUr3b4SgNh8FJpgI1igYb+ESENyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvDZgrMz0gRdSCvqv6y3PI/VoQboSkuysAMv+7/w5EikGTMAxBRCGybx6CZIf7KyflUh0gh4LbBzxN776w/Y6Q8bcXY7svzto+McoKlFur0bDpRp941O3H8eW3UYNJDmflmlr4jLh9w6xSY1Mimj1A7NlUZ2eRYAwYsp8GtkxdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAd9aiKD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-553be4d2fbfso7158564e87.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2025 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752669226; x=1753274026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPBtNDYnm76liocICYdzU8O0GnhwSM9tVX+/thS9jJw=;
        b=qAd9aiKDUr21frYvaXdCRHpf3IvsucysRiSt0c2AQsDGFWUyODW7BuWJXCQG3iT/iR
         zxjw2xvtyAiRhu58B8y1y4/l1RXTk12T/C1gg2SsAS5RCNMZbKl85saXutiJA7XA0NZC
         wI39jIs3+6D+qekQD0KOaETERt91hUzz8R/iNza4J1E+KB5WFWpd1IYsejurjeDnKV2q
         Cv5EZvJWkumMBeg8ZWfQx/UTr3MAsZA34OyJ8D9Tkv2vV4hrLboCh4UFHFhBzQjztmbX
         aqiDAa1XMFk3T5+bA6NCYYm2rhgs5zfP0tjxbtrCJj3Lii/2n3eXVxEnSLXzJjeeDeUS
         HqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669226; x=1753274026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPBtNDYnm76liocICYdzU8O0GnhwSM9tVX+/thS9jJw=;
        b=VtVfDoM/L4q28Upv/S/OputvEoV2IWUSZ4KbFaNL4U8NbaZlYwBAnxY6oGHFQJ4j4q
         Ia1B3VkV/NPkVCF1izwyT96HyGy4J+UV8YkbxvlGbXH1HjqRzF0c2BQeCTuL5o9UtM5l
         IDRP9tnZwDaV8oD78IznFymZZP0SsC90sNJ64FwJobePmHK661Z55ilrnjax1sMVJPdg
         dh0sMYJCkcW4WF5mmqGujlYRvIxu8toMTShMBqFTKHGeAA8OxBZJSB7x0rmbpAHX9XcI
         idAlJKelaVRRPvI+5O25vNS3yoapuNwuoVROHDnFdf08qoIaoM3yUOhjap4zREs4GO4L
         4WRw==
X-Forwarded-Encrypted: i=1; AJvYcCUFfvUVZ9FjuP3LWp0nTS4nO03lZkKY7aZnyTx3lpv+NKiu4R/0RfgJrdbWRsSLscKwY/7MiMP1Qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFp0EQ190u0CctZesQU0K1q9JjTcXykmrvGPLJnDw1UEu6+Pj
	NOJcbzWaFbqfb0Ys3pxgsStUc+pWgKWVhK3B4fZA9s2F+mNeh3aQg2CT5cs4jv9oiu4=
X-Gm-Gg: ASbGncvoAInXwyeaoe1bfK/VZPp29upB85vx/LDBUXzDneCvNIFysvqxd2eg6guWZi4
	NzlmAJ48c6PjGPpxAXuDyo7bvoswKeDjorftbpndmJDNRHyCDdN2Lh+AuB669t5gG4+OfBgm/Xe
	SDzYsO1eY0wKM/RTwlkXQwTgDnXwaWFkn+IdC0+LizTE88vpMnr7I/0apxfTHlXPnQ4tK+xWw5z
	jCOtqASGBkv69zgsLfo7jsJnqZX9Iu0mLA4Qp4Kq0HVfBnRJWIrvfTB8TCTK6y0LhIEQOQzcQKY
	d2gcxnB0cS83fXCr5Zlg7v+az/R2C4Dg9PAUoR0uOuvlVco+SVCycwD7lq3Beg29wRZa0ZCZ+gU
	+DWVitzA+ICBEXpFDKn5ZhBNACEmCG+2NRwXgQARihSeXiLWjnNZLpuihXvYtYyULAFjI5f3z
X-Google-Smtp-Source: AGHT+IGRhItw3Rx9uduPizZnNMfo3XdSdJYBSLoV85/Au8cZvRZ7HllLBaEgOBko+rtbJAjBxkRJaw==
X-Received: by 2002:a05:6512:1041:b0:553:2f72:9ce0 with SMTP id 2adb3069b0e04-55a23f964afmr762602e87.52.1752669226288;
        Wed, 16 Jul 2025 05:33:46 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32fa29134d4sm21136211fa.22.2025.07.16.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:33:45 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@baylibre.com>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Saravana Kannan <saravanak@google.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 2/3] pmdomain: Respect the system-wakeup QoS limit at system-wide suspend
Date: Wed, 16 Jul 2025 14:33:18 +0200
Message-ID: <20250716123323.65441-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716123323.65441-1-ulf.hansson@linaro.org>
References: <20250716123323.65441-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A system-wakeup QoS limit may have been requested by user-space. To avoid
entering a too deep state for PM domains that are managed my genpd, let's
start to take into account the QoS limit when selecting the
low-power-state.

If it turns out that none of the states in the list of domain-idlestates
are suitable to use, let's leave the PM domain powered-on.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/pmdomain/core.c     | 10 ++++++++--
 drivers/pmdomain/governor.c | 23 +++++++++++++++++++++++
 include/linux/pm_domain.h   |  1 +
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/core.c b/drivers/pmdomain/core.c
index a86aeda1c955..5cbe7473c2b9 100644
--- a/drivers/pmdomain/core.c
+++ b/drivers/pmdomain/core.c
@@ -1396,8 +1396,14 @@ static void genpd_sync_power_off(struct generic_pm_domain *genpd, bool use_lock,
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
index 39359811a930..2630ba6f28ef 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -343,6 +343,27 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	return _default_power_down_ok(pd, ktime_get());
 }
 
+static bool default_system_power_down_ok(struct dev_pm_domain *pd)
+{
+	s64 constraint_ns = system_wakeup_latency_qos_limit() * NSEC_PER_USEC;
+	struct generic_pm_domain *genpd = pd_to_genpd(pd);
+	int state_idx = genpd->state_count - 1;
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
 #ifdef CONFIG_CPU_IDLE
 static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 {
@@ -418,12 +439,14 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 struct dev_power_governor pm_domain_cpu_gov = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = cpu_power_down_ok,
+	.system_power_down_ok = default_system_power_down_ok,
 };
 #endif
 
 struct dev_power_governor simple_qos_governor = {
 	.suspend_ok = default_suspend_ok,
 	.power_down_ok = default_power_down_ok,
+	.system_power_down_ok = default_system_power_down_ok,
 };
 
 /*
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 99556589f45e..0ad14cc4ad7f 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -140,6 +140,7 @@ enum genpd_sync_state {
 };
 
 struct dev_power_governor {
+	bool (*system_power_down_ok)(struct dev_pm_domain *domain);
 	bool (*power_down_ok)(struct dev_pm_domain *domain);
 	bool (*suspend_ok)(struct device *dev);
 };
-- 
2.43.0


