Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8FC2EBB7F
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 10:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbhAFJEO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 04:04:14 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:47750 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAFJEK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 04:04:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1068svIb124489;
        Wed, 6 Jan 2021 09:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=Arf8NPz03B6bGi6vbZIcGitheyWLUU4PlpI/Raiv2jk=;
 b=ACcL2M/RvrcFiuxiQV6Dey5+WfKGOT5vGLNVSYhElN2ojhyo3oBOZ4NDcVMbZXrGHd8d
 I+LA8LECSVqy5h1FPCpWEYB4Jo/xt+G4bzMNuR0kfT/eYi9CGuxeRCMxFGhCRHjfh2dU
 C8wHyAbAZ70ryB0bghuF/VOmthshFhBTztamOzH9V3nyjJYwByOKJLYf/9b+DnLxRGpV
 JMa92+r7f3o6fvMwEQJyITy+2dJ74Y8u8aUDWYV34vZFAIsAy7vUs1QmBv3kezLyIFsT
 jYSetIAQAhPaMhZJmEog4fLAnHOqr13+VzyuaHyjm0ATVzSSo8AoajDrF7pGv+Ts9CUl Iw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 35w7p0gfds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 09:03:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10691O71121138;
        Wed, 6 Jan 2021 09:03:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 35w3g0qfac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 09:03:22 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10693LjE021577;
        Wed, 6 Jan 2021 09:03:21 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 09:03:21 +0000
Date:   Wed, 6 Jan 2021 12:03:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 3/3] powercap/drivers/dtpm: Fix an IS_ERR() vs NULL check
Message-ID: <X/V8zHPwlGiSxq1M@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/V2k8dwaXJH6VFh@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060054
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The powercap_register_control_type() function never returns NULL, it
returns error pointers on error so update this check.

Fixes: a20d0ef97abf ("powercap/drivers/dtpm: Add API for dynamic thermal power management")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/powercap/dtpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 470a1182b868..5a51cd34a7e8 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -467,9 +467,9 @@ static int __init dtpm_init(void)
 	struct dtpm_descr **dtpm_descr;
 
 	pct = powercap_register_control_type(NULL, "dtpm", NULL);
-	if (!pct) {
+	if (IS_ERR(pct)) {
 		pr_err("Failed to register control type\n");
-		return -EINVAL;
+		return PTR_ERR(pct);
 	}
 
 	for_each_dtpm_table(dtpm_descr)
-- 
2.29.2

