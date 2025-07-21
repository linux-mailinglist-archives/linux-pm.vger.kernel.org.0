Return-Path: <linux-pm+bounces-31145-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FEB0BA28
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6BF3ADEEA
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDBD212FB7;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="As6DlLNv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72411E5711;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064241; cv=none; b=IQS1PriDiM9f5bFniPO12G5y/timzCcP0ape6L5UMluUwzrhJinA8faXRNo2NwMkHEXEByrOMM1SpKCC2MMwjtcIiaIWmrOLQcLasmv8KkHEc6+snogthQKGnSOj3KER9zvHYCo/0uIXy6eMXXrtQcojeCAg8UXXgLm+JIcEETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064241; c=relaxed/simple;
	bh=VEFsUmrh5CUSmdGcsk7A4iu5lTamrHBBQbePPNsb6fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=upUEMeIJz0gmWJbGHnG640jRNH4oeW44RDee6eNx7uT2r038sl3ELQHUfr8t1VLysyJhytkw8FIly8716D6g6B1OpvIzCO7tZHX2JcL/bzh98nnQa2KZmal2br2jlEWJds+Uz8g42pv1vBDvcNsP+ed9rMXz1HzfjR15c99pYqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=As6DlLNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C5C7C19422;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064240;
	bh=VEFsUmrh5CUSmdGcsk7A4iu5lTamrHBBQbePPNsb6fM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=As6DlLNveMyvOyjdrp0GBARC/IHENLn/Giurn7XIwO7NClyq3v5Y5lRZ0yZOeCpBM
	 Ef2gV2S3tbtoPBsVOGbd82puhh+lctbm4sDQJg58SPKzxLo/9ZCwXogzZmUlkXDePS
	 sA9qJ/Lf7bC6ElK6z8Ui6/6NQifmc73qMIOonEPd9RUjihR/owmsRD+QY3U0t8waef
	 /l7XZQMROhjp3gST33bh1qqUJbLoxqRRDCm1hwERWcBKw8Ag6Y8WyGA+P6YE0L/oji
	 NUV8sFngEVXGkm7X9FNWPYs6l300SCpWgT9MA0Hci83MAewKnNXu34nrcKRioOAJ03
	 8qmavTwcd8TNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530E1C83F17;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:14:59 -0500
Subject: [PATCH v2 05/17] dt-bindings: thermal: tegra: Document Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-5-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=1137;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=k5R1tghQgg5zWHMrFL8NyxLEhTBC0sAbF1cM0lIByUU=;
 b=PN58npPb+8Yb2p863wVe7T8c3F+xHHfiVNyEIiqJO9Galpibr1KdvL9MTQtkYWbv5kHw7LBbF
 6so15kGV/tcBgffSpqCQFcIttSw2jpTIm90rM9NVMQWSYkcCzfbonx3
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add the compatible string for Tegra210B01 SOC_THERM

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
index 19bb1f324183bb22bc75630798da67fc834920b8..cf47a1f3b3847d4a0371d0bc711638fc5e3b6cd3 100644
--- a/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
+++ b/Documentation/devicetree/bindings/thermal/nvidia,tegra124-soctherm.yaml
@@ -21,6 +21,7 @@ properties:
       - nvidia,tegra124-soctherm
       - nvidia,tegra132-soctherm
       - nvidia,tegra210-soctherm
+      - nvidia,tegra210b01-soctherm
 
   reg:
     maxItems: 2
@@ -207,6 +208,7 @@ allOf:
             enum:
               - nvidia,tegra124-soctherm
               - nvidia,tegra210-soctherm
+              - nvidia,tegra210b01-soctherm
     then:
       properties:
         reg:

-- 
2.50.1



