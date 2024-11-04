Return-Path: <linux-pm+bounces-16913-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F69BACA4
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 07:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472171F221FA
	for <lists+linux-pm@lfdr.de>; Mon,  4 Nov 2024 06:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D22A18CC10;
	Mon,  4 Nov 2024 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nZcjlJE2"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025C1741E0;
	Mon,  4 Nov 2024 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730702327; cv=none; b=A5iFKE2vGHb4Uf9LOyvd+whrdNf7ZoJBHjkE/IZ1Kw8+0J3r1AMXlRAXGxOKDtvNU3iO1GODkb3lRrgXrel3qOCCOX0T9RU4Nxrp7WEwNK0fK/c6PykYms/MlU0oK5dgAJ6c+SuIy/ko7ow7CyrK0BM9vL3nSxT2Gz2TufUqm/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730702327; c=relaxed/simple;
	bh=Fdh28i9yaL2QRgsXLb9NyUvhop4Ep0eQkAUyT/RTIUs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ivZGoP5dGiwlN30v5tfHinTnKtjV6kmGjet56gonrHbyxMS3uMe3BmnBepKbS+8p4CC6cvZSX9xPMgrgQgnSu/49031K4ulyEYTFbxaAr/PVAElV+4smBtAJKobwoK03frTuvnWlKREf2LY77VjXPwqLuqn2XB1bUxlEANwD8os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nZcjlJE2; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A46cLcE057212;
	Mon, 4 Nov 2024 00:38:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730702301;
	bh=nGVz5KejI+6GMQUMN3KYKvT7myfaxUoc/i4p+RM9ypI=;
	h=From:To:CC:Subject:Date;
	b=nZcjlJE2WqciqJjHksmXiRxrbAMM7mRxyb86cqdanUPb1aT7ZE/R5fKJIl9zGhLbW
	 8CXjSqZ4Eqyl/SkNeQ+PwdByUbZh/aFUQWP9eLvJ92m+CC71y/RxQy/UMjv+L+9esq
	 jXV38vPcsrCmy5QnwoILsLkvyIXroRVyQpHYplNk=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A46cL9m106737;
	Mon, 4 Nov 2024 00:38:21 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Nov 2024 00:38:21 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Nov 2024 00:38:21 -0600
Received: from lcpd911.dhcp.ti.com (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A46cHVi123048;
	Mon, 4 Nov 2024 00:38:18 -0600
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Dhruva Gole <d-gole@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Bryan Brattlof <bb@ti.com>,
        Wadim Egorov
	<w.egorov@phytec.de>
Subject: [PATCH V3] arm64: dts: ti: k3-am62: use opp_efuse_table for opp-table syscon
Date: Mon, 4 Nov 2024 12:07:08 +0530
Message-ID: <20241104063707.3604302-1-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add another entry in the wkup_conf for the syscon node, and then use
that for the syscon in opp-table.

Marking entire wkup_conf as "syscon", "simple-mfd" is wrong and needs to
be addressed similar to how other child-nodes in wkup_conf are implemented
in the same file.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---

Since the driver fixes for ti-cpufreq.c have made it in -next [1],
The DT fixes for SK-AM62x can be supported with support for legacy
style DT as well. This has been tested on SK-AM62x [2]

[2] https://gist.github.com/DhruvaG2000/40b80cc04a9ac90c86445d6e67ece4cb
[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/cpufreq/ti-cpufreq.c?id=1724ae88efcbcd0daeb203ffeb4a2c0e59f2ddf7

Changelog:
v3:
- Update syscon@43000000 to say bus@...
- Validated that these changes don't break U-Boot:
https://gist.github.com/DhruvaG2000/2833b895dc79d5ce16265ecf15310add
- Link to v2:
https://lore.kernel.org/all/20241030044553.3225383-1-d-gole@ti.com/

v2:
- Deleted PATCH to Make the AM625 efuse_offset 0, because with [1] we no
  longer break backward compatibility and hence need to preserve the old
  offset.
- Link to v1:
  https://lore.kernel.org/linux-arm-kernel/20240902093222.2828345-3-d-gole@ti.com/

---

 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 9 +++++++--
 arch/arm64/boot/dts/ti/k3-am625.dtsi       | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index e0afafd532a5..9b8a1f85aa15 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -8,9 +8,9 @@
 #include <dt-bindings/bus/ti-sysc.h>
 
 &cbass_wakeup {
-	wkup_conf: syscon@43000000 {
+	wkup_conf: bus@43000000 {
 		bootph-all;
-		compatible = "syscon", "simple-mfd";
+		compatible = "simple-bus";
 		reg = <0x00 0x43000000 0x00 0x20000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -22,6 +22,11 @@ chipid: chipid@14 {
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
index c3d1db47dc9f..c249883a8a8d 100644
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

base-commit: dec9255a128e19c5fcc3bdb18175d78094cc624d
-- 
2.34.1


