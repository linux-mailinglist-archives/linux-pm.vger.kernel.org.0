Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 697539D0D9
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2019 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbfHZNom (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Aug 2019 09:44:42 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55548 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731796AbfHZNoi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Aug 2019 09:44:38 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F0DE200201;
        Mon, 26 Aug 2019 15:44:36 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8042620000C;
        Mon, 26 Aug 2019 15:44:36 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id E98A220605;
        Mon, 26 Aug 2019 15:44:35 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/6] PM / devfreq: Add dev_pm_qos support
Date:   Mon, 26 Aug 2019 16:44:27 +0300
Message-Id: <cover.1566826075.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add dev_pm_qos notifies to devfreq core in order to support frequency
limits via the dev_pm_qos_add_request.

Unlike the rest of devfreq the dev_pm_qos frequency is measured in Khz,
this is consistent with current dev_pm_qos usage for cpufreq and
allows frequencies above 2Ghz (pm_qos expresses limits as s32).

Like with cpufreq the handling of min_freq/max_freq is moved to the
dev_pm_qos mechanism.

Patches 1/2 are technically bugfixes; as far as I can tell the paths
that "goto err_devfreq" in devfreq_add_device never worked correctly.

Constraints from userspace are no longer clamped on store, instead all
values are allowed and we only check against OPPs in a new
devfreq_get_freq_range function. This is consistent with the design of
dev_pm_qos design.

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
  PM / devfreq: Don't take lock in devfreq_add_device
  PM / devfreq: Add to devfreq_list immediately after registration
  PM / devfreq: Introduce devfreq_get_freq_range
  PM / devfreq: Add dev_pm_qos support
  PM / devfreq: Use dev_pm_qos for sysfs min/max_freq
  PM / devfreq: Move opp notifier registration to core

 drivers/devfreq/devfreq.c    | 313 +++++++++++++++++++----------------
 drivers/devfreq/exynos-bus.c |   7 -
 drivers/devfreq/rk3399_dmc.c |   6 -
 include/linux/devfreq.h      |  22 ++-
 4 files changed, 177 insertions(+), 171 deletions(-)

-- 
2.17.1

