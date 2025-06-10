Return-Path: <linux-pm+bounces-28414-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A99B1AD4337
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA4217C7F0
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEBE26656F;
	Tue, 10 Jun 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxLxI5Rn"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79102265CAF;
	Tue, 10 Jun 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749584887; cv=none; b=SAguzOJDVTLwnXYLajA7Xk9pdhCLTZrA8eq3eM4exfjoe+mVojQeDoAgj8G+qP1QqdaJ7prf8O/pZYpiYEjvuvVv+gKdsjeAaNWhILvKFerYJXqNjPFRN6B9P8Kzm8QnrMoVKNdi6ddcp3wF/zgyRfNXjD4dkJeYj1q9mRIlB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749584887; c=relaxed/simple;
	bh=d5VvSlRmjGMzNDVpmfFxLSG08CZOidzcCPaxvVrcA00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CuNHq5NjfZ2H9ZU17KpPXG4XkI1VAPvXIsuhP2L0uvBHdhoJHKjqLohUImsWpyqaohKaNDgdK7VNLe4w5VoORWe2ZGDu3jFh+VipeDYlwZA+JKPENvd5U251rFyQbz/tMG5M0L9ffPipMSyQYus250zmMROLMp10vzUlGiY90Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxLxI5Rn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0A56C4CEF8;
	Tue, 10 Jun 2025 19:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749584886;
	bh=d5VvSlRmjGMzNDVpmfFxLSG08CZOidzcCPaxvVrcA00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KxLxI5RnlY5GmFl8MT4zL+Fdvnm7io/+od4zRYmYKqRR2JoB50XY6Pfe1MqDPsnCT
	 QqsTraNeblpp9umRiPlNCDzpzPg+Z/K/Ly0WGJJ7luW3VJuPgHY8Ni5OF2hWPOa2PO
	 N5RkkLtn9y053bRa4abkgzobCBlBdw6wUymPb/Q7jcPysJvJVpMVC81O6b16di01gJ
	 o/linNQs5PXsZzEcl0BXo6yBIVqfS6Ro6N99pEe2PiC0EVAFNrquREUimubMUFy5N/
	 qZYnFWlcZaLqciN/pVkyKxN6LWbPVrLdmkrxCb7eGniJhqQlTDw9C28hzWO1OCkp9x
	 qdmawQO4taNlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4999C677C4;
	Tue, 10 Jun 2025 19:48:06 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 10 Jun 2025 15:47:34 -0400
Subject: [PATCH v5 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-pf1550-v5-6-ed0d9e3aaac7@savoirfairelinux.com>
References: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
In-Reply-To: <20250610-pf1550-v5-0-ed0d9e3aaac7@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
 Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Abel Vesa <abelvesa@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749584885; l=1037;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=1qhTIEsmPLxNuuFFSqYxrKKKek2sC5avXrd07642loc=;
 b=Fx/CMj3bOIeSkwdj6q4aKIZjFw7ZmMdCnD2yZ9n4JOLquOmEEbFcX0ZrsF/9tRDc7LEH46aUq
 sFSc3bKbdGpCUvlZdiBKUR5GHYNlYqE1qYOXBUQtTbwKznBiulo0xuO
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
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98201e1f4ab5908ff49d32d19275e123cedb4b66..29287ab3c9d00240ecb0ac9793aa908ec75a9bd0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17853,6 +17853,16 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP PF1550 PMIC MFD DRIVER
+M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
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



