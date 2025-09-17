Return-Path: <linux-pm+bounces-34894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15F4B80CA4
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 17:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4004172250
	for <lists+linux-pm@lfdr.de>; Wed, 17 Sep 2025 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB7314D11;
	Wed, 17 Sep 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BwT+OpCT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5E2FD1B0;
	Wed, 17 Sep 2025 15:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758124470; cv=none; b=bJGDvpmzJ5Auf+p6UIhYRCsQaLTSVsljf0KMCGLpaGLI7tZlmFkooFE7qZVB2ZPSdcTW+V9L06SyOAAOEYJg3/NYQoElTJUfJv3xnDYK5ssfn6CPmYUAp3PUwYHn9PZTdWKVJe1vCtqrvp+EoZRtcVjTpS1q07Q9cFaPvKcqLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758124470; c=relaxed/simple;
	bh=lJ1hQC4FSkaeInMQ9OwyDwx59vbkBqmqCr00VADdE6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XDH7/RQJKt17unVHehyEie1jJUPai8RwbhkncAfrckn4aqNfzpBdv4VeeWIRDbA9Y3ASFeQtOaf7k0CxRG79DIN/1ft7yFysVR3U8I//e36O8eO4eEvMjkG6EZLTJLSJq42+o18bEujcW9b4R0PXjDZEGB1rWjqL7ZNfJB4+84w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BwT+OpCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 193D9C2BC87;
	Wed, 17 Sep 2025 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758124470;
	bh=lJ1hQC4FSkaeInMQ9OwyDwx59vbkBqmqCr00VADdE6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BwT+OpCTEDfV17BOw4Xneqw21fMsscO2RgLmD1w4LW40v0JiZZ8SbUFxGLRlukV/p
	 b0aHxxwGsCyVCBRAspu68Lvjn4Ah5ykKsJLj7FGjhisliqjmtpp1CPTOyd/7WLd4R0
	 2RC2JRcG/N3tP/eYDRckmoGM03VGQ0AraKJPcjA+yH4PkfUbhlDm4FeZg0dMnaFKTK
	 ok81XzS2jfqFUIDFLbF+ra5PLwKRV/+tgYkt4iNlx4dLMvw8Ea5EVXybVRK729GGu/
	 uLkwHRyIY62HaE2Qf52Zm0ysH1bH7JrIHuxKVgH/JDlLh0XafS40OvPQlsvdN71db1
	 lm3qjTAfab8Yw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10592CAC5A5;
	Wed, 17 Sep 2025 15:54:30 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 17 Sep 2025 11:52:39 -0400
Subject: [PATCH v11 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-pf1550-v11-6-e0649822fcc9@savoirfairelinux.com>
References: <20250917-pf1550-v11-0-e0649822fcc9@savoirfairelinux.com>
In-Reply-To: <20250917-pf1550-v11-0-e0649822fcc9@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, 
 Abel Vesa <abelvesa@linux.com>, Robin Gong <b38343@freescale.com>, 
 Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Sean Nyekjaer <sean@geanix.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758124466; l=1227;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=v9TE3OjU72u4FujlV703JbwctqJD/5aDkzjsVneeZaY=;
 b=wo/vDSX+LocQ+hwwZWxnBThF4cG31DtJbry4+NKbGNQav5Z8+dFHZjVhbR7g18P/mXLleV/lv
 z2ppe3KXzJEBnd0mBFi+rDALgzNhQdYI5RmfW65PMXuK6hLSsgZFZLy
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add MAINTAINERS entry for pf1550 PMIC.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Sean Nyekjaer <sean@geanix.com>
Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v9:
 - Pick up Frank's `Reviewed-by` tag
v6:
 - Add imx mailing list
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 60bba48f5479a025f9da3eaf9dbacb67a194df07..ffc834aace4272e663f9717bcffd67100eb546c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17996,6 +17996,17 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP PF1550 PMIC MFD DRIVER
+M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/nxp,pf1550.yaml
+F:	drivers/input/misc/pf1550-onkey.c
+F:	drivers/mfd/pf1550.c
+F:	drivers/power/supply/pf1550-charger.c
+F:	drivers/regulator/pf1550-regulator.c
+F:	include/linux/mfd/pfd1550.h
+
 NXP PF8100/PF8121A/PF8200 PMIC REGULATOR DEVICE DRIVER
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained

-- 
2.50.1



