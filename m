Return-Path: <linux-pm+bounces-30324-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15A5AFBDAB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 23:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5723F4A51AA
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jul 2025 21:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA3728C2DC;
	Mon,  7 Jul 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXHfgIrT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3D289E0F;
	Mon,  7 Jul 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924247; cv=none; b=Nmk1fsOH0nBSHsIReFBMfE6SUCHe0CmpqTSk25hkeKP/RwR0qMyGPNe3nc2MCoQAuk2JvXllEP3N00EnCZMURNxJ7PSI3s6QfWkMrj/ac9bRrBEoLobaH6czUJuFB8wCVERx0TgXC2U76sdb2rQ30wLChkyYP5un9T1wDgEtUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924247; c=relaxed/simple;
	bh=UjvYRqjrtZPvhprK+jn7Vt31iFSNrReNe6hMrP9h1X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVje6Hy3w2X78w1iLfkP8WdkrBOO/oW3ShVreOkfTfrO6+W/e68gZkAI4lGU33+rwPSxmm7v7OCoK5mkdnEK2+WVIVcF+DVYWu0oc8HZlcZd7z0uHTST5R4aA0jMb0TldfdmK86Y+AtC1PVYUAuPbLr6Z1I7PiYY28EqRCtMb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXHfgIrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6C07C19421;
	Mon,  7 Jul 2025 21:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751924246;
	bh=UjvYRqjrtZPvhprK+jn7Vt31iFSNrReNe6hMrP9h1X8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eXHfgIrTXzlQogqtB2jTxcH12xdM6bywOuhjflQo6IN/DLQD1MxSoIaynza4ORRcM
	 SmswOjNMwP42XYibToAmVO8vAmdJIKfmlNpsP24F+xt2FM699Qsplms7Tc/0bdB1O1
	 aeb9GxHdeZ1jiPbRq4zoDSb2mPN+KuxOzugNwDi0y6GvVDy4iFCMBNBFdO/5oa6bOA
	 hsFPfdjQQ/UY2imDJ8AxHhFoOvCiot4HgYymdr7PFjZrlJ1FO6iYOaO0GqYBJTNs53
	 a5QOVS2Fdw7Tt1vvhI7szqUm0QAiLiz/twR7jMJavMQWPKugC5POTwDm3nbWv/9PIl
	 6i2Ch+Ybto//Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB7DC83F12;
	Mon,  7 Jul 2025 21:37:26 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Mon, 07 Jul 2025 17:37:25 -0400
Subject: [PATCH v8 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-pf1550-v8-6-6b6eb67c03a0@savoirfairelinux.com>
References: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
In-Reply-To: <20250707-pf1550-v8-0-6b6eb67c03a0@savoirfairelinux.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751924244; l=1098;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=A2g1QBfQcrzU9z5M8QRFE0Nrt7Jq7rU2GZY3TiYW/3Y=;
 b=iB96E+EO5wF7wnhnGl63GsQ2Qrp4+CZpn+wMRX4+BmXD5B7C4ewGXAfVX2kNxNKcqCuHOvXRp
 6TyRbOmwG2NCmY5MLimE/JgpCu4nsyVQD4RrKmKKjA33mIb19WQxnVY
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



