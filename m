Return-Path: <linux-pm+bounces-28403-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F8AD3E81
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 18:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2AB3A5CBC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99BE243364;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="is1xQi66"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EEE241691;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571840; cv=none; b=SzA5ukSmVHyFmjeOpai7K0t607Tz6q5TAL1bz9+BoYv+y3G27Mu54q8eFzA4J97YcbNUc/hkkqZ9RYXD1348ywN0ep+8dS8cqIOSoD7D7UctM52FkBgWzKcfXv3271xiHKKxfzpedG+uX6h0ONevqPn782i9/BlCZIT/hLRYwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571840; c=relaxed/simple;
	bh=SXHxzaiiLT/m2k1jRME2dSR/Kfqf0in/78dSyfn423g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l8RYE3P6n6XqyJ8Z5TMQyl6BAu5zAxDFJdNTgT7QQnGVxi7182WhROicc89D1aVC1u7XxyTP3YY2/ys8VYXbeQ4YfRLyfOaZfkUEvkUPOYctWcO9GxeQQ6AnN6xPI50fp2GpEtnbruugvb1LEIfvGRE7YvSypFHy6Um7lfMOuSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=is1xQi66; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA7FC4CEED;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571840;
	bh=SXHxzaiiLT/m2k1jRME2dSR/Kfqf0in/78dSyfn423g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=is1xQi66VbkmDQLA6BmyUYeIDZwK7TCFnOQpK5v7y4eZFGN/SPkwTPlp6tEG4Ka6f
	 5OOdYKqZbQAssMIQsSHwe7cHF/7PzXQRnWLVJx/pKtA17ma9ih/ptr9go7wiK8WzRD
	 va99Vh6Ki4+SgSZc5Ioo2vvc38EBKLVOCBgjFHOevIbRj5pcYuZ9kSbbMiCLgRFOKz
	 Ohg2/Gs5H75gFpl++0OnZVKm//imP9c/hMvooIh9hHVUGgzzQhPL2gfV1RshgIxUAY
	 fqNHGHLUCa5rW5Pg5iW3y9sllOWuREZKP5fXLjCa0pUPqnEnG4lme0nJME2WX1EYIB
	 HhJyg9nKbmNCQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF2C5B543;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Tue, 10 Jun 2025 15:29:51 +0000
Subject: [PATCH v7 10/10] arm64: dts: apple: t600x: Add SMC node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-smc-6-15-v7-10-556cafd771d3@kernel.org>
References: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
In-Reply-To: <20250610-smc-6-15-v7-0-556cafd771d3@kernel.org>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=d8mVq62H2zbw5gGICFsvhQIy6YecpVCZ77lCLDSqOcw=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4aHf7Xmm8vulmtud8lsO1CmsHu10GnvyYerXR5GJgaz7
 tr5IjWro5SFQYyDQVZMkWX7fnvTJw/fCC7ddOk9zBxWJpAhDFycAjCRRGVGhh8v3rkm6f5/JP3w
 wBO+tq9hKctyLe2M47JVmIxSbrccMmRkWHBy5+cCl4eblr1InP2f7ajs802XfnbeubX0wrV9xTL
 bZ/AAAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Neal Gompa <neal@gompa.dev>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi | 35 +++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 110bc6719512e334e04b496fb157cb4368679957..9eb9b0656bf9c570983c90e360795b7a7c71cf90 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -24,6 +24,41 @@ aic: interrupt-controller@28e100000 {
 		power-domains = <&ps_aic>;
 	};
 
+	smc: smc@290400000 {
+		compatible = "apple,t6000-smc", "apple,smc";
+		reg = <0x2 0x90400000 0x0 0x4000>,
+			<0x2 0x91e00000 0x0 0x100000>;
+		reg-names = "smc", "sram";
+		mboxes = <&smc_mbox>;
+
+		smc_gpio: gpio {
+			compatible = "apple,smc-gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		smc_reboot: reboot {
+			compatible = "apple,smc-reboot";
+			nvmem-cells = <&shutdown_flag>, <&boot_stage>,
+				<&boot_error_count>, <&panic_count>;
+			nvmem-cell-names = "shutdown_flag", "boot_stage",
+				"boot_error_count", "panic_count";
+		};
+	};
+
+	smc_mbox: mbox@290408000 {
+		compatible = "apple,t6000-asc-mailbox", "apple,asc-mailbox-v4";
+		reg = <0x2 0x90408000 0x0 0x4000>;
+		interrupt-parent = <&aic>;
+		interrupts = <AIC_IRQ 0 754 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ 0 755 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ 0 756 IRQ_TYPE_LEVEL_HIGH>,
+			<AIC_IRQ 0 757 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "send-empty", "send-not-empty",
+			"recv-empty", "recv-not-empty";
+		#mbox-cells = <0>;
+	};
+
 	pinctrl_smc: pinctrl@290820000 {
 		compatible = "apple,t6000-pinctrl", "apple,pinctrl";
 		reg = <0x2 0x90820000 0x0 0x4000>;

-- 
2.34.1



