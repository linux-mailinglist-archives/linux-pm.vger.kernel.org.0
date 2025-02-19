Return-Path: <linux-pm+bounces-22397-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC3EA3B9B5
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E21F1892C9F
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2025 09:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBA41E0E05;
	Wed, 19 Feb 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7oZp1GP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0971CAA6C;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957225; cv=none; b=tKQs0jSHB7z96EdF4gKp35yYJ+3koO07kQXZ7WQApXS6aFTjkdn6AwtJp7PnhD49ShGdBPm/ZX1+yQzU9v3peHkB5GS/DXwfwZA0eqctXV3l/l5vsKA5Pn5kNMXcT1XyMghaIxH4PbLUNdolvNuIx7jyBL+31iRpVq18VodoHfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957225; c=relaxed/simple;
	bh=/8BENyPma1E57fsseTa1ytYOdy6D1/EypBQxBbUeYB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hUS5jCGhu+RnzSUKwxDaEw655WPUVQTIbW68CazKNZWNxIAqKOZ/YUh2dcsOqxTqCEs4e6FnkiY8POTaWaK8bJD8B6gU1ISDY0uHI1GUQVfcK0BMZ/QzKEQ+7n2r8te+8D5fc3o97Sn5duXUf7ES+e/zrg3+esK7BWxnLorF0Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7oZp1GP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 923A9C4CED1;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739957225;
	bh=/8BENyPma1E57fsseTa1ytYOdy6D1/EypBQxBbUeYB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=m7oZp1GPHV4yDMeriWYC05zFcs6bEymz+i3F8bjTa232EVq3UgDWTBepdWBMyGSsS
	 hJLkXPgT7j/3x4jdFZ5wCGsNKbT/6R6h9mbj9BaLX/9TZWguk8oKpgZ3F+I7irUDcU
	 mkmst4mCs4ieJlidpXPsrcI1LVZtHzjTBS8uft3bDkb7EORbmUDwGjf3bsawGQ6E2d
	 w7oB6iu/qM3XjxMVXYlwYIUuf6rSis39tZgHxwoYnUyinrixg0qeHmd2C0wP0OB66q
	 YGE1vlD7r7DitV0yHB6JiAYDwi6Qk931CxnzMuhH5+ctnh1CBD3skzzQ1BwEa4HDhg
	 aOtzWIP2JOrzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CBDC021B1;
	Wed, 19 Feb 2025 09:27:05 +0000 (UTC)
From: Sasha Finkelstein via B4 Relay <devnull+fnkl.kernel.gmail.com@kernel.org>
Date: Wed, 19 Feb 2025 10:26:57 +0100
Subject: [PATCH 1/5] dt-bindings: power: apple,pmgr-pwrstate: Add
 force-{disable,reset} properties
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250219-isp-v1-1-6d3e89b67c31@gmail.com>
References: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
In-Reply-To: <20250219-isp-v1-0-6d3e89b67c31@gmail.com>
To: Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-media@vger.kernel.org, imx@lists.linux.dev, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739957223; l=1111;
 i=fnkl.kernel@gmail.com; s=20241124; h=from:subject:message-id;
 bh=q1+AY+SX/HidyXOKL452yUY1CfrAy107+rMUbBBYmrY=;
 b=tIUgSAQ20H8Sh73LCctDDWcqZ8+098KXHQs/GdR+9F+SgFTynX3VPt5fV3fDgjtWC9w3AB7LA
 21v8x5BdfKECnc6GVZLlsALOJuRzMvKveogRObUVqDQNDLNsBpm9mC+
X-Developer-Key: i=fnkl.kernel@gmail.com; a=ed25519;
 pk=aSkp1PdZ+eF4jpMO6oLvz/YfT5XkBUneWwyhQrOgmsU=
X-Endpoint-Received: by B4 Relay for fnkl.kernel@gmail.com/20241124 with
 auth_id=283
X-Original-From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Reply-To: fnkl.kernel@gmail.com

From: Sasha Finkelstein <fnkl.kernel@gmail.com>

Add properties to set disable/reset bits when powering down
certain domains

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 .../devicetree/bindings/power/apple,pmgr-pwrstate.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
index 59a6af735a2167b7edd9e0491da238f21effe316..9c8f5385bee5aa1bac8c3e44963713299160521e 100644
--- a/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
+++ b/Documentation/devicetree/bindings/power/apple,pmgr-pwrstate.yaml
@@ -62,6 +62,16 @@ properties:
       Forces this power domain to always be powered up.
     type: boolean
 
+  apple,force-disable:
+    description:
+      Use the disable bit when turning the power off
+    type: boolean
+
+  apple,force-reset:
+    description:
+      Use the reset bit when turning the power off
+    type: boolean
+
   apple,min-state:
     description:
       Specifies the minimum power state for auto-PM.

-- 
2.48.1



