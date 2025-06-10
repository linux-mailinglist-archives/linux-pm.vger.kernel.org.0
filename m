Return-Path: <linux-pm+bounces-28404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6413AD3E86
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 18:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 970203A61C5
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE732243379;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a914ghSC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F9B24169E;
	Tue, 10 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571840; cv=none; b=XtCnE+6c89dc4bk5q7ZEjJ8Wu3E0AWEy62dS1/DmlTX3a1ypsY/g0vdOUSpZVVpfJnR02JZr+RT2Q2Z791I/L3oD2VRx9ogXSVOHbWvEZ9GDTqSXnNDnL4c5M1cm388ZZubI0e6+ZVIjrFktsWUaaCwP5rDzOPMpykiu7lV4zVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571840; c=relaxed/simple;
	bh=LdciKIEfC54OCN+wMLcJhY50a3NMkpFHdd2g/2anl9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQac0eiVvWH6FSVjI5fa1QOwNm0+KRJC+0Rk3HKyIUbSc7uEj0OU+Zy19rL4CU9hoEmlgAj1PoA9VpQoPW2cwifoAwDFxBwJbeIkqe0IRhYzoUn55CD46a7Wc+M2rL4P59y6GWwnBxarRerWfrADO3tQiz0hyWRu+Lvpa0dG0io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a914ghSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB432C4CEFF;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749571839;
	bh=LdciKIEfC54OCN+wMLcJhY50a3NMkpFHdd2g/2anl9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a914ghSCSV5MYU7MRrFjBqsWJsL3SNYntH5veWnmyeMbmPccrzknKBcMvMI1xzUid
	 0K9+qvSBPoU3go9gsDKmyvqEQm5RGzTQldPsuYwg1sfCOhmbFsUJbxtc7Y1yVxOujC
	 CJ73KNWg32kpT+X+la67f6kvo67bR1kvDvctKDoO922CR9hoNO0hhZQGAZcz04NR4J
	 UmQSlwag9RvgA7gyBKk9Cy8QaYJuwQLLJyUUSVvmRkaj7TorwM2RxUYBs+GMBKR91I
	 +aDLWHWRo6DsxOyRBpZc1xqr4SMBC9QSkOKilIDsFRuvqYxmnTY5TpQcaVuaIAjAEN
	 RrfDnm1kZW1QQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D239BC677C4;
	Tue, 10 Jun 2025 16:10:39 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Tue, 10 Jun 2025 15:29:50 +0000
Subject: [PATCH v7 09/10] arm64: dts: apple: t8112: Add SMC node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-smc-6-15-v7-9-556cafd771d3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=PTk+uvBuZw97L0oizh86ZFF+DstpQe37103kl1wYeLQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ4aHf1X8+/2HbrJx7drvnmkZHHDTaw7vUobpE5q/Trnf4
 Xdt80W3jlIWBjEOBlkxRZbt++1Nnzx8I7h006X3MHNYmUCGMHBxCsBESo4yMswoKZi8wYHvON/9
 rmcGLW82dRlor9t86NtRaQtulU0R7ysZGTps7FVMkkwlGa+IOGTdfHDvtrJfyOntl46/2yf6u2t
 eNC8A
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



