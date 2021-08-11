Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F153E9980
	for <lists+linux-pm@lfdr.de>; Wed, 11 Aug 2021 22:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhHKUPH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Aug 2021 16:15:07 -0400
Received: from foss.arm.com ([217.140.110.172]:57854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhHKUPG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Aug 2021 16:15:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A77C13A1;
        Wed, 11 Aug 2021 13:14:42 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C5D753F40C;
        Wed, 11 Aug 2021 13:14:40 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 0/2] cpu_pm: cpu_pm_notifier_chain vs PREEMPT_RT
Date:   Wed, 11 Aug 2021 21:14:30 +0100
Message-Id: <20210811201432.1976916-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi folks,

This is v3 of:

  http://lore.kernel.org/r/20210811131405.1731576-1-valentin.schneider@arm.com

which addresses cpu_pm's notifier chain not playing nice with PREEMPT_RT.

Revisions
=========

v1 -> v2
++++++++

o Reword changelog; clarify comments (Sebastian)
o Delete atomic_notifier_call_chain_robust() (Sebastian)

Valentin Schneider (2):
  cpu_pm: Make notifier chain use a raw_spinlock_t
  notifier: Remove atomic_notifier_call_chain_robust()

 include/linux/notifier.h |  2 --
 kernel/cpu_pm.c          | 50 ++++++++++++++++++++++++++++++----------
 kernel/notifier.c        | 19 ---------------
 3 files changed, 38 insertions(+), 33 deletions(-)

-- 
2.25.1

