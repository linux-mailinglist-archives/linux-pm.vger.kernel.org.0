Return-Path: <linux-pm+bounces-14684-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEB1986216
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D829828B185
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A0E188588;
	Wed, 25 Sep 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nsX2ra+3"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46E1D5AD1;
	Wed, 25 Sep 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276095; cv=none; b=kmVqI8AfHymXBKH6ZFt8ROwmXR56mtokWLpyR+b8ICPusdfiuULyg//sUc7mNTlVdAnQtYswcZoYWzE3NWANIHSD+2c9tUvI5GF4j98g1dkDv8Exr6c3DDpLuoCySAN7tcnL+LD65L+EDhXWMoYROW6X36FFhA9b5Mp8xtPmnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276095; c=relaxed/simple;
	bh=K16//F0DbPidmtkltMX/58Fp9H3+Gu7z7oJbF7Rw3t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KBsGx4kpwKd6/C8CWeGfZPPG9WAl9SCJkw7QR1oZDJoP/0ohm1IYT1niyznrPfCqrObBcQSDEAKSMt8O+UENSyS9//HXcWm8SHrBIcGVGjByhGo0331jnXmpL1HtOyDLrXexhOTUHYZXn8D3LRrtP8E29Y280ssU6lrf9nnZzVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nsX2ra+3; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PEsmbu062906;
	Wed, 25 Sep 2024 09:54:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727276088;
	bh=NK+aFPtpOPuMKEx44hKVNRmBW7EcmS4qirihAf/Pj8U=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=nsX2ra+3Ip62JVHWJymWSjig9RqGPPT78FYvzSFZd9Iz3fVgGIYwp+b8PWY43adKR
	 cT0br7RvvX2DVpqiCtiPMi0NGEIVwl/Q3vUeNaFMKflQPFzyCJbgOG0A1Nxejs311F
	 S/8dmRM61A9yNdGOrXLihg52D+/tq71OoCk1ma54=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48PEsmwJ101421
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Sep 2024 09:54:48 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 09:54:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 09:54:47 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PEsYCj110564;
	Wed, 25 Sep 2024 09:54:44 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Wed, 25 Sep 2024 20:24:16 +0530
Subject: [PATCH v6 2/6] arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ti-cpufreq-fixes-v5-v6-2-46f41a903e01@ti.com>
References: <20240925-ti-cpufreq-fixes-v5-v6-0-46f41a903e01@ti.com>
In-Reply-To: <20240925-ti-cpufreq-fixes-v5-v6-0-46f41a903e01@ti.com>
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
        Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727276075; l=1133;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=QKNdDE/Q+mzdtPNctGFPfcbWIa4u1MDTUg8/co9DUGU=;
 b=AtB9POziL6pfK4Jk8OvZ8M+fdXEs8pyd6ZAwhnELOGgOqNUczu4DZBh7EtOObYrlOH179kHX1
 CX6f1MnKfkXAra24GkBdBKagqzp2Z8kOmcGHFjkYh9aCsfavJ3fnC82
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


