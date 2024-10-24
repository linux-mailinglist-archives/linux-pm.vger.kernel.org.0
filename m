Return-Path: <linux-pm+bounces-16417-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 630989AEDB5
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 281FF285E46
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C580C1FF03E;
	Thu, 24 Oct 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="fu0uHdmh"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3581FAF05;
	Thu, 24 Oct 2024 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790356; cv=none; b=R8U6YdJFAwrpv4lSW+nrK8mDZnz8G2jGNqn7MtbXBXWrugMyMWTrKRh7esCVixdvu/AaRvrlY4V0jUWMQLLAOTHSL5ApHG+ZJf49gC1Wm4QJnarR4nRtENLSeJzJKD4L6ZHfnFWrzFe+qnmGupJc/ujCZpaUZK8N3EGet3Tgqww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790356; c=relaxed/simple;
	bh=JkRVwM9k+j3E/nlOdSLDJcFQJqTbTeyz4GS5TOzoBYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGWBd39KGY/SS1cjJsB3xh73pypvVYpMuStXb8CIc/oGNq9SMqFOT7LPNU7VNqM3tn6FgwaRK9VT0EW0aosyWB27ga1lsmmCU73i9b7Y2gJZ1Bkee9dfL0vl7cYPdsyYs5sbdk1YvulQe0G9YDgW7FJm5Wz/vFu5/QCe0KNBkFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=fu0uHdmh; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789782;
	bh=JkRVwM9k+j3E/nlOdSLDJcFQJqTbTeyz4GS5TOzoBYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fu0uHdmhg589NknjBuOq9MenRyuPkuLBEwT8UHfJfGkBBQxJ0hjtome9pFYIJ+ttH
	 yKeWh1Jg8E+iEXu7C5XCIQSpBNGf8kSqDa33v+kuK3L3PRnHPpAF9zvKb0V9uIU+/a
	 GynAIKZ3nVc4shet1UoW5blBjtZxNaMS8uLnjCxh9EFoEPMlJ9l1z+y1id20ZKcXkr
	 V+fE7ofcC6P22gbdH5KAYDiwtn2q0uNfEmE7kU2UJA1aZQgsUdHtX5KZQ/EOTltLxQ
	 0tNG3dPJI4PTOWsD/PXI1M1bLyvPGfNnPu1v77ZKBa+KHbvIaHbti9KNY/O6CJtxpl
	 DRh1VwlvO88Mw==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-usb@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	Andre Przywara <andre.przywara@arm.com>,
	Parthiban <parthiban@linumiz.com>,
	Yangtao Li <frank@allwinnertech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 03/13] dt-bindings: phy: sun50i-a64: add a100 compatible
Date: Thu, 24 Oct 2024 14:05:21 -0300
Message-ID: <20241024170540.2721307-4-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
References: <20241024170540.2721307-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The USB PHY found in the A100 is similar to that found in the A64,
although it requires some quirks to be enabled. Add a compatible for the
A100's variant.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
index f557feca9763..b91e6c83722c 100644
--- a/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/allwinner,sun50i-a64-usb-phy.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - allwinner,sun20i-d1-usb-phy
       - allwinner,sun50i-a64-usb-phy
+      - allwinner,sun50i-a100-usb-phy
 
   reg:
     items:
-- 
2.47.0


