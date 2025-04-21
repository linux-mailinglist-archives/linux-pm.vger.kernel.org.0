Return-Path: <linux-pm+bounces-25807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D639A9554D
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 19:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54B1616CBE3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 17:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F491E51F2;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKuV0Hqu"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA98A1EA80;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745256839; cv=none; b=nNvK9T0MN+WfqfCsXRAuOo8TZ7fbx+Oiyx8guzMRmqYz5h8xV2hCTNWZGn40FWi2MDDsIPrFD9vp8hsv/E0TFiHC2+8gCqobMAlcpZ5MS/VNq4LsqBaQX6+MpfwXHZsNVK3GpD6f15CVFTy9Xd5kB3vViLvJJlFhFwjCcg/c9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745256839; c=relaxed/simple;
	bh=NqoJZQYbOu0KOBDPUEf4rHSczzB69S5WPBdVEW4eXcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SH7jwy3aYHQtNVY54vgrhH+H8AY415x3BJxpjpSY1JD+6Z3rr1EvdOC46FawJzbvHP589Gkx5TBG7Sfr+Yt+IbE0G3Wyt1x2nJH/wT/3n+fo98Rx/l3jHqf869QWG3Z+FerEJLiXtYNFNQWTD5Ohbs8iTrOMmgujbDCiQwouJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKuV0Hqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42EBFC4CEEA;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745256839;
	bh=NqoJZQYbOu0KOBDPUEf4rHSczzB69S5WPBdVEW4eXcw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KKuV0HquLQ/Sem+Bz5ekHsv5p53n3t+JK8aO7HuY+tKgV6CHfREWIa0OHPnEctLwL
	 zJwDZO/bJh3x8w4SzX4oFdak8pLdyxKMrBlOGRD6nEhChn917Y8IqaF2mVqQ/4VK4U
	 3QWWc2iSwZrqbESs/Ln4vUc51+Kj9cscMkV2DmD02swYcpgRl+11dnDSBkschjlLdh
	 fpaXbCIuxrtS5+R7zcI+xIsuIeUi4n8GFt0JSDbB5juTinU08BvCyD7vEuH+wPzVY6
	 rwCJSfocqJPaBO1zUlO7P6EDiaVX8oomr89MXvTn9R5lItL2SjBSKcopGy65K9gI14
	 ShS+bPJVJgsMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB4FC369D3;
	Mon, 21 Apr 2025 17:33:59 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 21 Apr 2025 12:33:53 -0500
Subject: [PATCH v3 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-tegra124-cpufreq-v3-1-95eaba968467@gmail.com>
References: <20250421-tegra124-cpufreq-v3-0-95eaba968467@gmail.com>
In-Reply-To: <20250421-tegra124-cpufreq-v3-0-95eaba968467@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745256838; l=865;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=tiIp2lJcL5RDKC6iOuLruRLPB9+MEu1Fb+kT9gWphI8=;
 b=wIoxmTafephvHoyDlkM9je+aFkL6yJWeRsaIsXgqufWBpmx4ObTEaQPlauteETDvmHx2/7pZe
 OJWrf/bhXvDBwIqP1TOvdhxGc5lnGv0sFRg0rlWFDUcwrEPBTURPeYo
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



