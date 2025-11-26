Return-Path: <linux-pm+bounces-38699-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EADDCC899E0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 12:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D126D4E4565
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123AC3271F0;
	Wed, 26 Nov 2025 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eqLxOJbe"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D732572C;
	Wed, 26 Nov 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764158220; cv=none; b=UCnRTBuGbT3QC7E2JBHxSEOj1/CAKQQ11Brew2zjqWCuCA6XH7pdTnQG75/T/e8y22VC+VcenyXgnKeWeq70uRr0VxwzIo+2lUJUHRfJwofumtCadyUeb3AQbe6/eDDexlfAMZ5Q3uEmW1v9cM81IJRWnlb08BmrjkNXhujyWr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764158220; c=relaxed/simple;
	bh=FbsOThTrOK1Y/J4tVtyPVao7glCLEJI4mGN39AL4NMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qBRSgfulnPguLP0HD1Y2l+1uOnUpDivaI6bHGxeITOf1DAwPyAsMuu/FyPfuW3lJX/E78bZis2h8iyCYHpYLUw1R8lEGTYxoZvRynDiDqZRouE5/C9RhqU35eQAYSbdO5IEEVjtQLbc0xzz8nbvdXWtvHjZxGUS41x7bF30y+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eqLxOJbe; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=wOF1Tb4hdKgT+VsV0pVwid5+bzJCocSTb9mIOLanReE=;
	b=eqLxOJbe1xoF/BP0G2y/8umG0/LHkVwmn9QwVPals7otH+ObdqjTGJDwaf5fss
	GVUvamd7vUSm3f9ejJ+fS9hRXppRrLDtZBqLhxwEYKaJIDQNXrzDx/yZjyNkh4QN
	oiq/WaK9Yk1tF5jgrER4iMg9lKBvXJEig9nmmsjiUnPpI=
Received: from [192.168.10.1] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgBnveN26iZpJOi_FQ--.56535S5;
	Wed, 26 Nov 2025 19:54:38 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Date: Thu, 27 Nov 2025 02:44:09 +0800
Subject: [PATCH 3/3] riscv: dts: spacemit: Add thermal sensor for K1 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251127-b4-k1-thermal-v1-3-f32ce47b1aba@163.com>
References: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
In-Reply-To: <20251127-b4-k1-thermal-v1-0-f32ce47b1aba@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Shuwei Wu <shuweiwoo@163.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764182662; l=3083;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=FbsOThTrOK1Y/J4tVtyPVao7glCLEJI4mGN39AL4NMQ=;
 b=5qfoCVv1RYJJOaOFBlH40yx4L/yjtsCKGCP81+u/pjMb+oCIc/0VcR2naijW2pAhw8TGNO1vS
 /HH6dBRwZTuC75jdRRQh+JAa2XQYx9Xs3UqO17RS1WazITCSt22Jpcs
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:PigvCgBnveN26iZpJOi_FQ--.56535S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1rKF48GFyfCw4xtw48Xrb_yoW5XFyDpF
	1Skws5GFZrAryfXa13CryDK398Ka1vva48Xan7uryrArn0qFZI93y0k3W5tF18Gr4rW34j
	vryqy34DuF1qy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U17K3UUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/1tbioBMSjmkm4WqyYwAAs6

Include the Thermal Sensor Unit (TSU) node in the SpacemiT K1 dtsi
with definitions for registers, clocks, and interrupts.
Additionally, configure thermal zones for the soc, package, gpu, and
clusters to enable temperature monitoring via the thermal framework.

Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 6cdcd80a7c83b3f62500f226e8ed16787ded5016..67596c230396056eea4b2cfa9c6d7f04627c0209 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -338,6 +338,96 @@ osc_32k: clock-32k {
 		};
 	};
 
+	thermal-zones {
+		soc-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 0>;
+
+			trips {
+				soc-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		package-thermal {
+			polling-delay-passive = <0>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 1>;
+
+			trips {
+				package-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		gpu-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 2>;
+
+			trips {
+				gpu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				gpu-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster0-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 3>;
+
+			trips {
+				cluster0-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cluster0-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		cluster1-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&thermal 4>;
+
+			trips {
+				cluster1-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
+				cluster1-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -369,6 +459,17 @@ syscon_apbc: system-controller@d4015000 {
 			#reset-cells = <1>;
 		};
 
+		thermal: thermal@d4018000 {
+			compatible = "spacemit,k1-thermal";
+			reg = <0x0 0xd4018000 0x0 0x100>;
+			clocks = <&syscon_apbc CLK_TSEN>,
+				 <&syscon_apbc CLK_TSEN_BUS>;
+			clock-names = "core", "bus";
+			interrupts = <61>;
+			resets = <&syscon_apbc RESET_TSEN>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		gpio: gpio@d4019000 {
 			compatible = "spacemit,k1-gpio";
 			reg = <0x0 0xd4019000 0x0 0x100>;

-- 
2.51.0


