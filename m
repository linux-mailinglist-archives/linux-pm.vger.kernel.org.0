Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B433B2B65
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 11:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhFXJal (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbhFXJak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 05:30:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83078C06175F;
        Thu, 24 Jun 2021 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=knAjhsG/6jthQQWVo2QqXwIZ8VPSdd1nuBR6NhivhIM=; b=G16tTJWDTbC4LlBQmCkQ9sdNKz
        +tbh+qINMtf1/qD6j02kAoXLBXx+vVlyKZaw+sS+OgtyNejJx8hzyb1IBdGXt9x8cwneis4BxmKrb
        dmr6Yh/U631/OU11euOHm3qXFlsAIyO+2iaF+xYzF0jcLRtS8RzeZLk6fYd6RC+3FTbO4CV/CK1rj
        WhlgS07AcBgQWyhqu7W+kWtDnzrIYHCbdPbWD5tuT41agPFnlAwT9StFndYoueuwcztmcc0bp6RRG
        VIJQBCy4Z8fXdLqIEhKby4bNAmvizdWbkQcpf28RIy9ORAyP3mN1aQeZ5CcFG6MlCj/jQ5U7bobD/
        NEvq+uSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwLdd-00GOui-Fu; Thu, 24 Jun 2021 09:27:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C29CD3002D3;
        Thu, 24 Jun 2021 11:27:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A81F12B64C06E; Thu, 24 Jun 2021 11:27:07 +0200 (CEST)
Message-ID: <20210624092615.885982587@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:21:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 2/4] freezer,umh: Clean up freezer/initrd interaction
References: <20210624092156.332208049@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

handle_initrd() marks itself as PF_FREEZER_SKIP in order to ensure
that the UMH, which is going to freeze the system, doesn't
indefinitely wait for it's caller.

Rework things by adding UMH_FREEZABLE to indicate the completion is
freezable.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/umh.h     |    9 +++++----
 init/do_mounts_initrd.c |   10 +---------
 kernel/umh.c            |    8 ++++++++
 3 files changed, 14 insertions(+), 13 deletions(-)

--- a/include/linux/umh.h
+++ b/include/linux/umh.h
@@ -11,10 +11,11 @@
 struct cred;
 struct file;
 
-#define UMH_NO_WAIT	0	/* don't wait at all */
-#define UMH_WAIT_EXEC	1	/* wait for the exec, but not the process */
-#define UMH_WAIT_PROC	2	/* wait for the process to complete */
-#define UMH_KILLABLE	4	/* wait for EXEC/PROC killable */
+#define UMH_NO_WAIT	0x00	/* don't wait at all */
+#define UMH_WAIT_EXEC	0x01	/* wait for the exec, but not the process */
+#define UMH_WAIT_PROC	0x02	/* wait for the process to complete */
+#define UMH_KILLABLE	0x04	/* wait for EXEC/PROC killable */
+#define UMH_FREEZABLE	0x08	/* wait for EXEC/PROC freezable */
 
 struct subprocess_info {
 	struct work_struct work;
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -79,19 +79,11 @@ static void __init handle_initrd(void)
 	init_mkdir("/old", 0700);
 	init_chdir("/old");
 
-	/*
-	 * In case that a resume from disk is carried out by linuxrc or one of
-	 * its children, we need to tell the freezer not to wait for us.
-	 */
-	current->flags |= PF_FREEZER_SKIP;
-
 	info = call_usermodehelper_setup("/linuxrc", argv, envp_init,
 					 GFP_KERNEL, init_linuxrc, NULL, NULL);
 	if (!info)
 		return;
-	call_usermodehelper_exec(info, UMH_WAIT_PROC);
-
-	current->flags &= ~PF_FREEZER_SKIP;
+	call_usermodehelper_exec(info, UMH_WAIT_PROC|UMH_FREEZABLE);
 
 	/* move initrd to rootfs' /old */
 	init_mount("..", ".", NULL, MS_MOVE, NULL);
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -28,6 +28,7 @@
 #include <linux/async.h>
 #include <linux/uaccess.h>
 #include <linux/initrd.h>
+#include <linux/freezer.h>
 
 #include <trace/events/module.h>
 
@@ -436,6 +437,9 @@ int call_usermodehelper_exec(struct subp
 	if (wait == UMH_NO_WAIT)	/* task has freed sub_info */
 		goto unlock;
 
+	if (wait & UMH_FREEZABLE)
+		freezer_do_not_count();
+
 	if (wait & UMH_KILLABLE) {
 		retval = wait_for_completion_killable(&done);
 		if (!retval)
@@ -448,6 +452,10 @@ int call_usermodehelper_exec(struct subp
 	}
 
 	wait_for_completion(&done);
+
+	if (wait & UMH_FREEZABLE)
+		freezer_count();
+
 wait_done:
 	retval = sub_info->retval;
 out:


