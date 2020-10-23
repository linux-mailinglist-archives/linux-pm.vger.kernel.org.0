Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA907297273
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750919AbgJWPgv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 11:36:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:53802 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbgJWPgv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 11:36:51 -0400
Received: from 89-64-88-190.dynamic.chello.pl (89.64.88.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id ee32e835f268b9f3; Fri, 23 Oct 2020 17:36:48 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH v2 0/4] cpufreq: intel_pstate: Avoid missing HWP max limit updates with powersave governor
Date:   Fri, 23 Oct 2020 17:21:50 +0200
Message-ID: <2183878.gTFULuzKx9@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

There is a problem in intel_pstate that if it works in the passive mode with
HWP enabled, changing the policy max frequency may not cause the HWP max limit
to be updated accordingly which is quite confusing and may be incorrect.

That happens because of two checks, one in the cpufreq core and one in the
driver itself, that are there to avoid unnecessary HW/FW updates when the
current frequency doesn't change.  Of course, that is the case when the
policy max limit changes under the "powersave" governor (which sets the
current frequency to the policy min limit) and in that particular case,
the checks turn out to be harmful.

There is also an analogous problem in the schedutil governor that prevents
driver callbacks from being invoked if the target frequency doesn't change
and which also affects intel_pstate in the passive mode with HWP enabled
(see the changelog of patch [4/4]).

The v2 addresses some review comments from Viresh and adds patches [3-4/4] to
address the schedutil issue.

The cleanup posted as the [2/2] previously will be applied independently and
it is not included in the v2.

Thanks!



