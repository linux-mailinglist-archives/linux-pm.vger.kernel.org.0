Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA20E351A2F
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 20:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbhDAR6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 13:58:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15898 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236803AbhDARzU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 13:55:20 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FB4tP64yBzkbql;
        Thu,  1 Apr 2021 22:14:05 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 22:15:41 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rjw@rjwysocki.net>, <pavel@ucw.cz>, <len.brown@intel.com>,
        <zhe.he@windriver.com>, <yuehaibing@huawei.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] freezer: Remove unused inline function try_to_freeze_nowarn()
Date:   Thu, 1 Apr 2021 22:15:37 +0800
Message-ID: <20210401141537.21288-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/freezer.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 27828145ca09..0621c5f86c39 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -279,7 +279,6 @@ static inline int freeze_kernel_threads(void) { return -ENOSYS; }
 static inline void thaw_processes(void) {}
 static inline void thaw_kernel_threads(void) {}
 
-static inline bool try_to_freeze_nowarn(void) { return false; }
 static inline bool try_to_freeze(void) { return false; }
 
 static inline void freezer_do_not_count(void) {}
-- 
2.17.1

