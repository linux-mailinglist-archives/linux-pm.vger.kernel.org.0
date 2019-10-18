Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F4DBB02
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 02:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408807AbfJRAuE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Oct 2019 20:50:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47822 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409035AbfJRAuE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2019 20:50:04 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I0nTs9071784;
        Fri, 18 Oct 2019 00:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=+vwT+5KKYBbhbI7WHloSzb4suphzKe7v/mQR2yYzwfU=;
 b=MvFua4TkOjApWPLtYD2KnpMfwnJfhr3+ZFJfqKnUAjZ78Er9g7ji7tb8M1Opf5JBl2n+
 jox1IMVarjVuN7luOrLb5djtEd9S4RbZVdJ4VlyTs7eLKiK/dzzklGTKSwzQShxJ08ij
 7ZiodKS3kvV7vk8jANlomTgycSiwYf396gVLSGyALkWzVXG26OLSIF2sWJvQoXUzDN6T
 9fN4q7uEKsuiKolL7qiCFNw7HyqxllLlLbO9Bnvn33yQQLY+eXTtT1fcTLZof+yY6+w5
 9zEz4laGZ1F9OSZa/aaBNG8WQGqDrFFt/DXqZm+0owD51gLm5ML0yUwVBsJAgzFjjklc 5A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vq0q48g89-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 00:49:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I0mXMm074602;
        Fri, 18 Oct 2019 00:49:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2vq0ev1g7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 00:49:48 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9I0nl0n027845;
        Fri, 18 Oct 2019 00:49:47 GMT
Received: from z2.cn.oracle.com (/10.182.70.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 00:49:46 +0000
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mtosatti@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [PATCH v2] cpuidle-haltpoll: make haltpoll aware of 'idle=' override
Date:   Fri, 18 Oct 2019 08:49:29 +0800
Message-Id: <1571359769-32040-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=854
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=941 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910180005
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currenly haltpoll isn't aware of the 'idle=' override, the priority is
'idle=poll' > haltpoll > 'idle=halt'. When 'idle=poll' is used, cpuidle
driver is bypassed but current_driver in sys still shows 'haltpoll'.

When 'idle=halt' is used, haltpoll take precedence and make 'idle=halt'
no effect.

Add a check to not load haltpoll driver if there is 'idle='.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
v2: remove #if guard per Rafael

 drivers/cpuidle/cpuidle-haltpoll.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index 932390b..b0ce9bc 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -95,6 +95,10 @@ static int __init haltpoll_init(void)
 	int ret;
 	struct cpuidle_driver *drv = &haltpoll_driver;
 
+	/* Do not load haltpoll if idle= is passed */
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
+		return -ENODEV;
+
 	cpuidle_poll_state_init(drv);
 
 	if (!kvm_para_available() ||
-- 
1.8.3.1

