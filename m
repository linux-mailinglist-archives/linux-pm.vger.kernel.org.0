Return-Path: <linux-pm+bounces-31143-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB12B0BA05
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 04:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A491D1780D4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6CD1F4C92;
	Mon, 21 Jul 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH3v0xeD"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B887B1DFD96;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753064240; cv=none; b=ZStC78JuqHeF/e+FnNY2v6hyLfeNJviScAQiMffQqbO39IpKiba10pwgXNluTd5yBtxrf+J9vjKBubdDhzb+BWjE12XSl58nS6Bg6TmT+nIg0Nzt7nUdp7rSpJ3zbxpHhb7ipLq1CvWiCDLQRv/t8QdH4Cf4CaVtp3CXdLPgWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753064240; c=relaxed/simple;
	bh=+N08sZPiGNzkS31ZMq73XQsRz/6PC2CS+i/IRLP1KHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQKnT/Rt4hX6/N29pdvAncGn1Z18kjdNvt5zq0CLjb585xncoc8RXZUy9g3AF2h/dQvQCuejTDamHHYYOrbjTpFAJHV/e4bvBrVVO0CptLUf9ocfqvT4zmwQewVGiBxT5Tyi2nZ2HCBecuFl5yYq97pZBKmeuTXrD8oTmjCeJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH3v0xeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E76AC4CEF1;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753064240;
	bh=+N08sZPiGNzkS31ZMq73XQsRz/6PC2CS+i/IRLP1KHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XH3v0xeDRLUNwZvVLXSfSChV9/5puplFLP56SWDE8N5NLfT5/N/LwCLWq/iYq6RA6
	 Twrq2+/RCq4IyvFUvGTq+2QDWNoYChaNQ9KjBpxhCmFCl1yRJLqGqPsG1ImF2yXzBg
	 mFPzqxQV7iqMnP9uwdj2CnxUnqMsLsqCHewkrpsLgFt1DTmNmaH8ollUge3M98XfJt
	 fPO33n8aja0zRgKXEwDNB8IApTbOvOSyqWCwHWbkcdf5DGj+9kSPUReTR3QIOi68uc
	 VzK9XnSOGTYCtrL/3eEzHaQWpYNM8lTYEXCu5cYstFcvsKjlGuQkljqr/FCN/LnIPI
	 yK/33ohkY1Kbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3385CC87FC3;
	Mon, 21 Jul 2025 02:17:20 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sun, 20 Jul 2025 21:14:57 -0500
Subject: [PATCH v2 03/17] dt-bindings: usb: tegra-xusb: Document
 Tegra210B01
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-t210b01-v2-3-9cb209f1edfc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753064238; l=944;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Nh6f3WIWhHTEV0li2SkjJP6VUkET3tGtA5Y1/bQ0xS4=;
 b=MKvWtyQKbqNPY3woOWQs4qzFh2uYhbwzLsig4HH0zT8z9D2bKFHp/4x34k1Eh7LjoIRTzAg7A
 Ru15aqCaWqjAkI7i/a/6aXmAV9EQVrtJke/6159qIKCBUyYDrQv4e+S
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Add the compatible string for Tegra210B01 XUSB

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml b/Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml
index c0e313c70bbaba4f5da9cb090ab6f3027d274a2d..543355118282f52b276a087185709320dd8e09d6 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra210-xusb.yaml
@@ -15,7 +15,9 @@ description: The Tegra xHCI controller supports both USB2 and USB3 interfaces
 
 properties:
   compatible:
-    const: nvidia,tegra210-xusb
+    enum:
+      - nvidia,tegra210-xusb
+      - nvidia,tegra210b01-xusb
 
   reg:
     items:

-- 
2.50.1



