Return-Path: <linux-pm+bounces-20921-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F3A1B21F
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 09:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F15C18872AF
	for <lists+linux-pm@lfdr.de>; Fri, 24 Jan 2025 08:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7348321A45B;
	Fri, 24 Jan 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qpRtzuNb"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886321ADC2
	for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709126; cv=none; b=rGtboP4YsXOCiwwjf34IPBR8mR2fPylLvhAqMj7ovo29aBLrTPXWtjRQMGtIRmZrDzs2/gNn/dNMFXt+BXp/+bdPRRlCBdta2gLVTwVQyLDQp6r7COUei4751dg0LAgUhz6252jNJaNQzWNZ6oyAh0ro/BKcRAX0XVsAf09H3lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709126; c=relaxed/simple;
	bh=ZtKAdPOE/yiUZcNKc6wx5VGP3CgOWIpPQs88KFvxwiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SIIKfVMf14OfhXQRSIpLPWY7ptPElw1Zc1uG4zTwLs+TLkjk7ar20GyFxtji2Am5tdapKQXMKS+a9Hn2pF2oUXa0C6SAwLi74++/AE0rGcnhwi2bauLSvcoiqC1o5tJ1ELmX2xAPokHRChsDP/zxXcsyDzjSU3ggSw3Pf6nfWyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qpRtzuNb; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso33173295ad.0
        for <linux-pm@vger.kernel.org>; Fri, 24 Jan 2025 00:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737709124; x=1738313924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yzYc7qVU9Uzxw80p5rHJnVdAt0LlKaG56j4kp6QKVj8=;
        b=qpRtzuNbB6xkzDmC3bNodkCyQnq+OL+cWU3hlEUj4oSNjNkTzBpCNzE6HsaTICbnWN
         kUN6YAi4ls/VsR4CSiK2rP62POrDgCF4tUTGo2WGIHwp1ymRAJmI5Ma1FTjyCacOdBOW
         l+05oIp6yBNvEsDnAMHQPWdUJ1FzcJjBj0VcRAFZ6mn+2IbgeFjZKyMsDGss0Pm/Si4q
         MEtgPOOzv5xQyBNipz9f3Ax2oxW02lXBkcWHWnLcD1g5pjzctdWVKDX48/83zcCMDY80
         wFiQhokuuaR01up5j7Dmfe3tuSj+c7KdPL5fjUQOP8HK6Wd7YdKEJ/lRQev2+/ZTOjRy
         nUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709124; x=1738313924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzYc7qVU9Uzxw80p5rHJnVdAt0LlKaG56j4kp6QKVj8=;
        b=dTC8/rdbfJpPi6dat35P9dGnJvkcw3hMf1exZOOkw1CgCAp01zCqSG7STFXwbq6X37
         yDoa8/pSi2hS1OD0SfkXLe3ki3cp1KIZwdOG+30W+p8Wr5oxSHlnbFwMtLeATLJGVNMO
         F/IN0N4uRSEEOMoZYQgVzI91iA3wzt3GdIeYmRWWI+s768ly7WVlm9TPghN3n5e8YT9O
         vNtHd5tMcY8b62H1DhOIOwLh+3uXYgdp4q9tTp6e5xgx+JwcRI6NXAFhY5pEauQWDJJ3
         NuRY+dWRpP8kiqyu+ezykPNzywuIZxA5HbNma6oJekAcyY/DYzMuiS8DNixdW83wzSqx
         9OBA==
X-Gm-Message-State: AOJu0Yx8AAH3SBRX+qD6B9zVLrQMes/rCALsiV6BhXG5UGrHklY6DPeu
	79dCl28nYpr1tpKJbYXh2FFY5WqHZvWFvIO9JIlTvqLdfnzms9UCV2vSI1aXi5o=
X-Gm-Gg: ASbGncuAB7GsWR3YiFctzRKSzc8TwDhe2/icsei/V7EnnBp3+hEDSoryHg+rMSl8Vmb
	/Veny8acWAW/vrdMhr9hhdMGTPT4HyPlhvlhsZroiqu0f2BNAC16AnLesy05mekUPgjE2F7DCMh
	byfk+daKMtA6wNGAhMSGWKC0NHZzStO4/O3JD1pHTcVVfEYB5cnWi0Ats4QnkGvCBADGt75Z7oa
	YVE1VB9uhrIKQtm00apOg6rw2rDxtUS9ZOZgE8e4vrj8O1uF94txSy8I70aIosq4g1J6/wDxGjK
	qrgD7iU=
X-Google-Smtp-Source: AGHT+IEW2J0hQVKd6sccpBRyw0/ehkHAqNU6doeIgHMGNqOjCEKZ13YCsHpa/owM+wMbKyWGMLNMzg==
X-Received: by 2002:a17:903:120b:b0:216:1cfa:2bbf with SMTP id d9443c01a7336-21c355deb5bmr484792275ad.35.1737709124236;
        Fri, 24 Jan 2025 00:58:44 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414da40sm11422255ad.179.2025.01.24.00.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 00:58:43 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] cpufreq: acpi: Set policy->boost_supported
Date: Fri, 24 Jan 2025 14:28:08 +0530
Message-Id: <0b4d7f14cd2c17a2abd5f94b67b50d293f5d6bc8.1737707712.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737707712.git.viresh.kumar@linaro.org>
References: <cover.1737707712.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a later commit, the cpufreq core will call the ->set_boost()
callback only if the policy supports boost frequency. The
boost_supported flag is set by the cpufreq core if policy->freq_table is
set and one or more boost frequencies are present.

For other drivers, the flag must be set explicitly.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 3b7e63e8cbd4..6f16cc25ab70 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -891,6 +891,9 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
+	if (acpi_cpufreq_driver.set_boost)
+		policy->boost_supported = true;
+
 	return result;
 
 err_unreg:
-- 
2.31.1.272.g89b43f80a514


