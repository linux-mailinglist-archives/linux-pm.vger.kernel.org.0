Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9204CDFCF
	for <lists+linux-pm@lfdr.de>; Fri,  4 Mar 2022 22:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiCDVgV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Mar 2022 16:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiCDVgU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Mar 2022 16:36:20 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4915F4FD
        for <linux-pm@vger.kernel.org>; Fri,  4 Mar 2022 13:35:31 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 224K4TWm003471;
        Fri, 4 Mar 2022 21:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gN1JJihx3gBGFq4+moiVD+lNNFPR/5SQZrGoak4zawc=;
 b=rtAmGGb5Dm/G9Ht60OecZESmG5KPD/iHMe28d29Awjd2AB9xYK/9YBWnyI4gxKZ18Y9t
 d3w3sa79klJMuYTL4nsDG7vIgq2NJIZFAqHr31sbaXYP1zz9ngrHswvO0RK3LlartNtt
 OFi50DWFp3wO3GtOWRL2dFaaeZyN0lW28bqSBFfcDpDm20l6kgv1gOO79kZbCQpIvvdU
 px72t/wmbPe05poBnN+wYPh5puBzEeWN3yY0J9KOxP9ZssRd4CBphkxju7nxtUQKcoEu
 yOI9TyykUNSAhpeKcsWUcIQ7UhhR4Gu+FA+uEyBqYW11oq5KwCowOaS8EyNvd8wf2UHa aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hrtxrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 21:35:24 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 224LHCRp064470;
        Fri, 4 Mar 2022 21:35:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by aserp3020.oracle.com with ESMTP id 3ek4j96mge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 21:35:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByIgyWcC20z7MIyuhFmwzupI+wHm1/+cUCVuR0BX2pQWwjZ0YoSolRAXXRMroEckJzwFcwdxRk2HGKTETwqTLgYqeO2jxSjfwz2nxyMVYbpVaWPPRlwO7yK9RPxmFAp1Ds6KUKGhkam+bAfsFAXFrJMS1xflYBblqOy9FbYjNKpGAV21n42cz3N3XgaYnCSOdVSyON/dI5jtzt6BPgWE4dIbS03FPS3FFJumUmf90+z4YV0Z3TAm2zOLpB9nPanf7zonWgCFmDAwO7Wa9LEJS64VZ7TCxW7Ga+MlfQXTIRtKNeKQsAEVdBszycRAER0yw6auSxJPzVeAXfDESH7U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN1JJihx3gBGFq4+moiVD+lNNFPR/5SQZrGoak4zawc=;
 b=kFnk1N+LxpgxnJW25x1ckl9Kr98tKKSvgdkoZGIWTcKjK/lfR1gAlsmy59Mngzq4d+pCLz8oWGgclmOfDuNh7BQjWCmZKE1UK483ciVpgySU1UNkA91qM+2EOiH0tokFFCmztLflkJeCD7CbT8zUvyDEvMktlb/hHkkAyj7LAclLFm31YNmrvqyDGE+senu+EiMPfSLzJw/lko5OyhLqoj8NL3HroxJFHDPvvCv7GMHo6T80sO/0+Xath1i0nNpZuT5i8RPJ8nsb4kD8sLmjD35o22C6+RKa4jpv2Q7bZyWY5QzrIZ2KjfctAhs6XkBTx0vOmsW4gKurGdK5K89LxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN1JJihx3gBGFq4+moiVD+lNNFPR/5SQZrGoak4zawc=;
 b=MoJ3dOH19jjgbo/6mD23ux26mh8aYehB7F0Z9+CCLnJHetpDU0Z5yI6DiuNjLi+lFSEI6PocIkWkYuoRA9FWyF7+/jSfuCJRr+ZqeRfUVJD9J8U8/VLn30egZNey0uL1zoGuJ4M/vLcflC2sgL/m5T7+VxwVfVTiRBcx6oncmwo=
Received: from SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 21:35:21 +0000
Received: from SJ0PR10MB4461.namprd10.prod.outlook.com
 ([fe80::513f:7377:a42a:834a]) by SJ0PR10MB4461.namprd10.prod.outlook.com
 ([fe80::513f:7377:a42a:834a%5]) with mapi id 15.20.5038.017; Fri, 4 Mar 2022
 21:35:21 +0000
Subject: Re: [PATCH] tools/power/turbostat: Remove Package C6 Retention on Ice
 Lake Server
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Artem Bityutskiy <dedekind1@gmail.com>,
        Yu Chen <yu.c.chen@intel.com>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
References: <20210504145234.4103405-1-artem.bityutskiy@linux.intel.com>
From:   Kin Cho <kin.cho@oracle.com>
Message-ID: <01dd04dd-a2ad-6ee2-4a8f-f801908e4299@oracle.com>
Date:   Fri, 4 Mar 2022 13:35:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210504145234.4103405-1-artem.bityutskiy@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: DM6PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:5:334::21) To SJ0PR10MB4461.namprd10.prod.outlook.com
 (2603:10b6:a03:2d8::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f69e82-8fcc-46f7-ac6d-08d9fe26e273
X-MS-TrafficTypeDiagnostic: PH0PR10MB4647:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB464707DD6BF3E6B359F669A085059@PH0PR10MB4647.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aHmM4GKtha7FL07Cmo4yMiq+8hkCKkJ+wc60qeRDag2B5AtFGK6ydVxWkK7XIge+i37e5E8bM9jD8mu0Ycwbrhh+07IylJFeqwXJxdCN1brVgI26oUCr3zzAXfOnp26trbA96+ka+8E81b+Ws+DVd+V8jDpl8ObxEHwX0fN14s4g/6B4Wrt20fE1Ztw+1w9/P3MbIqDrTeYQYfq69aN+U9lyWZT0LlAYdX/m8AvKdSxShzzOt1q/NCg9jynhyM1y4yUpzW0pES6u4nRrduz6gd9EBH2bTOFHOonrgxKhMIwX/YYkicxJ3S88pzraLJQ4qmMsyxnw91Cq8BQ0+YNiTgQeRN7/Bcj4wLqNGI84Fu1iBa5PSXxDkWZu8uwC0ndmKZZHjmDHzbjF5vUj06LrwnKxDUgGwzrXI1YYOos3ixVGbC5T7SV4dryRY7XHfGxGG5VTmxNSCCoWEIMnI11e8Qzkf6FNKqVoDU8uXzuvnfkqbLfjyzfKHVYEqL/nGADVVWVkn8GH2TmtHZ+U7TZIYbVAQm/Y4zA07CXg32/OOHS9okkq1tvUVIOQbUqd02xo8X5Mwd8GNtGjL2buSvpj03brV5ciTYX4/qC0F9xF1DThS00cSRflOkDXKvFSfJIj1L19FMOHyHShthVZIjk5sIsbInNavvBEWAhXJWIUEolfHzbtRMLiuNkV5Q/S6CRrEtYRiCAvNG3yT+gm+6OG2VtNifVDJchJJfyXXvRJqVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4461.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(5660300002)(2906002)(44832011)(66946007)(38100700002)(6512007)(508600001)(2616005)(6666004)(66556008)(66476007)(8676002)(86362001)(186003)(83380400001)(110136005)(53546011)(4326008)(31686004)(54906003)(31696002)(6506007)(36756003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHptM3NQaGdkU0gxT2xpYUhpdER3VHpnSk8rTGN4dW5Xb2VibEhuclpnSjFr?=
 =?utf-8?B?ekE1MjV3THhKSWhBQURFUjUxSGpIcTRhUWhwSlo1bnN1MkRYNW4zVWl4TjFl?=
 =?utf-8?B?QkVQUDdzT0RDZzVxZTVkUU1rWjRzODgvMVR1WkxZbkUvS0Y0UTA5T1hKMUNY?=
 =?utf-8?B?RDhNVUN3ZWRBZFJFVlZsQzEvMDdkdXdkQlFhaHRuNWN1TmRIRGROaWx1OGNV?=
 =?utf-8?B?aDUrM25ZejRHWTRZOVFoNjZ6QUdtdW1PaDFnRmM4Z05ETHBNRDVkQzhjSnBI?=
 =?utf-8?B?WDRMMGZYbU5oRGQwalI1RlcwU3hDZFNUNFhibmxKY2t3SWFPUWx0U1RTemox?=
 =?utf-8?B?dkxycVMvNnhSRjdyTTMwUzk4SmQzQkNUdGwzMHpSUHFqaVBJVDJmV0tKcE5J?=
 =?utf-8?B?U0VwYSt2UzllQWtpcDJTeHUvNlVBcTkrcGNxTFdiUXluZ3pXNWxKbjFiRk5h?=
 =?utf-8?B?d3RFb2YwT0kwZXA5enFnU0xqL040aS82ejMwOEdZUTNFU0pmbWFDa091Tndj?=
 =?utf-8?B?R01jMjFYUG9WanFUc1lHYVA0NzVpaHBMUDNla0tkNVNkVHBIbnMvTTgyN2Vy?=
 =?utf-8?B?ZElHQ0hwdFVIOW1uTHQ1bGdmWUxSdGF2b1IzdlkxeVBCR3JmU0k1RGg4dzA2?=
 =?utf-8?B?RittSWtQTkQ1eVBvNFFxd2lwTWJmSW5sazRPRkhOZHl2dnF4d1dnZDVRZUFX?=
 =?utf-8?B?SjNEUlhXc2pTR1FTMXB1R3lsOFlocjNOMGZtWnhRVGNVbUZtV0NRNGlKbVRh?=
 =?utf-8?B?M2Nib2N4MS8rRWk1ZEJULytiVlZpVGRtenNvZ0xNMkdTQXRXV1FWa0xoL2Jw?=
 =?utf-8?B?dHpST2w3aTd3T0IvMnNNRXcxYm9Eb3cvVzYvWEVZdE8xekNEaGtYQ0V2WllY?=
 =?utf-8?B?d3NLd2JSeGl5S2Vaa1laVjdrV2FEZjdaWXN6SjNZa1hjdlo2VEZLMDNJNVVT?=
 =?utf-8?B?MmpJM2wxS3p2dWZPcGhPcENoV0RjcGU1Q2xqb2ZVZmVxK0RzK1VBNW4xOS9y?=
 =?utf-8?B?WFJyUFA3eElwUjRqdHVvdXl5Yy9pQ2N2RmlXRDNTZlNoTnQwYUk3R3Y5R28v?=
 =?utf-8?B?anBhV2J1TmMzalJZeVAvUVV0THlCRVRPU2NEVFJhUE93RWJJT1BqQlNmNDdx?=
 =?utf-8?B?ZFc1azNJbUplNWg0YzVzVWZNYnErOXNGOXpJc250c0JmM1VDaGRseVJkTkJu?=
 =?utf-8?B?ZHVBNWlrWmlvcHF0VEZZS2IrSTd4MmhEUFRBc2F3bDBzVkVLdVVmZ0ZoTmVH?=
 =?utf-8?B?OG5wb1kzdEpzdU9SRXpRY1A4VnN1M3NGWWpvTmNrakplYzY1aWRGMXplMjg3?=
 =?utf-8?B?QjQ1RWNDcVFzdUw1eFVJTTE1TlN1ZzFOSnJpS3k5ZTFMU3pWSjBrV2crZTlh?=
 =?utf-8?B?TDNIQVFCbjFCWDdiYzQ4RGNFT0tnOW5mcXRUQVgrTTJjVkQyaXQ3c0laZkhn?=
 =?utf-8?B?NDRZdXlFaTZ5aFNOeWV5a2dDUEJ5VGZjYVlKMDFUdWhFejRFbmZkNm00S2tR?=
 =?utf-8?B?SndORkpFb1hrWU40WnhhQndXV1RLNDA5S2F2N2lBbnAwS3ZUUTdlOEkwNTkx?=
 =?utf-8?B?UHZhemEvWjJrK1hlZlY4c2s3SlZ6b0VOYnp1OWdtRlR0c0FsZHZJblBJSUZV?=
 =?utf-8?B?Y01GbFptMVZxeWI0Y2RZbzNkUEpja0JTeDFMV25mSmd1cHZucW1UT2ZMRmNO?=
 =?utf-8?B?Y2UrWk14T1A3RDNNU1VXL3NWeU5uSGUyYUYwdW1RVnRPUFlqZzRPdWZXdyt6?=
 =?utf-8?B?dUt1SE5jSS9XT2VoUUllTTRlVHpvL0l2bEZTcWNPUzFQNXpRRUdJUERIbW5v?=
 =?utf-8?B?MUhMaUc2N1BOc3h0cllQZUE3ZGhseHR6OElRTlAwWEcraGYvWmVodXNlL0dG?=
 =?utf-8?B?RWlwcGgwQjc2bkxhMDRQeU96bmVPZDdTTXQvSkROSG1UN0FycjBPTVd5c1Ry?=
 =?utf-8?B?Ym1FM0pvZm1uQVNGWHFaUXIwQXlNakZUWGZFWmxNV3Q1TS9ieGw1eWJRR0ZH?=
 =?utf-8?B?dkZoYzJzcmNBZDFWd0tHRWRoL1JVRnBqMWpRQTFUWElPTEgrMHhMZGpVR2Z3?=
 =?utf-8?B?SCtQTG1laXFHRGpmY05Pb3ZkbmFPS3d0aTVsL1J5bmorbm1obXUzenJMZk5I?=
 =?utf-8?B?RjdvZDVGaVZYMThVcG4wMnZvUTM2Ni9xWEZJUTdFcTR2NThmdTBoQTN6ODRV?=
 =?utf-8?Q?8BsefqvsmTh9EP/wPVTjJe6Nl8WNKXJpA8nsyPNWgFhO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f69e82-8fcc-46f7-ac6d-08d9fe26e273
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4461.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 21:35:21.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/Aklx3zMf5unKAXZP8D0MfuRflK6P9FQebIJPT2H1dcF5OLTf2Ouf+s5+6bgjLE6it3tbu4vKJS6kRZ2ElDaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10276 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203040105
X-Proofpoint-GUID: 0vXY2ZvZnQLEq2djwCgnAUr0Uwom1fKq
X-Proofpoint-ORIG-GUID: 0vXY2ZvZnQLEq2djwCgnAUr0Uwom1fKq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

This patch (25368d7cefcd87a94ccabcc6f9f31796607bbe4e) has affected 
Sapphire Rapids support.
Specifically Pkg%pc2 and Pkg%pc6 are now missing on Sapphire Rapids 
(with package C6 retention).
See below for a diff of turbostat --list output with and without 25368d7.

-kin

--- turbostat-0304_115100-v5.12-10-g25368d7cefcd    2022-03-04 
11:51:00.184727582 -0800
+++ turbostat-0304_124741-v5.12-10-g25368d7cefcd--25368d7 2022-03-04 
12:47:41.543801798 -0800
@@ -1,2 +1,2 @@
  turbostat version 21.03.12 - Len Brown <lenb@kernel.org>
-usec,Time_Of_Day_Seconds,Package,Core,CPU,APIC,X2APIC,Avg_MHz,Busy%,Bzy_MHz,TSC_MHz,IPC,IRQ,SMI,POLL,C1ACPI,C2ACPI,POLL%,C1ACPI%,C2ACPI%,CPU%c1,CPU%c6,CoreTmp,PkgTmp,PkgWatt,RAMWatt,PKG_%,RAM_%
+usec,Time_Of_Day_Seconds,Package,Core,CPU,APIC,X2APIC,Avg_MHz,Busy%,Bzy_MHz,TSC_MHz,IPC,IRQ,SMI,POLL,C1ACPI,C2ACPI,POLL%,C1ACPI%,C2ACPI%,CPU%c1,CPU%c6,CoreTmp,PkgTmp,Pkg%pc2,Pkg%pc6,PkgWatt,RAMWatt,PKG_%,RAM_%


On 5/4/21 7:52 AM, Artem Bityutskiy wrote:
> From: Chen Yu <yu.c.chen@intel.com>
>
> Currently the turbostat treats ICX the same way as SKX and shares the
> code among them. But one difference is that ICX does not support Package
> C6 Retention, unlike SKX and CLX.
>
> So this patch:
>
> 1. Splitting SKX and ICX in turbostat.
> 2. Removing Package C6 Rentention for ICX.
>
> And after this split, it would be easier to cutomize Ice Lake Server
> in turbostat in the future.
>
> Suggested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> Reviewed-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>   tools/power/x86/turbostat/turbostat.c | 36 ++++++++++++++++++++++-----
>   1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index ace100dd5a83..81afaff81f43 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2259,7 +2259,7 @@ int amt_pkg_cstate_limits[16] = {PCLUNL, PCL__1, PCL__2, PCLRSV, PCLRSV, PCLRSV,
>   int phi_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
>   int glm_pkg_cstate_limits[16] = {PCLUNL, PCL__1, PCL__3, PCL__6, PCL__7, PCL_7S, PCL__8, PCL__9, PCL_10, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
>   int skx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL_6N, PCL_6R, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
> -
> +int icx_pkg_cstate_limits[16] = {PCL__0, PCL__2, PCL__6, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLUNL, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV, PCLRSV};
>   
>   static void
>   calculate_tsc_tweak()
> @@ -2374,6 +2374,7 @@ int has_turbo_ratio_group_limits(int family, int model)
>   	switch (model) {
>   	case INTEL_FAM6_ATOM_GOLDMONT:
>   	case INTEL_FAM6_SKYLAKE_X:
> +	case INTEL_FAM6_ICELAKE_X:
>   	case INTEL_FAM6_ATOM_GOLDMONT_D:
>   	case INTEL_FAM6_ATOM_TREMONT_D:
>   		return 1;
> @@ -3613,6 +3614,10 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
>   		pkg_cstate_limits = skx_pkg_cstate_limits;
>   		has_misc_feature_control = 1;
>   		break;
> +	case INTEL_FAM6_ICELAKE_X:	/* ICX */
> +		pkg_cstate_limits = icx_pkg_cstate_limits;
> +		has_misc_feature_control = 1;
> +		break;
>   	case INTEL_FAM6_ATOM_SILVERMONT:	/* BYT */
>   		no_MSR_MISC_PWR_MGMT = 1;
>   	case INTEL_FAM6_ATOM_SILVERMONT_D:	/* AVN */
> @@ -3701,6 +3706,20 @@ int is_skx(unsigned int family, unsigned int model)
>   	}
>   	return 0;
>   }
> +
> +int is_icx(unsigned int family, unsigned int model)
> +{
> +
> +	if (!genuine_intel)
> +		return 0;
> +
> +	switch (model) {
> +	case INTEL_FAM6_ICELAKE_X:
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>   int is_ehl(unsigned int family, unsigned int model)
>   {
>   	if (!genuine_intel)
> @@ -3803,6 +3822,7 @@ int has_glm_turbo_ratio_limit(unsigned int family, unsigned int model)
>   	switch (model) {
>   	case INTEL_FAM6_ATOM_GOLDMONT:
>   	case INTEL_FAM6_SKYLAKE_X:
> +	case INTEL_FAM6_ICELAKE_X:
>   		return 1;
>   	default:
>   		return 0;
> @@ -3828,6 +3848,7 @@ int has_config_tdp(unsigned int family, unsigned int model)
>   	case INTEL_FAM6_SKYLAKE_L:	/* SKL */
>   	case INTEL_FAM6_CANNONLAKE_L:	/* CNL */
>   	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
> +	case INTEL_FAM6_ICELAKE_X:	/* ICX */
>   
>   	case INTEL_FAM6_XEON_PHI_KNL:	/* Knights Landing */
>   		return 1;
> @@ -4358,6 +4379,7 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
>   	case INTEL_FAM6_HASWELL_X:	/* HSX */
>   	case INTEL_FAM6_BROADWELL_X:	/* BDX */
>   	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
> +	case INTEL_FAM6_ICELAKE_X:	/* ICX */
>   	case INTEL_FAM6_XEON_PHI_KNL:	/* KNL */
>   		do_rapl = RAPL_PKG | RAPL_DRAM | RAPL_DRAM_POWER_INFO | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_PKG_POWER_INFO;
>   		BIC_PRESENT(BIC_PKG__);
> @@ -4514,7 +4536,8 @@ void perf_limit_reasons_probe(unsigned int family, unsigned int model)
>   
>   void automatic_cstate_conversion_probe(unsigned int family, unsigned int model)
>   {
> -	if (is_skx(family, model) || is_bdx(family, model))
> +	if (is_skx(family, model) || is_bdx(family, model) ||
> +	    is_icx(family, model))
>   		has_automatic_cstate_conversion = 1;
>   }
>   
> @@ -4729,6 +4752,7 @@ int has_snb_msrs(unsigned int family, unsigned int model)
>   	case INTEL_FAM6_SKYLAKE_L:		/* SKL */
>   	case INTEL_FAM6_CANNONLAKE_L:		/* CNL */
>   	case INTEL_FAM6_SKYLAKE_X:		/* SKX */
> +	case INTEL_FAM6_ICELAKE_X:		/* ICX */
>   	case INTEL_FAM6_ATOM_GOLDMONT:		/* BXT */
>   	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
>   	case INTEL_FAM6_ATOM_GOLDMONT_D:	/* DNV */
> @@ -5067,10 +5091,9 @@ unsigned int intel_model_duplicates(unsigned int model)
>   	case INTEL_FAM6_ATOM_TREMONT_L:
>   		return INTEL_FAM6_ATOM_TREMONT;
>   
> -	case INTEL_FAM6_ICELAKE_X:
>   	case INTEL_FAM6_ICELAKE_D:
>   	case INTEL_FAM6_SAPPHIRERAPIDS_X:
> -		return INTEL_FAM6_SKYLAKE_X;
> +		return INTEL_FAM6_ICELAKE_X;
>   	}
>   	return model;
>   }
> @@ -5180,8 +5203,9 @@ void process_cpuid()
>   			edx_flags & (1 << 28) ? "HT" : "-",
>   			edx_flags & (1 << 29) ? "TM" : "-");
>   	}
> -	if (genuine_intel)
> +	if (genuine_intel) {
>   		model = intel_model_duplicates(model);
> +	}
>   
>   	if (!(edx_flags & (1 << 5)))
>   		errx(1, "CPUID: no MSR");
> @@ -5359,7 +5383,7 @@ void process_cpuid()
>   		BIC_NOT_PRESENT(BIC_Pkgpc7);
>   		use_c1_residency_msr = 1;
>   	}
> -	if (is_skx(family, model)) {
> +	if (is_skx(family, model) || is_icx(family, model)) {
>   		BIC_NOT_PRESENT(BIC_CPU_c3);
>   		BIC_NOT_PRESENT(BIC_Pkgpc3);
>   		BIC_NOT_PRESENT(BIC_CPU_c7);

