Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7139F07C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhFHIPQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 04:15:16 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:4513 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFHIPP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 04:15:15 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzjbW4wsszZdjT;
        Tue,  8 Jun 2021 16:10:31 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:13:20 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 16:13:20 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] PM: hibernate: remove leading spaces before tabs
Date:   Tue, 8 Jun 2021 16:13:14 +0800
Message-ID: <20210608081314.13435-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

1) Run the following command to find and remove the leading spaces before
   tabs:
   find kernel/power/ -type f | xargs sed -r -i 's/^[ ]+\t/\t/'
2) Manually check and correct if necessary

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index af507c8c895b..f7a986078213 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1146,7 +1146,7 @@ int create_basic_memory_bitmaps(void)
  Free_second_object:
 	kfree(bm2);
  Free_first_bitmap:
- 	memory_bm_free(bm1, PG_UNSAFE_CLEAR);
+	memory_bm_free(bm1, PG_UNSAFE_CLEAR);
  Free_first_object:
 	kfree(bm1);
 	return -ENOMEM;
-- 
2.25.1


