Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8116839B49F
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 10:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhFDIL5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 04:11:57 -0400
Received: from foss.arm.com ([217.140.110.172]:60448 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhFDIL5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Jun 2021 04:11:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E49621063;
        Fri,  4 Jun 2021 01:10:10 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.3.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C5713F719;
        Fri,  4 Jun 2021 01:10:05 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        qperret@google.com, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, lukasz.luba@arm.com,
        Beata.Michalska@arm.com, mingo@redhat.com, juri.lelli@redhat.com,
        rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
        bristot@redhat.com
Subject: [PATCH v2 0/2] Add allowed CPU capacity knowledge to EAS
Date:   Fri,  4 Jun 2021 09:09:52 +0100
Message-Id: <20210604080954.13915-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The patch set v2 aims to add knowledge about reduced CPU capacity
into the Energy Model (EM) and Energy Aware Scheduler (EAS). Currently the
issue is that SchedUtil CPU frequency and EM frequency are not aligned,
when there is a CPU thermal capping. This causes an estimation error.
This patch set provides the information about allowed CPU capacity
into the EM (thanks to thermal pressure signal). This improves the
energy estimation. More info about this mechanism can be found in the
patches comments.

Changelog:
v2:
- clamp the returned value from effective_cpu_util() and avoid irq
  util scaling issues (Quentin)
v1 is available at [1]

Regards,
Lukasz

[1] https://lore.kernel.org/linux-pm/20210602135609.10867-1-lukasz.luba@arm.com/

Lukasz Luba (2):
  sched/fair: Take thermal pressure into account while estimating energy
  sched/cpufreq: Consider reduced CPU capacity in energy calculation

 include/linux/energy_model.h     | 16 +++++++++++++---
 include/linux/sched/cpufreq.h    |  2 +-
 kernel/sched/cpufreq_schedutil.c |  1 +
 kernel/sched/fair.c              | 19 +++++++++++++++----
 4 files changed, 30 insertions(+), 8 deletions(-)

-- 
2.17.1

