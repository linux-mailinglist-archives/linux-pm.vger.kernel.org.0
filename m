Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AB859A5DD
	for <lists+linux-pm@lfdr.de>; Fri, 19 Aug 2022 21:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbiHSTER (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Aug 2022 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349794AbiHSTEP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Aug 2022 15:04:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1B1C6CC5
        for <linux-pm@vger.kernel.org>; Fri, 19 Aug 2022 12:04:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JHHvd2023015;
        Fri, 19 Aug 2022 19:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Y7/Zp5MZMS7XEWDAYkd5WAif0rHz1F4Ak/bMqY884Bg=;
 b=Wmlx2CLm/J4bp/zphu1xKfFrwpcjco3lFWI0JoiPZroytd/Ls9go9P0Pw6bUVWdjVkTn
 KsYwW5aCnyMjkr+LuiXw3B+6WbPkCX2fOG/jQ76t7oyuXUD+v2QZQ9CWl9a/FardO9zu
 GySzE0vu+7gfdRrC2brCBMZt65AYSg8U+a8b0TV1PRJ7h3BIu+3o8QHKD3vs0qHBXQt9
 u5Cq3o/11gliWIzWVK1Vj23IrihcpcbJRpYP2t1LpAmhx3ccWXroPekQnfAy3gycR4m1
 4DGFtukzd+k1vgZCiu3G1Gdak3oLUaIKEr55neznwaxtj8DYZASxT61rRB7zb/HSE+gl Ug== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j2esv87w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 19:04:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27JGg1mQ010395;
        Fri, 19 Aug 2022 19:04:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d5ru38-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Aug 2022 19:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cpw1Pq9G9fMC4JFup13RnVCUFGHoUc9OF9ofDh6mr62+f84BmKjCiOv62Y7EGpfS4GRVG6OilGCXlbtulVozdjORIvbvyzDSf6Er6aa6Kma+MCOBxvfKQM+B+RQ3Sl0OOli0RnvMvtJ9jYXuz26roE+xjQCX83KRPt9RiPzh+LjSUtZD6Hh7OJcfnS3Cfmi9EXvmz7hYTEm4YBLYZCjC8Uhsu2Yf2GMVjlLGzgJOuPPvaprfpSh3cQ2CbiDTlAWgFJZzwN1KGR6fYs3zu5kjuaqdQVvtVulg3KNDUJe2WZQAu0aCPDRZnhSHOCAzi3ggq0pJXovhppcrYRXDB5/Yiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7/Zp5MZMS7XEWDAYkd5WAif0rHz1F4Ak/bMqY884Bg=;
 b=bLaSciGcQ5rZr8zDs65HDb25KivAN1lnb1/u3sABxZKVo9inR3EcGpxguXFSA9NkvDMgPUNBpkUvbBO8/5FyU5hrYVqNrP8NwfBtXBZOvdhoxe7kWFCb8x6PIpiWpLbpd9NsbrSSvDr6esLCexASMcUxESMnomfll1gAqIk8kROkXPLddue+qXzNzaGKLw+hVcmYNPGAQfDX5kSRwgSVLyRsou/GwwMMoiXpZo/vMzp5DS+ebVjXS0AEQo8KMZY+jKkEtpvI4R7ewmHkuaxztxdX1/Ygxl7D/sAC2pRxR4LZQC74ilAs1jCOwktE3+UJ/zUF943A2Q9HaV7OHXceJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7/Zp5MZMS7XEWDAYkd5WAif0rHz1F4Ak/bMqY884Bg=;
 b=UHQtSyCibgVHPwYTydUVjjSeyES8G24JychaqocmRLtAN7B8cmgrFSXPCnxloaj8mL8q7Fvo925oDTW9JQmIYZv451juSjflCTb7dlJRtb9kbU9ZbRDbsHajNzYHWCbZ7KXAKlfK6+V755C6xzRNBX3xPvGo2uQ5BHpwIiMTIYk=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 19:04:07 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c%7]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 19:04:07 +0000
From:   Chris Hyser <chris.hyser@oracle.com>
To:     chris.hyser@oracle.com, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: cppc_cpufreq: prevent crash on reading freqdomain_cpus
Date:   Fri, 19 Aug 2022 15:03:57 -0400
Message-Id: <1660935837-7481-2-git-send-email-chris.hyser@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1660935837-7481-1-git-send-email-chris.hyser@oracle.com>
References: <1660935837-7481-1-git-send-email-chris.hyser@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: DM6PR17CA0027.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::40) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44b7c82e-f056-4ebd-3b51-08da82159725
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TBo4Lokzs0DM/M2vx2eY1M0BW48rkqDQlP6v97kZJ0g6O1HoCm2kb69NuMmhSb4Mi2PI1y6VWbewTDlgD7cScDxL97jLik6602Kf8oMP5hQvjnCtAblK/NEJyw7cQ100KqVbVGZB5bAK4n79k8bGxo2oPXtSYsErN+q7a0me+ZCnm1EMo25F0lZ9SlBCySDe7Bs4V+DOqxW3VNEaOJAF7EmG4tlFhwfbCWgvLWbS8SVVRfESMo9yzlXe7OOKu4uBPev8I74/hoaUwiHz6gp9rYtIgNw0CukAZFZdYXq1fXorh6q1XSPeSHz/XWL45IH4mGU5w0bNDH4dt4emq6hfPA2wogyOJqnsbumwQJ4tc4QoTKMAJZluFZbOn+ZmuvtzEPEp3WoipWvv4ybzMz5k47jI0MAZjmBQ8euyiBFGNt9QeVJBjmrIjb9qaIA5wJmBFAxV1YLqtIk9a/uSG7QD77ykbb9hmGIJFeD0dKGbIl/+AWJDC0nT2NpmmX5+utbLxPlSDAKeMZeprkq4cLo6zMF9B1JFOFel68R/mNVzxV0I0xxqbqkXFKEACY84clJWa0MYrrfXekpbAFP2pgUe4koZfN+lAMm0B7+i2oz1KPVVoHa4EtnjCDIiHA8qVJDOQwno60kp6cRAzlgKa6lb9SVwzJ+MF06akUPruZmEysowsZf3FSuH+RbbYiJNpWkILT2JFeNg0yZT4VGEWB2aY1wwtgYXkC3dnoAxJGoYaSHuRiBsbIddFjvhOxuOKUSW2sMhTQBum7WQtVuqA4G7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(376002)(396003)(346002)(44832011)(6666004)(6506007)(5660300002)(110136005)(52116002)(186003)(2616005)(66556008)(66476007)(36756003)(86362001)(66946007)(6512007)(2906002)(8676002)(26005)(83380400001)(41300700001)(8936002)(316002)(478600001)(6486002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FvrGQI7f1j6glKBH54EZCvdTCQlLhv+ibGqXI48tLGERZmqDkqr92Y4W0oHR?=
 =?us-ascii?Q?FbXtS6pC8HXkygWi4qr+80gZOFNZX9uKSKKKKT2OwFmg+cgQi46Krmjm4MfU?=
 =?us-ascii?Q?I5Ws9knEhmVKAd53uYrzguN1AwQGaKtGD9BHHKKqn9ydq3ZdZgPBRfrvVQaL?=
 =?us-ascii?Q?u94pLuCei2XAB4aAQfyQQPlV9tq506hi1iLZu5bFUVlYXsgyDs49AlJwpZhZ?=
 =?us-ascii?Q?5jS2VZvI0uwFAYtQBtyN7SAN3am+4Nai/7MggkfypxIBxYnAzT4rbxoNkgpo?=
 =?us-ascii?Q?g+W//KUHIpnLprvaTqLmOkuJVH3SeXPqamaEXGTesT10hIsd02bsmgagUW6s?=
 =?us-ascii?Q?YVX5pWWsCvZ45vYLFcxZ7Tt82VLJ5k7Iad9wiIxVEUkcPus9BfJWndSZ90rZ?=
 =?us-ascii?Q?00XLPz1AfGf2lDPew3kzc6KR+ABK6mrQ+YCjIk5ajNJwVRxN78Pa3ChfSGzP?=
 =?us-ascii?Q?s7OEltx8nej7Js9OilkU6lytYIgRTEhbeA/fUHq2ZO5mGElDbZ0YJwx3/BgQ?=
 =?us-ascii?Q?+IIznHxqkCNJxhXvoJU34qmiWZ+fr48Mxq0Zpqkgqp0ILOw7xLshOCSxmQPf?=
 =?us-ascii?Q?u3lKM7mOaGv0zlzOZIJ6t71m3jxNz2EI9CQawow5/uosXmbbqa7Iu8RzZL6G?=
 =?us-ascii?Q?yjD2uzDuAwiZ8kSUt9VVGG8dUv3q1sDznB/noCgxMxeOQNpxCzN+W42HnuVN?=
 =?us-ascii?Q?rO7LTysChDS7L58MJqOeHuQ6KTVPa0+iv0eZPkOheAO6lLCMhk+0QyqlBOZd?=
 =?us-ascii?Q?1qR5y1Bmt+VJBkyDpuvENgB9BG96lcrPXkp8K1DQjYqbLl681+lpspxY4X8H?=
 =?us-ascii?Q?KWiAdLkF+rsdxCsUSLmt+UR+hVoAQTUhp75pq/5qmQHEeRqGWLiYLMe668Mp?=
 =?us-ascii?Q?6pcwPQjBOuWadlwKo2LKMOfLCMJURwYpVazbBg08bvXkrl4i1jKYnX7fhQzV?=
 =?us-ascii?Q?1f1CmxCzkMjW+cH8cTdhlK+QXyj/b75uVLaDGc3DCRFTZDIsR4oTTxP4HbsV?=
 =?us-ascii?Q?epabGM8XGaLhWLxgZsc/B8iEEsyTbGWDB4LD0eOD8TU0kT4UNWdGHc9zhlca?=
 =?us-ascii?Q?WbGp5J1WfgRUuCKs5ck/Yi8XKnO1zWVi+/XU0ChoP8qbEC9sD/9ctNo7sieZ?=
 =?us-ascii?Q?Z5CXy4U46EqIg3SCZbPXCakd23jAobWZ1+xRgGfcuKD8WYOY9nXbdTYhQTUO?=
 =?us-ascii?Q?LgiL6iZKku0cIfW6IZQgMjlOdvrNlSGXMh61BShvKIysWDClz5VzAUawZqmS?=
 =?us-ascii?Q?ZWRoBg+32Y9GJvvxWB9F0cNCvmac9EPfiZYn6C/7oykp7+Ac391auPEiW7Nb?=
 =?us-ascii?Q?nSiuLAJ4fG1Xj+lfJjCyL6yAOSTOn1S2dj4DOI9kyiuMGNWb6JlsOuuU1SJ9?=
 =?us-ascii?Q?nB4QqAk0rUzpDfWpOFm+EfZx1CW50Mjln23vsaonexGf5DZ7nstFdtQBas4Z?=
 =?us-ascii?Q?0drslij1dYxX4+BpUychud7Tk8TogHcNDGK7J/0ZdBs8O6JPaI86t3qYE4uF?=
 =?us-ascii?Q?uVlQ5oVLfOZun1gowrejQHrG+c5mCSPdFqJF8UaDyCA4mF6IJKzToZTOrTd/?=
 =?us-ascii?Q?xKe2FI1Ud560EE1AmKaAz/CWfvIhRlhXbSsGxjGA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b7c82e-f056-4ebd-3b51-08da82159725
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 19:04:06.9946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZpkcTuy6rLNE7mw73g0crHbUcFQFoepQrTgjOfu5Se19Nam+Mz9Jns6xvzUcYdibye+wpZxhxpxuLdTtXyN+0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5711
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208190071
X-Proofpoint-GUID: RHwTQtx4DOOBt-lNaz6IS_ve5rVHFMwc
X-Proofpoint-ORIG-GUID: RHwTQtx4DOOBt-lNaz6IS_ve5rVHFMwc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>

While running stress-ng --sysfs on an ARM system following a cpu offline,
we encountered the following NULL pointer dereference in the cppc_cpufreq
scaling driver:

[ 1003.576816] Call trace:
[ 1003.579255]  _find_next_bit+0x20/0xc8
[ 1003.582909]  cpufreq_show_cpus+0x78/0xf4
[ 1003.586830]  show_freqdomain_cpus+0x20/0x30 [cppc_cpufreq]
[ 1003.592318]  show+0x4c/0x78
[ 1003.595104]  sysfs_kf_seq_show+0x9

This is the exact issue described in commit e25303676e18 ("cpufreq:
acpi_cpufreq: prevent crash on reading freqdomain_cpus") with the fix
described there also solving this issue. I tracked the root cause to the
following: a scaling driver which provides a struct freq_attr sysfs
attributes array passed via struct cpufreq_driver during driver
registration, has .init() and .exit() functions and does _not_ provide
.online()/.offline() routines. cpufreq core creates the attributes, but
does not remove them even though .exit() frees the underlying memory. The
core functions and most drivers have corresponding NULL data pointer
checks.

Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 24eaf0e..4210353 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -876,6 +876,9 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
 {
 	struct cppc_cpudata *cpu_data = policy->driver_data;
 
+	if (unlikely(!cpu_data))
+		return -ENODEV;
+
 	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
 }
 cpufreq_freq_attr_ro(freqdomain_cpus);
-- 
1.8.3.1

