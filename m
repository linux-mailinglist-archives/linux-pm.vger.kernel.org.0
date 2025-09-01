Return-Path: <linux-pm+bounces-33510-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A83CB3D758
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 05:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBBF18890EA
	for <lists+linux-pm@lfdr.de>; Mon,  1 Sep 2025 03:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F34021930A;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQVC+VnE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB271D432D;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756697664; cv=none; b=flHxNtMG8uq/z1QtM1B4kLEjpliBnY3lgsAmK3jM6Gk+O+nVqBaERkbJiH5Du7VbxlVPsysk9ZrbEeuK+kan5ufTW+cuJH7Kn505LEysF5gwM68dsR9+3CL+lPTr3aKx0kys70t22ssJf2Requ6tokKyJMXEeSrLvc+VNA5/u/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756697664; c=relaxed/simple;
	bh=Ze9D0/HuTzUb0aMQasiWEKnNNc0FMjQN2+TxiuxDzFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fK4T5bmjEkPMrcwcx8cQgjkkwCGTMj504isMqTOUgJY7hpHcDXxVhBCZdI4jKDmCnVr/IWzVErhMkVZ+drahDIU7LeBzI/9KZBEYT63eqQKyX79ouJvo5q2S24Mha3UyZLPGjOkU20Zmt1LXsbjIPSPqhJXgpy7hRGvpgxvw7VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQVC+VnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E5A6C4CEF7;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756697664;
	bh=Ze9D0/HuTzUb0aMQasiWEKnNNc0FMjQN2+TxiuxDzFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pQVC+VnEbnLGTrrQwT8UxR7DVh9sHaWc4GrPlTvw1vi1wXOvegLj/RyUPrE74DreR
	 vq6IJJiZm7U9djE87ZjPKUCD1Sgo8GUiPSypGnfKadWdsas4Mm1vdbyMTPbLLIIW3m
	 xeVeSY9DCC7nmWopgMwUZVZw4c/1GMLx2jAoWbS/i+MNudJNEDIbEYZQ9yaQDFLKRE
	 xue2nXyyXHNCkjjoPVGK3gJA9UJMIYvWC+oVlcQ9JYYdmzZNUfgemR43jYBGcZXTkN
	 Tvi25B+TI0YC/vHdJUFUt5okn7e+C6bJG0LhPMJvSUcbKIDEM/aDniJyzeB/RI9J0P
	 v5DHkLygb/R7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9D5CA0FFD;
	Mon,  1 Sep 2025 03:34:24 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 31 Aug 2025 22:33:49 -0500
Subject: [PATCH 1/8] dt-bindings: tegra: Add ICC IDs for dummy memory
 clients for Tegra186
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250831-tegra186-icc-v1-1-607ddc53b507@gmail.com>
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
In-Reply-To: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756697663; l=816;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=68sWGSUz7jYX5/edcY0jO4D+Q2zCiMMqrwxxXnLD9fA=;
 b=wP7+4iyKDGsDRFbZSmrt5J8akn4Ol66dV2LyX6lOR6za+KQEXYuq225AesWmVSOnfNCT7G4/v
 cgzlDXY3jB9DhkusGEln32ClWkN7k+zC0jLzLQ6tgvR0l1VyRGtd/SC
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



