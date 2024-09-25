Return-Path: <linux-pm+bounces-14686-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCD698621D
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 17:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 170BB1F292AD
	for <lists+linux-pm@lfdr.de>; Wed, 25 Sep 2024 15:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D471F188731;
	Wed, 25 Sep 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bAVQuByl"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334F514F9D0;
	Wed, 25 Sep 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276104; cv=none; b=suKTj19m7NvbTrNm2ng3AD/0W7+v10Yi/+Qi8S4jPmFoIuKfG3B0kvuiLToW5y0pr1oGxk7R6x8KyXVmJW87mKXHNaZJoF1ey8wdyEqpIqqK9IbTA6s+h5CEq679ZSpevqYcutLWZKHhvl0Koi2tuSV1QECjRtn+7R7loSrntBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276104; c=relaxed/simple;
	bh=9TdNETtTnsOfwHv1BPX1X4EncEO6xuAjOt7AXgk6a04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Hl1poVzZ5wq1MBbGHqKyRcF1MRvdMaD4UYkx6BaNK1scZwhhcil9Z158jL/aPx+uI6/qxMj/Sj0sfqeR/Pv3/wqGT1sh9Ph2PWJjEBkv1RYD89upAMiVpIoSBPYVwpGVusK1OEMHF7qMFCDQmialabAxyL8pE0mWRCnQbSFnfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bAVQuByl; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48PEsuYf073375;
	Wed, 25 Sep 2024 09:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727276096;
	bh=6kNy+oF+7IH4TdlM7HPfJbKXYAWCEdbMeGLixnsPAxc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=bAVQuBylmq89/IXa1ie+8ftRNXj01PsrpOl/CwAtE/GlCzKSKpekabhGhNrRJ1Pjg
	 PaeAEEspzYZMThk6QHdrqziyzLUmQDiWkL7v9/oWyRzLxpNP5iO0Y3Jg0uhQQFI7Oo
	 1vCTrfF2BjX1dKauiVEhEcAVub5lFx6i7rkGhjqk=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48PEsufj019355
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 25 Sep 2024 09:54:56 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 25
 Sep 2024 09:54:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 25 Sep 2024 09:54:55 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48PEsYCl110564;
	Wed, 25 Sep 2024 09:54:52 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Wed, 25 Sep 2024 20:24:18 +0530
Subject: [PATCH v6 4/6] arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ti-cpufreq-fixes-v5-v6-4-46f41a903e01@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727276075; l=1070;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=J2V9iMpCezlqmgozhrln6pQnlfb3x2eF+J3i+JcTGx0=;
 b=ia9CW9/0ztWYQ+kII9d3XGkREIhnseM8u/xF9AuocdCAwMoZbrecJZ9dCbDOuDaC2Ab95EDfX
 RLjZ7sm3mqDBcDI7qB9dZvAxqziVfLEW0+vKgZ7JLzH+Z4cLW/N8TdQ
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Bryan Brattlof <bb@ti.com>

The AM62Px reference board is capable of supplying 0v85 to the VDD_CORE
which allows the Cortex-A53s to operate at 1.4GHz according to chapter
6.6 of the SoC's data sheet[0] . Append the 1.4Ghz entry to the OPP
table to enable this frequency

[0] https://www.ti.com/lit/ds/symlink/am62p-q1.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 3efa12bb72546291e2fda79695edf577bbb134a1..7f3dc39e12bc9ca4a746ff092f946b84a36404b3 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
@@ -128,6 +128,15 @@ led-0 {
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
 	tlv320_mclk: clk-0 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";

-- 
2.34.1


