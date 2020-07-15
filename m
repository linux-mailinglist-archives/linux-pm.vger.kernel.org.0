Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0280220E20
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgGONbi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 09:31:38 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19993 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730872AbgGONbi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 09:31:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0f052c0003>; Wed, 15 Jul 2020 06:31:24 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 15 Jul 2020 06:31:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 15 Jul 2020 06:31:37 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jul
 2020 13:31:32 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 15 Jul 2020 13:31:32 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0f05300001>; Wed, 15 Jul 2020 06:31:31 -0700
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
Subject: [TEGRA194_CPUFREQ PATCH v6 0/3] Add cpufreq driver for Tegra194 
Date:   Wed, 15 Jul 2020 19:01:22 +0530
Message-ID: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594819885; bh=WTUIqvfTFFpJnkH2n1zUFiz0tjU+/4uyluowU1GJEtQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=RpSImJzMyW2BDMCE4bSK5VZwzXCjM7mkstKHXBIdWsB26Yeji/Pqf6sCb4oGYzjS+
         VeXbiGdfbaSocZPTkAG1AB4Ody5yYEeY7CyXCSRlF4+hseb2hzxLy/A6z79VH0mlsi
         hKTJBiAmCdCuGrsUtkZngqhDcuUR85azvtZ6h59MQe94kQzUP0phO4D8Ff2VT5clqG
         wpv5iuvuTiU5sNMUEI+E4ugL0k6f1SJFC2xtvuv6tItdjtPigoojMZnfhgaLkxU3rq
         inej/VKTMCKMiOa/lryWAZlawZcqsdeSJ51lyZ6DX0/Ukq0i5vM/Lq8iVUxYCduTnx
         xbYvnN+i19/cA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh & Rob,

Have made the changes as per feedback.
Please review/ack and consider this patch set for merging in 5.9.

Thank you,
Sumit
---

The patch series adds cpufreq driver for Tegra194 SOC.

v5[5] -> v6
- Add new schema file for 'nvidia,tegra194-ccplex'[Rob].
- Minor changes suggested in cpufreq driver[Viresh].

v4[4] -> v5
- Don't call destroy_workqueue() if alloc_workqueue() fails[Viresh]
- Move CONFIG_ARM_TEGRA194_CPUFREQ enabling to soc/tegra/Kconfig[Viresh]
- Add dependency of 'nvidia,bpmp' on 'compatible' in yaml file[Michal]
- Fix typo in description causing dt_binding_check bot failure[Rob]

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


Sumit Gupta (3):
  dt-bindings: arm: Add NVIDIA Tegra194 CPU Complex binding
  arm64: tegra: Add t194 ccplex compatible and bpmp property
  cpufreq: Add Tegra194 cpufreq driver

 .../bindings/arm/nvidia,tegra194-ccplex.yaml       |  69 ++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   2 +
 drivers/cpufreq/Kconfig.arm                        |   7 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/tegra194-cpufreq.c                 | 397 +++++++++++++++++++++
 5 files changed, 476 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
 create mode 100644 drivers/cpufreq/tegra194-cpufreq.c

[1] https://marc.info/?t=157539452300001&r=1&w=2
[2] https://marc.info/?l=linux-tegra&m=158602857106213&w=2
[3] https://marc.info/?l=linux-pm&m=159283376010084&w=2
[4] https://marc.info/?l=linux-tegra&m=159318640622917&w=2
[5] https://marc.info/?l=linux-tegra&m=159465409805593&w=2 
-- 
2.7.4

