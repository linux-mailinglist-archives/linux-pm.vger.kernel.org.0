Return-Path: <linux-pm+bounces-33769-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAAAB42A45
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 21:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1F2544313
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 19:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4C36CC71;
	Wed,  3 Sep 2025 19:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grannp+t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAB369993;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929082; cv=none; b=LinZh8EC++U1bdLVc+XTDk/yPNOvW+4Nxr4WzGX/mTUJK6dKfdwP/2XEioBxFBuQITLWigOoq39+oO0SizHwpwZji/vvFWUDO9D/2mOsUwI9Qv9kQ/e/RMhmlpN73QwwktSeTKAnR31aJ8RzuXVlnI74opEK56/qaAhx//TyUxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929082; c=relaxed/simple;
	bh=gosAl1zQ0z5viYliFA0S6p65O6ADdSW+IUkYdiR08BU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=buQNbYMndUJInLqmkAliWC0n60DX8jL/u68H8LVoaTHtRyO8BUk3L6mQM6zBLcCGyy5KDatax2iMHfRs+N6wZmjwWzaVVvIrwyJMQpMowcRTD+I9oC44ocvW75MHJd/OH9ilNa6ExIr95ooU79y9ugq9ktys/jmXz4z82GFWFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grannp+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4911DC4CEF9;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756929082;
	bh=gosAl1zQ0z5viYliFA0S6p65O6ADdSW+IUkYdiR08BU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=grannp+tQCTQDMgXylmxFoh0XeyE9JFwhC+91GvvcH741TvKLpVQEn5/2dSiDLnyf
	 c07AaDEO8yt4v34ZKlrbDdKlzJ0sAYV3K1fN2toC+Xj7Wq9hgLb7X3doTgRNDhPf3q
	 gGZh4vY+JRcVvWTStYG8WhH0iC8zYu3EkkFEEoYxAisG1K6WM4LYWuA1MwDJJER/QT
	 QOMEFgelhwr9+izlG9v/Aaw78hVt03SUcqOXKJ+dUvDZENuoSdzT1zXL1gsZVXdnk1
	 NJpVAoRIR0nrV/OFQguFRuj86kh25T6jJ0b7XfiIgqVsHv9W0xcf/F+vf8XrhYtFZ6
	 ATpJyV2MKAwAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F33ACA1015;
	Wed,  3 Sep 2025 19:51:22 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 03 Sep 2025 14:50:13 -0500
Subject: [PATCH v2 7/8] arm64: tegra: Add interconnect properties to
 Tegra210 device-tree
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-t210-actmon-v2-7-e0d534d4f8ea@gmail.com>
References: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
In-Reply-To: <20250903-t210-actmon-v2-0-e0d534d4f8ea@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Dmitry Osipenko <digetx@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756929080; l=2042;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=dV5rTm0DsZp/CMwTv4aBWDsgqy68fQx2GO3uvjxraWo=;
 b=8KJrmH7vWHUUfCAjtvitM9AHQNN1+mEHjvJngDdk8ep6XUBYc2UNFXjXWYNnnl3uWchMEJHUv
 kFpJ7toCSUMD3c0Ar9qaNBYe+3j6/6jnSdAy++/90eQtXqLp4zQmRBE
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add interconnect properties to the Memory Controller, External Memory
Controller and the Display Controller nodes in order to describe hardware
interconnection.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 6da10db893add44a98fde1666c382511212fd43c..2fcc7a28690f7100d49e8b93c4fb77de7947b002 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -202,6 +202,19 @@ dc@54200000 {
 
 			nvidia,outputs = <&dsia &dsib &sor0 &sor1>;
 			nvidia,head = <0>;
+
+			interconnects = <&mc TEGRA210_MC_DISPLAY0A &emc>,
+					<&mc TEGRA210_MC_DISPLAY0B &emc>,
+					<&mc TEGRA210_MC_DISPLAY0C &emc>,
+					<&mc TEGRA210_MC_DISPLAYHC &emc>,
+					<&mc TEGRA210_MC_DISPLAYD &emc>,
+					<&mc TEGRA210_MC_DISPLAYT &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor",
+					     "wind",
+					     "wint";
 		};
 
 		dc@54240000 {
@@ -217,6 +230,15 @@ dc@54240000 {
 
 			nvidia,outputs = <&dsia &dsib &sor0 &sor1>;
 			nvidia,head = <1>;
+
+			interconnects = <&mc TEGRA210_MC_DISPLAY0AB &emc>,
+					<&mc TEGRA210_MC_DISPLAY0BB &emc>,
+					<&mc TEGRA210_MC_DISPLAY0CB &emc>,
+					<&mc TEGRA210_MC_DISPLAYHCB &emc>;
+			interconnect-names = "wina",
+					     "winb",
+					     "winc",
+					     "cursor";
 		};
 
 		dsia: dsi@54300000 {
@@ -990,6 +1012,7 @@ mc: memory-controller@70019000 {
 
 		#iommu-cells = <1>;
 		#reset-cells = <1>;
+		#interconnect-cells = <1>;
 	};
 
 	emc: external-memory-controller@7001b000 {
@@ -1001,6 +1024,7 @@ emc: external-memory-controller@7001b000 {
 		clock-names = "emc";
 		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
 		nvidia,memory-controller = <&mc>;
+		#interconnect-cells = <0>;
 		#cooling-cells = <2>;
 	};
 

-- 
2.50.1



