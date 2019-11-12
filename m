Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7423F9AC2
	for <lists+linux-pm@lfdr.de>; Tue, 12 Nov 2019 21:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfKLUcH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Nov 2019 15:32:07 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:38657 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbfKLUcH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Nov 2019 15:32:07 -0500
Received: by mail-pf1-f202.google.com with SMTP id m1so16388491pfh.5
        for <linux-pm@vger.kernel.org>; Tue, 12 Nov 2019 12:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=YXQx/W19DjRT45sudkGcownKnjElC/pkN1OhsIzM96I=;
        b=E0MA/U0e/Ir3oTesUR3lbc72KPhRUcktmr14Rd6IlEOsdXbMHM3KS9JGSWuxc9kHCc
         +O+JezJM5VfFVoT5Ngsj5Sw56M+Roju26suQqeDGGsLTQg50XFx2zw+5sEfaX3f71JE9
         cdeSvQmgtD+paGsQf3w169KBi6k1Ah2IND7S+OIREx3FbSOpNAFG5oiaKMVmzSu2rcov
         Dc8SAkQ9lr0T9UqO8OubcaAlYGjuG5iSI8YKJbmUP/rGU6AjtxC7R/mk/v9t9cA06pFM
         WbLZUsbqe55f2wPyA9FfMRo8qGprp6LcvxoxT4+Sce0kqTnJIwI+qiNE+9TRae6Hg3Sw
         5ZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=YXQx/W19DjRT45sudkGcownKnjElC/pkN1OhsIzM96I=;
        b=nQCcfHSZwrOLhinHDHvnnzqnl9OtTIy+F4+l3w6oaudVq9lOHWCIR8A4t5TKX0Wn5F
         Z3QPInGWyZuXTa6fguO/3/t3VIZN1EwDAlE4VmEX8bF3Br3WBrM6cMtbU8oPwHzSvOCs
         0UwV7YD7d8ybK52OrmtZlvD8MI8Kt8PglWepnISmKG9xnM1tqquGqF8iu8kUAcxR8a95
         c0HfVh0M2SLt4nlLwH/HDCRtCax7UOHWYhJ8Bw3W846Z+WUh8ULYMcICDkHV6fht0ZW8
         4I41FidEi5QVwfgfyYPK0+OIeU3ldJcfI9ctBRYLTKY5tKKL/5cZxHuu09PXF0ZYVUhx
         QXNw==
X-Gm-Message-State: APjAAAWXsgEEuMV88mvD8iirM0/ql7W/lKeZ1k2T4cSveJFAuqj5tGua
        ozDFbOUu8svLOIr+o6x5DI5xmcM=
X-Google-Smtp-Source: APXvYqxZYENeurFYBI93H6hBNoITu9pAWLh8dS9xxQVYZFilab1ST7b555XNIa21qYSv4OFEaNmCPcg=
X-Received: by 2002:a65:6687:: with SMTP id b7mr3795669pgw.214.1573590726189;
 Tue, 12 Nov 2019 12:32:06 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:31:54 -0800
Message-Id: <20191112203154.101534-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] Fix deadlock in thermal thermal_zone_device_check
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit [2] changed cancel_delayed_work to cancel_delayed_work_sync to
avoid a use-after-free issue. However, cancel_delayed_work_sync could be
called insides the WQ causing deadlock [1].

[1]
[54109.642398] c0   1162 kworker/u17:1   D    0 11030      2 0x00000000
[54109.642437] c0   1162 Workqueue: thermal_passive_wq thermal_zone_device_check
[54109.642447] c0   1162 Call trace:
[54109.642456] c0   1162  __switch_to+0x138/0x158
[54109.642467] c0   1162  __schedule+0xba4/0x1434
[54109.642480] c0   1162  schedule_timeout+0xa0/0xb28
[54109.642492] c0   1162  wait_for_common+0x138/0x2e8
[54109.642511] c0   1162  flush_work+0x348/0x40c
[54109.642522] c0   1162  __cancel_work_timer+0x180/0x218
[54109.642544] c0   1162  handle_thermal_trip+0x2c4/0x5a4
[54109.642553] c0   1162  thermal_zone_device_update+0x1b4/0x25c
[54109.642563] c0   1162  thermal_zone_device_check+0x18/0x24
[54109.642574] c0   1162  process_one_work+0x3cc/0x69c
[54109.642583] c0   1162  worker_thread+0x49c/0x7c0
[54109.642593] c0   1162  kthread+0x17c/0x1b0
[54109.642602] c0   1162  ret_from_fork+0x10/0x18
[54109.643051] c0   1162 kworker/u17:2   D    0 16245      2 0x00000000
[54109.643067] c0   1162 Workqueue: thermal_passive_wq thermal_zone_device_check
[54109.643077] c0   1162 Call trace:
[54109.643085] c0   1162  __switch_to+0x138/0x158
[54109.643095] c0   1162  __schedule+0xba4/0x1434
[54109.643104] c0   1162  schedule_timeout+0xa0/0xb28
[54109.643114] c0   1162  wait_for_common+0x138/0x2e8
[54109.643122] c0   1162  flush_work+0x348/0x40c
[54109.643131] c0   1162  __cancel_work_timer+0x180/0x218
[54109.643141] c0   1162  handle_thermal_trip+0x2c4/0x5a4
[54109.643150] c0   1162  thermal_zone_device_update+0x1b4/0x25c
[54109.643159] c0   1162  thermal_zone_device_check+0x18/0x24
[54109.643167] c0   1162  process_one_work+0x3cc/0x69c
[54109.643177] c0   1162  worker_thread+0x49c/0x7c0
[54109.643186] c0   1162  kthread+0x17c/0x1b0
[54109.643195] c0   1162  ret_from_fork+0x10/0x18
[54109.644500] c0   1162 cat             D    0  7766      1 0x00000001
[54109.644515] c0   1162 Call trace:
[54109.644524] c0   1162  __switch_to+0x138/0x158
[54109.644536] c0   1162  __schedule+0xba4/0x1434
[54109.644546] c0   1162  schedule_preempt_disabled+0x80/0xb0
[54109.644555] c0   1162  __mutex_lock+0x3a8/0x7f0
[54109.644563] c0   1162  __mutex_lock_slowpath+0x14/0x20
[54109.644575] c0   1162  thermal_zone_get_temp+0x84/0x360
[54109.644586] c0   1162  temp_show+0x30/0x78
[54109.644609] c0   1162  dev_attr_show+0x5c/0xf0
[54109.644628] c0   1162  sysfs_kf_seq_show+0xcc/0x1a4
[54109.644636] c0   1162  kernfs_seq_show+0x48/0x88
[54109.644656] c0   1162  seq_read+0x1f4/0x73c
[54109.644664] c0   1162  kernfs_fop_read+0x84/0x318
[54109.644683] c0   1162  __vfs_read+0x50/0x1bc
[54109.644692] c0   1162  vfs_read+0xa4/0x140
[54109.644701] c0   1162  SyS_read+0xbc/0x144
[54109.644708] c0   1162  el0_svc_naked+0x34/0x38
[54109.845800] c0   1162 D 720.000s 1->7766->7766 cat [panic]

Fixes commit 1851799e1d29 ("thermal: Fix use-after-free when
unregistering thermal zone device") [2]

Signed-off-by: Wei Wang <wvw@google.com>
---
 drivers/thermal/thermal_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index d4481cc8958f..c28271817e43 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -304,7 +304,7 @@ static void thermal_zone_device_set_polling(struct thermal_zone_device *tz,
 				 &tz->poll_queue,
 				 msecs_to_jiffies(delay));
 	else
-		cancel_delayed_work_sync(&tz->poll_queue);
+		cancel_delayed_work(&tz->poll_queue);
 }
 
 static void monitor_thermal_zone(struct thermal_zone_device *tz)
@@ -1414,7 +1414,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
 
 	mutex_unlock(&thermal_list_lock);
 
-	thermal_zone_device_set_polling(tz, 0);
+	cancel_delayed_work_sync(&tz->poll_queue);
 
 	thermal_set_governor(tz, NULL);
 
-- 
2.24.0.432.g9d3f5f5b63-goog

