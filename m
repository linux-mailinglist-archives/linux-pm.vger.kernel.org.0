Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFF72A7F2A
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 13:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgKEM4g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 07:56:36 -0500
Received: from foss.arm.com ([217.140.110.172]:59964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgKEM4f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Nov 2020 07:56:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E1B6142F;
        Thu,  5 Nov 2020 04:56:35 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DD2823F719;
        Thu,  5 Nov 2020 04:56:33 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org,
        sudeep.holla@arm.com
Cc:     morten.rasmussen@arm.com, jeremy.linton@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com
Subject: [PATCH 0/8] cppc_cpufreq: fix, clarify and improve support
Date:   Thu,  5 Nov 2020 12:55:16 +0000
Message-Id: <20201105125524.4409-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

I found myself staring a bit too much at this driver in the past weeks
and that's likely the cause for me coming up with this series of 8
patches that cleans up, clarifies and reworks parts of it, as follows:

 - patches 1-3/8: trivial clean-up and renaming with the purpose to
                  improve readability
 - patch 4/8: replace previous per-cpu data structures with lists of
              domains and CPUs to get more efficient storage for driver
              data and fix previous issues in case of CPU hotplugging,
              as discussed at [1].
 - patches 5-6/8: a few fixes and clarifications: mostly making sure
                  the behavior described in the comments and debug
                  messages matches the code and there is clear
                  indication of what is supported and how.
 - patch 7/8: use the existing freqdomains_cpus attribute to inform
              the user on frequency domains.
 - patch 8/8: acpi: replace ALL coordination with NONE coordination
                    when errors are find parsing the _PSD domains
              (as described in the comments in the code).

Hopefully you'll find this useful for ease of maintenance and ease of
future development of the driver.

This functionality was tested on a Juno platform with modified _PSD
tables to test the functionality for all currently supported
coordination types: ANY, HW, NONE.

The current code is based on v5.10-rc2.

Thanks,
Ionela.

[1] https://lore.kernel.org/linux-pm/20200922162540.GB796@arm.com/

Ionela Voinescu (8):
  cppc_cpufreq: fix misspelling, code style and readability issues
  cppc_cpufreq: clean up cpu, cpu_num and cpunum variable use
  cppc_cpufreq: simplify use of performance capabilities
  cppc_cpufreq: replace per-cpu structures with lists
  cppc_cpufreq: use policy->cpu as driver of frequency setting
  cppc_cpufreq: clarify support for coordination types
  cppc_cpufreq: expose information on frequency domains
  acpi: fix NONE coordination for domain mapping failure

 .../ABI/testing/sysfs-devices-system-cpu      |   3 +-
 drivers/acpi/cppc_acpi.c                      | 126 +++---
 drivers/acpi/processor_perflib.c              |   2 +-
 drivers/cpufreq/cppc_cpufreq.c                | 358 +++++++++++-------
 include/acpi/cppc_acpi.h                      |  14 +-
 5 files changed, 277 insertions(+), 226 deletions(-)

-- 
2.17.1

