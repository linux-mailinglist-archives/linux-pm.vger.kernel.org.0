Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEE5202CFB
	for <lists+linux-pm@lfdr.de>; Sun, 21 Jun 2020 23:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgFUVeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Jun 2020 17:34:44 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13073 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgFUVen (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 17:34:43 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eefd2190000>; Sun, 21 Jun 2020 14:33:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 21 Jun 2020 14:34:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 21 Jun 2020 14:34:43 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 21 Jun
 2020 21:34:41 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 21 Jun 2020 21:34:41 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eefd26d0000>; Sun, 21 Jun 2020 14:34:40 -0700
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
Subject: [TEGRA194_CPUFREQ Patch v3 0/4] Add cpufreq driver for Tegra194 
Date:   Mon, 22 Jun 2020 03:04:30 +0530
Message-ID: <1592775274-27513-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592775193; bh=rc/M36yeXh5NhddSoYlnubmqDFsAahtXAPVUVnc5BfI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=EE/5PLa1eoCEU8hDS3f8it1qikL9dJNkNDmVA2+UtpKGoqYaLI6/eiA/1yirUFs/f
         6YowgOUZ452MVE7uvoduxmMfbx4nkJ4k6RLZNshhvcUVY9RhrYXi9xIIBb1lC6IBtZ
         Wji70eIWEg89zeRCImIHo945ND9uVfcYl72gejBEUJv8NxuSg3xrr9l97W1OuNkEWr
         k096lLYeB0+3A//9vS6zpdYskx+xhAEvH/be7OXhe2K0MvwBPGoISskxR4YHTMEUhS
         aUO5Q1gjctxBBiB/cAXd3r1PZgn3+5s6k2Yup/mtKiMLzcWrmjHBT1r74a50uzrLIm
         oUZ6t51qqQ/qQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch series adds cpufreq driver for Tegra194 SOC.

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
 drivers/cpufreq/tegra194-cpufreq.c              | 403 ++++++++++++++++++++++++
 6 files changed, 422 insertions(+)
 create mode 100644 drivers/cpufreq/tegra194-cpufreq.c

[1] https://marc.info/?t=157539452300001&r=1&w=2
[2] https://marc.info/?l=linux-tegra&m=158602857106213&w=2 
-- 
2.7.4

