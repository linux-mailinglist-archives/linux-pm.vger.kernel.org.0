Return-Path: <linux-pm+bounces-34198-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEFB4A1FC
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C86D16E47D
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BB7302760;
	Tue,  9 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA8ol0Cz"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31CF3019B0;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398894; cv=none; b=fNeoV3hOYi63H61RdIeZ02fBETYQ4AlFWFZiB6jafnwx2QMdQfAhlcfxLoDPPGAgjDSP8WgNK7owEfroix2v670SucKhSlDBqc+kJcQRs+rTpri2tH9eLQ7sfga6dmj4WnT0JsXLgcTvP8A54jtZsKKGbR3GUMwbZ2FHJhKqqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398894; c=relaxed/simple;
	bh=Ze9D0/HuTzUb0aMQasiWEKnNNc0FMjQN2+TxiuxDzFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btzVlGQ5BsLWrebu+fY3l3U2l5w0KPJfQByeUEzLfKBWqcrFfJf/Ur9FBvyqJ9ePz04Aibcsc0/56jcN4DxY8z7vsHOYTbm7Ioc1JXdov7+IV3VxZePIu/t3Ioz32hsL2Sh+501GbrYMDg6AMFJlrE0jOdVQbhNGYUcE6/uIBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA8ol0Cz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75A41C4CEF9;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757398894;
	bh=Ze9D0/HuTzUb0aMQasiWEKnNNc0FMjQN2+TxiuxDzFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YA8ol0CzgbduQivg3h/evfoidWyfKA5cLTWBRJPKIvRb30TuJi1blHVp2SUyQfyo+
	 AtnDEEGAtxhDP45tRm9DFv5Ff/K2+SbjBXFxKMkSoeNT0ZczE4lcUUdYiF4SDd1x7e
	 y248+ksgj71pQMAe2qom7qN4soSMb2b1zpzOV1TLwIsxATp6c8lhwjmkhlDAOfCHrh
	 Kh83K4aPA1AGwNucatrOCdfKEmqXy240j4b2AxhhSPFQyg+DOGsrbGODvejNAiIDct
	 tOCAZgp6+142LCFmZiwR6rzN/wWKzDabFknzWoe4IaEmxPxz3IAxgHKDnU5MuCjgp/
	 Flo3RU8KiXv4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64835CAC589;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 09 Sep 2025 01:21:30 -0500
Subject: [PATCH v2 2/8] dt-bindings: memory: tegra186-mc: Add dummy client
 IDs for Tegra186
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-tegra186-icc-v2-2-09413724e781@gmail.com>
References: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
In-Reply-To: <20250909-tegra186-icc-v2-0-09413724e781@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757398893; l=816;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=68sWGSUz7jYX5/edcY0jO4D+Q2zCiMMqrwxxXnLD9fA=;
 b=mvAyvsFOy2n0FwXJSnneawdexs0XZv6RZZeag9Qn7pJTitpp2x2xwnAt8idRCMpnxX4A4yavH
 JMQEsNyKQWvCKJz5WgX7etI0kAjslKURC3a/kEpL8bc0FOmYKj2une6
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add ICC IDs for dummy software clients representing CCPLEX clusters.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 include/dt-bindings/memory/tegra186-mc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/memory/tegra186-mc.h b/include/dt-bindings/memory/tegra186-mc.h
index 82a1e27f73576212bc227c74adff28c5f33c6bb1..8abbc26f3123aad2dffaec6be21f99f8de1ccf89 100644
--- a/include/dt-bindings/memory/tegra186-mc.h
+++ b/include/dt-bindings/memory/tegra186-mc.h
@@ -247,4 +247,8 @@
 #define TEGRA186_MEMORY_CLIENT_VICSRD1 0xa2
 #define TEGRA186_MEMORY_CLIENT_NVDECSRD1 0xa3
 
+/* ICC ID's for dummy MC clients used to represent CPU Clusters */
+#define TEGRA_ICC_MC_CPU_CLUSTER0       1003
+#define TEGRA_ICC_MC_CPU_CLUSTER1       1004
+
 #endif

-- 
2.50.1



