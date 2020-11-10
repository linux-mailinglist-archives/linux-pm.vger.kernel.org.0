Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E442ADCE3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 18:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgKJR2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 12:28:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:48720 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbgKJR2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 12:28:24 -0500
Received: from 89-64-88-129.dynamic.chello.pl (89.64.88.129) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 9ecaaf740a3def68; Tue, 10 Nov 2020 18:28:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH v3 0/4] cpufreq: intel_pstate: Handle powersave governor correctly in the passive mode with HWP
Date:   Tue, 10 Nov 2020 18:21:56 +0100
Message-ID: <11312387.r5AVKgp8zO@kreacher>
In-Reply-To: <13269660.K2JYd4sGFX@kreacher>
References: <13269660.K2JYd4sGFX@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Monday, November 9, 2020 5:49:49 PM CET Rafael J. Wysocki wrote:
> 
> Even after the changes made very recently, the handling of the powersave
> governor is not exactly as expected when intel_pstate operates in the
> "passive" mode with HWP enabled.
> 
> Namely, in that case HWP is not limited to the policy min frequency, but it
> can scale the frequency up to the policy max limit and it cannot be constrained
> currently, because there are no provisions for that in the framework.
> 
> To address that, patches [1-3/4] add a new governor flag to indicate that this
> governor wants the target frequency to be set to the exact value passed to the
> driver, if possible, and change the powersave and performance governors to have
> that flag set.
> 
> The last patch makes intel_pstate take that flag into account when programming
> the HWP Request MSR.

The v3 simply uses different names for the new governor flags.

Thanks!



