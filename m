Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86F721D7D4
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 16:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgGMOHL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 10:07:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16572 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMOHL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 10:07:11 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c6a550000>; Mon, 13 Jul 2020 07:06:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 07:07:11 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 13 Jul 2020 07:07:11 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 14:07:10 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jul 2020 14:07:10 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0c6a8a0002>; Mon, 13 Jul 2020 07:07:10 -0700
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
Subject: [TEGRA194_CPUFREQ PATCH v5 2/4] arm64: tegra: Add t194 ccplex compatible and bpmp property
Date:   Mon, 13 Jul 2020 19:36:47 +0530
Message-ID: <1594649209-29394-3-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594649174; bh=TpthJr1iU0Z8U18qrY6XTkSfu4UJS8h2L2M4yxyYoSY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FwpE1atwlp8SXES4cUJ3zPPT4j1DaQesDcN5DjrIBTMEWv6jr/jiTik+uGV6dgdp5
         9PGlCm96O+vbcMzhqZsSDVoxAqHlS3R23OJXBKZm4VZa/FvjsE+wWi6gjnbl8fNuHO
         H9uifcTu23dm2TBrzF5XbQv+6TbXyTNqTs0lkKgyjVawKS9cuMmh2GO72aXhOYf2us
         RuYt/6epYSlyNcSapZhybKpuCHNGUkPkC/bKcfTbfN8/GEd3ohzfciIkbeqB/6tq0t
         FhY/OoMyj56QouGDh/bvuXIBvVmyC9FtcP9AalFjY9nGwPFlxD19DnVX5Lbvi70Dud
         m7tnyHz1xXucQ==
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

