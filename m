Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556BD2EBB25
	for <lists+linux-pm@lfdr.de>; Wed,  6 Jan 2021 09:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbhAFIhf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Jan 2021 03:37:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53644 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbhAFIhe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Jan 2021 03:37:34 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1068VNI4052402;
        Wed, 6 Jan 2021 08:36:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=q+KJ8AfPkiSCHLPRdLSxb87gjhWi/QLcykmElkTz1T0=;
 b=yoTjTwaXig6Czqfr4rcKDk7U2dVFqJQKrVm4tXkcxaCkVSo9eFMr6B4hIz+0BpdZGaqF
 m3V0rg/djTklghEcNJwa4rOVgvLOwu4v/AhiJoo9GQTqMoRQ3vwb8Oe0AzpZ275kkLTN
 f4EL9CRw1PiFLu5DLQbrj+Qijv07LsBvesJT8im8LClS/NKKEVtVx8tddj05/79FGyIo
 OW7nUXLNDdYlaB2iYe4b0jJRKTmzPxxJMKejYJC1I0+GEiB+AZlCT91ekYxkeHKKjHYo
 LWdxkNGc/e8wKleqHKS1QYyJEPtSQ4LvlDMB4tAZQxZB+uDOe9FLbL1E3kqqy2B5zVtI 3g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35w53b0r1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 06 Jan 2021 08:36:47 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1068XAha042304;
        Wed, 6 Jan 2021 08:36:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 35w3g0p66r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Jan 2021 08:36:47 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1068ajMG027546;
        Wed, 6 Jan 2021 08:36:45 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Jan 2021 08:36:44 +0000
Date:   Wed, 6 Jan 2021 11:36:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/3] powercap/drivers/dtpm: Fix a double shift bug
Message-ID: <X/V2k8dwaXJH6VFh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060051
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1011 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060051
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The DTPM_POWER_LIMIT_FLAG is used for test_bit() etc which take a bit
number so it should be bit 0.  But currently it's set to BIT(0) then
that is double shifted equivalent to BIT(BIT(0)).  This doesn't cause a
run time problem because it's done consistently.

Fixes: a20d0ef97abf ("powercap/drivers/dtpm: Add API for dynamic thermal power management")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/powercap/dtpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
index 0abcc439d728..d49df0569cd4 100644
--- a/drivers/powercap/dtpm.c
+++ b/drivers/powercap/dtpm.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 
-#define DTPM_POWER_LIMIT_FLAG BIT(0)
+#define DTPM_POWER_LIMIT_FLAG 0
 
 static const char *constraint_name[] = {
 	"Instantaneous",
-- 
2.29.2

