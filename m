Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C66A4182
	for <lists+linux-pm@lfdr.de>; Mon, 27 Feb 2023 13:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjB0MO1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Feb 2023 07:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB0MO1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Feb 2023 07:14:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935CB26AB
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 04:14:25 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id h16so24834151edz.10
        for <linux-pm@vger.kernel.org>; Mon, 27 Feb 2023 04:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3KHwy0QcGi0rO056chVSlWDuGfsYFIKCcGaeikIt/I=;
        b=ELPNTnxzDAR0yj9aLcbx76CAlo9mDdBLnkK9TVOC9d1Opw8Jom4hT5Wk251ULYME8p
         rklQOlykYO8mBRuA9+eKKJdrYuMy31WZ7wTW941uNuhpR3FURcTyi4qDKy1cXYO7JDN3
         1OMWbPuPV/I2oKjTQoo7RJRS+W+kMJN4WYXNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3KHwy0QcGi0rO056chVSlWDuGfsYFIKCcGaeikIt/I=;
        b=3UStF91VeaOWMJPnChXDU/wNY8JXN942g/KYsNRDxDVV710JioIkRFRElh6lWIIekg
         ZyiL2KXHEkpXTVyqzIQBq4R+e78xigto7wyLmIFiBOOX7RXvsciZ+HUpOxtGMfMsTbwg
         1zXZOeGi/iYXpg0Ht3u52bQh6kYWOB/soNjZ/Pa7mfdHSxflrV+TYAQ9ErD0coR8gjix
         fqQp1SsDucAy4AikLGiX85rIt9f/gE8Zn0UQMRGFeT4CSzmorwfinVgiPpdenqW6MgsS
         iQ3VxifE8QbLd8/R09jElOFO+pcGl94glATGE+PUThh9Uy/WOoFp1D7wwCFsQrqH7/r2
         DzpQ==
X-Gm-Message-State: AO0yUKVAdrkVHe5SqVGGNX9wCJzyGB9MXi0CjKTxsTnMmZ4qL3KFlT8D
        bO63YSkzuLmDN0BWMhGG44giY5cI6xH8MxUfHR8=
X-Google-Smtp-Source: AK7set+1DSzVXqZljjZAuH+qh6zQwLgXW79tOiIuzgWF9sn//T1POupD/OhoCpUeCwgYufBmucTUuQ==
X-Received: by 2002:a05:6402:53:b0:4af:6a7e:90ee with SMTP id f19-20020a056402005300b004af6a7e90eemr14057432edu.7.1677500063860;
        Mon, 27 Feb 2023 04:14:23 -0800 (PST)
Received: from md.corp.google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id 30-20020a508e1e000000b00499b6b50419sm2994766edw.11.2023.02.27.04.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 04:14:23 -0800 (PST)
From:   Michal Dubiel <md@chromium.org>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, pavel@ucw.cz, Michal Dubiel <md@chromium.org>
Subject: [PATCH 1/2] kernel/freezer: Add routine to read task's freezing reason
Date:   Mon, 27 Feb 2023 12:13:17 +0000
Message-Id: <20230227121318.2116638-2-md@chromium.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230227121318.2116638-1-md@chromium.org>
References: <20230227121318.2116638-1-md@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There are few reasons why a task is freezing. It can be due to system
suspend, it can be due to explicit user request, etc.

For most cases, the actual reason is not important, but there are some that
it is useful to distinguish between what actually caused the task to
freeze.

One example is when user requests freezing of tasks belonging to a certain
cgroup. If for any reason, system goes suspend and resume when the cgroup
is frozen, the already frozen tasks should not be thawed but remain frozen
to ensure the suspend/resume cycle transparency. The system should not warn
about skipping thawing of such processes as it is normal situation.

The proposed function allows to obtain information about the freezing
reason and let the calling code decide what to do accordingly.

Signed-off-by: Michal Dubiel <md@chromium.org>
---
 include/linux/freezer.h | 17 +++++++++++++++
 kernel/freezer.c        | 23 ++++++++++++++------
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index b303472255b..b936a349e0d 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -28,6 +28,23 @@ extern bool frozen(struct task_struct *p);
 
 extern bool freezing_slow_path(struct task_struct *p);
 
+extern enum freezing_reason freezing_reason_slow_path(struct task_struct *p);
+
+enum freezing_reason {
+	FREEZING_NONE	  = 0,
+	FREEZING_CGROUP	  = (1 << 0),
+	FREEZING_PM	  = (1 << 1),
+	FREEZING_PM_NOSIG = (1 << 2),
+};
+
+static inline enum freezing_reason freezing_reason(struct task_struct *p)
+{
+	if (static_branch_unlikely(&freezer_active))
+		return freezing_reason_slow_path(p);
+
+	return FREEZING_NONE;
+}
+
 /*
  * Check if there is a request to freeze a process
  */
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 4fad0e6fca6..2536054db60 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -26,6 +26,21 @@ bool pm_nosig_freezing;
 /* protects freezing and frozen transitions */
 static DEFINE_SPINLOCK(freezer_lock);
 
+enum freezing_reason freezing_reason_slow_path(struct task_struct *p)
+{
+	if (pm_nosig_freezing)
+		return FREEZING_PM_NOSIG;
+
+	if (cgroup_freezing(p))
+		return FREEZING_CGROUP;
+
+	if (pm_freezing && !(p->flags & PF_KTHREAD))
+		return FREEZING_PM;
+
+	return FREEZING_NONE;
+}
+EXPORT_SYMBOL(freezing_reason_slow_path);
+
 /**
  * freezing_slow_path - slow path for testing whether a task needs to be frozen
  * @p: task to be tested
@@ -43,13 +58,7 @@ bool freezing_slow_path(struct task_struct *p)
 	if (test_tsk_thread_flag(p, TIF_MEMDIE))
 		return false;
 
-	if (pm_nosig_freezing || cgroup_freezing(p))
-		return true;
-
-	if (pm_freezing && !(p->flags & PF_KTHREAD))
-		return true;
-
-	return false;
+	return (bool)freezing_reason_slow_path(p);
 }
 EXPORT_SYMBOL(freezing_slow_path);
 
-- 
2.39.2.722.g9855ee24e9-goog

