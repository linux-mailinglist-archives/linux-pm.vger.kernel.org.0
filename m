Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB352EBB3E
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 09:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbhAFIrW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 03:47:22 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:34418 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAFIrW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 03:47:22 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1068dQhF044099;
        Wed, 6 Jan 2021 08:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=z7ZqTjI99oyi2EBTjUIXeXaGoLqGycL6Kku7VSNhOzk=;
 b=KzrjzJmDX90z+a0bN4LKxiT/ZEzY/IGsojIef8EJw/uvjFO4ofbFDmFmqpR3kQh8+1RN
 zL2WZrLIdJ8i4sEhqIM/64MF3095UOlL8I/R8Zcw5ACpF+DqJzBn9YDRcnw4WGk8XVuV
 Sdxw7ri7bf58IIfsFG+AmIswKlHHXFgjraN9lYis7wFO8GXFhZ82xe32E3WVhmiu+YOi
 ze0QBJCFrhw2jNHN3p3W4VTPMGp8P3yrPjCiVuiT455WHM2aTXTscxTqnurgquULl2yY
 oXwZ517itfJl4FELxjP7LQniQMt5b2tI2rp3wbX0A3n9K9HBPzAdfjD+C8YdTfTbRXF6 1A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 35w7p0gdqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 08:46:36 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1068kV5T007244;
        Wed, 6 Jan 2021 08:46:35 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35v4rce8f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 08:46:34 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1068fJ8v000798;
        Wed, 6 Jan 2021 08:41:19 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 00:41:18 -0800
Date:   Wed, 6 Jan 2021 11:41:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/3] powercap/drivers/dtpm: Fix some missing unlock bugs
Message-ID: <X/V3pV//ui0rcxbs@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/V2k8dwaXJH6VFh@mwanda>
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060053
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060052
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We need to unlock on these paths before returning.

Fixes: a20d0ef97abf ("powercap/drivers/dtpm: Add API for dynamic thermal power management")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/powercap/dtpm.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index d49df0569cd4..470a1182b868 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -147,13 +147,17 @@ static void __dtpm_add_power(struct dtpm *dtpm)
  */
 int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max)
 {
+	int ret = 0;
+
 	mutex_lock(&dtpm_lock);
 
 	if (power_min == dtpm->power_min && power_max == dtpm->power_max)
-		return 0;
+		goto unlock;
 
-	if (power_max < power_min)
-		return -EINVAL;
+	if (power_max < power_min) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	__dtpm_sub_power(dtpm);
 
@@ -164,9 +168,10 @@ int dtpm_update_power(struct dtpm *dtpm, u64 power_min, u64 power_max)
 
 	__dtpm_add_power(dtpm);
 
+unlock:
 	mutex_unlock(&dtpm_lock);
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -187,8 +192,10 @@ int dtpm_release_zone(struct powercap_zone *pcz)
 
 	mutex_lock(&dtpm_lock);
 
-	if (!list_empty(&dtpm->children))
+	if (!list_empty(&dtpm->children)) {
+		mutex_unlock(&dtpm_lock);
 		return -EBUSY;
+	}
 
 	if (parent)
 		list_del(&dtpm->sibling);
-- 
2.29.2

