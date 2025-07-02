Return-Path: <linux-pm+bounces-29960-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF41AF0CE3
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 09:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706624E284F
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jul 2025 07:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12102232369;
	Wed,  2 Jul 2025 07:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnV4Ri9J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD092309B3;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442409; cv=none; b=nH6IKyq4IVjsYDevVssfcuS/bMJClS+8xl+5p6PJr7Vg/KZm4yseNKNL7+9Rzf5wVqlF5AiBj4Aclr/bUhu7d5E+7OUv6XYYenFw/vpbZCuHqvrU5hbeX9CFIz3MwgLaRllCclIGswPyKo6z/1Jx77BDdKDyb2ekthowvbgm+u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442409; c=relaxed/simple;
	bh=UPGQs6o7IxPKQ3JcTYGvuyxfO5biIaF57rUkGXslPb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cvN40lHstZ+nzIxJY/iNub5bnd1MaU2w1ccMn3KnI9Lyw9qSDn/c/rIXQs1gj9dQa9qzefLE9uH883D9qHf75A4Kfz00ApBK835bbMre2FggqhkBxlEbwNtIpHVasFnsMQUtTzkTUPJCmr4qCW7N2r34P8oEdLJI0kCfw/D87h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnV4Ri9J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C270C4CEF8;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751442408;
	bh=UPGQs6o7IxPKQ3JcTYGvuyxfO5biIaF57rUkGXslPb4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AnV4Ri9JJmbRqp+2AmdUWHshc+V6XXIpGoF5GH5eK9UPuYZfVvnpeu34Efkxpr1Ux
	 DQdgL1zW1Zb72KyiaUuNj7xOQTKoASEA3FduGQSYUbaOSCxcx1XjX7Pl2EvBePrAO6
	 aPI7EHIS5BkfW4IyRyUrT1BNVE7zTZ3jKaRdTT8rKHKwmk8AtztSlQ25FqEonfdwPm
	 w6J8A2aqmGWPZuHxBiXrASK64mVUe+EFdKQBmJSXCC99kiCdK6nhGIZrZskCUcIFl5
	 as2dLtwTRpZXKwO61NrPmUMfV8RhQrs83QmE1bpW5m/SzUAqJR9xtxuCBaYFeDztSP
	 7A4m+9PwFTyyQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F09BC83013;
	Wed,  2 Jul 2025 07:46:48 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 02 Jul 2025 02:46:25 -0500
Subject: [PATCH v5 2/3] cpufreq: dt: Add register helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-tegra124-cpufreq-v5-2-66ab3640a570@gmail.com>
References: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
In-Reply-To: <20250702-tegra124-cpufreq-v5-0-66ab3640a570@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751442407; l=1698;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=o7BSnjiEeAr40p8PQoKLMNpDwUQoKoaMMFdZbO3EPoY=;
 b=u4mb1O8HXeuudeU1EGdFvH0aUkecR25S5gJX5CVbPdk8NDZc+4BN+f4lUC6Z8GIrCWEn/rh6x
 cV07wFV9m6NAs9gOIagCuROX0B+zZJCWw3Xj6o336YmaPmLC3ICPw5n
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



