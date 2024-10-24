Return-Path: <linux-pm+bounces-16406-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737619AED3F
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 19:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E791F21F29
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF2C1FC7EA;
	Thu, 24 Oct 2024 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="DL3jdBNp"
X-Original-To: linux-pm@vger.kernel.org
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87711FAF07;
	Thu, 24 Oct 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789792; cv=none; b=izAi8nrmPTG7am2TlPIFM/eVgtFHb5ege1tynuUASAx9Sxke3zd0/4JeHAWE9s3BDrBBPkOQMQwThuGu3Q6C7uAXb5Ld7dxr3H2cTmkUewnx9G09I4+yAOASGhMU/TwOaarn+pfA1zkZEnum+JS0imA7mbCCDzc2Q3tZlRXKUSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789792; c=relaxed/simple;
	bh=0RkskRslYaUuKRSgVlTdkKv+Mh9NFTsXkwpsxrbjVIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIJy6MgHYI/JEX+X8mKEEIUCtgCKzJ6hR1XHEjw/vCH7Pq5d/LAXKOtXbMic1oNGA10qxDgWqgNDsyNfAIz2QEr+lf+jFg17E6NLt0vQzgGba69mEmsnBAET988vVql/7bzrxJxYlRCFQ/pN5SGlIqnqFZ4ykCzVUP2Tm9usmUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=DL3jdBNp; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1729789788;
	bh=0RkskRslYaUuKRSgVlTdkKv+Mh9NFTsXkwpsxrbjVIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DL3jdBNpJNo5KntIZ0v25l3caK6zQjh0AQF//EWEnTja844TVoiVVkP53yIEkSYid
	 DKTa16726L5IJMSUtxcb8b+x3AVift1IIubQRxKvoftZxNIZZszSGiWwaeYSM3ZXgC
	 IRF/+WiDp5wGzmj/yjAhTQb1gMpPaSYQwSAnHFSzr9wONGl5h8f5FxcYTT0uCLsSMQ
	 XpP0ttP2olSRaNo2Q5MKtnK7RosfYu3uw4Z6MF6I2JFjpPZ+nvuTjWEBW8Fvwc2r/x
	 W2WBq8Qk4hcSIR2KwhyBzh+hCQWXhw23u5LiEd2Uq4IZkTMPyfO0pm3nW+tDx/+0S8
	 rmJpdHNQ+NppA==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-usb@vger.kernel.org,
	Yangtao Li <tiny.windzz@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 11/13] dt-bindings: opp: h6: Add A100 operating points
Date: Thu, 24 Oct 2024 14:05:29 -0300
Message-ID: <20241024170540.2721307-12-masterr3c0rd@epochal.quest>
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

The A100, similar to the H6 and H616, use an NVMEM value to determine
speed binnings. The method used is similar to that of the H6. However,
the information is stored at a slightly different bit offset.

Add a new compatible for the A100.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
 .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
index ec5e424bb3c8..603c6c88d080 100644
--- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
+++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
@@ -23,6 +23,7 @@ properties:
   compatible:
     enum:
       - allwinner,sun50i-h6-operating-points
+      - allwinner,sun50i-a100-operating-points
       - allwinner,sun50i-h616-operating-points
 
   nvmem-cells:
-- 
2.47.0


