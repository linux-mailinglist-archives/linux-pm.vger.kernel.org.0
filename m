Return-Path: <linux-pm+bounces-19897-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328A79FF895
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA293A2D3B
	for <lists+linux-pm@lfdr.de>; Thu,  2 Jan 2025 11:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F71AF4C1;
	Thu,  2 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pC7/Iq/h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F26E1ADFE2;
	Thu,  2 Jan 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735816564; cv=none; b=UrL3pPC8zQzyQWmcuPxq9r+t0VGYEGOdf7IGQWRiiHstHfsXV8GERUObjt5k2lVLHRRuS6Pg0sYe6zpBMHtKaf74nJcdefnC8p+P0l3/izsR+CtmhFyRMj/641cGp/HqhrLpASBWhbjJ71W1KVQ2icbPt+C2D2/RGcKhJzs68f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735816564; c=relaxed/simple;
	bh=cEnF3ovwUU25dT0wsQm5L10I978yEVeevFbc61/RQ9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLcJqTrQUDfiQ4W+g0rVYPohfZK9OBlO3t0UZVE7+fXh57G7cBJG2Pp4l63h8eFHSNZ8LmjPpQzp2IGDzmlW3mVjKYf0ndBwfqflDm9Du6yoFV/Lv6dLS+eeE50Tuntt+Ky7bKKD8VeD2B+h2TF8vhBkOq1wrJMzEXrv3973GlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pC7/Iq/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC3B4C4CEE4;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735816564;
	bh=cEnF3ovwUU25dT0wsQm5L10I978yEVeevFbc61/RQ9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pC7/Iq/hYbOMU0dmtsCyG38BVc069b6zrNQ+D4jl5WSlJN1A3z7hpRDea6DtcMl3A
	 h82NEKQ9VBXwbPH5sjh82PqtjKGzocubCEjlaojhVDzJT1F/7KBPVhbiAWMarGvE5G
	 Buw/+qvSMLSbxmQngFePpvp7q0HVK7JEZnI4ZyQCgTQYPt550RP3nbLaN3QCqUmDqR
	 2Hjdl3Qq2pq+M8q7vVOOyOfHAIS/8t+sWFqwsHBM20jW+LI/uz1TRZo76jOrjigCvM
	 jCbfgIht/5UilrbzjAadxVFrDmNf+SJRxFLEJQlBnSMmdpsgFpBZgyr7GLx7TQ99Hl
	 9SS197wW5uZ3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EDE77194;
	Thu,  2 Jan 2025 11:16:03 +0000 (UTC)
From: Thomas Antoine via B4 Relay <devnull+t.antoine.uclouvain.be@kernel.org>
Date: Thu, 02 Jan 2025 12:15:06 +0100
Subject: [PATCH v2 4/4] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 fuel gauge
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250102-b4-gs101_max77759_fg-v2-4-87959abeb7ff@uclouvain.be>
References: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
In-Reply-To: <20250102-b4-gs101_max77759_fg-v2-0-87959abeb7ff@uclouvain.be>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, Thomas Antoine <t.antoine@uclouvain.be>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735816515; l=1485;
 i=t.antoine@uclouvain.be; s=20241202; h=from:subject:message-id;
 bh=GN3EniKaEOYE0aMNRzhLT0R4oirK05MCY9w8a0rDXYc=;
 b=eMvTZq9F+2RWFQ1BgK4RRLys8hBQwJ8vxzR3brqK5tBh//epZY74AciI9nsB10bwtDs1X2cbA
 YbKhbU97pEDDbvI3SWyzXLCMXp5vg1Z6AoNRMAQDFPtFUDxrpzy1Z+z
X-Developer-Key: i=t.antoine@uclouvain.be; a=ed25519;
 pk=sw7UYl31W1LTpgWRiX4xIF5x6ok7YWZ6XZnHqy/d3dY=
X-Endpoint-Received: by B4 Relay for t.antoine@uclouvain.be/20241202 with
 auth_id=289
X-Original-From: Thomas Antoine <t.antoine@uclouvain.be>
Reply-To: t.antoine@uclouvain.be

From: Thomas Antoine <t.antoine@uclouvain.be>

Add the node for the max77759 fuel gauge as a slave of the i2c.

The todo is still applicable given there are other slaves on the
bus (pca9468, other max77759 functions and the max20339 OVP).

The fuel gauge has been tested and seems to give coherent results.
Manual activation of the charger via i2cset shows that the sign of
the current does indicate charging/discharging status.

Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 387fb779bd29ea3812331a7951f03b181c5fe659..6c83ee6f8a6b0327c576573d03a8d2bcc93f9e16 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "gs101-pinctrl.h"
 #include "gs101.dtsi"
 
@@ -90,6 +91,15 @@ eeprom: eeprom@50 {
 &hsi2c_12 {
 	status = "okay";
 	/* TODO: add the devices once drivers exist */
+
+	fuel-gauge@36 {
+		compatible = "maxim,max77759-fg";
+		reg = <0x36>;
+		reg-names = "m5";
+		shunt-resistor-micro-ohms = <5000>;
+		interrupt-parent = <&gpa9>;
+		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
 
 &pinctrl_far_alive {

-- 
2.47.1



