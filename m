Return-Path: <linux-pm+bounces-31153-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF91B0BA4F
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD353A9AA3
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35C822422A;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogl8rMKc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0021F4C90;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064241; cv=none; b=HNTmhuPmyE8hSxRjQ0+pIYwMrjfRI9zilSDq/F9dn2dkeEQc7Qt4BeMNP1XPBEgtmayLdk86HDbzfJi3eq42ggDPHsZTw/7P5SvbwBEDJlWJwG/t7oAft9pMue1x4uWnc8+CbRndylkiNA3G3Kgbxdx+dVJnT1xF1FegAd/7j20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064241; c=relaxed/simple;
	bh=JyF87RPkDaLpT/P1HT3Qoe8Kdjq7ScIPnxVM9dDy2FI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OP6m1yqfVChbFWi7t9Tvn09aaqvQsbrRSXZp8fueq5Vw7Nw2z1dwOYBStZHNy7DzKlPIychp59aY+CW0PcnTI3x6sLKzcCGqN/CSsyupYL0K3hCBhVm5Nn/7e5mF69P/btjXqtA9/qrgOeUnym77Z2kePu/B5IhJRAXJ27Inp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogl8rMKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 802EBC2BC87;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064240;
	bh=JyF87RPkDaLpT/P1HT3Qoe8Kdjq7ScIPnxVM9dDy2FI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ogl8rMKcFjFfp4WaJ3OojUvBzj92K6pwdAcGfAiBwQ3klLiuK9XLOfHcbw/wPKt3J
	 a+FmlCIOmtcvO0n1PCFhXAItuwmkzzo40QOSWr7M8mw5oNwnSlqz6X5sdiQuFgZFwS
	 44z34NwEZQNhI48E64KR8hc425KYBbsGQE8yUUzhpPkWJgtqUkmfb40/2uL46dByk4
	 PCKxBral+oVzxrIXFzd2HKvOBPrB+oxVvc3Ps4nefXiidCGWRgGD6Xjn7RpO5XdKQe
	 Jye3nyqCUyVAYssUqrYFBTLwtwok+IN3nAm3ipRWRtKIkTKCXqzRWPa22bUrtitPV/
	 G7jPCZm8+eDZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7346EC87FC3;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:15:01 -0500
Subject: [PATCH v2 07/17] dt-bindings: clock: tegra124-dfll: Document
 Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-7-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=1036;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=7rvUsu8rYJf8zTq2a+g5h7mFfug/TkyFU9zjev3k0Uw=;
 b=DrQanWee+Rx+lddFQvDRapAfBnA2NR9vY/ny51dXSZ0bSOOgc1bqODjRYW1wyzQnXGTariAB/
 mAcdH679EjYCMp/HlRUV6jJmnA8G+fRhEY9jSMEENisTspEuzUuDWKR
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add Tegra210B01 support for DFLL clock.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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
2.50.1



