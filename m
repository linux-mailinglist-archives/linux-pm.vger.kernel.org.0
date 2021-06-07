Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E6839D520
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 08:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhFGGmc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 02:42:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbhFGGmc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 02:42:32 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1576ar5c085279;
        Mon, 7 Jun 2021 02:40:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=ylMHy/A9w+QIDTFOJaoNbCLo7Ejb5ndHlc/ZCtdkuLU=;
 b=tjvM2JJdVymA22Z7h/XFCY3/DvWr4ncVUX1u0Jq9jlrbKaFIUNGnfulGOkEJdPQBxayZ
 AtycobBhuVU55DKIbIVek3h+w6Kxgcr0huCo5UKuJLB76vigrrKoF068C5v0PtPO6DIU
 p5Wsenvtd0gtDVf/k1b1wChmeMkHWeup1P9+tu/qqJoDxw0qDK9fBY4wfwMk10UmHRP2
 s97wQamBelfXZxs6Eibfa/JVe6oAzJbefkCVB/B54wul1u0wYx/9TSb0Qqknd9dtG/Ao
 8OLV3rNAxpVBUXRF+rRgII4vZnFpIRi8gB8zSArcQ15TfDBKXTMn9UkJMwkqTyTW3BCL dw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 391cpft97k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 02:40:29 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1576bTm7031134;
        Mon, 7 Jun 2021 06:40:28 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 3900w90207-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 06:40:28 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1576eSbM35127692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Jun 2021 06:40:28 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AFDAAC05B;
        Mon,  7 Jun 2021 06:40:28 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B21AAC060;
        Mon,  7 Jun 2021 06:40:27 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.199.33.79])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  7 Jun 2021 06:40:27 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 0D52F2E2E70; Mon,  7 Jun 2021 12:10:21 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc:     linux-pm@vger.kernel.org, joedecke@de.ibm.com,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Subject: [PATCH v4] cpuidle/pseries: Fixup CEDE0 latency only for POWER10 onwards
Date:   Mon,  7 Jun 2021 12:10:14 +0530
Message-Id: <1623048014-16451-1-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hmfTVJQGVyDQdTpPfrTlWNvpVyXXj2Y0
X-Proofpoint-ORIG-GUID: hmfTVJQGVyDQdTpPfrTlWNvpVyXXj2Y0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-07_06:2021-06-04,2021-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106070051
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
CEDE(0)") sets the exit latency of CEDE(0) based on the latency values
of the Extended CEDE states advertised by the platform

On POWER9 LPARs, the firmwares advertise a very low value of 2us for
CEDE1 exit latency on a Dedicated LPAR. The latency advertized by the
PHYP hypervisor corresponds to the latency required to wakeup from the
underlying hardware idle state. However the wakeup latency from the
LPAR perspective should include

1. The time taken to transition the CPU from the Hypervisor into the
   LPAR post wakeup from platform idle state

2. Time taken to send the IPI from the source CPU (waker) to the idle
   target CPU (wakee).

1. can be measured via timer idle test, where we queue a timer, say
for 1ms, and enter the CEDE state. When the timer fires, in the timer
handler we compute how much extra timer over the expected 1ms have we
consumed. On a a POWER9 LPAR the numbers are

CEDE latency measured using a timer (numbers in ns)
N       Min      Median   Avg       90%ile  99%ile    Max    Stddev
400     2601     5677     5668.74    5917    6413     9299   455.01

1. and 2. combined can be determined by an IPI latency test where we
send an IPI to an idle CPU and in the handler compute the time
difference between when the IPI was sent and when the handler ran. We
see the following numbers on POWER9 LPAR.

CEDE latency measured using an IPI (numbers in ns)
N       Min      Median   Avg       90%ile  99%ile    Max    Stddev
400     711      7564     7369.43   8559    9514      9698   1200.01

Suppose, we consider the 99th percentile latency value measured using
the IPI to be the wakeup latency, the value would be 9.5us This is in
the ballpark of the default value of 10us.

Hence, use the exit latency of CEDE(0) based on the latency values
advertized by platform only from POWER10 onwards. The values
advertized on POWER10 platforms is more realistic and informed by the
latency measurements. For earlier platforms stick to the default value
of 10us. The fix was suggested by Michael Ellerman.

Reported-by: Enrico Joedecke <joedecke@de.ibm.com>
Fixes: commit d947fb4c965c ("cpuidle: pseries: Fixup exit latency for
CEDE(0)")
Cc: Michal Suchanek <msuchanek@suse.de>
Cc: Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
v3 --> v4 : Added the check inside pseries_idle_probe() instead of
            in fixup_cede0_latency() since the positive form of the check
	    is easier to read than the negative form in v3. Also rewrote
	    the comment to reflect the fact that the firmware provided values
	    can be used on any of the previous compat-modes running on POWER10,
	    not just the POWER9 compat mode.

	
 drivers/cpuidle/cpuidle-pseries.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index a2b5c6f..e592280d 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -419,7 +419,21 @@ static int pseries_idle_probe(void)
 			cpuidle_state_table = shared_states;
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
-			fixup_cede0_latency();
+			/*
+			 * Use firmware provided latency values
+			 * starting with POWER10 platforms. In the
+			 * case that we are running on a POWER10
+			 * platform but in an earlier compat mode, we
+			 * can still use the firmware provided values.
+			 *
+			 * However, on platforms prior to POWER10, we
+			 * cannot rely on the accuracy of the firmware
+			 * provided latency values. On such platforms,
+			 * go with the conservative default estimate
+			 * of 10us.
+			 */
+			if (cpu_has_feature(CPU_FTR_ARCH_31) || pvr_version_is(PVR_POWER10))
+				fixup_cede0_latency();
 			cpuidle_state_table = dedicated_states;
 			max_idle_state = NR_DEDICATED_STATES;
 		}
-- 
1.9.4

