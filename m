Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCF842655D
	for <lists+linux-pm@lfdr.de>; Fri,  8 Oct 2021 09:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhJHHsw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Oct 2021 03:48:52 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24223 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhJHHsw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Oct 2021 03:48:52 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HQgGp14v5zPjtP;
        Fri,  8 Oct 2021 15:45:54 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 15:46:55 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Fri, 8 Oct
 2021 15:46:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <vireshk@kernel.org>, <nm@ti.com>, <sboyd@kernel.org>,
        <d-gerlach@ti.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] opp: Fix return in _opp_add_static_v2()
Date:   Fri, 8 Oct 2021 15:46:52 +0800
Message-ID: <20211008074652.19700-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix sparse warning:
drivers/opp/of.c:924 _opp_add_static_v2() warn: passing zero to 'ERR_PTR'

For duplicate OPPs 'ret' be set to zero.

Fixes: deac8703da5f ("PM / OPP: _of_add_opp_table_v2(): increment count only if OPP is added")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/opp/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 2a97c6535c4c..c32ae7497392 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -921,7 +921,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
 free_opp:
 	_opp_free(new_opp);
 
-	return ERR_PTR(ret);
+	return ret ? ERR_PTR(ret) : NULL;
 }
 
 /* Initializes OPP tables based on new bindings */
-- 
2.17.1

