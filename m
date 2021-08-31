Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E43FC688
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 13:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbhHaL1t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 07:27:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26264 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229686AbhHaL1s (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 07:27:48 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V9YcGh022218;
        Tue, 31 Aug 2021 11:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=r8ZhiKpBJYDl+zGVL6zkIwoJ5xE4hk2V3plPh2b6Bhs=;
 b=q6EZ6UDyDBrMJoz/30xMhtMif0v64XexpzKGLmRg/TDkitrR6AGmcfR/NzXiQ69m9hDQ
 xURrmMRYunjubpdBq0wIBOVG2wnNpzCSppXrZ5RL6J53Fcw/Hbou5I7FAzbEfuxdE/Zr
 MuMLMWQEYMfG1zjxurVQHEYPBBbpMtH3zbV0QmNzwU+66dFxNVm/XQBr1z5p7w1jOrQP
 xqzQW3gJK2t5EKNKDLhuby/4mcbYZMcHYq+ZM7IRJqtidccuM+PXu63+Duxj/1+8/8Lm
 Sjpd9u/jUG2hsZjzTKxuAq7j9Zc1yhIWkhzH0zg8taadu3Fgzxu5/vne9nyRt7Hnq6L/ Ew== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=r8ZhiKpBJYDl+zGVL6zkIwoJ5xE4hk2V3plPh2b6Bhs=;
 b=aQ7SM3lHO2bOg8M1EiiBa0422SRQJQlsCDmEQuKjbCQ0Z8thsUioLl8gLZj1244+Ae4n
 N9vX1k4byH7qTCM4zos61wDvyp14orN8uO5HklRery9+xp6/8+V0YdG2VL9ZDD0fkY/X
 7A6oCPQ0mXKfif0H9qqEcbtXHEBFpP2s7Es91YSNIsaJzn65ZJbHjlgpUbPM0OplfOQC
 /5JcthqAzZ5MCNermNBzIaD+40d/TcP6r22T4RqoJpskW9r9xzZX6VnOutTiPG2lh9Fh
 nViwZihF2+DhLyxnTefbYiUG/guqfJjGuQJdnH2sJ8jRPEORLIfRg7+bpRBW8bDsUy+s 1Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf2mgn8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 11:26:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VBFcAA121391;
        Tue, 31 Aug 2021 11:26:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3020.oracle.com with ESMTP id 3aqcy4htg7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 11:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEA+Sd73i9lWzIVuPnP8ImbUNC3q/KS5qMEYoGXOLnnChbKJJ43jPfn4jvwm5m1f+HHS9GFHJKUG0y1YieusLT3wJaHqsrFAwFTjXT3zvGj5aGfqwAjcOu53vcambk8s5xb9GjGsSFpSm2xxrJAH6n0u9Mtu/Dkzhp+QIxd783MCmyCD3AGU/PPR0VOZqdysqrg373Nfh/v3MP67NifTbf2OaBWBo2M7KO1uHVRqFw5D2EioYSabBV1s26gTQ61/DG5CbrUtyNTiMFby6V6iyDxP3dMT5ljJJJ2j/p2TeqJXlCGkTiSCTfrcllPjMjzn+dagbduhnKjSdowYr3HvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8ZhiKpBJYDl+zGVL6zkIwoJ5xE4hk2V3plPh2b6Bhs=;
 b=dkmpVWAUVNkbGP6yyx/iaJBLvNGVD8c/skVsmy18ALIyum5KlAwz953bQScITwvWud+7spWby5X3yReerXfSc1n6NGSSCGbFaVUr4jTkGSOR3nsO4EHkMOOoQcWoRpKpVsweLBkZGhz9vINUjjbDyJHjmkzxxMxu7R9tNAPY5+Lam79Jh00xaR6p+bNGUyNyY+adpCiazPN18RKWYkZky/4Y4vvYugoX0p7dzqLKD76BCymTmBqKAjS9C4UlaCz2w3/6Ypcy7HSaAfdl4x1aA1LLLA8EMAwUWmDBIYgfBpie5dzhQUdLOVn9bMe34KL8jyN+Q8yH+N+Tr1N8z0kojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8ZhiKpBJYDl+zGVL6zkIwoJ5xE4hk2V3plPh2b6Bhs=;
 b=tmr8KDf/qbaS2R+fQdaGEARHDu/nfM1hheWG6hXx+QLmE1U7jBgCcN4nyDEGRwyEmso+FII5uNUjK7ud/IlQZZPL56doSrQPC3aK3+WLbzSAa7UoyffllOb575Wk67P3zYjJ9j24oruRihvROJgXbTloSlyeDaJCa+wvYkA1CNM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2158.namprd10.prod.outlook.com
 (2603:10b6:301:2d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 11:26:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.019; Tue, 31 Aug 2021
 11:26:50 +0000
Date:   Tue, 31 Aug 2021 14:26:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     jsmart2021@gmail.com
Cc:     linux-pm@vger.kernel.org
Subject: [bug report] scsi: elx: efct: LIO backend interface routines
Message-ID: <20210831112624.GA24558@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LNXP123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LNXP123CA0008.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Tue, 31 Aug 2021 11:26:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e18b88f5-3da9-4898-26fd-08d96c7239bd
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB21581E2E032D50CB6CF6BAE08ECC9@MWHPR1001MB2158.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TympBs2YJeXoiV9f9OIbhjoQ8d2EsSytR4My88FQxe2rk9MQzxcgNShOa7J9UcUnxEqVqhL5m7DTRNIFjrHmoALVw0kg2bAJ0k4f/7sgkriRS+oGN6fUW28OnyN4f+ESFEVREl6ZsSET+8K3tdJVljWvMrUWmBs9zq+vm3voseGHGqi/zEPaOmKyIMlbcCWzcGcb2BpSf4WioAiMOBCJA5b1ddigHb1VSM4N9A4zkDvCrhsFPkQiu3JO5j8s470psGDsIVbtRLaEwmqKpjKYImUxaYkQ4KewDPirG0FNj15+AlZcWIf5a2jHygzJJiY7moIm34TC+ZFo7zqONw0NWmaWk8ASrOyXppgrSFSTfEbuKtXU1LJREArroHB2QnU7mb1p9GJ8z+4dSmTAT9lQqfVV3V/twi5FlDhFOs58AMzmk5/FuRVMUO6nPWjP74IjF8+3y8CGMAks4x+eyEC37OQYPhjE5c0fPActToSnQFuXq3mERGqV6RA9gi0dW3DSLILCzeKf0C94+s+h924eYSBVk1+WuY0bhhmOXUKPqQse35JF1+/L7fXy51SCCiNFG+eyGrzEWY9ZkSqIwFnmKZfblZmepX28A0ZzpEsVPWs52rA6FbhqQ1ZsZXs8c4bE+A46eKlhtVBd2/H4tC+vaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(186003)(52116002)(316002)(66946007)(86362001)(38100700002)(66476007)(6496006)(66556008)(5660300002)(508600001)(6666004)(4326008)(55016002)(1076003)(33716001)(8676002)(44832011)(83380400001)(8936002)(9576002)(33656002)(9686003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qxS3EX1Z1HU0Eq4VoJU7vP7siN5YYjzdBaoFS5VZvG9SMRA5jgt+Hhw6Lue3?=
 =?us-ascii?Q?LX7zM5s0bK6jLk8E8Q5YMBGgeZHs7dxKq74LH0wqDFuqkFB1VcR87xKcEAhY?=
 =?us-ascii?Q?R8dvx0PXhKBW3viXvvjE7ZjOBr79l4qHl+zBuFpmS3Cy14nwGKfAGNDOV2HH?=
 =?us-ascii?Q?bfagWVf/fITnCcPSwYM41iJQyU5MCEIewMEUIAYXona4SZmc2gDJUrqB5cmu?=
 =?us-ascii?Q?Jec0AS+51o7d36LWySrlMorgVM0LI36z8tgjeKk1XQ1qDY38x+MExnBLamd8?=
 =?us-ascii?Q?6ZPaUg1Dou4Yf5J+aXOFqSFBWbO+ZRDNc0kwmeUI4lmP3uY0LH7aQZL0tjnf?=
 =?us-ascii?Q?lg4Kame6I02AqZYDBYOsy2xstjL3M+FHaf/y+ww8KmnFGVkZLiuUAvdp3vxM?=
 =?us-ascii?Q?5McQ9kFLYFIdDLP6tdwZg/RHkbyOmEr1X9l+7gQ8KNKbIz/LIs/0IuJpgSHi?=
 =?us-ascii?Q?G8CoPvJfJXeEVj6yzCTh0dG4D/7wjKfXK4q+Nxx+8urIqDWFNYOchgj9S4B2?=
 =?us-ascii?Q?a6OymQ7Wx4dyJWMMhl2snM6/e1CcsFyd0RNT5yfTNI9AMc3qOUVIcA/mz8a+?=
 =?us-ascii?Q?JMdWQ4bUBdGKSS6Skg1hlqL51m0Xcxqg81dW4YyAiTcFO6o1nv61deWxxhg3?=
 =?us-ascii?Q?ynes8pXnT7BptLh9Hms0NXIEdiT9JdZbCeCJjX/aES0CvPF70WKtZUCzo014?=
 =?us-ascii?Q?w9BA5wwSq4jRyGS4THbu4JX+YhvKmW+H7rlVIWNgugabm1vav2x3XlvqAS8u?=
 =?us-ascii?Q?+v4cX80JFAT8ZZ/7gz1NNQFkOzABw69uA4Weia0Ehx5TKQO6uB6Zwnby8X9/?=
 =?us-ascii?Q?LJNVJO9oahwzlfRCoxVd1pBzaBpxzE0P/xgoi106ODCDEsb7xcWyQMNlpT54?=
 =?us-ascii?Q?O2lqgamhwQZvZuqG94CX+zz6cfmjxUGJJwoQNPCldrTz4LlfukGB148FVCQW?=
 =?us-ascii?Q?C/HYQMSph7dg2EOAxJfnvz5U6WUsVTLYgjWFWFCB7b3fhXsYIBcAA4FE5FIe?=
 =?us-ascii?Q?1wV0eswQeL4ZXkomtpGoiqq9G5AUTjgMnf7lFcRRzn77+DM/w7lW1qjFyGV1?=
 =?us-ascii?Q?7iMCvJvgWncetf5Zatt6zHjZCLSY9kpE2VtIeCZ9aS27bINY5JiNKhjsfYLE?=
 =?us-ascii?Q?Optaq0i8ClVZDEWW0WOnnksBksrgt4By/ATIWadPh9ZWnNMEVFZbJS7q5py9?=
 =?us-ascii?Q?DD4GZ7qqhTaQ9eKNdttJP6FAngk6J4KYqRnz8UtK/lo4UONiz1Dr2nynRDd2?=
 =?us-ascii?Q?reuYSFRp39EZIkUEE5KY2Pu5UabwDbvVqV8mOkj+fDru+NF4rdF+IB0lLkEt?=
 =?us-ascii?Q?lQmaf812yu1YNlHV+pPwtHK745d3lUxi5swTIkfCNu7sK7Z8BhlPc6ocpyV0?=
 =?us-ascii?Q?oyoZDR4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e18b88f5-3da9-4898-26fd-08d96c7239bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 11:26:50.3673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 182ZCjxEcw/5Uh6m+b3W/jmGOX7HYhC25qaIKivsLQfn7eRW6agY3KIdXQfBYegN53AzX/HEL/9VDcDDLjEZAqCxv4ZIUXRV4IE4i+XSVfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2158
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=899 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310065
X-Proofpoint-GUID: PT_z1c_g-0PHHa6_-7srnwP2pkLJtzM-
X-Proofpoint-ORIG-GUID: PT_z1c_g-0PHHa6_-7srnwP2pkLJtzM-
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello James Smart,

The patch 692e5d73a811: "scsi: elx: efct: LIO backend interface
routines" from Jun 1, 2021, leads to the following
Smatch static checker warning:

	drivers/base/power/sysfs.c:833 dpm_sysfs_remove()
	warn: sleeping in atomic context

drivers/base/power/sysfs.c
    829 void dpm_sysfs_remove(struct device *dev)
    830 {
    831         if (device_pm_not_required(dev))
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^
If this is true then the warning is a false positive.

    832                 return;
--> 833         sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_group);

It's the down_read() in kernfs_find_and_get_ns() that sleeps.

    834         dev_pm_qos_constraints_destroy(dev);
    835         rpm_sysfs_remove(dev);
    836         sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
    837         sysfs_remove_group(&dev->kobj, &pm_attr_group);
    838 }

The call tree is:

efct_lio_npiv_drop_nport() <- disables preempt
-> fc_vport_terminate()
   -> device_del()
      -> dpm_sysfs_remove()

drivers/scsi/elx/efct/efct_lio.c
   875  efct_lio_npiv_drop_nport(struct se_wwn *wwn)
   876  {
   877          struct efct_lio_vport *lio_vport =
   878                  container_of(wwn, struct efct_lio_vport, vport_wwn);
   879          struct efct_lio_vport_list_t *vport, *next_vport;
   880          struct efct *efct = lio_vport->efct;
   881          unsigned long flags = 0;
   882  
   883          spin_lock_irqsave(&efct->tgt_efct.efct_lio_lock, flags);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Holding a lock.

   884  
   885          if (lio_vport->fc_vport)
   886                  fc_vport_terminate(lio_vport->fc_vport);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Sleeps on the success path unless device_pm_not_required() is true in
dpm_sysfs_remove().

   887  
   888          list_for_each_entry_safe(vport, next_vport, &efct->tgt_efct.vport_list,
   889                                   list_entry) {
   890                  if (vport->lio_vport == lio_vport) {
   891                          list_del(&vport->list_entry);
   892                          kfree(vport->lio_vport);
   893                          kfree(vport);
   894                          break;
   895                  }
   896          }
   897          spin_unlock_irqrestore(&efct->tgt_efct.efct_lio_lock, flags);
   898  }

regards,
dan carpenter
