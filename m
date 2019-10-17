Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B956CDAC5B
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 14:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393274AbfJQMfc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 08:35:32 -0400
Received: from [217.140.110.172] ([217.140.110.172]:41474 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727291AbfJQMfc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Oct 2019 08:35:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFD201BC0;
        Thu, 17 Oct 2019 05:35:15 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDF7F3F718;
        Thu, 17 Oct 2019 05:35:14 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: [PATCH v2 1/5] cpufreq: scpi: remove stale/outdated comment about the driver
Date:   Thu, 17 Oct 2019 13:35:04 +0100
Message-Id: <20191017123508.26130-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191017123508.26130-1-sudeep.holla@arm.com>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 343a8d17fa8d ("cpufreq: scpi: remove arm_big_little dependency")
removed the arm_big_little dependency from scpi driver and doesn't
provide any ops to arm_big_little cpufreq driver. Lets remove that
stale comment.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scpi-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 2b51e0718c9f..20d1f85d5f5a 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -1,8 +1,6 @@
 /*
  * System Control and Power Interface (SCPI) based CPUFreq Interface driver
  *
- * It provides necessary ops to arm_big_little cpufreq driver.
- *
  * Copyright (C) 2015 ARM Ltd.
  * Sudeep Holla <sudeep.holla@arm.com>
  *
-- 
2.17.1

