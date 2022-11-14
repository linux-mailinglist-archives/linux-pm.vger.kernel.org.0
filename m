Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BE462766A
	for <lists+linux-pm@lfdr.de>; Mon, 14 Nov 2022 08:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbiKNHcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Nov 2022 02:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiKNHcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Nov 2022 02:32:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C685F186EE
        for <linux-pm@vger.kernel.org>; Sun, 13 Nov 2022 23:32:23 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AE6wrPQ038411;
        Mon, 14 Nov 2022 07:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=5E0yXPl1ftpSTjRgXfzjfIiMloq0mA6tfUDHkX+TFOY=;
 b=EPV8kVYtCG0VjyfDwfOYRzR+Yc80oEl5wrRfwLXpjTHUZYk+J8ffJ19WlZM/ygXSH0Lz
 48rpJYQdn7i/I56iz1fpJxsOvIKwxlKoaZWDl7EffRTNBOAGC8KUHuswpkzlyeVawZH1
 2jZ99k7y9ETWAFe7jh1NhAciY/xv87qQI+dPSriKZ5xWmX56KA250PgM4UFBuAmnfhFO
 4r1hlSUQyTnvZ0chJuNmAPpDJ54iDi91SlUIwV5nDYvuKV/ONRzO9JRqxKSJ+/Yl8yRT
 XQOp5laSfJa4TGn8CSm0MRiEHHsi0ib/ESgx+Eab52DPtb9C157R12sfEEm80bwmP+J3 xA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kugvq0pnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 07:32:08 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AE7KFxV033657;
        Mon, 14 Nov 2022 07:32:08 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kugvq0pn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 07:32:08 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AE7KYu7003111;
        Mon, 14 Nov 2022 07:32:07 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3kt349c885-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 07:32:07 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AE7W4kW16974288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 07:32:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5DF758051;
        Mon, 14 Nov 2022 07:32:05 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25AA35805A;
        Mon, 14 Nov 2022 07:32:02 +0000 (GMT)
Received: from li-87263a4c-1efe-11b2-a85c-b6723e0c5f8d.ibm.com.com (unknown [9.43.65.55])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 14 Nov 2022 07:32:01 +0000 (GMT)
From:   Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
To:     mpe@ellerman.id.au, svaidy@linux.vnet.ibm.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, npiggin@gmail.com
Cc:     srikar@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/cpuidle: Set CPUIDLE_FLAG_POLLING for snooze state
Date:   Mon, 14 Nov 2022 13:01:54 +0530
Message-Id: <20221114073154.30407-1-aboorvad@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: np6J5Jul7JMPH9RKmeQ2x20SbJyex8M8
X-Proofpoint-ORIG-GUID: ZGyTlQ8YciXcoc66ni_ZRVBtswe1Jtsq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_06,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211140055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

During the comparative study of cpuidle governors, it is noticed that the
menu governor does not select CEDE state in some scenarios even though when
the sleep duration of the CPU exceeds the target residency of the CEDE idle
state this is because the CPU exits the snooze "polling" state when snooze 
time limit is reached in the snooze_loop(), which is not a real wake up 
and it just means that the polling state selection was not adequate.

cpuidle governors rely on CPUIDLE_FLAG_POLLING flag to be set for the
polling states to handle the condition mentioned above.

Hence, set the CPUIDLE_FLAG_POLLING flag for the snooze state (polling state)
in powerpc arch to make the cpuidle governor work as expected.

Reference Commits:

- Timeout enabled for snooze state:
  commit 78eaa10f027c
  ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")

- commit dc2251bf98c6
  ("cpuidle: Eliminate the CPUIDLE_DRIVER_STATE_START symbol")

- Fix wakeup stats in governor for polling states
  commit 5f26bdceb9c0
  ("cpuidle: menu: Fix wakeup statistics updates for polling state")

Signed-off-by: Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 5 ++++-
 drivers/cpuidle/cpuidle-pseries.c | 8 ++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 0b5461b3d7dd..9ebedd972df0 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -76,6 +76,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 	local_irq_enable();
 
 	snooze_exit_time = get_tb() + get_snooze_timeout(dev, drv, index);
+	dev->poll_time_limit = false;
 	ppc64_runlatch_off();
 	HMT_very_low();
 	while (!need_resched()) {
@@ -86,6 +87,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 			 * cleared to order subsequent test of need_resched().
 			 */
 			clear_thread_flag(TIF_POLLING_NRFLAG);
+			dev->poll_time_limit = true;
 			smp_mb();
 			break;
 		}
@@ -155,7 +157,8 @@ static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] = {
 		.desc = "snooze",
 		.exit_latency = 0,
 		.target_residency = 0,
-		.enter = snooze_loop },
+		.enter = snooze_loop,
+		.flags = CPUIDLE_FLAG_POLLING },
 };
 
 static int powernv_cpuidle_cpu_online(unsigned int cpu)
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 7e7ab5597d7a..7538aa63f972 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -44,6 +44,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 	pseries_idle_prolog();
 	local_irq_enable();
 	snooze_exit_time = get_tb() + snooze_timeout;
+	dev->poll_time_limit = false;
 
 	while (!need_resched()) {
 		HMT_low();
@@ -54,6 +55,7 @@ static int snooze_loop(struct cpuidle_device *dev,
 			 * loop anyway. Require a barrier after polling is
 			 * cleared to order subsequent test of need_resched().
 			 */
+			dev->poll_time_limit = true;
 			clear_thread_flag(TIF_POLLING_NRFLAG);
 			smp_mb();
 			break;
@@ -268,13 +270,15 @@ static struct cpuidle_state dedicated_states[NR_DEDICATED_STATES] = {
 		.desc = "snooze",
 		.exit_latency = 0,
 		.target_residency = 0,
-		.enter = &snooze_loop },
+		.enter = &snooze_loop,
+		.flags = CPUIDLE_FLAG_POLLING },
 	{ /* CEDE */
 		.name = "CEDE",
 		.desc = "CEDE",
 		.exit_latency = 10,
 		.target_residency = 100,
-		.enter = &dedicated_cede_loop },
+		.enter = &snooze_loop,
+		.flags = CPUIDLE_FLAG_POLLING },
 };
 
 /*
-- 
2.17.1

