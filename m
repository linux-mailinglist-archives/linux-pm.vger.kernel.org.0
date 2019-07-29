Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E62D78EE1
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 17:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfG2PPA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 11:15:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43002 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfG2PPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 11:15:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so28411203pgb.9;
        Mon, 29 Jul 2019 08:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1JmFol5QA2g3GXQE+vAp5O+rOodAJCnuqQE1Qyu/KT4=;
        b=bFTWNNt7z0cI4RjPL6vfnmtRPX/uCjzZ8Jn1MTFV1H3pHUx9/ObJYAm0n5LmoNEWxV
         2a/RbnduIcEzVN9q0aSfNRz7mVKz0iJd/fq7MvXr0cQU72oCHophAiTsKSTNu+dm32m+
         pj0FCd2KCdwckRc74nq8fEqx4FGEQtS2obuUypyhu9RNvUfyQ1aNLaoQ4RzJVdAiCbrb
         MsmmCfZVb2627TaSKI6MXI9c+EvzdXz4xOaUXECBh5U0QxJuK0sG8/Lw7btM1vanUg/K
         Qj5w4Ouwcsyrf9Zj2p0yp8/v0gDlTioQDxPXqmL0ufk9StvScECVjPxACLzR9RooFdQk
         14RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1JmFol5QA2g3GXQE+vAp5O+rOodAJCnuqQE1Qyu/KT4=;
        b=Ga45OHLOikOMJuuMgRTop2AkHseS1I0/4FUEc7tyr60INzrbDlAhxo5rvo5jCKfvOU
         1E1lHxCnXQfQ0mnjHuawBvFZFkMsZXihFiZjHINYPwylOG3wH+F12ZprQSQi1Q/qh0FP
         PxrILvQqWA3D/qkjQ2Cqk5V06/+ujBS/zfnfJYFxt4xetqKx4Q9XoxUIELiMkn2uO8Uh
         R1M5N8/O8/1saOulPanu4LqAVIBrMrnvgNMMBsgln20SF1nqptiPZgEzxfYx3jZz/+gk
         WCf+73VAjHbhmpVfl1gKb18vxvv/Npgf1BYKSgqIZiWJpyDM5PXqmOrWWBKhwBrBRPq8
         FISw==
X-Gm-Message-State: APjAAAWVGCjd8doTpxJUKI9NRA0At2AEIACK2k/sQ/WV8D6KzDTUGKUh
        6xgLcoEyVt61k1Mdrafa6Es=
X-Google-Smtp-Source: APXvYqwzPO+nPta6qj9xGglCyLQGW6/qJsJMIxXcsk+ZEPFeXWjpcQfDG6Sw1EfuN76esVUg+TtXFA==
X-Received: by 2002:a63:e5a:: with SMTP id 26mr101025779pgo.3.1564413299473;
        Mon, 29 Jul 2019 08:14:59 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id q21sm47923622pgb.48.2019.07.29.08.14.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 08:14:58 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH 07/12] power: Replace strncmp with str_has_prefix
Date:   Mon, 29 Jul 2019 23:14:54 +0800
Message-Id: <20190729151454.9606-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

strncmp(str, const, len) is error-prone.
We had better use newly introduced
str_has_prefix() instead of it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 kernel/power/hibernate.c | 8 ++++----
 kernel/power/main.c      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index cd7434e6000d..49d4bfdb2b67 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1188,15 +1188,15 @@ static int __init resume_offset_setup(char *str)
 
 static int __init hibernate_setup(char *str)
 {
-	if (!strncmp(str, "noresume", 8)) {
+	if (str_has_prefix(str, "noresume")) {
 		noresume = 1;
-	} else if (!strncmp(str, "nocompress", 10)) {
+	} else if (str_has_prefix(str, "nocompress")) {
 		nocompress = 1;
-	} else if (!strncmp(str, "no", 2)) {
+	} else if (str_has_prefix(str, "no")) {
 		noresume = 1;
 		nohibernate = 1;
 	} else if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)
-		   && !strncmp(str, "protect_image", 13)) {
+		   && str_has_prefix(str, "protect_image")) {
 		enable_restore_image_protection();
 	}
 	return 1;
diff --git a/kernel/power/main.c b/kernel/power/main.c
index bdbd605c4215..5e5f64bb3a43 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -495,7 +495,7 @@ static suspend_state_t decode_state(const char *buf, size_t n)
 	len = p ? p - buf : n;
 
 	/* Check hibernation first. */
-	if (len == 4 && !strncmp(buf, "disk", len))
+	if (len == 4 && str_has_prefix(buf, "disk"))
 		return PM_SUSPEND_MAX;
 
 #ifdef CONFIG_SUSPEND
-- 
2.20.1

