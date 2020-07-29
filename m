Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1D2319BD
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jul 2020 08:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgG2Grx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jul 2020 02:47:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1980 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbgG2Grw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2020 02:47:52 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06T6UqJx081895;
        Wed, 29 Jul 2020 02:47:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jqrsk7jb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 02:47:47 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06T6VHE2083671;
        Wed, 29 Jul 2020 02:47:46 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jqrsk7hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 02:47:46 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06T6UdlF004560;
        Wed, 29 Jul 2020 06:47:46 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 32gcy4fhd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jul 2020 06:47:46 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06T6ljld56492374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 06:47:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53BC2B2065;
        Wed, 29 Jul 2020 06:47:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F2E07B205F;
        Wed, 29 Jul 2020 06:47:44 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.85.173])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Jul 2020 06:47:44 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 9CEF82E2FB8; Wed, 29 Jul 2020 12:17:39 +0530 (IST)
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
Subject: [PATCH v2 1/3] cpuidle-pseries: Set the latency-hint before entering CEDE
Date:   Wed, 29 Jul 2020 12:17:32 +0530
Message-Id: <1596005254-25753-2-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596005254-25753-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1596005254-25753-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-29_02:2020-07-28,2020-07-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=821 bulkscore=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290041
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

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-pseries.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 3e058ad2..88e71c3 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -86,19 +86,27 @@ static void check_and_cede_processor(void)
 	}
 }
 
+#define NR_CEDE_STATES		1  /* CEDE with latency-hint 0 */
+#define NR_DEDICATED_STATES	(NR_CEDE_STATES + 1) /* Includes snooze */
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
 
@@ -130,7 +138,7 @@ static int shared_cede_loop(struct cpuidle_device *dev,
 /*
  * States for dedicated partition case.
  */
-static struct cpuidle_state dedicated_states[] = {
+static struct cpuidle_state dedicated_states[NR_DEDICATED_STATES] = {
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
-- 
1.9.4

