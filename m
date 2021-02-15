Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA47131B5B7
	for <lists+linux-pm@lfdr.de>; Mon, 15 Feb 2021 08:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhBOHtw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Feb 2021 02:49:52 -0500
Received: from foss.arm.com ([217.140.110.172]:60422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhBOHtw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Feb 2021 02:49:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76CF8101E;
        Sun, 14 Feb 2021 23:49:05 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.16.99])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A13F93F40C;
        Sun, 14 Feb 2021 23:49:03 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        ionela.voinescu@arm.com, nicola.mazzucato@arm.com
Subject: [PATCH v7 0/3] CPUFreq: Add support for opp-sharing cpus
Date:   Mon, 15 Feb 2021 07:51:36 +0000
Message-Id: <20210215075139.30772-1-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

In this V7 posting I have reworked the CPUFreq scmi driver in a different
way as suggested in v6.
Essentially I believe it is more efficient to keep the support for opp-shared
in the _init() stage, rather than moving everything to _probe(), storing
whatever is required and reuse it only once in _init().
The reasons for this are:
- scmi-cpufreq has no init cases that would require a deferred probe.
- therefore, moving the all the cpus initialisation to probe, whilst possible,
  will result in a waste of memory, since we need to store cpumask and
  freq_table only for them to be reused just once later on at init.
- it does not appear to be functional justification for moving the init code
  to probe, which results in unnecessary overhead for both coding and review.
- this change is much smaller and only one patch required (1 file changed,
  52 insertions, 20 deletions) compared to a version where we first move init
  code to _probe and later add support for opp-v2 (2 patches, 1 file changed,
  194+34 insertions, 44+9 deletions, version with a linked list).
- this v7 implementation is much easier to maintain.

Many thanks,
Nicola

[v7]
  * Bring back common stuff for CPUs from _init stage to _probe
  * Remove patch "scmi-cpufreq: Move CPU initialisation to probe"

This v7 is based on Linux 5.11-rc6

[v6]
  * Remove deferred probe, not occurring
  * Move common stuff for CPUs from _init stage to _probe

This V6 is rebased on next-20210111

[v5]
  * Rework documentation of opp-shared within OPP node
  * Register EM only for the first CPU within cpumask in driver
  * Add check for nr_opp in driver before registering EM
  * Add comments on both dev_pm_opp_get_opp_count in driver
  * Remove redundant ret=0 in driver

This v5 is rebased on top of:
next-20201208 + Lukasz Luba's patches [1]

[v4]
  * Remove unconditional set of opp_table->shared_opp to exclusive
  * Add implementation for scmi-cpufreq
  * Change subject

These patches are on top of:
next-20201201 + Lukasz Luba's patches (waiting for Rafael) [1]

[v3]
  * Remove proposal for new 'cpu-performance-dependencies' as we instead
    can reuse the opp table.
  * Update documentation for devicetree/bindings/opp
  * Minor changes within opp to support empty opp table
  * Rework the RFC by adding a second proposal

[v2]
  * Fix errors when running make dt_binding_check
  * Improve commit message description for the dt-binding
  * Add RFC for implementation in cpufreq-core and one of its
    drivers.

Nicola Mazzucato (2):
  scmi-cpufreq: Remove deferred probe
  scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM

Sudeep Holla (1):
  cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev

 drivers/cpufreq/cpufreq-dt-platdev.c |  2 +
 drivers/cpufreq/scmi-cpufreq.c       | 70 +++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 18 deletions(-)

-- 
2.27.0

