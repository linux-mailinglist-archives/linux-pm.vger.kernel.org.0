Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3561020B519
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 17:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgFZPoS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 11:44:18 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:7404 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgFZPoS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 11:44:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef617730002>; Fri, 26 Jun 2020 08:42:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 08:44:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 08:44:18 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 15:44:14 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 15:44:14 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef617ca0002>; Fri, 26 Jun 2020 08:44:13 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ PATCH v4 2/4] arm64: tegra: Add t194 ccplex compatible and bpmp property
Date:   Fri, 26 Jun 2020 21:13:54 +0530
Message-ID: <1593186236-12760-3-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
References: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593186163; bh=TpthJr1iU0Z8U18qrY6XTkSfu4UJS8h2L2M4yxyYoSY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=SJss+3SVYoVyw3hk76qQCnfqfE3+M6RmWd8wKhQf87N+OFvV3m3w4jAweaSg1n9fQ
         LMs5r2abT3NQSTVHKnmHUPTBTGj54e2UxuNR/6iSs3PNnYiJCd96kTAC5BqGKpdtge
         rGY+wDH6nskrRPgDtt3LiNMw/uCOD6bht2CT3MgiTx4yavuPLHiOuqTHcU12R7gHXy
         Dcgt0avZyMSi5gvQ9aNF94IFnJnfKFX2mu33SVPsKOFNXIeh5hLIWqHLwEk8aOjS25
         iUBbUShiDXBEL8yAGWkSm61wyi1b6AWL0hzlTaPlUlOkRXlBlV7i3u4LSh9S4c1bkv
         em9koXVuenJCw==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tegra194, data on valid operating points for the CPUs needs to be
queried from BPMP. In T194, there is no node representing CPU complex.
So, add compatible string to the 'cpus' node instead of using dummy
node to bind cpufreq driver. Also, add reference to the BPMP instance
for the CPU complex.

Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 7c9511a..0abf287 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1764,6 +1764,8 @@
 	};
 
 	cpus {
+		compatible = "nvidia,tegra194-ccplex";
+		nvidia,bpmp = <&bpmp>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-- 
2.7.4

