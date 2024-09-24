Return-Path: <linux-pm+bounces-14602-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B498429A
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02031F219CC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 09:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A2155CBF;
	Tue, 24 Sep 2024 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YNmIZyIG"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C5E768FD;
	Tue, 24 Sep 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171487; cv=none; b=RoHhwhusfINLT8Od+O9Q44boJnGgj06RGImE3h7mcf1oPdvF/awVHmVqX2WeGNUTsv52jUsFFUNg/gCDuKNgNpQdXDEaelXfC1WvTgwmnK8coG7WqdnGtWCtBX/0U/Re3BJ4XbK/QOCTMVZ9wsEH4INEG7/jwX3qa1slefR+GCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171487; c=relaxed/simple;
	bh=K16//F0DbPidmtkltMX/58Fp9H3+Gu7z7oJbF7Rw3t8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PaMshFjIzEdzydI+iWb/916vEEYwiQhI0gwDrUl7ii1kiQWWv5Zs3UP1t317AEmzi9mO9AgrG6PgF9XW4VZwE6vd50ZHakK7rORBi2rkIePv4+Ax5BEJEn0fLJGk4obDQQPjhMolKb3zF3uHBvtK7DeDZtbxdHzdy8fA26V4aTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YNmIZyIG; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48O9pBIE003162;
	Tue, 24 Sep 2024 04:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727171471;
	bh=NK+aFPtpOPuMKEx44hKVNRmBW7EcmS4qirihAf/Pj8U=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=YNmIZyIGfwisLySIRql80nONNd1uP5/dQVZphBHWtdJFHbfB7WcMrWbqMChb4vDl6
	 00Uh4MS62mapBUwNxSScK5+Mzpzqv8VOmEgMGX4oV0Lxkx/+Ernzdffz1VZRVnoENa
	 tU8SUSO+5wQv9zy5UeusH1OEN+hlWNOQMNZctkvM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48O9pBtG005945
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 24 Sep 2024 04:51:11 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 04:51:11 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 04:51:10 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9owSr017217;
	Tue, 24 Sep 2024 04:51:07 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 24 Sep 2024 15:20:42 +0530
Subject: [PATCH v5 2/6] arm64: dts: ti: k3-am62a7-sk: add 1.4ghz opp entry
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240924-ti-cpufreq-fixes-v5-v5-2-cbe16b9ddb1b@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727171458; l=1133;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=QKNdDE/Q+mzdtPNctGFPfcbWIa4u1MDTUg8/co9DUGU=;
 b=2jxqcvmcRkYpL08Fm2npIy10A3VGdIK9qzlReoRqiEcPSiznTUE5o9OWTOjj5lvZm5DqCyGCN
 OVWUOd+cQ/9Bgybut3/83ygKdxycSnU6H+ZIswcff61a0LidXjYBZzp
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


