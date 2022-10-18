Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996EB603352
	for <lists+linux-pm@lfdr.de>; Tue, 18 Oct 2022 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiJRTXq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Oct 2022 15:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJRTXo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2022 15:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5289D6CD13
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2022 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666121022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=s0ybmAdKdKZNlXCdss0Mmrg5Wa8iFFzfcU0KpodNEzg=;
        b=BIHsKMMB0yTRkJwTQJLOBp8NlzsNHeaO+h10iI2JVQz8CFKCA7Y06+nwt9uWbNvw77P0O6
        C+dthQKNPKMVIADECN8kFeXtwiKXzMtQV2vPcgRDJPDKgJSfT080r5nZWHKgFf35HozYDO
        4KGJJtgJX7BcOVIKiys/6Ev1WzBzF/s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-Uz4c2vNWMPO4z0ErsDJvJg-1; Tue, 18 Oct 2022 15:23:41 -0400
X-MC-Unique: Uz4c2vNWMPO4z0ErsDJvJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1121101E985;
        Tue, 18 Oct 2022 19:23:40 +0000 (UTC)
Received: from prarit.7a2m.lab.eng.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0A4E2166B41;
        Tue, 18 Oct 2022 19:23:40 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     Prarit Bhargava <prarit@redhat.com>, Len Brown <lenb@kernel.org>,
        David Arcari <darcari@redhat.com>
Subject: [PATCH] turbostat: Provide better debug messages for failed capabilities accesses
Date:   Tue, 18 Oct 2022 15:23:37 -0400
Message-Id: <20221018192337.3725439-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

turbostat reports some capabilities access errors and not others.  Provide
the same debug message for all errors.

Cc: Len Brown <lenb@kernel.org>
Cc: David Arcari <darcari@redhat.com>
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 tools/power/x86/turbostat/turbostat.8 |  2 +-
 tools/power/x86/turbostat/turbostat.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index c7b26a3603af..7dcb4f4f3d55 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -340,7 +340,7 @@ starts a new interval.
 must be run as root.
 Alternatively, non-root users can be enabled to run turbostat this way:
 
-# setcap cap_sys_admin,cap_sys_rawio,cap_sys_nice=+ep ./turbostat
+# setcap cap_sys_admin,cap_sys_rawio,cap_sys_nice=+ep path/to/turbostat
 
 # chmod +r /dev/cpu/*/msr
 
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index aba460410dbd..7484754fc403 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -670,7 +670,8 @@ static int perf_instr_count_open(int cpu_num)
 	/* counter for cpu_num, including user + kernel and all processes */
 	fd = perf_event_open(&pea, -1, cpu_num, -1, 0);
 	if (fd == -1) {
-		warn("cpu%d: perf instruction counter", cpu_num);
+		warnx("capget(CAP_PERFMON) failed," " try \"# setcap cap_sys_admin=ep %s\"",
+		      progname);
 		BIC_NOT_PRESENT(BIC_IPC);
 	}
 
@@ -3502,9 +3503,6 @@ void msr_sum_record(void)
 /*
  * set_my_sched_priority(pri)
  * return previous
- *
- * if non-root, do this:
- * # /sbin/setcap cap_sys_rawio,cap_sys_nice=+ep /usr/bin/turbostat
  */
 int set_my_sched_priority(int priority)
 {
@@ -3518,7 +3516,8 @@ int set_my_sched_priority(int priority)
 
 	retval = setpriority(PRIO_PROCESS, 0, priority);
 	if (retval)
-		err(retval, "setpriority(%d)", priority);
+		errx(retval, "capget(CAP_SYS_NICE) failed," "try \"# setcap cap_sys_nice=ep %s\"",
+		     progname);
 
 	errno = 0;
 	retval = getpriority(PRIO_PROCESS, 0);
@@ -5476,7 +5475,8 @@ void print_dev_latency(void)
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		warn("fopen %s\n", path);
+		warnx("capget(CAP_SYS_ADMIN) failed," " try \"# setcap cap_sys_admin=ep %s\"",
+		      progname);
 		return;
 	}
 
-- 
2.37.3

