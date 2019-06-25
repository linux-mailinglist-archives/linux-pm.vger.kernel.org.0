Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586085222C
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2019 06:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfFYEiG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Jun 2019 00:38:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbfFYEhm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 25 Jun 2019 00:37:42 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5P4X7cj141938
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:41 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tbadfcc7b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2019 00:37:40 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 25 Jun 2019 05:37:38 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 25 Jun 2019 05:37:35 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5P4bYjo33751518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jun 2019 04:37:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA47511C05B;
        Tue, 25 Jun 2019 04:37:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9969511C050;
        Tue, 25 Jun 2019 04:37:33 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.87])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jun 2019 04:37:33 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com
Subject: [RFCv3 4/8] sched/fair: Define core capacity to limit task packing
Date:   Tue, 25 Jun 2019 10:07:22 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190625043726.21490-1-parth@linux.ibm.com>
References: <20190625043726.21490-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19062504-4275-0000-0000-00000345534D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062504-4276-0000-0000-000038558DD5
Message-Id: <20190625043726.21490-5-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250036
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch defines a method name arch_scale_core_capacity which should
return the capacity of the core. This method will be used in the future
patches to determine if the spare capacity is left in the core to pack
jitter tasks.

For some architectures, core capacity does not increase much with the
number of threads( or CPUs) in the core. For such cases, architecture
specific calculations needs to be done to find core capacity.

This patch provides a default implementation for the scaling core capacity.

ToDo: As per Peter's comments, if we are getting rid of SMT capacity then
we need to find a workaround for limiting task packing. I'm working around
that trying to find a solution for the same but would like to get community
response first to have better view.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/fair.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e8c5eb339e35..ff3f88d788d8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5929,6 +5929,25 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	return cpu;
 }
 
+#ifdef CONFIG_SCHED_SMT
+
+#ifndef arch_scale_core_capacity
+static inline unsigned long arch_scale_core_capacity(int first_thread,
+						     unsigned long smt_cap)
+{
+	/* Default capacity of core is sum of cap of all the threads */
+	unsigned long ret = 0;
+	int sibling;
+
+	for_each_cpu(sibling, cpu_smt_mask(first_thread))
+		ret += cpu_rq(sibling)->cpu_capacity;
+
+	return ret;
+}
+#endif
+
+#endif
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
-- 
2.17.1

