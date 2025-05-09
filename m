Return-Path: <linux-pm+bounces-26907-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D73CAB06EC
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 02:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3271BC4A2F
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 00:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABD236D;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhwSM3XW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A208A2D;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746749057; cv=none; b=qmLT6Kwlv1MPLVl1Tcro24CNDZTdv/FPprN76oFQEHOrbHM8leJ0BNtwqrHgSqiEpJCY6LuWHOhotZW4xYja8G8I6D1P7/l+4e20VkZ0dZ1aJqD1BVthFqKp2EWpCBl/hRreywTuYLfRFzy7vhEw/d2xyyJGdjhJnbQUf0GeyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746749057; c=relaxed/simple;
	bh=NqoJZQYbOu0KOBDPUEf4rHSczzB69S5WPBdVEW4eXcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BuEny7ZopSc1uV8zziZFd1lM80oBMPKC23MHRnC4+oBQXjR9muDk9tH6GUnVfV+RDmCvmbKgGVCstfQ064kOdRe34hD855npPqZhdl+oD3Onx0wkvr3fHEmgaBKuSWoVOjFbT2fele8NwR42KcmdIL8F1nafVsRH5aScrcRpcro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhwSM3XW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61FAAC4CEEE;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746749057;
	bh=NqoJZQYbOu0KOBDPUEf4rHSczzB69S5WPBdVEW4eXcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VhwSM3XWXLu9L32IX3SbxI5sXVDDG/Sp2Vw9VJwar/5CnR3meo5AQpt5Xwm6SP2Jd
	 rj7zjyDyUkzG89jdDwty/pofaHEip8fjkex2zelYIpSuvcoG7G3HqjfIN6dHeBrO1h
	 ECBe3THCTh1NPzKqsjhn2mx8YzQvKK2QCtWnIIUkujrNdudJsM4q9dtKH29Luq048v
	 /KLbrvowJ9FgL+xdqBqVHW3bITGzK8ZAhFGTtkI9BRgBMYmVudNIAJ8k/TJLqGoFeT
	 T4uAUqEigztkxzkMulsNENnGxnUywqI1eLsKwnkxK6UIO21WDP2aA5nWwPbjbYiR4H
	 n6HkQrAKRfx/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C611C3ABC9;
	Fri,  9 May 2025 00:04:17 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 08 May 2025 19:04:14 -0500
Subject: [PATCH v4 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-tegra124-cpufreq-v4-1-d142bcbd0234@gmail.com>
References: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
In-Reply-To: <20250508-tegra124-cpufreq-v4-0-d142bcbd0234@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746749056; l=865;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=tiIp2lJcL5RDKC6iOuLruRLPB9+MEu1Fb+kT9gWphI8=;
 b=6ztn1BppSzZB4kAA4w/uQUj0mKqeIzD5KgOAqWR8jiN8KRDF79YfXJ3lfxUKHf6nZYfJxX8ti
 n+2jk3nDMWCBvMkTxLRyidq/BoOxV7zcJfD1Gc+b0a0She+gcvSGyS6
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Instead, unregister the cpufreq device for this fatal fail case.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/tegra124-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 514146d98bca2d8aa59980a14dff3487cd8045f6..bc0691e8971f9454def37f489e4a3e244100b9f4 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -168,7 +168,10 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
 disable_dfll:
 	clk_disable_unprepare(priv->dfll_clk);
 disable_cpufreq:
-	disable_cpufreq();
+	if (!IS_ERR(priv->cpufreq_dt_pdev)) {
+		platform_device_unregister(priv->cpufreq_dt_pdev);
+		priv->cpufreq_dt_pdev = ERR_PTR(-ENODEV);
+	}
 
 	return err;
 }

-- 
2.48.1



