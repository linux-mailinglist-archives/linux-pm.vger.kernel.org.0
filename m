Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96D11197DE0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Mar 2020 16:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgC3OJD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Mar 2020 10:09:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgC3OJC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Mar 2020 10:09:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 25303AC5F;
        Mon, 30 Mar 2020 14:09:01 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: Add a sanity check for invalid state at stats update
Date:   Mon, 30 Mar 2020 16:08:59 +0200
Message-Id: <20200330140859.12535-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal sysfs handler keeps the statistics table with the fixed
size that was determined from the initial max_states() call, and the
table entry is updated at each sysfs cur_state write call.  And, when
the driver's set_cur_state() ops accepts the value given from
user-space, the thermal sysfs core blindly applies it to the
statistics table entry, which may overflow and cause an Oops.
Although it's rather a bug in the driver's ops implementations, we
shouldn't crash but rather give a proper warning instead.

This patch adds a sanity check for avoiding such an OOB access and
warns with a stack trace to show the suspicious device in question.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

We've hit some crash by stress tests, and this patch at least works
around the crash itself.  While the actual bug fix of the buggy driver
is still being investigated, I submit the hardening in the core side
at first.

 drivers/thermal/thermal_sysfs.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb4dff7..a23c4e701d63 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -772,6 +772,11 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 
 	spin_lock(&stats->lock);
 
+	if (dev_WARN_ONCE(&cdev->device, new_state >= stats->max_states,
+			  "new state %ld exceeds max_state %ld",
+			  new_state, stats->max_states))
+		goto unlock;
+
 	if (stats->state == new_state)
 		goto unlock;
 
-- 
2.16.4

