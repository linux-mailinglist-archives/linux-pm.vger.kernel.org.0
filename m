Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CA8360AE9
	for <lists+linux-pm@lfdr.de>; Thu, 15 Apr 2021 15:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhDONq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Apr 2021 09:46:27 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:5601
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233037AbhDONq1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Apr 2021 09:46:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCDIM+o6VNCneHB7Din+4Jh61r/CEZnkNCXZ/KNps6k4t2S0A3jlr1bF3EB76fMXEXEuQSyE8SlpPCmGL48OdQnBxz+Rfj3CW7iSbxbRIGlLCrwS1uKzEnA8OHUZB583RxcjySoNDW/As1rxIjvPOWMlMrhOV2uTDC6sBnzvjrOtJGwOBNaQ3fBZ2zTYa0+AG26V4BYPhqvR5e7oqaQ5/2/NJprgyBb1dQt5MwL/FqFI/QONodA50LEMjxsGL0V8/iXnHsMlb/dAyv0h453GdtCu3jlsWMxxVLR/oX29dZpShv6DgMRidOiQ5H/DX4FlJbbL902cPlGXrUhoZ6Q+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjVNpk0BfecPDx3nQyr9Oa3U4nUm/ZlS09CrQT7Zjw=;
 b=Jqzt+ExMALYrY3U3N4tZFZkc1kPLPNIb8Z+Nv1hWPWj+YlItO8ckS+mSC54clT6NRpzxuyuqzBYRF0kcnEpg7CjcDijXE4LwSHab7dCQeu6uL7KyglX46CPoUEn+NGxT9AHcMFvTnFq0ZOe9Qr+ehjeA+HaBwfq5eHYKW97prkJGK8bUXhEv3gS3tBBQAwUBUh4aNiFnkud6XcxG273FTJVJX9kOYviQUN98LBRAhEyHpLlfg0a2H4HfYi01fCOGuiPwmB6QwItTCpq/tVhPkYIjwsAN0tOQgUuS82uUuY9JnRgLHUxs9glq8M76Y8uHBV8sNElgI7Q1Ce8e++vOTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmjVNpk0BfecPDx3nQyr9Oa3U4nUm/ZlS09CrQT7Zjw=;
 b=aVsxosk04C02EvB67q7xXktoAevQ0VUQ13WHA1AChc3EHEk4kiP/AqkYuD3jgUJMgrcU45Z5r7lAX79aQUjxMxqw6ZWJtwCd4EueT4KNfdHT2y+wJR8DuXanpdl/b7Oix0z4uFzm1xXDNNFqshd70oRAeG4tHDtobubRpnXjmAY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1600.namprd12.prod.outlook.com (2603:10b6:301:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 13:46:00 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::5094:3a69:806f:8a28%5]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 13:46:00 +0000
Date:   Thu, 15 Apr 2021 21:45:28 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     xufuhai <xufuhai1992@gmail.com>
Cc:     Thomas Renninger <trenn@suse.com>, linux@dominikbrodowski.net,
        sherry.hurwitz@amd.com, linux-pm@vger.kernel.org,
        xufuhai <xufuhai@kuaishou.com>, lishujin@kuaishou.com
Subject: Re: [PATCH v2 2/2] cpupower: fix amd cpu (family >= 0x17) active
 state issue
Message-ID: <20210415134528.GA2671822@hr-amd>
References: <20210324082838.41462-1-xufuhai1992@gmail.com>
 <20210324082838.41462-2-xufuhai1992@gmail.com>
 <1717786.6COvnHc5Zm@c100>
 <20df509c-5a2d-3bfc-f08f-142b18c896ed@gmail.com>
 <6de2b9d1-435d-99a2-c733-4f49483f8f57@gmail.com>
 <79f26f6b-f9f8-36ac-6f43-6329935ba9e4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79f26f6b-f9f8-36ac-6f43-6329935ba9e4@gmail.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::28) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by HK2P15301CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.1 via Frontend Transport; Thu, 15 Apr 2021 13:45:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3baf2ca-b214-4fc6-7c80-08d90014cd9b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1600:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16009FA573121F267010D5E8EC4D9@MWHPR12MB1600.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itOR3Z45hnXpw4brHiMSHVnnRakfCMkf3DCAZPIhYDuAkGhUX4FZXlUg1G1rSkxcbO6NYgSsuCaUNMqwTpeLjgQxg3S+gPC/5LOQ/Oej2TwiCf5XYyvdhx0ocCdEcboYQjwxe3hXuk3ywKkp1cDbKYodJVIG+L/yqUE3MaFiKVAS8bWGXkVAFRZh7aStrXjOskYaoQqvCsk118QiLCudU7jKW5wA/tycfSeuFpUcMTz3OdZTWxPxD7fvvcgCa9cY46kf1YyIoYmXx2LSWsyhZhTQ1SIvoLqXuG1nK9cpcA8aCkqw6F3YfR3TK2xf2VB6KE/1CYQ1dgr8tD5ahXvtm46N4J0DoMrXNA+w/BrVWn1sq4kIr/CliPAe4gA2tbRvdbW2l9mfX9vJYgmiM24RPlIzBO1B257M6flT9CQHtD4x5WDE+f/KL7YNbwu+25MjpfPUKoS3GLHZJjYHEAb0UFAQgV05/Xgcs2DpxKe/OH6wM64fi7tZXdMcoU0HjWNtRePJNIlVT6rZW4+VN22mG2tPUkOQBXj0CEDhO04WutyEvioTsYIWQJ2lH1BDGjPKqvh93nO79wDOkvCvFRYS/h79D8nRInLUX1Y0AiHQJ8VixSGI5LgVA34naMZlyxeyoSy4vfPMMf6RBlyas0JsAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(66574015)(4326008)(33656002)(5660300002)(478600001)(38350700002)(38100700002)(52116002)(33716001)(6496006)(1076003)(6666004)(8676002)(66476007)(83380400001)(316002)(66946007)(54906003)(8936002)(9686003)(6916009)(86362001)(16526019)(26005)(186003)(66556008)(55016002)(2906002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TVhTbnA5SHdzZUsrNzZsc0d5c3BxVkhpVUl4bFpLQzhvR3hiMVR1RmFzY3Zk?=
 =?utf-8?B?M1EySHpjQ3dBWFIybGlPdU9Ga0cxWVIzdXV3NFZ1d0ZNVmpCWDRFV2o0SzJy?=
 =?utf-8?B?UEJGVUpOS1pRZk9TU01OMDloUUZiMUozUWlacUFrTk9EaTVjWlF2d3JOVTl2?=
 =?utf-8?B?M04wZHdqUGJFR2NsVnlOYmhmUi9GeENwVk1JVmxCOHAwcktBTCt1M2h4MHB4?=
 =?utf-8?B?TXh4bW5iTGI5SmpseVlBOG1NWW1EUFZYQkxSRUUvWmdWcXl4ck5hbHlzTW9O?=
 =?utf-8?B?a2JRU05wSWNmSFZyM0JERmJDNkJJWVNrdjlra3ZuMWdadVNLOXIyVkx6MEU0?=
 =?utf-8?B?OVIvU0JrYXhTeW9lVnNKbzB3SVluN2NhZ1lhZWxNbnY0Q0dDQUtPQ1JwcUpx?=
 =?utf-8?B?NFpZMnFyTS9melpabU0zWmNFbGdtcFJ6WE5UZDZsMUtiOEJsNXhjWmRxbk9t?=
 =?utf-8?B?c0hXM1dxcFMrS3JQM215ekVtUHdRVVNtbm1FZTk5c21VdW52L01KSE5MamtJ?=
 =?utf-8?B?S3Z3OG90M1RJa1hBZk9JUGZBRzZQMTFuaEl3Sm1qT0VoSEZnUkVuWDgvZTdW?=
 =?utf-8?B?Y3gydFA4a252bUEyUnZ0WlhxK01FRlFUaDR1Ym1RT2ZMUFo1bFE3OGRIaGpv?=
 =?utf-8?B?L05OcHVlOVhhcFBhMXlzVGJxR2ZHYU5TcmRoVWhjcG81MCtIbDhvSDdpTU1Q?=
 =?utf-8?B?aTBnMW9DUGRxdkIwdnhYWWhacDhpbHdDeW8vRzV3STYwTUdaZlJTTEFqK01F?=
 =?utf-8?B?ZkZLdkVmZlBFUldZTEp6bG5oM2prcU1MOWs2Um5nNnpnUG1hRzdnbkUwU2tw?=
 =?utf-8?B?eStqT2FBVzVVM2dmRy9QeHVXT2Jyamw2eWpHNUU5SGNnYVRLdHRyM2dhN1hz?=
 =?utf-8?B?QVdqWDdWRlZFc2tHcmFhNDZ6a3cxb2hUYWthWWdVR2NiaUpwV1JPQW5VZ2pK?=
 =?utf-8?B?bG5WQnNqUzdmb2R6NWE5RWFRZC8ydXVpVmRjcmxzUTMyeUM4WVgwazhTaldy?=
 =?utf-8?B?Sk9qSnJpVE0rOHpDOGFZQjh0UVl2TWVUcmVtL1RMS0JnTWpFL3Z3d0hyV2pm?=
 =?utf-8?B?ZExLU0ZUV0NpTE81Rkd1MXhTVGdNTk5KWjdXajJGV1BKek5PZHNIdjhnbDk5?=
 =?utf-8?B?eFd3ZXNlbldqZEpHNEh0NGlzaEdjb0RqcXc5RS9xcjZSN3NVaDY0UUtoN2pH?=
 =?utf-8?B?TkhtY2xCMk5DNGdQN2lTNGZBTTlVQnVJNWRsWVZtRUZmUFZvcXBuZ0FmUzRk?=
 =?utf-8?B?OXpsOXBVd1EyS2thcGx4Lys1dFpHMHUvZkNpNFp1V0pWVVdQRTdRUlNZeFNM?=
 =?utf-8?B?SnRYdDA0SkgvUk9UdldjbTZTM0FMa1cwL2pOVW5TM1FWRVdTdDlmVlpKRiti?=
 =?utf-8?B?YWh2amlXY21BL0huZHZnY1FjM1VmM2hjN2JXS3NxZU9HY2FjQjNRUUR0TldD?=
 =?utf-8?B?TjVTN0duQi8rSmh6SlZsVFdWMGFjUWwvNFg1T2d1WWVTalVEcG52VTVkV1Zm?=
 =?utf-8?B?OUI1czQrcE1JV1R0REp5WXFsZnQvWURONlVXNkN4bWdoUzIyc1grU052SnM2?=
 =?utf-8?B?Vko5YkRPUXUrQXNmcjErdVZBN1RYQlhSZ0Zzc2xpZmpUYkxrUzNsSGRzb2ZK?=
 =?utf-8?B?dWNucHA3bFFQcXlwMWtnK29kQ1pya3NoQnBrSFBNQnorWmJ1N0JtMHFlcGp2?=
 =?utf-8?B?VWJWcXdCcHR6ZWxlckVUb3lQT3BmS1ptVEtkVzY1VUVZYW1RQVBsWTJoWU5x?=
 =?utf-8?Q?2pZpF0UQ44+KD3/HxJb8+O5VQORYAb9ASZWMkwW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3baf2ca-b214-4fc6-7c80-08d90014cd9b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 13:46:00.2119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lZ1oJyAVJwNjiEnqToGhOPvItuVBRZpPWAvSymMcLUJUQ+efDGqslcA1I15yVno0i08DWiZMFTHKgtPq9agB8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1600
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Apr 15, 2021 at 03:02:54PM +0800, xufuhai wrote:
> From: xufuhai <xufuhai@kuaishou.com>
> 
> If the read_msr function is executed by a non-root user, the function returns 
> -1, which means that there is no permission to access /dev/cpu/%d/msr, but 
> cpufreq_has_boost_support should also return -1 immediately, and should not
> follow the original logic to return 0, which will cause amd The cpupower tool
> returns the boost active state as 0.
> 
> Reproduce procedure:
>         cpupower frequency-info
> 
> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
> Signed-off-by: lishujin <lishujin@kuaishou.com>
> Reviewed-by: Thomas Renninger <trenn@suse.com>
> ---
>  tools/power/cpupower/utils/helpers/misc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> index fc6e34511721..565f8c414396 100644
> --- a/tools/power/cpupower/utils/helpers/misc.c
> +++ b/tools/power/cpupower/utils/helpers/misc.c
> @@ -16,7 +16,7 @@
>  int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>                         int *states)
>  {
> -       int ret;
> +       int ret = 0;
>         unsigned long long val;
> 
>         *support = *active = *states = 0;
> @@ -30,18 +30,21 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
>                  */
> 
>                 if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
> -                       if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
> +                       /*
> +                        * no permission to access /dev/cpu/%d/msr, return -1 immediately,
> +                        * and should not follow the original logic to return 0
> +                        */

Looks good for me as well.

Acked-by: Huang Rui <ray.huang@amd.com>

> +                       ret = read_msr(cpu, MSR_AMD_HWCR, &val);
> +                       if (!ret) {
>                                 if (!(val & CPUPOWER_AMD_CPBDIS))
>                                         *active = 1;
>                         }
>                 } else {
>                         ret = amd_pci_get_num_boost_states(active, states);
> -                       if (ret)
> -                               return ret;
>                 }
>         } else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
>                 *support = *active = 1;
> -       return 0;
> +       return ret;
>  }
> 
> 在 2021/4/8 上午10:21, xufuhai 写道:
> > Any reply? Thomas
> > 
> > 在 2021/3/30 上午10:46, xufuhai 写道:
> >> Thanks for your review, Thomas～
> >> as you suggested, I have updated my patch as your advice.
> >> Please help me review the patch again. thanks
> >>
> >>
> >> ----------------------------------------------------------------------------------------------------
> >>
> >> From: xufuhai <xufuhai@kuaishou.com>
> >>
> >> If the read_msr function is executed by a non-root user, the function returns 
> >> -1, which means that there is no permission to access /dev/cpu/%d/msr, but 
> >> cpufreq_has_boost_support should also return -1 immediately, and should not
> >> follow the original logic to return 0, which will cause amd The cpupower tool
> >> returns the boost active state as 0.
> >>
> >> Reproduce procedure:
> >>         cpupower frequency-info
> >>
> >> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> >> Signed-off-by: chenguanqiao <chenguanqiao@kuaishou.com>
> >> Signed-off-by: lishujin <lishujin@kuaishou.com>
> >> Reviewed-by: Thomas Renninger <trenn@suse.com>
> >> ---
> >>  tools/power/cpupower/utils/helpers/misc.c | 13 ++++++++-----
> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/tools/power/cpupower/utils/helpers/misc.c b/tools/power/cpupower/utils/helpers/misc.c
> >> index fc6e34511721..565f8c414396 100644
> >> --- a/tools/power/cpupower/utils/helpers/misc.c
> >> +++ b/tools/power/cpupower/utils/helpers/misc.c
> >> @@ -16,7 +16,7 @@
> >>  int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
> >>                         int *states)
> >>  {
> >> -       int ret;
> >> +       int ret = 0;
> >>         unsigned long long val;
> >>
> >>         *support = *active = *states = 0;
> >> @@ -30,18 +30,21 @@ int cpufreq_has_boost_support(unsigned int cpu, int *support, int *active,
> >>                  */
> >>
> >>                 if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
> >> -                       if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
> >> +                       /*
> >> +                        * no permission to access /dev/cpu/%d/msr, return -1 immediately,
> >> +                        * and should not follow the original logic to return 0
> >> +                        */
> >> +                       ret = read_msr(cpu, MSR_AMD_HWCR, &val);
> >> +                       if (!ret) {
> >>                                 if (!(val & CPUPOWER_AMD_CPBDIS))
> >>                                         *active = 1;
> >>                         }
> >>                 } else {
> >>                         ret = amd_pci_get_num_boost_states(active, states);
> >> -                       if (ret)
> >> -                               return ret;
> >>                 }
> >>         } else if (cpupower_cpu_info.caps & CPUPOWER_CAP_INTEL_IDA)
> >>                 *support = *active = 1;
> >> -       return 0;
> >> +       return ret;
> >>  }
> >>
> >>  int cpupower_intel_get_perf_bias(unsigned int cpu)
> >> --
> >> 2.24.3 (Apple Git-128)
> >>
> >> 在 2021/3/29 下午6:58, Thomas Renninger 写道:
> >>> Hi,
> >>>
> >>> Am Mittwoch, 24. März 2021, 09:28:38 CEST schrieb xufuhai:
> >>>> From: xufuhai <xufuhai@kuaishou.com>
> >>>>
> >>>> If the read_msr function is executed by a non-root user, the function
> >>>> returns -1, which means that there is no permission to access
> >>>> /dev/cpu/%d/msr, but cpufreq_has_boost_support should also return -1
> >>>> immediately, and should not follow the original logic to return 0, which
> >>>> will cause amd The cpupower tool returns the turbo active status as 0.
> >>>
> >>> Yes, this seem to be buggy.
> >>> Can you clean this up a bit more, please:
> >>>
> >>>> Reproduce procedure:
> >>>>         cpupower frequency-info
> >>>>
> >>>> Signed-off-by: xufuhai <xufuhai@kuaishou.com>
> >>>> ---
> >>>>  tools/power/cpupower/utils/helpers/misc.c | 9 +++++++--
> >>>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/tools/power/cpupower/utils/helpers/misc.c
> >>>> b/tools/power/cpupower/utils/helpers/misc.c index
> >>>> fc6e34511721..be96f9ce18eb 100644
> >>>> --- a/tools/power/cpupower/utils/helpers/misc.c
> >>>> +++ b/tools/power/cpupower/utils/helpers/misc.c
> >>>> @@ -30,10 +30,15 @@ int cpufreq_has_boost_support(unsigned int cpu, int
> >>>> *support, int *active, */
> >>>>
> >>>>  		if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_CPB_MSR) {
> >>>> -			if (!read_msr(cpu, MSR_AMD_HWCR, &val)) {
> >>>> +			ret = read_msr(cpu, MSR_AMD_HWCR, &val);
> >>>> +			if (!ret) {
> >>> ret should be initialized. I would initialize it with -1, but as Intel case
> >>> is always "good"/zero, it may make sense here to set:
> >>>
> >>> ret = 0
> >>> at the beginning of the func already.
> >>> At the end of the func, unconditionally returning zero:
> >>>         return 0;
> >>> should be replace by:
> >>>         return ret;
> >>>
> >>>>  				if (!(val & CPUPOWER_AMD_CPBDIS))
> >>>>  					*active = 1;
> >>>> -			}
> >>>> +			} else
> >>>> +				/* no permission to access /dev/cpu/%d/msr, return -1 immediately,
> >>>> +				 * and should not follow the original logic to return 0
> >>>> +				 */
> >>>> +				return ret;
> >>>
> >>> Then this part is not needed anymore, right?
> >>> Still the comment would be nice to show up, maybe slightly modified
> >>> in the if condition?
> >>> Afaik 100% correct comment would be:
> >>> /* ... */
> >>> for one line comment and:
> >>> /*
> >>> * ...
> >>> * ...
> >>> */
> >>> for multiline comment (one more line..).
> >>>
> >>>>  		} else {
> >>>>  			ret = amd_pci_get_num_boost_states(active, states);
> >>>>  			if (ret)
> >>> and these 2 lines can vanish as well at this point:
> >>>                         if (ret)
> >>>                                 return ret;
> >>>
> >>> What do you think?
> >>>
> >>> Thanks for spotting this,
> >>>
> >>>           Thomas
> >>>
> >>>
