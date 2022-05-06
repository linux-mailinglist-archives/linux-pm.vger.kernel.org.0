Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C57351D227
	for <lists+linux-pm@lfdr.de>; Fri,  6 May 2022 09:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243147AbiEFHZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 May 2022 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbiEFHZl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 May 2022 03:25:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC97766FB6
        for <linux-pm@vger.kernel.org>; Fri,  6 May 2022 00:21:59 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2464dZNp018676;
        Fri, 6 May 2022 07:21:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hZRtuFyMA9yY1ZnOeFPFeR6e4IiV1L7iZEBd2mLyeic=;
 b=ZECrn8O1PyX5/JNNFlQUuCKPdgjlH/QzLclZHbpD3o+qHQMLdajIjQZy/k0Sle6zs6g6
 pazksKiY66rLmrJGe+y+jEd/hWLD3AFexoYDQG+SIfFoG64lRpjogSr6twYUEvBelGnQ
 Bru8P7/QGAEZJo8sFymhOBpBXVODaRU2SHjdQY5+uFdMiFZI1xqEM3y2Xc9aDa7rUbyu
 XJDlg+Sf46ntU/4Em9krYY1P2L4AxBswu9ik2paG5EGKKMXgbBO+OmUxMnDD7JdgM/Lh
 EwdkISQPuDNa1uzb7Y0BNFkAGEHEH5971AIcw/YaxJJT0F3/ph3BcGoBWAAbyAR3V3Qa Og== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwntde5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:21:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2467F5wS027960;
        Fri, 6 May 2022 07:21:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3frujbq8c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 May 2022 07:21:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y85XMJ56+nY2FJNsbARUgiIOJGBr2uZJHkfhJmDrKHc8TG96za7Q+9uNC55RRiKwwjwUI1H063heCQ6cce3q45ykDXnBy8DL0w49E29UwFnTQ8rOYf5DT+EN498Zoox4aLTQ/JzoP7GOMu+02VLCaGLDp7BVUsUQl0Qemr2xic9VsE7ntyYs7poa9bz+FENgke7AxoklV/VDwGdX5sc28oeanRl5wTkOUwLTSFAOxbD9p7c1YAqx7ZYs2m2RMUH52KEJa5MdvJGX8a6bbayEcwHUKc+LPvAYYXp9GvOV6f904ZwkMLSHpBuKvhNmiKDsxESe3x7e0Abb/gNTBKDl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZRtuFyMA9yY1ZnOeFPFeR6e4IiV1L7iZEBd2mLyeic=;
 b=dZ73Dy3Txr8ek+n4poY/4oCqv4oYTu6wMTIvY6A2W87KfF7693mw3vN3by/iz32OIagW1Yy2oh1u+pwJnVdfn089B4z90B9+2BNckky9lTrXr7FtdaFuvM+E59kieyK2ZF0fsXMnKletMReqXO5bB1v8hilulg5PPcTqKLMCwJzGLD6qG5IMN3vCNY+/M2Dl++eXBKh497+vpRMnB9+8VJuQBwG4kosyFJlhy2JqfNahnPfl7VIKf8E8VlG1B8kLVVRDixR5emFzcaaSAChzYS9hg2WwIXNhS36tzFB/P4PTk6ljPYJvnHX80kNzhgs9g0mnKXxBPa7OjahH7hvykw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZRtuFyMA9yY1ZnOeFPFeR6e4IiV1L7iZEBd2mLyeic=;
 b=nnCKn5joxQfcwHSiZl0n4ghnMCsu5IT2GjZhUIJ1RlOtzsi7uVkELWTHTnOYfOE88nj04J40DqNZC/WLbvWxZ14gci5EIEF/muwqVnBjGk7zqLJuYer5dXobTArrL5h46Fy0F2OnEHqPHbNR+9iIQ0ZCkgpoDUvrbLD23B353/E=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4137.namprd10.prod.outlook.com
 (2603:10b6:5:217::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 6 May
 2022 07:21:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c053:117c:bd99:89ba%5]) with mapi id 15.20.5206.027; Fri, 6 May 2022
 07:21:55 +0000
Date:   Fri, 6 May 2022 10:21:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] cpufreq: Fix possible race in cpufreq online error
 path
Message-ID: <20220506072146.GD4031@kadam>
References: <YnKZCGaig+EXSowf@kili>
 <CAMA88TpC_7-S7HDnjE5VLS-h_y0pQw1Qb_Q-2DYsSDoZJLdUgQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMA88TpC_7-S7HDnjE5VLS-h_y0pQw1Qb_Q-2DYsSDoZJLdUgQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0171.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df300575-0f89-4bbf-fb1b-08da2f311913
X-MS-TrafficTypeDiagnostic: DM6PR10MB4137:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB41379CE4ABCE73C26FD310B78EC59@DM6PR10MB4137.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mh3g6ftBrA1uzEAruJ48+RjdEQMxlBCGGJd0D4Eitkobpdli3puBkgf0KRPHThHTIhITX1eOmGdC2S6p7RnktHxrMonpBG/cc3uGIHYdYtNyAIg1c+nCysLzxlaPxH1AMEb6RWUAa91lSsNRHcsi/fB3LBbb6Tm6sIThoDS5aBCGIwA08nK/lMVKxZzACWpIK3LOo+GHUnzSqnE7rfU05Q68Sk313aM2DzM32ppC+wDExqDiGPGAz1k8qFmJRl/8yBUCOu7UXflCPhCIReUjoPEgDsWwHAp1GMvp6tT8Z1vA0SMw2bvJhNBt35gW5GSvH3GAyM68z1D1Nhkkr8+jTiTva0EUlHd1vlgIWd/CR7W9S6SWJ7ljGISmActt+umkdApAhBWBJQQJU8uzaJAygJ3fxst3p+5Paj8WBTRwm3/OhgJBzVqHZJeR0sRRLoOGGLTXoQwdsr8WgDGlUN5vTwS1jcm0IA2H1qZZi4n0uVKYYzcYbDQjy7+HbGcGnWkRKvOIV0BS72v6nM6lBed5rt3Xi6W5Q3sAwYqWTY7vK0CFJhId2W8pkeR8RbL/UuWjjp2n+XWqQEKEzq69TQymVfFRG3pvcm/uCF79d1es702ZdsXhRlNuGiOzAQI8l8nUQc2v7dSzs20bqZULcDRSQc/LBhzluE23z1AMxl5UHHcoLVraukNUC2Kl2s0cH4+ZeoHLOnB6p05vsIaLlwESag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(86362001)(6486002)(508600001)(9686003)(6512007)(83380400001)(44832011)(26005)(2906002)(8936002)(6916009)(316002)(6506007)(33716001)(4326008)(6666004)(8676002)(186003)(38100700002)(52116002)(38350700002)(66476007)(66946007)(33656002)(66556008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vGXjhrDxKjcAX7wjtci1qnlEV/qTwVrHdhNaLdpdeiBcxuXgbUsw0MJaIl1p?=
 =?us-ascii?Q?jKNSNnfNrFYz2X48uk5T9bAtSusXX7If0KEUXZMjDlSY0+AntFNlnK9cwz9u?=
 =?us-ascii?Q?lZPSwueqWtds/OQTzCOh6SmCAK2MIkfCFQi6aS52Vtbzer0BQLDEgt/sY6I8?=
 =?us-ascii?Q?JWJl8Awl2iHKLzFE9u9lF4jpyNKwIAYodjvIbXoBgvgNbbNK1peqZul+ODth?=
 =?us-ascii?Q?uC8mQ63T1BmbY+p55H1NbjyNzQfKrAvbBd6wCp+T67Tnde2EsXh9SOlS6Bzj?=
 =?us-ascii?Q?K41y+qBI9u7o3P1Rq6VZtd37COkc7JZSofqLXUKvGgRO68iworhqCtfSxBkL?=
 =?us-ascii?Q?4w2VwjqHR51kNaCPOcb6HW0/w651nO511PL6kNKXGcf4sufMG15/eN92UlNn?=
 =?us-ascii?Q?kvjQHq2ANNs7mQn9c+emUf61969Imt83e3Fh3SVy27UjLJPOM5SJhfM1/Rzp?=
 =?us-ascii?Q?jSTfjmrYPFi38DVOQ0Hvc8WVPENQoVAnhQKbW9dQ847YVMdbdbPis84c4kq9?=
 =?us-ascii?Q?495RiAYDa96NdIKjZXut9sPv4zAkLxeLI5MSdaYd4Y/+PZqGOeVFVzjHJOmq?=
 =?us-ascii?Q?FIecvrapjMVn3DvHbWXfsO2HyPNWhwjsUUzMMuYf9MPG3uBnRX2y/o+eaOMN?=
 =?us-ascii?Q?s023Zb4iXwcc/+7+5tcbGe2iWt4xniOmrA7sUEB4cwkmpkH8O5VksoF3DOEo?=
 =?us-ascii?Q?4T33bNUsS/ihZuU7Ij0vL7k4uvo6zxlgvwKnrV4cLjxtMxGtftQvVZxGEujc?=
 =?us-ascii?Q?B3iX16dT1MnxrSFelkyNEmmS3S+RnSi2+m5/aAmkMQrlToDuGlnm16RucHZI?=
 =?us-ascii?Q?pYJPXcOCxN1x0er337bg4BAQaiSQj2Y+mPIF54E1j/tvdh3dGcWB2RCSx5Ky?=
 =?us-ascii?Q?lN1iUzVu/wARWOkCsDa3K86z9XUpt2UorDnehk+KpuW9Cphqzig5F+vcyRel?=
 =?us-ascii?Q?hS6YW1b9k9ncTCehINRTR9XWN4I0fnW4Fe8TgIKuPad6dH7THvM3yTg5hUcK?=
 =?us-ascii?Q?EpL+9aE5G6Uh5eXAXn9EJNopQjGWbTMmN4pDt901OMp2MJHuNhzeYW4Qaza5?=
 =?us-ascii?Q?Kz7PSLBtZ7pRbDh6EAqJy/s8bI9YOSXAsJPNnAz5Qs2BNfto0xoeHWCYzlyP?=
 =?us-ascii?Q?qFAXlhedIEnN7N0lVEA7WbnkOZotRgZO4yvXufM0sDZv4fl9rtvCeUbOeztd?=
 =?us-ascii?Q?BvkMBI9GmGoBxtKNF59t3ulTMQxLfxxG9vfSEbTR7ZIViW/MY5nzQML1AMJF?=
 =?us-ascii?Q?TGvDVtooyyseT84bMzBzWY94ZcjB/AxtnqsJ0sqadyGbrDrWj9Sg18a1/71G?=
 =?us-ascii?Q?nT2uSV+Ua7zDDA35hfBQvORlNR+k7sd9qKcra5PvcQYFuJubBeRnm+HTtcXt?=
 =?us-ascii?Q?u6dyG5+zTxnnthwcG8Mdj239oyRgZPefAYiwswlR7YnhNqoRBhL9tgC3tXYf?=
 =?us-ascii?Q?hlxCDipYHGEHTgDILoNO1YLfTJrVaCui8Sh89tQpbTnIR9LHTF5NKP9Nbckb?=
 =?us-ascii?Q?d2kEVDoFlNwXt0fCLxnPJckJEN4gq3aBAJb4KVMEMw81oxyxK6BK2ZF8v8HJ?=
 =?us-ascii?Q?rIU44MJGJb+ZKKvrAdKowml91zJV3xcuh8440J4UddaSCGwkSiDBCxp6loFd?=
 =?us-ascii?Q?jHtn8aJpb8byryUPdibl0bxP4A2KmnHx3BmsSgDjwNLzp2I0qvlH2C3A6ayG?=
 =?us-ascii?Q?acJsej1bi0g6bxOYniNf6hWPD1tQc1RYQ90BhsnyBK+3ayjiHNKJBD2fRdFT?=
 =?us-ascii?Q?7QN6iqUb6dvlg4/IpFivuFx8Uz9nxPo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df300575-0f89-4bbf-fb1b-08da2f311913
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 07:21:55.0270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oUPHp+8K+ceURZiwqJySTzfR6bL/8hNTg5fVwzC/WBA7hE92QjU1EFTc2xUxUwkD7P+bjQspAf+g7GYLFwSLWWvjt1qFZBPGYdtFv0JtktE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4137
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-06_02:2022-05-05,2022-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205060038
X-Proofpoint-ORIG-GUID: _p1aXkDSF0CFCrn8qx_bjDkKzvvBft4H
X-Proofpoint-GUID: _p1aXkDSF0CFCrn8qx_bjDkKzvvBft4H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, May 06, 2022 at 02:43:59PM +0800, Schspa Shi wrote:
> > drivers/cpufreq/cpufreq.c
> >     1318 static int cpufreq_online(unsigned int cpu)
> >     1319 {
> >     1320         struct cpufreq_policy *policy;
> >     1321         bool new_policy;
> >     1322         unsigned long flags;
> >     1323         unsigned int j;
> >     1324         int ret;
> >     1325
> >     1326         pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
> >     1327
> >     1328         /* Check if this CPU already has a policy to manage it */
> >     1329         policy = per_cpu(cpufreq_cpu_data, cpu);
> >     1330         if (policy) {
> >     1331                 WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
> >     1332                 if (!policy_is_inactive(policy))
> >     1333                         return cpufreq_add_policy_cpu(policy, cpu);
> >     1334
> >     1335                 /* This is the only online CPU for the policy.  Start over. */
> >     1336                 new_policy = false;
> >     1337                 down_write(&policy->rwsem);
> >     1338                 policy->cpu = cpu;
> >     1339                 policy->governor = NULL;
> >     1340                 up_write(&policy->rwsem);
> >
> > unlocked here
> >
> >     1341         } else {
> >     1342                 new_policy = true;
> >     1343                 policy = cpufreq_policy_alloc(cpu);
> >     1344                 if (!policy)
> >     1345                         return -ENOMEM;
> >     1346         }
> >     1347
> >     1348         if (!new_policy && cpufreq_driver->online) {
> >     1349                 ret = cpufreq_driver->online(policy);
> >     1350                 if (ret) {
> >     1351                         pr_debug("%s: %d: initialization failed\n", __func__,
> >     1352                                  __LINE__);
> >     1353                         goto out_exit_policy;
> >
> > goto
> >
> >     1354                 }
> >     1355
> >     1356                 /* Recover policy->cpus using related_cpus */
> >     1357                 cpumask_copy(policy->cpus, policy->related_cpus);
> >     1358         } else {
> >     1359                 cpumask_copy(policy->cpus, cpumask_of(cpu));
> >     1360
> >     1361                 /*
> >     1362                  * Call driver. From then on the cpufreq must be able
> >     1363                  * to accept all calls to ->verify and ->setpolicy for this CPU.
> >     1364                  */
> >     1365                 ret = cpufreq_driver->init(policy);
> >     1366                 if (ret) {
> >     1367                         pr_debug("%s: %d: initialization failed\n", __func__,
> >     1368                                  __LINE__);
> >     1369                         goto out_free_policy;
> >     1370                 }
> >     1371
> >     1372                 /*
> >     1373                  * The initialization has succeeded and the policy is online.
> >     1374                  * If there is a problem with its frequency table, take it
> >     1375                  * offline and drop it.
> >     1376                  */
> >     1377                 ret = cpufreq_table_validate_and_sort(policy);
> >     1378                 if (ret)
> >     1379                         goto out_offline_policy;
> >     1380
> >     1381                 /* related_cpus should at least include policy->cpus. */
> >     1382                 cpumask_copy(policy->related_cpus, policy->cpus);
> >     1383         }
> >     1384
> >     1385         down_write(&policy->rwsem);
> >     1386         /*
> >     1387          * affected cpus must always be the one, which are online. We aren't
> >     1388          * managing offline cpus here.
> >     1389          */
> >     1390         cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
> >     1391
> >     1392         if (new_policy) {
> >     1393                 for_each_cpu(j, policy->related_cpus) {
> >     1394                         per_cpu(cpufreq_cpu_data, j) = policy;
> >     1395                         add_cpu_dev_symlink(policy, j, get_cpu_device(j));
> >     1396                 }
> >     1397
> >     1398                 policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
> >     1399                                                GFP_KERNEL);
> >     1400                 if (!policy->min_freq_req) {
> >     1401                         ret = -ENOMEM;
> >     1402                         goto out_destroy_policy;
> >     1403                 }
> >     1404
> >     1405                 ret = freq_qos_add_request(&policy->constraints,
> >     1406                                            policy->min_freq_req, FREQ_QOS_MIN,
> >     1407                                            FREQ_QOS_MIN_DEFAULT_VALUE);
> >     1408                 if (ret < 0) {
> >     1409                         /*
> >     1410                          * So we don't call freq_qos_remove_request() for an
> >     1411                          * uninitialized request.
> >     1412                          */
> >     1413                         kfree(policy->min_freq_req);
> >     1414                         policy->min_freq_req = NULL;
> >     1415                         goto out_destroy_policy;
> >     1416                 }
> >     1417
> >     1418                 /*
> >     1419                  * This must be initialized right here to avoid calling
> >     1420                  * freq_qos_remove_request() on uninitialized request in case
> >     1421                  * of errors.
> >     1422                  */
> >     1423                 policy->max_freq_req = policy->min_freq_req + 1;
> >     1424
> >     1425                 ret = freq_qos_add_request(&policy->constraints,
> >     1426                                            policy->max_freq_req, FREQ_QOS_MAX,
> >     1427                                            FREQ_QOS_MAX_DEFAULT_VALUE);
> >     1428                 if (ret < 0) {
> >     1429                         policy->max_freq_req = NULL;
> >     1430                         goto out_destroy_policy;
> >     1431                 }
> >     1432
> >     1433                 blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
> >     1434                                 CPUFREQ_CREATE_POLICY, policy);
> >     1435         }
> >     1436
> >     1437         if (cpufreq_driver->get && has_target()) {
> >     1438                 policy->cur = cpufreq_driver->get(policy->cpu);
> >     1439                 if (!policy->cur) {
> >     1440                         ret = -EIO;
> >     1441                         pr_err("%s: ->get() failed\n", __func__);
> >     1442                         goto out_destroy_policy;
> >     1443                 }
> >     1444         }
> >     1445
> >     1446         /*
> >     1447          * Sometimes boot loaders set CPU frequency to a value outside of
> >     1448          * frequency table present with cpufreq core. In such cases CPU might be
> >     1449          * unstable if it has to run on that frequency for long duration of time
> >     1450          * and so its better to set it to a frequency which is specified in
> >     1451          * freq-table. This also makes cpufreq stats inconsistent as
> >     1452          * cpufreq-stats would fail to register because current frequency of CPU
> >     1453          * isn't found in freq-table.
> >     1454          *
> >     1455          * Because we don't want this change to effect boot process badly, we go
> >     1456          * for the next freq which is >= policy->cur ('cur' must be set by now,
> >     1457          * otherwise we will end up setting freq to lowest of the table as 'cur'
> >     1458          * is initialized to zero).
> >     1459          *
> >     1460          * We are passing target-freq as "policy->cur - 1" otherwise
> >     1461          * __cpufreq_driver_target() would simply fail, as policy->cur will be
> >     1462          * equal to target-freq.
> >     1463          */
> >     1464         if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
> >     1465             && has_target()) {
> >     1466                 unsigned int old_freq = policy->cur;
> >     1467
> >     1468                 /* Are we running at unknown frequency ? */
> >     1469                 ret = cpufreq_frequency_table_get_index(policy, old_freq);
> >     1470                 if (ret == -EINVAL) {
> >     1471                         ret = __cpufreq_driver_target(policy, old_freq - 1,
> >     1472                                                       CPUFREQ_RELATION_L);
> >     1473
> >     1474                         /*
> >     1475                          * Reaching here after boot in a few seconds may not
> >     1476                          * mean that system will remain stable at "unknown"
> >     1477                          * frequency for longer duration. Hence, a BUG_ON().
> >     1478                          */
> >     1479                         BUG_ON(ret);
> >     1480                         pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
> >     1481                                 __func__, policy->cpu, old_freq, policy->cur);
> >     1482                 }
> >     1483         }
> >     1484
> >     1485         if (new_policy) {
> >     1486                 ret = cpufreq_add_dev_interface(policy);
> >     1487                 if (ret)
> >     1488                         goto out_destroy_policy;
> >     1489
> >     1490                 cpufreq_stats_create_table(policy);
> >     1491
> >     1492                 write_lock_irqsave(&cpufreq_driver_lock, flags);
> >     1493                 list_add(&policy->policy_list, &cpufreq_policy_list);
> >     1494                 write_unlock_irqrestore(&cpufreq_driver_lock, flags);
> >     1495
> >     1496                 /*
> >     1497                  * Register with the energy model before
> >     1498                  * sched_cpufreq_governor_change() is called, which will result
> >     1499                  * in rebuilding of the sched domains, which should only be done
> >     1500                  * once the energy model is properly initialized for the policy
> >     1501                  * first.
> >     1502                  *
> >     1503                  * Also, this should be called before the policy is registered
> >     1504                  * with cooling framework.
> >     1505                  */
> >     1506                 if (cpufreq_driver->register_em)
> >     1507                         cpufreq_driver->register_em(policy);
> >     1508         }
> >     1509
> >     1510         ret = cpufreq_init_policy(policy);
> >     1511         if (ret) {
> >     1512                 pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
> >     1513                        __func__, cpu, ret);
> >     1514                 goto out_destroy_policy;
> >     1515         }
> >     1516
> >     1517         up_write(&policy->rwsem);
> >     1518
> >     1519         kobject_uevent(&policy->kobj, KOBJ_ADD);
> >     1520
> >     1521         /* Callback for handling stuff after policy is ready */
> >     1522         if (cpufreq_driver->ready)
> >     1523                 cpufreq_driver->ready(policy);
> >     1524
> >     1525         if (cpufreq_thermal_control_enabled(cpufreq_driver))
> >     1526                 policy->cdev = of_cpufreq_cooling_register(policy);
> >     1527
> >     1528         pr_debug("initialization complete\n");
> >     1529
> >     1530         return 0;
> >     1531
> >     1532 out_destroy_policy:
> >     1533         for_each_cpu(j, policy->real_cpus)
> >     1534                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
> >     1535
> >     1536 out_offline_policy:
> >     1537         if (cpufreq_driver->offline)
> >     1538                 cpufreq_driver->offline(policy);
> >     1539
> >     1540 out_exit_policy:
> >     1541         if (cpufreq_driver->exit)
> >     1542                 cpufreq_driver->exit(policy);
> >     1543
> >     1544         cpumask_clear(policy->cpus);
> > --> 1545         up_write(&policy->rwsem);
> >
> > Double unlock
> 
> Thanks for pointing out this double unlock, do you want to fix it by yourself?
> Or I will fix it.
> 

Could you fix it?

regards,
dan carpenter

