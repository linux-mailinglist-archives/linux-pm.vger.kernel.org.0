Return-Path: <linux-pm+bounces-16404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA7E9AED36
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C2B285376
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3A01FAF1A;
	Thu, 24 Oct 2024 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="jpK+LRwA"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6992167DAC;
	Thu, 24 Oct 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789790; cv=none; b=CrGKvW5QDl9olOG8h2Bz71STbJpmB4tfVlfLILvUlPLK5yYbLcQqZyMy35/0WcbwFtiHvKQia95yIBzyV+xu2sTQR038F8QmqyPNXO9f+UJ5+5qPzYKm8m3f7v3kZ6zJRB62KVNbsUUNywkvMNJ4OZ84Fy9Jv+Wo/GgsoFiAt90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789790; c=relaxed/simple;
	bh=LIXJN7WyqZbUIo6zFt/nMh6Am1vcombr30b63lmOUnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHDRWe/UDHTmU8d2y5B9YKkqkuMHo7W6bPe7GwiHXt/kBowBHu2Rq/b0biza49gm/TVfsq9M7G4qokglkJ+3V5lhlRN10lEVgW6rTUTSSAq3o0TnRzz91kGKQyq7PLJa147Yi5kncFkr+eksslpLkjdyP3uDyDBvCSskOgveXD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=jpK+LRwA; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789783;
	bh=LIXJN7WyqZbUIo6zFt/nMh6Am1vcombr30b63lmOUnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jpK+LRwAyINXIUY2QUYqrQYDafODoy+OCx/WIRluz3+tup0nE0CF9Vavkfw+vt6AH
	 dsEFQB1U0j7su8mzUmoj2G9otG40x41feD/OkfJwR1J6y7B9PPdY/zGxFaAKDCIrp2
	 w8DCkw7P8fKCBcx512aZvLtJuPL0gT97cXESWCBOw56LuDaxMpU4dQipwgjP2tKq7o
	 uPQTnoQUdPLdm9nfnMscbLsGl7bScPLf2Rei4En/Iu/VVGTFaZP386i1pTBZzqnTDA
	 cilvq2WgrzIMe3Fa9tS5lEO9a49NHDtahB5aBG/1jKjXqKC5MsHb5rDH98JHBUc2/G
	 kvA0Fc+KlyKOw==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 05/13] dt-bindings: usb: sunxi-musb: Add A100 compatible string
Date: Thu, 24 Oct 2024 14:05:23 -0300
Message-ID: <20241024170540.2721307-6-masterr3c0rd@epochal.quest>
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

The A100 MUSB peripheral has 10 endpoints, and thus is compatible with
the A33 version.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
index f972ce976e86..d4993336a29b 100644
--- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
@@ -24,6 +24,7 @@ properties:
               - allwinner,sun8i-a83t-musb
               - allwinner,sun20i-d1-musb
               - allwinner,sun50i-h6-musb
+              - allwinner,sun50i-a100-musb
           - const: allwinner,sun8i-a33-musb
       - items:
           - const: allwinner,sun50i-h616-musb
-- 
2.47.0


