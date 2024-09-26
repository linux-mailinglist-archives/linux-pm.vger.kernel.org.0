Return-Path: <linux-pm+bounces-14791-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A85986EE8
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556FE286FEF
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0A1AB518;
	Thu, 26 Sep 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Jtdi0Qqq"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EC1ABED5;
	Thu, 26 Sep 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339757; cv=none; b=CtHzsIdO4RvdbXhYpRRYzfJMLAcLYQ7LxphYAPRxc/ZbhSGICBUdgavGY8ozO8dRSncbLOF8AlSr4Wdb5iy2ikwTZlfPX3TcD4kPAGF+QamHmWzH543ezHug8iInpqg0nOmnMiV+VQU+mIkiJYp+rxcUTqk4KUTHRjcc43weIC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339757; c=relaxed/simple;
	bh=9TdNETtTnsOfwHv1BPX1X4EncEO6xuAjOt7AXgk6a04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=M3b1ZRWNTAC2NdyQbijG8r5zdNmY5s/6eFS/TcukiQr9yjWgpV5JNfx2VstG0n/Cmr7Uy2HnhOklNUZ6Bdv1o0zmxptaCImTYbxXEWmoLSgAAUasXG2m6JvuzWvxCIzJyt+ovrU9VGH0HboW/d0mNbzySvRXjiAzaVQPLutP5jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Jtdi0Qqq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZoER042653;
	Thu, 26 Sep 2024 03:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727339750;
	bh=6kNy+oF+7IH4TdlM7HPfJbKXYAWCEdbMeGLixnsPAxc=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=Jtdi0Qqq67ukHtncGk7q+ArzwKY4TqlD7Zhxn3Zd9XH92GMIlif77q577GLXWKBj6
	 VlpJgJuYEnuj41tLM8/Sv6zYkdPcWJhPSyYCTEMZ95wY0q7ydII4KGDe0t3y0te228
	 Bs/tBcZua0Vk3hewiZE95y0fgBbYzuni+JmgwVSk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8Zomv052675;
	Thu, 26 Sep 2024 03:35:50 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 03:35:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 03:35:50 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZPK8064456;
	Thu, 26 Sep 2024 03:35:45 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Thu, 26 Sep 2024 14:04:55 +0530
Subject: [PATCH v7 4/6] arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240926-ti-cpufreq-fixes-v5-v7-4-3c94c398fe8f@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727339725; l=1070;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=J2V9iMpCezlqmgozhrln6pQnlfb3x2eF+J3i+JcTGx0=;
 b=Z2q8crZggpaHQgP4HpD6MDTahddhltLS+OnBB/j5TguSppzBD7d83uMowLBLlV2ja0/p4CBv2
 cPb/LT65UFVBFyxwyg08PDW5uKY3xKH6eH0KtjOH3JHQUrFz0wm5iLR
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


