Return-Path: <linux-pm+bounces-31156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84D0B0BA42
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233653B1863
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACF823536B;
	Mon, 21 Jul 2025 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDF8p2SV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA17211A27;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064241; cv=none; b=hak2NOpCLsyBarCiz8QXmjdqAn5cYvNf2J10l3aaEaVVbz3rIeG07ANOBxtkmsIQCl5cQMJVJw/wQpqpUVJPoK3dTKJlOtf18MPOLvjSgMbBjcXL6jfGTSRihzetpGcnAkOjGGNkKnc4IFhaj9Ppzq9llm4QRRlhpCz+qnzq3eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064241; c=relaxed/simple;
	bh=HKncAPxSIMFbw/2kZa81BXmIQwYXT5pSJU8eZyb16Cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+MrGtqa5dtMXXqXCbT/GR5B/qg7/4csop+fi7N7efPcOkSDPIFt8YOAdtkqPGM06qEYeIGdy78UjzYdbcIPBijOeoi14HJhC9mj697pmGU6kI+dVbeAy7s+bs92pvrfSpYvIyOCqIOSFbk1Ke4MLxFCImHre8tmTk2CwGf+bUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDF8p2SV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C4DFC4CEEB;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064241;
	bh=HKncAPxSIMFbw/2kZa81BXmIQwYXT5pSJU8eZyb16Cw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sDF8p2SVWKxAW8J8sVNoycp3TMCvNEy5tH33ogmoNDZGN4d0EPFFba4hOSIc5pKYA
	 PvRMaAac86/chcGIv6ZLiPvUZojhVXBetuzUjjWJbrnegEVtVm0QU9z340HRuqepo5
	 W9Rso2yyrnDBaM/oyuqmJWrkoflU+nTgSt63zvjVmgqB5VhqYGOy6Hp/QCC/66LJgn
	 uMrywjTTh6IwMgg06aKRsuwSyUXCWozEuJuaTz2CrDMMyvyTR1QLdg8x0Mxm05aI5J
	 ZrfBFjrOAMvEyEwTcPU6P3LzYHQP8B8c7M+qM0nyf1/DwRwbBqnwTOxmPrrXkvq0v2
	 VoyTRw9K4A/4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443EC83F17;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:15:09 -0500
Subject: [PATCH v2 15/17] arm64: tegra: Add BPMP node for Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-15-9cb209f1edfc@gmail.com>
References: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
In-Reply-To: <20250720-t210b01-v2-0-9cb209f1edfc@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nagarjuna Kristam <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Mathias Nyman <mathias.nyman@intel.com>, 
 Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-usb@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=1355;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Hy6C9irOt/10mikaBceHy3GtlZHG/JQi0cSRGeXarHY=;
 b=EfHg7uCuTKPxSk0yEqtg1tdc8FokfNrH8aTGAsexCfz0kAHF4YypdOpv+MuIC8f81hsYMrDlp
 IZ/nwyRzRXeDveBxKSISA5ao0hXZ9iMk5PH60qtWJwALZHzNE1O/kwh
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The Tegra210 soc supports bpmp offload for power management among other
things. This was considered insecure partway through the soc's lifecycle
and support was removed in the bootloader. However, Tegra210B01 returned
to using the bpmp. Plus old bootloaders on the original Tegra210 still
work with the existing driver. So add the node to the common Tegra210
soc dtsi, but disabled by default.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 402b0ede1472af625d9d9e811f5af306d436cc98..3361de1ab41b37e430d399df2bf77d64226f33e8 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -968,6 +968,17 @@ cec@70015000 {
 		status = "disabled";
 	};
 
+	bpmp: bpmp@70016000 {
+		compatible = "nvidia,tegra210-bpmp";
+		reg = <0x0 0x70016000 0x0 0x2000
+		       0x0 0x60001000 0x0 0x1000>;
+		status = "disabled";
+
+		interrupts = <GIC_SPI 6 IRQ_TYPE_EDGE_RISING>,
+			     <GIC_SPI 4 IRQ_TYPE_EDGE_RISING>;
+		interrupt-names = "tx", "rx";
+	};
+
 	mc: memory-controller@70019000 {
 		compatible = "nvidia,tegra210-mc";
 		reg = <0x0 0x70019000 0x0 0x1000>;

-- 
2.50.1



