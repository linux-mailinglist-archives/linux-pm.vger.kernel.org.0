Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60A260075B
	for <lists+linux-pm@lfdr.de>; Mon, 17 Oct 2022 09:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJQHJp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 17 Oct 2022 03:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiJQHJi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 17 Oct 2022 03:09:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBF0E0D
        for <linux-pm@vger.kernel.org>; Mon, 17 Oct 2022 00:09:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29H73rOT001064;
        Mon, 17 Oct 2022 07:09:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=yzfTk/FQrZFxByOQCK91rNv8tPrV4ZRNRGwG7Yl2dNo=;
 b=iJ7Ld94PYbt3xBAJH4OUWwkqUkjIyeDUOZAu8McylE1zSU8UAW7zNSzx5b6Y8XotZopC
 QY+ecA7hPfHJn34nAUlQDVGAwaMms5MBROpLw4r8SNWcib3gdHcHp/SGF3FqvZjj5ZdF
 XN8QJbo76u+RyKvgb0bDCrXBIcEkzvujFjD+dyh/M6ytuZa4IIp3eAGaPK5B9pRt4kLM
 JjAjzcaO2JG6Zb9bxz5KHmrYTiEwnnLBBGBWJut+Yk8OLR91K/t3VPyvdLyx1jU2B0Hm
 e666NrsneebTNnnRBELsFTO+zDdemyxV6ZFFKhfieWlKOkpU46VbG//YW5CeYmRiTl8q vA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k91ra02p1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 07:09:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29H51DHI029464;
        Mon, 17 Oct 2022 07:09:22 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hr8fcm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Oct 2022 07:09:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUP0fv2bVeoI1FjFayERB7SEEakKb0fVKo4pw63bNEnZQInNEnEVYviCGNli2tW9x3zPTW9V3pkrAMGQXBq0woCle8HjVeB5b/HVDaNJExmv+5JbZqozEKbNRGayUz3RccicKkGVnXp0K8dPKtBOHtYUUiP8Q8ecscXj0UfEFK6OgPy6/NLtYrpWu4keyRrUDhhv5VneRRtMJ7p/hvk4dLeA/4rqt41IWhGYuRD/p9QZXnvmSKKBgntXfuygpSLaJ7rZhgRyS1KdHCkBQ7YWaEaL+jizZskOojUzpD8euDYkkXlX6hbB7B7d7/KAfFOcWTBBI8wLDfG1scM5zDSpvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzfTk/FQrZFxByOQCK91rNv8tPrV4ZRNRGwG7Yl2dNo=;
 b=UQBxtBJPXNipMk52zPqlamOnwKfflAZSP3TbFhTvuOJjFbrsM5av8LeCMAM+XGv6rE2lpnmL6ZAgj4OuVVFu1GDp3hvRquw0G6qvPhQFF3S2tzT8FzZUEd84nL3gIPsABci+nYyjETWjYJ6IDvyp23QyXjvc8TfsSynqm0eVwKNLjHMfTpSxLbzSQX8jPa3JdFo2+Q0mDPYPu7Ml2tOG/ru+qwUIijnEkcbi3f3v2rXlhBgHnI49HlbWs7AIuI5//0BSZbcSILwuwCl6pCXDYzcGZkW2ciR+YoqYkkvv/ZWqAFYWHavb68Gh7EeZIUiZiwPlIfo2qw6HQV8nIJMgmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzfTk/FQrZFxByOQCK91rNv8tPrV4ZRNRGwG7Yl2dNo=;
 b=DXz7f3VNgbdRAp6S80V0p1XXqO+/BbWk6e7W3JwdFdqCAHlF5hLgvcyX0gI1Y4mgzGc2b+i4RSZFKGp3gRjlvkzyWXVlH/noEIvomhQVwDocX7JtWrcrxA5lW/FAuAbdc/Q/jCK8UnN1qDD5oXm19emdlnRUK35YAlrZ1Md9EGk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5011.namprd10.prod.outlook.com
 (2603:10b6:208:333::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 07:09:20 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Mon, 17 Oct 2022
 07:09:19 +0000
Date:   Mon, 17 Oct 2022 10:09:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] thermal: Add cooling device's statistics in sysfs
Message-ID: <Y0z/knSyW1e6Dg3D@kadam>
References: <Y0ltRJRjO7AkawvE@kili>
 <20221017055735.is4by26po2woxzet@vireshk-i7>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017055735.is4by26po2woxzet@vireshk-i7>
X-ClientProxiedBy: MR1P264CA0076.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:3f::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BLAPR10MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 1122cc77-6b16-4a0a-8be7-08dab00e82c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbcLf5W/+/ctKrIiyU12EHxc+oUuunKFWie2UvelqsbPl3nq5dZrWn34ZDAyni9uiEfVU5v879FGuEgmP1TWAVHwuN8t1SqG4k7CxcabCMEji1TNEfO8a30KF4AzN+mM5BRUmVv40eFbKc8R8ILA6J9u+YERb1rsV+NvRf78kJrKPqVVxb4qN2v/TDIkIpnJZFrP3FTMwABtBZzlIJhkXw+pyxr5dARZf/mobMgpjqUe3kIMFvN1lCz4EzxxsXok0BCoIt3DBCGn57rw6XOHOdb8hBAtRVp8KRQ4fcie2WzJV+3mZlaydUq8vE8LtBbQCkIE5RM7xQ9qMrNYL1B4nXqD3Hq/IWfJGhByTHmk6FiUKgg7pgwFF+vnvHDwXwpFPcnzNkMoyItZpbJVJ4Bzl4gd68Ac2LBBHcouDJHqw9i+pkXF1d9ETWnXNkT/Vi5/gz6rFzeaEuYlsjA2yuH3Ql+cL0DzuOpsa+IyP7h2Fa0/pDNKyGUq699QJnZvXo308UYTQ+0LxBckhaFL1tl5/vK7UccWac5C7F5RNbc2iGeb6RPZDTM+9LLKRPdmWAvqje1qu8UXwdWsV3kiA4op0rjWSAk/wlG2YUdnA79rYNrrAcyJ+8YHA6NsT2HSUaX2du8GpJv4NxEDr/6/y+kPhdPZ+RYMNMoTpF6bI4SZoAyIlZGTnoPkffMF223iRGrASrvVPak6SOAv6C5qC970eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199015)(33716001)(86362001)(4326008)(41300700001)(53546011)(6512007)(26005)(6506007)(8676002)(6916009)(5660300002)(9686003)(66476007)(44832011)(8936002)(66556008)(6486002)(478600001)(66946007)(6666004)(316002)(38100700002)(186003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j2OvWHD8duCJCIG8W4HoaTPtsvvp3SKEZ5l5xck2+TmScnfdca1V5lpE13lt?=
 =?us-ascii?Q?y0CZJi2PUnARGjwpMa5OTDCu+/Nl4GCi0e1UgacIizcHJN5O9bVDP5JNsG+X?=
 =?us-ascii?Q?5f+i6LHNrjSGeff/a7Iskr5QB3LoqtgAttHPQYoitu8WSvqQrA8r0xKcxgM+?=
 =?us-ascii?Q?OffBiyV+KdOHVLkSpAKco3yBZbpX7iLt18HBaZvk/aUp/WkBxRgkSQ6GbrLk?=
 =?us-ascii?Q?0apGdPjgu817QmF+e4ByNr69jR6/zMDXiYP/fK8qBEASJqCgROHcgMD6Fvnq?=
 =?us-ascii?Q?9gdbRm5OLlm0wiCsHwdOgkUPBBta1IfOknndTpUn/UdsB552OuYy6iuWIcR3?=
 =?us-ascii?Q?BGLSa48W1PL/kUy1spE+65/CBQYZuiolcdJOpCI4EDVX5v0iH8+o4D6Mowdo?=
 =?us-ascii?Q?ojRfZN4MxS6r5eaYDfcFBBh8A+kbTleCToSHHEZODLW8MyNczv1Axwx52RXW?=
 =?us-ascii?Q?Vbstm+amSRgquXEpO7C6ATsPjiL2y7w/fjWm2Mmq3AAxmKJOU3HkA2p0NkOO?=
 =?us-ascii?Q?Lhec841//T9NYJCMhgFU3IRaDfTKki1pzz4Cr0Sy8JBL8AV+wqpbO5VKgoqx?=
 =?us-ascii?Q?SlNb4JbTnOYc2YSjdF8nGiRyy2YErFiNP1GVawOJbleJgQQ69/0NDpXEMTbz?=
 =?us-ascii?Q?I4z7UCOipcHoSNtmfP+G7aisfGXptARF/+0JBpX1BY0OUu+aSg3hACujmZ8V?=
 =?us-ascii?Q?ypjQpFd73GcCF3MDz6T2QpJLtfrSKTGCNWmQsDgmQXU0gB/fCxHtPTeRP1qm?=
 =?us-ascii?Q?Rl667UXOpDncXEj8X/VxKoVE6GId8b046i9+e74c2Tx8y0xsFa0cZw5qiyAv?=
 =?us-ascii?Q?4AFhltkwZYT7t9ppN7+W+TbJs/EEj7keGnqUKt7ZG7f4Mg3E7J285rDsgPye?=
 =?us-ascii?Q?1i5CX5Zxv4tBbSmjtQXbwCIrAJHDGyILY3fttfvyNyX06KqiANvmZVcNBvhN?=
 =?us-ascii?Q?Ipv7J2G/4s+5eQJPsO8GunOmeeSW7eTxQGWQWJGpS8nQSJ1D1Ylt5wyIUQ7t?=
 =?us-ascii?Q?EPOGq9BQQA8Q9hWSlCXLw6WOtFjSUJqh6u92BaIOWGl/sw+tEeUa3Zn45CsT?=
 =?us-ascii?Q?+jJeQD47mEn8MTM8/G8ex/oJotksGGfW9Gmepd1MK9T4GmZg5+Jyt2CxujhB?=
 =?us-ascii?Q?divxu+kBBSntud5VD0Fwg55KlNt7awifJF1QQBvCqbd289DlaQ6tRADAMGa7?=
 =?us-ascii?Q?XoO98VqODAHnOU7ENMuWJTLq1bgcMG+0yz0qI3HSg3HKToM69GtBYrXseL6n?=
 =?us-ascii?Q?5orjubxxTFYUjoN7CKuc/x11gNtzzozCDgWTDuSvreMwpBvmVuWlvHZJbwQl?=
 =?us-ascii?Q?VgWDNf+e0Vq8ljzYjtPwtvHT8gSkspturXtTzsNv7ce8sZRQLLjlE3/mT1e9?=
 =?us-ascii?Q?sUKTGcQ7M2lRrAIVHNLr05S51HvUVXRM424BYTYC0AC+qAOpFhrqEXL0R0Wr?=
 =?us-ascii?Q?otKh2z1ElVdtz5MWN5Nqg6L7dlRci3UZSGZ+OexVYaHhYGSFS32wanpS9YXw?=
 =?us-ascii?Q?A6vwHEaDAWZGN2s+fXI1pZUK10Fstz4EPoKf7fKukuAGO3Mw1YWXPFechcJB?=
 =?us-ascii?Q?4Q9vUbULrP/tTZzL9LJISN5r1tlg/SXiZMGQnP2TdN2Dmg9fmjcrA3Tl0LT9?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1122cc77-6b16-4a0a-8be7-08dab00e82c7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 07:09:19.8055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Clbt6pzj6vgdRGqYrJsJY+bBmrk1Zo1+t9psDJUB1OTJsCqrrLjAOzU5NsYJzpfBDonuepIsuytOItZrTNuZEepqzn31lqCWiRCDEr+g9aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_06,2022-10-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210170041
X-Proofpoint-GUID: 8gUsldoIbnVVIBsN5P1KP6r6fzbxCMbi
X-Proofpoint-ORIG-GUID: 8gUsldoIbnVVIBsN5P1KP6r6fzbxCMbi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 17, 2022 at 11:27:35AM +0530, Viresh Kumar wrote:
> On 14-10-22, 17:08, Dan Carpenter wrote:
> > Hello Viresh Kumar,
> > 
> > The patch 8ea229511e06: "thermal: Add cooling device's statistics in
> > sysfs" from Apr 2, 2018, leads to the following Smatch static checker
> > warning:
> > 
> > 	drivers/thermal/thermal_sysfs.c:656 thermal_cooling_device_stats_update()
> > 	warn: potential integer overflow from user 'stats->state * stats->max_states + new_state'
> > 
> > drivers/thermal/thermal_sysfs.c
> >     642 void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
> >     643                                          unsigned long new_state)
> >     644 {
> >     645         struct cooling_dev_stats *stats = cdev->stats;
> >     646 
> >     647         if (!stats)
> >     648                 return;
> >     649 
> >     650         spin_lock(&stats->lock);
> >     651 
> >     652         if (stats->state == new_state)
> >     653                 goto unlock;
> >     654 
> >     655         update_time_in_state(stats);
> > --> 656         stats->trans_table[stats->state * stats->max_states + new_state]++;
> >                                                                       ^^^^^^^^^
> > The new state value comes from the user via sysfs.  It is <= LONG_MAX
> > but otherwise there is no limit on its value.
> 
> This routine gets called after cdev->ops->set_cur_state() has returned
> successfully. That callback does the verification of this value, based
> on what's the maximum value allowed and hence the size of the array
> here.
> 
> I don't think we will have any issue here unless the cooling driver is
> buggy and isn't checking the state properly.
> 

I only looked at the 1 example I posted, but so far as I can see from a
sample size of 1 they are all buggy.  100% buggy.

This strategy of relying on the drivers to do it correctly was doomed
from the get go.

regards,
dan carpenter


