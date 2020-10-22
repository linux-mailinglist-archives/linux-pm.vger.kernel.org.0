Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7D295DDA
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 13:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897721AbgJVL56 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 07:57:58 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49644 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897699AbgJVL56 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 07:57:58 -0400
Received: from 89-64-87-167.dynamic.chello.pl (89.64.87.167) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.491)
 id c2ae5f4a621278e0; Thu, 22 Oct 2020 13:57:55 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/2] cpufreq: intel_pstate: Avoid missing HWP max limit updates with powersave governor
Date:   Thu, 22 Oct 2020 13:55:13 +0200
Message-ID: <1666263.spd1I39WAV@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi All,

There is a problem in intel_pstate that if it works in the passive mode with
HWP enabled and the "powersave" governor is used on top of it, then changing
the policy max frequency doesn't cause the HWP max limit to be updated which
is quite confusing.

That happens because of two checks, one in the cpufreq core and one in the
driver itself, that are there to avoid unnecessary HW/FW updates when the
current frequency doesn't change.  Of course, that is the case when the
policy max limit changes under the "powersave" governor (which sets the
current frequency to the policy min limit), but in that particular case,
the checks turn out to be harmful.  This is dealt with by the first patch.

The second one is an optimization that can be done right away on top of the
first one.

Thanks!



