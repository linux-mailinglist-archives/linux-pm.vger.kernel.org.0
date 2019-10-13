Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B167D5919
	for <lists+linux-pm@lfdr.de>; Mon, 14 Oct 2019 02:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfJNAnr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Oct 2019 20:43:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43834 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbfJNAnq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Oct 2019 20:43:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9E0f906136448;
        Mon, 14 Oct 2019 00:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=77664crqggBs6vqUBErJUe+tfNhGlZupqkwqa4ZPD94=;
 b=D25DMKKkY6e9st02pwZm5u2GptW5e3vzLJDJuZuQEEkcoX6pJKoHJzFfGafZZyb3cFLS
 YTcoNlit9wgUdb0eH4nhDRxQroACznJkNaVr0OPwj2AxPqPtAhYI8HpFGlWQpYPLW6E7
 mZ+n8tM/OPvmdLSUfpeg2yRMED7kYB9hwOW6sodcItkWg6CEynb0n1OpJ8b5tonG7Fg+
 hb72pv0gFCBuIpIhhAcm7z3+nG94FGKPIQBKw+j3yo7yWScCzEixYRN5gDionbrtY1G9
 E9ccD3evlZatnMlSGClwirBSUaLi/zJB1HJC9971A4BFso3LfVdbuKeLikJZwgzwfE6D zg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2vk7fqw6us-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 00:43:37 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9E0djRW124185;
        Mon, 14 Oct 2019 00:41:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2vkrbhr5cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 00:41:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9E0fYrd030219;
        Mon, 14 Oct 2019 00:41:34 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 14 Oct 2019 00:41:34 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mtosatti@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH] cpuidle: not unset the driver if it already exist
Date:   Sun, 13 Oct 2019 08:46:26 +0800
Message-Id: <1570927586-12023-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=799
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910140003
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9409 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=885 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910140003
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

__cpuidle_set_driver() check if there is an already exist driver and
unset it before return with -EBUSY. The next call will succeed as it's
just unset. This is strange as we should either keep old driver and
return -EBUSY or unset and set new driver and return 0.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 drivers/cpuidle/driver.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 80c1a83..a200304 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -74,7 +74,6 @@ static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
 	for_each_cpu(cpu, drv->cpumask) {
 
 		if (__cpuidle_get_cpu_driver(cpu)) {
-			__cpuidle_unset_driver(drv);
 			return -EBUSY;
 		}
 
-- 
1.8.3.1

