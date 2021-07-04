Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4B13BABA1
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 07:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhGDFwi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 01:52:38 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:49557 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229476AbhGDFwh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 4 Jul 2021 01:52:37 -0400
X-UUID: 077d661e23cc427a8fc7c9e0983c0c3d-20210704
X-UUID: 077d661e23cc427a8fc7c9e0983c0c3d-20210704
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(111.28.186.210)] by nksmu.kylinos.cn
        (envelope-from <xiongxin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 797888787; Sun, 04 Jul 2021 13:49:02 +0800
From:   xiongxin <xiongxin@kylinos.cn>
To:     len.brown@intel.com
Cc:     rjw@rjwysocki.net, pavel@ucw.cz, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH] PM / s2idle: Fix the failure of specifying "mem_sleep_default=" parameter
Date:   Sun,  4 Jul 2021 13:49:54 +0800
Message-Id: <20210704054954.9349-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On the arm64 platform, the psci driver is used by default to set the
suspend_ops structure; but the psci_acpi_init() function is called
before the command-line parameter "mem_sleep_default=" is specified;
the user cannot set the desired suspend mode through the
"mem_sleep_default=" parameter;

In mem_sleep_default_setup(), judge whether suspend_ops is set, if it
has been assigned, rewrite the value of mem_sleep_current variable; in
order to complete the user setting;

Signed-off-by: xiongxin <xiongxin@kylinos.cn>

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index d8cae434f9eb..bef4b17de3f6 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -192,6 +192,21 @@ static int __init mem_sleep_default_setup(char *str)
 			break;
 		}
 
+	/*
+	 * When the suspend_ops has been set, "mem_sleep_default=*" will
+	 * be invalid, here to fix this situation.
+	 */
+	if (suspend_ops) {
+		if (mem_sleep_default == PM_SUSPEND_TO_IDLE)
+			mem_sleep_current = PM_SUSPEND_TO_IDLE;
+		else if ((mem_sleep_default == PM_SUSPEND_STANDBY) &&
+				valid_state(PM_SUSPEND_STANDBY))
+			mem_sleep_current = PM_SUSPEND_STANDBY;
+		else if ((mem_sleep_default >= PM_SUSPEND_MEM) &&
+				valid_state(PM_SUSPEND_MEM))
+			mem_sleep_current = PM_SUSPEND_MEM;
+	}
+
 	return 1;
 }
 __setup("mem_sleep_default=", mem_sleep_default_setup);
-- 
2.25.1

