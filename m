Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFD7232B64
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 07:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgG3FdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 01:33:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726133AbgG3FdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 01:33:20 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06U5X3Gg179093;
        Thu, 30 Jul 2020 01:33:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jy8whq86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 01:33:18 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06U5XIST179933;
        Thu, 30 Jul 2020 01:33:18 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jy8whq7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 01:33:18 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06U5OQIM030866;
        Thu, 30 Jul 2020 05:33:17 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 32gcq1ss2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 05:33:17 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06U5XGQg48300468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 05:33:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FCBDAE067;
        Thu, 30 Jul 2020 05:33:16 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE412AE05F;
        Thu, 30 Jul 2020 05:33:15 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.0.230])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jul 2020 05:33:15 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id D80F82E2EB8; Thu, 30 Jul 2020 11:03:09 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v3 1/3] cpuidle-pseries: Set the latency-hint before entering CEDE
Date:   Thu, 30 Jul 2020 11:02:55 +0530
Message-Id: <1596087177-30329-2-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596087177-30329-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1596087177-30329-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_03:2020-07-29,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=850
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007300042
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

As per the PAPR, each H_CEDE call is associated with a latency-hint to
be passed in the VPA field "cede_latency_hint". The CEDE states that
we were implicitly entering so far is CEDE with latency-hint = 0.

This patch explicitly sets the latency hint corresponding to the CEDE
state that we are currently entering. While at it, we save the
previous hint, to be restored once we wakeup from CEDE. This will be
required in the future when we expose extended-cede states through the
cpuidle framework, where each of them will have a different
cede-latency hint.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
v2-->v3 : Got rid of the usused NR_CEDE_STATES definition

 drivers/cpuidle/cpuidle-pseries.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 3e058ad2..f5865a2 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -86,19 +86,26 @@ static void check_and_cede_processor(void)
 	}
 }
 
+#define NR_DEDICATED_STATES	2 /* snooze, CEDE */
+
+u8 cede_latency_hint[NR_DEDICATED_STATES];
 static int dedicated_cede_loop(struct cpuidle_device *dev,
 				struct cpuidle_driver *drv,
 				int index)
 {
+	u8 old_latency_hint;
 
 	pseries_idle_prolog();
 	get_lppaca()->donate_dedicated_cpu = 1;
+	old_latency_hint = get_lppaca()->cede_latency_hint;
+	get_lppaca()->cede_latency_hint = cede_latency_hint[index];
 
 	HMT_medium();
 	check_and_cede_processor();
 
 	local_irq_disable();
 	get_lppaca()->donate_dedicated_cpu = 0;
+	get_lppaca()->cede_latency_hint = old_latency_hint;
 
 	pseries_idle_epilog();
 
@@ -130,7 +137,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 /*
  * States for dedicated partition case.
  */
-static struct cpuidle_state dedicated_states[] = {
+static struct cpuidle_state dedicated_states[NR_DEDICATED_STATES] = {
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
@@ -233,7 +240,7 @@ static int pseries_idle_probe(void)
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
 			cpuidle_state_table = dedicated_states;
-			max_idle_state = ARRAY_SIZE(dedicated_states);
+			max_idle_state = NR_DEDICATED_STATES;
 		}
 	} else
 		return -ENODEV;
-- 
1.9.4

