Return-Path: <linux-pm+bounces-32750-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17F0B2E6DD
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 22:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57765E017B
	for <lists+linux-pm@lfdr.de>; Wed, 20 Aug 2025 20:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BA32EBBAF;
	Wed, 20 Aug 2025 20:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUHVK2kR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083F22D9EF9;
	Wed, 20 Aug 2025 20:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755722683; cv=none; b=dVqz+zyXBSQ7cPXfJAMMaJm/+0Ycu1K7UOugmg7FMjmam4OYVOGCkW3ZRVlhdkiuZTAPjNQJwoU5I1NjW9SuFSOcIxbE8v7EOxiNjX97yvjrQ8dgvrVANiYzyjVaAyJb1R2c8sKq1pK3M60oXMbugrkcheIoImNmMdiMpNiRKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755722683; c=relaxed/simple;
	bh=lJ1hQC4FSkaeInMQ9OwyDwx59vbkBqmqCr00VADdE6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uU1fUPnyz3F9PV6PxAIIc+4jqCxSiY1r2fVB6DgLf6y54NouFfPZqP36eTz+uXyfPCAHU2DMmnlr6MDWmSDB/GZka/dxc6jtEIVU0SXgyPPzNkNz/Chje8X7CYGnhcBGBOVS+WS/RyVfx0a0EywHnak/41sVVomOLRNIyMz+Zho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUHVK2kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77ADCC2BCB9;
	Wed, 20 Aug 2025 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755722682;
	bh=lJ1hQC4FSkaeInMQ9OwyDwx59vbkBqmqCr00VADdE6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GUHVK2kRerD7AoMhOVzVlR5USeBWPCwW9uGSvjHfykPFcRNQUPTtYo55JuwQfzYfL
	 AI1uBwdsFF8Q8T5z7jw0AOVRSymyxZ4tufZklELk/RJo4noIrDqpvhoxW+Fv8hO7cD
	 4Mwbp8qYC6EmZ1jbs7EXNpKj/juKdPM0vlyysXLAdmE/hsncCdGEt4Ocb374ENxuHD
	 +WuOypi2agLZ5jkrBzyhqdFiADzYM3jxvJah1tuqW5cLWn6wV5hO7rqCi6Xlo7S4In
	 96/EB433ct9WeD83YgpTg+SyryHKJomegwgqIBOwtd/syS7lQViXrjh0IBYkhojVw3
	 H4d/HxF7pn9kA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6A7CA0EDC;
	Wed, 20 Aug 2025 20:44:42 +0000 (UTC)
From: Samuel Kayode via B4 Relay <devnull+samuel.kayode.savoirfairelinux.com@kernel.org>
Date: Wed, 20 Aug 2025 16:44:41 -0400
Subject: [PATCH v10 6/6] MAINTAINERS: add an entry for pf1550 mfd driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-pf1550-v10-6-4c0b6e4445e3@savoirfairelinux.com>
References: <20250820-pf1550-v10-0-4c0b6e4445e3@savoirfairelinux.com>
In-Reply-To: <20250820-pf1550-v10-0-4c0b6e4445e3@savoirfairelinux.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755722681; l=1227;
 i=samuel.kayode@savoirfairelinux.com; s=20250527;
 h=from:subject:message-id;
 bh=v9TE3OjU72u4FujlV703JbwctqJD/5aDkzjsVneeZaY=;
 b=GIIcM0qzZAYLTKVVfzT9A1wTYWJMV/KRPEU8O1UjSCRJ6Ueb42urLTG8WwfRnkOOMic4SWpvH
 nM0WwybvfmpCJT0r9oK5DUlzAIuBS4G7+Y+wratkteE4DjU7hpwVxba
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



