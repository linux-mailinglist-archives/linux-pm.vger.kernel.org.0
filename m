Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021CE11297A
	for <lists+linux-pm@lfdr.de>; Wed,  4 Dec 2019 11:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfLDKqU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Dec 2019 05:46:20 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57260 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbfLDKqU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Dec 2019 05:46:20 -0500
Received: from 79.184.254.100.ipv4.supernova.orange.pl (79.184.254.100) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 3362c46b8c575e9d; Wed, 4 Dec 2019 11:46:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Artur =?utf-8?B?xZp3aWdvxYQ=?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 0/2] PM / devfreq: Add dev_pm_qos support with minimal changes
Date:   Wed, 04 Dec 2019 11:46:17 +0100
Message-ID: <5794906.l6Fuony6qs@kreacher>
In-Reply-To: <cover.1574179738.git.leonard.crestez@nxp.com>
References: <cover.1574179738.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, November 19, 2019 5:12:12 PM CET Leonard Crestez wrote:
> Add dev_pm_qos notifiers to devfreq core in order to support frequency
> limits via dev_pm_qos_add_request.
> 
> Unlike the rest of devfreq the dev_pm_qos frequency is measured in kHz,
> this is consistent with current dev_pm_qos usage for cpufreq and
> allows frequencies above 2Ghz (pm_qos expresses limits as s32).
> 
> Like with cpufreq the handling of min_freq/max_freq is moved to the
> dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
> store, instead all values can be written and we only check against OPPs in a
> new devfreq_get_freq_range function. This is consistent with the design of
> dev_pm_qos.
> 
> Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
> need to take devfreq->lock, this means that calls into dev_pm_qos while holding
> devfreq->lock are not allowed (lockdep warns about possible deadlocks).
> 
> Fix this by only adding the qos request and notifiers after devfreq->lock is
> released inside devfreq_add_device. In theory this means sysfs writes
> are possible before the min/max requests are initialized so we guard
> against that explictly. The dev_pm_qos_update_request function would
> otherwise print a big WARN splat.
> 
> Alternatively devfreq initialization could be refactored to avoid taking
> devfreq->lock but that requires several intricate changes:
> 
> 	https://patchwork.kernel.org/cover/11242865/
> 
> I considered making dev_pm_qos call notifiers outside the lock but
> that's another complex refactoring and it's difficult to ensure
> correctness. If two identical qos requests are made in parallel then the
> second shouldn't return until all notifiers are completely executed for
> the first and QOS is enforced; otherwise it mostly defeats the purpose
> of making proactive requests.
> 
> This series implements the minimal changes in order to implement dev_pm_qos
> support for devfreq. It only costs a little defensive programming.
> 
> This series is also marked as [RFC] because it depends on restoring
> DEV_PM_QOS_MIN/MAX_FREQUENCY inside the pm core:
> 
> 	https://patchwork.kernel.org/cover/11250413/
> 
> ---
> Changes since "big version" v10:
> * Drop accepted cleanups
> * Work with current locking approach (split cleanups into other series)
> * Drop acks and deliberately relabel as a new series. It still incorporates
> most previous discussion but takes a different approach to locking.
> * Don't print errors if devfreq_dev_release is called on error cleanup from
> devfreq_add_device, just accept that requests and notifiers might not be
> registered yet. I wish dev_pm_qos cleanups behaved like standard "kfree" and
> silently did nothing when there's nothing to be done.
> Link to v10: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=196443
> 
> Leonard Crestez (2):
>   PM / devfreq: Add PM QoS support
>   PM / devfreq: Use PM QoS for sysfs min/max_freq
> 
>  drivers/devfreq/devfreq.c | 151 ++++++++++++++++++++++++++++++++++----
>  include/linux/devfreq.h   |  14 +++-
>  2 files changed, 145 insertions(+), 20 deletions(-)

Please resend this series as non-RFC with the ACKs from Chanwoo included.

It may still be viable to push it for 5.5 during the -rc period.

Thanks!



