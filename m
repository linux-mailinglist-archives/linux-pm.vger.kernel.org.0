Return-Path: <linux-pm+bounces-30316-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B1AFBD51
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 23:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE85B1887DA7
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 21:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD57287252;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI+O4Fzf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C81285CB6;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751923040; cv=none; b=mF6K6Uj9+bl26DEVamAsHD03HWuR5BYmgw82wmVhTgQ2BcqCEy8OxABfbueJ86yZfZSKCDUxGzmiggdQZJVTeEoD4mbzUzkKVKvKzKoko++d9rMcqAfapw2KcpH8cwghYzfP2UmurRNvMSoWea/W6wUeknY9S4JVF05NoYJsbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751923040; c=relaxed/simple;
	bh=UPGQs6o7IxPKQ3JcTYGvuyxfO5biIaF57rUkGXslPb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qABlGG5mrG5gwtBba03Dn/XX171YXmcaqggMu+U8a2mb6AZQIhOGpWK4dRljPvRzsFt5P0glmBAN6dzkugCZEkXc02quO3WeUjP7pFBsWsZRLB6QcabYkZSJtaKLuNTmUSNXx5VlOhMKOCYt6v5j1g8LfyMBCLdgxlW5d5r8KCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI+O4Fzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34700C4CEEF;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751923040;
	bh=UPGQs6o7IxPKQ3JcTYGvuyxfO5biIaF57rUkGXslPb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jI+O4Fzf04vU2gDgfER/7R1fMRzltZP00uVSXVytd4drz/e69Z2rXedxJwEKGF0Xf
	 cE25CfrJyL7aIGB8niQwQzIlUGO+d3L3UYP+eI5KdQPP3b0fk8himFI2D/AksjN58a
	 BVcSmvFaLNi8VvAN8hxO+7M4ufIpCBKPqUfXtra221LRwnZQpfNnmUq6wFAEkPqMGQ
	 zbe9dR91KoumfSozI6uF34D4/XWO0iWbR7uxvquN5GAFWLtmcnzbqdN+zjKyrt7yOD
	 hmJyYYoj8skFCzYVwZZRR0BXDxg+o69GxtaedrszUy977UKcjbsKXZnSTNYvcVSfup
	 B1mz230bq4WJg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22EE3C83F0A;
	Mon,  7 Jul 2025 21:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 07 Jul 2025 16:17:14 -0500
Subject: [PATCH v6 2/3] cpufreq: dt: Add register helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-tegra124-cpufreq-v6-2-fe69c0f9bbab@gmail.com>
References: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
In-Reply-To: <20250707-tegra124-cpufreq-v6-0-fe69c0f9bbab@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751923039; l=1698;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=o7BSnjiEeAr40p8PQoKLMNpDwUQoKoaMMFdZbO3EPoY=;
 b=wXWLmy6jc3k4OJng0097xSiNPXWyA0flXotAsiuNhuR+74Ab7gz0CiykHDD4jteSMI7q1Qgcq
 1/bp4h/blJ1Dx96SKgvPmhzQTaeL9Axr4vljJ+lI7S3hfO5xrMFt7Ga
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Cpufreq-dt currently exports no functions. This means that drivers that
are based on cpufreq-dt have no way of establishing a depmod dependency
on it. This helper allows that link.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/cpufreq-dt.c | 11 +++++++++++
 drivers/cpufreq/cpufreq-dt.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e80dd982a3e23f6e678d691daba2d8bfda28d93c..506437489b4db241a7a6259274ae84e688772e66 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -329,6 +329,17 @@ static struct platform_driver dt_cpufreq_platdrv = {
 };
 module_platform_driver(dt_cpufreq_platdrv);
 
+struct platform_device *cpufreq_dt_pdev_register(struct device *dev)
+{
+	struct platform_device_info cpufreq_dt_devinfo = {};
+
+	cpufreq_dt_devinfo.name = "cpufreq-dt";
+	cpufreq_dt_devinfo.parent = dev;
+
+	return platform_device_register_full(&cpufreq_dt_devinfo);
+}
+EXPORT_SYMBOL_GPL(cpufreq_dt_pdev_register);
+
 MODULE_ALIAS("platform:cpufreq-dt");
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
diff --git a/drivers/cpufreq/cpufreq-dt.h b/drivers/cpufreq/cpufreq-dt.h
index 28c8af7ec5ef3ad0aa94f43ad9129600ca094329..fc1889aeb4f1f15fa7c46c2380021bbf40b62f11 100644
--- a/drivers/cpufreq/cpufreq-dt.h
+++ b/drivers/cpufreq/cpufreq-dt.h
@@ -22,4 +22,6 @@ struct cpufreq_dt_platform_data {
 	int (*resume)(struct cpufreq_policy *policy);
 };
 
+struct platform_device *cpufreq_dt_pdev_register(struct device *dev);
+
 #endif /* __CPUFREQ_DT_H__ */

-- 
2.50.0



