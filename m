Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29BAEB8FA
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 22:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfJaVef (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 17:34:35 -0400
Received: from inva020.nxp.com ([92.121.34.13]:57576 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfJaVee (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 31 Oct 2019 17:34:34 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E9071A0218;
        Thu, 31 Oct 2019 22:34:32 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 10B221A0214;
        Thu, 31 Oct 2019 22:34:32 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BE5F205E9;
        Thu, 31 Oct 2019 22:34:31 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v10] PM / devfreq: Add dev_pm_qos support
Date:   Thu, 31 Oct 2019 23:34:17 +0200
Message-Id: <cover.1572556786.git.leonard.crestez@nxp.com>
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

Like with cpufreq the handling of min_freq/max_freq is moved to PM QoS
mechanisms. Constraints from userspace are no longer clamped on store,
instead all values can be written and we only check against OPPs in a
new get_freq_range function. This is consistent with the design of
dev_pm_qos.

Notifiers from pm_qos are executed under a single global dev_pm_qos_mtx and
need to take devfreq->lock. Notifier registration takes the same dev_pm_qos_mtx
so in order to prevent lockdep warnings it must be done outside devfreq->lock.
Current devfreq_add_device does all initialization under devfreq->lock and that
needs to be relaxed.

Some of first patches in the series are bugfixes and cleanups, they could be
applied separately. The simplifications are used for PM QoS
implementations but they're also nice on their own.

The middle section restores DEV_PM_QOS_MIN/MAX_FREQUENCY after it was
removed by cpufreq folks; this device-centered mechanism is still a very
good match for devfreq. Plan is to use this for interconnect on i.MX but
Samsung also expressed interest:

---
Series is against next-20191031. Version 9 no longer compiles.

Let me know if prefer multiple smaller series. For example patches 1-5
could be split waiting for further discussion on PM QoS specifics.

Changes since v9:
* Restore DEV_PM_QOS_MIN/MAX_FREQUENCY based on new frequency qos
* Preserve devm usage in devfreq_add_device by splitting device_register
into device_initialize and device_add. This also simplifies cleanup.
* Adjust printk messages
* Drop check for zero scaling_max_freq in get_freq_range.
* Collect reviews.
Link to v9: https://patchwork.kernel.org/cover/11171807/

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
Link to v8: https://patchwork.kernel.org/cover/11158383/

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

Leonard Crestez (11):
  PM / devfreq: Fix devfreq_notifier_call returning errno
  PM / devfreq: Set scaling_max_freq to max on OPP notifier error
  PM / devfreq: Split device_register usage
  PM / devfreq: Move more initialization before registration
  PM / devfreq: Don't take lock in devfreq_add_device
  PM / QoS: Reorder pm_qos/freq_qos/dev_pm_qos structs
  PM / QoS: Export _freq_qos_apply
  PM / QoS: Restore DEV_PM_QOS_MIN/MAX_FREQUENCY
  PM / devfreq: Introduce get_freq_range helper
  PM / devfreq: Add PM QoS support
  PM / devfreq: Use PM QoS for sysfs min/max_freq

 drivers/base/power/qos.c  |  69 +++++++++-
 drivers/devfreq/devfreq.c | 280 ++++++++++++++++++++++++++------------
 include/linux/devfreq.h   |  14 +-
 include/linux/pm_qos.h    |  86 +++++++-----
 kernel/power/qos.c        |  11 +-
 5 files changed, 322 insertions(+), 138 deletions(-)

-- 
2.17.1

