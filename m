Return-Path: <linux-pm+bounces-35248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786EB96EC1
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 19:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6011484B3A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99B27B4E5;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vy+yOvYv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FB277CAB;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758647135; cv=none; b=A3CaUkuo/8hh9L+8IDc6a5cFyHLQVI32PlxFbcaAR4qzZXrWoCA6dtYbzx5m3qJtOljXbIGyDXQpypBCYE06DL81r+I50N+Slobtaw5syiw2+BMwMZnjnIGIS6NUny0J3/yCYqXaeFVUYA6YspB+kdPj/9F+E870fHucWy6UbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758647135; c=relaxed/simple;
	bh=318UfLgLWeVCCVkculraQF4zJFJU9xGx6cX42rAYGXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajBvNuPs/ekY+vEKrYhHL+vja5+3vMGSGEohnl6pqFjRB/9TpEtLov6ho5dtW91r1m92noRpY72lsIY6n07gbh1emuogUZabsOle55vd0yOxGHdXbHHpHTos3AWRYk0utsI1fHeIzQD9U84db1PBShGPU1eTN3P7WFZd3xEGIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vy+yOvYv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E06FC4CEF7;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758647135;
	bh=318UfLgLWeVCCVkculraQF4zJFJU9xGx6cX42rAYGXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Vy+yOvYvtup0TXvym8GDoA8I8E7BjQYfAfikyYuIlkcwQHuNfvFfvh5hsDPyTL6I4
	 k0W5CA1NIR1TpPDcKPBjRGDxLk2uCpdFp1kfOz3MGy7FH5nZK1Fyw3e5a27y5bilBr
	 sq88acXHVj8uT6A7YzXPAVAI2xfe+NxFpoOH36Wiyq4kxcS0TQwjompbpsgDncTt0A
	 JlyyZPwzSJ6yOKcdMvZ8eni8tlBQjJokWPedt6LgAuioGbHlda2fbEOpqtBjnasTuj
	 MVoCNDfhdIE/Pzb0QFVMRqv73mQElG30bGyStpnkUDZ//XqUHXSnM+Qz/XOMbEF78R
	 8u9L81gKm/Piw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144F6CAC5AE;
	Tue, 23 Sep 2025 17:05:35 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 23 Sep 2025 12:05:34 -0500
Subject: [PATCH v4 8/9] arm64: tegra: Add interconnect properties to
 Tegra210 device-tree
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-t210-actmon-v4-8-442d1eb6377c@gmail.com>
References: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
In-Reply-To: <20250923-t210-actmon-v4-0-442d1eb6377c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758647133; l=2042;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=ow4cANazhCY0RP1MyRkdGrzne1APbjCWzT7QbzRnuww=;
 b=86n5FPQ+85RbxoyUYbG2BxOF/wMvagEcV+aXJn+geL7a4BVqxY8PyVVnRD4/rU1aUYjA/Iemw
 tXVpy+Xzd09BCmyMfm+XG1ODVfnlBV63qBkNJpy5l3CJYRHFGTCcktW
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
2.51.0



