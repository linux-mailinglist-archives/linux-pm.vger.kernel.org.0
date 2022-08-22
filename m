Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE30659C059
	for <lists+linux-pm@lfdr.de>; Mon, 22 Aug 2022 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiHVNTc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Aug 2022 09:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiHVNTb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2022 09:19:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F96513F55
        for <linux-pm@vger.kernel.org>; Mon, 22 Aug 2022 06:19:30 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MCnJOB029147;
        Mon, 22 Aug 2022 13:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gjxwJBJYZW2a9FQE/oUUXnBZiRtH99Y9yeu3A4Y0zhE=;
 b=gV1sIUmlOq7tacvDJqqBhsquLY8mFDd9JQ9iTd5+qPVRzP8bQEotVZP4ICmaDhdRvoJI
 SgaSgr5zSjS8kRUkTxfa/u7iKbFglwHEJ9lfGfAfnESR8a2iKvlmZpdeNFzNn3LCVV8B
 /2qsox1tH/yUlmuhlHn006bqZtYTxJWBm59Kz2tcLaMWc3kR70Pbyi6QkDFH4zcC4Zd5
 XBREP1WSrg9O+qXSsmQLI7Xti4IWU8u6uMhahHHuttNdy2wgETqO7vEzdJYdB+ehY3oI
 +/J7w510qYc30Xdz8ofMqGcj2BZVXyXF3DhoHo9TUMDm2tAo0ZoExC2UXfK1wF6ls7HU AA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4a4ur2rg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 13:19:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27MDE0fP036155;
        Mon, 22 Aug 2022 13:19:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn1r32k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 13:19:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rre7GV/sp63t351hCVlJ4LEYEQzZeLG03lzfpgRuAue3NQFjQzl0RZBUk8YjQ/Ph1lFzx+XhgXPGzcFqQpRzQTNNy3WD3fw8p8nIABl7qR6bDUcJGMEhGWLTCoRLN86ykbd+WGRYfLBZWYtEaGTJXTd6i5As7H4FFc8LogorP5jtVF1oUtzwoF4CbdLCGTkfIRPD/4q9G7YUNOHppdIsjp4snr/9TjYtVOeHL2TqHLQ9Y3MCof+Xc4jgEpsyTOifLeJUK5AibIr1jxXYOiiXnA6HhnEn8nV1kAjqSlTaaz2QfNe3gTKou89liCoh6MJoEHtNOQRyy3o/RzyTKXMqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjxwJBJYZW2a9FQE/oUUXnBZiRtH99Y9yeu3A4Y0zhE=;
 b=K+rSj/pNOp7rGG6l3JyYdlp5WXPk1g/TWik1Z2Q/MxbTg6iItAZWBh2xP7+n4Cc0VRxmIdp5bIKWhP36wj2naMq7OErcobLfP+Qg2Wy3v9u5gsxu8RqAq38TbQ7GvHxORy/7WNAnebe4f6y0XPMhe6FzQXKvK/3WsF6u3SHPGfr5pgs2WHMMVq3/jNRkwEMbXAozI9uj3TsbBEE6hwtDkQwJH41Ibl9epi0NELpRC1kF8QTKmT5xMUF5wV9y3Tbspp67akKJ8oywPWZPNCzujH2rxFBKgYVWXqPhSZek06c8NK/P/c9Vko0UCoueytN7rK+OitD8/oUiqfO5v0R8ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjxwJBJYZW2a9FQE/oUUXnBZiRtH99Y9yeu3A4Y0zhE=;
 b=rNAuDb3Mw46cODdZA5uA7png6v8QBw820dX8wtoOs9SYSmEy2PqWwMbVejTbpyT4oapG+eP1cz5eEfJIpquofVdjEkhSfZZD6zSmT/vTG3YeeF7TZk+iq10cCTHVS/M+PAFknn1zgczMa9U2nET/ovW3/DCUArAbUIT9ecCGsNM=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by CH2PR10MB3800.namprd10.prod.outlook.com (2603:10b6:610:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Mon, 22 Aug
 2022 13:19:22 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::f1e9:f64a:1a86:ee3c%7]) with mapi id 15.20.5546.024; Mon, 22 Aug 2022
 13:19:22 +0000
Subject: Re: [PATCH] cpufreq: cppc_cpufreq: prevent crash on reading
 freqdomain_cpus
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <1660935837-7481-1-git-send-email-chris.hyser@oracle.com>
 <1660935837-7481-2-git-send-email-chris.hyser@oracle.com>
 <20220822053920.y6us5rsi6u5cdapi@vireshk-i7>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <6a77acc7-2bc2-2f97-b3cb-32ad1dd21007@oracle.com>
Date:   Mon, 22 Aug 2022 09:19:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20220822053920.y6us5rsi6u5cdapi@vireshk-i7>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0029.namprd02.prod.outlook.com
 (2603:10b6:208:fc::42) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3fd948f-68d2-4026-1722-08da8440ed44
X-MS-TrafficTypeDiagnostic: CH2PR10MB3800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QEwTmtg7hkwm3NuseuyX5aM2V5EoK5BNjbeDmw4HLIWb70zFHPVIGec/i8mWEBWH4Fztw7nRYmYQqkG0/j30OoPBSYW3YD3iiTcBY37tkLT8NkLqePVssyIGu5cRO7H2R5KF9Sx3DiDGxFk6B1asjKuMaAXZLajpz4hyv9ss4a4bMhKPb8vFnUVqPCouFW56KdHbXu2i7ex2fkKObxz80FZsnKcpP6hfQLSgxvz6tQtQr8AKQOVWg5cM8RZ8pRXNYz+1GuSCox243y3nCJpDnjTGEeLVr0aFiYeQRRie2uJIZ0r2BIbr2a6OdTzDTig8npspVPflX6qtjV+Nk3G7yrGl/f4ceD+8xu2pIy495jqkh86ZTUWtOdyE5N4oNFoKbjSYGzwUQCHbKYa1m9FHFZHR9dSiAK4r9sqvKUi/WdEtXMxdQPYrLeS1VIGHdYk78fK3U1xR+U443C5fCBcYYVQFOofrSGCz25nm0IhuSXOpXGAc4h/HbXjN8urwh7B+ZITtvYTz9l1ZXbwSx7eg/s+fe3JUVcKavsJS37AllEwCkiHPaT2eTmZtZajeYqtWym84yaae9deiBxclfy8ADwxp2RuWDgPDBUT1GvYfpWf8Rffu2bLE/CCkERDLWOxaRNllLTtOK5D+AUB1UbLs7Ptz/+M+liu+6ms9kZ3taSP/17EdjpWDkDRqEbtUV9AObBLAH0o6Og1ocRH5C43q/qNcmkG6dZ1TwBEz+FNJ4D2l92uwg6qh7de5QspKBolOFBSgAX+XxB7rc9xgo/rBjebJxA9MVbLSMKeW1pZuNPGItwxdcrpU/PB9JSy1oxj9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(136003)(346002)(396003)(31696002)(38350700002)(86362001)(38100700002)(8936002)(6666004)(44832011)(6916009)(5660300002)(66476007)(6486002)(316002)(66946007)(8676002)(4326008)(66556008)(83380400001)(186003)(2616005)(36756003)(52116002)(478600001)(26005)(53546011)(6512007)(31686004)(41300700001)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zzc2cjVSRlQ0UE8xWkljRkw1amYvODJCc2NJYjhRWmErVWZndmowU3doYkp0?=
 =?utf-8?B?bkxJdTZJMFQwQ2dKQ0JiZmNYd25GZGEvYjMwNnFRTXJtMXl0czhWK1VnV1k2?=
 =?utf-8?B?QkYrVmJ1U3YzYjMwUmQ5VWlJcTRxS29NTUtlRzdqRUVwclRhRzNZMWRqWHFN?=
 =?utf-8?B?ck1vYzF5dlY0bmM0VXNGQ0o2VmRnSVVuL28vcVhSVjVJS2ZJZjNsV2ZOWk11?=
 =?utf-8?B?cEEvS2ErMkRmcm9wRmMzWVlHcFBjZG95alY5YSs1b1diTVd4TzVMWmtGM1R2?=
 =?utf-8?B?b2lYZHBYWDFoRDZzNk8vcVZ2WjkvZGlHNU44bWNlOFRpUXdMTEF2a1RnV1pF?=
 =?utf-8?B?N0R0ZmJFSlJFSDl5dTI0WXV2OFhyQlBSUGlpeG4xU2JBdE1RNGxHemhaUkRv?=
 =?utf-8?B?UnR2cXN4VFJYT0YyQyt1UW1QV0JZUjY0VjBFTyt0YWNzWWMvWnFFR2VQdFpQ?=
 =?utf-8?B?ZjZNcE94R2p2KzkxQlFXaWNKNy9kQzdsa01JR2hxd2tBNmdQWmpwdzhRWDln?=
 =?utf-8?B?WlBDZHExaFhMOTkyNWRlUFVxL1dkUW05RTVqajN0MEh0ZlYyV0s0UDg5ZS9R?=
 =?utf-8?B?eUtIQ1k0NDJyZzh3VXZkUEdtRkN2RFFQc1QvQW9FOXRDSm15UXJsUFNyVzRY?=
 =?utf-8?B?Z0FpQmRCUTVlQndPZ04zUnF4c1Q3MkQ5ZnNMdk1aR1o3K3pId2RyNm16eUU4?=
 =?utf-8?B?disxaUNZNlZ2YXgreUxNTVhndnJ4OFJDRnZkbitZS3o5YlV6WmVLeEZldEt5?=
 =?utf-8?B?OSsxVnJubUNZeWkwVklvY3FvVzdKNjNtUWUyclBpTzdHbmlqWitWWTdqdVFv?=
 =?utf-8?B?L3FVbGs4a1FjYkZmZEo0dkdvelBlTnhCQ3dZR0hYNmtVc1BTejVsSHBTZnpX?=
 =?utf-8?B?N3A1REN4akpPamlHK1NxbnhaclBQTnN0a1BzT2ZyRWVqV3AzcWswY2xnWWpD?=
 =?utf-8?B?Yllmb0lwK1lGNUdydTFJbjF5MGIzWHQyV1VYeGdJdmNXaENTNGQzWTQ3ODNp?=
 =?utf-8?B?Um9tdEpMQ3NDNEpUakE5U0UrbWhpbG1yVjR2R1dhQ2hjT3NVby94cnpqaWJS?=
 =?utf-8?B?ZGtLaGNCVDIySzEzNHl5aW43cXh2TWoreDF4QzR3Q1VkYzU0V0tzZkdJUHJX?=
 =?utf-8?B?QWpFYk1vSVpYUWFGdHhKeUNac0M1TkYwa3BGQ283NlRHVVA0U1orWHdDVTJh?=
 =?utf-8?B?MWR2b2VnWFljUVdmdXJLOEE0bzhTM2NpQnl6bW1RWDdJOHdMMVdXNnl2Rngv?=
 =?utf-8?B?MFEyQkZ1TEsxZmlyRjZFdlNsdCsyd0pQWFFPWmlsVFE1MG5LaWY3ZUlZU3Ey?=
 =?utf-8?B?ZStiWHg0RjlDbXF5NlE0Z0JzelRWMUU0M05WVUh6WU5pS3FsRHl6eW9yQkd6?=
 =?utf-8?B?MWVnbjRKZXdGRjdHU1NsZEYxMEM3WjJDbFBsTldHMWgyK3FvbFhWa3NSM1I2?=
 =?utf-8?B?SG5lb0J0aTJkQ2t3YzIxOCt6NWtudWdqVWpqQkE3TWhvUTNuRit5OWsvN1Q0?=
 =?utf-8?B?bnRISEw1VFd2OTVnOUtURTBzc2NFSVRsQ2RYK1cvWXJLc252enpJblE1TnVQ?=
 =?utf-8?B?UVowdHJoMWRWZFFxczAzWW1OOTVJU014dU1zNFNKYy9acEFlQmlXMlNEMnFS?=
 =?utf-8?B?Q25vQXMxOFUvZ2V0Tmh0N0l0N3Z6cEp4NXBjUkNiTUlKQkk5N0RyMnY2V2Nw?=
 =?utf-8?B?N2dTb0JHcHVaZnZtOVdDdTVnRDJ1djNoUjQwZmhsRTAzM2p3SUo3TmkvZjBS?=
 =?utf-8?B?UXhyQmJZWFBPRG1NNEZWU1NRV0hxbzZ2eUNzaG1qZVhFMmFCMEFkYldHTG5W?=
 =?utf-8?B?VmxjSS9CS0JGTnd4WGpVU1gzeXRITHdqSzZHRkdSMUc0b3dNR2t4VkdJamFB?=
 =?utf-8?B?NThsaWNxZEFXQ1NWMXZMRGtPeHNCNGtBeUlqbTVSaC9Ud252SHpQMnM1N29q?=
 =?utf-8?B?dElhY09JakNGR0FGN284cWVWbnNDbHJZaGwxWVVIOHpyQWZNVWtUVExkTVAv?=
 =?utf-8?B?M1UzU25GeEFkMzBpcVdtQU55Z25hVXVDSi9TMG14dTBqMVhrU1V3UDQzMzNB?=
 =?utf-8?B?WmRvRklvZWl2ZGhoYzNJbS9FOWo1NCtDYXBFZW9UT3gwbG4zS25qdzNrNGMx?=
 =?utf-8?B?dmJ2ejdWVklETEd0WFJCMFVNSXlqMmo2ZFQ4V0hnYkcyOHFzdC9icWUxbDZs?=
 =?utf-8?B?bVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fd948f-68d2-4026-1722-08da8440ed44
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 13:19:22.1344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbXnxyBLnF97L3d3AqWW4mGtPtkyyykt9xZsD0SW7t15Ju81O8XULffAQIjTv9ouCk3Ej1Ytq0a+GTuRQ20VNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_08,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220056
X-Proofpoint-ORIG-GUID: iELkfuaYt0eAvEbXKBk8_V6gI8Ffn7CM
X-Proofpoint-GUID: iELkfuaYt0eAvEbXKBk8_V6gI8Ffn7CM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/22/22 1:39 AM, Viresh Kumar wrote:
> On 19-08-22, 15:03, Chris Hyser wrote:
>> From: chris hyser <chris.hyser@oracle.com>
>>
>> While running stress-ng --sysfs on an ARM system following a cpu offline,
>> we encountered the following NULL pointer dereference in the cppc_cpufreq
>> scaling driver:
>>
>> [ 1003.576816] Call trace:
>> [ 1003.579255]  _find_next_bit+0x20/0xc8
>> [ 1003.582909]  cpufreq_show_cpus+0x78/0xf4
>> [ 1003.586830]  show_freqdomain_cpus+0x20/0x30 [cppc_cpufreq]
>> [ 1003.592318]  show+0x4c/0x78
>> [ 1003.595104]  sysfs_kf_seq_show+0x9
>>
>> This is the exact issue described in commit e25303676e18 ("cpufreq:
>> acpi_cpufreq: prevent crash on reading freqdomain_cpus") with the fix
>> described there also solving this issue. I tracked the root cause to the
>> following: a scaling driver which provides a struct freq_attr sysfs
>> attributes array passed via struct cpufreq_driver during driver
>> registration, has .init() and .exit() functions and does _not_ provide
>> .online()/.offline() routines. cpufreq core creates the attributes, but
>> does not remove them even though .exit() frees the underlying memory. The
>> core functions and most drivers have corresponding NULL data pointer
>> checks.
>>
>> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 24eaf0e..4210353 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -876,6 +876,9 @@ static ssize_t show_freqdomain_cpus(struct cpufreq_policy *policy, char *buf)
>>   {
>>   	struct cppc_cpudata *cpu_data = policy->driver_data;
>>   
>> +	if (unlikely(!cpu_data))
>> +		return -ENODEV;
>> +
>>   	return cpufreq_show_cpus(cpu_data->shared_cpu_map, buf);
>>   }
>>   cpufreq_freq_attr_ro(freqdomain_cpus);
> 
> What kernel version are you testing this on ?

5.19

> We merged a patch sometime back:
> 
> commit d4627a287e25 ("cpufreq: Abort show()/store() for half-initialized policies")
> 
> which I believe should have fixed this issue. I will be surprise if it
> doesn't.

This patch is present and apparently does not solve the problem.

-chrish
