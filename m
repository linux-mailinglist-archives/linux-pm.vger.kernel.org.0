Return-Path: <linux-pm+bounces-28053-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E972ACCD01
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 20:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1D73A605D
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 18:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A0C28983B;
	Tue,  3 Jun 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbLSZnZg"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB89D289355;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975278; cv=none; b=uCFE1Q6fzE5TnDioyAJUuvJIPJCo3DZBrboI/0FE9AiREY0n8QNnJFvrcKq6d0MQS2rt+0L/5NfNTcOcUUA3YhdVomhHoUKa3jHwvZo9Sn9wSFNOZF+tdzlQI1o4byVzDWvYEsCCZFZKOBvPyCxLd0vnihVP3HpYdr2D0yQLg0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975278; c=relaxed/simple;
	bh=d5VvSlRmjGMzNDVpmfFxLSG08CZOidzcCPaxvVrcA00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKkb+uijQrhprhYSZ6ECdrKf0lZKExOhjfurmg1w7ZQ1Fbt0PC/SKSKfy5GNDiUmkrAmhPV6Mso1uZ5YGCIoiy+RYh5PvOZaWdwwdyvQSyyHBkngQu6oRHe+rltnMku3uvVCRQM/Yv8T3OHjj/hjhFmeTIKkifplh0ySVzwZwzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbLSZnZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65B7FC113CF;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748975278;
	bh=d5VvSlRmjGMzNDVpmfFxLSG08CZOidzcCPaxvVrcA00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XbLSZnZg0eWhUaZG64rnCA2vt9kJd674d/jEd7Aju01rr0sZWW2l/pscWbYrdvPSS
	 0ZnBi/6D/+o2QViiINAltm7XpyQf7aXPHdPtMvBgmAzYNObJ7CtLDVMg6FSfLc97ij
	 pLKNw+hAv+SXIrWwHy9IRciOCmTV/lMRKs94pDF5IN1CbvyB3qAsQSaxPvLmXlOLiR
	 yL8LblF4NtcLKN3waOtdFYAm1e6oa83pq1EMUJJ/0gqguE3ZRdOnSgdFWvWD5ltfxb
	 U019cwN9rA+f+87qE75ap5t34uc6FUaUnOuItktlafy1P1xiwnOFSJs7xiF8ef8Gqg
	 vxdVIvduSxCZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0EEC5AE59;
	Tue,  3 Jun 2025 18:27:58 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 03 Jun 2025 14:27:50 -0400
Subject: [PATCH v4 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-pf1550-v4-6-bfdf51ee59cc@savoirfairelinux.com>
References: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
In-Reply-To: <20250603-pf1550-v4-0-bfdf51ee59cc@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
 Robin Gong <b38343@freescale.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748975277; l=1037;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=1qhTIEsmPLxNuuFFSqYxrKKKek2sC5avXrd07642loc=;
 b=dE14mIjMAt45kIJM+A4+U3GTep01fbosFbCHeqVO2/5/keu5gbHrexSVEHYAe2ffeECUEQxKp
 PvTVoNvJY5hD8mhnibT+WTTK4/uTe+/N4pxTngWXSwY+k6KAQ80elNO
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



