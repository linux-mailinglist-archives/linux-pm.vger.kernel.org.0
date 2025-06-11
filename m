Return-Path: <linux-pm+bounces-28505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D484AD5FB5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 22:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94273AA54E
	for <lists+linux-pm@lfdr.de>; Wed, 11 Jun 2025 20:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF812BEC25;
	Wed, 11 Jun 2025 20:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBRpMs9q"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4C2BDC2D;
	Wed, 11 Jun 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749672180; cv=none; b=rbDrASWH1peq00w/IsV7XirbBWHU5mr8wvS+y8nhBjv5uIotyczKlZ4jZprPgi8vGRidC28NfVne7a+vY2eg6y7JexjTOgJ0t26SV2iYarakepPcOvCHm19YMDUsNCW+aJRXc45HIm5+rG0BF1rRRjiw8ocmV97qSrs/Y9DjTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749672180; c=relaxed/simple;
	bh=UjvYRqjrtZPvhprK+jn7Vt31iFSNrReNe6hMrP9h1X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCXYYn5ZYRtMcKoPkWIdi8TKEfEhTU8fBb7TMfastbUHL91iBDjjq1qDl3rScbbfQkyZpqejGIQTLM4RJ+YSAgDcNbJrtsaC1rZ2nElhprfBcDeRx1m08TT+vbB9P0PV00h581ofGTzfBZoeap03vX2WiCrPd7WaNz5tkmfi+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBRpMs9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C124C4CEEA;
	Wed, 11 Jun 2025 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749672180;
	bh=UjvYRqjrtZPvhprK+jn7Vt31iFSNrReNe6hMrP9h1X8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jBRpMs9qdDjEVPw9k7LZ2ZYOOAITlQiks6wNVpq7KpYPJbzJiZ6h/xknbEZUVXeA6
	 XEmUg1MbMalFzeglS1pj+t4vXk/+QXNrn9uAE/QqgYIXNr/j20FEJBDE9PsW0DE5y+
	 w8OJ5LZ0/xsZs9NQ3M+nxpWA7gq80c4tMDeMbYBpuvR4fS0Ej5kDfTM1kBqAkokFr0
	 xukW4M04hRvWNaTkZLcz10dr6aSkVmhStAiXCwxks04PQiGBy8ZMC3i4fxtOIReNsB
	 aw+Zr0WHi2RAYlGLSMuDQSAbGJB+jdV68TGb44VF2goJrL//+Dhup0eu9O+2AmvID7
	 /NIP8bluPJv6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52868C71136;
	Wed, 11 Jun 2025 20:03:00 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 11 Jun 2025 16:03:03 -0400
Subject: [PATCH v6 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-pf1550-v6-6-34f2ddfe045e@savoirfairelinux.com>
References: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
In-Reply-To: <20250611-pf1550-v6-0-34f2ddfe045e@savoirfairelinux.com>
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
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749672179; l=1098;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=A2g1QBfQcrzU9z5M8QRFE0Nrt7Jq7rU2GZY3TiYW/3Y=;
 b=JLty8CjMJicQq1reFnjgmqLmWRGsUdUZlD70w5L2JJ3/RqbojqxbuEUJOX0m75y2zOKN/pV4s
 lyEuI8o+X63CZJH7qjkQDz0W/lu85XMSm4bI6Ix/uK/ycokLGQ2CEBF
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add MAINTAINERS entry for pf1550 PMIC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
v6:
 - Add imx mailing list
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98201e1f4ab5908ff49d32d19275e123cedb4b66..5547fdafa7e1bb11903d5d5bef246c2e1a20fbca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17853,6 +17853,17 @@ F:	Documentation/devicetree/bindings/clock/imx*
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
2.49.0



