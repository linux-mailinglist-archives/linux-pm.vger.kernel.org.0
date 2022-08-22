Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D9659C9C2
	for <lists+linux-pm@lfdr.de>; Mon, 22 Aug 2022 22:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbiHVUOq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Aug 2022 16:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiHVUOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2022 16:14:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBF254645
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 13:14:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MK0ivk008404;
        Mon, 22 Aug 2022 20:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=6Q7cmKUhWoiVMDRIIUa3yKhv+dNeaN7WvAc9Zg4yGnc=;
 b=asBKH4zf9azlyftf7UTp0G5tcaGt1TGZwoSduwuwqri2Retk48p5KkYS0jaD/V7tuIQC
 w0jbzxhz8WQGsvYrm/9kuw8xolzL1FyBFcw17XJpy81CBuOefiK3+5x8MVrR4/Ak+wdp
 7uc5m0Mlxt6yFU/lii9SVejtxYa0jfg33YMXQlLHJ799cBKOmZHraBPDsarN2RpY7Vbf
 OKlHPhwypNkWd8EBiFUuTev08HgA0W9CvyPALyLfexJhkhD/dNVuDoi8HskAvSLxKL1v
 KrM9JvY8aF+Qlg2XTAfTtzlVfDPi+NaryhL7dshGZqley5SDum8fKYMuUr9dh/a+H7+i hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4e8crcgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 20:14:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27MISQT4025281;
        Mon, 22 Aug 2022 20:14:36 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn24tbd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 20:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoiChGrWgZY99EDFS+bq4e5mMLHj/KTOYJZ0Ys2b8KHRzu5pQQxEHqFRLUfLPyn49/DpEjYk+PStCTKvx/zVZl78VxVSoxU9tCUqUwYki+JxkiD9byHl+odUc3i+8ShMGNRk8C1vNUzJgB717FLX24yzihTP8ZkOpn79MR5DHnUoJjpBGJeUWYLsFewf+XCeqMtverC4IWbPNVCkNwpNhmiJCPUX08VgY0/v9RCDvT3F3iIwJTSJDcbRLcpuOXqMW4uNQFS9vkSFCrxhtp82ICRMgRl3NlmEZHv7uDob7Ulvl49+hctYY2a2QaJdBIFw3PhtyIaXywcXy5QeDBqUZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q7cmKUhWoiVMDRIIUa3yKhv+dNeaN7WvAc9Zg4yGnc=;
 b=Y62lA6Gp8nGh+0WArlixhCSE+e6fSKZAjzerjA6l0ojSYPrV/buRj5DPZTKNb25/ezfANzHuTxx3RuoPKK0RkNqP9U+51055JqGwSfnf0QWYwsYuSYMsTdL5ZeCv+wkbBnLHMVmKPenX8wdaWqGUd1LNEyK3YWV8fROeu+p399NToZQMR4wMpaw5VO+uARayS6tQGLElCW0U7wRxbtkdNSOeZpw0NdUCF4L2Q/5MjoRWPLhLZFET3yhvxnoURkHwIyCFRVHHwoScKlL27XybmnX9usEWK8n6ZXg9RwP+1RGT/ux6SxQy6QWMdBMz9pUPawwTt6TNS52vYsKh13e3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q7cmKUhWoiVMDRIIUa3yKhv+dNeaN7WvAc9Zg4yGnc=;
 b=LP7P3UYESDR8RT68OgdTxC+dMnx6KI8ut0gqP5RwyO7/SivR1JX/Hsw49LeNTkk8KWDsGFwRb3ZEw+uluQESeb9ktygtiy3P0Kfnewf87hQB5Mxutg8INFhNifGf4GnQDassRPPQnFrWB/jBOArYTz4E2KGtCgwGdmQmtIk2ZhU=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SJ0PR10MB4654.namprd10.prod.outlook.com (2603:10b6:a03:2d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 22 Aug
 2022 20:14:34 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c%7]) with mapi id 15.20.5546.024; Mon, 22 Aug 2022
 20:14:34 +0000
Subject: Re: [PATCH] cpufreq: cppc_cpufreq: prevent crash on reading
 freqdomain_cpus
From:   Chris Hyser <chris.hyser@oracle.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1660935837-7481-1-git-send-email-chris.hyser@oracle.com>
 <1660935837-7481-2-git-send-email-chris.hyser@oracle.com>
 <20220822053920.y6us5rsi6u5cdapi@vireshk-i7>
 <6a77acc7-2bc2-2f97-b3cb-32ad1dd21007@oracle.com>
 <7b716f03-fa86-dc49-6a8f-ac999503900e@oracle.com>
Message-ID: <7eb7800b-6100-84b0-1855-3c5a330c810d@oracle.com>
Date:   Mon, 22 Aug 2022 16:14:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <7b716f03-fa86-dc49-6a8f-ac999503900e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0059.namprd16.prod.outlook.com
 (2603:10b6:208:234::28) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 530132a3-e5a8-4365-87d2-08da847aee34
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4654:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aZcUEmzu5/aG87nxop/ohiZeNKlQZ4uiE9K+eJ5ot8icLp9gctovB7AfIg13ss5u0sqGp9PleqeGZk14Opfk4Zr3mUzRfiwIdCjoDCHX7YbdyT0Fs2H8pRN311/ca+ZlKVtFqXFdZnS0EPFfX/TERyzaD7gdyJFj/pnmYGd0RNT0K8O3rI3GjQCYZtZS8Ddm+jCz81Oviqg0q3MC09PY8V6q4Jarm5ke6mfeJG8ofxSrZebhGhONS4aM6aAAb3kjbMbH7nFr2+LPEu+tO95mKr2+H28FohRCtPOsRfGE/p7UWNU/YtXUdrLQUZKpya64CAMe6Qw2i2AbTrEE1cfz19pj2BqgvPlfgyEjz+V6fgn7GwCsdn26gBmOTxPpmo+vqUpPMQCLmQ0gQXJTqE+DYtfjNlOZOPTsPXOAy+V5ejG6kXrmpcvGrEkFGIFGTaN8CLIU5nFf6NVvLjwYAegeTCjPFS32gp8kYfOTYscGq/Ij7/GCrdSzq/33uNoHFcthMs1chzxpTWkdZJwo5RT5Tfgznqh4l8Jb81x0ACo2C0dLxZif1n6RBGNdjRjboG7NeXXWleWs/voxvSt0Mw0RqdGg+yHFaS2vC5OyGHFcAn8782N5Jgm8thv3tyD0NSEfIRNlaJk4/QGnVo6ldVYkACkNmmgjJnMk7F3rSxnxX7l3z1FDG5Cduya+xV9n2vXfZ3eeQQUGVezmcpbRskZMLgNmWKAhn6Ru1pWz+uEbuIomCcOiHbcHyRZp9geT77ynoSAEevQPzJWFFyY7uWGCeH97nQ1CYhyeEjPffrINI2Mpii/DhHL2mEx51ZD2u6Sl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(136003)(39860400002)(38100700002)(2906002)(316002)(66476007)(5660300002)(6916009)(44832011)(66946007)(66556008)(8936002)(186003)(4326008)(8676002)(6506007)(38350700002)(86362001)(31696002)(41300700001)(6666004)(478600001)(26005)(31686004)(53546011)(36756003)(83380400001)(6486002)(6512007)(2616005)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SW5lUFNRM0tXZ3pzb3RkOU5yNFlna0dHejFaZi9RV3hJU1AvVExDa2tka2tG?=
 =?utf-8?B?K0hGa01QS0loWEl2Nkd4R3JVVXBKck4yREphdWZQcHBxaVNxK29lYU5ROSt0?=
 =?utf-8?B?SXBTUWcvTndWZVBJcktyVTdLSEFCS1k4Vm0xbE9qcHpxL2xXSmtiS0JQU3g5?=
 =?utf-8?B?bHEvcHhON2Q2dXJPU0pYMWJtVEhyTXdCVk04L1kzTWhhWHdLRGM1Ti9rUFJ6?=
 =?utf-8?B?VU4wNVNTeFNGVGl0NE00RHplQk1QdmttY2lYdnpGODJQTXZ6VERCV1M1dDRq?=
 =?utf-8?B?NUFnTE9FNDV2OFNJeDRPWG5WZjMrREVTN21YdFhvTlF6bVhSdWc4UnFuVnBP?=
 =?utf-8?B?a2loWkw4cmk0b1lyNkNIbGtUaTVLdUlaZTJKNnM2Sk4rL3NnVHM0QjBCdFAv?=
 =?utf-8?B?QjkxSG5xanRWZElIRGQ4TkxobVZ2RHVteDMwMk8rNE9QNmZ6NFBPZVJiWVBI?=
 =?utf-8?B?bjFIblIySUk2Y1h4TkpnRm9CcjA2NCtkRXhrRDZ1Q21PRHIrcHE4a3J0R0FZ?=
 =?utf-8?B?bVJYQVNGZWpxbkV6U3Q1dEdTWkNRWWNYNFpEMFd4K2pqWGgxY0NEOFJrWmpi?=
 =?utf-8?B?S2had2ZIZ0Z6UWFCVm1SRUFPSVhJdDVmZEpxT2o2dlAvWlJXMTlDdlRzLzd0?=
 =?utf-8?B?WC9CM0tpNXNEMXF4RzdxaWVROUNvbHN3ZWNyTzlZU1FzcHZUdElScFpyTjBZ?=
 =?utf-8?B?MEI2cXpBRisvUW9KbkZuTStUaTR6enRFZHZwOUIrYjQzUkpZRVhwZkN5ZWJZ?=
 =?utf-8?B?QkI5VGdHS3RUblVMQURWNTFvY2FTc25XL3E4UXQyS3c4cGdZTFhsUHZTSHdm?=
 =?utf-8?B?QSs1czAxL015RitIc2VlQU9mNUJkUFpQdjVIRWYzbmZTcWV6Mk1qVVRRY3pV?=
 =?utf-8?B?WEQyWVd6R1JKY2hnYVJpTU1KbWc2WU54eHRtUnlPZlBscDJtSEQ2Zzc2cTdV?=
 =?utf-8?B?RmZkNDd0Z01NcnVYeHA5emJLclJUaE9LZ1ZQZkczWE5wa05SclpqVktxd1hT?=
 =?utf-8?B?Tk1zNC9Qak9lRlJ0dE8xWjFHaThOUmhEVmg0akdIVUJGUm8wNFB5dUl0QTRi?=
 =?utf-8?B?MzBUeHZZTU1DNFlldy9vRHZUbEhPS0NXNlcxWlhQMHJLbGQzNDZMYnNDam1u?=
 =?utf-8?B?U2ZwVWl4NzNLSnQrZkErbTE2cW1pVkZMM1RZTVl4amJIK3NPYTZUOHN5Qm1h?=
 =?utf-8?B?SGtCT3pTRDQ3QjM3Y3UrMTdHTXNCQmR2ZEVacHA3cCtwNDNoZjdVNVdsUmlz?=
 =?utf-8?B?SHNYK01OMHRsMEQyMkgwNTlPSzltRERHdHNmek51ZUNkbVhVbXl5MVlqNG5k?=
 =?utf-8?B?Nmg3UXNyVzZoeGFOendzUnAzYUlyWlZpLzQ3czdHRzlBWm1SN2w5SWk3cUpJ?=
 =?utf-8?B?c1RtMzNraEt2VXEyUW0zK2YvbHlHenVrMHBuVGJzU2s3ZEpBNFVQTFo4aFE0?=
 =?utf-8?B?ZXBWcUxXUGN1T3E4M05NMmdDaDQvbk1JdjNEZ1dBVlo1ckNHV205UFloSTB2?=
 =?utf-8?B?L0xsVUNSUVFHY3UxRkQvaHJoM0FCRjRXWlJaNUhXYjFxa3pSZEMzcDd5bUc4?=
 =?utf-8?B?R2tuaWhXazNJTWhxejZrcDFMVExBd0ZlMkpraXNaRm5ORjd0OFFXOVRCWksz?=
 =?utf-8?B?TXcyK3Z4Snd6OUVibm1jYWp4a1ZBZzBtWVhGOTRyelh0VHdHck5oV2xYWVNF?=
 =?utf-8?B?bHFieW1LaHF6N2VNL2xkQklVK2tza0YzQWJldmZDeTJpVVlUZ0ZhUmcwemtU?=
 =?utf-8?B?SnVLc01aMDJrUm5hUkNYMDc3U1NKc2VqcW5wUFpSQ0ZNVzFqbVI5Z1l1MURl?=
 =?utf-8?B?MS90YUFiT1FMa2EzTGVSRzJCKzExMU1rbHFLNWxweVYrbU8yZHdsam1jSmp5?=
 =?utf-8?B?Rmw0cEVxSG1ITmtGQWk1eXNncU9IVlFMYmthMkM0ZDZ3Y0ZoUUdaNWFVOXY4?=
 =?utf-8?B?MUt1Mk1kRE1IbHR6M0c5U1djdHFobkJ3clA0M3dJTDBiNW1BQlYvNllpVi9C?=
 =?utf-8?B?c1N1b2J0SFNhNTRiWUhlQkFWMFBuQnhRZHNacml1NVJIZG94Tk95cDBDb3M1?=
 =?utf-8?B?UktGTFNEQ0NvUjlEcDNETzBLeDE4VTNCSkQ2TElYTlFrZDJRaFhnWmxRcjFO?=
 =?utf-8?B?UzdEbzVCTXFNaHptenU3eWJ4TVdiR0Yvd3hCVUx3YjV6endIZEgyVEVyMlVV?=
 =?utf-8?B?Umc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530132a3-e5a8-4365-87d2-08da847aee34
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 20:14:34.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ad/zF3iIL9xeggtXH0x9y2WAYM65s14mnjYqwxm+Qpts0ToF8YXYu8bIqVpShxmiygQLVo7rghDm82HJoHa3Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_12,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220083
X-Proofpoint-GUID: tL4X7_sehqSRxTmkdCGQhQNqS03rVdx-
X-Proofpoint-ORIG-GUID: tL4X7_sehqSRxTmkdCGQhQNqS03rVdx-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 8/22/22 11:54 AM, Chris Hyser wrote:
> On 8/22/22 9:19 AM, Chris Hyser wrote:
>>
>>
>> On 8/22/22 1:39 AM, Viresh Kumar wrote:
>>> On 19-08-22, 15:03, Chris Hyser wrote:
>>>> From: chris hyser <chris.hyser@oracle.com>
>>>>
>>>> While running stress-ng --sysfs on an ARM system following a cpu offline,
>>>> we encountered the following NULL pointer dereference in the cppc_cpufreq
>>>> scaling driver:
>>>>
>>>> [ 1003.576816] Call trace:
>>>> [ 1003.579255]  _find_next_bit+0x20/0xc8
>>>> [ 1003.582909]  cpufreq_show_cpus+0x78/0xf4
>>>> [ 1003.586830]  show_freqdomain_cpus+0x20/0x30 [cppc_cpufreq]
>>>> [ 1003.592318]  show+0x4c/0x78
>>>> [ 1003.595104]  sysfs_kf_seq_show+0x9
>>>>
>>>> This is the exact issue described in commit e25303676e18 ("cpufreq:
>>>> acpi_cpufreq: prevent crash on reading freqdomain_cpus") with the fix
>>>> described there also solving this issue. I tracked the root cause to the
>>>> following: a scaling driver which provides a struct freq_attr sysfs
>>>> attributes array passed via struct cpufreq_driver during driver
>>>> registration, has .init() and .exit() functions and does _not_ provide
>>>> .online()/.offline() routines. cpufreq core creates the attributes, but
>>>> does not remove them even though .exit() frees the underlying memory. The
>>>> core functions and most drivers have corresponding NULL data pointer
>>>> checks.
>>>>
>>>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
>>>> ---
>>>>   drivers/cpufreq/cppc_cpufreq.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>>> index 24eaf0e..4210353 100644
>>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>>>> @@ -876,6 +876,9 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>>>>   {
>>>>       struct cppc_cpudata *cpu_data = policy->driver_data;
>>>> +    if (unlikely(!cpu_data))
>>>> +        return -ENODEV;
>>>> +
>>>>       return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>>>>   }
>>>>   cpufreq_freq_attr_ro(freqdomain_cpus);
>>>
>>> What kernel version are you testing this on ?
>>
>> 5.19
>>
>>> We merged a patch sometime back:
>>>
>>> commit d4627a287e25 ("cpufreq: Abort show()/store() for half-initialized policies")
>>>
>>> which I believe should have fixed this issue. I will be surprise if it
>>> doesn't.
>>
>> This patch is present and apparently does not solve the problem.
> 
> On digging into it, that patch says it is about catching partially initialized policies and indicates that by clearing 
> the policy->cpus mask. However, on a normal online/offline a completely initialized policy survives (ptr in the percpu 
> space) and that mask is not cleared and the driver show() funcs get called.

On yet further digging, that patch does appear to work. There is code that removes the current cpu on offline and as 
that is the only cpu, it does leave the policy->cpus empty. I think this patch must have showed up between when I first 
started digging into this problem and when I started trying to finalize my stuff. Thanks for pointing out the fix.

-chrish
