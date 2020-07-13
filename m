Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2E621D7CC
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgGMOG6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 10:06:58 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10119 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbgGMOG6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 10:06:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c6a750000>; Mon, 13 Jul 2020 07:06:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 07:06:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 07:06:57 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 14:06:56 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jul 2020 14:06:57 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0c6a7c0001>; Mon, 13 Jul 2020 07:06:56 -0700
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
Subject: [TEGRA194_CPUFREQ PATCH v5 0/4] Add cpufreq driver for Tegra194
Date:   Mon, 13 Jul 2020 19:36:45 +0530
Message-ID: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594649205; bh=U4gKmB4y0qNEJQMMMEmw5DHftEyFtcpFURIRDyOumOk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=Kz1L2isODkhL7vhii4ky6KnxDsBSmnVexTLc0pN1iEyCi5kOFc0Y7ZRJZKLWsEu9W
         l2Laqyjlo97zDxK4gDNTU0eiwPNTsAGe2xyXuhUk+KyXFYNGuXlmRSq7m6FRrAQOAN
         f2w6oTG4/tCB8+q8KBXlj9BcwJobPjPTrtxudKGExSHhJnBk9ysojvHmFkt2B1TyFU
         TOEfI8RPCYpQvTjl6tjQZVbCQ3GfnigVHzP5t504hDhBciaX8RtTEgWIDjm86pasKF
         V18pGIDdRpFkHWnDBkJ9y/3d4W7X6bfFd+jCZsm3rxZ8MYxkmPIOE/fkCPn9caOCFl
         OcO7aqbFrehDQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

The patch series adds cpufreq driver for Tegra194 SOC.
Incorporated the feedback on previous version of patchset.
Please consider this patch series for merging in 5.9.

Hi Rob,
Can you please review/ack DT patches (1-2).

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

Sumit Gupta (4):
  dt-bindings: arm: Add t194 ccplex compatible and bpmp property
  arm64: tegra: Add t194 ccplex compatible and bpmp property
  cpufreq: Add Tegra194 cpufreq driver
  soc/tegra: cpufreq: select cpufreq for Tegra194

 Documentation/devicetree/bindings/arm/cpus.yaml |  11 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |   2 +
 drivers/cpufreq/Kconfig.arm                     |   6 +
 drivers/cpufreq/Makefile                        |   1 +
 drivers/cpufreq/tegra194-cpufreq.c              | 397 ++++++++++++++++++++++++
 drivers/soc/tegra/Kconfig                       |   1 +
 6 files changed, 418 insertions(+)
 create mode 100644 drivers/cpufreq/tegra194-cpufreq.c

[1] https://marc.info/?t=157539452300001&r=1&w=2
[2] https://marc.info/?l=linux-tegra&m=158602857106213&w=2
[3] https://marc.info/?l=linux-pm&m=159283376010084&w=2
[4] https://marc.info/?l=linux-tegra&m=159318640622917&w=2
-- 
2.7.4

