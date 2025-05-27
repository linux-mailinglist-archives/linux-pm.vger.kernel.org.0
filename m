Return-Path: <linux-pm+bounces-27706-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 099F4AC5D14
	for <lists+linux-pm@lfdr.de>; Wed, 28 May 2025 00:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBF61BA048E
	for <lists+linux-pm@lfdr.de>; Tue, 27 May 2025 22:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804521A458;
	Tue, 27 May 2025 22:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLMSalmk"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E2E219307;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748384785; cv=none; b=VKU8PSmIn7dJoZrNMahRtAok+8/C+/gnS9R3YPU0mKjiRMx94IggknZZqnNFI+c/Jed0xjOYgM3C8hJ3mIRWB7EvZ9SBK68diN8LG3GjNIR2nJejEjd2jFG1Tu5mJgj22jamCBZq7VbK7bgpbAs5WUI9omvaomv34LnoVyBtaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748384785; c=relaxed/simple;
	bh=zRmRsJT6zhzDSuXbgOvOnJhhy3nPlwowYHwtO5D0rxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fm8CxduPV4XU9BDRfE+Wt4ruNmARXAKrqHDOpmSH5qYkU1udaGSVzwIkoYrHXBUbJEuxZojzukrEy97nchpG/tdhqsCDgj5ekc8W1SuqMrerbgoJRImt6hjxh6Ai591eqSljZ/VN/qv972qPqrui5Znc+Vu3G1Upc6hvfkhGP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLMSalmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CA8AC4CEF9;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748384785;
	bh=zRmRsJT6zhzDSuXbgOvOnJhhy3nPlwowYHwtO5D0rxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hLMSalmkULYK2vdY3477xLMhfHSkQHSZ+Gor8HRAXuUZHyK/LVeZ1bcun6O/6uJRw
	 UddWzglc3/rSWSGujxmUs+ttJs4D/lHYBy6LIcMo1EU9fNMXBM96+dtWVXJjR95MIw
	 rEhGoOM5ECr+8awiD+sU9q2p+IqdyU27I6T9Q+O5rBKRqjV+g+t1IQYqcJzhAUPCQd
	 7erBcdrzvAFaOWmEiT+Q1xobk7uFfOc2wiI+EaIxm9MoO9dRKl4FRtLqFcyorAqPbU
	 RyBkx6sUasrVeoe5nAJ2U8GIrVewUUHla0r56f/j49auBRmyenOF0CJoPuxuUF9U7q
	 1tTVijC01Fcvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12927C5B543;
	Tue, 27 May 2025 22:26:25 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Tue, 27 May 2025 18:25:38 -0400
Subject: [PATCH v3 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-pf1550-v3-6-45f69453cd51@savoirfairelinux.com>
References: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
In-Reply-To: <20250527-pf1550-v3-0-45f69453cd51@savoirfairelinux.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
 Samuel Kayode <samuel.kayode@savoirfairelinux.com>, eballetbo@gmail.com, 
 abelvesa@linux.com, b38343@freescale.com, yibin.gong@nxp.com, 
 Abel Vesa <abelvesa@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748384783; l=966;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=P6wBCq9GpDy9ARq/1XDkixCcTLLaGUgI/CZwwZXFs4U=;
 b=CMM65Np1ztt3CDZ3fr0531DlK7o56shRW0QR18RIdCbHunxQHohl+CRzQyfw4eqtad36pcNA4
 phTgtEvDAJqAacrrbw5sE8JntLuWRivHi1X8f9j+5lqHuUJf59VCn1x
X-Developer-Key: i=samuel.kayode@savoirfairelinux.com; a=ed25519;
 pk=TPSQGQ5kywnnPyGs0EQqLajLFbdDu17ahXz8/gxMfio=
X-Endpoint-Received: by B4 Relay for
 samuel.kayode@savoirfairelinux.com/20250527 with auth_id=412
X-Original-From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
Reply-To: samuel.kayode@savoirfairelinux.com

From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>

Add MAINTAINERS entry for pf1550 PMIC.

Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 830ef5f9d86487a599236a2392e422f0e424a313..2be65383c3c7b1c1487577d23bff483aa437c4c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17688,6 +17688,16 @@ F:	Documentation/devicetree/bindings/clock/imx*
 F:	drivers/clk/imx/
 F:	include/dt-bindings/clock/imx*
 
+NXP PF1550 PMIC MFD DRIVER
+M:	Samuel Kayode <samuel.kayode@savoirfairelinux.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/pf1550.yaml
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



