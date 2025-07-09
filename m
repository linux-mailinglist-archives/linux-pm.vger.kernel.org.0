Return-Path: <linux-pm+bounces-30489-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EE0AFEE01
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 17:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB921C41B64
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 15:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A62E9728;
	Wed,  9 Jul 2025 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E84lmFSn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1C92E613F
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076069; cv=none; b=dO//46FDQBdccKKYRwtxPEtU5pms5HxP7JkBiz/D+/UniZ8h+TYeKDTiDWJWN67bPUCedLj0go0VbgVvFvBP+FpGf56JWJRcdF6PJqQEuZIvghGYTOPCWrv2gmwmtwM4YZGBwrzTU3JLoIfwNQUwg4TyRmK+YBHgMBZ7j4tv6jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076069; c=relaxed/simple;
	bh=h6tMRQRXn67KOocJPl7gL2XSOaaSQRap9WsxQwDoJLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lySZt5k5Rb5E1bDshpgHw3pfvJrRkWwwMyMwPGgxz4KhOn3rJulwgSltcAQyQbGgnHuVRELQXjF1Tt4eASW+ecIVm+6TzyFgwkDzKKJUobahKHBixR+rsAu2y0xRTkEqpq14hhFlTwDigsq7L4a4pH403HzDGScQgdFIhomXC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E84lmFSn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a536ecbf6fso64384f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 08:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752076066; x=1752680866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4M7LELCI1cPFBstNSyN002g4c3zY7P9EeDdL35tmOwI=;
        b=E84lmFSnmHBpUWKcnOp7gkz1a+J7IIz0uyU+ZaSkNK7sou1YggHzcpemdEQfGqj4eG
         ablawCUq399SHmSFlk+4gKeBgRLU8Twh6l6U7afVlnsjWuRWy9/VgYy8/DjvCX6qrgar
         9TFV8X9Mymjvv3QZEhmgRqUoy7ZTNzznAvwTu3e5jyRsQEpgcDTUganHsRmbyg5D9Zwo
         AR3okqhFm/PscynOoGOlIjPerkkECyHqpfPLk4Rc4TOlyaxhdwsCRT+0TH5v2Prq7qRy
         6slmu//kY4YS0Mfa6/qjkcaOD6WlUsQgHDfrmg/CydYbB3LE2Oy7JP4z9coJpoaFkSbN
         m6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752076066; x=1752680866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4M7LELCI1cPFBstNSyN002g4c3zY7P9EeDdL35tmOwI=;
        b=MJaPo3TMdqI9/HwoAH/uwov3BbjpWDuAxJkQ1xPR6QSW2A6OJl4xxKIra5WhAllmm3
         PoW4ufXIYgV8Ng/psH8J6hqLdfhGfq6ZFRB9bDILqBMDnvegnrVcfyNbiAUVwPH08RYg
         /d1f7gi38zb8FHtzuT2knJQnWGjp2BUEEhbFxyuYxuAsO6m7PbS9UaJo3EImG/xCBApc
         3s+aDzPKTa9R8DjXp9Cebc3Z7gzkxasjKv7Sy89lbV8IQuli/6+4KahJWbt6AJ19RDoW
         gr5I107U9q7Y3jOAzqAAv4KXE5F2lefBIsAK8s9Qf/qSd3ceUV90gT8rqbVlmDSVnHK3
         Y8Ng==
X-Gm-Message-State: AOJu0YzuWiE+36/eSH0HTCoXEEMPdfeLrQyGU28VuoDuXmemjCocgTnj
	BvREKa0QrJDoaYCRhTmm4BLgrbbpSPdD2ISwY+NdopvE6NInzpiy/NMUKWeIRo1RPJc=
X-Gm-Gg: ASbGncvDUf6X0KWR50uZK/5BNLmY+Eie2o3Zk6lHclnJzi8vRAnzG8zZn0AooaJdMfm
	z/AoJJNzYz+DcMF1fDjyxqr1ZhQrakGp6wcmgMLQufSyzvIMf1VA1YNvkP32x/MKbKgLKcEdhQt
	8AjngvVPfcY3a1+jcMJfZTTvWUbKcxst+kA8pAl0yCQZBmXtS3gesx+DghTbfp29xtzxJgtGEX5
	ymJlQShHQNQFV8nz+HaQnYwIip/1BmXa72/3MKpFCNnvzxj0fnn30tusWVGYTNVeWVg32kotcan
	GHGwRoUoly/MgPsGmvuUrE81cQ1FIeaTawb41O72rgrCITPJBIepcbiv6o+XN8lXSIc/seP2kIo
	IPK4XNwF7pyqx
X-Google-Smtp-Source: AGHT+IFtb3wKvcyNXV4wx2vLvybT75yPG2OAwmNgwliyjrb9KJP4FNMYX9tqHYbI3ZRouro6vvXlVw==
X-Received: by 2002:a05:6000:2206:b0:3a5:42:b17b with SMTP id ffacd0b85a97d-3b5e452a289mr2446888f8f.29.1752076065919;
        Wed, 09 Jul 2025 08:47:45 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b471b97732sm16783647f8f.59.2025.07.09.08.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 08:47:45 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rafael@kernel.org,
	sudeep.holla@arm.com,
	ulf.hansson@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT))
Subject: [PATCH] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
Date: Wed,  9 Jul 2025 17:47:28 +0200
Message-ID: <20250709154728.733920-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
not supported because the underlying generic power domain functions
used in the cpu hotplug callbacks are incompatible from a lock point
of view. This situation prevents the suspend to idle to reach the
deepest idle state for the "cluster" as identified in the
undermentioned commit.

Use the compatible ones when PREEMPT_RT is enabled and remove the
boolean disabling the hotplug callbacks with this option.

With this change the platform can reach the deepest idle state
allowing at suspend time to consume less power.

Tested-on Lenovo T14s with the following script:

echo 0 > /sys/devices/system/cpu/cpu3/online
BEFORE=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }') ;
rtcwake -s 1 -m mem;
AFTER=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }');
if [ $BEFORE -lt $AFTER ]; then
    echo "Test successful"
else
    echo "Test failed"
fi
echo 1 > /sys/devices/system/cpu/cpu3/online

Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT")
Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-psci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index 4e1ba35deda9..b19bc60cc627 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -45,7 +45,6 @@ struct psci_cpuidle_domain_state {
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(struct psci_cpuidle_domain_state, psci_domain_state);
 static bool psci_cpuidle_use_syscore;
-static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(struct generic_pm_domain *pd, unsigned int state_idx,
 			   u32 state)
@@ -124,8 +123,12 @@ static int psci_idle_cpuhp_up(unsigned int cpu)
 {
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
-	if (pd_dev)
-		pm_runtime_get_sync(pd_dev);
+	if (pd_dev) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_get_sync(pd_dev);
+		else
+			dev_pm_genpd_resume(pd_dev);
+	}
 
 	return 0;
 }
@@ -135,7 +138,11 @@ static int psci_idle_cpuhp_down(unsigned int cpu)
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
 	if (pd_dev) {
-		pm_runtime_put_sync(pd_dev);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_put_sync(pd_dev);
+		else
+			dev_pm_genpd_suspend(pd_dev);
+
 		/* Clear domain state to start fresh at next online. */
 		psci_clear_domain_state();
 	}
@@ -196,9 +203,6 @@ static void psci_idle_init_cpuhp(void)
 {
 	int err;
 
-	if (!psci_cpuidle_use_cpuhp)
-		return;
-
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
@@ -259,10 +263,8 @@ static int psci_dt_cpu_init_topology(struct cpuidle_driver *drv,
 	 * s2ram and s2idle.
 	 */
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
-		psci_cpuidle_use_cpuhp = true;
-	}
 
 	return 0;
 }
@@ -339,7 +341,6 @@ static void psci_cpu_deinit_idle(int cpu)
 
 	dt_idle_detach_cpu(data->dev);
 	psci_cpuidle_use_syscore = false;
-	psci_cpuidle_use_cpuhp = false;
 }
 
 static int psci_idle_init_cpu(struct device *dev, int cpu)
-- 
2.43.0


