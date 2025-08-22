Return-Path: <linux-pm+bounces-32878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A31B30E3A
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 07:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42EF16BFBC
	for <lists+linux-pm@lfdr.de>; Fri, 22 Aug 2025 05:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFECB2E282A;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCjprZzf"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801682E228D;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755841289; cv=none; b=SNDyb1sn5Vw0I00xS4zyyC7ILUxcIPj4LGAaI33/BXpyy/avhvPcwMkwhdxI577o0w60ixz5j/ZRvWJlbcynGePcb7entE2jibZDA6SVOO+lw+jAO8wL4fDTxOCXZcnKSeHd6uZWDyFNlRdvKLoFsouBFS5yzIjagJqZ7SkSb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755841289; c=relaxed/simple;
	bh=YthMYH+u7VxdtCFxsK4McprwGIGcM99TrDlR69FIdic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLElA+6OOziRt4wpZOZL4Y1Z2R8d6xDoPerSkdrGAlSLeu9rE0NI09XJdw0knljwsYSOM0Sk7UeQTAhGySDU7svzonbOQLjETwZVOlbFYEDj0vWFUYugCVjYJsS0qbbky82fT+KNe4Hq73vmsk6EklUlQgNW4/1AZDQc2WFh4y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCjprZzf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B302C4AF0D;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755841289;
	bh=YthMYH+u7VxdtCFxsK4McprwGIGcM99TrDlR69FIdic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vCjprZzf6+GTEOawcCEP5sllLT4PaEOkQjFkt4kUPDybsrdfdKRtHl2r1f06n0Hlg
	 6YiW0qRachTGAK1VT5r7IPhA65INYZewsaD6jGR4SumYwzacgl9/cUHBwYOJZqbfPI
	 gIysaQkmKK7KJp+TjLx0i6B2bwHE/orrOyYgC/s70wVZPmn4qNjfGXksn1ekXPe2Q7
	 tgOHM98X2z/2dYpuZ+8wTQTsA8H4Eq0lG6B72e0SUPrUgynvJsiZYdcbUz5c45N8WK
	 N1XrAm0dkuGZDGSBtYyvckTb7xs7teUPcyVQlQpbxFA7AYYHJP3rcDVFf4cG2fgmKL
	 gi9+kw3Bw27Pw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAB9CA0FE8;
	Fri, 22 Aug 2025 05:41:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 22 Aug 2025 13:39:58 +0800
Subject: [PATCH 4/5] arm64: dts: amlogic: s7: add power domain controller
 node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-pm-s6-s7-s7d-v1-4-82e3f3aff327@amlogic.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755841286; l=1118;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=Z2bZ8ygUDmcoyAdECyCuE+r70QpbVdcGLNPdDdonfMQ=;
 b=WI05JnHjXuCY998BA879NJ+KdanWzhdaPSvrGTLqMbeVhoRG3ElRKWk7bYPheM3Uvf39dcPCN
 BxXiBF6tjZ2D3xRGAsP0n7Z42wLPfArjZEFLcYW03QW7HFrsR4eaQj+
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: "hongyu.chen1" <hongyu.chen1@amlogic.com>

Add power domain controller node for Amlogic S7 SoC.

Signed-off-by: hongyu.chen1 <hongyu.chen1@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
index 260918b37b9a..0473ca7195b9 100644
--- a/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
+++ b/arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/amlogic,pinctrl.h>
+#include <dt-bindings/power/amlogic,s7-pwrc.h>
 
 / {
 	cpus {
@@ -43,6 +44,15 @@ cpu3: cpu@300 {
 
 	};
 
+	sm: secure-monitor {
+		compatible = "amlogic,meson-gxbb-sm";
+
+		pwrc: power-controller {
+			compatible = "amlogic,s7-pwrc";
+			#power-domain-cells = <1>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,

-- 
2.37.1



