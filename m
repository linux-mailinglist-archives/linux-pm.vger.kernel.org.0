Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7878A3B468E
	for <lists+linux-pm@lfdr.de>; Fri, 25 Jun 2021 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFYP3A (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Jun 2021 11:29:00 -0400
Received: from foss.arm.com ([217.140.110.172]:58614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFYP3A (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 25 Jun 2021 11:29:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4545F1042;
        Fri, 25 Jun 2021 08:26:39 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.7.232])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 241633F694;
        Fri, 25 Jun 2021 08:26:35 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Chris.Redpath@arm.com, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com, linux-pm@vger.kernel.org, peterz@infradead.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org, mingo@redhat.com,
        juri.lelli@redhat.com, rostedt@goodmis.org, segall@google.com,
        mgorman@suse.de, bristot@redhat.com, CCj.Yeh@mediatek.com
Subject: [PATCH 0/3] Improve EAS energy estimation and increase precision
Date:   Fri, 25 Jun 2021 16:26:00 +0100
Message-Id: <20210625152603.25960-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi all,

The patch set aims to address a scenario for Energy Aware Scheduler,
where we estimate and compare energy values and miss a more precised results.
In some use cases estimations for two CPUs might give the same values
for a given task and it's utilization. Those values would be different
when we have a better precision and avoid this rounding error.
Thus, the decision of choosing a CPU for a waking-up task might also
be better.

We have received this feedback from our partners.

Address this rounding error issue and increase the precision of Energy Model
em_perf_state::cost values. This change should not affect other
subsystems in kernel: thermal IPA, PowerCap DTPM, etc, since they use
em_perf_state::power field, which is not touched. It also doesn't
trigger the need for updating all existing platforms to register EM and report
power values in different scale.

Regards,
Lukasz

Lukasz Luba (3):
  sched/fair: Prepare variables for increased precision of EAS estimated
    energy
  PM: EM: Make em_cpu_energy() able to return bigger values
  PM: EM: Increase energy calculation precision

 include/linux/energy_model.h | 11 +++++++----
 kernel/power/energy_model.c  |  3 ++-
 kernel/sched/fair.c          | 13 +++++++------
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.17.1

