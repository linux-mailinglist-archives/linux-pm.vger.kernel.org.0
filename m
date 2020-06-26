Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EDF20B512
	for <lists+linux-pm@lfdr.de>; Fri, 26 Jun 2020 17:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFZPoE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Jun 2020 11:44:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12431 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbgFZPoE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2020 11:44:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef617950000>; Fri, 26 Jun 2020 08:43:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 08:44:04 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 26 Jun 2020 08:44:04 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 15:44:03 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 26 Jun 2020 15:44:03 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ef617bf0001>; Fri, 26 Jun 2020 08:44:03 -0700
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
Subject: [TEGRA194_CPUFREQ PATCH v4 0/4] Add cpufreq driver for Tegra194
Date:   Fri, 26 Jun 2020 21:13:52 +0530
Message-ID: <1593186236-12760-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593186197; bh=UM5Bbd0/GCwYfLhn/DGNjOUA+9lJK2yysJtZ6vuKT3w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=itVozhVZE0HqUPYrUE3m9zs4S5isSIaSDKgdblwqwDxbYUjQqWeR6Ocizr8a6ENYD
         eAe5ebcN6juo8UFkShxVOomHAq8+j8AvyJg37XPJYIvwfZxZX2bRtH/pPXs93dfD1+
         L+PHJ5dO870vMQo5GnDLv+51Sx5UVMfYHrXmC66xGPxcr93hTv24tyEyPNtaF36x2N
         olV0DzDAA1aLQ8Sl55fiQaRH7K6s/VX7s+5GB2mT29KAWgodPLNcnO37j28sQ0O7tI
         XPEcoSmZsP37G8ww2zMsBLF+23B6GcmhrT0XVJDFm7cZtX1ESYDfKmq0wm20//s4nP
         qZol7eI/JzlaA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch series adds cpufreq driver for Tegra194 SOC.
Incorporated the feedback on previous version patchset.
Please consider this patch series for merging in 5.9.

v3[3] -> v4
- Open code LOOP_FOR_EACH_CPU_OF_CLUSTER macro[Viresh]
- Delete unused funciton map_freq_to_ndiv[Viresh, kernel test bot]
- Remove flush_workqueue from free_resources[Viresh]

v2[2] -> v3
- Set same policy for all cpus in a cluster[Viresh].
- Add compatible string for CPU Complex under cpus node[Thierry].
- Add reference to bpmp node under cpus node[Thierry].
- Bind cpufreq driver to CPU Complex compatible string[Thierry].
- Remove patch to get bpmp data as now using cpus node to get that[Thierry].

v1[1] -> v2:
- Remove cpufreq_lock mutex from tegra194_cpufreq_set_target [Viresh].
- Remove CPUFREQ_ASYNC_NOTIFICATION flag [Viresh].
- Remove redundant _begin|end() call from tegra194_cpufreq_set_target.
- Rename opp_table to freq_table [Viresh].

Sumit Gupta (4):
  dt-bindings: arm: Add t194 ccplex compatible and bpmp property
  arm64: tegra: Add t194 ccplex compatible and bpmp property
  cpufreq: Add Tegra194 cpufreq driver
  arm64: defconfig: Enable CONFIG_ARM_TEGRA194_CPUFREQ

 Documentation/devicetree/bindings/arm/cpus.yaml |   9 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |   2 +
 arch/arm64/configs/defconfig                    |   1 +
 drivers/cpufreq/Kconfig.arm                     |   6 +
 drivers/cpufreq/Makefile                        |   1 +
 drivers/cpufreq/tegra194-cpufreq.c              | 396 ++++++++++++++++++++++++
 6 files changed, 415 insertions(+)
 create mode 100644 drivers/cpufreq/tegra194-cpufreq.c

[1] https://marc.info/?t=157539452300001&r=1&w=2
[2] https://marc.info/?l=linux-tegra&m=158602857106213&w=2
[3] https://marc.info/?l=linux-pm&m=159283376010084&w=2
-- 
2.7.4

