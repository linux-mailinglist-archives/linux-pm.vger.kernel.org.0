Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C4D2FFD89
	for <lists+linux-pm@lfdr.de>; Fri, 22 Jan 2021 08:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbhAVHnx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 22 Jan 2021 02:43:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22256 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbhAVHnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2021 02:43:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611301345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=AFt1RADT85CsWLHgnysjUrQIh/N67g4zQfsS8BqGolw=;
        b=XphXQ8soZ9jfXEtgVo1S7dWrW5t4hqfFEBg/bYv/pPXxViABMmhipvMjUYe9bjAff6UTOh
        RL1dGYKfi7yCe13BeXqlFeMOzj9+XG6mf/2jDy+Olre2AK6wxCaQb9cHxGC9o5zpAV09yg
        Hrj4h22+hbZrujXnFfKmiJ+ZmI0tr+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-DOfXFTfLODqb0r8euOk-2g-1; Fri, 22 Jan 2021 02:42:19 -0500
X-MC-Unique: DOfXFTfLODqb0r8euOk-2g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E83031800D42;
        Fri, 22 Jan 2021 07:42:17 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D4EA60BF3;
        Fri, 22 Jan 2021 07:42:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     kexec@lists.infradead.org, rafael@kernel.org,
        dan.carpenter@oracle.com, kernelfans@gmail.com, bhe@redhat.com
Subject: [PATCH] kernel/kexec: remove the lock operation of system_transition_mutex
Date:   Fri, 22 Jan 2021 15:42:14 +0800
Message-Id: <20210122074214.26583-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Function kernel_kexec() is called with lock system_transition_mutex held
in reboot system call. While inside kernel_kexec(), it will acquire
system_transition_mutex agin. This will lead to dead lock.

The dead lock should be easily triggered, it hasn't caused any failure
report just because the feature 'kexec jump' is almost not used by anyone
as far as I know. An inquiry can be made about who is using 'kexec jump'
and where it's used. Before that, let's simply remove the lock operation
inside CONFIG_KEXEC_JUMP ifdeffery scope.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Pingfan Liu <kernelfans@gmail.com>
---
 kernel/kexec_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 80905e5aa8ae..a0b6780740c8 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1134,7 +1134,6 @@ int kernel_kexec(void)
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (kexec_image->preserve_context) {
-		lock_system_sleep();
 		pm_prepare_console();
 		error = freeze_processes();
 		if (error) {
@@ -1197,7 +1196,6 @@ int kernel_kexec(void)
 		thaw_processes();
  Restore_console:
 		pm_restore_console();
-		unlock_system_sleep();
 	}
 #endif
 
-- 
2.17.2

