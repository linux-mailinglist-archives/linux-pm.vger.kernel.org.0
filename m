Return-Path: <linux-pm+bounces-34164-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 056A4B49311
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 17:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDDE34E1D02
	for <lists+linux-pm@lfdr.de>; Mon,  8 Sep 2025 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EF30DD02;
	Mon,  8 Sep 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCfKPzi7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC29221546;
	Mon,  8 Sep 2025 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345067; cv=none; b=ExmreF4ztPwWhJ53BVUAKSQg5c2qoTpPL+R6NmLLatosst6WOXXYNX23eXkgnNidJb5LJyaih2JvgawrL6etJrUlUo/EefvfeGXvXfAOzKIg6EYCUgdBBWP4zKx72qKdxTY223IH0eHLWrv14jcy0n3JLXUqRC1msmf8SbEpPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345067; c=relaxed/simple;
	bh=F3qaWkwKt9cdMvSRM6WVc3wT/RqouyGxmJ6H6L5Udxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a2JUbd/BOGcFDLxe006ndDQMmclq/GtGBSVAU4Kb7aOqtBIZKDxQa5VjuqilVhG41XxvcO9R60NEz3z/EjF2RbGyh3AvxWO1KhkFseM5dscwrofZpUfu23u11IUNbOtdBvJYxB3RwA//SULFy3QSmAt2qJduNd+IY3L1CgRLbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCfKPzi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030DEC4CEF1;
	Mon,  8 Sep 2025 15:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757345067;
	bh=F3qaWkwKt9cdMvSRM6WVc3wT/RqouyGxmJ6H6L5Udxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XCfKPzi79lXScX38n+sryt0AldiXsmLEHRz8sLfamvCmyJKiCq8NKkNBYAUYsLh+f
	 asYFxzWRWpeWN4MX0HFNNq7yvs2930v+z1bOZLjMu5aNDnMTQzUrbZGgAs55qT/zzr
	 gLMAjBbDi0qdCM8TUlfbzUIPItUR6/laNMsIcrzxpPeTbJpzAmS7y90QHsUebxB7o0
	 TjFq0Y5XprmW7GjoUK1rpECk/F058Ph2eRZnJ5by+Y3/2lSFEsNxNuoROtsV3YiR9O
	 MZIvMoz5LcbcoxZyXkqhzLSguXd63S6KcRymbMwjj9Qao7M0XF7F2QoMC/9/B24xlN
	 rmGFSga6R2gPA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1uvdjF-0000000080a-1gbp;
	Mon, 08 Sep 2025 17:24:25 +0200
From: Johan Hovold <johan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 1/2] cpuidle: qcom-spm: fix device and OF node leaks at probe
Date: Mon,  8 Sep 2025 17:22:12 +0200
Message-ID: <20250908152213.30621-2-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250908152213.30621-1-johan@kernel.org>
References: <20250908152213.30621-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the reference to the saw device taken by
of_find_device_by_node() after retrieving its driver data during
probe().

Also drop the reference to the CPU node sooner to avoid leaking it in
case there is no saw node or device.

Fixes: 60f3692b5f0b ("cpuidle: qcom_spm: Detach state machine from main SPM handling")
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/cpuidle/cpuidle-qcom-spm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-qcom-spm.c b/drivers/cpuidle/cpuidle-qcom-spm.c
index 5f386761b156..f60a4cf53642 100644
--- a/drivers/cpuidle/cpuidle-qcom-spm.c
+++ b/drivers/cpuidle/cpuidle-qcom-spm.c
@@ -96,20 +96,23 @@ static int spm_cpuidle_register(struct device *cpuidle_dev, int cpu)
 		return -ENODEV;
 
 	saw_node = of_parse_phandle(cpu_node, "qcom,saw", 0);
+	of_node_put(cpu_node);
 	if (!saw_node)
 		return -ENODEV;
 
 	pdev = of_find_device_by_node(saw_node);
 	of_node_put(saw_node);
-	of_node_put(cpu_node);
 	if (!pdev)
 		return -ENODEV;
 
 	data = devm_kzalloc(cpuidle_dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	if (!data) {
+		put_device(&pdev->dev);
 		return -ENOMEM;
+	}
 
 	data->spm = dev_get_drvdata(&pdev->dev);
+	put_device(&pdev->dev);
 	if (!data->spm)
 		return -EINVAL;
 
-- 
2.49.1


