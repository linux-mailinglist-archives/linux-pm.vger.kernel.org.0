Return-Path: <linux-pm+bounces-26619-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DDAA7FF5
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 12:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EC1BA028C
	for <lists+linux-pm@lfdr.de>; Sat,  3 May 2025 10:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEFF1EE014;
	Sat,  3 May 2025 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg/zCX9f"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BD11E7C07;
	Sat,  3 May 2025 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746266836; cv=none; b=BUJbk721t5CkLFG+0Tf2qWNn13cviIxkDJEuwRExc46LD+tjxVm8DZGLWi91pFo+nUTOcnsGL6HRJvl5l5YWbNTWRtkaWxnqLLEQmpz9WTkxZiMTg4adI+QVjroG2inKKMYtjaRkQMt1k0VGGofRPb+pPJwuqOlkc6AeLfJGiKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746266836; c=relaxed/simple;
	bh=YJOaSDly5OXf7x/9U0F2pBzqeVmuR2xxTnyLEHHQiBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tTQ25jWOorccqb0uwmv2G8x2APHSMOcjHtFb9erfNT//P8YjfR7ourouwjo/wJPPf/3msSFBpo8ZQtOErTZ9dX2uMewr0tC5dDe4SXizKBLZPNzPKUe1IaU8dUzpUvTV8ifSgmw49YAapUSv/W5/KcdJ74LRB0cbLqAC0z+/N3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg/zCX9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A6C5C116D0;
	Sat,  3 May 2025 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746266836;
	bh=YJOaSDly5OXf7x/9U0F2pBzqeVmuR2xxTnyLEHHQiBo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kg/zCX9f/0OIa/Mv0E7eAgV+9hBiXMLIXXsdhZZy8gBy2GaO91TF+ZZ9y85ZxGe5A
	 S/LqlRkjTrS7jVPY8c0AeOM6H/dsQkhIbKO4u2+OvOnsBtRpXaRp3hjMlmmJZehrCD
	 tFvJPFV2wqIy1q1DSXLINlEVhKnU1Etl6JicWBjYs0WVlqtMIbm6p3mihQ8924NfFO
	 R+O9cz/cPl/NhU5JFiok8TgkCvc3xGtJcIiaUkmHwd8//NQyahFP293Od540zr1TSH
	 BT2m89DlGohzRqCmv8apb9Za4gzOaDuArGfZXthpFfd+VM0Q+FXCdUOR3e5UKi9Ea+
	 od+p+qxJLSkZA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1464CC369D9;
	Sat,  3 May 2025 10:07:16 +0000 (UTC)
From: Sven Peter via B4 Relay <devnull+sven.svenpeter.dev@kernel.org>
Date: Sat, 03 May 2025 10:06:55 +0000
Subject: [PATCH v4 8/9] arm64: dts: apple: t8112: Add SMC node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250503-smc-6-15-v4-8-500b9b6546fc@svenpeter.dev>
References: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
In-Reply-To: <20250503-smc-6-15-v4-0-500b9b6546fc@svenpeter.dev>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=sven@svenpeter.dev;
 h=from:subject:message-id;
 bh=vsXQZT03CWopgaZq8Qi/epv0zAQvVBiropiOdEDcO7c=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4boq3OH3+eVGyzb8CuXccoijbvPJpuzpRm9az9nMP97r
 teBGcqhHaUsDGIcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJ6P5h+F+U9nzGBd/3Fzgn
 b1xmE9/E73Li6OYZk67d250kl8qsyXSc4X/C41san9xt1RqDjq/YtipcLTjXMtz57HW7lGN+ujZ
 9U1gB
X-Developer-Key: i=sven@svenpeter.dev; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@svenpeter.dev/default with
 auth_id=167
X-Original-From: Sven Peter <sven@svenpeter.dev>
Reply-To: sven@svenpeter.dev

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8112.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8112.dtsi b/arch/arm64/boot/dts/apple/t8112.dtsi
index e95711d8337f6cea898e88a3d564caf2c4f94404..861cf2f684a067d73f79d8f01447bc375136793d 100644
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
+					<&boot_error_count>, <&panic_count>, <&pm_setting>;
+				nvmem-cell-names = "shutdown_flag", "boot_stage",
+					"boot_error_count", "panic_count", "pm_setting";
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



