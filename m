Return-Path: <linux-pm+bounces-30840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC7DB04FF7
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE071AA78B2
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C082D5C62;
	Tue, 15 Jul 2025 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nigDLP18"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7732D46BF;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552232; cv=none; b=o1QldWdjkvUOxXQ4MtSqGlRwivPoR3VHIbSvxX29H0Y31hPHOzCCWe5seuKkE+mTLthuuhtzu98iwTTmK4DdssMmOliJFFrSnb2JXOzuZxK1PCPxRlj0yTvx9kQwRLdg/aiAxzOexWptxqRFTPVlWQ5Cb4VaY3IiVURNqbysQNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552232; c=relaxed/simple;
	bh=69mT4j9gGXbCwC6IkkO5kcgglBEd5iCH6O4+hlHZFSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vn6wyN4IXMUWGVz/r0YsVSmZl58mOHmxzwEbVlDPvHwZ9zoldIcAer2i1pA7de3MMyufEi6S/b9h5HOUWpxG8kFOF9DB9XVy3rGEyF4b/F0UDMOuNEBbVjDXx3wEzMZvk/nYy/WkjjYqEoaNs3fJkO+8RqT8E/8S47179+N1Ipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nigDLP18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABE67C19425;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=69mT4j9gGXbCwC6IkkO5kcgglBEd5iCH6O4+hlHZFSk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nigDLP18VaNEzjJMeF8RvKkLgdk43JpoKP68NQdV+5+Sz/JAALgGnS755n3xsgYr8
	 HxllM9g7d3B2Pm3BakbZLd4h0wpSSYDCgAOse2N7HOQ3vT8GjvTuMnJydC19ZEHyvZ
	 JFR4DOL8f8b4PbtpcwK7xG0l5B+2WXZBnQU0vOB65Hzbs7+jYvBxI/WmBhhzjFelo6
	 04lKCrAHVzSiKoTAkAkM7L6VV2ik8gCOv1AK6S7nepwrzV9S+3EodGdoKqIviLgyZh
	 I1C/3tnh1oERR1Ge6f0lp8Uyu0S8VuP9OCYvx4+TMzYO7UN4JKzpcnODsOicIT+yGN
	 6oCNvtf2eFehQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F875C83F2E;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:58 -0500
Subject: [PATCH 15/17] arm64: tegra: Add BPMP node for Tegra210
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-15-e3f5f7de5dce@gmail.com>
References: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
In-Reply-To: <20250714-t210b01-v1-0-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=1355;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=EGqGpsmvVUcZ9BC/fErJCUcbZka+SWE7U9kl0UCL2e0=;
 b=mdM9cDjp2UVQwDqZNIt4haw/jqF7QKWVAk+1bKi6m2zSE+O3aSw0x9JGVxpwNHm7atlknU0w/
 CazoxeUkeIQAXH/SGE+z9O1gO9SzReVSRTf5oDW6/2gMtHB7hJriSrp
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
2.50.0



