Return-Path: <linux-pm+bounces-31144-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32ACDB0BA33
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047F21891E8A
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9B0213E6D;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmNZ1uWW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F11E833C;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064241; cv=none; b=LZhpXVSli/7Z8wB11T4uOwm057+B5rGy4/GPrV96tYeb+k/s8ttMKjl0GH2a59xnXpfZfJXXc5K/xpgnoYeGOOWzvxTJ1WJCekd526jNFSE8LSXJd178iXMNbY6iCRy8ZU9xG8oJ8E3dhTjqBaG7IovEcEZBs4NrPcxCXA6GTg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064241; c=relaxed/simple;
	bh=tN+GZ4c/gBEI2UISeTGiT7bSlNC0ur8QtsyWbQbdzek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOhLf4tC2IY6r/Jdsq4O0UfPhaghXDDphy8QX0R8EzXc3PV4HsdrD89ODHNSwbDUvaFfGPjo9XgaY6zfDepFl1Y32XPE1T9PBaERW+Zo+5qJYBxwjtiaVRMpxSnWUSJHGV+RnWfqLsE8D3JhCsJg89DB/fp/kfMuF8RgvAXlyvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmNZ1uWW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CE41C4CEFD;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064240;
	bh=tN+GZ4c/gBEI2UISeTGiT7bSlNC0ur8QtsyWbQbdzek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qmNZ1uWWPW17FX+YTi2yCRV1aFiMQ4PuWHOcN+blYK0mZrmfRDM1VoJXKlSME5rOk
	 54KC88rmbmSl8T8VSZyjMLZ0A9XIe41M3+wRfMOwgBkL2DKzn8DpqujqrtAiZhWvdn
	 2DXtcUiZepSfkLfWvi7x1jEWDHj7t3qsVvB25VyiE5+ezIzyVqXAA2VsHM+I/ufmYN
	 TUR8IC7tG+toR53NcgV7HRbxrVoaeSC17gF4AI1xc406JD6xyhXcZwrnYjRTYsRtN4
	 6vI4N8zD7u54MQJYv/CxGcKwHSZwy+Y3o8mXTWrd9xwa7ZVy5SVWs+Yck2lNI6Mj35
	 Tmm/pyzFaAHVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637AAC83F1A;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:15:00 -0500
Subject: [PATCH v2 06/17] dt-bindings: clock: tegra: Document Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-6-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=1600;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Cj+m/fB3eeAdMaIIZwt0Ih/S0OtnqsxT3QW3PAC9JvE=;
 b=O5KPaGIZppqEfJdwPtQFnaBWV/PmQMESQEbEt9SVW75ehrbBGKx4tBjt6LsmYFYVAhrZrzYt1
 F2AWSf1yZb5CKSciKkv3G48Q1pv9oKkZNv8G7/JGs753OKwa5Wpqa/A
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

* Add the compatible string for Tegra210B01 clock and reset
* Add Tegra210B01 specific clock bindings

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml | 1 +
 include/dt-bindings/clock/tegra210-car.h                        | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
index bee2dd4b29bfe391caee346aa5afad49772c2c41..88cce500bbc43de934f6c56152e5b2d006f8a8bb 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
@@ -32,6 +32,7 @@ properties:
       - nvidia,tegra30-car
       - nvidia,tegra114-car
       - nvidia,tegra210-car
+      - nvidia,tegra210b01-car
 
   reg:
     maxItems: 1
diff --git a/include/dt-bindings/clock/tegra210-car.h b/include/dt-bindings/clock/tegra210-car.h
index 9cfcc3baa52c6eef0439c859200cf44446a1cd17..27485d9b80f68fc0e7668a8abbd1b821f62035dd 100644
--- a/include/dt-bindings/clock/tegra210-car.h
+++ b/include/dt-bindings/clock/tegra210-car.h
@@ -409,6 +409,9 @@
 #define TEGRA210_CLK_DMIC3_SYNC_CLK 392
 #define TEGRA210_CLK_DMIC3_SYNC_CLK_MUX 393
 
-#define TEGRA210_CLK_CLK_MAX 394
+#define TEGRA210_CLK_UTMIPLL_60M 531
+#define TEGRA210_CLK_PLL_P_UPHY_OUT 532
+
+#define TEGRA210_CLK_CLK_MAX 533
 
 #endif	/* _DT_BINDINGS_CLOCK_TEGRA210_CAR_H */

-- 
2.50.1



