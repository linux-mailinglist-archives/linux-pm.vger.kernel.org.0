Return-Path: <linux-pm+bounces-29914-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E18AEF741
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 13:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DEFA1C0204E
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jul 2025 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64BE2798EC;
	Tue,  1 Jul 2025 11:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Phee2/pV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B427978C
	for <linux-pm@vger.kernel.org>; Tue,  1 Jul 2025 11:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370500; cv=none; b=Rue0uFZuW6y+AXEd6+ZoxVCIW/oy7JmUbrFI8c2osCIDGWv1axo5Z+AiSpsjXaFzU3dkn9Hq9Qx5XcAp990ltHG64XUSdfrQshSw4OelG10sO7TutFP5hrBdsE0e1E5sgpMVG5556Qo8o+vHks7C2Ys5kH50Xi8pf25h9DXDCdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370500; c=relaxed/simple;
	bh=IcMPWNtWz+Yq437eto4KGz4yBcEZPkVOdOxFSJOvbLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KrmUqwKWHqJRDprDrw1/vRpdg1oT5dRbS2Ifadz7URnLL52sHGKqVCw2vrE59yL1n2j7x+9WDu+Qjh4+g9GO84J89JlBVS7PN3YkV4afpsVmAPkZOFeduBFev95kCeGgNz3ZZdIxJeY/2Ql6DWYSPTLpZ5mdAxwgA/GrnDOE7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Phee2/pV; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-553dceb342fso5049946e87.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Jul 2025 04:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751370497; x=1751975297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSVn2mrG7zN+yugOBdym77+gEsZFQXOddpv10aEY7jo=;
        b=Phee2/pVjtu8knDXoTq8OmkVIeCVsYjZAnC27+3H1AYhu0wR/2lEGDuuAChsfdLvZE
         +Bb6jW2s6iPyT7/I0E9tEZ08/om/BSIWgCLXwik7QAoA1ReuZECDnS9MipC4t4MMgKgv
         6354MpRjmKG8wklTq8t+pLZWkd3P7yuq2O3o8TK7kpJzfZ6bU3F45ZkEDAs86pkNfJAt
         wH+OnmYuSQ4lSMtylZYDetL7YZYQ1BArRLXkSrwKJoMbWRzTr5T/yYsZC8Qz81U3Evp2
         Oxsu17cZMxYU2GtulFR8wSpcEmi1Rv4JnWIkNVlUhrUJ+LhCfu49Gc6uHC/Q2/AYeeEP
         iBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370497; x=1751975297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSVn2mrG7zN+yugOBdym77+gEsZFQXOddpv10aEY7jo=;
        b=Tmry0nlcnM3U4l/i6Hn2WaHkmAoCoiybvDzGP3RUw3hIJrSf3VvYuxe1MfFnobXgR+
         TKbLkgOV91Ob7+pWJH/VrTKeekPtP5/ubOLH7HX+Zt/EkiW38SeXOrMzErbohnUf+XJ1
         9uz0H9xVa0NvsUN41Jm1BtbTKCy+0PR507+6zt8VRvBpIGLoeaJUsDoriqYJw+rq6aJ5
         UCiRcDgFTyyywQH+rD80Ts8zohjFtc+CS9nh5bnmcpN/wzWse1EvN9Gy+C0X4glInq1V
         QwhSCpmQaz2usTiNY5m6g1VjHjxVm6JDeqHEUz/prBo9TqCulsli4DPXLhY/Rm/1BbSM
         THUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfYJ/sA91egmL06uMM0qaCXa1DxtHjFNHyrKmY+l5a2KM+dhr4Lqo2kswevLRGE5D6SnlAP0IX1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YweCWZEblV1P9tAb6tWJNbaZmwoGAMYM1UdvCEZ8hYwB8nVRclm
	EBtCWWmrkhFgbaLBi0CLJ3QekCq2M0wjMyRScVWBjSP4ksFjqO0J7pThdD+CODUdXio=
X-Gm-Gg: ASbGncsYcmAQ9MAJKRHk+onUHGFFGKYprrlPwNPUwlm+D+MuTu+0rSyIIIbHQ9fzVMo
	B4TWbN7vdeBWANuJidr58cdY2pMeNhetpQ78pW+hXdP0+ZYo0cvOW+/rBnG1FTQf4tMLnvT/UNW
	2uKZ630V8DGUEoX9Oz0eEIHVi9EhUnvhaBW938Wmng2jdiKqnhEt3kfH3/MD/g9Ze6gvbaz+lk6
	GsxX3S0AyEJBrlkgENUlWhqp3/PklSymliEv0dedXV8b1wm4JtiABfr0s0eUN+UKiRavI6KbGyw
	Wy9/E5IBc9izHWW07tYvRsqKimnuBjMaVtnj7MLiBjy8i7FXONiqNqBlU74IHWGuG9Rmm3XlNK0
	3K7MvgCQJLGESlDX0ZfXmSF4MOMLXja9VHQBRM1Ck4RQOiH8=
X-Google-Smtp-Source: AGHT+IHDgDRPfHPY98/LHxFMoQy3YVLaarT1QmySpf801TGvHsjckA9nhAnZDzSK8mfVyqtwI0kzDA==
X-Received: by 2002:a05:6512:159a:b0:553:522f:61bb with SMTP id 2adb3069b0e04-5550b7e7b62mr4991989e87.12.1751370496991;
        Tue, 01 Jul 2025 04:48:16 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b2f162dsm1800592e87.248.2025.07.01.04.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:48:16 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hiago De Franco <hiago.franco@toradex.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v3 24/24] cpuidle: riscv-sbi: Drop redundant sync_state support
Date: Tue,  1 Jul 2025 13:47:26 +0200
Message-ID: <20250701114733.636510-25-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent updates to the genpd core, can entirely manage the sync_state
support for the cpuidle-riscv-sbi-domain. More precisely, genpd prevents
our ->power_off() callback from being invoked, until all of our consumers
are ready for it.

Let's therefore drop the sync_state support for the
cpuidle-riscv-sbi-domain as it has become redundant.

Cc: Anup Patel <anup@brainfault.org>
Cc: linux-riscv@lists.infradead.org
Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X
Tested-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> # TI AM62A,Xilinx ZynqMP ZCU106
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index 83d58d00872f..a360bc4d20b7 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -44,7 +44,6 @@ static DEFINE_PER_CPU_READ_MOSTLY(struct sbi_cpuidle_data, sbi_cpuidle_data);
 static DEFINE_PER_CPU(struct sbi_domain_state, domain_state);
 static bool sbi_cpuidle_use_osi;
 static bool sbi_cpuidle_use_cpuhp;
-static bool sbi_cpuidle_pd_allow_domain_state;
 
 static inline void sbi_set_domain_state(u32 state)
 {
@@ -345,20 +344,6 @@ static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
 	return ret;
 }
 
-static void sbi_cpuidle_domain_sync_state(struct device *dev)
-{
-	struct sbi_pd_provider *pd_provider;
-
-	/*
-	 * All devices have now been attached/probed to the PM domain
-	 * topology, hence it's fine to allow domain states to be picked.
-	 */
-	sbi_cpuidle_pd_allow_domain_state = true;
-
-	list_for_each_entry(pd_provider, &sbi_pd_providers, link)
-		of_genpd_sync_state(pd_provider->node);
-}
-
 #ifdef CONFIG_DT_IDLE_GENPD
 
 static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
@@ -369,9 +354,6 @@ static int sbi_cpuidle_pd_power_off(struct generic_pm_domain *pd)
 	if (!state->data)
 		return 0;
 
-	if (!sbi_cpuidle_pd_allow_domain_state)
-		return -EBUSY;
-
 	/* OSI mode is enabled, set the corresponding domain state. */
 	pd_state = state->data;
 	sbi_set_domain_state(*pd_state);
@@ -401,8 +383,7 @@ static int sbi_pd_init(struct device_node *np)
 	if (!pd_provider)
 		goto free_pd;
 
-	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN |
-		     GENPD_FLAG_NO_SYNC_STATE;
+	pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
 
 	/* Allow power off when OSI is available. */
 	if (sbi_cpuidle_use_osi)
@@ -570,7 +551,6 @@ static struct platform_driver sbi_cpuidle_driver = {
 	.probe = sbi_cpuidle_probe,
 	.driver = {
 		.name = "sbi-cpuidle",
-		.sync_state = sbi_cpuidle_domain_sync_state,
 	},
 };
 
-- 
2.43.0


