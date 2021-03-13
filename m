Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A76339B68
	for <lists+linux-pm@lfdr.de>; Sat, 13 Mar 2021 03:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhCMCuo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 12 Mar 2021 21:50:44 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55866 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhCMCuY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 12 Mar 2021 21:50:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D2o69X057748;
        Sat, 13 Mar 2021 02:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=Kav+ftAFfpoOqo3YkZqpORL3VRlpr2qOyD2B9yHj4b0=;
 b=DifRA0zgYYgK/Btqgz4hO0s/svEWVMY6/UXymuFMpXYrfZVDv5Yj7EVRjiOysHsBOjbT
 hUmMoyXbmphSCM0Fc1v8NpDT25ZEapxcYFsPDaGptz2magMyfawpXr4I118SbOxq1YAX
 XAfBTUhr6WmGeIUoCAyItv9Hm+s19jQdCKGZr2uYc43pteSbLu9EzjyJ7UbAhyknxgs9
 HhmtA45epWMfMKt/bzrWGnhPJR3MxuCsZdoQI2pgV4OopgNeJ8ak5O4g9tFfbGlXUlD0
 g9io296ozMVRdokl03AWvY4L6KY9OsBD6lR6gQnwbPTAK7Neak7MiVVSgtZUWhQI99JY 7Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3742cnkr03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 02:50:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12D2nXYl016204;
        Sat, 13 Mar 2021 02:50:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by userp3030.oracle.com with ESMTP id 378jgtga4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 13 Mar 2021 02:50:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh/9wzKB8yQNY2odXvwJlNJ1g09PDGANIDxTmrTZ2F/K5+r62qnPV9sdJInnFx/l30IGVs7xbwIk5hXIhVxVJd94s1Jm0hkq2j8gov4avGAr1+aI9afewtR3lX3Z4atGU/81I7xpZq4OjFk3LTmO/NRxKM902XsEEuyoXcLzAksxRmvW9PKg6DNAr/g9MgTrN1YQw1vperP2oBkOjDJa+kMdskXaR6GtYUQ3t2fcae8jyZE91sT09U9Ucr686OsLGeAP0nO4RcIV8otgecSUmjR7029w7Y66BLsgIw8u+24W6r59DIDBmuASy+/UNwYwUTDmTdvTP6npADrKqTBzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kav+ftAFfpoOqo3YkZqpORL3VRlpr2qOyD2B9yHj4b0=;
 b=ClDZwvZsNusu/Po8OoHdXiPk6JMzadlTSqNozVsPLLaRTcNP2Swly3L/vlMelhrZPeK/ew5vyYeJ60wNJiyW5pytU8zYBDgsR+WoUbuagPaR2kvbY22D4CtHfcWX6aNKmzQK/VxZKFdektVCey4gfJsWMyZjEcs/bVEm2wF1fHZeEUdYuCRSNhzo9yv+Y9z7zHVURUxIBG0Vvk+425K9NBLpXXxe611RX1TdOLN6y2IbpSIiEHrOeXYgpwqbBzB318IPV3P4HKgi/CpL6+UzLFaUsfrfVWNjBgzdWTaqv8Dbzwf3KVEHuA/kRHeMD1R9P0TISCuq1YUnVwik1d+Fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kav+ftAFfpoOqo3YkZqpORL3VRlpr2qOyD2B9yHj4b0=;
 b=jxHbcqkcUq6ddRieLSIZraU14B1MKtpd+smArjAnyjxvwAC92MMzDnMBGiDm/zmQikubRtv3mLHl+imTRa8JdYNJr84G+OvZLhD8BCmV98beRtbqMPCa75ozhaZdct+WE5Df/JQv9g5XZ0G+NizCghZni0/WppNpZ+LNEQl4arU=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3794.namprd10.prod.outlook.com (2603:10b6:a03:1b2::30)
 by BYAPR10MB2726.namprd10.prod.outlook.com (2603:10b6:a02:ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Sat, 13 Mar
 2021 02:50:13 +0000
Received: from BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902]) by BY5PR10MB3794.namprd10.prod.outlook.com
 ([fe80::21a6:5c60:cd6e:1902%7]) with mapi id 15.20.3912.031; Sat, 13 Mar 2021
 02:50:13 +0000
From:   Tom Saeger <tom.saeger@oracle.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        linux-pm@vger.kernel.org
Cc:     Tom Saeger <tom.saeger@oracle.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: cppc: simplify default delay_us setting
Date:   Fri, 12 Mar 2021 19:50:06 -0700
Message-Id: <35ac53f3efdfe58337fb66ad899b548dfa3bbc1b.1615603452.git.tom.saeger@oracle.com>
X-Mailer: git-send-email 2.30.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2606:b400:8014:1041::13]
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To BY5PR10MB3794.namprd10.prod.outlook.com
 (2603:10b6:a03:1b2::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2606:b400:8014:1041::13) by SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Sat, 13 Mar 2021 02:50:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31390431-4453-4642-20bd-08d8e5cab960
X-MS-TrafficTypeDiagnostic: BYAPR10MB2726:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2726E45AB3FF5FA4EB057791FC6E9@BYAPR10MB2726.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:854;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAd8KnUnKWZ7AzxACLihZM/GN7ooaqxUxMDww59wcla8qflY2j9ru0MJoYRcMukTF23KimycfvLtCv5KkytMY6L7mUHq8jAHmAPHVvT7c21bDlWor4EQndW0T8EXMAyZQKX54XhHqBLWZUoqyzW2xXt9DbwIYY7Y+DRYS1bZrsTBXw036KL/kt0g6gUtYBxIEPwW+RHsTa13psCtl00nPZT0kdY2Qzu1rsbBU1HY5Ba0gKUea+hkflfVaH6qkKoLQ+m72RyRwozIqokzC0udI934dduB/SLhg/xB7UEk+ZcKg725vrqwbZ/5UOWAawwIgpV/5X2hFKnbh5g8kt2xwnHMRiPvF0iR7mjnmrAbO/xFvfkR8UqFbYrj8dMDc3DJ39LpzuveeBzAX2ddbxi28LXLC8LidyF+un0UZDAuG4lN+8fvpM/g2vdBQ+G6ElboHO1IwbnNgrnA3FtJ+05WHBwdIj8b62XdsnN7ctkL/Sj1MOAQNWu2v4QwuKNHpK+xbU9bwlt+A/puYjhuo3Thbwecceu3lVPbhHDLSX9jRtVEWOSURRiuYxoXo9z6SvNRz7ztWOBsYFf2IsGfYNZLc8a/hcqCZUvtl5B7HMqKbzd75LzWJe7iXilrqkmTA5LiZIgWCYD9+2TdE8x6ziUnZiuKsHH/9QoP22SLnq6irrtxkUwttqMUMKIWvz22n0Mp6wP/q/70K7kC9SJ1YQPdEIBssG+eF18y5kk1PnVbqz2jShVPh0JHxbBwJAGx/9ELs/3sYS2EVt+GGPB5HqGq00P0QZ7XqEkPlxO8jDsq4zvuJJ5H1EtLgX7/4Z+WhobZEdbjzZX5TVlwoMsV0dJ1bwAHG9FJtV0/upuFgjDktZ9/FchcGqVyWux6fq17SqbtMOxoUq9Dd1dBCXX8Z/DgTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:BY5PR10MB3794.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(136003)(346002)(396003)(39860400002)(376002)(366004)(6496006)(2906002)(6666004)(186003)(44832011)(66556008)(110136005)(8676002)(52116002)(5660300002)(478600001)(2616005)(316002)(66476007)(86362001)(83380400001)(36756003)(66946007)(8936002)(16526019)(6486002)(4326008)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uUjzaK+A/V3b6hcsHCl07+JGPCZa5WyIwmadH5rlKqHH9EwZsHLePanJEKQF?=
 =?us-ascii?Q?4RFRCbrSabdrs6P4F3V3b/GZbqVIsb97xGbLe7hYN0IEkaMc8zZbCmBZ5AUz?=
 =?us-ascii?Q?G0xmxt+DMrsxiUB8KLKuCGZ5672LPIpcHbF6vHsumU/ajW6NHNzCjq89SGT8?=
 =?us-ascii?Q?+tbIfU0c+YBpSw33m01Sg4jVhfTQyQJBANgUdv32zU6I90OlArno8D+NTM4G?=
 =?us-ascii?Q?OdxdiRf3ppazxTvcVnqIR1GudHdihdfBohSOFbDDQkET3aAkNO9M6/UB01hE?=
 =?us-ascii?Q?+uuPOuhlQEi8hrirVyc0/jhv/IuH8rtuSiMawSCDmUG6QekVzloRkOpGz68k?=
 =?us-ascii?Q?9YvVUBfbyONI+l81ND5YYMpiagiyGWbr87hzofhutPJ2YH6cpyUX63FvV6IV?=
 =?us-ascii?Q?ABG82DKXrw8yR+TenANMzLtbdJPPUEw/VrqVCBKrZwvK5jtjMleeGho75rIc?=
 =?us-ascii?Q?uEPgWYodyBUOpmGqXFI7KBE97QxnBQ/r4mhY9bpA4HaDZcpps545xdSjGl4u?=
 =?us-ascii?Q?iaGHZaW1rviOpcIE0yto9+VWC+hOXYQ0gPZcSmtNZk2zinU059gvOszfffWz?=
 =?us-ascii?Q?f6tFrVRDJicxASkjpAJrC6Vgi3U7yZU2HFya0MGjmOwFzFbxHAJYHSCwVYel?=
 =?us-ascii?Q?fbENAe6vFS9JlzzU/Jzaz4K0PLauaxUGD9AXKE8dspcDP7icqqqDqIVLtP/T?=
 =?us-ascii?Q?Mq/KLTyf3qS4J9ne4GvAUE5+JWb1U0YKyVX8G91ibG6f4qcH45Wtq16Iz/1v?=
 =?us-ascii?Q?D312jvREOb0bm1p0PykQ3/jTV/Yu0WeWqV1bjTFJBvy+2s0+UN+CH2smEVYY?=
 =?us-ascii?Q?l0gMUaVCSHDDwFk9GF/UMqnNDRSB+bvuyUvDGP3U+y00c55apNZOMLMQaItZ?=
 =?us-ascii?Q?Oepr1/YNlZfNNmdiaRRnE6HidNEzHVARC+MxfdWrwNPLSGaGCJX85zi15eUV?=
 =?us-ascii?Q?/IFav1Htb29wmpGt4XLBxA24beAPESoqWGefIBQ2KnY9yz/EvTmRjbP0uwX3?=
 =?us-ascii?Q?6forh/j82loNKEwX56DGe/hYtfA9Pj5WaOGiFKj1dGaLZNDqMU7HGR61FRcf?=
 =?us-ascii?Q?MWDiHhuuxEe5YUyq3adrqMwkcpD5HrRbUmm46G2yvrq72G+wl1+BtyNtacSw?=
 =?us-ascii?Q?TWWFOlsAs7P3nmyRbAZsHS8kBmbi/Xg2qcORaIHtt3cShzRLfWhBlBu9ePny?=
 =?us-ascii?Q?oU0kaA3BAbh1QOt5zByiUoaAhR6VW94z4cMZeT/zTFzSWUkulp70kxJlaEsv?=
 =?us-ascii?Q?PGxMOkmF7ZIxOJp1knQDuk80kz0OUO9Pe1jcjW2rNcb4QJ6b9nXGvf5KsNKo?=
 =?us-ascii?Q?zbek6iINgvoScK7ZNU5QsVZyRlBXTYZyvmyKw8o/ZryCjw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31390431-4453-4642-20bd-08d8e5cab960
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3794.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 02:50:13.1772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gGQVOkGaiRLQ8Oj32TFf7SCJ0VShJ3Dyh36TZjCKllgfF76g9PWJqsTmFfU269Jy0HmTldtbrp6IKG+Fy8y2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2726
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103130018
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103130018
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Simplify case when setting default in cppc_cpufreq_get_transition_delay_us.

Signed-off-by: Tom Saeger <tom.saeger@oracle.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8a482c434ea6..2f769b1630c5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -216,26 +216,16 @@ static unsigned int cppc_cpufreq_get_transition_delay_us(unsigned int cpu)
 {
 	unsigned long implementor = read_cpuid_implementor();
 	unsigned long part_num = read_cpuid_part_number();
-	unsigned int delay_us = 0;
 
 	switch (implementor) {
 	case ARM_CPU_IMP_QCOM:
 		switch (part_num) {
 		case QCOM_CPU_PART_FALKOR_V1:
 		case QCOM_CPU_PART_FALKOR:
-			delay_us = 10000;
-			break;
-		default:
-			delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
-			break;
+			return 10000;
 		}
-		break;
-	default:
-		delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
-		break;
 	}
-
-	return delay_us;
+	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
 }
 
 #else
-- 
2.30.1

