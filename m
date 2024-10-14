Return-Path: <linux-pm+bounces-15595-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2B99C189
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D331F210EC
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2024 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0726714D2A3;
	Mon, 14 Oct 2024 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="y1916qdS";
	dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b="y1916qdS"
X-Original-To: linux-pm@vger.kernel.org
Received: from bayard.4d2.org (bayard.4d2.org [5.78.89.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2697614AD24;
	Mon, 14 Oct 2024 07:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.78.89.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891535; cv=none; b=k2xaDxd5znPzU42mHnM7coR4QkcD0D/8O7EQ38xhciVuqmVICZFU3Udmixo4vso67Coka8sloWpq4SnykJpUJtG1iieTs4ZwcCrCBCW9JS4muQLKyjVsqpJ8+27ISACppa6B+WzGZyV3TiVIblwGnrcka0jzr0yJyUjaCFI9Lws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891535; c=relaxed/simple;
	bh=DwDhlRnfpNqUwydKjC1DfKRcf6/WtjZO99jAwo/5zu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4glcYkD25WhJ3aQB3pYDULzFH0rNPZxcb1BYuVGVGCAvKMrguX8fIsTbqD5KQ3Nd+U4BcrYR9HFL65Ax7kizjBWSmk9d6TRXue03tazqX59eS42LRakhhJxOSiyzXt8grjKKnQ5LuxCiOmccqHEM/0Q9LUDbQ2xq4e95vP5Fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org; spf=pass smtp.mailfrom=4d2.org; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=y1916qdS; dkim=pass (2048-bit key) header.d=4d2.org header.i=@4d2.org header.b=y1916qdS; arc=none smtp.client-ip=5.78.89.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=4d2.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=4d2.org
Received: from bayard.4d2.org (bayard.4d2.org [127.0.0.1])
	by bayard.4d2.org (Postfix) with ESMTP id D1357122FE1E;
	Mon, 14 Oct 2024 00:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728891533; bh=DwDhlRnfpNqUwydKjC1DfKRcf6/WtjZO99jAwo/5zu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y1916qdSUQSOFUWoMsWsKiK+hPQ9abzy46MMb+1BK7HiIzjV+YkPmX0kMXsCMN4oZ
	 nt55DEO0RHjD4Y5yzgnYGjj/1rgOBu1x2dgvVouuuPVYAJeVaNB9/16fxzCYq9DuKX
	 tXumTql/PSWyIllPnLqHSDm3U+JdJ55N4mENBoYNFfswHEPmsw57vIDA+kz0vuwhG7
	 Mu+vVjVk+YIj+nddSMQHtKwNy4rKrgIeyp18Yd5AFea4mGmgTKRDxRrur/mbT73sDV
	 KwftQJFPGnFE71ByhL6yc4+DnOaAVpTHUi00X6YPpUUEhcMOtp31BxULUMs76mnkDH
	 ROQ3gXcYYLYQw==
X-Virus-Scanned: amavisd-new at 4d2.org
Authentication-Results: bayard.4d2.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=4d2.org
Received: from bayard.4d2.org ([127.0.0.1])
 by bayard.4d2.org (bayard.4d2.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bJZxxpwYIaA4; Mon, 14 Oct 2024 00:38:53 -0700 (PDT)
Received: from localhost.localdomain (unknown [110.52.220.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: heylenay@4d2.org)
	by bayard.4d2.org (Postfix) with ESMTPSA id 1679B122FE21;
	Mon, 14 Oct 2024 00:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=4d2.org; s=mail;
	t=1728891533; bh=DwDhlRnfpNqUwydKjC1DfKRcf6/WtjZO99jAwo/5zu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y1916qdSUQSOFUWoMsWsKiK+hPQ9abzy46MMb+1BK7HiIzjV+YkPmX0kMXsCMN4oZ
	 nt55DEO0RHjD4Y5yzgnYGjj/1rgOBu1x2dgvVouuuPVYAJeVaNB9/16fxzCYq9DuKX
	 tXumTql/PSWyIllPnLqHSDm3U+JdJ55N4mENBoYNFfswHEPmsw57vIDA+kz0vuwhG7
	 Mu+vVjVk+YIj+nddSMQHtKwNy4rKrgIeyp18Yd5AFea4mGmgTKRDxRrur/mbT73sDV
	 KwftQJFPGnFE71ByhL6yc4+DnOaAVpTHUi00X6YPpUUEhcMOtp31BxULUMs76mnkDH
	 ROQ3gXcYYLYQw==
From: Haylen Chu <heylenay@4d2.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>
Cc: linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Haylen Chu <heylenay@4d2.org>
Subject: [PATCH v5 3/3] riscv: dts: sophgo: cv18xx: Add sensor device and thermal zone
Date: Mon, 14 Oct 2024 07:38:13 +0000
Message-ID: <20241014073813.23984-4-heylenay@4d2.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014073813.23984-1-heylenay@4d2.org>
References: <20241014073813.23984-1-heylenay@4d2.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add common sensor device for Sophgo CV18xx SoCs and thermal zone for
CV1800b SoC.

Signed-off-by: Haylen Chu <heylenay@4d2.org>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 28 +++++++++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv18xx.dtsi  |  8 +++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index ec9530972ae2..af53c9ec3197 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -12,6 +12,34 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x80000000 0x4000000>;
 	};
+
+	thermal-zones {
+		soc-thermal {
+			polling-delay-passive   = <1000>;
+			polling-delay           = <1000>;
+			thermal-sensors         = <&soc_temp>;
+
+			trips {
+				soc_passive: soc-passive {
+					temperature     = <75000>;
+					hysteresis      = <5000>;
+					type            = "passive";
+				};
+
+				soc_hot: soc-hot {
+					temperature     = <85000>;
+					hysteresis      = <5000>;
+					type            = "hot";
+				};
+
+				soc_critical: soc-critical {
+					temperature     = <100000>;
+					hysteresis      = <0>;
+					type            = "critical";
+				};
+			};
+		};
+	};
 };
 
 &plic {
diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
index b724fb6d9689..0465561f7043 100644
--- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
@@ -133,6 +133,14 @@ portd: gpio-controller@0 {
 			};
 		};
 
+		soc_temp: thermal-sensor@30e0000 {
+			compatible = "sophgo,cv1800-thermal";
+			reg = <0x30e0000 0x100>;
+			clocks = <&clk CLK_TEMPSEN>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>;
+			#thermal-sensor-cells = <0>;
+		};
+
 		i2c0: i2c@4000000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x04000000 0x10000>;
-- 
2.46.2


