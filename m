Return-Path: <linux-pm+bounces-14607-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F969842AC
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 11:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AD991F21B6F
	for <lists+linux-pm@lfdr.de>; Tue, 24 Sep 2024 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328AF1791F4;
	Tue, 24 Sep 2024 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a4nnE9VO"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672941714BA;
	Tue, 24 Sep 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171491; cv=none; b=M4OZ+RWlczFHI7+nXhiyskYE88sMLYwFtSNhD3aPf9OMQDPW9MoTagEaPJlSKr08+wHZAmvUtDvZXcS5tUKNBUwkWUJTwlO6oT+MdIln9shoEnX18aGtF7nrX9aIgnU3G0Gnzp2nYwjaEDeurrbl9qDn0S1Kup5N3Ie5S9X9nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171491; c=relaxed/simple;
	bh=gmxyRsRvrN/GW7kRQnE8u/bLH36aFbd2B6dpmrkb7U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MqOF3XZdCxxJmVqFIsbvq733RjxUCUC5SqLSRRfLtTays6hVpS9BCbKu8nNEuhXoC+PKrPOsQdIZlvYDXfZ9/8VgtXqP9xG4nlynLJv2IIjTz7WSOwjyOI3XUfaFFrd+ACplWA/pqSQ+4T/Qjj4yhqB0booco4loBLL7YfnI9Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=a4nnE9VO; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48O9pNBI003201;
	Tue, 24 Sep 2024 04:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727171483;
	bh=zLhShaVN27E261VkbondnBJqweCJB7QrnU+MuM8Qq0E=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=a4nnE9VOmFEkX5LB/WBFbhzjZi7DQUol+4yKSKogbW1at7s+YzzAcbpdHMr0vv8uI
	 o7Y4if3Iu2hdVgHMRUN+10fT4cZ+mxC+LxqwxUISQUQurPpDwItjWE9FwAVEWeRciy
	 dLDg1Q6hiqHUSZJZDJBIxUBMZEd6/daRHHU0/pm8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9pNiJ017168;
	Tue, 24 Sep 2024 04:51:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 24
 Sep 2024 04:51:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 24 Sep 2024 04:51:23 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48O9owSu017217;
	Tue, 24 Sep 2024 04:51:19 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Tue, 24 Sep 2024 15:20:45 +0530
Subject: [PATCH v5 5/6] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240924-ti-cpufreq-fixes-v5-v5-5-cbe16b9ddb1b@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727171458; l=2062;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=gmxyRsRvrN/GW7kRQnE8u/bLH36aFbd2B6dpmrkb7U4=;
 b=iiVadLTD5Z5Ab3nxOZwC3GCVhsPQnORwbTQBFsHSmS1vvMBy4+D+LhTOTeZfZMQjoYshhdtIi
 rNxoE1RFk3CD7/a1puPp5OQth+BFzOsi/SyyyIx8iWT6GGfLfhzDEJX
X-Developer-Key: i=d-gole@ti.com; a=ed25519;
 pk=k8NnY4RbxVqeqGsYfTHeVn4hPOHkjg7Mii0Ixs4rghM=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add another entry in the wkup_conf for the syscon node, and then use
that for the syscon in opp-table.

Marking entire wkup_conf as "syscon", "simple-mfd" is wrong and needs to
be addressed similar to how other child-nodes in wkup_conf are implemented
in the same file.

Also, rename syscon to bus and drop reg = <>;

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 10 +++++++---
 arch/arm64/boot/dts/ti/k3-am625.dtsi       |  2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index e0afafd532a5c63f29ca0dabc541ffa22dde609b..9933bb55b00532fbd5ea74fc90036ab0eadd50bc 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -8,10 +8,9 @@
 #include <dt-bindings/bus/ti-sysc.h>
 
 &cbass_wakeup {
-	wkup_conf: syscon@43000000 {
+	wkup_conf: bus@43000000 {
 		bootph-all;
-		compatible = "syscon", "simple-mfd";
-		reg = <0x00 0x43000000 0x00 0x20000>;
+		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x00 0x43000000 0x20000>;
@@ -22,6 +21,11 @@ chipid: chipid@14 {
 			reg = <0x14 0x4>;
 		};
 
+		opp_efuse_table: syscon@18 {
+			compatible = "ti,am62-opp-efuse-table", "syscon";
+			reg = <0x18 0x4>;
+		};
+
 		cpsw_mac_syscon: ethernet-mac-syscon@200 {
 			compatible = "ti,am62p-cpsw-mac-efuse", "syscon";
 			reg = <0x200 0x8>;
diff --git a/arch/arm64/boot/dts/ti/k3-am625.dtsi b/arch/arm64/boot/dts/ti/k3-am625.dtsi
index c3d1db47dc9f351d217721c0b9e46a0c68995838..c249883a8a8d846aa21092c4c341fd443cfcec15 100644
--- a/arch/arm64/boot/dts/ti/k3-am625.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625.dtsi
@@ -108,7 +108,7 @@ cpu3: cpu@3 {
 	a53_opp_table: opp-table {
 		compatible = "operating-points-v2-ti-cpu";
 		opp-shared;
-		syscon = <&wkup_conf>;
+		syscon = <&opp_efuse_table>;
 
 		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;

-- 
2.34.1


