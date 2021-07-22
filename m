Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C393D1C8F
	for <lists+linux-pm@lfdr.de>; Thu, 22 Jul 2021 05:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhGVDTL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 21 Jul 2021 23:19:11 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:13138 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230438AbhGVDTK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jul 2021 23:19:10 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16M3pLIu004763;
        Thu, 22 Jul 2021 03:59:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=0SLU7ucV7dhNxjJdhvrw7XDr45DyJQQKVqpcWkStXGM=;
 b=0qdpyHP2XexAy0ofbq3lTxKYJTT8ThT+4QESLm/jFnr41GWa4Q/KB4Km933pugnU03ES
 tgA2xW/L+LutN2qK5qucdk1umERJsn/XeEiGWWBiL224JKYwdlO8N2Sn0N9LHOY73k//
 xS1YVDCo7MyxdWCwdhRxj9nqaC9vBbDpkyLFMvjGtIZVbRkoS88F4MB4xc+fZl7So3xk
 9gqzq3lDdFRmelvhs9El3ttTez0WT9Imv0wIfWwVGX7trqqr30EiT36SNBhC90YaHbZG
 hjGyucuuPTClUrbfgMJN2O76Vu9E1yCMY7P/0iJu+Y0N8uSh6cAZGMEg4bitwxKz1VXc 2g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=0SLU7ucV7dhNxjJdhvrw7XDr45DyJQQKVqpcWkStXGM=;
 b=K6HHe/kPFJYCx2YWhNk8eRXMg51yj6L3UUuJ6Iq5/I4K3WWT4HYOkYAVp7q1ukIUUsET
 l76MwZCJR0gaYtN/Rg51aYgekxJ/a1BABCwERlDS9EaE5JBqDNzkruGha61cNL1/ZuVF
 FD/jFGlCh//ltI7gX8Vci9FRBmAow0yJPD2/NDqP/isnZtd9oVpPlr3xviO0Q23KsXDJ
 E/Jbpn3P+O37hEdu0veeC1JFXjWEFQvx50OBx3bPByaHwJYWwagHFsnci9O+te2fbqTD
 c1ZbciczxBmU9vv/E9u+PckBjJJnONN56wbHY34fdONJLb4FJ9LyrwhLuPvQNCEWzyQP EQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39xc6btj23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 03:59:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16M3tNat182261;
        Thu, 22 Jul 2021 03:59:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 39wunn753m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jul 2021 03:59:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aiLhaN99jdPYG+Svfjnv5IcuOVWqlZ5/Xwa/SwzJ+96LzANtqnTKmi3sbFKoNkSppztmll7A/jn9MvmLHGEgZyFqQ2DKtDlubwsFC2akYSVibpMjycOKSGl4wouERqw2JMe9nt3VfSjqgEdUxAGS0a8fKQTeScPy2Acpadbo5LG+MCKn0JcpLt5u0cGsMB2D22aQRSLe7+C6xb7B5dg9pGjUKT9cNSqfFrl5KR0X3Aswf7VKV+MM01Ae2kE29hnLT6/67fii5MMiaJxquLkoVYiQIgJ8xHjbM0ZdtoldijkKZviulgK+PWeIrahHcfCoRDNR396EV4WG6t6Pjp2vZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SLU7ucV7dhNxjJdhvrw7XDr45DyJQQKVqpcWkStXGM=;
 b=CdFUl30SxkmHyWf3bMWgtg1enGhV5nJXQjseiPJB2BByv9/+uZovA4CbXvzQawwCjpJeerbQ/FOu/r0RPzWa3Mkfbh4I9ppbKnwagIUcam0dPLuPCnwbHXXTUv+vkdE02cSLwD0VfpAMmXmHVUcdNA5u3AKW3uVRaZeHCrb7ekbWbwhZSLSN/2cYgz4g6k5orJiUrQYYEdcHxltfAJAyG3UQESF6ZbFLFVtMEby4iVz4kTdoHtmq6h10eg1nu7ZmXq1D4wuTnwxC/g48botdBeUm5asFy+ADN7Ei2Ct1Pb44hnXlwZnX4Y2liKmyJVLNZFRjhquT/WqQi6winB8QJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SLU7ucV7dhNxjJdhvrw7XDr45DyJQQKVqpcWkStXGM=;
 b=XZqWbFu8Lvi9ZVu3WIL9DuMcKSvF/HAZNqvCt5Y6OSiX2wT2O68nU1ZRYCPo0hgqIsoP2zFEt5jNoofK9buyuuu1tIeV5+7Vdy8FVH0oFIHDyTe4ClMC8gO84EwpDSbcAnkBMF9NGgRppFZELiD6jFlyDTMgkZK7KYhb9UD38lc=
Authentication-Results: puri.sm; dkim=none (message not signed)
 header.d=none;puri.sm; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 22 Jul
 2021 03:59:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1%8]) with mapi id 15.20.4331.034; Thu, 22 Jul 2021
 03:59:06 +0000
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     bvanassche@acm.org, hch@infradead.org, jejb@linux.ibm.com,
        kernel@puri.sm, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, stern@rowland.harvard.edu
Subject: Re: [PATCH v6 0/3] fix runtime PM for SD card readers
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czrbxapj.fsf@ca-mkp.ca.oracle.com>
References: <20210704075403.147114-1-martin.kepplinger@puri.sm>
Date:   Wed, 21 Jul 2021 23:59:02 -0400
In-Reply-To: <20210704075403.147114-1-martin.kepplinger@puri.sm> (Martin
        Kepplinger's message of "Sun, 4 Jul 2021 09:54:00 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0081.namprd05.prod.outlook.com
 (2603:10b6:803:22::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SN4PR0501CA0081.namprd05.prod.outlook.com (2603:10b6:803:22::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Thu, 22 Jul 2021 03:59:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccb2cbb2-4f5f-4ab0-572c-08d94cc50d32
X-MS-TrafficTypeDiagnostic: PH0PR10MB4454:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB445413B5B2F2BFF1283E82DB8EE49@PH0PR10MB4454.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWQ9S322CXI/jhNjtUqlDgj1QrxKLV8yLSU7zr54xYKJyXNcCk1FeH1DLgQGT+CsroO7RmpJLIia4/iZFZUlBjWPjeRVFS+YhYXPLo3Y5zoG3a7Kh2ijF+8xtsKGNzcJaX/IcRCj3u2tnYkmmeNQgOxlByzXZd4eW4a5nQARCB+qC33Ituilm3V4agmUwx3o1NNgEqDnz3U/vNC0+XShMbxDkVJEF0AZuE6VowHWV1EmxezK841o3SQBhY3Ctr5T6JssfXlYy6nZYgOLDvcy16uyOPDE7F9IXL9HKZq2GfYHwGkMmo2Px8nB/HLH0jKWYv2dvCvrZ0AAr521pLzyNkx9FBy0TNYMeC7ArE9ppvv/yfrU2lkFqt/3vmsE1361IwLRs+1kXd49gBj4tnkjX3pO9/2Abeho4LvK3BsPP2vhPIe1AKi/zthkDd7Z0d3CXRYKWNYbA+IEh7ZH5jUQpi5iztbohpLBWiO4YqUzfUaDh6vp6AffhDzEIlYrWHg5kym8ZYogNAq+2PDYC/Wn4EKVAeFfUmrvP447GQUZ6cPImp+P3wGyt5MPVDolUJKqMTrYRdbu+eZzUMWnebHwnVvGH+No/9jWzjAwiYMRhEnUNA6Ltn1jnVOl6DxXz9rVk2aW0GE/ypb6c41MBKSRSNaHnEYxHqlbV1O9y1bX5430fogYR6XS2HeyxWg4nn4DzaFFkEw1UbrW7mu6Ygjztg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(7696005)(8676002)(5660300002)(66476007)(8936002)(36916002)(52116002)(186003)(508600001)(4326008)(66556008)(6666004)(66946007)(956004)(26005)(2906002)(38100700002)(86362001)(6916009)(55016002)(4744005)(38350700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1HXm0/T5snTMLBozEfvv5d9OTRZgcoRrJqSXWg3Ks1j1uSsSlbHxnnRs9ol+?=
 =?us-ascii?Q?YkUdJU6czkp2dpbr/ABLQsA3qZ0RcWukXFO9e5Tv+/Dt0yys4VZHNwNWOjWT?=
 =?us-ascii?Q?35LpoX/xSZf5QyRyf6UrvXAU6T22dtMrpvJ9TZaNH/+artYmQI0Zm46jeWXJ?=
 =?us-ascii?Q?nq69q8HgbPgrXbPNGvdCHvvJIgdbhFml0t1hYpmwVfxOPa29WGmjNjqAtGdd?=
 =?us-ascii?Q?BdjpXnUCCdHZ9hl8pSQpSYlgN2A2m17hyricAcGpbvziIMxka6aLda0lQEeO?=
 =?us-ascii?Q?x0P7LoeNvlwiRK7ljXAmF9WxQIv6acFJ68+I1JgrrJ4+ob5ZDNDTGaal5HaA?=
 =?us-ascii?Q?o9n6rzu20tMO1fyH2MCtxEzhqNSNu7L2fLOw09ZNTSQN1OR0MC6TbZGOQBAY?=
 =?us-ascii?Q?+3l3RC05UtHBJYyPg+yBJLok0cQ2fHu53dhnbK4nLK7rzOmCfinrR51atK1j?=
 =?us-ascii?Q?onh+2Q9ntUGLiBjx2bnqB7dWrcXjMMsTu8h5ddNguRTJ7WLdiBTSx6xFFsUS?=
 =?us-ascii?Q?YgcZ90Q1X430L274HFeW1zQxlgoGyAI+X3LqQmztakE3UtGqxuEIc0dtSEnP?=
 =?us-ascii?Q?zPqwkt9l4p0CrpbxzXeDwc0HLOL6Qj8atJZsIi7Es2gOPvMR6j7RI5OoPZpX?=
 =?us-ascii?Q?de3ose/JBz3RPZqFYDnT2NVfKBciY+n8L65+T7FGQXSYzWQADnYDPDOWXVGM?=
 =?us-ascii?Q?SowbHCBKCpZ3uX/5RVD7rUmZ+3WhufiwIyPff8/fAL9fVO8XeRWLGEj1xsJp?=
 =?us-ascii?Q?YlgR5gylrzJ0yjwCGVmDRrKHSfRGN8lFa+e/jBsylBZTZkN/tozqbf9bR+Ls?=
 =?us-ascii?Q?Vxjv1sfrBMHkyif21tBZoExOHAGfEJRHCAm0/9IMGese4tBug4ilCHrhA+0l?=
 =?us-ascii?Q?FuX/e8wNExyDVWPbHA9l7gxcyy7owtOo5X396MBYRbFbi6FQrtfL+X5Pxjz1?=
 =?us-ascii?Q?hrJTEQ3DezxRhF9SRwHzDhRW5ZusXD/aYFJiK5FbnP6AQTjU+Zt0o+FsMiya?=
 =?us-ascii?Q?7hU/3FOFt5abp9Zf/VmbwCTlVKjLHOmFLsAyRtgUvxxGQOOxCioZU1WUulTP?=
 =?us-ascii?Q?Hp7gMXHEULEODTx1dIxz6Fc1bklunuUlMaHM5PQxFhmeh4bcpfxdme2KDwJd?=
 =?us-ascii?Q?CHLvVlqm7UGxcpZOa3nL1rJm035+gYSuIc/CoNa4h4ek3vUglwPGluWOljhX?=
 =?us-ascii?Q?ZFXjKPLTEIVv606b7imhXuezbrTEj42mWrEERf+H3cbWtm1RrGzLOVmZ5P5T?=
 =?us-ascii?Q?Ig+f/AtVWWiWUNhrUD9YBXwm0VgH8sH4Mrqo4Y3R3bl9xDqA0hODbmIAKZgk?=
 =?us-ascii?Q?ryQH+UTw/DGh+hSNJxpHjx4v?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb2cbb2-4f5f-4ab0-572c-08d94cc50d32
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 03:59:06.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BI80WNtM6uJrawYxPrSLTDbZw5lbNui+nVx4sR9R6cGlnQrgGxfoMhN5/Rupt10XrAQBDU6VU5n23T4YSbaQ5ckQ/ytg+jGohnbNA/SnOwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10052 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107220020
X-Proofpoint-GUID: pf64l-3G5lHXcJo2HMPkrze_SCRzBB9a
X-Proofpoint-ORIG-GUID: pf64l-3G5lHXcJo2HMPkrze_SCRzBB9a
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Martin,

> (According to Alan Stern, "as far as I know, all") SD card readers
> send MEDIA_CHANGED unit attention notification on (runtime) resume. We
> cannot use runtime PM with these devices as I/O always fails in that
> case.

Made a few changes (added "ignore" to clarify what the flag does and
twiddled how the workaround is triggered in sd.c). Applied to
5.15/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
