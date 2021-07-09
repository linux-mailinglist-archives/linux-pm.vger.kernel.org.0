Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931553C1CEC
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 03:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhGIBFr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Jul 2021 21:05:47 -0400
Received: from m15113.mail.126.com ([220.181.15.113]:39012 "EHLO
        m15113.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhGIBFq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Jul 2021 21:05:46 -0400
X-Greylist: delayed 1835 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2021 21:05:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Bau5W
        sM5tFaq/gw8r4NEOvCzfyvBXA7HtsNl9Sbf5FE=; b=aZhn1kJEQEGGjytiJ7TZW
        q2JNKZattBTdKTgcfb1e2BOrooA6+vYn1DIHz1z3v22L3sXoQePMln470RQpsRm+
        4kMO+olnH4Zx6ERlOLfsnsQqEfUekuqE5BYM4vNDNmCPr2YJRu4RG3K4yuZmWeDC
        5danLZBjjDH6gPI49kcER4=
Received: from localhost.localdomain (unknown [111.28.186.210])
        by smtp3 (Coremail) with SMTP id DcmowADHz88MmedgOBXESw--.12897S2;
        Fri, 09 Jul 2021 08:32:13 +0800 (CST)
From:   xiongxin <win239@126.com>
To:     rjw@rjwysocki.net, pavel@ucw.cz
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH] PM / s2idle: Fix the failure of specifying "mem_sleep_default=" parameter
Date:   Fri,  9 Jul 2021 08:32:04 +0800
Message-Id: <20210709003204.26944-1-win239@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcmowADHz88MmedgOBXESw--.12897S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw15KFyrXFWDWw4UXw4xJFb_yoW8Gw4Dp3
        4rK3y8Ka12yryYyF4Utw4kZFy5X3WrKFWYka9rK3ykGrW3Wwn5Gr1Utr17X34YvrZ7ZF4I
        vrn7tw4qqwnY9FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwpnPUUUUU=
X-Originating-IP: [111.28.186.210]
X-CM-SenderInfo: xzlqjjaz6rjloofrz/1tbiHRHJilpEEOR2sQACsg
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: xiongxin <xiongxin@kylinos.cn>

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

