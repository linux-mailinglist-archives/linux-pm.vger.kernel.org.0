Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7332CC61
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 07:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234589AbhCDGJa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 01:09:30 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:2826 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbhCDGI5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 01:08:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B604079500002>; Wed, 03 Mar 2021 22:08:16 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 4 Mar
 2021 06:08:16 +0000
Received: from skomatineni-linux.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:15 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <skomatineni@nvidia.com>, <daniel.lezcano@linaro.org>,
        <robh+dt@kernel.org>
CC:     <ksitaraman@nvidia.com>, <sanjayc@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v1 0/5] Add cpuidle support for Tegra194
Date:   Wed, 3 Mar 2021 22:08:07 -0800
Message-ID: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614838096; bh=Tm0rjLZy4rE/8LLZIWcUvLj0vz1UXzrKC2AfwxMiOoc=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:X-NVConfidentiality:
         MIME-Version:Content-Type;
        b=lhjieTAyEclx3YJdE8KX2vVwtCt4TWYusD43JZ+DBqKCNRJhGbB8aWMyKppvSHvtW
         i0ER0/vsv6HCoWiybdH4nfOA+cO4YFlq3mrLIbpIvvxNvO7Gp/pvD1JXfE6G7UB5T/
         YG/1bzNg9FMDjbUDF0cg/rnrzzU8qbgghQ2nmqVaJP+TgHN4gJC4FSBqRiuvg970M4
         aSDTEfzHgo37oPogfH1d57lxA+eWa3BXRYM+oCYxgK8+DQBWxN6R7Y8yzqUmt7IONb
         Is5W2AUxy5VmWcX+u9zmA8BUyTNNNWwGwnglgnPml2o2GAM+/tJWON/jKeBvhke6u8
         Url2R3HciPvug==
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This series adds cpuidle support for Tegra194 carmel CPUs.

MCE firmware is responsible for deciding on CPU idle power state
based on state information and MCE firmware background work.

Tegra MCE ARI driver is the interface driver to communicate with
MCE firmware from the kernel.

CPU idle driver passes idle state information to MCE through Tegra
MCE driver and requests idle state transition to MCE happens through
PSCI CPU suspend.

This series includes below patches
- Add CPUIDLE section to MAINTAINERS
- Add Tegra MCE ARI driver to communicate with MCE firmware from kernel
- Add dt-bindings for Tegra194 cpu idle states
- Add cpuidle driver to support Tegra194 CPUs idle state management
- Update Tegra194 device tree with cpuidle support to Tegra194 CPUs.


Sowjanya Komatineni (5):
  MAINTAINERS: Add Tegra CPUIDLE driver section
  firmware: tegra: Add Tegra194 MCE ARI driver
  dt-bindings: arm: Add cpu-idle-states to Tegra194 CPU nodes
  cpuidle: Add Tegra194 cpuidle driver
  arm64: dts: tegra194: Add CPU idle states

 .../bindings/arm/nvidia,tegra194-ccplex.yaml       |  53 ++++
 MAINTAINERS                                        |  12 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |  28 ++
 drivers/cpuidle/Kconfig.arm                        |  10 +
 drivers/cpuidle/Makefile                           |   1 +
 drivers/cpuidle/cpuidle-tegra194.c                 | 319 +++++++++++++++++++++
 drivers/firmware/tegra/Kconfig                     |  11 +
 drivers/firmware/tegra/Makefile                    |   4 +
 drivers/firmware/tegra/mce-tegra194.c              | 155 ++++++++++
 drivers/firmware/tegra/mce.c                       |  88 ++++++
 include/soc/tegra/mce.h                            |  32 +++
 include/soc/tegra/t194_nvg.h                       |  56 ++++
 12 files changed, 769 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-tegra194.c
 create mode 100644 drivers/firmware/tegra/mce-tegra194.c
 create mode 100644 drivers/firmware/tegra/mce.c
 create mode 100644 include/soc/tegra/mce.h
 create mode 100644 include/soc/tegra/t194_nvg.h

-- 
2.7.4

