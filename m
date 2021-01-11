Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964FA2F19E9
	for <lists+linux-pm@lfdr.de>; Mon, 11 Jan 2021 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbhAKPno (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Jan 2021 10:43:44 -0500
Received: from foss.arm.com ([217.140.110.172]:60220 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728633AbhAKPnn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 11 Jan 2021 10:43:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3019B1042;
        Mon, 11 Jan 2021 07:42:58 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.39.85])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC0C23F70D;
        Mon, 11 Jan 2021 07:42:55 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net,
        vireshk@kernel.org, cristian.marussi@arm.com
Cc:     morten.rasmussen@arm.com, chris.redpath@arm.com,
        nicola.mazzucato@arm.com
Subject: [PATCH v6 0/4] CPUFreq: Add support for opp-sharing cpus
Date:   Mon, 11 Jan 2021 15:45:20 +0000
Message-Id: <20210111154524.20196-1-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

In this V6 posting I have addressed comments on reworking the scmi cpufreq
driver in smaller changes.

This is to support systems where exposed cpu performance controls are more
fine-grained that the platform's ability to scale cpus independently.

Many thanks,
Nicola

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

Nicola Mazzucato (3):
  scmi-cpufreq: Remove deferred probe
  scmi-cpufreq: Move CPU initialisation to probe
  scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM

Sudeep Holla (1):
  cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev

 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 drivers/cpufreq/scmi-cpufreq.c       | 196 +++++++++++++++++++++------
 2 files changed, 155 insertions(+), 43 deletions(-)

-- 
2.27.0

