Return-Path: <linux-pm+bounces-31140-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F34B0B9FB
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79A9188A251
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5CA1F0995;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIhRwKDt"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AFF1991D4;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064240; cv=none; b=mdinHa0LPaaq8AcKSASgLyJ3FNUPCztdhhhDPU+6kuzu6RbtoxNEUcSUJKCaG+lHbu0M9wELj7BirQwQchdYsAT+fQ0HZsyNYZyvdGnNsMfVSZvj/JbHi6qlzWJ+s47CzVPG8bxv31AaLQ8vGy+JDugCFWZU8GCOR1M55MMvbPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064240; c=relaxed/simple;
	bh=tH3H8zgMbP7z7HPFQ34anWHnf3Cn7AZwpiLAi9WmJp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NsLzuymZQuiBk0ZnqI6zUGMikzpSXA63KylFA2GNHpi80G4aiqbZKmsqKXkI3Tt9yiEKLiFp3GuWN08mL721fSMhonFrogEMv+NyaGyFqu9XJKi+0DHL1HVq7ZzZq+TT8Mk93iMLK1Scn1LbtYBeGhwPFuNdRjYCXR85KCfMIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIhRwKDt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 305A2C4CEF6;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064240;
	bh=tH3H8zgMbP7z7HPFQ34anWHnf3Cn7AZwpiLAi9WmJp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nIhRwKDtRrA8tPFAomq3bmNMoaNjwUXQHqwDQuXOz1SADOOYCk56SZlSgVvaPPFCJ
	 FrgQbLMHen7l/5AAv4i12LsJqqQAoir7u5x+JZIhPy5sfmgFdPv9jCIXRLWbs7lsx1
	 ER5xTVJxV4BjKRcdkU1cUZKQrK6ynvW7hDEqUc3bpQu4eHGK5aVvoRCPoocBWeQy5g
	 G/5mc4cQ/a1zQaAAOSpcnT1z/PfhIJkLGdHoXRbsEfrIjG8MW4/0kqb9ZBPV7aOqGK
	 Wc602dsS1UBpPkGAvcA9wREmy3Qs/5OttxISjVLrsmwaDZ32n8f5EEI6MH72dSEryE
	 DegnaTqdeQ4aw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2085FC83F22;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:14:56 -0500
Subject: [PATCH v2 02/17] dt-bindings: phy: tegra-xusb: Document
 Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-2-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=949;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=UpNpYF6b2E0atbGFOefjF2Dt7IyUMvWdkARxBy1JuV0=;
 b=leQBs4fOTFx56689NhbY10lbcJjLOjEPkrvzVuaZtWB05gxb8cmVgMHlKkdmfhz4pe2EBkDX9
 8i/Ikyy5xBAB7+boqoeiPvK3fz9nJ6ClD1BTGo90eneB/4qr6y9HF6B
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add the compatible string for the Tegra210B01 XUSB PHY

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 .../devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml          | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml b/Documentation/devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml
index e9237c58ce45df7fa25cac861891b3fe76efe83d..e876be8058d6a37cf006351f478d29e6b981c672 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra210-xusb-padctl.yaml
@@ -42,7 +42,9 @@ description: |
 
 properties:
   compatible:
-    const: nvidia,tegra210-xusb-padctl
+    enum:
+      - nvidia,tegra210-xusb-padctl
+      - nvidia,tegra210b01-xusb-padctl
 
   reg:
     maxItems: 1

-- 
2.50.1



