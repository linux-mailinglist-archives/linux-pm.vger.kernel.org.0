Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8905B66772
	for <lists+linux-pm@lfdr.de>; Fri, 12 Jul 2019 09:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfGLHGl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Jul 2019 03:06:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725871AbfGLHGk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jul 2019 03:06:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6C76Fxt075053
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2019 03:06:39 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpj2my0g7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 12 Jul 2019 03:06:32 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <huntbag@linux.vnet.ibm.com>;
        Fri, 12 Jul 2019 08:05:55 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 08:05:53 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6C75q0p36700450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 07:05:52 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B7805204E;
        Fri, 12 Jul 2019 07:05:52 +0000 (GMT)
Received: from boston16h.aus.stglabs.ibm.com (unknown [9.3.23.78])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B98D952051;
        Fri, 12 Jul 2019 07:05:50 +0000 (GMT)
From:   Abhishek Goel <huntbag@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org
Cc:     npiggin@gmail.com, rjw@rjwysocki.net, daniel.lezcano@linaro.org,
        mpe@ellerman.id.au, ego@linux.vnet.ibm.com, dja@axtens.net,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [RFC v4 3/3] cpuidle-powernv : Recompute the idle-state timeouts when state usage is enabled/disabled
Date:   Fri, 12 Jul 2019 02:04:57 -0500
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712070457.55242-1-huntbag@linux.vnet.ibm.com>
References: <20190712070457.55242-1-huntbag@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19071207-0016-0000-0000-00000291FA7D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071207-0017-0000-0000-000032EFBD50
Message-Id: <20190712070457.55242-4-huntbag@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120072
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The disable callback can be used to compute timeout for other states
whenever a state is enabled or disabled. We store the computed timeout
in "timeout" defined in cpuidle state strucure. So, we compute timeout
only when some state is enabled or disabled and not every time in the
fast idle path.
We also use the computed timeout to get timeout for snooze, thus getting
rid of get_snooze_timeout for snooze loop.

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 35 +++++++++++--------------------
 include/linux/cpuidle.h           |  1 +
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 17e20e408ffe..29add322d0c4 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -45,7 +45,6 @@ struct stop_psscr_table {
 static struct stop_psscr_table stop_psscr_table[CPUIDLE_STATE_MAX] __read_mostly;
 
 static u64 default_snooze_timeout __read_mostly;
-static bool snooze_timeout_en __read_mostly;
 
 static u64 forced_wakeup_timeout(struct cpuidle_device *dev,
 				 struct cpuidle_driver *drv,
@@ -67,26 +66,13 @@ static u64 forced_wakeup_timeout(struct cpuidle_device *dev,
 	return 0;
 }
 
-static u64 get_snooze_timeout(struct cpuidle_device *dev,
-			      struct cpuidle_driver *drv,
-			      int index)
+static void pnv_disable_callback(struct cpuidle_device *dev,
+				 struct cpuidle_driver *drv)
 {
 	int i;
 
-	if (unlikely(!snooze_timeout_en))
-		return default_snooze_timeout;
-
-	for (i = index + 1; i < drv->state_count; i++) {
-		struct cpuidle_state *s = &drv->states[i];
-		struct cpuidle_state_usage *su = &dev->states_usage[i];
-
-		if (s->disabled || su->disable)
-			continue;
-
-		return s->target_residency * tb_ticks_per_usec;
-	}
-
-	return default_snooze_timeout;
+	for (i = 0; i < drv->state_count; i++)
+		drv->states[i].timeout = forced_wakeup_timeout(dev, drv, i);
 }
 
 static int snooze_loop(struct cpuidle_device *dev,
@@ -94,16 +80,20 @@ static int snooze_loop(struct cpuidle_device *dev,
 			int index)
 {
 	u64 snooze_exit_time;
+	u64 snooze_timeout = drv->states[index].timeout;
+
+	if (!snooze_timeout)
+		snooze_timeout = default_snooze_timeout;
 
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
 	local_irq_enable();
 
-	snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
+	snooze_exit_time = get_tb() + snooze_timeout;
 	ppc64_runlatch_off();
 	HMT_very_low();
 	while (!need_resched()) {
-		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
+		if (get_tb() > snooze_exit_time) {
 			/*
 			 * Task has not woken up but we are exiting the polling
 			 * loop anyway. Require a barrier after polling is
@@ -168,7 +158,7 @@ static int stop_loop(struct cpuidle_device *dev,
 	u64 timeout_tb;
 	bool forced_wakeup = false;
 
-	timeout_tb = forced_wakeup_timeout(dev, drv, index);
+	timeout_tb = drv->states[index].timeout;
 
 	/* Ensure that the timeout is at least one microsecond
 	 * greater than current decrement value. Else, we will
@@ -263,6 +253,7 @@ static int powernv_cpuidle_driver_init(void)
 	 */
 
 	drv->cpumask = (struct cpumask *)cpu_present_mask;
+	drv->disable_callback = pnv_disable_callback;
 
 	return 0;
 }
@@ -422,8 +413,6 @@ static int powernv_idle_probe(void)
 		/* Device tree can indicate more idle states */
 		max_idle_state = powernv_add_idle_states();
 		default_snooze_timeout = TICK_USEC * tb_ticks_per_usec;
-		if (max_idle_state > 1)
-			snooze_timeout_en = true;
  	} else
  		return -ENODEV;
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 8a0e54bd0d5d..31662b657b9c 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -50,6 +50,7 @@ struct cpuidle_state {
 	int		power_usage; /* in mW */
 	unsigned int	target_residency; /* in US */
 	bool		disabled; /* disabled on all CPUs */
+	unsigned long long timeout; /* timeout for exiting out of a state */
 
 	int (*enter)	(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
-- 
2.17.1

