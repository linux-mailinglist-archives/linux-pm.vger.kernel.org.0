Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2083398B28
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 15:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhFBN6U (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 09:58:20 -0400
Received: from foss.arm.com ([217.140.110.172]:45358 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhFBN6U (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Jun 2021 09:58:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 701DF1042;
        Wed,  2 Jun 2021 06:56:36 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.1.174])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D1BF3F73D;
        Wed,  2 Jun 2021 06:56:32 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, vincent.guittot@linaro.org,
        qperret@google.com, dietmar.eggemann@arm.com,
        vincent.donnefort@arm.com, lukasz.luba@arm.com, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com
Subject: [PATCH 0/2] Add allowed CPU capacity knowledge to EAS
Date:   Wed,  2 Jun 2021 14:56:07 +0100
Message-Id: <20210602135609.10867-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

This is a patch set which aims to add knowledge about reduced CPU capacity
into the Energy Model (EM) and Energy Aware Scheduler (EAS). Currently the
issue is that SchedUtil CPU frequency and EM frequency are not aligned,
when there is a CPU thermal capping. This causes an estimation error.
This patch set provides the information about allowed CPU capacity
into the EM (thanks to thermal pressure signal). This improves the
energy estimation. More info about this mechanism can be found in the
patches comments.

Regards,
Lukasz

Lukasz Luba (2):
  sched/fair: Take thermal pressure into account while estimating energy
  sched/cpufreq: Consider reduced CPU capacity in energy calculation

 include/linux/energy_model.h     | 16 +++++++++++++---
 include/linux/sched/cpufreq.h    |  2 +-
 kernel/sched/cpufreq_schedutil.c |  1 +
 kernel/sched/fair.c              | 13 +++++++++++--
 4 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.17.1

