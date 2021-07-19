Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4C3CD1CE
	for <lists+linux-pm@lfdr.de>; Mon, 19 Jul 2021 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhGSJl3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 19 Jul 2021 05:41:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6694 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235172AbhGSJl2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 19 Jul 2021 05:41:28 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16JAKwwm022682;
        Mon, 19 Jul 2021 10:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=kCyuUg1+8W0wkkqgCm1RXRaPR3biZPhuHlGVqHgIvrY=;
 b=TxTP4WvDM68COJR9ip3J7NBvIGduJ56vU/AqYRIqsltFtVoxPSH5Fr4Um9KEpd6IdnLH
 blOOW+YrZLXbPK+BLLup70/N8D8aCxVhUSHSlzsJTPmmGO91QN4JaWv/YOpbOGQAZ73K
 UMnudtmpdCbc72ryQwPCFnnUBClJvoSJZOnxJaaIQFxwo98RuONFAEz77vdbeL2x0igw
 qLHYCf8UPWp0f+yFif/HCL8UIzT0RS2sa1MXvvpOXm7giTbsD4IFWNrdj69hy+peRSc5
 Pu/YfZej9XD3bJm5lko8Aj9C1OB5ICIAvAPb4ooW4rzqlOEHIrST+JNEHg3E0df1ppcd yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=kCyuUg1+8W0wkkqgCm1RXRaPR3biZPhuHlGVqHgIvrY=;
 b=XckoOIZqG/jR7JQlDjmtOcavX5ID6hNSs7oKPZWFjCCzIStyA79sXHG47Ed47EZVP2sq
 5DqLop5c50NNCNy5Us0xtvXWdExYkzzbR6EhzouSd6+5zvsxCBx9kSYGyvxJv2adsq7U
 e8sJ6dW/DjhPIsmc+iYiPkwzwr1raCT0FTJHP4MuctZQcGBGB86D9W44yqVwv6NNHE4S
 5+wb1pNlvX3zl18+AE/RkEp7WsUTcAquwe6llP97l9b1b5+Qh8TQI5lX7miRqK4Ps57d
 NQlkjpOiCI1kYpRO+zZp8JbDpGd0pd0q0z7aachTo2t1QLSqc858vZC9GkvKup/2r8FP gQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39uqrtjntv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 10:22:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16JAF0bH096990;
        Mon, 19 Jul 2021 10:22:05 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by aserp3020.oracle.com with ESMTP id 39uq14fm8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jul 2021 10:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJZBVWdLh5i1CcBI0zCVOiDXCyJdBuF3oefehBhHkRQRJIAM/MWe8Z8T0GoME/cu4L8/TiVwXA1OwmTQk/etwq2kd4JFBaSMiEZiEhys8J83w1ajWCAAk5ZxULj5SE6oRahehH0oWABVS+q7OQsLURBk7HYPtWK/5UJq6L/+YYXPKZvRBVzxcVJFO/PWsrn5T8+k5XL9DBbUHT1kno8BtfO3ZCMpuv9OIm7CDmjDf3xazboHajl02sZtzDonY+d5UsWug0L/cMTEyx+sNP/LbU+9qfkrs/H6NUA7ERTRPG8f+mlMU60BZqJ3UCZGtjRqrFfjnMBDNjX5dgzPQi1SpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCyuUg1+8W0wkkqgCm1RXRaPR3biZPhuHlGVqHgIvrY=;
 b=RMQ2CDJ7PJzCS3kO7x7eFeeztz+it4pmpI6/zu27jyohAm+0bcS+rLDEdGwOpHNIDfDGklzGWEQ9a/cc7Jx6OU9OxuorRR6sffoTIaMHlXBg9T5JMZFjeIaAKQYrWoMog1p+G7fDGTp9yKH6hgMS95qiRoSdHsaCgyekjusDLB/eSinncFSNMhlEAsWF51WdIdggvmdCK1qgGJs0tGlE4bCtns7C4fiHfvFWmviuC5Nph6ntfq24FICEEqbn1pRhyMIaS5GvKBCsNsRka733CS1RLpB0cUFRnLHS2k6avjoDGyKaueCGV7h7h/3+fmzHmGytdYWqurt9bJNPkEkFog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCyuUg1+8W0wkkqgCm1RXRaPR3biZPhuHlGVqHgIvrY=;
 b=s/lmgYZFabC9jJMaqrOMec1pQPwbNRNhmZYpMNPYwR9kU0uGaiA+XLPVRbuh3jcMR6DJJ7GxdbmIa6h0Uq71LgK9vUvlqE4IngvbmUFHh8gpEax7v7bR0v05SCTHuFJM9uvqr9rcuexP7qSlTr3oZMvb+Rpf5xc9x5PeC/PAo3E=
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2256.namprd10.prod.outlook.com
 (2603:10b6:301:31::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Mon, 19 Jul
 2021 10:22:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.033; Mon, 19 Jul 2021
 10:22:01 +0000
Date:   Mon, 19 Jul 2021 13:21:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] power: supply: ab8500: clean up warnings found
 by cppcheck
Message-ID: <20210719102124.GT1931@kadam>
References: <20210719101648.14497-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719101648.14497-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 10:21:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aecefc1-299d-4b9f-467c-08d94a9f0c48
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB22561A9939F5F21BD8A78CD78EE19@MWHPR1001MB2256.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyJ0MqeUMNIHTDvDsWINgjn/cMnqRcVETO5KjHIJggaWo1vbB4oCsKuLeEcQWZw0aOFUzXJxJZFMuTIHAwxqlMH8PPmrQ7iPyafn4sS5nzj63o1uMxdUn1/IFYwE7hB9cU0QvYoS5UMKI1aLSwAgi6iN/woumEaycZ7oMxKsS8F9EFrR3QE2MT4SLP2FdscDUqH634pdDSnH10zunlq0bhiAnOB9unQGOMXaweq6PNRYsca4rivdsfIzcK6qDvoj750TqiKEVEOdjnXN50EU9iC9FZ80TBJNLkUCIoxzfiXsAn1sEvJjZkvvuF+wP8we2+7PCJg055SFY+ndvLiDMTo+57JI6RM4Ep88Gus/zsPZY3+0ISjZvSBR6FjhhO5ZmtnOFS6FgednJKSMyFZ34vYCyxkFE0TPtpuw0JoHMeR+7AVzkT0hKGKlYfkas+rQLo3IKI7eEqWGcIW+sUmYSkMAjJGv16RvcrqeUPCexjRdubRukorUAHs/Og2q0KcEOxyqlpYxRYfz8ZQcFmKpqk6nkyFL3445IJZ90tzN4s6bT5kqM/qSAcTj3b0HPubEtKrsa8jfQ6i8RZ5hZCZyGYXTxZkwrfvTRdkvH0usIPp5uqvuE2JEcVI6NteknnNSxgUiqtCv+c72oR5uJPRhrQ+jR7dVza+3H/kuqjYGNqA/VRas2BQJGHR1iT0YiDNCDtuOx7wN1yM1I/tNvWD3zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(346002)(376002)(136003)(5660300002)(38350700002)(38100700002)(66946007)(86362001)(4326008)(33716001)(4744005)(1076003)(44832011)(33656002)(52116002)(9686003)(66476007)(956004)(6666004)(6496006)(186003)(478600001)(55016002)(83380400001)(9576002)(2906002)(8936002)(26005)(8676002)(6916009)(316002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7xGeiYcyrB0grSlBpswB7UScQto9EogakUwzZRnzHbscefm20Tl2MfG1fywR?=
 =?us-ascii?Q?0pxVZDwR/aOH4yTytJvH5F2Xo7Tzbcqcuefwh7/NKmDrndlacBUTAyitgRO2?=
 =?us-ascii?Q?w22hhmpTdhIuzqJnLUD0mIFki8qhUQ//zojpXdFoP6wJIWxdiVoiqFlo7eAB?=
 =?us-ascii?Q?kL2Znto9evTKGXvtceCZwtzGZDzdSD6hBYSW6mAfPVloERiBkXBaPW6n4qyJ?=
 =?us-ascii?Q?DnGMd7o/lx0T4Lksrum5jglFjw5VXUTBGC33LDlu7kpqb/4GBxmXUYZHd29i?=
 =?us-ascii?Q?PqKZlbP2zTeyNwSuc2oYQ79fXeUfcN7z5ZM8w5cPq+ib6UZATaVTfihrYq4M?=
 =?us-ascii?Q?veyiPPjgWBRjDVfk79cys4rezP5dtrL//gWMH9gRuG5/covBysl/jfgDObgn?=
 =?us-ascii?Q?2i1mGOO6tyc2QeDuK6vOffv6YE2hnr8Q0okpNXAqqp0AMM9gkFiw/lwHEYEf?=
 =?us-ascii?Q?q98k4BsTVwSxzjDYHwXQuoMBuDfxj/8zc0cN+sV8boDf1uAfDvA7KzE6WVyV?=
 =?us-ascii?Q?88NbIqekBPJLXr2swNA0gTHX+4qkckc0+1YWVr/15xRrnpPRqvHmk30WOXA0?=
 =?us-ascii?Q?lxk0ZDBg61Yuw65AJjJbOWhYpKT0SD4SHce15tApnKuvTLqKz7l8zQpVBbOD?=
 =?us-ascii?Q?0HucwGREOGkWnyk3PtQDg+4H3W23w0s1kUXeP+fDCGIJHhYkFWJtn9k8XEko?=
 =?us-ascii?Q?WME3pL/Sqoks7Zp2sozWeE9UTR7flKAIiU88Jhnfe8iSmOT7lwT8s0U1vxrz?=
 =?us-ascii?Q?eaPrSLuPV7Qkr+Q1veYrfGTBY/wLB29rif03UtyFdJ4pZNR7PVL1WwDrO9rH?=
 =?us-ascii?Q?+lptaFcxedEhUeRkNIF7R1Y0CRWHSinbsSra25sMs+E7C0hn3PTbRLF1rJZ7?=
 =?us-ascii?Q?lc+yNdgdsHLbteLPrNYOh2CID81p5RIJFYxdpl0u9FbxWQG2KJ09k9iBHHoN?=
 =?us-ascii?Q?WzdqZAxcVnI7YE4mPFGQA8rc0W+zpT4pyW5cdoyHvu1UPbyisHOCX4+WkGVj?=
 =?us-ascii?Q?MdGidoetGxbtnxqqespZkkS+B+irPT7kX2GPsCcjmdIg03AW2GfoOZUkCMx5?=
 =?us-ascii?Q?qtDy0e9rB/cEi5kRDL3wEY00HiDWLGT4UrI6wEERlnWX+EKnbp42LJiS279S?=
 =?us-ascii?Q?4jY0oELkY2vlzujh0zEZKanLqXFtWVoQfjAyRSvh0TdeHQcn08nz4jjuUeMv?=
 =?us-ascii?Q?1TGUMgI6bl+MPXkw4JO5bd0+9q5eZFfSRDUKx1TavyKR8Zj3dteVB5x6PgzT?=
 =?us-ascii?Q?vPQ+BvTPtxwYkJUFwFsvAGpMY63Y9Z0WZAOMcCNSazFVNd3zsCJ3CLxUm95U?=
 =?us-ascii?Q?5dbxIHwYgOY0wVFz5LCp5L5/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aecefc1-299d-4b9f-467c-08d94a9f0c48
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 10:22:01.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrWYx/Tf1LrCBk0p+bBokmd1HBD01OMS3cDX2Rc+JaokbZZtO1wH91IfrmtZMm02T4XuJRU9XuG+AIYd6EB8SyWYuquiXCaZWMqclvPukS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2256
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10049 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107190058
X-Proofpoint-ORIG-GUID: 7T4gX8Jmx6hmG2QmElBEYJjgRtbU-Ho4
X-Proofpoint-GUID: 7T4gX8Jmx6hmG2QmElBEYJjgRtbU-Ho4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 19, 2021 at 11:16:48AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Clean up a handful of checkpatch warnings:

The subject says cppcheck but it's actually checkpatch.

>  - static const char * array should probably be static const char * const
>  - function arguments should have identifier names
>  - else should follow close brace '}'
>  - suspect code indent for conditional statements
>  - unnecessary parentheses in an if condition
>  - avoid multiple line dereference
>  - prefer using '"%s...", __func__' to using 'ab8500_chargalg_wd_work'

This printk should just be deleted.  Use ftrace instea.

>  - prefer 'long' over 'long int' as the int is unnecessary
> 

regards,
dan carpenter

