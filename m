Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6AC2DA128
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 21:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503007AbgLNUKw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 15:10:52 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49774 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502867AbgLNUKm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 15:10:42 -0500
Received: from 89-77-60-66.dynamic.chello.pl (89.77.60.66) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id b3bf987f1bf494ed; Mon, 14 Dec 2020 21:09:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: [PATCH v2 0/3] cpufreq: Allow drivers to receive more information from the governor
Date:   Mon, 14 Dec 2020 21:01:52 +0100
Message-ID: <3827230.0GnL3RTcl1@kreacher>
In-Reply-To: <20360841.iInq7taT2Z@kreacher>
References: <20360841.iInq7taT2Z@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The timing of this is not perfect (sorry about that), but here's a refresh
of this series.

The majority of the previous cover letter still applies:

On Monday, December 7, 2020 5:25:38 PM CET Rafael J. Wysocki wrote:
> 
> This is based on the RFC posted a few days ago:
> 
> https://lore.kernel.org/linux-pm/1817571.2o5Kk4Ohv2@kreacher/
> 
>  Using intel_pstate in the passive mode with HWP enabled, in particular under
>  the schedutil governor, is still kind of problematic, because it has to assume
>  that it should not allow the frequency to fall below the one requested by the
>  governor.  For this reason, it translates the target frequency into HWP.REQ.MIN
>  which generally causes the processor to run a bit too fast.
> 
>  Moreover, this allows the HWP algorithm to use any frequency between the target
>  one and HWP.REQ.MAX that corresponds to the policy max limit and some workloads
>  cause it to go for the max turbo frequency prematurely which hurts energy-
>  efficiency without improving performance, even though the schedutil governor
>  itself would not allow the frequency to ramp up so fast.
> 
>  This patch series attempts to improve the situation by introducing a new driver
>  callback allowing the driver to receive more information from the governor.  In
>  particular, this allows the min (required) and target (desired) performance
>  levels to be passed to it and those can be used to give better hints to the
>  hardware.

In this second revision there are three patches (one preparatory patch for
schedutil that hasn't changed since the v1, the introduction of the new
callback and schedutil changes in patch [2/3] and the intel_pstate changes
in patch [3/3] that are the same as before.

Please see patch changelogs for details.

Thanks!



