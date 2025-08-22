Return-Path: <linux-pm+bounces-32875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A5B30E31
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50B21C20E73
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A972E2676;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBIRVmQR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDDA2820A3;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841289; cv=none; b=p0j/d4Tldq2QskQ15WE4tlwzRvNxLcmpk+CPu2S+adJH825mXa7k9kl1PiyPGEI+HlyHdU+ILfjyElrIzBbZdUREfjHrqpZlxF+EUvc5FzU7fxJBis6ErgccHgCPZhJNLmZTXEMa0mYl3CZNJjreWbnE8o7wNVWIHRfg8Y3vHJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841289; c=relaxed/simple;
	bh=jf9fstk9wE+vQeskkAEyhsMSu0t2e6OAGeuGQ8JCH94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdnX2JDBkpH0ljuk+dk7wuuOosBrxB2rR4RaKF58pVzLZ39YuOb/qFGvHaMKQZ9aWEZhP1+nlUYJW7MBPxV8vLslWoNp5ZANAEw4VDJ0bn+IxB2RHTkSfe106Hk6QJvjwR2uW/3uZCkqJXC6tYF9LyCFaPbcoGje3/PmrJ5CWdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBIRVmQR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A6A8C116C6;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755841289;
	bh=jf9fstk9wE+vQeskkAEyhsMSu0t2e6OAGeuGQ8JCH94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UBIRVmQRBEwi//GZN3lGsyqtkKQPW4jvDDlniRORX7SrUNwDGCDwjaCsXBM6I7mv6
	 qJnrj5AOcCtjJhcacJd6HAhX+Al/aw+uqx+S/cOcl3vcVzmR0nPg3+y4VmcaEg544o
	 1L/r4zmSMrMz1sfwI/gZizMnR+aAUz21sKN9mrQTtZ5zoxaihTYllOQAqZjAAIsGu8
	 4PK7uLLbiLDmkb0y/Vj0icgcjRdQ7V+E+t/kd3odvf8yVIriHcacVdLFGKPilJUY5i
	 JJ8a+A5z5jyvDRQ3Q5t7p7RHjyDZ6+R1AflRU99/2hmq3tXPLlzMKNlrkLa5IgjObE
	 wxPPqo0rI2vsA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10966CA0EEB;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 22 Aug 2025 13:39:57 +0800
Subject: [PATCH 3/5] arm64: dts: amlogic: s6: add power domain controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-pm-s6-s7-s7d-v1-3-82e3f3aff327@amlogic.com>
References: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
In-Reply-To: <20250822-pm-s6-s7-s7d-v1-0-82e3f3aff327@amlogic.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jianxin Pan <jianxin.pan@amlogic.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 "hongyu.chen1" <hongyu.chen1@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755841286; l=1145;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=kaj5R8JXVNmN1FRoL5Yj/r2ULPjPs0Piqs4W5hS0JIc=;
 b=mNWwLLgu/xNH88+Fcp2R6hiHPFt3qyqtax1tCkA5cWc5xDTGy40bxgHirv+0PdP4kSNEpHllh
 ErUZY0ni+izBFCMmB47LG4bOyeAuJGPyYKWMyELiZbj6DppovDMfviA
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: "hongyu.chen1" <hongyu.chen1@amlogic.com>

Add power domain controller node for Amlogic S6 SoC.

Signed-off-by: hongyu.chen1 <hongyu.chen1@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
index 5f602f1170c0..0dca64a2ef9e 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
+#include <dt-bindings/power/amlogic,s6-pwrc.h>
 / {
 	cpus {
 		#address-cells = <2>;
@@ -41,6 +42,15 @@ cpu3: cpu@300 {
 		};
 	};
 
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+
+		pwrc: power-controller {
+			compatible = "amlogic,s6-pwrc";
+			#power-domain-cells = <1>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,

-- 
2.37.1



