Return-Path: <linux-pm+bounces-35644-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D62BB1241
	for <lists+linux-pm@lfdr.de>; Wed, 01 Oct 2025 17:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A2189E250
	for <lists+linux-pm@lfdr.de>; Wed,  1 Oct 2025 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B428505D;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikGAzP3l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE6C283FDD;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759333362; cv=none; b=qW4rVGmXOajfSp7rvF305P0LZ3kQzPzt3tMleNdcabURz77aPtlM6kftlyZSqQMXYOsEYC/WQeXeF4DGHqGMIcOFrQq+VUyjW3gFJPHi9mKmV6807NVEu3uTCcCHD71ySn8kTjPg3yEow6CuKeI8BV5n88iD80yVlYBX9US1F3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759333362; c=relaxed/simple;
	bh=aLMjkI0N9pKIbUT9f12rSPBR9IjP2dlhRR4XDWQ8FHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NCz4jgeOKq9sOt2LEDMBRIIgMKySxCi+a98AeCarsiYqzWsZfgLu54PXYDP5p1uOHfJQUIOeqqz6xicFUVB12FnrLbbGj6xLUTMcQs/ciGbKRGXx+DZokKNwMDphywjmWDNImvn8POpxHp+QIvjexKfY5tg1fxbsA/TtuJSklBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikGAzP3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86349C2BC87;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759333362;
	bh=aLMjkI0N9pKIbUT9f12rSPBR9IjP2dlhRR4XDWQ8FHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ikGAzP3lLY/kWgzOTHmFXvaei2ZAA6DjqrGY8DNR/jVj6NC0f+ABiEHEDmJLH9qIG
	 cIOipNxxNQ5WOmV5wvSICj7a/+6eHnjLi+cxetoHtmHGLAyZKYsAfcGErl+mIVWTh+
	 FNurO18Y6S+79UCxOqorBjeS7OzrvE5Nx4CQyXUmrtyzsxJX9mW6ovG2rFfSFYJu+X
	 qqFwF+KY9EAEFbOAZ7nE7c+LcmpbkpFlLpbIgQA5/E5Bp+cZDqOJSOXgDjdfbSTVIF
	 /bg9esHont9y+fyUoKfDSkzNJfB/Mt+7Igk2DRqwPS0jEgD7UeYmEP8ffZnbjgbSmh
	 7VmBvm95pObbw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72261CCA470;
	Wed,  1 Oct 2025 15:42:42 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 01 Oct 2025 11:42:42 -0400
Subject: [PATCH v12 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-pf1550-v12-6-a3302aa41687@savoirfairelinux.com>
References: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
In-Reply-To: <20251001-pf1550-v12-0-a3302aa41687@savoirfairelinux.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759333360; l=1229;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=GUpwedwZ6iTM/9T8xwTWsw5t21VrPDOJAhQDVkmdBtI=;
 b=2WpW9lNVxnpyGsfvRtsbtDpNK6l2vH8C+8r+KLHpzefyxsWELgNa2VO1R6dhsXCuawvudv3dg
 wpUIgtg1lJKBm+N7Z+21QXTnU0Y4Ff2vUKhqfFEczjiZU9ln+KhAtiV
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
index 97d958c945e4ffa3031590823f7a2867f577ebf3..5cc042b7ffe31a79bbbcbfd1fec7831b3546054d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18293,6 +18293,17 @@ F:	Documentation/devicetree/bindings/clock/*imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/*imx*
 
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



