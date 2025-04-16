Return-Path: <linux-pm+bounces-25506-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3A5A8AFAA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 07:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC44189B56B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 05:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A122A1CF;
	Wed, 16 Apr 2025 05:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dPP8+wAX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD2D22837F
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 05:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744781394; cv=none; b=gjMGL4minT8OxvGkWHhE0s3x3nm75rnh2ANqixM/ipMikDxaqhLs0IrgNyTUzicwAsoboNam9bgL79byYRVvjCPxhv064lPlu3aXwpTQ2eHscgp6TyXBK0dqN0JfIEjocuAqRQn8l0S+y2NaFev76dho6qZTKcYd04aoOYPNcxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744781394; c=relaxed/simple;
	bh=jc2P0FLKUbuUnuPT+QXDTqSMgRqcZBvymeXvHm2lyl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KrFMPyUaCQrNOcefCnP6kQ8fGAMNO2koZqMDXiCVJr/xSQBTB0CcXPpHv390MVYxWBOFTWA2KA1b0GhFHteXHteAmF0S+bMIcQtLIc62xEzL0WN5QTqZ1H7ImhtNuBAJSNQvSvq7MDd9dgwXHiSjZzKlw9HsHA8amzu03DEtwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dPP8+wAX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c277331eso324963b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Apr 2025 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744781392; x=1745386192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8JiAqsF5x2IY2pzcennaaVSFJ8VSWY+FvXn70ZrivFU=;
        b=dPP8+wAXAcxn2BcOLUS5B7ZfOQmka39rt7vlNUE5CYOJs5EG6xhpEpBDoiCXKg7ErY
         xVjBRG5RaCub8esr2a/vsLsYJjNN1JuCDGZ6Z7z+CdzTkW//nUnpYLpkOhzow0tRyuNu
         UnXqTc4y9DJLR9dK2Hs09RqcOhTVLGxVmVHufXHzURH746CBnuUZi19gK7SYcwGh6WI1
         x8DhXcALnwuKlJA6EE35BB9DBS4w36fq5HOideYGMIRqUaXHNj+mWfKh/asTWn23L72Y
         frGrubXQU8kCp7IxpcBSzSaVBZd+2f35bCxN4HeedgCXjAqCtVCuHdD2t1kb7ZneWBB1
         2Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744781392; x=1745386192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JiAqsF5x2IY2pzcennaaVSFJ8VSWY+FvXn70ZrivFU=;
        b=R3vQNQROBD1J50P6Fap3XgNQ4Q59M9PLOyx2aVwD5gC9f0XDms3YfzNvSI99xMVU2U
         C9q32UOdjKKt7H2a5/VfNV7UTCe5nOPL4gBmmXW0d76/3K8qHjxGDMb7wcIXA3DJKI9U
         K4aSjxLAxVq2a5KyC7YomfYtTf+HgU0icj5TDUw7r5/z7aSsYy53i+gCyQkFbdomwQ7F
         79EqL/1UVKExEpJWTezrXg4dR51NIQebUIxzczrBQcb3ew4rmaIhYy6vQOj6DDErWZhJ
         qUr7tgUiR9pdMN12qexLfRRXBbxR4FMZkUUyLpAPiwKokIoM9CCl726Wp0J63OxAGXvQ
         F8UA==
X-Gm-Message-State: AOJu0Yx/YDUFlY+TDM3WIAZvScx+Sfvo9ooIRi+KvKz8w7dyUFQOIlnD
	UnB0hmlAgDEEXY76LRwJD/6gfj0qi798g4mwOboDWMsnEQatbuvGrUXhMm3l5jA=
X-Gm-Gg: ASbGnct/Z6zOKXUEVjSosYaprrC1DdfZBoLF8n1IbuN785Psfik8XkAyl0mwZmzCy6O
	bv94CSqhuIckWi/zlU6gtdOg2RbJ0ntgGdWsacXVC+klXBcEejESbeGmUICWYnqO4ovjlDGZcg6
	9Wa0uXgm8hsEj9Bl9ZZZpjv3yJnGrv0O1EUheMlueO5Al6DK1i5a13HbkjK860vxWqKQ9VEsQic
	psZFHU2nPzxE4oOIHFrt8t3zacdZEcyK12CB7Aue3yvPWTs5mrCrhwsG+H0ccQc+0ZUJg5tbgLo
	a5BL0WUXJLjpqBE9iz5UBOba/V+6LJN/bfGlDYc3Vw==
X-Google-Smtp-Source: AGHT+IG61ZK8x5hBsfWexuPvwuzpYC8LpkByjNLxC/7ZjRGdoC7rJOSEBFLwDUjCqYQxWalVipYW4g==
X-Received: by 2002:a05:6a20:9f8a:b0:1f3:2968:5ac5 with SMTP id adf61e73a8af0-203b3b60d60mr655797637.20.1744781391895;
        Tue, 15 Apr 2025 22:29:51 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b0b220aa259sm474466a12.3.2025.04.15.22.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 22:29:51 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: acpi: Don't enable boost on policy exit
Date: Wed, 16 Apr 2025 10:59:37 +0530
Message-Id: <2c788c2ca0cab09a8ef4e384f272af928a880b0e.1744781329.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The boost-related code in cpufreq has undergone several changes over the
years, but this particular piece remained unchanged and is now outdated.

The cpufreq core currently manages boost settings during initialization,
and only when necessary. As such, there's no longer a need to enable
boost explicitly when entering system suspend.

Previously, this wasn’t causing issues because boost settings were
force-updated during policy initialization. However, commit 2b16c631832d
("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()") changed
that behavior—correctly—by avoiding unnecessary updates.

As a result of this change, if boost was disabled prior to suspend, it
remains disabled on resume—as expected. But due to the current code
forcibly enabling boost at suspend time, the system ends up with boost
frequencies enabled after resume, even if the global boost flag was
disabled. This contradicts the intended behavior.

Fix this by not enabling boost on policy exit.

Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220013
Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 924314cdeebc..85b5a88f723f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -89,8 +89,9 @@ static bool boost_state(unsigned int cpu)
 	return false;
 }
 
-static int boost_set_msr(bool enable)
+static void boost_set_msr_each(void *p_en)
 {
+	bool enable = (bool) p_en;
 	u32 msr_addr;
 	u64 msr_mask, val;
 
@@ -107,7 +108,7 @@ static int boost_set_msr(bool enable)
 		msr_mask = MSR_K7_HWCR_CPB_DIS;
 		break;
 	default:
-		return -EINVAL;
+		return;
 	}
 
 	rdmsrl(msr_addr, val);
@@ -118,14 +119,6 @@ static int boost_set_msr(bool enable)
 		val |= msr_mask;
 
 	wrmsrl(msr_addr, val);
-	return 0;
-}
-
-static void boost_set_msr_each(void *p_en)
-{
-	bool enable = (bool) p_en;
-
-	boost_set_msr(enable);
 }
 
 static int set_boost(struct cpufreq_policy *policy, int val)
@@ -532,15 +525,6 @@ static void free_acpi_perf_data(void)
 	free_percpu(acpi_perf_data);
 }
 
-static int cpufreq_boost_down_prep(unsigned int cpu)
-{
-	/*
-	 * Clear the boost-disable bit on the CPU_DOWN path so that
-	 * this cpu cannot block the remaining ones from boosting.
-	 */
-	return boost_set_msr(1);
-}
-
 /*
  * acpi_cpufreq_early_init - initialize ACPI P-States library
  *
@@ -931,7 +915,6 @@ static void acpi_cpufreq_cpu_exit(struct cpufreq_policy *policy)
 
 	pr_debug("%s\n", __func__);
 
-	cpufreq_boost_down_prep(policy->cpu);
 	policy->fast_switch_possible = false;
 	policy->driver_data = NULL;
 	acpi_processor_unregister_performance(data->acpi_perf_cpu);
-- 
2.31.1.272.g89b43f80a514


