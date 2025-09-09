Return-Path: <linux-pm+bounces-34197-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C9B4A1FA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 08:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32EAE3ACFAC
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 06:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9E1302746;
	Tue,  9 Sep 2025 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfzlJW6U"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D312F2D8DA6;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398894; cv=none; b=Ei/1dNjJ1bUlwkpADex7z1W3NtduZAbzsqPbEqn4l3nhPVv56Vz3ja9DzW2mRejvSoI5Gca1AZSUWP9NY/Nijtzq8dEtLD6QtQU2Noqz106z4jaUSGy06co0P94MfAkFSWZiOuzLWgZIn1Az4Eo6/oKjjQ0k2h33bbf36qhJnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398894; c=relaxed/simple;
	bh=lTzEzt7B30YSrqMuZRySEr37koys5vP4NQ0cnXVdvZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VV+7F86gGq+RZ1+S52FoyfcyQ5dDdKF+/w0VhAEOpe0zxkKKiNk+/9hmza6+I8r9Lcd8rPFIZQdifnUpDi4lvexG1Js5HQGOtWflD+POjWke7T5d7W0nmW/nONv8ocdMNZm63fPq9F4XZ6AqP3V8X8kEBYmp/Qz8+zKa0Gb0quY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfzlJW6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BC26C4CEFD;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757398894;
	bh=lTzEzt7B30YSrqMuZRySEr37koys5vP4NQ0cnXVdvZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lfzlJW6UsAknGSO0If68NLKDr6YjhxTyzBBm5eG9Y19bVAhjr70wGnngseQ+7wvGE
	 dqd0c63VEiGI7LBvLpLh8MzOpzl5jg9POvaidFrth45+CMVvhx0wlf7tlKHa7H1vTU
	 UvZ+BU5fnPhb5jcj2M2LbelxtCxkMdnHd387SNCPF5t5nPXt82foU1LFkO7Adla561
	 zssH2ALKXZKzouf15M2/MqMQrSsTikhUuXlCSx/INXbdWmb6cwMk6ZLbsRmNjx5W0N
	 ddjAaq7gUi65Iy1i/NYgvboVkyvgagJVacm9CQhweY0iE6r40cHePEg2KoPqA1zaij
	 XcP7rsN8EUxCg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AB7CAC58B;
	Tue,  9 Sep 2025 06:21:34 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 09 Sep 2025 01:21:31 -0500
Subject: [PATCH v2 3/8] dt-bindings: memory: tegra194-mc: Add dummy client
 IDs for Tegra194
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-tegra186-icc-v2-3-09413724e781@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757398893; l=911;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=i1j7eBKUtkZ5vfUZNnts2xOfdyQGodjxO0KvmD0RhP4=;
 b=+mOk0b/i06ueK/P6P14ptBkfr5yTbG8HMcdyQKGcpH+I2u0LS+rwBeRpXVxqddJpsO5nb5YqH
 8bHBwpkPzIVDgf2dJP5K2aZy+M9muPafg1rXDEdMM8YNQjCcigGo+eK
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
 include/dt-bindings/memory/tegra194-mc.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/memory/tegra194-mc.h b/include/dt-bindings/memory/tegra194-mc.h
index eed48b746bc94072a6bd0af7f344dbb6f6618859..a7d97a1a470cd3cfb18c7ef45c421426ea3c7abf 100644
--- a/include/dt-bindings/memory/tegra194-mc.h
+++ b/include/dt-bindings/memory/tegra194-mc.h
@@ -407,4 +407,10 @@
 /* MSS internal memqual MIU6 write clients */
 #define TEGRA194_MEMORY_CLIENT_MIU6W 0xff
 
+/* ICC ID's for dummy MC clients used to represent CPU Clusters */
+#define TEGRA_ICC_MC_CPU_CLUSTER0       1003
+#define TEGRA_ICC_MC_CPU_CLUSTER1       1004
+#define TEGRA_ICC_MC_CPU_CLUSTER2       1005
+#define TEGRA_ICC_MC_CPU_CLUSTER3       1006
+
 #endif

-- 
2.50.1



