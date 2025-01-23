Return-Path: <linux-pm+bounces-20863-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A24B2A1A361
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 12:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 311507A68EA
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2025 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE98217677;
	Thu, 23 Jan 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vmrx21SY"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC4C21765E
	for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737632379; cv=none; b=D9gKvcxVjnUSFC4Kzwk5o7YAagfqx0uv7NnVYLnOD/Pgg6Y/UcTAlMZmNRRl5IOBhrdONT7eJta9zRMWTS3cEBxJDxZ1AFjl1koUF+GPV80eVsgML1MBSRQWHt1pVO5iuWd5aIuEQLLb50alErRZ/tQmI0x1YmKFT9UZ8o+hYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737632379; c=relaxed/simple;
	bh=LHdZZBs8LqTdaSpOCmU9TByv0nLy7UgO7+chu9ptj08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ISThDfZdtmqFqtI5gWilwEpcJYzilSkA0znScnV9IW0dntKziQCSS/VrucYYrEVtaIW+jIVWBgKJuOm3HyfklQQqmoR592pM3gi+x/Qb1DXKprC6cELzF07CuPpKFGDR6KtFI1jMmOXTMP1KckVB0hXADnrIKk/n7q5+25JdrFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vmrx21SY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb95317so12529195ad.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Jan 2025 03:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737632376; x=1738237176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBicRp1Zl8mKWJDqg/9fln4v72TIU9xhaEp8a6ynJK8=;
        b=Vmrx21SYwhSrZFdoFBUPr8kAzyD1BuqBIyM2VauFmgabm3klMTO29RsiYEpMXUutRn
         ++X90BirTFNUiIqnRrr/J/FwLfxvVE1qUABMGPRuyDzxdaIss0V/2oCDt4oBvPRKN5hi
         P1mUHHZinD7eA30ygqWFwmOc/ChO2/rZAf3QMlw67Gy9JvngSoxCC7W7y2JNskPxfOrF
         L1ejlar+06EHbX2fkmHen2dtGLk11LSbh99WUlG1Uizfl+ScdExV6ZYhkW1xm+Qax2FM
         nPdxv5aoPlbPNJtLBvIwbqxXl1+8PRU1LQqqyEqobji/du+tG+8uKuQ8mV6tNGZ+AeSL
         We5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737632376; x=1738237176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EBicRp1Zl8mKWJDqg/9fln4v72TIU9xhaEp8a6ynJK8=;
        b=sMVc3b2DeAkr+whPqHav/y2TQ+pJXDeunNMihpFbogekcvOpU770E0F2/KNGyBM2dy
         O5kLSsBM4e1t5PSjFybuEs+uxFFH1pseaeHqYCtGMXho4PgWZcIybLAMNMBHKjq/2lY4
         uXj0zTb2fkH+P8Y+3L6LiByXepKLRDf1/pGsf4yETzgKIxG0etb0KcnSSGChJq+elNf7
         9UFq/8XvUQ4xWwX7G6HjtjfFlB6m5g3y4D6y/Za2uq6GGaCRsd/RVGVN1PXkJ26ZsUcW
         VwzFbrxsmCShWwD1YSBZdYw2ijqJAt0i1UGnsxmCPWGgvMYwgUK0RTME4LSaa0dWGJGW
         HBYA==
X-Gm-Message-State: AOJu0YyaiLW+EKNCoV4KwbdHlrrQGLmNgrDYsseG8rii0/+bYCqnJeKW
	6HuUhjX8TcL/QdBPJid47zybUJdXg7//4+galK201XxbkYlWKoe++us/QE/6N70=
X-Gm-Gg: ASbGncsDsePwJ/NqDodJdSwkouuqXVAe453bvg7WeXyTIgrTm2FLNva0laCckR1g5Xn
	F1N1fZsGy4fi+mLpWfYrZdtT5J/fWF0hQ5hDyAjDQC9abWlb6BBbqCbjDjLrMEI4vcHQMMBvUQC
	cYBgyZu593ko+r7u8bZ6v9+SkO2VQl3BySViCuLm0mYYPsEAnhQjYPZh10vepSNYM7TQ0Q5LyVu
	ifJiVb+av68pNCfXzSfF8mhzeEfcIVMumCLe76FGfkjXsu3WVUUaRpdhLbrRbAj7JWc62F5ZKxr
	kAincq8=
X-Google-Smtp-Source: AGHT+IEVeVKW2icUS5K8c44XwKvlMP+JRAoHXW+RwI1RCgxUCMtM492yQON+xonJq1vZPLhZ81eMBw==
X-Received: by 2002:a17:902:ec81:b0:216:5448:22a4 with SMTP id d9443c01a7336-21c351bcc64mr417493375ad.10.1737632376284;
        Thu, 23 Jan 2025 03:39:36 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2cea0531sm112676825ad.24.2025.01.23.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 03:39:35 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 28/33] cpufreq: speedstep: Stop setting cpufreq_driver->attr field
Date: Thu, 23 Jan 2025 17:06:04 +0530
Message-Id: <2df2aa08d493cb0236361f21589b186c3585c37a.1737631669.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1737631669.git.viresh.kumar@linaro.org>
References: <cover.1737631669.git.viresh.kumar@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cpufreq core handles this for basic attributes now, the driver can skip
setting them.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/speedstep-centrino.c | 1 -
 drivers/cpufreq/speedstep-ich.c      | 1 -
 drivers/cpufreq/speedstep-smi.c      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 3fafedb983b5..3e6e85a92212 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -507,7 +507,6 @@ static struct cpufreq_driver centrino_driver = {
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= centrino_target,
 	.get		= get_cur_freq,
-	.attr		= cpufreq_generic_attr,
 };
 
 /*
diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index f2076d72bf39..262cfbde9ca7 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -315,7 +315,6 @@ static struct cpufreq_driver speedstep_driver = {
 	.target_index = speedstep_target,
 	.init	= speedstep_cpu_init,
 	.get	= speedstep_get,
-	.attr	= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id ss_smi_ids[] = {
diff --git a/drivers/cpufreq/speedstep-smi.c b/drivers/cpufreq/speedstep-smi.c
index 0ce9d4b6dfcc..39265884c3f1 100644
--- a/drivers/cpufreq/speedstep-smi.c
+++ b/drivers/cpufreq/speedstep-smi.c
@@ -295,7 +295,6 @@ static struct cpufreq_driver speedstep_driver = {
 	.init		= speedstep_cpu_init,
 	.get		= speedstep_get,
 	.resume		= speedstep_resume,
-	.attr		= cpufreq_generic_attr,
 };
 
 static const struct x86_cpu_id ss_smi_ids[] = {
-- 
2.31.1.272.g89b43f80a514


