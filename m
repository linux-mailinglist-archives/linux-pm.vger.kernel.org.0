Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1D2113F02
	for <lists+linux-pm@lfdr.de>; Thu,  5 Dec 2019 11:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfLEKFX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 5 Dec 2019 05:05:23 -0500
Received: from inva020.nxp.com ([92.121.34.13]:36560 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfLEKFX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 5 Dec 2019 05:05:23 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 737121A0B7E;
        Thu,  5 Dec 2019 11:05:21 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 669EE1A04CC;
        Thu,  5 Dec 2019 11:05:21 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DC8A2047A;
        Thu,  5 Dec 2019 11:05:20 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] PM / devfreq: Add dev_pm_qos support
Date:   Thu,  5 Dec 2019 12:05:05 +0200
Message-Id: <cover.1575540224.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dev_pm_qos notifiers to devfreq core in order to support frequency
limits via dev_pm_qos_add_request.

Unlike the rest of devfreq the dev_pm_qos frequency is measured in kHz,
this is consistent with current dev_pm_qos usage for cpufreq and
allows frequencies above 2Ghz (pm_qos expresses limits as s32).

Like with cpufreq the handling of min_freq/max_freq is moved to the
dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
store, instead all values can be written and we only check against OPPs in a
new devfreq_get_freq_range function. This is consistent with the design of
dev_pm_qos.

Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
need to take devfreq->lock, this means that calls into dev_pm_qos while holding
devfreq->lock are not allowed (lockdep warns about possible deadlocks).

Fix this by only adding the qos request and notifiers after devfreq->lock is
released inside devfreq_add_device. In theory this means sysfs writes
are possible before the min/max requests are initialized so we guard
against that explictly. The dev_pm_qos_update_request function would
otherwise print a big WARN splat.

This series depends on recently accepted series restoring
DEV_PM_QOS_MIN/MAX_FREQUENCY inside the pm core:

	https://patchwork.kernel.org/cover/11262633/

It would be great for this to get into 5.5-rc1

---
Changes since RFC v1:
* Trim cover letter
* Drop RFC since DEV_PM_QOS_MIN/MAX_FREQUENCY was restored
* Collect Acks.
* No code changes
Link to v1: https://patchwork.kernel.org/cover/11252415/

Changes since "big version" v10:
* Drop accepted cleanups
* Work with current locking approach (split cleanups into other series)
* Drop acks and deliberately relabel as a new series. It still incorporates
most previous discussion but takes a different approach to locking.
* Don't print errors if devfreq_dev_release is called on error cleanup from
devfreq_add_device, just accept that requests and notifiers might not be
registered yet. I wish dev_pm_qos cleanups behaved like standard "kfree" and
silently did nothing when there's nothing to be done.
Link to v10: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=196443

Leonard Crestez (2):
  PM / devfreq: Add PM QoS support
  PM / devfreq: Use PM QoS for sysfs min/max_freq

 drivers/devfreq/devfreq.c | 151 ++++++++++++++++++++++++++++++++++----
 include/linux/devfreq.h   |  14 +++-
 2 files changed, 145 insertions(+), 20 deletions(-)

-- 
2.17.1

