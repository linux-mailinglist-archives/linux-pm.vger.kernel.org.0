Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A74D17BB28
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2020 12:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFLF7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Mar 2020 06:05:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33528 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgCFLF7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Mar 2020 06:05:59 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026B0720022609
        for <linux-pm@vger.kernel.org>; Fri, 6 Mar 2020 06:05:58 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yk4jpxkgr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2020 06:05:57 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <psampat@linux.ibm.com>;
        Fri, 6 Mar 2020 11:05:55 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Mar 2020 11:05:52 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 026B5pCA59506800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 11:05:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36FA142042;
        Fri,  6 Mar 2020 11:05:51 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 094AE42047;
        Fri,  6 Mar 2020 11:05:50 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.124.31.88])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 11:05:49 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com, ego@linux.vnet.ibm.com
Subject: [PATCH] Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
Date:   Fri,  6 Mar 2020 16:35:49 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20030611-0016-0000-0000-000002EDBDD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20030611-0017-0000-0000-00003351157E
Message-Id: <20200306110549.25517-1-psampat@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_03:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003060079
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch avoids allocating cpufreq_policy on stack hence fixing frame
size overflow in 'powernv_cpufreq_work_fn'

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 drivers/cpufreq/powernv-cpufreq.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 56f4bc0d209e..20ee0661555a 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -902,6 +902,7 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
 void powernv_cpufreq_work_fn(struct work_struct *work)
 {
 	struct chip *chip = container_of(work, struct chip, throttle);
+	struct cpufreq_policy *policy;
 	unsigned int cpu;
 	cpumask_t mask;
 
@@ -916,12 +917,14 @@ void powernv_cpufreq_work_fn(struct work_struct *work)
 	chip->restore = false;
 	for_each_cpu(cpu, &mask) {
 		int index;
-		struct cpufreq_policy policy;
 
-		cpufreq_get_policy(&policy, cpu);
-		index = cpufreq_table_find_index_c(&policy, policy.cur);
-		powernv_cpufreq_target_index(&policy, index);
-		cpumask_andnot(&mask, &mask, policy.cpus);
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy)
+			continue;
+		index = cpufreq_table_find_index_c(policy, policy->cur);
+		powernv_cpufreq_target_index(policy, index);
+		cpumask_andnot(&mask, &mask, policy->cpus);
+		cpufreq_cpu_put(policy);
 	}
 out:
 	put_online_cpus();
-- 
2.17.1

