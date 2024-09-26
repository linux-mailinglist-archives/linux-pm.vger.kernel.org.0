Return-Path: <linux-pm+bounces-14792-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54730986EEC
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 10:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40911F21E90
	for <lists+linux-pm@lfdr.de>; Thu, 26 Sep 2024 08:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75F41A704A;
	Thu, 26 Sep 2024 08:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PgAobRUs"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AF21A4E9A;
	Thu, 26 Sep 2024 08:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339769; cv=none; b=pv3mjopgDyCKIxZ164U8nN9ixvRg0QuqTQtWdmfcxsj9aX5tezzLCQUdz0PmEAzGbrFsIJDAyOZiAeMXjYQUkfEDXjhR6Zc20B2e/2JF755jjd8zChaZSRKADivsXlHcNbJo0dOPm5l991/6XD+pPJft/VB3w3UCRwyOkiX07P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339769; c=relaxed/simple;
	bh=gmxyRsRvrN/GW7kRQnE8u/bLH36aFbd2B6dpmrkb7U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Mjg4h8yWtJ69VD8kgi4n9mked5Vr9V4y2ObqTZ5kw3iRZHlWedARPITTgQNwM0pBHjcaTmo5HAq/Z+5u18uyetjlahNRx5J+2PeH6H3WhlMjsEhIDWgXiN6qjSQ8Mi68Re+GtcvAGVLnaJrLUfuKA6z4RsRkGwW1jKZ4vrpmx8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=PgAobRUs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZtKL069839;
	Thu, 26 Sep 2024 03:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1727339755;
	bh=zLhShaVN27E261VkbondnBJqweCJB7QrnU+MuM8Qq0E=;
	h=From:Date:Subject:References:In-Reply-To:To:CC;
	b=PgAobRUso3AVh8p7H3FPRH8DprDnwv22vB3MjHljzbWQPV7ezfegr4yFpQsPR1zK+
	 1anBJz7S5FJtwysbhW4Oty401aVm+S5LuMTX22JwhW90ua6itbc3mj/pAxjePoxn9D
	 SVa9FWVOStqMsJk6f274oHOmTA+yfqc4AsBqnXhM=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48Q8ZtCG006550
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 26 Sep 2024 03:35:55 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 26
 Sep 2024 03:35:54 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 26 Sep 2024 03:35:55 -0500
Received: from [127.0.1.1] (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48Q8ZPK9064456;
	Thu, 26 Sep 2024 03:35:50 -0500
From: Dhruva Gole <d-gole@ti.com>
Date: Thu, 26 Sep 2024 14:04:56 +0530
Subject: [PATCH v7 5/6] arm64: dts: ti: k3-am62: use opp_efuse_table for
 opp-table syscon
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240926-ti-cpufreq-fixes-v5-v7-5-3c94c398fe8f@ti.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727339725; l=2062;
 i=d-gole@ti.com; s=20240919; h=from:subject:message-id;
 bh=gmxyRsRvrN/GW7kRQnE8u/bLH36aFbd2B6dpmrkb7U4=;
 b=LlNNBZyVor5AP/eXka2i6tm8J6sR4UY+lHeRlH40FetDY2GEM0TFbGgM5my7l3rEoe0zJn2JC
 G7vSMXZr9UtAFmt+TrH7JKipBGa9+XgVDw/AAma9MCEdWSm/jrpTe40
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


