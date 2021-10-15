Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC85B42F608
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbhJOOsI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 10:48:08 -0400
Received: from foss.arm.com ([217.140.110.172]:44030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240697AbhJOOsH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Oct 2021 10:48:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4818014BF;
        Fri, 15 Oct 2021 07:46:01 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.23.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4803D3F66F;
        Fri, 15 Oct 2021 07:45:58 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Subject: [PATCH v2 0/5] Refactor thermal pressure update to avoid code duplication
Date:   Fri, 15 Oct 2021 15:45:45 +0100
Message-Id: <20211015144550.23719-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This patch set v2 aims to refactor the thermal pressure update
code. There are already two clients which do similar thing:
convert the capped frequency value into the capacity of
affected CPU and call the 'set' function to store the 
reduced capacity into the per-cpu variable.
There might be more than two of these users. In near future
it will be scmi-cpufreq driver, which receives notification
from FW about reduced frequency due to thermal. Other vendors
might follow. Let's avoid code duplication and potential
conversion bugs. Move the conversion code into the arch_topology.c
where the capacity calculation setup code and thermal pressure sit.

Apart from that $subject patches, there is one patch (3/5) which fixes
issue in qcom-cpufreq-hw.c when the thermal pressure is not 
updated for offline CPUs. It's similar fix that has been merged
recently for cpufreq_cooling.c:
2ad8ccc17d1e4270cf65a3f2

Changes:
v2:
- added Reviewed-by from Thara for patch 3/5
- changed the doxygen comment and used mult_frac()
  according to Thara's suggestion in patch 1/5
v1 -> [1]

Regards,
Lukasz Luba

[1] https://lore.kernel.org/linux-pm/20211007080729.8262-1-lukasz.luba@arm.com/

Lukasz Luba (5):
  arch_topology: Introduce thermal pressure update function
  thermal: cpufreq_cooling: Use new thermal pressure update function
  cpufreq: qcom-cpufreq-hw: Update offline CPUs per-cpu thermal pressure
  cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function
  arch_topology: Remove unused topology_set_thermal_pressure() and
    related

 arch/arm/include/asm/topology.h   |  2 +-
 arch/arm64/include/asm/topology.h |  2 +-
 drivers/base/arch_topology.c      | 35 +++++++++++++++++++++++++++----
 drivers/cpufreq/qcom-cpufreq-hw.c | 14 +++++--------
 drivers/thermal/cpufreq_cooling.c |  6 +-----
 include/linux/arch_topology.h     |  4 ++--
 include/linux/sched/topology.h    |  6 +++---
 init/Kconfig                      |  2 +-
 8 files changed, 45 insertions(+), 26 deletions(-)

-- 
2.17.1

