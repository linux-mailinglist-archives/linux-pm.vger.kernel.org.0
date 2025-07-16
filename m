Return-Path: <linux-pm+bounces-30920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F72B0793A
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 17:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F02175DA5
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jul 2025 15:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6FC2F1FED;
	Wed, 16 Jul 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlObW82O"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0322857E2;
	Wed, 16 Jul 2025 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678714; cv=none; b=CCYtvvBUxF7qAut6by/yNUmKfQN9A71djPih2rt9rj71qaEW70gcYEMkjH/1QnrvQMlRzantZ9LnmotX8aOtK/CI+UXno8d7P9UWaZud1Xo174Uyjo966VaQd8bCb28fz3W4bSiy7k5enuSBBkrYIWwht4ZBLIBToxopQ4abE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678714; c=relaxed/simple;
	bh=ctJcP0kRv0/Wi+KIXcw8d+CrgsU+9uirMAPEcZ6GPes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FyBCfqETCA1m3y7YUvkwOlJBeuFagxlwKIirNODw5ojXGK12RKFK+F2EuxSgLFlalKqT+XqAnsOYj6N47HO2+V0PmU4lfXQ6MHQ66XCYQo30pINELhovFyIxKDWwAAkWbxd5yeACYhIncG5qzxccOxbP5NyasdwktQL0Kv4C2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlObW82O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC5D3C116C6;
	Wed, 16 Jul 2025 15:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678714;
	bh=ctJcP0kRv0/Wi+KIXcw8d+CrgsU+9uirMAPEcZ6GPes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UlObW82OyFZb3pB0WDBhyZRF1Z4bJatdFJTQfOMVqH6VcC3+Rl7CiIfXzR5kbn/zI
	 COtMNeEXeE0Xh6GauXJfun74sgJW+ctw1dJ5c/v9UWwGUDYgWQjY9PsGB1NEoJiipZ
	 UAHPioea0vqaB+EYcp2+w6rxkgwmMJG5c4e4+KrJNOg9t1F/myYL2HFXTpcO/ucl2C
	 gJkAmEHW/NnSgK5KhhsMVnqTvyPrNqEsGLY+7aan6pPBwZuBa9t7GYeKfmZQ0Ks0t0
	 MV8ozivUZRGmLYq2PnCEto0irgEduvVuQlh8NjzDcV0yAxxp73X84zqvV4RNKtVq30
	 vfkOqTCiGEbKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE966C83F22;
	Wed, 16 Jul 2025 15:11:53 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 16 Jul 2025 11:11:49 -0400
Subject: [PATCH v9 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250716-pf1550-v9-6-502a647f04ef@savoirfairelinux.com>
References: <20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com>
In-Reply-To: <20250716-pf1550-v9-0-502a647f04ef@savoirfairelinux.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752678712; l=1183;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=jUiZqiH8LjNPiivusSZZae82B2tSvI6ZwXvbA3h8PLg=;
 b=PD4V5wlEIeMxxnR4FROfcym7nstywV3gyZagAsobo0CxlqfUNQSqL5cTA6/ubaCHRLvEXUIGe
 lZdyzR/Rtc2BpDEJQpC4mGGcMhTKWI3XUJim4p/3xl5FI7uM9BXSMdu
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
2.50.1



