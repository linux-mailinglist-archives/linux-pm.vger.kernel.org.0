Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A529EDAC5D
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502390AbfJQMff (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:35:35 -0400
Received: from [217.140.110.172] ([217.140.110.172]:41462 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfJQMfe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 08:35:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A0131993;
        Thu, 17 Oct 2019 05:35:14 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A84693F718;
        Thu, 17 Oct 2019 05:35:13 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: [PATCH v2 0/5] cpufreq: merge arm big.LITTLE and vexpress-spc drivers
Date:   Thu, 17 Oct 2019 13:35:03 +0100
Message-Id: <20191017123508.26130-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Since vexpress-spc is the sole user of arm_big_little cpufreq driver,
there's no point in keeping it separate anymore. I wanted to post these
patches for ages but kept postponing for no reason.

Regards,
Sudeep

v1->v2:
	- generated the patch using -B that helps to keep delta short
	  for review
	- Split the last patch into 3 different patches to deal with
	  removing bL_ops, debug messages and other code formatting
	  separately

Sudeep Holla (5):
  cpufreq: scpi: remove stale/outdated comment about the driver
  cpufreq: merge arm_big_little and vexpress-spc
  cpufreq: vexpress-spc: drop unnessary cpufreq_arm_bL_ops abstraction
  cpufreq: vexpress-spc: remove lots of debug messages
  cpufreq: vexpress-spc: fix some coding style issues

 MAINTAINERS                                   |   5 +-
 drivers/cpufreq/Kconfig.arm                   |  12 +-
 drivers/cpufreq/Makefile                      |   2 -
 drivers/cpufreq/arm_big_little.h              |  43 ---
 drivers/cpufreq/scpi-cpufreq.c                |   2 -
 ...rm_big_little.c => vexpress-spc-cpufreq.c} | 254 ++++++------------
 6 files changed, 93 insertions(+), 225 deletions(-)
 delete mode 100644 drivers/cpufreq/arm_big_little.h
 rename drivers/cpufreq/{arm_big_little.c => vexpress-spc-cpufreq.c} (68%)

--
2.17.1

