Return-Path: <linux-pm+bounces-31142-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D00BB0BA03
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E92D188C675
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF321F4165;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+G0filL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70621DF977;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064240; cv=none; b=mI5CvA4wcQk4r0l8nDzPRYaekgu9Kf+Ty1mez43GFj3nUcZPbb7gE0OPAgGYEsy1sYlV2I7LjD8pf3AYrnyXYRUNRdQ5cCCrNvCNHe7VqaVVl1xgiBsB8WOsBT36Ul0YTyu7Y4GDf6ueXYHlPBovrYQFU5f7uKDme3JMTxWVFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064240; c=relaxed/simple;
	bh=vuCgT399Tvy3ihYWlKr0gOTWovLoiM7vzL+kV8wI55s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ghhgLeSFrs0yOP/4gPRaflWyyWvKbzc8O/CT9UOtGtRygAVq21MvG/Z0UyS52JBUPaxzeUQWPbFHWk9CSz2jEeFSGpTixpVW1t4EIlSdXGkKqAsPQtSwwZj5yzT1U3mp0bQnaJwnwT66dxMmTQ8RRGCY431O9ELSvf1kDUwwsx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+G0filL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E280C113CF;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064240;
	bh=vuCgT399Tvy3ihYWlKr0gOTWovLoiM7vzL+kV8wI55s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Q+G0filLrq7vo49/af3PJ+W/20Fshr/TjRDG1C2hFobsCHTz1l60oT8hjHCLq6kAy
	 WEfsD97abFZkJKSRV6kgUNHuuyMmMQuJFwh+BsNWRGZT2OLM/lV0Vboml51HgZHM5E
	 HIEdMXf9kmL6jPfx6Y/xGnpjMvSrOoFR4rpXNPhS83teJ5CTiyNgWKvEJz7nMHATH5
	 VfSsFz/lwkntb5tCxtO37oaf1bhuBE666mZgg+/x2PXZTn/LzFPqL08sEwaqy8y6Jn
	 C8+lgiQtUPWtZx6ETxQn0/3V87cWY8Jw5orbYAejPepg2zR+Q/cci1K2quEtCADXgl
	 a7MClWgAjJSJA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4361EC83F3D;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:14:58 -0500
Subject: [PATCH v2 04/17] dt-bindings: usb: tegra-xudc: Document
 Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-4-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=1193;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=pAfMVat5MDdzgLzxXxUreqZI79lZMEWuOpddgF8NWOo=;
 b=PUFD7+lE9tSm/n+Tjm7HSerh/lB6BDuUENawVBCaj3KpmbUhn0TTedWYZNMAZYLUm5kf/oCvv
 lP8esGhRcVrBL+GbiN5mVw5b6Iwf8fKxA4camgnuHvVbJeOzaNd5d2T
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Extend the Tegra XUSB controller device tree binding with Tegra210B01
support.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
index c6e661e8915ca4d3e905331299d981f4d3964314..4574e66e7c1d3d3c918991920bbf4f3ea0ee6ab2 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml
@@ -20,6 +20,7 @@ properties:
     items:
       - enum:
           - nvidia,tegra210-xudc # For Tegra210
+          - nvidia,tegra210b01-xudc # For Tegra210B01
           - nvidia,tegra186-xudc # For Tegra186
           - nvidia,tegra194-xudc # For Tegra194
           - nvidia,tegra234-xudc # For Tegra234
@@ -130,6 +131,7 @@ allOf:
           contains:
             enum:
               - nvidia,tegra210-xudc
+              - nvidia,tegra210b01-xudc
     then:
       properties:
         reg:

-- 
2.50.1



