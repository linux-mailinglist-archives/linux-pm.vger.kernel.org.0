Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A3D3BE395
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 09:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhGGHfF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 03:35:05 -0400
Received: from mailgw.kylinos.cn ([123.150.8.42]:53349 "EHLO nksmu.kylinos.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230390AbhGGHfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 03:35:04 -0400
X-UUID: a7127cbe3b2c497e84fc744309c87a08-20210707
X-UUID: a7127cbe3b2c497e84fc744309c87a08-20210707
X-User: xiongxin@kylinos.cn
Received: from localhost.localdomain [(111.28.186.210)] by nksmu.kylinos.cn
        (envelope-from <xiongxin@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 530429751; Wed, 07 Jul 2021 15:31:20 +0800
From:   xiongxin <xiongxin@kylinos.cn>
To:     len.brown@intel.com, rjw@rjwysocki.net, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH] PM / s2idle: Fix the failure of specifying "mem_sleep_default=" parameter
Date:   Wed,  7 Jul 2021 15:32:16 +0800
Message-Id: <20210707073216.152267-1-xiongxin@kylinos.cn>
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

