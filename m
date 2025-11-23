Return-Path: <linux-pm+bounces-38409-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37510C7DE13
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 09:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8ADAF34FE60
	for <lists+linux-pm@lfdr.de>; Sun, 23 Nov 2025 08:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295132C21D9;
	Sun, 23 Nov 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADdLpRe8"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F8285071;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763886985; cv=none; b=TGVjdxsRDFK1XaTBPxJsDq/grnGDIQ6wn+cfHXWgt1MDmO/W+h8HfZQzU7ggF5M4Nv65b4GaOJ7FHR3gJlNQaOMh4MV2N2A+UStrWbwU5NpIdUv+TkyfVoROfOSnjiOKm7MqlyBIYmX8PN3HKm/YDBE3eiePG5/oKXqfBqKkF0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763886985; c=relaxed/simple;
	bh=4VcxCMgYhmMmtFoirHuT2VY7mXYknw3cZfIwfQ93BDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A40sPX1QsLbUo5PXJEIB3fp5MPZApg6IS5wBzq+VwJTCCZLeVJELuQd94JwCdeKKTSsoTH7kj8toXyyjpcIfjguQMoj0AoshechqNliBPkcXlcXyXNzK19/pEUxS58RzkJ/O6OmHAxKoRmnZol27q87Yb0i+/wlDu3N2Bt+NWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADdLpRe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C621C116B1;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763886984;
	bh=4VcxCMgYhmMmtFoirHuT2VY7mXYknw3cZfIwfQ93BDg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ADdLpRe8tjByzXw83VIaT5hoSXH7vb1EdbIkOztecE5k7keW7iypTqd+doDcoT/F/
	 y23qn+6Vz26wH0BEVOl1n/wjVL/elMdNjB7U5UwS3/os/5ATZAVwPfAd7roHlDfVlM
	 NyZ7upDErTe9OAx6dgO8EWL1xK/LsQwCjLjgTy9w2ZVsBJdxl8MFAKdp6jyI8TKthB
	 UH+F+aspDg0WXrXyQijcSZ+onyjNlBGo9qgz4mb0QFNHaGmWflZPMhnklPLW64uB+X
	 nUU+1L8me725OoN17cUemaJX0XmmTSX/9SjIVuUOKPirs5lyMJK5BLNBcPV4RsNSt+
	 ggzduqEyewamA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71784CFD318;
	Sun, 23 Nov 2025 08:36:24 +0000 (UTC)
From: Amit Sunil Dhamne via B4 Relay <devnull+amitsd.google.com@kernel.org>
Date: Sun, 23 Nov 2025 08:35:50 +0000
Subject: [PATCH 3/6] dt-bindings: usb: maxim,max33359: Add supply property
 for VBUS in OTG mode
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-max77759-charger-v1-3-6b2e4b8f7f54@google.com>
References: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
In-Reply-To: <20251123-max77759-charger-v1-0-6b2e4b8f7f54@google.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Lee Jones <lee@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>, 
 Amit Sunil Dhamne <amitsd@google.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763886983; l=1124;
 i=amitsd@google.com; s=20241031; h=from:subject:message-id;
 bh=ak0DhAM6ewGMiDuF0MxJPbPRxRy5VTuNwAK+zQj0j2o=;
 b=mnGqbVl/z06LDtgfnWHySKhlpzdB1tI4sr08M43fZvaKI1QcLj53kcG8lfxv77MkytMWWtr3k
 noSNgWtq7qIDsQ+UoA9apDtsiFUsGzHKu5mAgTiqkWWxOP57RsbPlrE
X-Developer-Key: i=amitsd@google.com; a=ed25519;
 pk=wD+XZSST4dmnNZf62/lqJpLm7fiyT8iv462zmQ3H6bI=
X-Endpoint-Received: by B4 Relay for amitsd@google.com/20241031 with
 auth_id=262
X-Original-From: Amit Sunil Dhamne <amitsd@google.com>
Reply-To: amitsd@google.com

From: Amit Sunil Dhamne <amitsd@google.com>

Add a regulator supply property for VBUS when usb is in OTG mode.

Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
---
 Documentation/devicetree/bindings/usb/maxim,max33359.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
index 3de4dc40b791..a529f18c4918 100644
--- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
+++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
@@ -32,6 +32,9 @@ properties:
     description:
       Properties for usb c connector.
 
+  otg-vbus-supply:
+    description: Regulator to control OTG VBUS supply.
+
 required:
   - compatible
   - reg
@@ -53,6 +56,7 @@ examples:
             reg = <0x25>;
             interrupt-parent = <&gpa8>;
             interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+            otg-vbus-supply = <&otg_vbus_reg>;
 
             connector {
                 compatible = "usb-c-connector";

-- 
2.52.0.rc2.455.g230fcf2819-goog



