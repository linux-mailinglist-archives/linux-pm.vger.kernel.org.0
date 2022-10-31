Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FB261374A
	for <lists+linux-pm@lfdr.de>; Mon, 31 Oct 2022 14:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiJaNCH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Oct 2022 09:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiJaNCG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Oct 2022 09:02:06 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F10FAFC
        for <linux-pm@vger.kernel.org>; Mon, 31 Oct 2022 06:02:05 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4N1Cpm0SkPz15MD5;
        Mon, 31 Oct 2022 20:57:04 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:02:03 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 21:02:02 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rafael@kernel.org>, <daniel.lezcano@linaro.org>,
        <amitk@kernel.org>, <rui.zhang@intel.com>
CC:     <linux-pm@vger.kernel.org>, <yangyingliang@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH 1/2] tools/thermal: tmon: fix build warning caused by misusing strncpy()
Date:   Mon, 31 Oct 2022 21:21:09 +0800
Message-ID: <20221031132110.65847-1-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Building tool tmon emits the following warning.

tmon.c: In function ‘main’:
tmon.c:233:4: warning: ‘strncpy’ specified bound 20 equals destination size [-Wstringop-truncation]
  233 |    strncpy(ctrl_cdev, optarg, CDEV_NAME_SIZE);
      |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

If the third parameter 'count' of strncpy() equals destination size, we
can not guarantee the dest string is NULL terminated. The dest string
'ctrl_cdev' will be used as the input of strstr(). Let's minus the copy
count by one and force the dest string NULL terminated.

Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 tools/thermal/tmon/tmon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 7eb3216a27f4..537a7a47f401 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -230,7 +230,8 @@ int main(int argc, char **argv)
 		switch (c) {
 		case 'c':
 			no_control = 0;
-			strncpy(ctrl_cdev, optarg, CDEV_NAME_SIZE);
+			strncpy(ctrl_cdev, optarg, CDEV_NAME_SIZE - 1);
+			ctrl_cdev[CDEV_NAME_SIZE - 1] = '\0';
 			break;
 		case 'd':
 			start_daemon_mode();
-- 
2.20.1

