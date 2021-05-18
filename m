Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F9A387994
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 15:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbhERNNQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 09:13:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3022 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhERNNP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 09:13:15 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkxDN6CN2zlgJp;
        Tue, 18 May 2021 21:09:40 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 21:11:56 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 21:11:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <amitk@kernel.org>, <daniel.lezcano@linaro.org>
Subject: [PATCH -next] thermal: thermal_of: Correct struct name __thermal_bind_params
Date:   Tue, 18 May 2021 21:14:08 +0800
Message-ID: <20210518131408.1310057-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix the following make W=1 kernel build warning:

   drivers/thermal/thermal_of.c:50: warning: expecting prototype for struct __thermal_bind_param. Prototype was for struct __thermal_bind_params instead

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/thermal/thermal_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index 5b76f9a1280d..e86389fa1431 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -35,7 +35,7 @@ struct __thermal_cooling_bind_param {
 };
 
 /**
- * struct __thermal_bind_param - a match between trip and cooling device
+ * struct __thermal_bind_params - a match between trip and cooling device
  * @tcbp: a pointer to an array of cooling devices
  * @count: number of elements in array
  * @trip_id: the trip point index
-- 
2.25.1

