Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748D539EC4F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 04:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFHCrL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 22:47:11 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3092 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhFHCrK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 22:47:10 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FzZGf4Z09zWtjm;
        Tue,  8 Jun 2021 10:40:26 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 10:45:17 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 10:45:16 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rjw@rjwysocki.net>, <pavel@ucw.cz>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <x86@kernel.org>,
        <hpa@zytor.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] x86/power: fix doc warnings in cpu.c
Date:   Tue, 8 Jun 2021 10:54:27 +0800
Message-ID: <20210608025427.2781445-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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
 arch/x86/power/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 3a070e7cdb8b..2640b9128479 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -60,7 +60,7 @@ static void msr_restore_context(struct saved_context *ctxt)
 /**
  *	__save_processor_state - save CPU registers before creating a
  *		hibernation image and before restoring the memory state from it
- *	@ctxt - structure to store the registers contents in
+ *	@ctxt: structure to store the registers contents in
  *
  *	NOTE: If there is a CPU register the modification of which by the
  *	boot kernel (ie. the kernel used for loading the hibernation image)
@@ -183,7 +183,7 @@ static void fix_processor_context(void)
 /**
  * __restore_processor_state - restore the contents of CPU registers saved
  *                             by __save_processor_state()
- * @ctxt - structure to load the registers contents from
+ * @ctxt: structure to load the registers contents from
  *
  * The asm code that gets us here will have restored a usable GDT, although
  * it will be pointing to the wrong alias.
-- 
2.31.1

