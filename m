Return-Path: <linux-pm+bounces-38345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED3C7863F
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C77B04EDE62
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B9C34573C;
	Fri, 21 Nov 2025 10:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkMIuz0g"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5749C344024
	for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 10:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763719425; cv=none; b=IjqQS4lXIYBHOKe86VNvaDsKsmDdLKbdGtAaujnxtLu+uFa4VAVN5NkGK5LJt6C9O9V/lisKwCbLmH6OVdYhwsIgep4CpmGxuALXCrWKd2XfVd7ra9pAejUkjNP8ia6vQe0+ugEz6Bgpksa2OZw3hWiwxWNJZcPt0rs4zrozzlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763719425; c=relaxed/simple;
	bh=MJxuCpjjKZOzZQVt9PIbLTi9e2sc7SsHSJWlFzSJx7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtzCto4P7rir9bv+zE0uKiE6ov1V+i/5Koce04OpLozj6jIJoI3IoPbc4APOHBN9hFzad2wcETgFOU/EFM+Hjiv2KujO2j5u8Y78VM5wLbXmeepMhdrOQaliJ3Wepg6HeADdtd31lHmpNSKcm5MEw96EcdojeZoH0g4CuNbL3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkMIuz0g; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37b95f87d4eso14930471fa.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Nov 2025 02:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763719420; x=1764324220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jGPeEHKWVuJIa8HHZpuFjo58itYUjW84JrZNCFr27o=;
        b=NkMIuz0gQbdK7lRn62Mqtfw88TAIqwTsKy9EyKgTGQsLohNU3OsAx5PDeWTEY6nsGS
         +HTvINv8mIJj7uoGkWgzPx8BQ+q2tt4+88yzAQ5hKszg9ILTHE5kl6+aFVfAASw/WqAU
         Af2L/VwvS4iuUOBKugptedFlmbGkXXz6P7eVA37MjMg0MfIc8aUWWPPf3UIuVpExn4bF
         iQvLzYFmv099NKX0daE/w3eC4Nc34CJdviK+UxMlY7A1lw6WaVhghky4Azfgl7oT+7Fk
         VIyBWtsgFqq8y3VxEsIZ/x7dzKgsyjP+NMW2y3HATmYdW7A2YieoJaI4botnfvryiQUk
         lS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763719420; x=1764324220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1jGPeEHKWVuJIa8HHZpuFjo58itYUjW84JrZNCFr27o=;
        b=CkIF9t4hqDh0UfTvkXrTusR/6pAQRZ/fd2LC4xrn8IuBrTkiQuCqE8iRoyspYgH6sU
         KhB8VW4xhDSsmj/RPPiFl4aP7a2ACLRSPEN/zF9uf9SLFIpU8YrVdLsPjPviHS/IbPDG
         pDeq2HYXNCUdzilFH16Uy9KIe21ESmQWCcjPIDBNHChcDKq6YB+95ZwBDywuBDdUdGfJ
         VKhkBeuAE1x/Y5onyrts265vxNQPpriv0z7P2iTmVj0jY89EuGGgBix3c8eLXY2/Anj5
         2lxqdwQ5lt+BdJMO/SRTNuctYsxyX3tb/G0I7ShDG2B5RaEUrHZxRgUZYHZEDU4FJGxk
         beqg==
X-Forwarded-Encrypted: i=1; AJvYcCVubs+GMLFj3IC1k4mqugcnG/yFocP9GDSjo0TlLsEekt/OQRqazXywJ2R2o4uctkHZL5c6rn4ihw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKawxY620xkW/v/CIjqw5gi2Oo1fveMdRV3gWNvPXyz8DkcDOH
	6ze07MXTLstUZ+puadqBHwcjUHwuLdEaIC1hL8iybodNSXD8eWVdBm+CvJrh6jkNzkY=
X-Gm-Gg: ASbGncsNFWQ+IHl2VQG4o78y+1rQHFZCVg9Vfe6is0293kD5o873sTTnmWLsdkuQmc1
	+rsqybHb8zYtuW9VfvLRdasdjADmku/LYbPvBLAkBRSH9g6+Z+Ru2gyounLQDGBDroIXU1Q6GgK
	b8EjMDcXpwIdwk3ZHqHfJqo2pvZ22cPlsm/7Gc/gu3VXD5PU9qgM6Y0giaCMgVGdMV7gOSmQGQv
	9WRyFIiSRr2XLsnx0bctURggpv9CUFCTyxuDZyEbyibfMTjwL/qFgkIRy4uMzpgZXdL19y28Erd
	Vfp4tfMHqQ7VN/6AqfIy5732oPkNQdz5MNC40gTJQW+579LfG5QuQveNX3Cq8aEcWz9uht1XFao
	5Xu2ZCNhORpmszG6bqp0QgAYB8U+g/gJJuHxx/2phLA1P1PlNroTCmfxyg2696D7upT7ycg/kfB
	x4ifDgrfwIAck1IdBdRPOvxchDmGuQM5Uzgg87hAY5BDu4eb4cRkzmDujdcP+d
X-Google-Smtp-Source: AGHT+IFLmq3mXcT5DxVN+3wK08/EmPXPJaubrK1WkqZ8td8Jxs6hqP0+/hynWWzg8tl6NP7ARG8PKw==
X-Received: by 2002:a2e:8a96:0:b0:35f:a210:2a35 with SMTP id 38308e7fff4ca-37cd91aab9cmr4951321fa.7.1763719419900;
        Fri, 21 Nov 2025 02:03:39 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b597b2sm11056181fa.12.2025.11.21.02.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 02:03:39 -0800 (PST)
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
Subject: [PATCH v3 2/6] pmdomain: Respect the CPU system wakeup QoS limit for s2idle
Date: Fri, 21 Nov 2025 11:03:08 +0100
Message-ID: <20251121100315.316300-3-ulf.hansson@linaro.org>
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
s2idle through genpd, let's extend the corresponding genpd governor for
CPUs. More precisely, during s2idle let the genpd governor select a
suitable domain idle state, by taking into account the QoS limit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

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


