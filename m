Return-Path: <linux-pm+bounces-32879-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E02B30E38
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F77B4E2C2B
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A62E2DF4;
	Fri, 22 Aug 2025 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWPqCCbc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63892E2DC3;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841290; cv=none; b=SFJs+dVcKsuVCox+aWeeijzjvwbfKyjSfBGB3Y6Sm6zMPBoweSnGXw+UN9HJKI3jBaXeXHb6QF/kREOfOZcTF95ojB/yrhASIZTgDDT8DFuhfQyW9UX+y14geqXekRPHhcbi/2PYA2t5iwNC03X5JVmHzTfl52sR5KVQJCaE0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841290; c=relaxed/simple;
	bh=q26G8rY/yZxO41j2xn0EyyR4ny+JDENIwRMkvg4w+oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iy9vORFkwpA7I+OOU6ZEnfh7yaaZuNn/k/5zr2QDR4GlAIO4ZF7TR4txzqGWjd7pfHRkn9HqrFgnCvCmUuayEIPYsdIvZFpPYdzTb3Wh+9zUDX/hlVkv7M5f2hU9unzqKbbAPE/SzqWcIic0hJ0vFSYUXnFBgDdSpwl8E11BsdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWPqCCbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35F65C19424;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755841289;
	bh=q26G8rY/yZxO41j2xn0EyyR4ny+JDENIwRMkvg4w+oE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YWPqCCbce2TXBlmjKsaYLv09yUF129Nd3IXQr9GOs3zg1mGrnywVqjqmT7OB2ydq+
	 r7Q72X9Ss4nRax5iTWUQD9LrBoquxLQZ9pjNCKIPp1h/1Zrjrutr8UcJ9RojefRVLO
	 155qejoBXjstryIOYR62R1+xQHQJX0o/sPAHRRYOTbt5usLENwhU7ugHn38SGWrx0K
	 hZBhZksOY8eGNqi4WDUNR6amMLkvwz5t6J3GypHaafwUY0ikZ7Db98f1GCJyWrhaRF
	 G996J9/C/s/Znvr16OMb57fHCCBIL5zxY/SsZqcKIJkLZIg+EuK9zJ7/UFGbvSvQIB
	 QEzsgOw4D06yA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B4CA0EFF;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 22 Aug 2025 13:39:59 +0800
Subject: [PATCH 5/5] arm64: dts: amlogic: s7d: add power domain controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-pm-s6-s7-s7d-v1-5-82e3f3aff327@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755841286; l=1126;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=F3DI1ogP18md6om9oJnkr6Qx94X86wm1hH073PtNhiw=;
 b=UTBvqx5lDN8I3xs1OuAWV2aGNtBoLnpVVnLb1uKQWs+18TabxePARl+cb3YJVjQdWDHm//7l6
 g8zqxGWO9CbAeMCbeVw3FBbyXciArP6U74hOtKEYt1E4rSVLRVDtg9o
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: "hongyu.chen1" <hongyu.chen1@amlogic.com>

Add power domain controller node for Amlogic S7D SoC.

Signed-off-by: hongyu.chen1 <hongyu.chen1@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
index c4d260d5bb58..f1c2e91ec6c5 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
+#include <dt-bindings/power/amlogic,s7d-pwrc.h>
 
 / {
 	cpus {
@@ -43,6 +44,15 @@ cpu3: cpu@300 {
 
 	};
 
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+
+		pwrc: power-controller {
+			compatible = "amlogic,s7d-pwrc";
+			#power-domain-cells = <1>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,

-- 
2.37.1



