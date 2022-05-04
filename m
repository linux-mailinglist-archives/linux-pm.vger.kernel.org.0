Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DFA51A38B
	for <lists+linux-pm@lfdr.de>; Wed,  4 May 2022 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbiEDPVX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 May 2022 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352117AbiEDPVV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 May 2022 11:21:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BC74348E
        for <linux-pm@vger.kernel.org>; Wed,  4 May 2022 08:17:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 244DwrEq004338;
        Wed, 4 May 2022 15:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=UDce3dSA5KwYXfzEDGYLu2NTzjCahvxcmRBhauWYVCM=;
 b=jLWLfNGGgLBhS7N84xpTQq6okCNzrDwBVHBxy0pDqfRGpxrk+0p7uyHYW4gvU0JihoGx
 IywRKCpyH8PZ6TI/WS5RcI2sawfntkq2s8/NWFnh1MgYWad/AYUSkAhcQ8iss4a8OcMJ
 dJKjb1/1nm+L6GpAwp8pd8Zd7cQGfE35yLUUqdFWw/OwZNRj/h1ZcLEEUqk4UD6uDvWE
 feBAjeXCiMoEBCX/JMokrj8a9HNnpqnLbXEkTYkrtqQsUzNg9uwoL4xbTCjadD0/i9Vu
 UGIhc2PDi4PeCyE2uAQlqNUC72E9w6yR6A1eDOMdsqGoLoiRtPH2HqiKSNGgZt0aeHzG 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0gtmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 15:17:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 244FFSxC023735;
        Wed, 4 May 2022 15:17:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fusafmxqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 15:17:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/GyjL/TyVrR9SuWN1jckv73Ctt9DxDcTIKuRtaX+nWPbj3XXIVYDB+DxOmh8i991dCyhxFkisCp2X/PXTX9L9ZpCpRNchH9BqYu4M4GeyFiP+W+jT8hrc6ES/e6DE7nHGc0gzveC7PMLyq2WD2/Vb4YRT++sYYgqxoHxvZgfXnRpGK9p51bmjzSUB0FuVPsjsE/qb0G+91+ztWyT1hpIXIeQ1rA1g3PCEg25olWsjovEs9sNBmelctQ6yiK1dE5vaRWWldCfuEYLDJAmNllIUUlBN6moFz6XUJEBQ3Kvg76Z5AGlSmw3T2xsZs2Yec55cOwjJ3ETfyMsL19iZAFNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDce3dSA5KwYXfzEDGYLu2NTzjCahvxcmRBhauWYVCM=;
 b=HzGhp6q2ThatFPqkX+1+//cdaArj4L8TVRDBgdQ9t6n78S7Yk4+fCxzWlaw+znSPywbQzyT8/hbiQLxMNdCXR0rkHYD5AJo3pRPEKN2U0/1hqS8FprZeABI/85rnbXNKIobjx1OuPnmm7e2C472EBxOKGsMYHelzjtPw+W1ycVyveL2PbEAPDq8i+ld7w6oABIKH/CYyYJhAkbduBTGk/grzlpdp59FmXK7WF4345nQbqaukDGEQe/BBi6xUt3RY/eqZla6X0FmUlRLTcign+v0BqqVDiJ+In8sdCtjBj7OwDa8ZSk9CNUlLWRR7g074Mr35bi7kToFQaFgOHkHmDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDce3dSA5KwYXfzEDGYLu2NTzjCahvxcmRBhauWYVCM=;
 b=zc0lQaeRtEdf1E3MFb+1Rm8cfpg1Gx+uJqCCc3e1k8fPzWgvpvG4q2rtvn7giqi1lnzy5t8YLXUevxqIDhEJGYneZdou7MOQcC3iAlOqSBt6p85kDy7kM9kSyyrzTQtJ1lMW35ukCx6tMHRnqK22GCkXL482WeSASqWsDqynryQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2182.namprd10.prod.outlook.com
 (2603:10b6:910:48::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 15:17:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Wed, 4 May 2022
 15:17:37 +0000
Date:   Wed, 4 May 2022 18:17:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     schspa@gmail.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] cpufreq: Fix possible race in cpufreq online error path
Message-ID: <YnKZCGaig+EXSowf@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f38306-246a-40f0-ff7a-08da2de138a1
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2182:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB21820FBE57993CBA7A988FB58EC39@CY4PR1001MB2182.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RJYOXrkuSMxFzOlqNkFGd4E1hLPCIQwaEDPdR8/QdvoMnA2YfkNJ7Ah5w4fbQAyuDQfNwaqxCmPii0uKaOeJU5Bak0zn+Av/WzTfziqCwEUzh6Bp32TvPRUyyUWFKBn2yBUMMtNHWnZmfAIl5m22/t+KdqVnHyDKqvBpABzqnhJURVXrdv9mZYlblMYy4MoY8S6i8ZAqhHm6gZYAqwk5WiN9tpLeIhw2vHsrXh0KQNVQHp0Oo9p9bSeKNk0D/1hRm0VjwbyK0yuyJB78zp4kaMUrdsf2YDo4EBonDgQXEnZ/3FNmAf9VktGtPBqC5C5yIrNX3KMzJQZExW08U8MizEyr6c1OwXHJJa6sqJoQavx67U1PE0slMcnLHP0xTN5xX95qfD4YDG52F/g71Poca9sv12U3ACBubnUn54eRhZi7F4DgflKDYLZArtnf8a6eRypc/qShyJfsZH/y8uajX5QS3vgJsMJvJ1rLXRnQQBbM8n+kf4MkJ0im0hFK5AN7rEkBTdlahAlCNjP5g1d7psryQl1vk6gPrpm9KTZBfq7x9PUvPrY7of1gSbjyqZB1EveVMOhqf5dwbVC5tI8u3q2cTbe1p67IzhYtYIb022kkZyc2qvd1gBSVvT9KUdCEnwToh+fEJo5hUhCQLQHXVFPhXiT0RPLkZ6Gxqh9HZz30yZ5t3wThKg6dYepIW5oSpQB3qCzDqY3Rj3m7m3WFUByx6OMztrr0JZQ8BDMEK00=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(33716001)(38350700002)(38100700002)(6916009)(316002)(6486002)(66476007)(8936002)(44832011)(5660300002)(66946007)(4326008)(8676002)(66556008)(186003)(2906002)(83380400001)(508600001)(26005)(52116002)(6666004)(9686003)(6506007)(6512007)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iq3Nt/dLzvNlxkBnRfdJIkqqgelAOyeYbOkiLNFsfdXvRb7BsNQNAf58dERa?=
 =?us-ascii?Q?CQw5wf+7sDahymyMPQdd6N9Ig2kMhNqbnz3+IMYZ6EDVMpNpYrTnSZscLAGu?=
 =?us-ascii?Q?8lmxWGlXuiginWIkJdkYzspZWtnQvTGKhi1zt6dLiewT6eZ625PvO72bwpKS?=
 =?us-ascii?Q?EPjjxpp9NXHBL+N7fTVjr0YYy0evsWf6g/ktXeiioKlg2wTQjiryIBHjtFPH?=
 =?us-ascii?Q?AM4OPQqcCVBPF7uf627FylIN8iJq7ApSf/cWqcB+65HV2A3bqHnHKGLYKJ/O?=
 =?us-ascii?Q?T7IUE8KW2ZkYMq7mMu1bKSxBIqF3PvhjF/N2GewE1sNLsL7EvstnmO3dzni5?=
 =?us-ascii?Q?iKFSPViB2+sp30ryHOKY5CysERsNR5MDNLITnulq4aGag+YmlLuYnCBHKBr+?=
 =?us-ascii?Q?fYEYggTMzutnmz0pbYqoU89jnkFBPaEB0ncjxxyJGvqxsDre0QrhDD2GXA6/?=
 =?us-ascii?Q?prNSSIDTMe+prw4ni7JfFNnb/d+TEMeJYdGCev6E6Yx7BRRvFPJnEq3VuKCp?=
 =?us-ascii?Q?cQBSOWwu9us2BpPRrJJudJwUIVjus4E/pv+/6KzFULfHguxsoyRcocvfLPVM?=
 =?us-ascii?Q?nhchHf1ZLF5MfF/Cj2auy7C6BgsbxhlIOxtPkdhsoBNZSIw9KRG/vJquxAdR?=
 =?us-ascii?Q?KqojGUfYnhiIeHGYcjrjmW+klZcAVuT8isMAOUcRI1rPKNdy2sGGKFe7Nti8?=
 =?us-ascii?Q?xDWctjFqSeJgkM0a36FSKFocOyVUEQCjve3AseG3x1XxA1gZimH2lXHm+Dh9?=
 =?us-ascii?Q?CAv7P/4FzMX0fpXUF5JnBJjgK0bfl7ezoCsfWhu2ofD55ph9EyZtZSWukqRh?=
 =?us-ascii?Q?WktOawHvkCmXzBy8jxKXSgGdiHT0K8RKVaqcJYNVyz0AVRuh8vSQq+q2MZ99?=
 =?us-ascii?Q?ikzwLEaS/gpIbQ2QcknUpIyo/2I/49mtqBXWHgxpP6PWS78K099YQYtpDlT2?=
 =?us-ascii?Q?0OgtT2k8plJR50dMd7TYSEPilxkglFb+2O9mXvQ0v1wkDTOPQV7YM10MsmWW?=
 =?us-ascii?Q?2HLaMFuCIJfm8rz0yzItWlEf7ibstwvDJ9PTyJiDGwjElCF4rhDvXPjrQNtt?=
 =?us-ascii?Q?uLiHy0laCqGabsuzRNaZp/+g+Vi79MqSaJPFhtdPpB43MT/pw8dVSIs0AXg4?=
 =?us-ascii?Q?NtdbYqaIPF8jlZ7VIGhWyon6gVgZ84CoIX/A/J9NlWMcQ9TYWJaT5cWRbys0?=
 =?us-ascii?Q?vWfLwtV4ssX2cXiXt16hgJM4K77QgSRyl9BBIfBoaoN5jVnP812/Gn2lWlZ7?=
 =?us-ascii?Q?U1Rj4IxYX/KlVPhePaBPImP4vuI5GsIIf3VjhJHV5c2D6czIJ6oQrNBvw/tX?=
 =?us-ascii?Q?aSab1F2WAqU79z+jNjj4vYRVqAgJOREac7WwutBnWJ3FhtbMfhiy46GqQhGE?=
 =?us-ascii?Q?ddyqCNJ+ElZYzYd/fYm8Qgb4vp1ha14W9t3CBUYFMFlJCnSQKLaZdX6V0z00?=
 =?us-ascii?Q?owkIEw5VzKtigRvHyBJYDdZUJAG8ioRQz8bFOFuFTJKUd1siaWPDGMyrGy1B?=
 =?us-ascii?Q?BzYZ99fBOcU0f9f1XMQ4mDnPVFp8zdCg4uKi2v+u4VKX7D/VlYxU5pm2dXMH?=
 =?us-ascii?Q?DbjOrmKsbG5foZNpHZl6HywezEy9M9MLj3gDZyN+glDTqNBMJz6Q5Iuum3eG?=
 =?us-ascii?Q?p7ipuraFKetMUQon8vhf4wCwn19m53GCmEX2+Z0oavz0Vq4L5NiKA9+eJXWj?=
 =?us-ascii?Q?eMhs0EYOPNOe6d6dZpdPwtMybwDbJEeVqlzYiwaJr1Kew/b1Jo87LmMitLp+?=
 =?us-ascii?Q?7o9WKd51tjaWDBCg8A0p1eFRbppSLMw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f38306-246a-40f0-ff7a-08da2de138a1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:17:37.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0xEZ3ZiA4aJHnXh/K22I2RsX+ajefqykBJ1nMf54oRkNqLJ2tlDb1KgOcCfCfZAEOHFp3hhcUZI74YULD4NmlEgWVxftmHB6Awcz3gtQSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2182
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-04_04:2022-05-04,2022-05-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=970 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040098
X-Proofpoint-ORIG-GUID: FPlaOyypZo15g31_jccUXxIuPv4u8F38
X-Proofpoint-GUID: FPlaOyypZo15g31_jccUXxIuPv4u8F38
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Schspa Shi,

The patch f346e96267cd: "cpufreq: Fix possible race in cpufreq online
error path" from Apr 21, 2022, leads to the following Smatch static
checker warning:

	drivers/cpufreq/cpufreq.c:1545 cpufreq_online()
	error: double unlocked '&policy->rwsem' (orig line 1340)

drivers/cpufreq/cpufreq.c
    1318 static int cpufreq_online(unsigned int cpu)
    1319 {
    1320         struct cpufreq_policy *policy;
    1321         bool new_policy;
    1322         unsigned long flags;
    1323         unsigned int j;
    1324         int ret;
    1325 
    1326         pr_debug("%s: bringing CPU%u online\n", __func__, cpu);
    1327 
    1328         /* Check if this CPU already has a policy to manage it */
    1329         policy = per_cpu(cpufreq_cpu_data, cpu);
    1330         if (policy) {
    1331                 WARN_ON(!cpumask_test_cpu(cpu, policy->related_cpus));
    1332                 if (!policy_is_inactive(policy))
    1333                         return cpufreq_add_policy_cpu(policy, cpu);
    1334 
    1335                 /* This is the only online CPU for the policy.  Start over. */
    1336                 new_policy = false;
    1337                 down_write(&policy->rwsem);
    1338                 policy->cpu = cpu;
    1339                 policy->governor = NULL;
    1340                 up_write(&policy->rwsem);

unlocked here

    1341         } else {
    1342                 new_policy = true;
    1343                 policy = cpufreq_policy_alloc(cpu);
    1344                 if (!policy)
    1345                         return -ENOMEM;
    1346         }
    1347 
    1348         if (!new_policy && cpufreq_driver->online) {
    1349                 ret = cpufreq_driver->online(policy);
    1350                 if (ret) {
    1351                         pr_debug("%s: %d: initialization failed\n", __func__,
    1352                                  __LINE__);
    1353                         goto out_exit_policy;

goto

    1354                 }
    1355 
    1356                 /* Recover policy->cpus using related_cpus */
    1357                 cpumask_copy(policy->cpus, policy->related_cpus);
    1358         } else {
    1359                 cpumask_copy(policy->cpus, cpumask_of(cpu));
    1360 
    1361                 /*
    1362                  * Call driver. From then on the cpufreq must be able
    1363                  * to accept all calls to ->verify and ->setpolicy for this CPU.
    1364                  */
    1365                 ret = cpufreq_driver->init(policy);
    1366                 if (ret) {
    1367                         pr_debug("%s: %d: initialization failed\n", __func__,
    1368                                  __LINE__);
    1369                         goto out_free_policy;
    1370                 }
    1371 
    1372                 /*
    1373                  * The initialization has succeeded and the policy is online.
    1374                  * If there is a problem with its frequency table, take it
    1375                  * offline and drop it.
    1376                  */
    1377                 ret = cpufreq_table_validate_and_sort(policy);
    1378                 if (ret)
    1379                         goto out_offline_policy;
    1380 
    1381                 /* related_cpus should at least include policy->cpus. */
    1382                 cpumask_copy(policy->related_cpus, policy->cpus);
    1383         }
    1384 
    1385         down_write(&policy->rwsem);
    1386         /*
    1387          * affected cpus must always be the one, which are online. We aren't
    1388          * managing offline cpus here.
    1389          */
    1390         cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
    1391 
    1392         if (new_policy) {
    1393                 for_each_cpu(j, policy->related_cpus) {
    1394                         per_cpu(cpufreq_cpu_data, j) = policy;
    1395                         add_cpu_dev_symlink(policy, j, get_cpu_device(j));
    1396                 }
    1397 
    1398                 policy->min_freq_req = kzalloc(2 * sizeof(*policy->min_freq_req),
    1399                                                GFP_KERNEL);
    1400                 if (!policy->min_freq_req) {
    1401                         ret = -ENOMEM;
    1402                         goto out_destroy_policy;
    1403                 }
    1404 
    1405                 ret = freq_qos_add_request(&policy->constraints,
    1406                                            policy->min_freq_req, FREQ_QOS_MIN,
    1407                                            FREQ_QOS_MIN_DEFAULT_VALUE);
    1408                 if (ret < 0) {
    1409                         /*
    1410                          * So we don't call freq_qos_remove_request() for an
    1411                          * uninitialized request.
    1412                          */
    1413                         kfree(policy->min_freq_req);
    1414                         policy->min_freq_req = NULL;
    1415                         goto out_destroy_policy;
    1416                 }
    1417 
    1418                 /*
    1419                  * This must be initialized right here to avoid calling
    1420                  * freq_qos_remove_request() on uninitialized request in case
    1421                  * of errors.
    1422                  */
    1423                 policy->max_freq_req = policy->min_freq_req + 1;
    1424 
    1425                 ret = freq_qos_add_request(&policy->constraints,
    1426                                            policy->max_freq_req, FREQ_QOS_MAX,
    1427                                            FREQ_QOS_MAX_DEFAULT_VALUE);
    1428                 if (ret < 0) {
    1429                         policy->max_freq_req = NULL;
    1430                         goto out_destroy_policy;
    1431                 }
    1432 
    1433                 blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
    1434                                 CPUFREQ_CREATE_POLICY, policy);
    1435         }
    1436 
    1437         if (cpufreq_driver->get && has_target()) {
    1438                 policy->cur = cpufreq_driver->get(policy->cpu);
    1439                 if (!policy->cur) {
    1440                         ret = -EIO;
    1441                         pr_err("%s: ->get() failed\n", __func__);
    1442                         goto out_destroy_policy;
    1443                 }
    1444         }
    1445 
    1446         /*
    1447          * Sometimes boot loaders set CPU frequency to a value outside of
    1448          * frequency table present with cpufreq core. In such cases CPU might be
    1449          * unstable if it has to run on that frequency for long duration of time
    1450          * and so its better to set it to a frequency which is specified in
    1451          * freq-table. This also makes cpufreq stats inconsistent as
    1452          * cpufreq-stats would fail to register because current frequency of CPU
    1453          * isn't found in freq-table.
    1454          *
    1455          * Because we don't want this change to effect boot process badly, we go
    1456          * for the next freq which is >= policy->cur ('cur' must be set by now,
    1457          * otherwise we will end up setting freq to lowest of the table as 'cur'
    1458          * is initialized to zero).
    1459          *
    1460          * We are passing target-freq as "policy->cur - 1" otherwise
    1461          * __cpufreq_driver_target() would simply fail, as policy->cur will be
    1462          * equal to target-freq.
    1463          */
    1464         if ((cpufreq_driver->flags & CPUFREQ_NEED_INITIAL_FREQ_CHECK)
    1465             && has_target()) {
    1466                 unsigned int old_freq = policy->cur;
    1467 
    1468                 /* Are we running at unknown frequency ? */
    1469                 ret = cpufreq_frequency_table_get_index(policy, old_freq);
    1470                 if (ret == -EINVAL) {
    1471                         ret = __cpufreq_driver_target(policy, old_freq - 1,
    1472                                                       CPUFREQ_RELATION_L);
    1473 
    1474                         /*
    1475                          * Reaching here after boot in a few seconds may not
    1476                          * mean that system will remain stable at "unknown"
    1477                          * frequency for longer duration. Hence, a BUG_ON().
    1478                          */
    1479                         BUG_ON(ret);
    1480                         pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
    1481                                 __func__, policy->cpu, old_freq, policy->cur);
    1482                 }
    1483         }
    1484 
    1485         if (new_policy) {
    1486                 ret = cpufreq_add_dev_interface(policy);
    1487                 if (ret)
    1488                         goto out_destroy_policy;
    1489 
    1490                 cpufreq_stats_create_table(policy);
    1491 
    1492                 write_lock_irqsave(&cpufreq_driver_lock, flags);
    1493                 list_add(&policy->policy_list, &cpufreq_policy_list);
    1494                 write_unlock_irqrestore(&cpufreq_driver_lock, flags);
    1495 
    1496                 /*
    1497                  * Register with the energy model before
    1498                  * sched_cpufreq_governor_change() is called, which will result
    1499                  * in rebuilding of the sched domains, which should only be done
    1500                  * once the energy model is properly initialized for the policy
    1501                  * first.
    1502                  *
    1503                  * Also, this should be called before the policy is registered
    1504                  * with cooling framework.
    1505                  */
    1506                 if (cpufreq_driver->register_em)
    1507                         cpufreq_driver->register_em(policy);
    1508         }
    1509 
    1510         ret = cpufreq_init_policy(policy);
    1511         if (ret) {
    1512                 pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
    1513                        __func__, cpu, ret);
    1514                 goto out_destroy_policy;
    1515         }
    1516 
    1517         up_write(&policy->rwsem);
    1518 
    1519         kobject_uevent(&policy->kobj, KOBJ_ADD);
    1520 
    1521         /* Callback for handling stuff after policy is ready */
    1522         if (cpufreq_driver->ready)
    1523                 cpufreq_driver->ready(policy);
    1524 
    1525         if (cpufreq_thermal_control_enabled(cpufreq_driver))
    1526                 policy->cdev = of_cpufreq_cooling_register(policy);
    1527 
    1528         pr_debug("initialization complete\n");
    1529 
    1530         return 0;
    1531 
    1532 out_destroy_policy:
    1533         for_each_cpu(j, policy->real_cpus)
    1534                 remove_cpu_dev_symlink(policy, get_cpu_device(j));
    1535 
    1536 out_offline_policy:
    1537         if (cpufreq_driver->offline)
    1538                 cpufreq_driver->offline(policy);
    1539 
    1540 out_exit_policy:
    1541         if (cpufreq_driver->exit)
    1542                 cpufreq_driver->exit(policy);
    1543 
    1544         cpumask_clear(policy->cpus);
--> 1545         up_write(&policy->rwsem);

Double unlock

    1546 
    1547 out_free_policy:
    1548         cpufreq_policy_free(policy);
    1549         return ret;
    1550 }

regards,
dan carpenter
