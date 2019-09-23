Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C1BB886
	for <lists+linux-pm@lfdr.de>; Mon, 23 Sep 2019 17:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394068AbfIWPvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Sep 2019 11:51:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59110 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfIWPvP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 23 Sep 2019 11:51:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 68B071A0BB1;
        Mon, 23 Sep 2019 17:51:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 62BA91A09C6;
        Mon, 23 Sep 2019 17:51:12 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id B185420613;
        Mon, 23 Sep 2019 17:51:11 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Matthias Kaehlcke <mka@chromium.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lukasz Luba <l.luba@partner.samsung.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v6 0/6] PM / devfreq: Add dev_pm_qos support
Date:   Mon, 23 Sep 2019 18:51:03 +0300
Message-Id: <cover.1569252537.git.leonard.crestez@nxp.com>
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

---

Changes since v5 are mostly cosmetic:
* Drop patches which are not strictly related to PM QoS.
* Add a comment explaining why devfreq_add_device needs two cleanup paths.
* Remove {} for single line.
* Rename {min,max}_freq_req to user_{min,max}_freq_freq
* Collect reviews
Link to v5: https://patchwork.kernel.org/cover/11149497/

Sorry for forgetting to properly label v5. I know this is inside the
merge window but review would still be appreciated.

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

Leonard Crestez (6):
  PM / devfreq: Don't fail devfreq_dev_release if not in list
  PM / devfreq: Move more initialization before registration
  PM / devfreq: Don't take lock in devfreq_add_device
  PM / devfreq: Introduce devfreq_get_freq_range
  PM / devfreq: Add PM QoS support
  PM / devfreq: Use PM QoS for sysfs min/max_freq

 drivers/devfreq/devfreq.c | 264 +++++++++++++++++++++++++-------------
 include/linux/devfreq.h   |  14 +-
 2 files changed, 188 insertions(+), 90 deletions(-)

-- 
2.17.1

