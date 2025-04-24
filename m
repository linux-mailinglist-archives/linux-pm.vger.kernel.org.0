Return-Path: <linux-pm+bounces-26130-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFC9A9B3B8
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 18:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838011BA4A18
	for <lists+linux-pm@lfdr.de>; Thu, 24 Apr 2025 16:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B92820DC;
	Thu, 24 Apr 2025 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KNiYkABA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235702820D3
	for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745511631; cv=none; b=QD/Mv6kQ9jysvTXg5WYDvvxW6jmirmfpjbF2EAmv5P+Zl92rMu75yylt1hjSUkLVPoPLRblT3kItleraGTiNRlzzuvsHUKWh0nJNnQJnA2yZLZCdMMxPfh9PzVPYGc/3rTsnd5spfc1q+3ibUHCYVEgxqDabMHjkdxT1R3XM2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745511631; c=relaxed/simple;
	bh=aDJVHGaFvaN7ytJ3XZQ82dd5Q/CiK/ofSwCmDjO8+jY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J6bThba3F0reyRrKI50Gec5Dw1VxrBNxc1hAly3+jzw/KisJpKektu9HgwmTC+JqsgECpHANKUb23lrW2G+NCcEU0fNBI0I+Ztj+zq7uTQNjIsUtn+kOru9UqyvBkicO7vfHeAZWLf409RmQW1RsRgoUACSZseBVCeBkAOzPCNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KNiYkABA; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22423adf751so14402845ad.2
        for <linux-pm@vger.kernel.org>; Thu, 24 Apr 2025 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745511629; x=1746116429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAEMnNThm5BtYQLpYvVy8LbqrgUr5WpG4VLt5eZ55BY=;
        b=KNiYkABAKvuybyX51ypI/jTgfwSwU5Apv3vCr3wuXxUb2JmNcXpIS9LjFiyL4fydlv
         5XHfm+J3hzLrl7R5gV5qK02tEEFdNtrEl/Yh+4QK31PL23Iz03kabEEqq4DfhCe/PlYt
         4dbjlDLVhDJG6WRpHqOUFiEkUJGwewUdV3c19jV6P6cBS04DVFxuw04G3ZaEybWQy3/n
         NcZdJxvvcX9UyPuRMN0ycxk+Lg8gvbiRJ4VvJoQ1z+pNzTyxpDwb6JYxM5stP021y59g
         sAHALTFuWik6+kO0q9Ar4qRLUKPDYx3+fDti8qCdjGpbCkdxcfV6kmTffsIQ0Pu+T0pB
         Vy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745511629; x=1746116429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAEMnNThm5BtYQLpYvVy8LbqrgUr5WpG4VLt5eZ55BY=;
        b=LqW5xEnspe/SCB9pqEjzSTlWWOXJWQildNjhX8sxJs+JJP+JtLNC8w1qcmvq7SsEVb
         5TDg3W6Bz8lvQGSaxENDdwoXAF5vL8CaAq88DBTGEjsTKaPzV+unGifUq75dymTymzd6
         bKg3wTb6vrBFNPY8QmVJbhHCKRqESmGH2P2AcC9/clVL6bGd6NZCDw4RLhoLIiYvdcos
         vssbFefiks/SfkgPbVaxV7sjL7F9HGGWr5FIRnATJzma3QniG9HjujTqlAYZ66kbcopv
         en6pmNTwqf3UiPwuwCiDgFZClnC8V/JGej+tzv/wb+nNswLcxRXwmuCos1XuKHOsO85m
         A+tw==
X-Gm-Message-State: AOJu0YzzabG1ps86jW1TfdY/3cgR/0BqffWuRJWN+WfD+cXySAK1GOx2
	P6ZWThwijVMv0akOOwIQfoZ/oe7CnJBcB6tMuQjtg/hz3Ny5wu6uXN/BeN4nRfk=
X-Gm-Gg: ASbGncssFcqdmVD458Ytkj6n6wDc3Rvo1gaRZM6mVtIcjxC9oaHH0zzg3Z78LY9tEgj
	8DMx9/kxZCeCJ3kZq1bSxGkKfNsRPxK1bU96UktRY+nlpwMzT0oqnyZXFYEW2SEvld+Hc7jJK5Q
	iwqjMbdtixhsMNUKqj7Bb+4wR42fCvB4kgiKDE+pQL0ipiQii03Kj6PUjMUd9kXj2Vbu6dhHAt0
	uFo6+yuPHtJXmLKXSfZ8d7pj3oTRt1nbUGK/iyIXlPthYfYHKYKAT0qcd61zUKmLPsWzF/1Hylz
	hgFhETa6/6PeZ332xa+fi0hY7p9odc6mkp7zRAdhTw==
X-Google-Smtp-Source: AGHT+IEC3G34HKnmp/Vwarv5ELQVHqGjzcRLSaOEM6FO3zSw7ZdDlftUSYsTgO6oH/156Kb1ZAVPTA==
X-Received: by 2002:a17:903:2f84:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22db3dc764dmr44052455ad.48.1745511629400;
        Thu, 24 Apr 2025 09:20:29 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db510304csm15416315ad.204.2025.04.24.09.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:20:28 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nicholas Chin <nic.c3.14@gmail.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/5] cpufreq: acpi: Re-sync CPU boost state on system resume
Date: Thu, 24 Apr 2025 21:50:14 +0530
Message-Id: <9c7de55fb06015c1b77e7dafd564b659838864e0.1745511526.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1745511526.git.viresh.kumar@linaro.org>
References: <cover.1745511526.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During CPU hotunplug events (such as those occurring during
suspend/resume cycles), platform firmware may modify the CPU boost
state.

If boost was disabled prior to CPU removal, it correctly remains
disabled upon re-plug. However, if firmware re-enables boost while the
CPU is offline, the CPU may return with boost enabled—even if it was
originally disabled—once it is hotplugged back in. This leads to
inconsistent behavior and violates user or kernel policy expectations.

To maintain consistency, ensure the boost state is re-synchronized with
the kernel policy when a CPU is hotplugged back in.

Note: This re-synchronization is not necessary during the initial call
to ->init() for a CPU, as the cpufreq core handles it via
cpufreq_online(). At that point, acpi_cpufreq_driver.boost_enabled is
initialized to the value returned by boost_state(0).

Fixes: 2b16c631832d ("cpufreq: ACPI: Remove set_boost in acpi_cpufreq_cpu_init()")
Reported-by: Nicholas Chin <nic.c3.14@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220013
Tested-by: Nicholas Chin <nic.c3.14@gmail.com>
Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 924314cdeebc..d26b610e4f24 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -909,8 +909,19 @@ static int acpi_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (perf->states[0].core_frequency * 1000 != freq_table[0].frequency)
 		pr_warn(FW_WARN "P-state 0 is not max freq\n");
 
-	if (acpi_cpufreq_driver.set_boost)
-		policy->boost_supported = true;
+	if (acpi_cpufreq_driver.set_boost) {
+		if (policy->boost_supported) {
+			/*
+			 * The firmware may have altered boost state while the
+			 * CPU was offline (for example during a suspend-resume
+			 * cycle).
+			 */
+			if (policy->boost_enabled != boost_state(cpu))
+				set_boost(policy, policy->boost_enabled);
+		} else {
+			policy->boost_supported = true;
+		}
+	}
 
 	return result;
 
-- 
2.31.1.272.g89b43f80a514


