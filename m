Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4CF6D4E49
	for <lists+linux-pm@lfdr.de>; Sat, 12 Oct 2019 10:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfJLIam (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Oct 2019 04:30:42 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfJLIam (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 12 Oct 2019 04:30:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9C8TRJK195161;
        Sat, 12 Oct 2019 08:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=DvkPmvgpRjxjpBe2LUXihgz5mIyBG+fGwIcFtLVc8eU=;
 b=V1+TiLL44U75vKOu80qTolOC/DwuMA6XIKiPLz1FDZwLQgtSk59XPg4xVOJpr9hpNFl7
 7LXvHwanJyO8aFIOVMNfRDUcyPG30Bb8pbqIjZ9YgvaT/inxOllqBfaL2hzGstTukEFh
 7GW+sOnwKLrEzZtwQjY8zo/uk0F5p1X2uUnKWhxaaSmEtAzjxdy2yotLfWfY/LAMtxvq
 K5KH4MloQgbtqcQ/eYYKl4pDxmBlNce7XddW+6P+g33eXTbynmWkjYP2mSqKHJC+LglY
 ep48K3KfodpNQMEUBWqMwODPSFK5ncFuVsTgvdfn7t1nLYF5C2v7dpPzngccl/wvDN7M 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vk6sq0nh3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Oct 2019 08:30:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9C8SDuu038208;
        Sat, 12 Oct 2019 08:30:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vk4vr903r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Oct 2019 08:30:24 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9C8ULk9000414;
        Sat, 12 Oct 2019 08:30:21 GMT
Received: from z2.cn.oracle.com (/10.182.71.205)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 12 Oct 2019 01:30:21 -0700
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, mtosatti@redhat.com,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: [PATCH] cpuidle: cpu hotplug support
Date:   Fri, 11 Oct 2019 16:34:59 +0800
Message-Id: <1570782899-31455-1-git-send-email-zhenzhong.duan@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910120079
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9407 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910120079
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently cpuidle driver doesn't support cpu hotplug. When
cpus != maxcpus cpuidle_register() will fail to register all cpus
past the online ones and thus fail to register the idle driver.
This is because cpuidle_add_sysfs() will return with -ENODEV as a
consequence from get_cpu_device() return no device for a non-existing
CPU.

At least cpuidle-haltpoll and intel_idle are making their own custom
code to support cpu hotplug.

This patch ease the work if we need to write a cpuidle driver with cpu
hotplug support in the future.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
---
 drivers/cpuidle/cpuidle.c | 76 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 24 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 0895b98..3ce6d2d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -558,6 +558,51 @@ static void __cpuidle_device_init(struct cpuidle_device *dev)
 	dev->next_hrtimer = 0;
 }
 
+static int cpuidle_cpu_online(unsigned int cpu)
+{
+	int ret;
+	struct cpuidle_device *device;
+	struct cpuidle_driver *drv;
+
+	device = &per_cpu(cpuidle_dev, cpu);
+	device->cpu = cpu;
+
+	drv = cpuidle_get_cpu_driver(device);
+	if (!drv || !cpumask_test_cpu(cpu, drv->cpumask))
+		return 0;
+
+#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
+	/*
+	 * On multiplatform for ARM, the coupled idle states could be
+	 * enabled in the kernel even if the cpuidle driver does not
+	 * use it. Note, coupled_cpus is a struct copy.
+	 */
+	if (coupled_cpus)
+		device->coupled_cpus = *coupled_cpus;
+#endif
+	ret = cpuidle_register_device(device);
+	if (ret)
+		pr_err("Failed to register cpuidle device for cpu%d\n", cpu);
+
+	return ret;
+}
+
+static int cpuidle_cpu_offline(unsigned int cpu)
+{
+	struct cpuidle_device *device;
+	struct cpuidle_driver *drv;
+
+	device = &per_cpu(cpuidle_dev, cpu);
+
+	drv = cpuidle_get_cpu_driver(device);
+	if (!drv || !cpumask_test_cpu(cpu, drv->cpumask))
+		return 0;
+
+	cpuidle_unregister_device(device);
+
+	return 0;
+}
+
 /**
  * __cpuidle_register_device - internal register function called before register
  * and enable routines
@@ -690,8 +735,8 @@ void cpuidle_unregister(struct cpuidle_driver *drv)
 int cpuidle_register(struct cpuidle_driver *drv,
 		     const struct cpumask *const coupled_cpus)
 {
-	int ret, cpu;
-	struct cpuidle_device *device;
+	int ret;
+	char cb_name[64];
 
 	ret = cpuidle_register_driver(drv);
 	if (ret) {
@@ -699,28 +744,11 @@ int cpuidle_register(struct cpuidle_driver *drv,
 		return ret;
 	}
 
-	for_each_cpu(cpu, drv->cpumask) {
-		device = &per_cpu(cpuidle_dev, cpu);
-		device->cpu = cpu;
-
-#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
-		/*
-		 * On multiplatform for ARM, the coupled idle states could be
-		 * enabled in the kernel even if the cpuidle driver does not
-		 * use it. Note, coupled_cpus is a struct copy.
-		 */
-		if (coupled_cpus)
-			device->coupled_cpus = *coupled_cpus;
-#endif
-		ret = cpuidle_register_device(device);
-		if (!ret)
-			continue;
-
-		pr_err("Failed to register cpuidle device for cpu%d\n", cpu);
-
-		cpuidle_unregister(drv);
-		break;
-	}
+	sprintf(cb_name, "cpuidle/%s:online", drv->name);
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, cb_name,
+				cpuidle_cpu_online, cpuidle_cpu_offline);
+	if (ret < 0)
+		cpuidle_unregister_driver(drv);
 
 	return ret;
 }
-- 
1.8.3.1

