Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB6E431A82
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 15:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhJRNSq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 09:18:46 -0400
Received: from mx22.baidu.com ([220.181.50.185]:59552 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231565AbhJRNSi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 18 Oct 2021 09:18:38 -0400
Received: from BJHW-Mail-Ex05.internal.baidu.com (unknown [10.127.64.15])
        by Forcepoint Email with ESMTPS id D707ED9772475B8D42DD;
        Mon, 18 Oct 2021 21:16:23 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 21:16:23 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Mon, 18 Oct 2021 21:16:23 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, "Len Brown" <len.brown@intel.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel: power: swap: Make use of vzalloc() and kzalloc()
Date:   Mon, 18 Oct 2021 21:16:21 +0800
Message-ID: <20211018131622.275-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-EX02.internal.baidu.com (172.31.51.42) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex05_2021-10-18 21:16:23:876
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Replacing vmalloc()/memset() with vzalloc() and replacing
kmalloc()/memset() with kzalloc() to simplify the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 kernel/power/swap.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 9ec418955556..5e8368fa348c 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -705,22 +705,19 @@ static int save_image_lzo(struct swap_map_handle *handle,
 		goto out_clean;
 	}
 
-	data = vmalloc(array_size(nr_threads, sizeof(*data)));
+	data = vzalloc(array_size(nr_threads, sizeof(*data)));
 	if (!data) {
 		pr_err("Failed to allocate LZO data\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
-	for (thr = 0; thr < nr_threads; thr++)
-		memset(&data[thr], 0, offsetof(struct cmp_data, go));
 
-	crc = kmalloc(sizeof(*crc), GFP_KERNEL);
+	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
 		pr_err("Failed to allocate crc\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
-	memset(crc, 0, offsetof(struct crc_data, go));
 
 	/*
 	 * Start the compression threads.
@@ -1198,22 +1195,19 @@ static int load_image_lzo(struct swap_map_handle *handle,
 		goto out_clean;
 	}
 
-	data = vmalloc(array_size(nr_threads, sizeof(*data)));
+	data = vzalloc(array_size(nr_threads, sizeof(*data)));
 	if (!data) {
 		pr_err("Failed to allocate LZO data\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
-	for (thr = 0; thr < nr_threads; thr++)
-		memset(&data[thr], 0, offsetof(struct dec_data, go));
 
-	crc = kmalloc(sizeof(*crc), GFP_KERNEL);
+	crc = kzalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
 		pr_err("Failed to allocate crc\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
-	memset(crc, 0, offsetof(struct crc_data, go));
 
 	clean_pages_on_decompress = true;
 
-- 
2.25.1

