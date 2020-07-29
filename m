Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A434232150
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgG2PMY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 11:12:24 -0400
Received: from foss.arm.com ([217.140.110.172]:53378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgG2PMV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 11:12:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9AE330E;
        Wed, 29 Jul 2020 08:12:20 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 95EB63F66E;
        Wed, 29 Jul 2020 08:12:18 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        viresh.kumar@linaro.org, lukasz.luba@arm.com, rjw@rjwysocki.net
Subject: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Date:   Wed, 29 Jul 2020 16:12:04 +0100
Message-Id: <20200729151208.27737-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The existing CPUFreq framework does not tracks the statistics when the
'fast switch' is used or when firmware changes the frequency independently
due to e.g. thermal reasons. However, the firmware might track the frequency
changes and expose this to the kernel.

This patch set aims to introduce CPUfreq statistics gathered by firmware
and retrieved by CPUFreq driver. It would require a new API functions
in the CPUFreq, which allows to poke drivers to get these stats.

The needed CPUFreq infrastructure is in patch 1/4, patch 2/4 extends
ARM SCMI protocol layer, patches 3/4, 4/4  modify ARM SCMI CPUFreq driver.

Regards,
Lukasz Luba

Lukasz Luba (4):
  cpufreq: Add support for statistics read from drivers
  scmi: perf: Extend protocol to support performance statistics
  cpufreq: scmi: Move scmi_cpufreq_driver structure to the top
  cpufreq: scmi: Read statistics from FW shared memory

 drivers/cpufreq/cpufreq.c        |  22 ++++
 drivers/cpufreq/cpufreq_stats.c  |  38 +++---
 drivers/cpufreq/scmi-cpufreq.c   | 116 ++++++++++++++---
 drivers/firmware/arm_scmi/perf.c | 210 +++++++++++++++++++++++++++++++
 include/linux/cpufreq.h          |  32 +++++
 include/linux/scmi_protocol.h    |  11 ++
 6 files changed, 401 insertions(+), 28 deletions(-)

-- 
2.17.1

