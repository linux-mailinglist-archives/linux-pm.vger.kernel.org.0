Return-Path: <linux-pm+bounces-14604-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF86B98429E
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743EC285724
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B152416C6B7;
	Tue, 24 Sep 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qOSj60eU"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED3D14F9CF;
	Tue, 24 Sep 2024 09:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171488; cv=none; b=ZCUOnY8ks4vA3/MqRB/7bagRmuvDvDKH1NXm5NGcu3o0DYktLlwIMTIc7KE4Wm75crueXTOePHwpfDbQWxjr/w3HLK6ExkYgg/hQvQr0EU/pmqKp4JmSkjfU26r9zFDYD9b/ZF5FPWZfvYFu7gkEQjLafrMJ2eD/QEa3A/o4UHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171488; c=relaxed/simple;
	bh=9TdNETtTnsOfwHv1BPX1X4EncEO6xuAjOt7AXgk6a04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=up+gVI71VmI4Ufez9rZZg/MaWaqRhyLvD6HpMhrkmtQ2eOpiJnHGld6/ByOxw2JXVO/UU71mlowEFPdF1QybDJMY9mOW1UyNFQ6/X2xSkRj0EQcNIvdqZAPHc3LxdCY3O9IX68w6cMd1MVOGZkwQ71oaL/gYPgv/2oHJyK/Uyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qOSj60eU; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48O9pJsa120027;
	Tue, 24 Sep 2024 04:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727171479;
	bh=6kNy+oF+7IH4TdlM7HPfJbKXYAWCEdbMeGLixnsPAxc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=qOSj60eUxkOHY4KjzW5J48O05FWb+6RXPMB0ya5fTt1igJEqOpomPbdFO0Qh16w72
	 aBVfhmmxRDI6Jgxpfr2FPhOvuugCKHLH1RGEJrSjkfmLigpoAnGaXBAmqMtXNzchAv
	 QdGwYZ+OhtcnrjDgGHXTS/936dBroL1sj6BPMaYA=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48O9pJub001007
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 04:51:19 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 04:51:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 04:51:19 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9owSt017217;
	Tue, 24 Sep 2024 04:51:15 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 24 Sep 2024 15:20:44 +0530
Subject: [PATCH v5 4/6] arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240924-ti-cpufreq-fixes-v5-v5-4-cbe16b9ddb1b@ti.com>
References: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
In-Reply-To: <20240924-ti-cpufreq-fixes-v5-v5-0-cbe16b9ddb1b@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727171458; l=1070;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=J2V9iMpCezlqmgozhrln6pQnlfb3x2eF+J3i+JcTGx0=;
 b=CNGRggXG+sMmFIJlNIbp5imBnzhkUBHx0SJA146FTW3bol7DvVw4M0HZ5q3FKgQCKuM1a59mX
 Yj1QMcFuRgxBHmKKSaGYaeB8EA8JW2j26z94aTsTsyT3f/7SGNQvIc3
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


