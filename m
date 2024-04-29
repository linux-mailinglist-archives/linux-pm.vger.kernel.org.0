Return-Path: <linux-pm+bounces-7285-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4498B5AE4
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099F11F22692
	for <lists+linux-pm@lfdr.de>; Mon, 29 Apr 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE4E7F7CC;
	Mon, 29 Apr 2024 14:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbmtKI66"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B607F481
	for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399562; cv=none; b=CSClC9RIOAqy2e0rkM9XT+scJpJEQHVuuRugfzKR78MMLEWmN4SDYIng9KUGtYN0QGg45yp9vOhA5tip/JxoFYPeY/QY10NUQy/7RnjV4lhTQrQBf3RLXkKp8fB+f4WhCT5gFVqctONgU89YDgLzF5wWHw+Q0WNOEUmSImxcPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399562; c=relaxed/simple;
	bh=DpM1v8E3gSnt57CaLj6GwmDgvluzFyBmqLFlQcHwaR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i8PCXtAlVfSTn70BYdADQoG72oK4cwYIXxLne/beaD9iqo6b66Bhc2Ul1N70U+FTPgDTSuwRk1OVKj+u8CgaGUx2FqenkMXba3ogStOMeGUxhNwF9CrOh2bFg0n7qsO9tfGOuRj3iPDV8cszZXxp03Wq7l60rXMbVcOkzj1HjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mbmtKI66; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2def8e5ae60so50320501fa.2
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2024 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714399560; x=1715004360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRW2Pq+Tdw9L+sqrvYL/hlPVkk69kmUaGQ7JliOeiWk=;
        b=mbmtKI66Ak+Q2VxpL6yXiOf7HLMp0nTLPpYolF+WBDRIgE2FmaGnRYEd7WhHSReNBB
         vZvoY0fY/7r4Px79e68Ufa7nvWLDyrzSNWMCQrwTtvZOHH2RHgxE0Gom28GdI0a/dysx
         A9KsiXQEMFvVfSO+7en/uy+F0v1yw/GGyz0OGeZEkcmMG854E9hHveh/MtI6oQcvy2yU
         KKwV4Q2aKBSdTfmC2ty2jQTFoG+sRqh3dE+aopYPUu4BDMn++BsoGo4lAqVWN8o1ywpL
         JmPtdSKhf3k5Z+THuYHf+BABcBb+lz0wUzeAZKk6rj3TcPCDvm6lvgz+CNqvGcaaTYsi
         d47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714399560; x=1715004360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRW2Pq+Tdw9L+sqrvYL/hlPVkk69kmUaGQ7JliOeiWk=;
        b=D9cvlg6Gopc2wdh6PxWXY+s/2srG1+tdYPjQYfOtCQL+Kd9XyQhXaJjcyXcaDHlUQj
         FIwnSF+RTa+4alH8KZYHf7v2zU1+MriRb7/AqjSmpiWWLX7MPXNaPvJ5nc97eYaVnMo3
         RKNyL0I0OzK69V9JHUD3vQe1z2KQv+JiyiK8q16rsbpfaybGKECLYxtBA7ggDy7EAD5o
         LivQ05QzAEA7h0Zwfz1UyJ175iuvd9oXo+TqU92JAZHC3zi28oUOvpdiCEV6XwbIjDU1
         qA2+NJ3tNE1JxlTwNt1LJGFKYpNuIKgqpQWdJ8W+B9BuXHzZvPUsOQ1UluJEEappdN/O
         hihQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaGPo5XY0CtQPTGS+QYbie6BnPB/eTlTFbR1igIhm/9itHseVDsm5+JrJ9y7wBqKShkJqRM61EE4Tp2G95vGWeStJgzCNc5m4=
X-Gm-Message-State: AOJu0Yxi5/xkyvamHFW2znqxrhkBAKD7K09bfo5oKa2g+c1ilT2FW4bI
	aA9OoW8k6YRFkbyoxSMK5pYNlBQJojbNUo+WPqVbl14zSGjseBBI5V+zJOTjgb0=
X-Google-Smtp-Source: AGHT+IGIsr9yUsbk31OY7Zps8MJ+0AvyGsEZBZ8WqFFN1lmQJPsxbIeDmm4LCdu93BtCTFbs9IJWAA==
X-Received: by 2002:a2e:a26c:0:b0:2df:b0c4:3ede with SMTP id k12-20020a2ea26c000000b002dfb0c43edemr4066331ljm.19.1714399559743;
        Mon, 29 Apr 2024 07:05:59 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id l5-20020a2e9085000000b002d7095bf808sm3636733ljg.128.2024.04.29.07.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:05:59 -0700 (PDT)
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
Subject: [PATCH 5/6] cpuidle: psci: Enable the hierarchical topology for s2ram on PREEMPT_RT
Date: Mon, 29 Apr 2024 16:05:30 +0200
Message-Id: <20240429140531.210576-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429140531.210576-1-ulf.hansson@linaro.org>
References: <20240429140531.210576-1-ulf.hansson@linaro.org>
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


