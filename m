Return-Path: <linux-pm+bounces-30833-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E1B04FBB
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5D707A3698
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9963F2D3238;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF3q/URV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C42D238B;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=gTmdLNZ/roG6X64gPAFqDWjsHTbLmnajb5euc9vFmbRysV5twXvsEVllRT0oS4PzcRu430bl3mHS49PQQ9dYAN6vtSKPg/L+gForHt6gZzSf/a93OHhJiLadAUgWyAnuyYjtajdlfgDo1lgLJ/4K+X3z2u+dX5QlfZ2ZTMzxE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=ZsWyVCGPIRm4MCQ8TbGemTLNJWjoor3VZEi+TvixlDo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hftuGJngmdQytGH8JQ6sKuGIF9Otrsnglkwz2OxOpc+qNoD8wIjjX2tAvgL8Nhsyv6CwNOV8sVS6ul4aACiF6UEcfU/dyV5vX/0kgpX9yx8M+xZy5LMkl2mwlX31L4NH9vy6SE4j6YpqhNE93iosG0YaUhcXMNDx2pHctxtFWWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF3q/URV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 240BAC19421;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552231;
	bh=ZsWyVCGPIRm4MCQ8TbGemTLNJWjoor3VZEi+TvixlDo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IF3q/URVwBm+kSEhiIoBVZ3J8nPYDpGh2RXeEjQfLgEHI58E7Iqq1wPF2PhhIrOZd
	 VVlwtCEINyAASpup3bYdyRHDT3Aw/o2mIbpbbhi0nJmSwe9H1jK7jG7vvuUV1hzDH8
	 kRR7LG9gt+0Rw1l3UTj5qIH5+QBLzFQ/q1DZoHLPw75fZhgLb3zdstn+uE6WMb7hVt
	 byne6K0TGLy6ytDB1Qx23g5/LNxfcNzNvHxQMEK/5uzqPTt+sQEqRO1PK4ZdvRztsA
	 kSV1vqUpd6iRgIO+mdN/MTSp/B4BtPDglpH5of++brjcsYwETVKe559smmrRvvbBLO
	 Q6MxX/X0ih0Nw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B90EC83F1D;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:50 -0500
Subject: [PATCH 07/17] dt-bindings: clock: tegra124-dfll: Document
 Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-7-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=989;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=fUgyjpOO75XKaaHCsWtsX8Af/k0zbHG3wyrbsvFHw+c=;
 b=HbtMGcj5C6VwNwqhghI57HKpV3VgiQhaNStx1cWF70IDveVcO2t81scUJfvX5T15T/YYF2Mlb
 yCn7vOLv+9wAxj6RKxYTWah7YhBV0miIjvGUKRN+FKk+L/mIuFOiZMx
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add Tegra210B01 support for DFLL clock.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
index f7d347385b5775ddd702ecbb9821acfc9d4b9ff2..aa7d50d4fe6f2c1c2500c53e3421355ce2b67599 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra124-dfll.txt
@@ -13,6 +13,7 @@ Required properties:
 - compatible : should be one of:
   - "nvidia,tegra124-dfll": for Tegra124
   - "nvidia,tegra210-dfll": for Tegra210
+  - "nvidia,tegra210b01-dfll": for Tegra210B01
 - reg : Defines the following set of registers, in the order listed:
         - registers for the DFLL control logic.
         - registers for the I2C output logic.

-- 
2.50.0



