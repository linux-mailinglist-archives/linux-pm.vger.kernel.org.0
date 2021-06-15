Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851813A7518
	for <lists+linux-pm@lfdr.de>; Tue, 15 Jun 2021 05:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFOD2o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 23:28:44 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7266 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhFOD2m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Jun 2021 23:28:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G3trx22K9z1BMXy;
        Tue, 15 Jun 2021 11:21:37 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 11:26:36 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 15 Jun
 2021 11:26:35 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rjw@rjwysocki.net>, <pavel@ucw.cz>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next v2] x86/power: fix doc warnings in cpu.c
Date:   Tue, 15 Jun 2021 11:35:35 +0800
Message-ID: <20210615033535.2907295-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 arch/x86/power/cpu.c:76: warning: Function parameter or
  member 'ctxt' not described in '__save_processor_state'
 arch/x86/power/cpu.c:192: warning: Function parameter or
  member 'ctxt' not described in '__restore_processor_state'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
V1->V2:
	Fix the formatting of this kerneldoc comment

 arch/x86/power/cpu.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 3a070e7cdb8b..54b530db5ed0 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -58,19 +58,20 @@ static void msr_restore_context(struct saved_context *ctxt)
 }
 
 /**
- *	__save_processor_state - save CPU registers before creating a
- *		hibernation image and before restoring the memory state from it
- *	@ctxt - structure to store the registers contents in
+ * __save_processor_statei() - Save CPU registers before creating a
+ *                             hibernation image and before restoring
+ *                             the memory state from it
+ * @ctxt: Structure to store the registers contents in.
  *
- *	NOTE: If there is a CPU register the modification of which by the
- *	boot kernel (ie. the kernel used for loading the hibernation image)
- *	might affect the operations of the restored target kernel (ie. the one
- *	saved in the hibernation image), then its contents must be saved by this
- *	function.  In other words, if kernel A is hibernated and different
- *	kernel B is used for loading the hibernation image into memory, the
- *	kernel A's __save_processor_state() function must save all registers
- *	needed by kernel A, so that it can operate correctly after the resume
- *	regardless of what kernel B does in the meantime.
+ * NOTE: If there is a CPU register the modification of which by the
+ * boot kernel (ie. the kernel used for loading the hibernation image)
+ * might affect the operations of the restored target kernel (ie. the one
+ * saved in the hibernation image), then its contents must be saved by this
+ * function.  In other words, if kernel A is hibernated and different
+ * kernel B is used for loading the hibernation image into memory, the
+ * kernel A's __save_processor_state() function must save all registers
+ * needed by kernel A, so that it can operate correctly after the resume
+ * regardless of what kernel B does in the meantime.
  */
 static void __save_processor_state(struct saved_context *ctxt)
 {
@@ -181,9 +182,9 @@ static void fix_processor_context(void)
 }
 
 /**
- * __restore_processor_state - restore the contents of CPU registers saved
- *                             by __save_processor_state()
- * @ctxt - structure to load the registers contents from
+ * __restore_processor_state() - Restore the contents of CPU registers saved
+ *                               by __save_processor_state()
+ * @ctxt: Structure to load the registers contents from.
  *
  * The asm code that gets us here will have restored a usable GDT, although
  * it will be pointing to the wrong alias.
-- 
2.31.1

