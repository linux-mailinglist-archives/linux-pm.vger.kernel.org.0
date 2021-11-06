Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72DE446BD1
	for <lists+linux-pm@lfdr.de>; Sat,  6 Nov 2021 02:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhKFBgl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 21:36:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:54624 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231987AbhKFBgk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 21:36:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10159"; a="212059582"
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="212059582"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 18:33:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,212,1631602800"; 
   d="scan'208";a="502194819"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2021 18:33:57 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: [PATCH 0/7] Thermal: Introduce the Hardware Feedback Interface for thermal and performance management
Date:   Fri,  5 Nov 2021 18:33:05 -0700
Message-Id: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Intel Hardware Feedback Interface (HFI) [1] provides information about
the performance and energy efficiency of each CPU in the system. It uses a
table that is shared between hardware and the operating system. The
contents of the table may be updated as a result of changes in the
operating conditions of the system (e.g., reaching a thermal limit) or the
action of external factors (e.g., changes in the thermal design power).

The information that HFI provides are specified as numeric, unit-less
capabilities relative to other CPUs in the system. These capabilities have
a range of [0-255] where higher numbers represent higher capabilities.
Energy efficiency and performance are reported in separate capabilities.
If either the performance or energy capabilities efficiency of a CPU are 0,
the hardware recommends to not schedule any tasks on such CPU for
performance, energy efficiency or thermal reasons, respectively.

The kernel or user space may use the information from the HFI to modify
task placement and/or adjust power limits. This patchset focuses on the
user space. The thermal notification framework is extended to relay
updates of CPU capacity. Thus, a userspace daemon can affinitize workloads
to certain CPUs and/or offline CPUs whose capabilities are zero.

The frequency of HFI updates is specific to each processor model. On some
systems, there is just a single HFI update at boot. On other systems, there
may be updates every tens of milliseconds. In order to not overwhelm
userspace with too many updates, they are limited to one update every
CONFIG_HZ jiffies.

Thanks and BR,
Ricardo

[1]. https://www.intel.com/sdm

Ricardo Neri (5):
  x86/Documentation: Describe the Intel Hardware Feedback Interface
  x86: Add definitions for the Intel Hardware Feedback Interface
  thermal: intel: hfi: Minimally initialize the Hardware Feedback
    Interface
  thermal: intel: hfi: Handle CPU hotplug events
  thermal: intel: hfi: Enable notification interrupt

Srinivas Pandruvada (2):
  thermal: netlink: Add a new event to notify CPU capabilities change
  thermal: intel: hfi: Notify user space for HFI events

 Documentation/x86/index.rst         |   1 +
 Documentation/x86/intel-hfi.rst     |  68 ++++
 arch/x86/include/asm/cpufeatures.h  |   1 +
 arch/x86/include/asm/msr-index.h    |   6 +
 drivers/thermal/intel/Kconfig       |  13 +
 drivers/thermal/intel/Makefile      |   1 +
 drivers/thermal/intel/intel_hfi.c   | 508 ++++++++++++++++++++++++++++
 drivers/thermal/intel/intel_hfi.h   |  40 +++
 drivers/thermal/intel/therm_throt.c |  21 ++
 drivers/thermal/thermal_netlink.c   |  52 +++
 drivers/thermal/thermal_netlink.h   |  13 +
 include/uapi/linux/thermal.h        |   6 +-
 12 files changed, 729 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/x86/intel-hfi.rst
 create mode 100644 drivers/thermal/intel/intel_hfi.c
 create mode 100644 drivers/thermal/intel/intel_hfi.h

-- 
2.17.1

