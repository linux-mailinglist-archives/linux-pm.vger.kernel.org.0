Return-Path: <linux-pm+bounces-14788-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF838986EDD
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95D0E1F234B4
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09A21A4E96;
	Thu, 26 Sep 2024 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E6w3/S5h"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD3239AD6;
	Thu, 26 Sep 2024 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339748; cv=none; b=kQ5QZWi6wIrks2bc9PIu3ctAZmLSBm37SUdyl1+plhFxaBdUoyoIxKR3ySPud2sei8Qrbmm6J17w9bFt8dQB9MhcsmLZuNJfZn4MXsg5eJOdM5rF/E3/ZgZITShffkmhkpB78aThpfkcnLbQGzbBmbEUiLehOakrhar8G/7zRw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339748; c=relaxed/simple;
	bh=K16//F0DbPidmtkltMX/58Fp9H3+Gu7z7oJbF7Rw3t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GHqGWhBEXgnkotwfyjQ2hHagd7V1Ioll7nl255WT6EuU07ytfUitNP9KS7kJvh0ok1fhDoe+kHaDXypEGbwDXOnxNhZvZkQpXmwkGnjgUA4NclF8J/hdgMGTTURJeDF5qSQ0YAgFR8llbm/TluCmG+bvG+S0j6SwblQ2c8BfKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=E6w3/S5h; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZfQF042517;
	Thu, 26 Sep 2024 03:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727339741;
	bh=NK+aFPtpOPuMKEx44hKVNRmBW7EcmS4qirihAf/Pj8U=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=E6w3/S5h1A/Hy/8CegjP132JVeH92i5LIYL2TDWFyOhxpy9PNOaterAaea6ifj4wO
	 DWTYnkEqKKz4F2xhpJVF9zd6DnZmn0BZXek/iaUflcs5Wr0O0NtpT+KqWd6ZyKt2+8
	 PiYEdo+X0oGe0Xs75HI7YY8JfM9kK7vF9YAFKRvQ=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8Zf3e052640;
	Thu, 26 Sep 2024 03:35:41 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 03:35:40 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 03:35:40 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZPK6064456;
	Thu, 26 Sep 2024 03:35:36 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Thu, 26 Sep 2024 14:04:53 +0530
Subject: [PATCH v7 2/6] arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240926-ti-cpufreq-fixes-v5-v7-2-3c94c398fe8f@ti.com>
References: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
In-Reply-To: <20240926-ti-cpufreq-fixes-v5-v7-0-3c94c398fe8f@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael
 J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>, Bryan Brattlof <bb@ti.com>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        Markus Schneider-Pargmann
	<msp@baylibre.com>,
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727339725; l=1133;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=QKNdDE/Q+mzdtPNctGFPfcbWIa4u1MDTUg8/co9DUGU=;
 b=oyFcxIMZSfUzRyrrqhjUJIo8VXLF2+KLYgfwxvoSQlVc0PaS3l3mIOLmO7eXoI51D5grqkp1A
 h2GChjsRSHPBcq2HATlMVnOWZ1+7GMqrB2hy2RnXroviX4X3pAnkGV4
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Bryan Brattlof <bb@ti.com>

The AM62Ax reference board is capable of supplying 0v85 to the VDD_CORE
which allows the Cortex-A53s to operate at 1.4GHz according to chapter
7.5 of the SoC's data sheet[0]. Append the 1.4Ghz entry to the OPP table
to enable this OPP

[0] https://www.ti.com/lit/ds/symlink/am62a3.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
index 67faf46d7a35a5954a5a832b8ab766320b48ea59..a6f0d87a50d8a7ebdb61e609e8071d6681dbec9a 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
@@ -68,6 +68,15 @@ wkup_r5fss0_core0_memory_region: r5f-dma-memory@9c900000 {
 		};
 	};
 
+	opp-table {
+		/* Requires VDD_CORE at 0v85 */
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-supported-hw = <0x01 0x0004>;
+			clock-latency-ns = <6000000>;
+		};
+	};
+
 	vmain_pd: regulator-0 {
 		/* TPS25750 PD CONTROLLER OUTPUT */
 		compatible = "regulator-fixed";

-- 
2.34.1


