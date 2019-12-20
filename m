Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD392127562
	for <lists+linux-pm@lfdr.de>; Fri, 20 Dec 2019 06:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfLTFm6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Dec 2019 00:42:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60334 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfLTFm6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Dec 2019 00:42:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK5dU4b125511;
        Fri, 20 Dec 2019 05:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=EmlhOLMZ/XL52F0CFZwbVdaEIMBrdzeizGPp4YA+ooo=;
 b=dk6VejbafNmmn0RDFlG81mjQOf1hRAjfDEWIHpFRp1WyFhZO8kHcZv3si+jG57P1aJAc
 D9vghhpojyhodMi2f4qfgXRfwj85Fc0HLqGyd1cJPvjWvL+qh6FH0x/92XTLK6d6+o5n
 oeuvG7Ghc66gfmZ87FZML7CDBehU5Og6eEo9ZsmKBaVhe1Wq7IaFsXAj1EEw0pZqsCoB
 dlm7lXiL1jTtfM+BfAAiMmdoYqCesfOcrxNdUIQuc81k43cJ/+Bp8sDvh5+LJPXmgMmp
 KkWpbVs4BOMFET/5ekkNXs7ZRcMBplBeITf76OkJDyj0DZAfueQyiPm2SVFchzJ8dEgr Ug== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2x01knpryp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 05:42:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBK5dQub185823;
        Fri, 20 Dec 2019 05:40:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2x0bgmyyd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Dec 2019 05:40:50 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBK5emwe016315;
        Fri, 20 Dec 2019 05:40:49 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Dec 2019 21:40:48 -0800
Date:   Fri, 20 Dec 2019 08:40:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal/drivers/cpu_cooling: Fix an IS_ERR() vs NULL bug
Message-ID: <20191220053750.4wcxgieqmceyhwo5@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912200044
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9476 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912200044
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The idle_inject_register() function returns NULL on error, it never
returns error pointers.

Fixes: 1e044f70e5c2 ("thermal/drivers/cpu_cooling: Introduce the cpu idle cooling driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/thermal/cpuidle_cooling.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 6d778acefeec..ab48387ce868 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -187,8 +187,8 @@ __init cpuidle_of_cooling_register(struct device_node *np,
 	}
 
 	ii_dev = idle_inject_register(drv->cpumask);
-	if (IS_ERR(ii_dev)) {
-		ret = PTR_ERR(ii_dev);
+	if (!ii_dev) {
+		ret = -ENOMEM;
 		goto out_id;
 	}
 
-- 
2.11.0

