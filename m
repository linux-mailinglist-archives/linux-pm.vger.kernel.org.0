Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B30BDC2DC
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 12:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408235AbfJRKiU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 06:38:20 -0400
Received: from [217.140.110.172] ([217.140.110.172]:34194 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1729479AbfJRKiU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 06:38:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB310AB6;
        Fri, 18 Oct 2019 03:37:59 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DFF8B3F6C4;
        Fri, 18 Oct 2019 03:37:58 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: [PATCH v3 0/5] cpufreq: merge arm big.LITTLE and vexpress-spc drivers
Date:   Fri, 18 Oct 2019 11:37:44 +0100
Message-Id: <20191018103749.11226-1-sudeep.holla@arm.com>
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

v2->v3:
	- Added Nico's ack
	- Added back blank lines and extra braces as suggested by Viresh
	- Updated copyright year correctly

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
 ...rm_big_little.c => vexpress-spc-cpufreq.c} | 244 +++++++-----------
 6 files changed, 92 insertions(+), 216 deletions(-)
 delete mode 100644 drivers/cpufreq/arm_big_little.h
 rename drivers/cpufreq/{arm_big_little.c => vexpress-spc-cpufreq.c} (68%)

--
2.17.1

