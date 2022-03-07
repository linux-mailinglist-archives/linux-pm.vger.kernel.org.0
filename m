Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FC4D0858
	for <lists+linux-pm@lfdr.de>; Mon,  7 Mar 2022 21:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbiCGUcZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Mar 2022 15:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiCGUcY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Mar 2022 15:32:24 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B144A57B0F
        for <linux-pm@vger.kernel.org>; Mon,  7 Mar 2022 12:31:28 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227ISuhN022335;
        Mon, 7 Mar 2022 20:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AIP8hOdBd0vrFMcQdSHQlLXVFy+xpP4+FSCRyTmKjdA=;
 b=IgvCTp6g0Nkwacs4j+ndwkyKjljPBgYBkcuAB14XnQMTaSCCzEocw1cqC4OIfJ5ujbwc
 UodquvfBpoMqgo9GDzVTnt4cYaCQjR4L7NHO7BMYPgDB5jmrDci1kEjEjjj2V8pGMSW+
 4R/1wtcvtOQNl60Hnk/d/AxJ96PYiWGew3/TCd7fzrwvkp0xyXtOok1ym+daK1SgnK4n
 tGqMsXd/soUBlRG0gjNCsHrwcYn/aMl/Ob6paxMgoHyOwYnC7UuN6az4/7qZV7C4HZyS
 QMolkDhMmU1KtieKVDKmoLnxooafJV8MWaS+LP0ZMM7+hV21wSZYnHn5UvLqVxnZHZ79 dQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0n3sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 20:31:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227KGJxn109272;
        Mon, 7 Mar 2022 20:31:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3ekvytvse7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 20:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpvM2aPjFeCjQ3QycrWjZIQis0h9jybQevB9/US+hQ0+xRsGp7p8WnaBazFpvS4zefTsh29qvZogQVfgD6RfuKbiLkRzfSH75fb55knhxYbS5mAwaRQL2w3uGJaOAPKydurjDm1pUb+BtH0RfXjdtZzV+t+u5fc2gwcYF4DUPvJsfx2A98zIlxrRgEwIIrVtyFCZHu8ss2SjGpSj2+qLOjmqJnSMSFPDdHg+CYEL+otStNhMHBe4Iy0+Muy3iKvnf/KgwIQJoHTVpAV6/oHbD+KStYXU6EjFyrBJYXRDjNaoqCgqZXXxPOwa2v7AEwtBNyNGKwoAH35zgR+EwRk3VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIP8hOdBd0vrFMcQdSHQlLXVFy+xpP4+FSCRyTmKjdA=;
 b=NFfgfDUm2AYCq/RDWxyU+1qrFlcCkUHW49LuxSDWSFoWEWAZDw4PyEq0donOQJFtcXZx2P5p1JFu7gIMXmiuREh5jq8prAoikgpala67thL7GE0nMkpxrF7jO1hr0yzMk6TwKtj5BS57RSuTfrCth4ymdJSJUQIcSPL4OSKJgcZCco/ASF5jVXOOdD+YkxJ6Hhrw2TQ+9tuYUc2tgWmh0BI/hGE3Ywo0p2vesXSNSn1WjJSy5dSjkC/alwgkaYbbkpwN1x4/xchvAEPN06vUL2ZAgMeDCB0gt3BF4Axmi7dnMS0uFtaDmD0Zqe+9eOfZ54tbpNGJBW5YsxobZZ8Z4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AIP8hOdBd0vrFMcQdSHQlLXVFy+xpP4+FSCRyTmKjdA=;
 b=In6SzTw+2TNKlf0q0yOfky8LiS2WIcWXRP0GOVAwArjIzLP6k1NJumD/lTaM+FJuMQ6x6B+Lejy8qVqLCZIIkmcfVvpSirF3fZgvWW0jKHxXMyc41QYnQEZPl+87TsSNrmXDKiGGkJ0BN9tHAkgfggKA95XsOloqNSLAw/LogJw=
Received: from SJ0PR10MB4461.namprd10.prod.outlook.com (2603:10b6:a03:2d8::15)
 by DM6PR10MB3243.namprd10.prod.outlook.com (2603:10b6:5:1a7::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 20:31:21 +0000
Received: from SJ0PR10MB4461.namprd10.prod.outlook.com
 ([fe80::513f:7377:a42a:834a]) by SJ0PR10MB4461.namprd10.prod.outlook.com
 ([fe80::513f:7377:a42a:834a%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 20:31:21 +0000
From:   Kin Cho <kin.cho@oracle.com>
Subject: Re: [External] : Re: [PATCH] tools/power/turbostat: Remove Package C6
 Retention on Ice Lake Server
To:     Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>,
        Linux PM Mailing List <linux-pm@vger.kernel.org>
References: <20210504145234.4103405-1-artem.bityutskiy@linux.intel.com>
 <01dd04dd-a2ad-6ee2-4a8f-f801908e4299@oracle.com>
 <20220305092057.GA8207@chenyu5-mobl1>
 <61b2d82dd53f5cc3609f095b60ad8afe8c085f39.camel@linux.intel.com>
Message-ID: <cc159635-b194-73ea-d713-2f240c709d46@oracle.com>
Date:   Mon, 7 Mar 2022 12:31:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <61b2d82dd53f5cc3609f095b60ad8afe8c085f39.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SN7PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:806:121::12) To SJ0PR10MB4461.namprd10.prod.outlook.com
 (2603:10b6:a03:2d8::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2814dfd-048e-4d48-f9c9-08da007970d5
X-MS-TrafficTypeDiagnostic: DM6PR10MB3243:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3243F8E48185CEA6C945576885089@DM6PR10MB3243.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +sxg9uBPq9lTBFs7mR8uSHDvL3jm6/NqWvjPduIfJiaeOI7RGnlzA5E0O5ExYv3e7216rxATsevIhacmkx9afrQMj85uo+OgvDEftwnwAoaaQknibz3LdWAL9RGd7UOJiKwKEkGBLxuuTN5/rgGf5+Umq/Fks8VCSDKYDMN76RoUhS3QUC4K3OIcsjObtMS2Rm5e+3bd3tG9MCIkNgCXxuT0h3PLC9Z+yK+9nktKRg6iqD2Pgp2tiVwRLOun+M4Ql03l3iiiacITnKzdHsma+ODTpXnkqer6l7beFdFpaaoqET4FG99C4WyQEsdcd8+2kmBPcQh0o218l3k4QQO2crOkI21w4HLGqB3UktRXfLX+jk818Bg7+eSeTNvNmCEquX0DSc8ubdHo9vpg8bmt2TedsbNv1fF+0aIm3pQo/3V1ds/u4Uas5h0bLCUXpSh3ryvFNCvupLr2ifRGBJeK+28mSXf75g0m6KIAOgQbePEoZLE2Bf1MU3ehGr8ywqPWq+fWaKDJeRQAs5nJeBNJnaQ+xHmPqZUYXy/eNCvK3qAsuSxhgMl1GMj3beLSs4mkwVLl7W53KBq24DWnWxDN32i/LqdSIIySTLMQlGCBfEm/0tRZHTf12i3YEcfU56LMA4C2R2Tbb3VrwN3LwoUYv5ZARVkRlHQilKbB62TygV+XGVfY46QYPGhcrVm3Lkdwh2anKO94HgU/eOl34WXdsoHoGmFJRreGFRTlbwyRiXDoP/6gMOr3s/ga6Q6HK88MGHb3KtfnBG8y38JAn92EQ2sbDZ3c2aBNp1bg1ns2lA9m5HP0i4u+YTOGoVIUyQ55n10Qwj87rX4sefxBZueKbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4461.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(83380400001)(6486002)(966005)(316002)(6666004)(6512007)(6506007)(186003)(36756003)(31686004)(508600001)(86362001)(31696002)(38100700002)(8676002)(2906002)(5660300002)(4326008)(110136005)(53546011)(66556008)(66946007)(66476007)(8936002)(44832011)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enlaaWFhRzhWSTI3UjBnRGhHaWhtR0lCb0Y1NnRKaDdmTjFiOUtXck5rYUxU?=
 =?utf-8?B?UDZFZ3A3amxEYUs5b3dONkRnSWVzYzdOYmoybUNrTHdVL1ZOZUFOMWU5Qi9C?=
 =?utf-8?B?Qnk3bXEwTGJ5b0ZacEh4djMrUkE5a0tvWFhCMDJOQkw0elRDSmZKYlhLVGRs?=
 =?utf-8?B?OFBhS00vZEw1RFF3TjA0TEVVUHZKMVhOdU53TndqcXRpM20vZ0VkemFHUlBM?=
 =?utf-8?B?dDFFL3ZtN1J5ZkMrUUFCV244N2tGN01hb1lQVFZYS3I1L2R1cDlYcEJmcTFH?=
 =?utf-8?B?MDBHNU8vcmdrbGQwdWUveXF2bCtLRUt5cGg4MHNNRWhYcmhDdHRwNVQzSGg2?=
 =?utf-8?B?MC9Zb0k2cUNWS0IxZ1RXT2UvL2lvQlpIVmtsSUd3Nm9CaHZnVk40eTJFYlNW?=
 =?utf-8?B?U0ZyNWVOSzI1VWZ4M2srRHFJaWNMaUJ5ZE9GdU8zYmo3b0dNeG55b0NpdWZp?=
 =?utf-8?B?aW15SXpITWc0NUpuVXJ4VnVzUy9PcC9yWUZ3SzZpWmFLYzNUSmVUWStPbDVu?=
 =?utf-8?B?aFQ1S2R0bEtHcm1VSnV1YVR1bnNZY3BYT0hja0ZVVEhlNHZPQWVCUWQrTTRV?=
 =?utf-8?B?NmdoaEtkRWdLWTJpUDFTSUY2YzJsS0VTaXFCWUprazM0MnVZcFVpSnpkdlVD?=
 =?utf-8?B?WjhYMUJzY2twUnhXNHZaUzBWTk8zZmZSWXpqK2tTdzdpNzFXYlBOUkxQdXhG?=
 =?utf-8?B?aHNXa0dVaWF6RWhYaGhiaWZLenl2TG9meVZJdTJqYnhBcGFFUUFiQ3lWK2l0?=
 =?utf-8?B?S0Z4M2ptS1ZkenlDZUJ5ZHk2Vnhqd1M3akRoRHRveGFSSmd2T3MxUm1BbkFs?=
 =?utf-8?B?UE5OS2JobVhIZlIvaWFHMjJnUHdtc2JZWktOT1p1V3I0em9VSTNYSVlFeHBa?=
 =?utf-8?B?aUp5SlAxdnp2QjIrOFdhMGhocS9EYkdXTlo4eFgvRC9ZNGFKN2tGSUFPQTJx?=
 =?utf-8?B?S0JkV0h3MWdqK2wxVkdURTB3OWVoOUlDNE11R3dyU1FxZ28yR3htVlJ6dThi?=
 =?utf-8?B?VVY4cnJ1dS82TXBTcWRsOTZXbDRWcDY5WHFCSEJSd1RobGFNQXBtMm9veVdh?=
 =?utf-8?B?eHEvMzVyL0RoRGsxWkh0TTExS0hqMitvdGF1UTVBTXpvdlFBZ1cxYm5XK01t?=
 =?utf-8?B?aEFqR1dLcE04b3RHRUxOYW9EM1VTUlhKY04zOXkzcUFKdUZzaWo0eXQzTHhM?=
 =?utf-8?B?V1ZHWG5JQjhQNUpEZ3FGekYzdkZIYlg3eUFCdXpPeDNEbm5QUkZTM3dZRnpq?=
 =?utf-8?B?S3dneVRmWWl1aEswc085OFVYbnpuemdIWGIyc2U1Sis5UTlJTXA2Z1V1UVFV?=
 =?utf-8?B?THU1d3gxZkFIZk5YeEx0ZmtrRFl4cE1lYThrMm1MUHIya2FKMjdLaVV0SHZs?=
 =?utf-8?B?L3ZDYWRzQXcwaU1xT2FlaFRGWVRHSG02YU41aGNFcm03T1dkNjdkdFBDdG4x?=
 =?utf-8?B?VUZsWk9LaHpzbFZqZGErUGhLN0VqVjIwc2g3aFBGVG55Njh4UjEyUmNyUTdN?=
 =?utf-8?B?ZldBdGZQdjNnWC8yR29tSXBMU25xUzhGc2VpUFo0d1h3SS9tSzRxT1pnNHNL?=
 =?utf-8?B?R1ZYbXAralJKRGROaHh4V2ZUNmRPRVB4ejU3Qk1BZUx1SFZQMkFNeFdkTWJE?=
 =?utf-8?B?UERrQ05CNWpVNWg5L0ZtMmtrdHhUcm5VSkRnTUdSalNjUEtuNzUrU0RDd285?=
 =?utf-8?B?QnVZTStpUHhRNCtyTjZOa0l6UU1VZHBWNTBPeTQ4dzBDczJBYlk5QzlQdm51?=
 =?utf-8?B?S3NxM1U0TjlIL3dNNnhYQVVNdno0d2RMRVFCdHJZNzYrYS9Ka1A4OGhCYWt4?=
 =?utf-8?B?VjFPTURYT202U1dFVWRKTFpkWENRVDc1NzVFT25LQk9WQVA3U0c5RmhDWmRn?=
 =?utf-8?B?OVdjWVI2dU96c3RpU1c0aFRxd0NrbndjQThpbFp5dW03Z1ZzKzFLUy8rbFRY?=
 =?utf-8?B?MVdrbjJkMFNuT1JjUzBFSTgvRWJWMnhpY0d5S05UU1pJNENPaG8zNnIzWGEz?=
 =?utf-8?B?UUZVU1JuQzVMaGVHSzFVdHRieStBdUVJNzh3L2NKU2V6TTFGaklTM1dsVWNR?=
 =?utf-8?B?V3lpb2xXalFWZTdZZFd3dlRGZHU3K3gxSXE1RzYzdGkwbmgwMUllclpsRXVH?=
 =?utf-8?B?YjdKbmlXMU9pZmIzWHBYK1Q3b1FwejAza1VGSVVwMlBLeEhjRFhpN0VXaDJs?=
 =?utf-8?B?WnRuUVFCUk12dTFkTWF5S2RacStDanIrM25xVDlWNzF5Z0l6M2JZR2JFWGJi?=
 =?utf-8?B?Q25RSzBYSm1saE5Vbm9jRHg1aXp3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2814dfd-048e-4d48-f9c9-08da007970d5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4461.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 20:31:21.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: To3NQtU4vDoZ24LFq6+Uswmdf0ofLIN9Xa9yj10kYwv0p7jhGenO2sCIdjaPfErLN38J9K3PXllM/c5qkhFPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3243
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10279 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070109
X-Proofpoint-ORIG-GUID: Sc956BWKnzvwZEc81ZXHAxTv11ZAEKG-
X-Proofpoint-GUID: Sc956BWKnzvwZEc81ZXHAxTv11ZAEKG-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Artem, Chen,

The patch "turbostat: fix PC6 displaying on some systems" fixes the 
issue on our Sapphire Rapids system.
On this system I also checked MAX_PKG_C_STATE, and it is 3.

Thanks,

-kin

On 3/6/22 6:35 AM, Artem Bityutskiy wrote:
> On Sat, 2022-03-05 at 17:20 +0800, Chen Yu wrote:
>> Hi Cho,
>> On Fri, Mar 04, 2022 at 01:35:17PM -0800, Kin Cho wrote:
>>> Hi,
>>>
>>> This patch (25368d7cefcd87a94ccabcc6f9f31796607bbe4e) has affected 
>>> Sapphire
>>> Rapids support.
>>> Specifically Pkg%pc2 and Pkg%pc6 are now missing on Sapphire Rapids 
>>> (with
>>> package C6 retention).
>>> See below for a diff of turbostat --list output with and without 
>>> 25368d7.
>>>
>> My guess is that the max limited package c-state exposed might be '3' 
>> rather than '2'.
>> Artem has previously found this issue on ICX and there is a patch:
>> https://patchwork.kernel.org/project/linux-pm/patch/20211004105224.3145916-1-dedekind1@gmail.com/ 
>> <https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-pm/patch/20211004105224.3145916-1-dedekind1@gmail.com/__;!!ACWV5N9M2RV99hQ!c44scI9uwc_oZRla1MmeuL9IJVimON-bjStsp8_FIh3icFJoju9aMrt6LpMCcA$>
>> would you please help check if that helps?
>
> Yes, this patch fixes the problem.
>
> Rafael, would you please take a look and possibly pick it? Thanks!
>
> Artem.
>

