Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AAF3BEA0A
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 16:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbhGGOtc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 10:49:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:52948 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232050AbhGGOt2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Jul 2021 10:49:28 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 167EgFTW009029;
        Wed, 7 Jul 2021 14:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=63TobvOKUPUTHPjIgyTZylq/B4LrJxmzwoPzeoR7crE=;
 b=HMvj3S+kouzdp6pvg7isyUyvKOWtBR2T7Vyop4PcUxc2yZyDFGHqseXjC92ivCL98DrY
 m5y4A1tM5+9vt0VKqVBNjAeAAUy7oQ3t2EoSuniZmVWMIIe7mnfn1UseOl4QaUQKT1La
 7RQi/kutP/GWtQCQ8/eQqPpoP3+C7TNcUxN/j1TXHV9NDaI7a0nfH2oEfJgqcq7qLlW0
 Mul5/77bTHbEKUkkjp6JQuDjideA5DoK3nYnaCaRUCs7RW2jI1oHqgK19PHnfuoey00t
 Wcu6ECHIHLHE8oOxZhxagJBrYZvnn9nvmSUt+5Xl/vMSR28/tkhRitlkvKBOAn7WjXFN DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n4yd139g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 14:46:40 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 167EeAZD041524;
        Wed, 7 Jul 2021 14:46:38 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by userp3030.oracle.com with ESMTP id 39jd13ht15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jul 2021 14:46:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dkoZpw/RYg8T7eRcKRhj8SsuwgwZ0Ibp/5CCp+6w2q17IiAth3dVADycvwNpCv+orGT4NpNFhrt9HXUXLDSe1/LCuPqJPQ11SdyZZh9DM01Yasy0r38hyMPNzJ683Fzi0g1N+K6TjSu7Mcc3SIMr7dnAmp4DOIAu3F4RIoacSgpRalNT0x5dX12DD1oe1/jlifV+dN9qKE3P8qmEmqDaXSc0GuEi+QmWWN15z+1n5BAGPYKC+PO7PR15hQaUbQcm2fP+kRDNuFOdut8crIBUxGg6podhsdlqkUccvV2aql7dogwHej1TOW7PMiZXxm9+0VbLuXrFDltKR0/+ID0uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63TobvOKUPUTHPjIgyTZylq/B4LrJxmzwoPzeoR7crE=;
 b=FF5wweQPiU2081bIooxZ4OAtX9GFE84Ql6XxZiKm9Og+XRWsNTJWCfTg8KoVMUCEqVhl0UB7OHtFlHNSr6MXCxtnSn/+tMC9S5TzCKadecXHOarpBYS6PLTXBox48GFHD9ZmQqSpR2Q7tUHj4csB7Aon3l2ECLvypfcB7ShHM5SGLPnSSJ4wmyl2Ncm/kysoGhI7gRg94a6eaucB8ueTEwd/kBEkqFl4A7oJyMxO6vW/2/EtuebEuX/h+CxuXFgTtfSJ9V+5qgXDp5EHoyyuJz7iWhs8xK6V9IAIbclYhmogSQeEU8lQ+Wnfow18e5zXp+Axjx8426LiZk9o6qDVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63TobvOKUPUTHPjIgyTZylq/B4LrJxmzwoPzeoR7crE=;
 b=FRhcw9jBgrZCJZO16lWfdpVlTw+O+P2K0B/DtW+pkq9tMPu0uMfd9qSNxK3COMmCs9ALshvnVJzyjfZRUm4kUZY3xVTpqC/Z5PjXvyhkSwH50ZV8Z9CwuBCmZCZS5LIE3XdOHd0aUbfhLh2TiLnrF2rFuOKeHKCugcjNRsVFGR8=
Authentication-Results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4436.namprd10.prod.outlook.com
 (2603:10b6:303:91::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 14:46:36 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 14:46:36 +0000
Date:   Wed, 7 Jul 2021 17:46:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     cw00.choi@samsung.com
Cc:     linux-pm@vger.kernel.org
Subject: Re: [bug report] PM / devfreq: Remove redundant governor_name from
 struct devfreq
Message-ID: <20210707144618.GZ26672@kadam>
References: <YOW8OfCxLDXe1XdF@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOW8OfCxLDXe1XdF@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 14:46:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 826b869a-08c1-4d78-83eb-08d9415605a2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4436DF3DCAA93D39EBCAE7ED8E1A9@CO1PR10MB4436.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SSCwIvWnFfNMJGXB3GF4DxQDzNlUFfhqbFSktzWbEKaEqlzTdh4xTVWKO9BR/xisrHW6ow4nHvEzWLfFEVdOG0SXhgN1IdAJETkENUxltLgZmeeopHrj2nFwgPOXizs4EvsB2GG78BxdAlKpzacCyMMqydJmm3WczUH3E6n/gXaGrRFKltMpl6jQ4Kd2m8km+LygcbI/xunlSjQCHRoRMB41jQL3v93besiuPZjRt0AfU0OevoJCb/C2HBg79inOA1GeokXVHSBtPszE2VIHegzMTSelGMM/vaqXR/Z+g483jAsEE5YP41mE+ZPP0BBWJLs35qD0TGactAMPNt9eHhn2rB3W5IAl2SGg/sdzqFqHR1nX19RTqpqTJ1B1uEv8gsMQ/gG3SiqSyFBZ3QbsNBaB0e9FN+F1FxBqo0fq/saoqHxpI4sopz96NNjmUczEzogSkosgAUYFAfptxfvHOKPVAdr+R2rtCTImh9vjRKX02tt4W4ye85CzkSymYO6fCFc3AEnmqy+wxs3W6U9Jo4sN8DHQWgFEdANoeEM9w6IGcB83En3TLBkMfY6obPCd1ESJJQfqtQDyGdMHE+Xgt0OmxKo8dpG0bmxQD19QMjjxS1GVDcvs2Jo836HiiyhBAX8WndA1l8SoNHPaUcKOZdjDOayVD5F6uEqKZ2RY0H/hIIrYbcCwaMOyIHaEXn88u53qXO0JLMx+d/bXdHPkdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(558084003)(26005)(33716001)(52116002)(5660300002)(6496006)(8676002)(6916009)(316002)(6666004)(186003)(4326008)(33656002)(38350700002)(956004)(478600001)(38100700002)(44832011)(1076003)(2906002)(8936002)(86362001)(55016002)(9686003)(66556008)(66476007)(9576002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mebyE4GR8iUQO5/zvkgL4IdB6T5AWY+wZWnreuNoUbWYKrmktpIkGrQCs7Vj?=
 =?us-ascii?Q?74A00WGMj9+Y6swBgey+XNPCxwTvi5K5WOkUEpRfjtgAB8rhY0Xebrfx2gNs?=
 =?us-ascii?Q?J5ABFgvC9GxMx4Kkfd2n1oJHk0VZxIdLqluBuu7rCFy0Z2BcrqrWZqzE5FDv?=
 =?us-ascii?Q?G1S9qugeaqJfweMzyNAumeJPss/oSVluu66bQDQC3ai4uHJKBc/zZQlFdlH7?=
 =?us-ascii?Q?Nw09NYwLMmVg4ij4cq57PsttOtv3nAPZ8HFybL2rQrloQ8mpQ1GYb8tZgUwl?=
 =?us-ascii?Q?wP6cRUcYFXcekmZ517ZjzzHK9tcwETp8TdHNRxPvjiz5xKlzTjazMd19xwaL?=
 =?us-ascii?Q?9L4aNOESuvdI8BpgdRlwdrV8JkI/iMtZGO/CGzGRzOdC2tF1cpMqmWe6yKOn?=
 =?us-ascii?Q?i7HyTZMj3nyrU194Rlaw4izfCyATULoyv3pYI6FCobSB6TlvNpux/mc0dOry?=
 =?us-ascii?Q?OiVk0URzUAZUb2oApn+s0rGfYWr1OgloDOmgIzGSlXCnNTO8Mpz4qJyOQCG7?=
 =?us-ascii?Q?OsbFpjF9c6tlQUH3yMJcyD/0oobI312fk/K/O0xeTDSd8cnCQc4G68xCFCiJ?=
 =?us-ascii?Q?gveJd51377rPlglzpWb0DuAfrva0pCMG1shoDGkjI2rR2qus8K50cB6/ylJ3?=
 =?us-ascii?Q?+H+6urInl2girps7RjaxYkaqxEZ0tOB3K7CWcaWv3nkxhZNTAZ+QKq62Rer3?=
 =?us-ascii?Q?v0zlTDPUP16AzTGmyCllBgEoGg5DPkP6zwYiCuoMI8KygY5eUNbE/utT+/Qv?=
 =?us-ascii?Q?cbNr5FtE1NgMTUTwAHSLLgH0sfH+MLsrCeju1FRHvU0XoD09oTq/XGGAoYER?=
 =?us-ascii?Q?+PX5Y7P06Zn8im0o61kmSUF3BUof4pvQB3OFG0HS1I/g9XWYPzRj3pt4hotk?=
 =?us-ascii?Q?bg6/4aZsynTRLPj8H0qEtsjwrCf4n0HifBoY0lm1EJZfRO809xW1s+rRO/Cq?=
 =?us-ascii?Q?gcCsqZC0TAeIrDefDRhqAaJSQx6/oNuzCvMgRKQDcZSTocOumv2N3uooJE4E?=
 =?us-ascii?Q?JYDlJl/DPR/KpMIfKVNUSdv2i/l8+QoQVvy965xmZ9JN2NeXeUK8TlZLrSsW?=
 =?us-ascii?Q?Ux6gcEA3xDWQT4GsA9PVMwNoKZ4X2ZEQr77h4fBT8B8yJR6mOoGXIGXBsMrx?=
 =?us-ascii?Q?eFwktLjNl3UE+85fKHJKaWhlh5Juw2JUoicD5mVHGWo+kjc9odVy0qrT9Z8Y?=
 =?us-ascii?Q?bxu7I2wHj0n5b2z9pqEw06puG5cMQWvppUpdK63eqUydy0RWVa+wj6roIBDU?=
 =?us-ascii?Q?tYeFmvvTjYX0koaHB01XNx1KLE6V59MIa/UPWorpBW7HH+G+SxRjqrvMSx4Q?=
 =?us-ascii?Q?AlUCE0/PHdV9JD4t2/LWUX5A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826b869a-08c1-4d78-83eb-08d9415605a2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 14:46:36.8354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFypAfQt2gOUHViuglXxjQVEJ0PwbSkmowhQxV6LQdfoK5KEOFSiLk7sn6STKlhjC9RTjevcQxAlSfS/J+lieEYV3EDPNxkzt1qyX82kCe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10037 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=909 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107070087
X-Proofpoint-GUID: BQXLm9qAqdIlDCP44J4Z922cbobsCuBw
X-Proofpoint-ORIG-GUID: BQXLm9qAqdIlDCP44J4Z922cbobsCuBw
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Same thing in the remove function as well.

    drivers/devfreq/devfreq.c:1334 devfreq_remove_governor()
    warn: variable dereferenced before check 'devfreq->governor' (see line 1331)

regards,
dan carpenter

