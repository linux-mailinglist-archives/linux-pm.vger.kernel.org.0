Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5672D3150
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgLHRmK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 12:42:10 -0500
Received: from foss.arm.com ([217.140.110.172]:52378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgLHRmK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 12:42:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 378C21FB;
        Tue,  8 Dec 2020 09:41:24 -0800 (PST)
Received: from ubuntu.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 04A0A3F68F;
        Tue,  8 Dec 2020 09:41:21 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com
Cc:     daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, nicola.mazzucato@arm.com
Subject: [PATCH v5 0/4] CPUFreq: Add support for opp-sharing cpus
Date:   Tue,  8 Dec 2020 17:42:25 +0000
Message-Id: <20201208174229.24323-1-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

In this V5 posting I have addressed suggestions on opp/of and scmi-cpufreq
driver.

This is to support systems where exposed cpu performance controls are more
fine-grained that the platform's ability to scale cpus independently.

Many thanks,
Nicola

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
  dt-bindings: opp: Allow empty OPP tables
  opp/of: Allow empty opp-table with opp-shared
  scmi-cpufreq: get opp_shared_cpus from opp-v2 for EM

Sudeep Holla (1):
  cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev

 Documentation/devicetree/bindings/opp/opp.txt | 54 ++++++++++++++-
 drivers/cpufreq/cpufreq-dt-platdev.c          |  2 +
 drivers/cpufreq/scmi-cpufreq.c                | 69 ++++++++++++++-----
 drivers/opp/of.c                              |  7 +-
 4 files changed, 110 insertions(+), 22 deletions(-)

[1] https://lore.kernel.org/linux-pm/20201124104346.27167-1-lukasz.luba@arm.com/

-- 
2.27.0

