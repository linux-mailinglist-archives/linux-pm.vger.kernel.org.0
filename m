Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D9B2A8611
	for <lists+linux-pm@lfdr.de>; Thu,  5 Nov 2020 19:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgKESZX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Nov 2020 13:25:23 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61274 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKESZW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 13:25:22 -0500
Received: from 89-64-88-191.dynamic.chello.pl (89.64.88.191) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.514)
 id 64633fd2ce86f13d; Thu, 5 Nov 2020 19:25:20 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] cpufreq: intel_pstate: Handle powersave governor correctly in the passive mode with HWP
Date:   Thu, 05 Nov 2020 19:17:54 +0100
Message-ID: <7417968.Ghue05m4RV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Even after the changes made very recently, the handling of the powersave
governor is not exactly as expected when intel_pstate operates in the
"passive" mode with HWP enabled.

Namely, in that case HWP is not limited to the policy min frequency, but it
can scale the frequency up to the policy max limit and it cannot be constrained
currently, because the governor has no way to tell the driver how much room
there is for adjustments around the target frequency passed to it.

For this reason, patch [1/2] introduces new policy parameters, target_min and
target_max, that can be used by the governor to pass that information to the
driver and modifies the powersave and peformance governors to use them.

Patch [2/2] modifies intel_pstate to take them into account so as to fix the
powersave governor issue, but they may be applicable for other purposes in the
future (eg. if the driver is updated to pass the "desired" P-state to the HWP
logic instead of just setting the HWP floor to the target one, both the
powersave and performance governors will need target_min and target_max to
basically work as documented).

Thanks!



