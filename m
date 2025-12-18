Return-Path: <linux-pm+bounces-39683-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3178FCCDB7A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 22:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3102430185E8
	for <lists+linux-pm@lfdr.de>; Thu, 18 Dec 2025 21:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549022DFA2F;
	Thu, 18 Dec 2025 21:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKDX5Va7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EA62FFDF7;
	Thu, 18 Dec 2025 21:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766094003; cv=none; b=N1fkYSLpx0m8O25JE2MF4M65NKp8T9beADacXOXY8b5nYS+LcGVi34ea7IQnl61waWGzCvj6L3quSCX6WOXKjRHmOqm9kwulMsjk7/AaOIflmZovWyIaQTvPYfudPP6OTpm+WK5E4KEFlMUeSuhh8GLDqu5HnISlT3ls+vPMSqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766094003; c=relaxed/simple;
	bh=vsV2c+tuF7IFL3gRXtUBGofxq0oUcI9To7itUQjzrSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q8YopEskzNGVuNCBt2890RGg7qxKj/nre3+OxqqExqDoVzM36RVpAuMzFAbZGBmpF1Xf5sf80YZGh59Svb9/NjWwBZLEmNDXyFR2dLI9OKJC9diYFYVRTyIL5QOdoqEH/iccpRYBea5XuX5SElag3Dn7JmF67IWvU425oLJWx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKDX5Va7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88174C4CEFB;
	Thu, 18 Dec 2025 21:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766094001;
	bh=vsV2c+tuF7IFL3gRXtUBGofxq0oUcI9To7itUQjzrSs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jKDX5Va74hjHPdYrZS2jbQuI2cwH0UGPnG4UqBwAoOXH4LPkfg3TQaa2STJe0PI98
	 qBmlbMmF4B+gOgmdvFLumV+sJzNU8FcrJHP//Th/XMoTFIyo2VMkof3DKtW+o+nMnQ
	 Ly/yOlGDEi85caR6vZd5zOmt3i63ijoC/KdVvri0sV5Y9Ex2bmX6x+Wg7VLl4vb4kn
	 fq6ZVo/XlvGucDr+jRAGLRMgt/2ZttKRPqylI3osTIJK23SkpigE8YAGZx3HG0yg2D
	 Q1kPWMQB5CESNesUqT96wz/UJfLt3JkQHNz0MH54fAsfWMAu1xywqJolBRznwJ2Fo3
	 8NnitjFTDmyUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DA2D711C8;
	Thu, 18 Dec 2025 21:40:01 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Thu, 18 Dec 2025 15:39:52 -0600
Subject: [PATCH] cpufreq: Add Tegra186 and Tegra194 to cpufreq-dt-platdev
 blocklist
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-cpufreq-dt-block-tegra186-194-v1-1-24adeea10b86@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQqCQBAG4FeROTfQLCXWq0QHnf3XhkJtVkMQ3
 92l43f5NspwQ6Z7tZHjZ9nGoUBOFemrHXqwxWIK53CVIA3rtCTHl+PM3WfUN8/ovZWmZrldWFN
 INbSDRFA5Jkey9f8/nvt+AGgpY25vAAAA
X-Change-ID: 20251218-cpufreq-dt-block-tegra186-194-cf2f6ecbe1de
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766094000; l=1011;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=NeuYHwaGhtf7Xwzd+4B3Gb3sX3e9KS9/TfvzfQbvhwc=;
 b=xciAxoY3GJgvChXqtKjoSv7DCCIujX80mlun25nM6obSqyP+9dllSHp3qd4jEszgD9RjVdIDV
 5Rp7P3GQqtxAUhPKN5faJvvwo1MwoYTiBkqkL/lmDjmqiEkkpdy46a+
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

These have platform specific drivers.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index b06a43143d23c6365e1e0b26d4299ef4b0c3482f..1708179b2610bca6035d10f0f4766eee6f73912e 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -147,6 +147,8 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "nvidia,tegra30", },
 	{ .compatible = "nvidia,tegra114", },
 	{ .compatible = "nvidia,tegra124", },
+	{ .compatible = "nvidia,tegra186", },
+	{ .compatible = "nvidia,tegra194", },
 	{ .compatible = "nvidia,tegra210", },
 	{ .compatible = "nvidia,tegra234", },
 

---
base-commit: 1058ca9db0edaedcb16480cc74b78ed06f0d1f54
change-id: 20251218-cpufreq-dt-block-tegra186-194-cf2f6ecbe1de

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



