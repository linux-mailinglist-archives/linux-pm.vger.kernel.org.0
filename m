Return-Path: <linux-pm+bounces-4537-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B14CD86C332
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 09:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1411C2112D
	for <lists+linux-pm@lfdr.de>; Thu, 29 Feb 2024 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD542481CE;
	Thu, 29 Feb 2024 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dOw6KgVw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8B1D6BD
	for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709194340; cv=none; b=lTOxzPshXQrSt6CUIyB1pTy1G2p6mdxRyh9ha4OojrcfOqgs6Fc34kdU76MklYVp53+5pT+qY1aUixs0ivogfowrKCkYQFm3lKmKn2EboLJXi6xyWeHjxOHCms9SLhkqzxZrXGZTS4i2qg8Ir8dfsGo3mNhfjdxc1G0iTvVB42g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709194340; c=relaxed/simple;
	bh=hkNoVgg/s16Yvv+JgdnS3mrdqjwPqt8dZTRUoWVH0HA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q+Dw5DOlAOxDt8AeG83/Xm6rOmlg5iq4MfeqyOQfMFpAAV5T51212PqVwFl1WjEnfaedY4A3tZLEFPNNs44IiP84VJ0U7d3m2LVd7BPY+dHUJZBJfAkwSMCBAaDOS/g1DNXnR302XdpAt+vZvIaOc3JEqzxzfIdoNOgFRRHlbKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dOw6KgVw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dc139ed11fso15041835ad.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Feb 2024 00:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709194339; x=1709799139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fL2ppWiNvWh5i4XwlQmZabTMeBWWyC5WjuRP+1u4wQE=;
        b=dOw6KgVwELpncbuyIwR3KA0mx1xGCFVgQFRUEdtVjJ70s27tO3jkfS2mZO65+eh3/G
         NwbR/VxjYOrNtvqoeoAwwpyFw40qslJCffMeaQvGXz9ffIDxc9bKPVzPbrHSEuwkd8bT
         pOLfc/LZvgGzbLn+5NqTDjaDfa11XpOqk7oSXoKEHfuSHbTJCpeIfAa9kVrb8/sWq8DI
         H7CYTFTt4bbd56T8T238mk0qFewed7aOCk2B5o/CpqfP0juIzVfeuetbXpvSgHZ1+Dz9
         kvAg+OxLuMOQkFqri5qPk5FYDg2ohebbQ4FlmeKVDNT0hPzp6P6nZFFT+BD0c9iOAuaW
         posg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709194339; x=1709799139;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fL2ppWiNvWh5i4XwlQmZabTMeBWWyC5WjuRP+1u4wQE=;
        b=tArFYzMjrtHgDwzkBan7WRRUemfzPQRG9q1H1Ia8tzpKRQgxT3p2OWMWuk8dUSe3aQ
         /I2lSTvBtb90b39u8R+J+1jAG1xrkRMhkvHxpE0u55l7FfStIhdv9PrQXkjhw7vs8DQn
         afaIpZDL2Y5cUrioJDgTcQxDNI6MmDJu+gMAWxoxFxPflaaHFcNmsM3vfm+HtObLOUWe
         ZTJtB9GL+xJJhIEedBF7e6xZlnE1PMZ8p0KbqIR79yBxXAzkKgwgYevgpkd0K57QwA96
         8mK2uKeEvCvLcZLr1aTDUwgE14doCxRC+vpI9TrTuq4bs1M2etuSIepdQBfe3ElfQDxJ
         QNXA==
X-Gm-Message-State: AOJu0YxdFEX+g8qYAiJiM9v7yahpCuCW/gJypmc0EoZIG+jVB4GDh6Kq
	vgXYsKJeJRev+C9ej9btVyg3ucpzNrCIRZDYUZqQwTq3Tg0eK7RbvmMXpW7WBTM=
X-Google-Smtp-Source: AGHT+IHnUsF+3dAIEpXcDmeHdire3xJOHx1UF2DJ1pIGXDkG1kh/CZYK/U94b3pDJNDqCv2cx4wyhQ==
X-Received: by 2002:a17:903:1c3:b0:1dc:b887:35bd with SMTP id e3-20020a17090301c300b001dcb88735bdmr1953757plh.5.1709194338594;
        Thu, 29 Feb 2024 00:12:18 -0800 (PST)
Received: from localhost ([122.172.83.95])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d2c900b001d8f111804asm803441plc.113.2024.02.29.00.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 00:12:17 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>,
	Roman Stratiienko <r.stratiienko@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Don't unregister cpufreq cooling on CPU hotplug
Date: Thu, 29 Feb 2024 13:42:07 +0530
Message-Id: <1333a397b93e0e15cb7cb358e21a289bc7d71a63.1709193295.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Offlining a CPU and bringing it back online is a common operation and it
happens frequently during system suspend/resume, where the non-boot CPUs
are hotplugged out during suspend and brought back at resume.

The cpufreq core already tries to make this path as fast as possible as
the changes are only temporary in nature and full cleanup of resources
isn't required in this case. For example the drivers can implement
online()/offline() callbacks to avoid a lot of tear down of resources.

On similar lines, there is no need to unregister the cpufreq cooling
device during suspend / resume, but only while the policy is getting
removed.

Moreover, unregistering the cpufreq cooling device is resulting in an
unwanted outcome, where the system suspend is eventually aborted in the
process.  Currently, during system suspend the cpufreq core unregisters
the cooling device, which in turn removes a kobject using device_del()
and that generates a notification to the userspace via uevent broadcast.
This causes system suspend to abort in some setups.

This was also earlier reported (indirectly) by Roman [1]. Maybe there is
another way around to fixing that problem properly, but this change
makes sense anyways.

Move the registering and unregistering of the cooling device to policy
creation and removal times onlyy.

Reported-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Reported-by: Roman Stratiienko <r.stratiienko@gmail.com>
Link: https://patchwork.kernel.org/project/linux-pm/patch/20220710164026.541466-1-r.stratiienko@gmail.com/ [1]
Tested-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44db4f59c4cc..4133c606dacb 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1571,7 +1571,8 @@ static int cpufreq_online(unsigned int cpu)
 	if (cpufreq_driver->ready)
 		cpufreq_driver->ready(policy);
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver))
+	/* Register cpufreq cooling only for a new policy */
+	if (new_policy && cpufreq_thermal_control_enabled(cpufreq_driver))
 		policy->cdev = of_cpufreq_cooling_register(policy);
 
 	pr_debug("initialization complete\n");
@@ -1655,11 +1656,6 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 	else
 		policy->last_policy = policy->policy;
 
-	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
-		cpufreq_cooling_unregister(policy->cdev);
-		policy->cdev = NULL;
-	}
-
 	if (has_target())
 		cpufreq_exit_governor(policy);
 
@@ -1720,6 +1716,15 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
 		return;
 	}
 
+	/*
+	 * Unregister cpufreq cooling once all the CPUs of the policy are
+	 * removed.
+	 */
+	if (cpufreq_thermal_control_enabled(cpufreq_driver)) {
+		cpufreq_cooling_unregister(policy->cdev);
+		policy->cdev = NULL;
+	}
+
 	/* We did light-weight exit earlier, do full tear down now */
 	if (cpufreq_driver->offline)
 		cpufreq_driver->exit(policy);
-- 
2.31.1.272.g89b43f80a514


