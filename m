Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3890E1688FC
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 22:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgBUVJU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 16:09:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41045 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgBUVJU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 16:09:20 -0500
Received: by mail-qk1-f193.google.com with SMTP id d11so3172623qko.8
        for <linux-pm@vger.kernel.org>; Fri, 21 Feb 2020 13:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ENPq/7GL2LdhwWd45tusEGIXiUDzJQV+38GbQQfDu9Y=;
        b=VeesGLC8L7IzrzUN89qTRkqVXcW8jd53cLBfKygxcqlUrbJxcGc7bp+qUu5jCyDADH
         EFzyxAyXvvYYmGIdXrocupJmYKEvrPvx8NDyBs2hFpLJmOBlvlBRikDqJjxCbgQJirlg
         cnpRslIQxdm/MIQI51Ie35aGcmCU+FF6haH2N+J1IT0hqSkWeq0bJsT6zeiU2NWtk8gw
         KniHr/MXtAVag3o4PU5+oWGTg5uEij0ZObOHno5LKAr5XeMyQcigiQ7kLrCewHgvYtU+
         XeUbjFE/aV8iI2Tq3bFTinhkLWG4Rpg57qRpEOpaz9t/jboqevP8L581oOPP/DWH2ggA
         hqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ENPq/7GL2LdhwWd45tusEGIXiUDzJQV+38GbQQfDu9Y=;
        b=piQLs4UWj24sFDnUnDJvmrNP7a0Nv0Ge52Po6HJOkgjoGCv6H5Rg0oqZQMv5RvMlAx
         jV7cRa4OLUADqkMQG3S8k6aBlN8gW2oX6xTmlDswp0d4ow7ms1VHRb7ADa2ulm10Tss1
         DHdt38o3AL8SQJmnt0cLBhTFDsPqrtjKAECUBdOKm2kxIATIg5C4fu9LRxL8dIIP+d8c
         SNOJ9qtIQzFjKo1ECJTtqjTM5Xz8qlRMIRAuJKK1iBbhw30GrFDOG/qbUJdRG+I7Oqfc
         XzzNPPiYZpWw/UQIKHmDw4tevEam0t9c92tl7v76XQjkMrqMagtT45CzCWAPZZspwpb7
         QUng==
X-Gm-Message-State: APjAAAW/rFON9rXluEUHgtwpBnoqemC4DvOSjbkcJS4oozEiq9Ngg9qr
        NhKns8YblpCwuN8h2MUp/awnTw==
X-Google-Smtp-Source: APXvYqzATGs4NTBVmPJHvs7Z3ZHgRZmLgy9kkqqhvC+t4Mg3ozlWXa7l0q0WQNcSuMmGZmO1EmypVg==
X-Received: by 2002:a37:a84f:: with SMTP id r76mr35023486qke.115.1582319358843;
        Fri, 21 Feb 2020 13:09:18 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n191sm2120818qkn.6.2020.02.21.13.09.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 13:09:18 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     rjw@rjwysocki.net
Cc:     elver@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next] power/qos: fix a data race in pm_qos_*_value
Date:   Fri, 21 Feb 2020 16:09:10 -0500
Message-Id: <1582319350-23515-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

cpu_latency_constraints.target_value could be accessed concurrently as
noticed by KCSAN,

 LTP: starting ppoll01
 BUG: KCSAN: data-race in cpu_latency_qos_limit / pm_qos_update_target

 write to 0xffffffff99081470 of 4 bytes by task 27532 on cpu 2:
  pm_qos_update_target+0xa4/0x370
  pm_qos_set_value at kernel/power/qos.c:78
  cpu_latency_qos_apply+0x3b/0x50
  cpu_latency_qos_remove_request+0xea/0x270
  cpu_latency_qos_release+0x4b/0x70
  __fput+0x187/0x3d0
  ____fput+0x1e/0x30
  task_work_run+0xbf/0x130
  do_exit+0xa78/0xfd0
  do_group_exit+0x8b/0x180
  __x64_sys_exit_group+0x2e/0x30
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffffffff99081470 of 4 bytes by task 0 on cpu 41:
  cpu_latency_qos_limit+0x1f/0x30
  pm_qos_read_value at kernel/power/qos.c:55
  cpuidle_governor_latency_req+0x4f/0x80
  cpuidle_governor_latency_req at drivers/cpuidle/governor.c:114
  menu_select+0x6b/0xc29
  cpuidle_select+0x50/0x70
  do_idle+0x214/0x280
  cpu_startup_entry+0x1d/0x1f
  start_secondary+0x1b2/0x230
  secondary_startup_64+0xb6/0xc0

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 41 PID: 0 Comm: swapper/41 Tainted: G L 5.6.0-rc2-next-20200221+ #7
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

The read is outside pm_qos_lock critical section which results in a data
race. Fix it by adding a pair of READ|WRITE_ONCE().

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/power/qos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 32927682bcc4..db0bed2cae26 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -52,7 +52,7 @@
  */
 s32 pm_qos_read_value(struct pm_qos_constraints *c)
 {
-	return c->target_value;
+	return READ_ONCE(c->target_value);
 }
 
 static int pm_qos_get_value(struct pm_qos_constraints *c)
@@ -75,7 +75,7 @@ static int pm_qos_get_value(struct pm_qos_constraints *c)
 
 static void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 {
-	c->target_value = value;
+	WRITE_ONCE(c->target_value, value);
 }
 
 /**
-- 
1.8.3.1

