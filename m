Return-Path: <linux-pm+bounces-23021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637D3A46A2F
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 19:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E613A3E83
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 18:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA62236A62;
	Wed, 26 Feb 2025 18:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxZNGvK1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D91236443;
	Wed, 26 Feb 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595922; cv=none; b=PqqRIwve3YuTm6LzW+Imq9r/4U3+xrctCFzUzepjteybapeVsI5s/xD67IWfQJPFBb4DkfUJj+R6iYx+NDPiXmApXvQP4YQGryQnaqp0pZNK4Z9HinZ9u8s3LuKW8FQ+v3xgUR25l3o+RdRBWdYtz2pQE1XFyUTSPMScfz6tMiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595922; c=relaxed/simple;
	bh=CFXegxZ6Pqf+ZCQVYyiQGtHlYNxqNF8xnYq6BFB3mf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ubUNcs9SBXxn4twjnNmXt75mqsx+x2tfZQ1ura9P++SZlH7lh6i4pEIJU01R/KwyqvC9/MX3aKCNOyDfMh0RZf51Qrgd2o3UxmqtIGdIQJZjJQ0/xGF7MeZqB7L7EdVnvDBRg06vBCOBYsshcTEjwVD330QDEw8HrqN0rcUp9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxZNGvK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74359C4CED6;
	Wed, 26 Feb 2025 18:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740595921;
	bh=CFXegxZ6Pqf+ZCQVYyiQGtHlYNxqNF8xnYq6BFB3mf8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=HxZNGvK1Af/pH3JiXoc+NzBbf449XFL0SBUUsU7ctDCUTOJgEolws18OxiKajvyiI
	 Tz/r2lce26jCk4ZMoKq69z1snPUml0aHAsR5WLkZACDfIpkclrT4maplCjPZBWD5OS
	 QuER9UUpYFEsRzgGBNyAI+rPrQGnQEhUSu3zWhS8xwwRjNJbUiI/1MCveMWcbvi+yl
	 IJJsC0LyIjLej7k+S6qcSih3wlBJSdyoL9EQO9MiEQGtrrFvpz0/mlnxCxNv/9WJWf
	 VS9970kRNqeOAz4CdjZrw22HG0IHw31GhDkVLuRkRPuDrp0H+aktcrQPjB5M3E1NHi
	 u4K3zdwpokEdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686C2C021B8;
	Wed, 26 Feb 2025 18:52:01 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 26 Feb 2025 12:51:59 -0600
Subject: [PATCH v2] cpufreq: tegra194: Allow building for Tegra234
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-build-tegra234-v2-1-cf7e0828714e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAM5iv2cC/3XMyw6DIBCF4Vcxsy6NjNhIV32PxgXKgJN4C1jSx
 vjupe67/E9yvh0iBaYI92KHQIkjL3MOvBTQD2b2JNjmBiyxLhGV6F48WrGRDwYrJXrZ1J012ll
 lIJ/WQI7fJ/hscw8ctyV8Tj/J3/qXSlKUotKkSEt0+tY8/GR4vPbLBO1xHF8+ucJarAAAAA==
X-Change-ID: 20250224-build-tegra234-c185bda9fd4a
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Sumit Gupta <sumitg@nvidia.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740595920; l=1281;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=GG8pNgZW8mtQ5aeY2C820RuKlp035VZNXb4TjlINh+A=;
 b=zB4HOcISgehHy7Msut+TQBc3j6s72LSJxEraXHywnKs5su5bJZGKTooUzqOTLcm1t2VlpsoHs
 z+bdcI1fiPxAIradJsOH/0g6L2oh2A9Hw4ml19sMM3W0hgIAW2YCsEs
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Support was added for Tegra234 in the referenced commit, but the Kconfig
was not updated to allow building for the arch.

Fixes: 273bc890a2a8 ("cpufreq: tegra194: Add support for Tegra234")
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
Changes in v2:
- Drop pci patch which duplicates
  https://lore.kernel.org/lkml/20250128044244.2766334-1-vidyas@nvidia.com/
- Link to v1: https://lore.kernel.org/r/20250224-build-tegra234-v1-0-39e4e912f968@gmail.com
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 9e46960f6a862b8b686a79bf3c20f1024ce3d02d..4f9cb943d945c244eb2b29f543d14df6cac4e5d4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -254,7 +254,7 @@ config ARM_TEGRA186_CPUFREQ
 
 config ARM_TEGRA194_CPUFREQ
 	tristate "Tegra194 CPUFreq support"
-	depends on ARCH_TEGRA_194_SOC || (64BIT && COMPILE_TEST)
+	depends on ARCH_TEGRA_194_SOC || ARCH_TEGRA_234_SOC || (64BIT && COMPILE_TEST)
 	depends on TEGRA_BPMP
 	default y
 	help

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250224-build-tegra234-c185bda9fd4a

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



