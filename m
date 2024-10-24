Return-Path: <linux-pm+bounces-16413-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3CD69AEDAB
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60DFDB24494
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2EA1FBF5F;
	Thu, 24 Oct 2024 17:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="iQxJhzXu"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AA1FAC51;
	Thu, 24 Oct 2024 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790356; cv=none; b=GoUzPimaJdQba2tF/QcZKGYHUtjAwxTieQZ7IRtnnB60/9noMsALi5BL0lnevmrhb38eBgeF9lWFDWiVf5j3c9VxDxyAdtsyjL4q37PWICx+9uOpXAxEzBeVQl34M/7uJiBfPQWNQqDYYk3WUO2OVZj+n3jC6RehYZLiYh1jSJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790356; c=relaxed/simple;
	bh=RX+bua+zQmv95muSSfcwHCoRRExA1+Jmd6fbL7zvW6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8Hz08Qxr76SuQuCop5wctxkiic8NVGCCERu38BGaXtHf8Ke4Y+0MGWZt9fwkhbP1aPAKe8NrqmGyXcsWjlydfRV7T8Qdkm0btG5vGJBCgMwcgZalBW/ds1D4QwRK8NsbKCuJxb0+qflhBxrokHzkSPKRnURogK67yBXVJmOdf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=iQxJhzXu; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789782;
	bh=RX+bua+zQmv95muSSfcwHCoRRExA1+Jmd6fbL7zvW6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iQxJhzXurv5NTaqqSXTBmDxmvJU4Vp9eGzjP1KUdQMgA1xxT5UGg9Cu7oefMCrZQs
	 rVeFo0vRZm4G9AOmDRzn5AUliV7IdhiTKiAPiZ9hftmGxMQYh/DQpJAjR2ccS+3F59
	 hKzjtxoc3C5PvikWx/7/msKmgee7/jU67G+M7b2vhyIKauebjab0xfj1H5L2ZdWyZc
	 LMpjLnghC7scjYGdwNJA5T5YY6rkaNMtaqmBS6trj1i21sURoBjA81DnOMwNevUnBr
	 ZpxcxPHA7hQTRDpGFs5gNVm7oB+IymjDva84lJoLfjRzBZPsWdFDAd9sxWy4gyn3+z
	 pQnIJZiaiB9wg==
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
	Conor Dooley <conor+dt@kernel.org>
Cc: Cody Eksal <masterr3c0rd@epochal.quest>,
	Andre Przywara <andre.przywara@arm.com>,
	Parthiban <parthiban@linumiz.com>,
	Yangtao Li <frank@allwinnertech.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Maxime Ripard <mripard@kernel.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 04/13] dt-bindings: usb: Add A100 compatible string
Date: Thu, 24 Oct 2024 14:05:22 -0300
Message-ID: <20241024170540.2721307-5-masterr3c0rd@epochal.quest>
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

The Allwinner A100 contains two fully OHCI/EHCI compatible USB host
controllers. Add their compatible strings to the list of
generic OHCI/EHCI controllers.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic-ehci.yaml b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
index 2ed178f16a78..e00e98dd04af 100644
--- a/Documentation/devicetree/bindings/usb/generic-ehci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ehci.yaml
@@ -30,6 +30,7 @@ properties:
               - allwinner,sun4i-a10-ehci
               - allwinner,sun50i-a64-ehci
               - allwinner,sun50i-h6-ehci
+              - allwinner,sun50i-a100-ehci
               - allwinner,sun50i-h616-ehci
               - allwinner,sun5i-a13-ehci
               - allwinner,sun6i-a31-ehci
diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
index b9576015736b..6ce81979781b 100644
--- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
+++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
@@ -17,6 +17,7 @@ properties:
               - allwinner,sun4i-a10-ohci
               - allwinner,sun50i-a64-ohci
               - allwinner,sun50i-h6-ohci
+              - allwinner,sun50i-a100-ohci
               - allwinner,sun50i-h616-ohci
               - allwinner,sun5i-a13-ohci
               - allwinner,sun6i-a31-ohci
-- 
2.47.0


