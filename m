Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE470220E29
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 15:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731864AbgGONbr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 09:31:47 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1044 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgGONbq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 09:31:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0f05350002>; Wed, 15 Jul 2020 06:31:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 Jul 2020 06:31:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 Jul 2020 06:31:46 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jul
 2020 13:31:45 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 15 Jul 2020 13:31:45 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0f053c0003>; Wed, 15 Jul 2020 06:31:44 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <mirq-linux@rere.qmqm.pl>, <devicetree@vger.kernel.org>,
        <jonathanh@nvidia.com>, <talho@nvidia.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ PATCH v6 2/3] arm64: tegra: Add t194 ccplex compatible and bpmp property
Date:   Wed, 15 Jul 2020 19:01:24 +0530
Message-ID: <1594819885-31016-3-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594819893; bh=TpthJr1iU0Z8U18qrY6XTkSfu4UJS8h2L2M4yxyYoSY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=hClJNTpJmi3ZKr35qzdDl30vXfg7bguu22hVcZUnu7HZNuJpgAZMtw5Qj2/0y66iY
         MdoNxZktR6/LLINxKEci/SE/aHIUa/WgLPWpguK+yEoVRHzDOrRdRJYEZ45W7dtXNh
         xMTqJ7fSdXfQSe2gH/INhbni9rIRPkg1iILWsoQsYfrTKOC/WJ5Tpsj8OZd+H2fQMh
         ZA3KM/u1I3/4ErqM/vaky801AWB3XoIlgxfeAMwBl+nPG3t/z29IXtmRRwr//+iqqa
         7UJhlHtLlQ75uRagvwC3cyivSBO7gE6iY2EVQX+9VltSFNi0mLJxvbhknebEjRsjlc
         fdG21pqXyx3XQ==
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

