Return-Path: <linux-pm+bounces-27183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABED4AB7DE0
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 08:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ECF48C6E3A
	for <lists+linux-pm@lfdr.de>; Thu, 15 May 2025 06:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5F297B66;
	Thu, 15 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVYCy5Bi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858A297A40;
	Thu, 15 May 2025 06:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747290135; cv=none; b=dKpHtiT3/sbGD1qRrX5CRHYMTKebJZodHFT4CGjhOXbqNa9n7w6m46QxSWDQpeWgXA+Zt5jC8C/yjnKYGvdKfpMxA8OkK05VtBgj9i+nC1YJbzWdeCDsacEJyr5vNcW8G4hCVD4thPPrs0kQVJw18WGOlW8vYbYaq52aYVR9esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747290135; c=relaxed/simple;
	bh=d/cnqlfcL3BEIbItF0LJzNxHyBvyuWmBbCAKSbuizjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kK7cpBq7kmic0SMTVjgqFKwbzj9zoUdsasQUmJoCvnpXd5tj0r0WurHShUwHMcuW8EFy7041YZA4aQTFA+0BjPU/tk6LdqsLgfrdJ2g16T7Y1TlzFNSocu74kGXQdxVuYBYm4t6niib93xt1F4dtrrCqXEm6EqOxYEGVIY1SQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVYCy5Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD960C116C6;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747290134;
	bh=d/cnqlfcL3BEIbItF0LJzNxHyBvyuWmBbCAKSbuizjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tVYCy5BiWTIcFBQlyEw5e1tczA4Vd8O/Rjm+Ppmyppa52CiE4/4v2+hnoVZ3qOEfa
	 k6wH7ULrd/Db84pMvv+107oAX4fEgS/dEs4F2XswyyWkvHyRG+zVAxLCN2lcKYf0QC
	 V47Y7I9tvOhRGECfdES4PzA2leJpgzv941TKzgKCHo4O5AujCqwDdrrPDbeACMXbdK
	 RLrq+DWUyjM0MvXJrrC3WRA+gLXv6Nb5n6Ln4eGiRnkXRa+obwOQBHmgaSAhiPBuuf
	 rfv6b1Id093Xx8r8FygPWFZelL/7VSybEsblkwcFCDCFCF+9T6Ik52cenyKOj9aJG5
	 +65m6TeFhxFoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CECC3DA6D;
	Thu, 15 May 2025 06:22:14 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Thu, 15 May 2025 06:21:21 +0000
Subject: [PATCH v6 09/10] arm64: dts: apple: t8112: Add SMC node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-smc-6-15-v6-9-c47b1ef4b0ae@svenpeter.dev>
References: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
In-Reply-To: <20250515-smc-6-15-v6-0-c47b1ef4b0ae@svenpeter.dev>
To: Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Hector Martin <marcan@marcan.st>, Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Lee Jones <lee@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1896; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=Wy1ROwTq/7w+Seef0bwqXl8fWrlwODCAclwUN7m+sTo=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4Zqh+DiqvoKrk9Bvgv6zB+YMZefOvSp4mZpm5PbmePX2
 SZGiJ7rKGVhEONgkBVTZNm+3970ycM3gks3XXoPM4eVCWQIAxenAExEZi7Df2f7x4q1d2y8Pymo
 9B09UH3A4mOKt7prvv7Lt4q3bZOq6xj+Z1XVaC7+yCCy5HaxVkXLddeCnfJeOzuefPkpnDM37xA
 7JwA=
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8112.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index e95711d8337f6cea898e88a3d564caf2c4f94404..ff059fd5cd799e0ca7271ddb3d94871e36035109 100644
--- a/arch/arm64/boot/dts/apple/t8112.dtsi
+++ b/arch/arm64/boot/dts/apple/t8112.dtsi
@@ -839,6 +839,41 @@ rtc_offset: rtc-offset@f900 {
 			};
 		};
 
+		smc: smc@23e400000 {
+			compatible = "apple,t8112-smc", "apple,smc";
+			reg = <0x2 0x3e400000 0x0 0x4000>,
+				<0x2 0x3fe00000 0x0 0x100000>;
+			reg-names = "smc", "sram";
+			mboxes = <&smc_mbox>;
+
+			smc_gpio: gpio {
+				compatible = "apple,smc-gpio";
+				gpio-controller;
+				#gpio-cells = <2>;
+			};
+
+			smc_reboot: reboot {
+				compatible = "apple,smc-reboot";
+				nvmem-cells = <&shutdown_flag>, <&boot_stage>,
+					<&boot_error_count>, <&panic_count>;
+				nvmem-cell-names = "shutdown_flag", "boot_stage",
+					"boot_error_count", "panic_count";
+			};
+		};
+
+		smc_mbox: mbox@23e408000 {
+			compatible = "apple,t8112-asc-mailbox", "apple,asc-mailbox-v4";
+			reg = <0x2 0x3e408000 0x0 0x4000>;
+			interrupt-parent = <&aic>;
+			interrupts = <AIC_IRQ 499 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 500 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 501 IRQ_TYPE_LEVEL_HIGH>,
+				<AIC_IRQ 502 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "send-empty", "send-not-empty",
+				"recv-empty", "recv-not-empty";
+			#mbox-cells = <0>;
+		};
+
 		pinctrl_smc: pinctrl@23e820000 {
 			compatible = "apple,t8112-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x3e820000 0x0 0x4000>;

-- 
2.34.1



