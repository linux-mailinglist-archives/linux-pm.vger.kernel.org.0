Return-Path: <linux-pm+bounces-14436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCE997C5E5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 10:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB51F22C6C
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 08:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5724F1991CD;
	Thu, 19 Sep 2024 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zDGbtGc2"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB6C1990C7;
	Thu, 19 Sep 2024 08:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734689; cv=none; b=DSqwZ3AOJWh+2+r+ruIhsmhGvMIAQsAjPrxdwrzIOkB2hWxn5MDz9A4qQ7YkMuVV3ChzR9PXX3ogBnEYdLEyxa45Dq8irbXOsaHHcr0DV7eJnX330Q+DWWOTX3+2MJpN31KOyimJTS1FmKMV9itsrTDeqEBlP/tXL0jjad0e+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734689; c=relaxed/simple;
	bh=D1ozCzN8EOcIsmgM8nfYHtI9gjtqsU0VRstJMG9YP94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYf7VFG1qzNs5exCPtPtP9H7p8MhaEyJheIwrRYKODaBxT+27C9+djfCKGNmBiuPFqMclDPNjfwh5umHM/9YAK3oXmEPrdCKSezOvOwIYNmlVaclTmvIPjtWnMmHbDOg4Du02244GqrGmgL1yLjudq9QZC/mUJMY/uQNK29CpgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zDGbtGc2; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48J8VEo6012186;
	Thu, 19 Sep 2024 03:31:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1726734674;
	bh=AHtx/XNkIWcnpZQhDMkchZlqzR1VQR4Dsjo81guqk98=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=zDGbtGc2PH+sHTBh58Mb0l3qJVTdB1zBFxyoBEySbxRQnqb6YO7wT6P3T6w3+UY4M
	 Gxfp0nyPeKjV+c/P9vYjEC5KsT9uTOvuv5FDWbdY/ZBgoUtQV3CEPezVEwRemSba3X
	 J3m0KNHI2WW1zE0+zYsKc8z3zgRN8y/cMD6DvOfQ=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48J8VEwP005798
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Sep 2024 03:31:14 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 19
 Sep 2024 03:31:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 19 Sep 2024 03:31:14 -0500
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48J8UrgX042798;
	Thu, 19 Sep 2024 03:31:10 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dhruva Gole <d-gole@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH V4 2/6] arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
Date: Thu, 19 Sep 2024 13:58:06 +0530
Message-ID: <20240919082809.174589-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240919082809.174589-1-d-gole@ti.com>
References: <20240919082809.174589-1-d-gole@ti.com>
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
index 67faf46d7a35..a6f0d87a50d8 100644
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


