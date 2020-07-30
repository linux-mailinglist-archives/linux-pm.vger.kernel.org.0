Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B65232B63
	for <lists+linux-pm@lfdr.de>; Thu, 30 Jul 2020 07:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgG3FdV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Jul 2020 01:33:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgG3FdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2020 01:33:20 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06U5W9Y3088741;
        Thu, 30 Jul 2020 01:33:17 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jw724p5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 01:33:16 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06U5WJbJ089679;
        Thu, 30 Jul 2020 01:33:16 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32jw724p50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 01:33:16 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06U5Oh7d020529;
        Thu, 30 Jul 2020 05:33:15 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 32gcy4srdu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jul 2020 05:33:15 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06U5XEXs50004444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Jul 2020 05:33:14 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F7CF28059;
        Thu, 30 Jul 2020 05:33:14 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ECED428058;
        Thu, 30 Jul 2020 05:33:13 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.102.0.230])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 30 Jul 2020 05:33:13 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id C80BB2E2D91; Thu, 30 Jul 2020 11:03:09 +0530 (IST)
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
Subject: [PATCH v3 0/3] cpuidle-pseries: Parse extended CEDE information for idle.
Date:   Thu, 30 Jul 2020 11:02:54 +0530
Message-Id: <1596087177-30329-1-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-30_03:2020-07-29,2020-07-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300038
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

This is a v3 of the patch series to parse the extended CEDE
information in the pseries-cpuidle driver.

The previous two versions of the patches can be found here:

v2: https://lore.kernel.org/lkml/1596005254-25753-1-git-send-email-ego@linux.vnet.ibm.com/

v1: https://lore.kernel.org/linuxppc-dev/1594120299-31389-1-git-send-email-ego@linux.vnet.ibm.com/

The change from v2 --> v1 :

 * Patch 1: Got rid of some #define-s which were needed mainly for Patches4 and
   5 of v1, but were retained in v2.

 * Patch 2:

  	* Based on feedback from Michael Ellerman, rewrote the
	  function to parse the extended idle states by explicitly
	  defining the structure of the object that is returned by
	  ibm,get-system-parameters(CEDE_LATENCY_TOKEN) rtas-call. In
	  the previous versions we were passing a character array and
	  subsequently parsing the individual elements which can be
	  bug-prone. This also gets rid of the excessive (cast *)ing
	  that was in the previous versions.

	  * Marked some of the functions static and annotated some of
	  the functions with __init and data with __initdata. This
	  makes Sparse happy.

	  * Added comments for CEDE_LATENCY_TOKEN.

	  * Renamed add_pseries_idle_states() to
            parse_xcede_idle_states(). Again, this is because Patch 4
            and 5 from v1 are no longer there.

 * Patch 3: No functional changes, but minor changes to be consistent
   with Patch 1 and 2 of this series.
 
I have additionally tested the code on POWER8 dedicated LPAR and found
that it has no impact, since the wakeup latency of CEDE(1) is 30us
which is greater that default latency that we are assuming for
CEDE(0). So we do not need to fixup CEDE(0) latency on POWER8.

Vaidy, I have removed your Reviewed-by for v1, since the code has
changed a little bit.

Gautham R. Shenoy (3):
  cpuidle-pseries: Set the latency-hint before entering CEDE
  cpuidle-pseries: Add function to parse extended CEDE records
  cpuidle-pseries : Fixup exit latency for CEDE(0)

 drivers/cpuidle/cpuidle-pseries.c | 190 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 2 deletions(-)

-- 
1.9.4

