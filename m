Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB69E0FDA
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfJWB7i (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Oct 2019 21:59:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38032 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbfJWB7i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Oct 2019 21:59:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N1t6RI028643;
        Wed, 23 Oct 2019 01:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=vumlNhIDpEfgHxXgVPRZJkF7ivtI8M5hQwk1p8n3CZg=;
 b=Q97sViVSujkG1sGSwXzfEd1u5r0ZEV1JPXEvOzhGXss/yMBx6dOe80WT9QT1CXozWkNZ
 cm7m6AI8A1xFAztt1FTrgDUR5PUmCXTCweyHZh6JZI55TIFWQEQgaT0S3VCiDOyO53jH
 sQlWdRvkafHU1w/l+8EEGtTDI1uh9+Fm3UMiaVlima3+t2f415DdCAqLRO/mRL7QZrkj
 Ifu8AnNswKFrI8gamOPcXpyZASodvOeHqDHcNoUebYFZFsi3TYCHFiXfF0e1AOLhDIEV
 OmEgcUI4bXkktMjPXColBm92/lW9XztDPR7jBNzOyzMrfUCGOYunOhDod5ZkJPkcc0vF /A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vqswtjcdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 01:59:19 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9N1sGPI043034;
        Wed, 23 Oct 2019 01:59:19 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vsp40wrt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 01:59:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9N1xFLZ011819;
        Wed, 23 Oct 2019 01:59:17 GMT
Received: from z2.cn.oracle.com (/10.182.71.218)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Oct 2019 18:59:14 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mtosatti@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH v2] cpuidle: not unset the driver if it already exist
Date:   Wed, 23 Oct 2019 09:57:14 +0800
Message-Id: <1571795834-2027-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9418 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230017
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

__cpuidle_set_driver() check if there is an already exist driver and
unset it before return with -EBUSY. The next call will succeed as it's
just unset.

check if any of the CPUs in the mask have a driver different from drv
already and if so return -EBUSY before updating any cpuidle_drivers
per-CPU pointers.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
v2: update code logic per Rafael

 drivers/cpuidle/driver.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
index 80c1a83..acfce04 100644
--- a/drivers/cpuidle/driver.c
+++ b/drivers/cpuidle/driver.c
@@ -62,24 +62,23 @@ static inline void __cpuidle_unset_driver(struct cpuidle_driver *drv)
  * __cpuidle_set_driver - set per CPU driver variables for the given driver.
  * @drv: a valid pointer to a struct cpuidle_driver
  *
- * For each CPU in the driver's cpumask, unset the registered driver per CPU
- * to @drv.
- *
- * Returns 0 on success, -EBUSY if the CPUs have driver(s) already.
+ * Returns 0 on success, -EBUSY if any CPU in the cpumask have a driver
+ * different from drv already.
  */
 static inline int __cpuidle_set_driver(struct cpuidle_driver *drv)
 {
 	int cpu;
 
 	for_each_cpu(cpu, drv->cpumask) {
+		struct cpuidle_driver *old_drv;
 
-		if (__cpuidle_get_cpu_driver(cpu)) {
-			__cpuidle_unset_driver(drv);
+		old_drv = __cpuidle_get_cpu_driver(cpu);
+		if (old_drv && old_drv != drv)
 			return -EBUSY;
-		}
+	}
 
+	for_each_cpu(cpu, drv->cpumask)
 		per_cpu(cpuidle_drivers, cpu) = drv;
-	}
 
 	return 0;
 }
-- 
1.8.3.1

