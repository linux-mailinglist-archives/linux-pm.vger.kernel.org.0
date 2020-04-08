Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B61641A1ADC
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 06:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDHETi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 00:19:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:49178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHETi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Apr 2020 00:19:38 -0400
IronPort-SDR: 1+EXfqA+0AL55gHzWeauR/odXv9k8IMSggGugzRPEetkcipKrd9CbMMY0FdbtY+g6iK5tx42OF
 Lq12uVMXqvsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 21:19:38 -0700
IronPort-SDR: Fr1b150FY2EfJ9SJU7sEJCXrDRkdddmUEbfQtDI89Kn/5cX7Qaa1T9DXhMt304HKIr+/0oxyyA
 Y3DkncAavPyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="451470411"
Received: from tliao1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.172.195])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 21:19:36 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, tiwai@suse.de,
        viresh.kumar@linaro.org
Subject: [RFC PATCH 4/5] thermal: Add a sanity check for invalid state at stats update
Date:   Wed,  8 Apr 2020 12:19:16 +0800
Message-Id: <20200408041917.2329-4-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408041917.2329-1-rui.zhang@intel.com>
References: <20200408041917.2329-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

This is from the origin changelog
"The thermal sysfs handler keeps the statistics table with the fixed
size that was determined from the initial max_states() call, and the
table entry is updated at each sysfs cur_state write call.  And, when
the driver's set_cur_state() ops accepts the value given from
user-space, the thermal sysfs core blindly applies it to the
statistics table entry, which may overflow and cause an Oops.
Although it's rather a bug in the driver's ops implementations, we
shouldn't crash but rather give a proper warning instead.

This patch adds a sanity check for avoiding such an OOB access and
warns with a stack trace to show the suspicious device in question."

Part of the problem described above is gone, but I'd like to keep this
patch so that we can detect the other max_state changes from other
drivers, and fix the drivers by invoking
thermal_cdev_stats_update_max() when necessary.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 96e4a445952f..e0e21c67e78a 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -779,6 +779,11 @@ void thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
 
 	spin_lock(&stats->lock);
 
+	if (dev_WARN_ONCE(&cdev->device, new_state >= stats->max_states,
+			  "new state %ld exceeds max_state %ld",
+			  new_state, stats->max_states))
+		goto unlock;
+
 	if (stats->state == new_state)
 		goto unlock;
 
-- 
2.17.1

