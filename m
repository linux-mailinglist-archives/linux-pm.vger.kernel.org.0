Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA0F6676E
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfGLHFw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jul 2019 03:05:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbfGLHFw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2019 03:05:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6C732NJ140862
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2019 03:05:51 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpn4s0xdf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2019 03:05:50 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Fri, 12 Jul 2019 08:05:48 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 08:05:44 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6C75hMS36175986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 07:05:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C704252069;
        Fri, 12 Jul 2019 07:05:43 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5C2A952054;
        Fri, 12 Jul 2019 07:05:42 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     npiggin@gmail.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        mpe@ellerman.id.au, ego@linux.vnet.ibm.com, dja@axtens.net,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC v4 2/3] cpuidle : Add callback whenever a state usage is enabled/disabled
Date:   Fri, 12 Jul 2019 02:04:56 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712070457.55242-1-huntbag@linux.vnet.ibm.com>
References: <20190712070457.55242-1-huntbag@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19071207-0016-0000-0000-00000291FA78
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071207-0017-0000-0000-000032EFBD4A
Message-Id: <20190712070457.55242-3-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=838 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120072
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

To force wakeup a cpu, we need to compute the timeout in the fast idle
path as a state may be enabled or disabled but there did not exist a
feedback to driver when a state is enabled or disabled.
This patch adds a callback whenever a state_usage records a store for
disable attribute.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 drivers/cpuidle/sysfs.c | 15 ++++++++++++++-
 include/linux/cpuidle.h |  4 ++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index eb20adb5de23..141671a53967 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -415,8 +415,21 @@ static ssize_t cpuidle_state_store(struct kobject *kobj, struct attribute *attr,
 	struct cpuidle_state_usage *state_usage = kobj_to_state_usage(kobj);
 	struct cpuidle_state_attr *cattr = attr_to_stateattr(attr);
 
-	if (cattr->store)
+	if (cattr->store) {
 		ret = cattr->store(state, state_usage, buf, size);
+		if (ret == size &&
+			strncmp(cattr->attr.name, "disable",
+						strlen("disable"))) {
+			struct kobject *cpuidle_kobj = kobj->parent;
+			struct cpuidle_device *dev =
+					to_cpuidle_device(cpuidle_kobj);
+			struct cpuidle_driver *drv =
+					cpuidle_get_cpu_driver(dev);
+
+			if (drv->disable_callback)
+				drv->disable_callback(dev, drv);
+		}
+	}
 
 	return ret;
 }
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index bb9a0db89f1a..8a0e54bd0d5d 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -119,6 +119,10 @@ struct cpuidle_driver {
 
 	/* the driver handles the cpus in cpumask */
 	struct cpumask		*cpumask;
+
+	void (*disable_callback)(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv);
+
 };
 
 #ifdef CONFIG_CPU_IDLE
-- 
2.17.1

