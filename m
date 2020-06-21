Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85653202D03
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jun 2020 23:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgFUVe4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 17:34:56 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13091 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgFUVey (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 17:34:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eefd2240000>; Sun, 21 Jun 2020 14:33:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jun 2020 14:34:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jun 2020 14:34:54 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jun
 2020 21:34:52 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 21 Jun 2020 21:34:52 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eefd2780000>; Sun, 21 Jun 2020 14:34:51 -0700
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
Subject: [TEGRA194_CPUFREQ Patch v3 2/4] arm64: tegra: Add t194 ccplex compatible and bpmp property
Date:   Mon, 22 Jun 2020 03:04:32 +0530
Message-ID: <1592775274-27513-3-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
References: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592775204; bh=TpthJr1iU0Z8U18qrY6XTkSfu4UJS8h2L2M4yxyYoSY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PuQLsq5qLSnk5BOfL2lL8u9+XGnihynUtYNOIBqGypyfZ236BFzEydUNXc1w4lsg8
         Rn5xIlWJcqd853pTH+y2KFJ9uHCL2X/TEFYiLYg9OcuDo5kv50hoUGdUwmuA7rjHor
         6eQD6acZUodj74rc6fsmvHPM5Of1AXv36mQ0Muz78Ahne8uHh+KBoij5cQgStdukcB
         QRn5kWqfCRONTlsEMUQQ7rwvs7B6BpQb7PqnbGOE/IGLBjvI2ZLvkqyipucD//f+jB
         iqMMRUcmKQWWbXls5p5jbXdnSKsRr1rkcXGk33Ku3VkCazH0ZS+u4kh1Rbl2ObgBCs
         ogz9jh7xywzhg==
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

