Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785FE2C8D00
	for <lists+linux-pm@lfdr.de>; Mon, 30 Nov 2020 19:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388156AbgK3Sjv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Nov 2020 13:39:51 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46014 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388112AbgK3Sju (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2020 13:39:50 -0500
Received: from 89-64-87-210.dynamic.chello.pl (89.64.87.210) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.530)
 id 1d25a2f50d092b2e; Mon, 30 Nov 2020 19:39:08 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Subject: [RFC][PATCH 0/2] cpufreq: Allow drivers to receive more information from the governor
Date:   Mon, 30 Nov 2020 19:33:49 +0100
Message-ID: <1817571.2o5Kk4Ohv2@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Using intel_pstate in the passive mode with HWP enabled, in particular under
the schedutil governor, is still kind of problematic, because it has to assume
that it should not allow the frequency to fall below the one requested by the
governor.  For this reason, it translates the target frequency into HWP.REQ.MIN
which generally causes the processor to run a bit too fast.

Moreover, this allows the HWP algorithm to use any frequency between the target
one and HWP.REQ.MAX that corresponds to the policy max limit and some workloads
cause it to go for the max turbo frequency prematurely which hurts energy-
efficiency without improving performance, even though the schedutil governor
itself would not allow the frequency to ramp up so fast.

This patch series attempts to improve the situation by introducing a new driver
callback allowing the driver to receive more information from the governor.  In
particular, this allows the min (required) and target (desired) performance
levels to be passed to it and those can be used to give better hints to the
hardware.

Patch [1/2] updates the core and the schedutil governor and patch [2/2] modifies
intel_pstate to use the new callback when appropriate.

Please refer to the patch changelogs for details.

Thanks!



