Return-Path: <linux-pm+bounces-25760-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8959AA9499F
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 22:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF0C3B2B5E
	for <lists+linux-pm@lfdr.de>; Sun, 20 Apr 2025 20:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C771D90DF;
	Sun, 20 Apr 2025 20:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2+1Fx6M"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD391D7E31;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745181743; cv=none; b=gI9BX4ITY04ajd114uMZM2DfI6aca3efYR/eFSkKRSSldXrE6zyuQIuq9Ov2MTtE73ZfvXTBhAfqGB1K0Mhrt2XUqzOhZLbYhRNIuvLHAi9qevW+40k8OI8xHJu6w5y2IaPvXHoZNOZYy/333OHctRoo1zPdQYpFeXwVUKGoVlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745181743; c=relaxed/simple;
	bh=LiLsSMNBkO/QQh5XLwAss8fuMt5IIFpKqKTysusd0ng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=di2wOrxFpkga6vA9/fYm+oWKINqW7B8GMYaQbrx0UUa4GGuly6DAktrRc0ySNy1yuVu7PvGyWJb0jp8GnrTXkXAtxgTqZlldnxD2+Z/DejXDn57/I1t27lEJhQ41Pic6XCoPvYrQLiGGws6Aibg8pH4E27WzPLgKY60iMlzZT4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2+1Fx6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46203C4CEE9;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745181743;
	bh=LiLsSMNBkO/QQh5XLwAss8fuMt5IIFpKqKTysusd0ng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P2+1Fx6MyRJpfsrUkgNwKWc86mJl/V5CMuiPFc/uworBvwB4Wa8JyPL1StLor6XWv
	 mg5ZMxz1tsqwGWsgDb2a/kefoA/doHlF+AyM8qFnLvOeGQIurxP7/DzHnXPFIqQObR
	 5hdpW+8X8y1o1VD38oxcY5MhQk3v5Gb4FcZ1BFyMMj3YBRlP7IV77C6iV00bkFAdjv
	 cuWaVDbbwAPiGUPCo94315++KezORn1s1JKTxABLf1VxN5bCSB6Il+nuosg9f2L6mk
	 HbSfKCzB77krH3ePmXMfxHEW1Bu6Eq1+0HRQPSaNPF47f6XbWtQNnTT18mB2gC1R1+
	 3ebaqNX9v5G/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3593FC369D6;
	Sun, 20 Apr 2025 20:42:23 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Apr 2025 15:42:01 -0500
Subject: [PATCH 2/2] cpufreq: tegra124: Allow building as a module
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250420-tegra124-cpufreq-v1-2-0a47fe126091@gmail.com>
References: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
In-Reply-To: <20250420-tegra124-cpufreq-v1-0-0a47fe126091@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745181742; l=1514;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=0/eJfta3Jq8byw+cbZkUJpmlw+R9HxZHBrK4OMYoxUc=;
 b=qNOJNyVuP9vd2vGD9n/kQuoAS9n/8fozqCUnEWanuZg7SnezDq4JliALrYslAXzV60rD9pmc0
 I1AJrESATxZCNef5ZKrtk5f894BXev2RHNdv2LblfwBqYnJp/1xD965
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

This requires a soft dependency on cpufreq-dt as this driver only
handles power management and cpufreq-dt does the real operations. Other
than that, this works fine as a module, so allow building as such.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/Kconfig.arm        | 2 +-
 drivers/cpufreq/tegra124-cpufreq.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 4f9cb943d945c244eb2b29f543d14df6cac4e5d4..625f6fbdaaf5fd774e3b0bb996eb7ce980da41ee 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -238,7 +238,7 @@ config ARM_TEGRA20_CPUFREQ
 	  This adds the CPUFreq driver support for Tegra20/30 SOCs.
 
 config ARM_TEGRA124_CPUFREQ
-	bool "Tegra124 CPUFreq support"
+	tristate "Tegra124 CPUFreq support"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on CPUFREQ_DT
 	default y
diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 514146d98bca2d8aa59980a14dff3487cd8045f6..9e46b53487fafdc1e9e95e765b9b490d9c95f2c6 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -211,5 +211,7 @@ static int __init tegra_cpufreq_init(void)
 }
 module_init(tegra_cpufreq_init);
 
+MODULE_SOFTDEP("pre: cpufreq-dt");
 MODULE_AUTHOR("Tuomas Tynkkynen <ttynkkynen@nvidia.com>");
 MODULE_DESCRIPTION("cpufreq driver for NVIDIA Tegra124");
+MODULE_LICENSE("GPL");

-- 
2.48.1



