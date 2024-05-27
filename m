Return-Path: <linux-pm+bounces-8176-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0C8D04E6
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB17289E94
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 14:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081C817167D;
	Mon, 27 May 2024 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lgof/2C2"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0774317107F
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819979; cv=none; b=mOxqLEB3gKHkpIiL9hdMJYsH/pj5mnj3+jfcs2YsakwjeZ/YNDyTNhgDiZf2119EvOdYoPTX2gOSGY3yMY/z1C/fcTDTHcyiJHfY1m0g7GCo4jaC8+9hb6oSl0WRdnJojud88EOekL5k4FE6Ecpiy2O8cd+uNui+Hl0XSfTX0ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819979; c=relaxed/simple;
	bh=Dqf4iQmXp0zK19p1+7qhaTomO3Kpy2CqPOAV3dW0uXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMef1ewIgioQMoxaJs3Eq+whomzsa4maQGBjpy/+pbpVNJOtgGSFNfcl/jFxez1+qwU7W7enMi1gaYiQcvxCGUkNjlaUabpCp5pmEWV0zRwn180gw76a1ZzxpJKELko6wozwwz4e41/ln/IC8ZH7o0NL8SlXvfudbdFUpQ9T+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lgof/2C2; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5295ae273c8so3510653e87.0
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 07:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716819976; x=1717424776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LljiSusVSLaQvLa3fMIpBprCm3Nn7mYz+K0yIBAx5Q8=;
        b=lgof/2C2IrfR8Y7zaAeMVr/gRnZfYETQoJbmAMIUJr7dMRqU2LYgvCZXIhZPlBjUa1
         3zQCaUH+XHmrSeJucMiZMkl6VB0R8iizmztVAjC7tiTvAkUhEHqQmkRzTGWvHriQspoM
         Nihi758/77c1m3UbQ+AUVxMPtBn6DkvuMmp9C5BjkOi/Ec3qvYx4yWmpvUU7jPRk0BvG
         VZyyyBabHeYoNy54D9qeFgaabyJvLJLKwY9+qgpt7EhvYrXF5wG0rws9teCn056jF7bC
         tmtFABRIJLXJExFJ1M+9vRCykropcRBGpokUiZ9eOT56oCtZszfml9pkHfQIfKgMOMBj
         +QNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819976; x=1717424776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LljiSusVSLaQvLa3fMIpBprCm3Nn7mYz+K0yIBAx5Q8=;
        b=PQy3IHiCCZhcMH6Ut0F2hV4s9qeRHEUGK0B/1PxFpBKrNhuxn9J1whRrFMknZgNIhR
         urFs8mSAHpbC3qpzVwtK8+o9WhjzjBHKRL6Y5Yl1jyktdI0HG3avMtNdEmEfllG7hsIB
         46vFDDBYT7oVz+nUs5ZbkO2IT+l8I6YYKqRzAhhmR0i4140QHQ8N8rZot/DSTe/zTqVG
         6b9qJYdTxC2+lkesGfVfjbsXl9MeKu3Iupqylyjulk7XwuGWvwKdrc5s2y90kt5g1MXv
         nvxeTerGsw2sxsvvcXc0zERBPrhWtj1g7hQRKetFxFgOG3COxys+RMA7+ZY74Jle9zYd
         Gn6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcMX/grP48mnulNRd2LF336VuSymCZ3vLU2GrGG+GXZs6EQ6YcqV/G3BjtngqqREdzQADXg6/F42xWpGeMgd3SHZADeAnsdB8=
X-Gm-Message-State: AOJu0Yyj7/TFICELKSsMOSR8mmYgMRKK0IPCWqitAZT4V7ExLhGoAVtM
	5b3jslQhcsj6uS4Ob/VX4aJ/8/Kqosa2Td32gk1hF012GKBZNhF3zHGLVMKfTmk=
X-Google-Smtp-Source: AGHT+IHda/pxt1Ko7UnJfUcRRPdZ4toQLHtsmBjmcxqQ5f4apt+9Z4qbCKGMZXNL6CMfnbUjmtCv8g==
X-Received: by 2002:a19:ee0b:0:b0:518:a9bf:73ec with SMTP id 2adb3069b0e04-5296519899emr5678201e87.35.1716819976367;
        Mon, 27 May 2024 07:26:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-529711fa7f3sm562002e87.258.2024.05.27.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:15 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Prasad Sodagudi <psodagud@quicinc.com>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] cpuidle: psci: Enable the hierarchical topology for s2ram on PREEMPT_RT
Date: Mon, 27 May 2024 16:25:56 +0200
Message-Id: <20240527142557.321610-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142557.321610-1-ulf.hansson@linaro.org>
References: <20240527142557.321610-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hierarchical PM domain topology are currently disabled on a PREEMPT_RT
based configuration. As a first step to enable it to be used, let's try to
attach the CPU devices to their PM domains on PREEMPT_RT. In this way the
syscore ops becomes available, allowing the PM domain topology to be
managed during s2ram.

For the moment let's leave the support for CPU hotplug outside PREEMPT_RT,
as it's depending on using runtime PM. For s2ram, this isn't a problem as
all CPUs are managed via the syscore ops.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
Changes in v2:
	- None.
---
 drivers/cpuidle/cpuidle-psci.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index d82a8bc1b194..ad6ce9fe12b4 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -37,6 +37,7 @@ struct psci_cpuidle_data {
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
+static bool psci_cpuidle_use_syscore;
 static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(u32 state)
@@ -166,6 +167,12 @@ static struct syscore_ops psci_idle_syscore_ops = {
 	.resume = psci_idle_syscore_resume,
 };
 
+static void psci_idle_init_syscore(void)
+{
+	if (psci_cpuidle_use_syscore)
+		register_syscore_ops(&psci_idle_syscore_ops);
+}
+
 static void psci_idle_init_cpuhp(void)
 {
 	int err;
@@ -173,8 +180,6 @@ static void psci_idle_init_cpuhp(void)
 	if (!psci_cpuidle_use_cpuhp)
 		return;
 
-	register_syscore_ops(&psci_idle_syscore_ops);
-
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
@@ -222,13 +227,16 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	if (!psci_has_osi_support())
 		return 0;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT))
-		return 0;
-
 	data->dev = dt_idle_attach_cpu(cpu, "psci");
 	if (IS_ERR_OR_NULL(data->dev))
 		return PTR_ERR_OR_ZERO(data->dev);
 
+	psci_cpuidle_use_syscore = true;
+
+	/* The hierarchical topology is limited to s2ram on PREEMPT_RT. */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return 0;
+
 	/*
 	 * Using the deepest state for the CPU to trigger a potential selection
 	 * of a shared state for the domain, assumes the domain states are all
@@ -312,6 +320,7 @@ static void psci_cpu_deinit_idle(int cpu)
 	struct psci_cpuidle_data *data = per_cpu_ptr(&psci_cpuidle_data, cpu);
 
 	dt_idle_detach_cpu(data->dev);
+	psci_cpuidle_use_syscore = false;
 	psci_cpuidle_use_cpuhp = false;
 }
 
@@ -408,6 +417,7 @@ static int psci_cpuidle_probe(struct platform_device *pdev)
 			goto out_fail;
 	}
 
+	psci_idle_init_syscore();
 	psci_idle_init_cpuhp();
 	return 0;
 
-- 
2.34.1


