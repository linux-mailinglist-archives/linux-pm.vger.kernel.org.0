Return-Path: <linux-pm+bounces-25795-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C29A94DC0
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 10:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B92C188B680
	for <lists+linux-pm@lfdr.de>; Mon, 21 Apr 2025 08:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2719420E70B;
	Mon, 21 Apr 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auci1cJW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA62288D2;
	Mon, 21 Apr 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223216; cv=none; b=ZHp7SjDVJtc9oD6/i/gHjDnl0It9JbB21XxxhJnIxER1oLdLYL1ksUXImV7Sq5tvRqt1miydO1dbfPYM0Gy8gx4x/+ucPjpqm27ojX62OsKIajwdYUSDHpa1I7aUycqqmRbWBVqb/r7sE7k6hciNtv4U6S8PZWjfLIAuVtqaIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223216; c=relaxed/simple;
	bh=KESONawVQc7EwCYau29CxPwms+kLtvEtUci/pYAacG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oP90s0JOGKF562Rq6Vsg297Jyq5loIQHHRbsrz+lxWNG0I9oKqZfrOHB7fnbPD+8LGOG5dPcqmJyzQWxrUJO8MBG66rHXXzzd0jEbGSQRg3uuZ6ugzu8IBRRyY/GM2Mc4G2aD+AofujQ/+ol8AG+NXlUmYr17TRr2qty2qouHpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auci1cJW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D5ECC4CEE4;
	Mon, 21 Apr 2025 08:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745223215;
	bh=KESONawVQc7EwCYau29CxPwms+kLtvEtUci/pYAacG4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=auci1cJWJ5LwwHDSkfTNuUCkuXD5UWi/GS2REdcIOB04cclCI8ojQQer/DcNORvaY
	 g8zYLndpQ/Lv5MIVO2Nzqx2QL2zt27vyDmzJ6sEQw9a1PKxlW9i2AVPG1Dx0rAMvLS
	 vGSHbZm1uatjkPiQxix+h8LvKAS6GfASKzl4+Re1XMzxX+/TLtMLrfELAVjtRzbx+A
	 PHLoih23xhE8aGyo/hjYgcbYIoBJOM6cJUoNuMM3J0ZXTkLnZWIHitLq+K5+Y4Rk58
	 r/iwDf1+sSsmXpFEKToNcuxra7U+16jdNiLgLmqTeUzVhCCHYTk2Z8SuWy6YmQdCT/
	 ZPwvGCO1NJaEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDDEC369D2;
	Mon, 21 Apr 2025 08:13:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 21 Apr 2025 03:13:31 -0500
Subject: [PATCH v2 1/2] cpufreq: tegra124: Remove use of disable_cpufreq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-tegra124-cpufreq-v2-1-2f148cefa418@gmail.com>
References: <20250421-tegra124-cpufreq-v2-0-2f148cefa418@gmail.com>
In-Reply-To: <20250421-tegra124-cpufreq-v2-0-2f148cefa418@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745223214; l=809;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=goje1oshiHYjUzzYAZp/ybbJMpcm4IHxhykHgvfR+Oc=;
 b=zrAuRuIUwzyI6uIM3MhkgAZ+6ROLi1vFgqv8Sk4EMvUi9Zqepv7HlDGnaWhsZs46kSAmFkgdL
 BToHCPx+MTnBDbBAJhhRxldkFlc8T1IC4JkodoLavXEvdAJoRfpo2sv
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
 drivers/cpufreq/tegra124-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra124-cpufreq.c b/drivers/cpufreq/tegra124-cpufreq.c
index 514146d98bca2d8aa59980a14dff3487cd8045f6..dc83b1631b13ec428f3b6bbea89462448a62adb4 100644
--- a/drivers/cpufreq/tegra124-cpufreq.c
+++ b/drivers/cpufreq/tegra124-cpufreq.c
@@ -168,7 +168,8 @@ static int __maybe_unused tegra124_cpufreq_resume(struct device *dev)
 disable_dfll:
 	clk_disable_unprepare(priv->dfll_clk);
 disable_cpufreq:
-	disable_cpufreq();
+	if (!IS_ERR(priv->cpufreq_dt_pdev))
+		platform_device_unregister(priv->cpufreq_dt_pdev);
 
 	return err;
 }

-- 
2.48.1



