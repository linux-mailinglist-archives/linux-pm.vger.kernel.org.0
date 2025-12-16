Return-Path: <linux-pm+bounces-39607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3798BCC08D9
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 03:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DCB3301818F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Dec 2025 02:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575D1FA15E;
	Tue, 16 Dec 2025 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NK+0J1Jw"
X-Original-To: linux-pm@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B3A59;
	Tue, 16 Dec 2025 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765850575; cv=none; b=fTRCJekpERkZc3+i8NcmMltw3yqFJLomXKXGF0zJEXQgHTlJNpV9vtFYqcqV+ew4IzLjq7VAMb6bMrnYeYDwX61ha7KQszLd7/xEqJHbbok63Q6j706OmiEe5J+y/7a9qBLDlkooU+EBMWuYW0dZ7B7obolEO8Tdp+UzlYLgTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765850575; c=relaxed/simple;
	bh=y011YJ1uJ0ICDCPPxjeBTXP9an/sM0tsW9o564MeUTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PiXfikcDNP2CzpkaAvpfmZK6IJS75TcmWzbdbe7DG5LQ6rj7oPQao5WTPfe0JVpUs9VJaxdFCShiNMGd5lmbqiG2j4cNzSittj+MJ1vSLHWlf1DuJbBtlxPrkqCP5MyyEtPLpyj/vmVCjgt+nl5b1SpYPKoJ8vJTsnfnWC+gGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NK+0J1Jw; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Date:Subject:MIME-Version:Content-Type:
	Message-Id:To; bh=Rs+rfWtyrtk97kpSu5fndp0xU+3WjRNBLxGPmOQrzzo=;
	b=NK+0J1Jw9/Rk8ursPJv1cCyc4VTt4GInpamkdvrups32oZGe6hzF4/CUgTd6Zk
	WD/s53T5AKAvtiui2dpW18JiyW9D+e2vdCAetlY+bjEZO6g4+yitJB8mC0+TU4Ux
	XsmG8JRgP0Vx997mhz752xT/fw5544098vxZOtrezD3cw=
Received: from [192.168.10.1] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDXUu97vUBpOmJ5Ag--.29S5;
	Tue, 16 Dec 2025 10:01:39 +0800 (CST)
From: Shuwei Wu <shuweiwoo@163.com>
Date: Tue, 16 Dec 2025 10:00:37 +0800
Subject: [PATCH v2 3/3] riscv: dts: spacemit: Add thermal sensor for K1 SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-patchv2-k1-thermal-v1-3-d4b31fe9c904@163.com>
References: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
In-Reply-To: <20251216-patchv2-k1-thermal-v1-0-d4b31fe9c904@163.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765850492; l=3136;
 i=shuweiwoo@163.com; s=20251125; h=from:subject:message-id;
 bh=y011YJ1uJ0ICDCPPxjeBTXP9an/sM0tsW9o564MeUTs=;
 b=uYTDOFVmm1ahH9cVHGgDpeVO1j+jLsXKk+qUN3obRjUh1fmGlF2ihXBM5/WY2ftbOs+M6QAdT
 914Ea3Y39X4BZcGt+xX3xYv9RiZm0bxSb6bfwyKiCEdpOL6GzQDzA72
X-Developer-Key: i=shuweiwoo@163.com; a=ed25519;
 pk=qZs6i2UZnXkmjUrwO5HJxcfpCvgSNrR4dcU5cjtfTSk=
X-CM-TRANSID:_____wDXUu97vUBpOmJ5Ag--.29S5
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrW8Gw45ZFy3Xw4xJry5Jwb_yoW5Wr48pF
	ySkws5GFZrJry3Xa13CryDK398Kan5ta48Xan29ryrArn0qFZIk3y0kwn8tF1kGr4rW34j
	vr1Dt34DuF1Dt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pNg4hQUUUUU=
X-CM-SenderInfo: 5vkx4vplzr0qqrwthudrp/xtbC4wP5iGlAvYOdvwAA3k

Include the Thermal Sensor node in the SpacemiT K1 dtsi
with definitions for registers, clocks, and interrupts.
Additionally, configure thermal zones for the soc, package, gpu, and
clusters to enable temperature monitoring via the thermal framework.

Signed-off-by: Shuwei Wu <shuweiwoo@163.com>
---
Changes in v2:
- Update compatible to "spacemit,k1-tsensor"
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index 7818ca4979b6a7755722919a5958512aa11950ab..0fe7396ea6e47d10a73e3bcea4f5165e5c268da0 100644
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
@@ -434,6 +524,17 @@ syscon_apbc: system-controller@d4015000 {
 			#reset-cells = <1>;
 		};
 
+		thermal: thermal@d4018000 {
+			compatible = "spacemit,k1-tsensor";
+			reg = <0x0 0xd4018000 0x0 0x100>;
+			clocks = <&syscon_apbc CLK_TSEN>,
+				 <&syscon_apbc CLK_TSEN_BUS>;
+			clock-names = "core", "bus";
+			interrupts = <61>;
+			resets = <&syscon_apbc RESET_TSEN>;
+			#thermal-sensor-cells = <1>;
+		};
+
 		i2c6: i2c@d4018800 {
 			compatible = "spacemit,k1-i2c";
 			reg = <0x0 0xd4018800 0x0 0x38>;

-- 
2.52.0


