Return-Path: <linux-pm+bounces-30832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9BDB04FB5
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 06:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417E31AA47B0
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jul 2025 04:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644212D23B8;
	Tue, 15 Jul 2025 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n26PIvb4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5102D12F7;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752552231; cv=none; b=fIUyzXbEBrsj0qnUWxccxIXpl+NecLAhBDfWOOK6hiZUOMx5bSgFJPrqZwOMcKIX0YceJi+W3hRNKodEa0wKT5jRrqEUVRyySSuL123wIGczBEIiLNUdptQ5ar3dMfs3jJzZTrARdaAtFm1zenIoqmRtdhnTY4MuNmy0ZSrNC48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752552231; c=relaxed/simple;
	bh=cUIiIvJhVKR9wTYPbfXfeTIQg5AtRje9ukOyLgihg9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=alJ/FQDDUFPk3laAPASH+2sjUT/3cKK8whj8lrXWRWxhdpv2z2O7lxu1cRTPhJRH3dDPM7urH/AHsueWndV9tRyBW+70OCtOq6C/UIDv4V27sr7AlOpM3BZqfgcLBcHPlNlaxEGBfNGX+rGGXnJTaCAfX4U+2j4P1VAh3WCoqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n26PIvb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2D91C4CEF1;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752552230;
	bh=cUIiIvJhVKR9wTYPbfXfeTIQg5AtRje9ukOyLgihg9U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=n26PIvb4/qRccrk4VK8D8f7yyTJgoJ9AlhdK95oMWesMV2CxenfyWZ6CvYZnAtUni
	 AHRnXQ09iS5lIm8+V7qKlXPDPmrZNY9ncih0GRa+uvoshq2BQfK8h89VkeT+gbPdqD
	 57psZreqnAldK5Bb7DrHwfqtYRypC8DJPmHd8d/O4ftpqqy6yn0CzXvR13PGXuin3e
	 kSzqQaODwqBw1Lr483g88U63qngcMuLsjk1+FJVG5IufKQgFcQcXqIlq77u8a7vlrx
	 vs0IaSo161ckCtR4x+xRMrbKd9KJNSRvmpCdmM0MnOYgccVqG4+9xijgVWc8YnLTCR
	 F3iMiMB0nq1mA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A049BC83F21;
	Tue, 15 Jul 2025 04:03:50 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 14 Jul 2025 23:02:45 -0500
Subject: [PATCH 02/17] dt-bindings: phy: tegra-xusb: Document Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-t210b01-v1-2-e3f5f7de5dce@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752552229; l=902;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=S+xEmmaI7KPQCg4icSZetTrJ6HEmpTYmTyrR9BWm6U4=;
 b=oFAYJgiq5zAewIvcvuf2FVbJYPXeLMkouUk1sQppnwgw8GP0DTIrtP2bwtLmOSpRKHsvaNZaE
 YHG8qgf5IE+C6GHWWbEeQ8srk1JoAam+kCy8+ezrtbNQqD7GXnW960V
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add the compatible string for the Tegra210B01 XUSB PHY

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
2.50.0



