Return-Path: <linux-pm+bounces-2536-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8036C838795
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 07:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2018A1F21741
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12D851034;
	Tue, 23 Jan 2024 06:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWqVz/x8"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9151024
	for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 06:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705991980; cv=none; b=MCckZkwQh7PhKMDQzlFNecsf1Z1Z9DDBGU5DVo2G3H8mRSUAK9OZ2DoEQqO5wQIc0qgJ1YBz+lz68Qm6gw1LAO3MM/PIvaibxlmxijf4T4xvDqA1FfLvZjzdjC5izmow8IxVdHEbSAWEzfh5jEKwLvqWSbwRjf5WXpjbC6hGpEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705991980; c=relaxed/simple;
	bh=97fUsI3syBIh9/BxtfH9kv6054fMXX9A+KQKCKVBfXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AISrIYDdxx9FrJH9NOOtynHe0V/+i47gRUgm1IGNhkjtSAHZ6czBw3ZCP2eXgPPpRwxFqTScpkUkjTJA0JMMjhmKb3AjvgnAYkcIsOThsHItQw9CYbvLkAtIB8Jr/XyTZe5LS0Vi2H0s1NCXgyQO6IC6n7wDOE3hRixJSYPIe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lWqVz/x8; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6dbb003be79so3466690b3a.0
        for <linux-pm@vger.kernel.org>; Mon, 22 Jan 2024 22:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705991978; x=1706596778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwio5HJQpvc8muMFO1anj17hxV7JwhZHGw2QVILfq9g=;
        b=lWqVz/x8tATAlQVo2yotw/ouuLHyeh1mRMSy2Lt/0VERuXzRE/t9d8RjnV60awJWg9
         nFukiYrq9i8T+9T1EtQQwEuLZus5AG9bh5W0C2IC7K7is9tSs9DZmNUtmTVjO0G9vN1N
         CyabPGvxsNFedVeRJcY/UOcDD2iGBSI+Smrvlsng9/+j9JnnZaQWct6Ilki4SeLj4vyT
         3bMi6k9IZ1hGNdJAFsVsWi+gcl2M/nE0CwXUqyEW9IIUvml121OkJAGtjzMQLd8ELlAf
         +D7Q2plp75LedHHOI/+sSKNJ6tUbDA3qERJk2/4If3YTkke68oQuTTO+cXctBo0YbxUu
         fVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705991978; x=1706596778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iwio5HJQpvc8muMFO1anj17hxV7JwhZHGw2QVILfq9g=;
        b=Ug2t1jReUqWlOoMF+AccNzqF0LqGYpUDEzXnBsVkoe0/COZdsJe/mmsR0ASQstoiZA
         otOyYTHZnLLnIP09C/j2obtVYEJAy52u36NiiSPHNIHSFKPfODde5byJkiWREYIxxTcM
         YqHpCisTJ7txuIsUe1o/N9UD4zltgdBe0vty0MrM0u4V7kpGtcePiQto3uP1dqW8Dp+u
         yy++8qD8q4UxOXR0JGTeGOnwfaBFf0gU4I8PVmZm2DPaCnaml7wfyqOK3B2EQiJkRVql
         rD+fe8ZQxLYOanwcTmbPjKb3yeg8Lkdo4lExmu0bLBfh8rW2/sRzEWvyIXa/K9P7H2Qn
         LZEw==
X-Gm-Message-State: AOJu0YyKFnRsrO4XXCOAn/GgsN3mh7kcOsh3/bwA7CUXysmiFDVdQipc
	pk+GGZtIoPulb1iG2pvZU0PNg20n0xcfcjXMvnCF9irsPksu23sOhKf7pGnDKDY=
X-Google-Smtp-Source: AGHT+IGRkUJZ64S+e5w8iA3Eig0m/KmoRJTuAHlDEoT2Bp9ReodFgcUTV4umNazpcnzIrz0lfhKWtA==
X-Received: by 2002:a05:6a20:9f9b:b0:199:4910:fe5b with SMTP id mm27-20020a056a209f9b00b001994910fe5bmr6333136pzb.54.1705991978692;
        Mon, 22 Jan 2024 22:39:38 -0800 (PST)
Received: from localhost ([122.172.81.83])
        by smtp.gmail.com with ESMTPSA id ls30-20020a056a00741e00b006dbe42b8f75sm2530831pfb.220.2024.01.22.22.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:39:38 -0800 (PST)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: Move dev_pm_opp_{init|free}_cpufreq_table() to pm_opp.h
Date: Tue, 23 Jan 2024 12:09:34 +0530
Message-Id: <ace4b31b297dfd7b8c969ff5046c8128c3e025be.1705991941.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the declaration of functions defined in the OPP core to pm_opp.h.
These were added to cpufreq.h as it was the only user of the APIs, but
that was a mistake perhaps. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Will take it via the OPP tree.

 include/linux/cpufreq.h | 20 --------------------
 include/linux/pm_opp.h  | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..8ff3e79727d8 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -694,26 +694,6 @@ struct cpufreq_frequency_table {
 				    * order */
 };
 
-#if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
-int dev_pm_opp_init_cpufreq_table(struct device *dev,
-				  struct cpufreq_frequency_table **table);
-void dev_pm_opp_free_cpufreq_table(struct device *dev,
-				   struct cpufreq_frequency_table **table);
-#else
-static inline int dev_pm_opp_init_cpufreq_table(struct device *dev,
-						struct cpufreq_frequency_table
-						**table)
-{
-	return -EINVAL;
-}
-
-static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
-						 struct cpufreq_frequency_table
-						 **table)
-{
-}
-#endif
-
 /*
  * cpufreq_for_each_entry -	iterate over a cpufreq_frequency_table
  * @pos:	the cpufreq_frequency_table * to use as a loop cursor.
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 76dcb7f37bcd..f1ac8bde09cb 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 
 struct clk;
+struct cpufreq_frequency_table;
 struct regulator;
 struct dev_pm_opp;
 struct device;
@@ -444,6 +445,21 @@ static inline int dev_pm_opp_sync_regulators(struct device *dev)
 
 #endif		/* CONFIG_PM_OPP */
 
+#if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
+int dev_pm_opp_init_cpufreq_table(struct device *dev, struct cpufreq_frequency_table **table);
+void dev_pm_opp_free_cpufreq_table(struct device *dev, struct cpufreq_frequency_table **table);
+#else
+static inline int dev_pm_opp_init_cpufreq_table(struct device *dev, struct cpufreq_frequency_table **table)
+{
+	return -EINVAL;
+}
+
+static inline void dev_pm_opp_free_cpufreq_table(struct device *dev, struct cpufreq_frequency_table **table)
+{
+}
+#endif
+
+
 #if defined(CONFIG_PM_OPP) && defined(CONFIG_OF)
 int dev_pm_opp_of_add_table(struct device *dev);
 int dev_pm_opp_of_add_table_indexed(struct device *dev, int index);
-- 
2.31.1.272.g89b43f80a514


