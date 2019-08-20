Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C279643B
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2019 17:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbfHTPYF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Aug 2019 11:24:05 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49934 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727835AbfHTPYF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Aug 2019 11:24:05 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B9B4200404;
        Tue, 20 Aug 2019 17:24:03 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D4162002A9;
        Tue, 20 Aug 2019 17:24:03 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 023F820612;
        Tue, 20 Aug 2019 17:24:02 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/2] PM / devfreq: Add dev_pm_qos support
Date:   Tue, 20 Aug 2019 18:23:59 +0300
Message-Id: <cover.1566314535.git.leonard.crestez@nxp.com>
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

Like with cpufreq the handling of min_freq/max_freq is moved to the dev_pm_qos
mechanism and this decreases the precision of the sysfs entries.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

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

Leonard Crestez (2):
  PM / devfreq: Add dev_pm_qos support
  PM / devfreq: Use dev_pm_qos for sysfs min/max_freq

 drivers/devfreq/devfreq.c | 170 +++++++++++++++++++++++++++-----------
 include/linux/devfreq.h   |  14 +++-
 2 files changed, 131 insertions(+), 53 deletions(-)

-- 
2.17.1

