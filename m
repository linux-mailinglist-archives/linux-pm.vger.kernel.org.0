Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5C53870F6
	for <lists+linux-pm@lfdr.de>; Tue, 18 May 2021 07:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbhEREsO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 May 2021 00:48:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3575 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241542AbhEREsN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 May 2021 00:48:13 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fkk1620zczmVJt;
        Tue, 18 May 2021 12:44:10 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 12:46:55 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 18 May
 2021 12:46:54 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC:     <vireshk@kernel.org>
Subject: [PATCH -next] opp: use list_del_init instead of list_del/INIT_LIST_HEAD
Date:   Tue, 18 May 2021 12:49:10 +0800
Message-ID: <20210518044910.608878-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Using list_del_init() instead of list_del() + INIT_LIST_HEAD()
to simpify the code.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/opp/of.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index c582a9ca397b..aa75a1caf08a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -433,8 +433,7 @@ static void lazy_link_required_opp_table(struct opp_table *new_table)
 
 		/* All required opp-tables found, remove from lazy list */
 		if (!lazy) {
-			list_del(&opp_table->lazy);
-			INIT_LIST_HEAD(&opp_table->lazy);
+			list_del_init(&opp_table->lazy);
 
 			list_for_each_entry(opp, &opp_table->opp_list, node)
 				_required_opps_available(opp, opp_table->required_opp_count);
-- 
2.25.1

