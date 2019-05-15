Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7E001F609
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbfEONyQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 09:54:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbfEONxt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 May 2019 09:53:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FDrJo8140871
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:48 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgm2101en-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 15 May 2019 09:53:48 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 15 May 2019 14:53:46 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 15 May 2019 14:53:43 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4FDrglP49479868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 May 2019 13:53:42 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 639B552051;
        Wed, 15 May 2019 13:53:42 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.18.182])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D37EB52050;
        Wed, 15 May 2019 13:53:39 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, dietmar.eggemann@arm.com,
        dsmythies@telus.net
Subject: [RFCv2 3/6] sched/core: Update turbo_sched count only when required
Date:   Wed, 15 May 2019 19:23:19 +0530
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190515135322.19393-1-parth@linux.ibm.com>
References: <20190515135322.19393-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051513-0020-0000-0000-0000033CFC9C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051513-0021-0000-0000-0000218FBF2B
Message-Id: <20190515135322.19393-4-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905150087
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the get/put methods to add/remove the use of TurboSched support from
the cgroup.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index facbedd2554e..4c55b5399985 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7216,10 +7216,13 @@ static int cpu_util_max_write_u64(struct cgroup_subsys_state *css,
 	 * Classify the tasks belonging to the last bucket of MAX UCLAMP as
 	 * jitters
 	 */
-	if (uclamp_bucket_id(max_value) == 0)
+	if (uclamp_bucket_id(max_value) == 0) {
 		tg->turbo_sched_enabled = 1;
-	else if (tg->turbo_sched_enabled)
+		turbo_sched_get();
+	} else if (tg->turbo_sched_enabled) {
 		tg->turbo_sched_enabled = 0;
+		turbo_sched_put();
+	}
 
 	/* Update effective clamps to track the most restrictive value */
 	cpu_util_update_eff(css, UCLAMP_MAX);
-- 
2.17.1

