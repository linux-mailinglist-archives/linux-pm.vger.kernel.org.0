Return-Path: <linux-pm+bounces-22166-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C74A3756F
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 17:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01F8116D90D
	for <lists+linux-pm@lfdr.de>; Sun, 16 Feb 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F618198A11;
	Sun, 16 Feb 2025 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA4tE66s"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97989450;
	Sun, 16 Feb 2025 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739722171; cv=none; b=gfvqG4s0PXAYj3/DeyYmT2XZvbomn/Sl11gFJm1bH4UoNLIgfJkVk+hN/qQpYaggYKY4p83wvws8LHPKSDxKzTNxl/Ik+H/xMimdoWIgW7N6KzLlc13LjxnEd3WXVL+uPoFghPUH2jj60vAl1uL+YRxVb4/PYrzPFFmtguJQ5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739722171; c=relaxed/simple;
	bh=mfbl0vJ7voZrewg6vqPE5K/y2Lsehv8G+ZR6l9PEvH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KKpEspcE2l2fLqP1NaUQzoaMSo2npdaAJjEz+LHg8zeLUL94kxrFg2OmjteXOWZv6sM/2ZdvGQeSk6C61sVQ8f0RTqxBhczvD8HGq9XXUunsghUCHLGAXcSGhFlbWGbnGlq8qLFyJHOFveH8XmGI1leNt6U3CMu/6ajDfqRdO1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA4tE66s; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2b89395a3efso1847494fac.2;
        Sun, 16 Feb 2025 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739722169; x=1740326969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rwXwJhkTpn0cp8zSQjVUxqBuPCU0+4gNIispero9yJo=;
        b=YA4tE66sWIuN6iYuyWeIr6s6gEVzmIAaUusZcglqeibsR43nGTyhoJs0IU2pWtCsVC
         CgbVax1zsosT4iAf5PpdxbSegrYLdp9ryhZ4IFsa1CF4FrRDsfRLZyrJS8NOSp3ybG9K
         HejzFdHcDnKe0kHR9PU9M+a+ReC858+7KtS3dQQa3QYvBpDfRzG+7lD+GxVe3zeRRRvv
         C5dP5jxM2jhP5OQioNKQGm9DXAJE1WHwV3BHfYfIULw4SMiEZPgS6v5o9+pwwVwgae8t
         CptV4dR/CL6ElaT+1aqGAUpg5lUffnis9MlLafjjPyVpUvTdDkBcgb4N7dp4LXLcXX1A
         fXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739722169; x=1740326969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwXwJhkTpn0cp8zSQjVUxqBuPCU0+4gNIispero9yJo=;
        b=B2gKFHA6geanHf/XsxvMg6xJG2ICpp5Cp3ui07VCybmZ0hJtWat4CDzkiyETsX5MQk
         NMBUjcAFnYBKIQxkqIISDqL2LI4gLoyFMNE8y2QraGMQshUhykxt/p4KZPC54Pm7HuWc
         vMhhrpVUZ14w/q+zIfLr73Xuer3FSDQHCXaFk4fMcvQumeAMpLQh83WFYaYGJOEW5xgs
         h9ZHLBXeQzi00QDUfLm6fVXJaGfhf5XGod94qsiLb30q6tr5JytWwlTYiCazjlyfXIEl
         vWG9JFae3IcVtHHPyD8zbmyZEHqnpuVQvliNISOKSN1baaLrJbS0KOwYXJviMKqSn+Nz
         l/XA==
X-Forwarded-Encrypted: i=1; AJvYcCUYJBNIhWsC3VRPW6kTk5J0oKz1fwXUTOMwTH++BzWq8und4346kpjGn8Gp1j+hSahy63l9rklUsqj75Pw=@vger.kernel.org, AJvYcCV3pyWdoeMgNxxui0s39/636SKazhW4A/5TIEfvR+TKHgK3N+5HImHqcM4/xznZriv4mkCDAHSgbQQ=@vger.kernel.org, AJvYcCXJeMCPIxG+eNRjv7wxEwULz5N58dcUEdbUuT2BRBFLu2xu0ZMJhhhRfj3CCHWhu/n/+TYJY0x9IlUuwXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbBhHCVsVMJ6j7M4ZkxiM+Rt9oIgNIivEACeQ80NpJgcPw4vhF
	xr/soIjNWeJKxySLw3gx4oVU+FqGBdI5n3Bb6tuB9xoonuFPFyGE
X-Gm-Gg: ASbGncuOv58C1e+1Lz8THOi9ie4PKhyBp3YHkqHvBt0ypiXcwQ+8gAnsRLkdrVR/Tqr
	oev9Q0FoZVufAozSY5/opmgkwQTnoBSLDhebrPf5fbzUo196SyUBiacWtK+k6DwKr/Qe3aIe94t
	U3+scY1b8bDKSXzgw/iQ58m+ad35YUXl1KdiKTn98Esf3vdhByQkztc3YcYLkJ/Fk3kycRWId0j
	mUy2y+B3yuVhcSLPtbqw+Fym7lT02FSIVRK9M+FIlvNtLMncofvol632Ebfx60FzIq16N+Vj/Hr
	jgzonNQwC6a0LndrriD4cPR01w==
X-Google-Smtp-Source: AGHT+IFJPDGkTR5KrflDiwTGE1Nz3oDLGA/P37bHvK58TqTMmGm8EI2n/rlW/oxOOtIfbvxA4e/B9A==
X-Received: by 2002:a05:6870:280f:b0:29e:4a13:603f with SMTP id 586e51a60fabf-2bc99a4b935mr3705664fac.4.1739722168850;
        Sun, 16 Feb 2025 08:09:28 -0800 (PST)
Received: from vengeance.tcpc.lan ([97.75.251.196])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b954875e0esm3355467fac.14.2025.02.16.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 08:09:28 -0800 (PST)
From: Aaron Kling <luceoscutum@gmail.com>
X-Google-Original-From: Aaron Kling <webgeek1234@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Aaron Kling <webgeek1234@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: tegra186: Share policy per cluster
Date: Sun, 16 Feb 2025 10:08:06 -0600
Message-ID: <20250216160806.391566-1-webgeek1234@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This functionally brings tegra186 in line with tegra210 and tegra194,
sharing a cpufreq policy between all cores in a cluster.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/tegra186-cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/tegra186-cpufreq.c b/drivers/cpufreq/tegra186-cpufreq.c
index c7761eb99f3cc..c832a1270e688 100644
--- a/drivers/cpufreq/tegra186-cpufreq.c
+++ b/drivers/cpufreq/tegra186-cpufreq.c
@@ -73,11 +73,18 @@ static int tegra186_cpufreq_init(struct cpufreq_policy *policy)
 {
 	struct tegra186_cpufreq_data *data = cpufreq_get_driver_data();
 	unsigned int cluster = data->cpus[policy->cpu].bpmp_cluster_id;
+	u32 cpu;
 
 	policy->freq_table = data->clusters[cluster].table;
 	policy->cpuinfo.transition_latency = 300 * 1000;
 	policy->driver_data = NULL;
 
+	/* set same policy for all cpus in a cluster */
+	for (cpu = 0; cpu < (sizeof(tegra186_cpus)/sizeof(struct tegra186_cpufreq_cpu)); cpu++) {
+		if (data->cpus[cpu].bpmp_cluster_id == cluster)
+			cpumask_set_cpu(cpu, policy->cpus);
+	}
+
 	return 0;
 }
 
-- 
2.48.1


