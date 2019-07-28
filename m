Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 992B577F9C
	for <lists+linux-pm@lfdr.de>; Sun, 28 Jul 2019 15:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfG1NbJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Jul 2019 09:31:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59088 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfG1NbJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Jul 2019 09:31:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D830B8021E; Sun, 28 Jul 2019 15:30:55 +0200 (CEST)
Date:   Sun, 28 Jul 2019 15:31:02 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        daniel.lezcano@linaro.org, subhra.mazumdar@oracle.com
Subject: Re: [RFC v4 0/8] TurboSched: A scheduler for sustaining Turbo
 Frequencies for longer durations
Message-ID: <20190728133102.GD8718@xo-6d-61-c0.localdomain>
References: <20190725070857.6639-1-parth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725070857.6639-1-parth@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

> Abstract
> ========
> 
> The modern servers allows multiple cores to run at range of frequencies
> higher than rated range of frequencies. But the power budget of the system
> inhibits sustaining these higher frequencies for longer durations.

Thermal budget?

Should this go to documentation somewhere?

> Current CFS algorithm in kernel scheduler is performance oriented and hence
> tries to assign any idle CPU first for the waking up of new tasks. This
> policy is perfect for major categories of the workload, but for jitter
> tasks, one can save energy by packing them onto the active cores and allow
> those cores to run at higher frequencies.
> 
> These patch-set tunes the task wake up logic in scheduler to pack
> exclusively classified jitter tasks onto busy cores. The work involves the
> jitter tasks classifications by using syscall based mechanisms.
> 
> In brief, if we can pack jitter tasks on busy cores then we can save power
> by keeping other cores idle and allow busier cores to run at turbo
> frequencies, patch-set tries to meet this solution in simplest manner.
> Though, there are some challenges in implementing it(like smt_capacity,

Space before (.

> These numbers are w.r.t. `turbo_bench.c` multi-threaded test benchmark
> which can create two kinds of tasks: CPU bound (High Utilization) and
> Jitters (Low Utilization). N in X-axis represents N-CPU bound and N-Jitter
> tasks spawned.

Ok, so you have description how it causes 13% improvements. Do you also have metrics how
it harms performance.. how much delay is added to unimportant tasks etc...?

Thanks,
										Pavel
