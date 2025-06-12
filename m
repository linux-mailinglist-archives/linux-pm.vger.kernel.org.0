Return-Path: <linux-pm+bounces-28557-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E7AAD74F1
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 17:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B2867AEFFA
	for <lists+linux-pm@lfdr.de>; Thu, 12 Jun 2025 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182E5273803;
	Thu, 12 Jun 2025 14:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OL01XOdY"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3827147C;
	Thu, 12 Jun 2025 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749740361; cv=none; b=fwnJGmavKcZ1XnW9gt5vFA9uAPAMpYI7KEybLekx4f05SLyUrO2N31HNW7SYN0Fy9Re1YCFaYreWxZ5mH6D4j0akJEujXqBy6YbE+7XQaxs2T39348he1Z4fGSv10v7mrUI2dhJv+HGg/kppAAxJkex6XVqhxcnHOcG0zIm24NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749740361; c=relaxed/simple;
	bh=UjvYRqjrtZPvhprK+jn7Vt31iFSNrReNe6hMrP9h1X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxmJsOCcqzG8TXgTV/Eg3pxu2c2Yg8mjHk9W2KRDvugJjwnjz7Gh7AS8FycHgNxi1swHMgAf99Q7LO7o3hLdK5w4yK+xtIJol0chc4IiC3jYm0FEZnWYji6WmIbRZTvja8C7MgFsVXUYgWUY0INRhTdn2in7YpYyp/rhR7UeziQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OL01XOdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 392B3C113CF;
	Thu, 12 Jun 2025 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749740361;
	bh=UjvYRqjrtZPvhprK+jn7Vt31iFSNrReNe6hMrP9h1X8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OL01XOdYmaNwne1MERUHHvRUipWxrQcSPz8pZuKqodc1zSQxwaJIlUprMjuOh+fRI
	 WKZ1eMEkBZPdBpW1WROH7ro423Eg35+uDyBVM5NCJAVWYDup6BV2BhDYmMr++czErm
	 i4+arUgbEvAzMDAZ9bbJvUZxjDnuMt14aAlsn9nno5HbAiLkTAMoP1Bp9gzypNtBWq
	 ubV4wcOR5LUfR0TTlme7YcOR6QRxfIpUg7ejoWKK9Pm+ht6zgYtRVQT13/LI5nOCFi
	 72NBR3JSUjAJ7cjHbscAKWuaNe/FiEOa6xHCk83MooIo0a0HZYXLz+8mdU/qBXbG3x
	 CfbKOj3jiKLFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC8C71149;
	Thu, 12 Jun 2025 14:59:21 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Thu, 12 Jun 2025 10:55:48 -0400
Subject: [PATCH v7 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-pf1550-v7-6-0e393b0f45d7@savoirfairelinux.com>
References: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
In-Reply-To: <20250612-pf1550-v7-0-0e393b0f45d7@savoirfairelinux.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749740359; l=1098;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=A2g1QBfQcrzU9z5M8QRFE0Nrt7Jq7rU2GZY3TiYW/3Y=;
 b=LkPveKIT4xgllL0334QP/yG1Yp5MPvFVgruoTOfhSZDIhvsOhErRIs4/So7fX17ibaDf4Yfxi
 j/u4ssmzcS3BVyNyAsMdRqG0Bohxw/H3lE0T8o1oBCnYH44MJhOiX37
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



