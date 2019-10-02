Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303C0C9243
	for <lists+linux-pm@lfdr.de>; Wed,  2 Oct 2019 21:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfJBTZS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Oct 2019 15:25:18 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60006 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJBTZS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 2 Oct 2019 15:25:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5000F2006D6;
        Wed,  2 Oct 2019 21:25:15 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 41DB52006AC;
        Wed,  2 Oct 2019 21:25:15 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D71D2060C;
        Wed,  2 Oct 2019 21:25:14 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 0/8] PM / devfreq: Add dev_pm_qos support
Date:   Wed,  2 Oct 2019 22:25:03 +0300
Message-Id: <cover.1570044052.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dev_pm_qos notifiers to devfreq core in order to support frequency
limits via dev_pm_qos_add_request.

Unlike the rest of devfreq the dev_pm_qos frequency is measured in Khz,
this is consistent with current dev_pm_qos usage for cpufreq and
allows frequencies above 2Ghz (pm_qos expresses limits as s32).

Like with cpufreq the handling of min_freq/max_freq is moved to the
dev_pm_qos mechanism. Constraints from userspace are no longer clamped on
store, instead all values can be written and we only check against OPPs in a
new devfreq_get_freq_range function. This is consistent with the design of
dev_pm_qos.

Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
need to take devfreq->lock. Notifier registration takes the same dev_pm_qos_mtx
so in order to prevent lockdep warnings it must be done outside devfreq->lock.
Current devfreq_add_device does all initialization under devfreq->lock and that
needs to be relaxed.

Some of first patches in the series are bugfixes and cleanups, they could be
applied separately.

---
Changes since v8:
* Fix incorrectly reading qos max twice in get_freq_range.
* Make devfreq_notifier_call set scaling_max_freq to ULONG_MAX instead of 0 on
error. This avoids special-casing this in get_freq_range.
* Add a fix for devfreq_notifier_call returning -errno.
* Replace S32_MAX with PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE. This seems cleaner
and avoids overflow when multiplying S32_MAX with 1000 on 32bit platforms. It
overflowed to 0xfffffc18 hz so it was mostly safe anyway.
* Warn when encountering errors on cleanup (but continue).
* Incorporate other smaller comment and printk adjustments from review.
Link to v8:
https://patchwork.kernel.org/cover/11158383/

Changes since v7:
* Only #define HZ_PER_KHZ in patch where it's used.
* Drop devfreq_ prefix for some internal functions.
* Improve qos update error message.
* Remove some unnecessary comments.
* Collect reviews
Link to v7: https://patchwork.kernel.org/cover/11157649/

Changes since v6:
* Don't return errno from devfreq_qos_notifier_call, return NOTIFY_DONE
and print the error.
* More spelling and punctuation nits
Link to v6: https://patchwork.kernel.org/cover/11157201/

Changes since v5:
* Drop patches which are not strictly related to PM QoS.
* Add a comment explaining why devfreq_add_device needs two cleanup paths.
* Remove {} for single line.
* Rename {min,max}_freq_req to user_{min,max}_freq_req
* Collect reviews
Link to v5: https://patchwork.kernel.org/cover/11149497/

Changes since v4:
* Move more devfreq_add_device init ahead of device_register.
* Make devfreq_dev_release cleanup devices not yet in devfreq_list. This is
simpler than previous attempt to add to devfreq_list sonner.
* Take devfreq->lock in trans_stat_show
* Register dev_pm_opp notifier on devfreq parent dev (which has OPPs)
Link to v4: https://patchwork.kernel.org/cover/11114657/

Changes since v3:
* Cleanup locking and error-handling in devfreq_add_device
* Register notifiers after device registration but before governor start
* Keep the initialization of min_req/max_req ahead of device_register
because it's used for sysfs handling
* Use HZ_PER_KHZ instead of 1000
* Add kernel-doc comments
* Move OPP notifier to core
Link to v3: https://patchwork.kernel.org/cover/11104061/

Changes since v2:
* Handle sysfs via dev_pm_qos (in separate patch)
* Add locking to {min,max}_freq_show
* Fix checkpatch issues (long lines etc)
Link to v2: https://patchwork.kernel.org/patch/11084279/

Changes since v1:
* Add doxygen comments for min_nb/max_nb
* Remove notifiers on error/cleanup paths. Keep gotos simple by relying on
dev_pm_qos_remove_notifier ignoring notifiers which were not added.
Link to v1: https://patchwork.kernel.org/patch/11078475/

Leonard Crestez (8):
  PM / devfreq: Don't fail devfreq_dev_release if not in list
  PM / devfreq: Fix devfreq_notifier_call returning errno
  PM / devfreq: Set scaling_max_freq to max on OPP notifier error
  PM / devfreq: Move more initialization before registration
  PM / devfreq: Don't take lock in devfreq_add_device
  PM / devfreq: Introduce get_freq_range helper
  PM / devfreq: Add PM QoS support
  PM / devfreq: Use PM QoS for sysfs min/max_freq

 drivers/devfreq/devfreq.c | 310 ++++++++++++++++++++++++++------------
 include/linux/devfreq.h   |  14 +-
 2 files changed, 224 insertions(+), 100 deletions(-)

-- 
2.17.1

