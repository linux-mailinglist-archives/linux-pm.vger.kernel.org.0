Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC79DA2C6
	for <lists+linux-pm@lfdr.de>; Thu, 17 Oct 2019 02:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfJQAlT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 20:41:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47790 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfJQAlT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 20:41:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H0Tci2054010;
        Thu, 17 Oct 2019 00:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=hz+5f6iLUqcsD4s/JDp34cnZKqTf0cQyrV5VqWsRJSg=;
 b=ou7y+4ZXtq6FvVzAlIpvfIRcRF74cR/PrexWYRrcJdBZt8F6oNpKO7Kk8FvvqMk4ylVn
 9/Y+wL2emggLxopUh4WScKUOc6NEQtE9xp5axlhZUQM+YsV0DnMO0EeC3EYI8NO59DLF
 3X/GtqpDEHSedQiE6h2tEYnI+/aH7XEvO9wCOaeicvkapotOhC7+nMR5RiDanHLSwU2j
 jwLNGcjnyqIqvkOvA8g3qN9LuyVIM2/5anfl/fLTh873VIgz7EJ+bwAoiZUYX3pZfWEs
 P8667totgyTYCvgftiEOtb4QRm5PaTa7zhMoucybPqt9+4T18DuxflHkl4OxgUZqVaw1 iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2vk68utp35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 00:41:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9H0SPtW167879;
        Thu, 17 Oct 2019 00:41:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2vp70nvkv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 00:41:04 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9H0f2Vh022438;
        Thu, 17 Oct 2019 00:41:02 GMT
Received: from z2.cn.oracle.com (/10.182.70.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 00:41:01 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mtosatti@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH] cpuidle-haltpoll: make haltpoll aware of 'idle=' override
Date:   Thu, 17 Oct 2019 08:39:10 +0800
Message-Id: <1571272750-29798-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9412 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170001
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currenly haltpoll isn't aware of the 'idle=' override, the priority is
'idle=poll' > haltpoll > 'idle=halt'. When 'idle=poll' is used, cpuidle
driver is bypassed but current_driver in sys still shows 'haltpoll'.

When 'idle=halt' is used, haltpoll take precedence and make 'idle=halt'
no effect.

Add a check to not load haltpoll driver if there is 'idle=' and haltpoll
is built in. If haltpoll is built as a module, still give a chance for
admin to use it despite 'idle='.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/cpuidle/cpuidle-haltpoll.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index 932390b..00e9821 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -95,6 +95,12 @@ static int __init haltpoll_init(void)
 	int ret;
 	struct cpuidle_driver *drv = &haltpoll_driver;
 
+#if !defined(CONFIG_HALTPOLL_CPUIDLE_MODULE)
+	/* Do not load haltpoll if idle= is passed */
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
+		return -ENODEV;
+#endif
+
 	cpuidle_poll_state_init(drv);
 
 	if (!kvm_para_available() ||
-- 
1.8.3.1

