Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4639C64B
	for <lists+linux-pm@lfdr.de>; Sat,  5 Jun 2021 08:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFEGcQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Jun 2021 02:32:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7110 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhFEGcQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Jun 2021 02:32:16 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FxqSD0Dz4zYqKX;
        Sat,  5 Jun 2021 14:27:40 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:30:26 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:30:26 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <rjw@rjwysocki.net>, <len.brown@intel.com>, <pavel@ucw.cz>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] PM/sleep: fix doc warnings in main.c
Date:   Sat, 5 Jun 2021 14:39:34 +0800
Message-ID: <20210605063934.688763-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add description for `state_show` to fix the W=1 warnings:

kernel/power/main.c:593: warning:
 Function parameter or member 'kobj' not described in 'state_show'
kernel/power/main.c:593: warning:
 Function parameter or member 'attr' not described in 'state_show'
kernel/power/main.c:593: warning:
 Function parameter or member 'buf' not described in 'state_show'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 kernel/power/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 12c7e1bb442f..d508c8c582e0 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -579,7 +579,9 @@ struct kobject *power_kobj;
 
 /**
  * state - control system sleep states.
- *
+ * @kobj: Pointer to the kernel object.
+ * @attr: Pointer to the kernel object attribute.
+ * @buf: buffer.
  * show() returns available sleep state labels, which may be "mem", "standby",
  * "freeze" and "disk" (hibernation).
  * See Documentation/admin-guide/pm/sleep-states.rst for a description of
-- 
2.31.1

