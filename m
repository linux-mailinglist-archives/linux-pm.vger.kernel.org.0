Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0192E2CC378
	for <lists+linux-pm@lfdr.de>; Wed,  2 Dec 2020 18:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389044AbgLBRWy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Dec 2020 12:22:54 -0500
Received: from foss.arm.com ([217.140.110.172]:45626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388999AbgLBRWx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Dec 2020 12:22:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71A541396;
        Wed,  2 Dec 2020 09:22:07 -0800 (PST)
Received: from ubuntu.arm.com (unknown [10.57.34.77])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37F543F575;
        Wed,  2 Dec 2020 09:22:05 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com
Cc:     daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, nicola.mazzucato@arm.com
Subject: [PATCH v4 0/4] CPUFreq: Add support for opp-sharing cpus
Date:   Wed,  2 Dec 2020 17:23:52 +0000
Message-Id: <20201202172356.10508-1-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

In this V4 posting I have fixed suggestions on opp/of and have added the
implementation for scmi-cpufreq driver.

This is to support systems where exposed cpu performance controls are more
fine-grained that the platform's ability to scale cpus independently.

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
  dt-bindings/opp: Update documentation for opp-shared
  opp/of: Allow empty opp-table with opp-shared
  scmi-cpufreq: get opp_shared_cpus from opp-v2 for EM

Sudeep Holla (1):
  cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev

 Documentation/devicetree/bindings/opp/opp.txt | 53 +++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c          |  2 +
 drivers/cpufreq/scmi-cpufreq.c                | 51 ++++++++++++------
 drivers/opp/of.c                              |  7 ++-
 4 files changed, 95 insertions(+), 18 deletions(-)

[1] https://lore.kernel.org/linux-pm/20201124104346.27167-1-lukasz.luba@arm.com/

-- 
2.27.0

