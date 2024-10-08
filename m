Return-Path: <linux-pm+bounces-15335-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5130994F3F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 15:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DED28846E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Oct 2024 13:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FA61E0DB6;
	Tue,  8 Oct 2024 13:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hmVKFX6q"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40371E0B9D;
	Tue,  8 Oct 2024 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393822; cv=none; b=qRBbIwsVY7PfE8jOWiAsyeEBgyRGe1MfVN4JtHiRv1a/BQLRr1EvMZ4SMZnZyqPODynT/ygdYeaPrwCKAErGKP7OBFfx6w+PRjyTZlXcx1FgmPp1XG6bQ+f2lre2rBaQnRQ9GJayeBazLMJDrkgAWtFWIoAanzZImS6lO7k8g8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393822; c=relaxed/simple;
	bh=PtmnZwPqvSQnWb0Yjs3f+GSJAFg9GAIGRZZ3T2Vm65c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VWXLQN88KHtuy2CWlaMeKKtS/Z0achT0IQLEQvNVCT+xPBUp1Cv8m/9o1yaiElo9DHYPA1rN2sWcj6wiNPkRQgH+U+qeE4/eVki5RzGW3IQGK5yByEhWxICQVJV59DDDOghvFC4U8BgJRt+fKFLW/Aj6Ihkslx6gW5rRWZOTaHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hmVKFX6q; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 498DNYR6013727;
	Tue, 8 Oct 2024 08:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728393815;
	bh=zytJpeXZ53gg/UZEyn0vEbjWxEvwqe5Wc7jTbTY0OaU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hmVKFX6qUqUhPPxBStl568Uq+baIOVQY7lbaraRS3t0UApL9aiiv/yR5k3IF5jWfb
	 l9jOTo4Bnc+A0m5dW0Q/l1GWvbRCU15JFhFCjI8ebatERPQl0V98Ehj/VMODj5evZL
	 7G6ZyTAWUBQb+W2c4gSJQDBSHNon8X2fd86N2BqA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 498DNY3G098012
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Oct 2024 08:23:34 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Oct 2024 08:23:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Oct 2024 08:23:34 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 498DN82G098273;
	Tue, 8 Oct 2024 08:23:31 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dhruva Gole <d-gole@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH V8 4/4] arm64: dts: ti: k3-am62p5-sk: add 1.4ghz opp entry
Date: Tue, 8 Oct 2024 18:50:53 +0530
Message-ID: <20241008132052.407994-5-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008132052.407994-1-d-gole@ti.com>
References: <20241008132052.407994-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Bryan Brattlof <bb@ti.com>

The AM62Px reference board is capable of supplying 0v85 to the VDD_CORE
which allows the Cortex-A53s to operate at 1.4GHz according to chapter
6.6 of the SoC's data sheet[0] . Append the 1.4Ghz entry to the OPP
table to enable this frequency

[0] https://www.ti.com/lit/ds/symlink/am62p-q1.pdf

Signed-off-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts b/arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
index 3efa12bb7254..7f3dc39e12bc 100644
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


