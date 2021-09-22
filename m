Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17CE441402F
	for <lists+linux-pm@lfdr.de>; Wed, 22 Sep 2021 05:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhIVDvw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Sep 2021 23:51:52 -0400
Received: from mail-bn7nam10on2089.outbound.protection.outlook.com ([40.107.92.89]:6913
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230054AbhIVDvv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Sep 2021 23:51:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjMv1YebY3xg2t8n70gFMepes4HM2P3aPFgMPaU9VYXqqEUZMk3ACH74XcWRnre/PI8zb3xD/6F0lnKG7CrJVnMrW6GLNhEVaM+IDQzomU0L0Yd8jvqrx7PZ5+7KjxUL34EjH7cjH8f6h+JOsbbjtUDfK4LV9RdTrzZoIWJ4FZo0ESdj0edbkj+PbBRMW1dv6rgJiB9nmh1FlofqdnC8BkAkokkdzQ1jYvlkGtgK6uAW/GoaGPKv8Dijlv12xbCrsSo7du7ocqYJeRtfNVO/+XWJpWP81Py8sFZst0pvxQCJyX0ccMvac5rIF9w1LpnWNaJcxHrf/vH4kCMYDtGa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+b2LBAzQjTzsWZU2MNThnhHpTBVWzvgGZtvIlI7GlYQ=;
 b=FW4iFkiRNbsGm64gqN6RYdWhBRF16QTwxAmI+2NoKh5ajpAdknkeM1N+3Noiw8skKvfOLdkRNDaZmapH309KiL1QzRUSOTw0lHT7aBDAny4AP2Qf5eJ7kFQuq+ZJnLnnA+K9PV0ZO0aXuMl9iy2DKuJwb+GEg8ugixPFsGmA9obsnsfXMb0khVfS8u+m3hUlwJ28YIeXrfZs4t9ExWPpwrRuyLpwJRfBlTlkClcORcw8lRed0I1vMpbKLryOxhRiYwzovF/lXFbdPcf/cmXArl9IshiGCALa99b9Cyw1c5O5rMG8h22/jgQlI0I7tWFMUhSWI03kUvJEOpyokndyJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b2LBAzQjTzsWZU2MNThnhHpTBVWzvgGZtvIlI7GlYQ=;
 b=TsGQLL9zJahsEqbxTiRLvuKqV/7LsyYD6zX4Kc6IBqB42DQei7uuT8Y6tca1fwO8/U8jEW9Y7B0fKAOTJG57b/3y3jKOMwfyqmSYePdm1+nV2DDFGQGoEVa4mb9tGekId8qhHAW1SVfGbkXnYTYsVw6OUH8X6xyaWIrWONspPBs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 by BYAPR12MB2775.namprd12.prod.outlook.com (2603:10b6:a03:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Wed, 22 Sep
 2021 03:50:15 +0000
Received: from BY5PR12MB4177.namprd12.prod.outlook.com
 ([fe80::b99c:d841:a12b:6f95]) by BY5PR12MB4177.namprd12.prod.outlook.com
 ([fe80::b99c:d841:a12b:6f95%6]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 03:50:15 +0000
Message-ID: <a20fc6ba-14fa-e9b9-de69-54b9eaf20e73@amd.com>
Date:   Tue, 21 Sep 2021 20:50:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] x86/ACPI/State: Optimize C3 entry on AMD CPUs
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20210819004305.20203-1-deepak.sharma@amd.com>
 <CAJZ5v0jWX=H=aZ25PzHdH05bRJvtYbGHfyTgH_68k4kfYkZc5A@mail.gmail.com>
 <951c4f8f-30ee-77d3-afb7-46e45c84213d@amd.com>
 <CAJZ5v0ic+0MKDbebrxnyxr=rRJbqP4LmB4g1fVVAVJWh98e=MA@mail.gmail.com>
From:   "Sharma, Deepak" <deesharm@amd.com>
In-Reply-To: <CAJZ5v0ic+0MKDbebrxnyxr=rRJbqP4LmB4g1fVVAVJWh98e=MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:a03:60::47) To BY5PR12MB4177.namprd12.prod.outlook.com
 (2603:10b6:a03:201::14)
MIME-Version: 1.0
Received: from [172.31.21.22] (165.204.53.104) by BYAPR07CA0070.namprd07.prod.outlook.com (2603:10b6:a03:60::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 03:50:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 753a3182-4ccc-4cc2-a6a3-08d97d7c15e0
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2775331C2F6AEFCCA4E7BC88E9A29@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BokOdLcr1KwZElWXx4WOzntQX/MBRLi0LNtxaoanwPIbTw6Y9acwhUTR5qp7C+v3qQpefCIzJZqydtQyFLGNh6i/Jz0TDIPg65zblPJGNV8Ppeb/jYXa6Aw7TTEcYVSwH2lSchB5hQgLLK/rOz161cDg7YTqS+UeoRzqbgaXM5XQPfg8GyZhkHlD8JlQLA7ek0lsMlYbV5eFsVeEp0GeESRtuk7NU/Q8vDBoUHujgIrljzODaY64XvmCvEOsh2s+Nxyl0gPP0Cdq0JgqI7Gk/WHguVLAc8SyzFmJDGRNAOoJBgKOGFbWe1os4/t9B8BHRtimPGIt8l+IV4BbwTsT0ULSIFEGwjm9BqAaWg5Fd7IvHJPDudO7mudv664eo8QBNthh2XEamUnJSN5zRt8aN8GS3fn0XyDH30L8bnYXM/xtnhvwEgcQUqEUobBuLUbjPmk89EqRAu4sE9rkpFHHTlmPVOlX1xwMumo9XftJ3lApE1KIArzK1ZQ2/EMxKxGBRBfcORcSvzmo3QJgcCiRslu5v9no7+S5gZCM2DVgv7tYzmz641w+i1JMA3mjWcdZnktVY62Ja7Whna/+iz4HDJkTHJCOpD18yhqgwmhSpLs9iTiwWNmCwp2nnPQLONr3Z+06ibxfvqDiBaYYaxs1DzeXW7ag+vz3H3FKdsxdd9rz2lMrfZOOPFtlDv+wuClh5BbgUbxwgKMCDO59NHto954FZnI9l3R88fN9Xo//isQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4177.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(36756003)(316002)(66556008)(16576012)(4326008)(956004)(26005)(186003)(2616005)(38100700002)(8936002)(31696002)(5660300002)(2906002)(6916009)(8676002)(7416002)(53546011)(31686004)(6486002)(54906003)(66946007)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEhtZ0hEdDE1Y2ZBWVdkT2pTazEveHByNUJmVXpZekhYaVZyVEtCdVYxV3pz?=
 =?utf-8?B?TVF6ZC9RdUp3S016eXRFRHNzU2l2TTBXNHdhNXhFMFBmZW1Bd3JaTElNalhI?=
 =?utf-8?B?RVhlRkZtdHhTTHk5b0FYcHN4ekxBTzZILzR5L1hmaGRpZlZMVG04Z0huRkNF?=
 =?utf-8?B?NCtUV1A5VWtyemFoMlgxZU1yTVNlNkU5MXRiNmNoemNjT3VyN2NBRTN6U2VR?=
 =?utf-8?B?NC9mOHI0ai9vQUNUY1FhK0VacGxDTGVvOS9vRjUyQUR0U3hpR1UrVjVJSDI4?=
 =?utf-8?B?bzdUa0JNck9BY2hpaDBBYW16RU1zc3lFaXlXNThsOW83RUVXdjVsQ0svUjg2?=
 =?utf-8?B?WmJyTSthR3lHYmdCdmZQUnBZdlcrdXZCZXNEU2hjbWZvUHV5Z0xLc29iUFhm?=
 =?utf-8?B?WFlFdk90SC9Beko4MGcrSFZwSVViczdxUkwrekpmaVpmbnJsaHVFaXFia054?=
 =?utf-8?B?UEJJYWRUREpCUXlrNW9tZ1MwUEpxYk5jUVVrN21rUFZIQzFNZ0k4WVpyaTVp?=
 =?utf-8?B?MWVZR2twdFpmVEtFckdjVHdGTEpqb2FXbkgvcFpJcFRQYjVLdnNRVkhDVyt0?=
 =?utf-8?B?V2N5RW5Qa3pLd3BHT1cxdDRtNzhKRzI0b2Y5MGFISkJTdkxscHVjYjJxTERG?=
 =?utf-8?B?ajVSMktubTE3MmVwUFhKM2pJOWJLNi8vTE9BVDRPZEdPVVM0bXhZUDRZRU1X?=
 =?utf-8?B?N2VUem8zS0tIKzluNXl0RWVWNUhvbGg3VEZwYlh1QTJ6QnhVcGYweWtSVWgy?=
 =?utf-8?B?c0V3aUo4RjlCSVlTeC9vVHhoQjhQWGtaSXNZeC82eEdheDI0Y1J6dEprNjgz?=
 =?utf-8?B?Y2pOcno4aE4xbk9qazBPSEV0OXFyd0VFZGo1YlpIaW40K3ZUL1BBVnVNN2F6?=
 =?utf-8?B?Y1lQTmxaQzJIQ0RGcGNIamxhbytCTkowald3ZUI1Y3I4RzRtbFpocnpqZksr?=
 =?utf-8?B?SXo0ZzhKaDlPZDU4VnBnWmFzbEx2WjR3emQxQUdyaExQWE41YTMyWmlaNEdD?=
 =?utf-8?B?bVk2dVYrQ0hqRnJMckxScjVuajh0emVxZDg5Tk16M0dWT0dVOWFHOXFyeE5W?=
 =?utf-8?B?NDFSM2h4QmhFL3g2VklyRFVpdzNmUFpuMDZsREt4QUpLY2FIOWV6WGsyWjV1?=
 =?utf-8?B?VjR2emNlMEtMR25nUnc5WFJqUmlvVktMSDFPUWVCb2NVcE5xWW92WHE5K2Rr?=
 =?utf-8?B?V2EvdHc1S01kZlRtYmZqT0JKaDFiSktnOUFycjNrVkJmTmI1UDZkZ3hVcnBQ?=
 =?utf-8?B?TUNVbGozdldwNURld3ZWU3A2SEVIdUZFUXZQYndjSGdpK3Niamk5dThNNXRT?=
 =?utf-8?B?RTlIRkQwd3ZubWV3UUh2MG16M3FoZ2FxTmdiTlVNM2VIeEY4eFptRmgzQVdV?=
 =?utf-8?B?T2xFbGpwWDc1dWVOcU82bG8wNWJ1bGdwRFdSejBpQTg5K3hIVVp0dnJFU0s4?=
 =?utf-8?B?Skh2cXFVVUU3QkVuSE54U2lSdHZGVGh5TFJ0azZlTmZ4VDFCS1hlZlBuYWVB?=
 =?utf-8?B?RTVFMzNqN1NGMFVTeDNkdEFJSDFnM05ERVlVZ0FQMFNFVjMzVGplbGMvc1oy?=
 =?utf-8?B?djJjYy9QZ1BHemEwMTFubUVad3VLMFRkVkt2UmkyRnUzUzVHZ3FMenlzV280?=
 =?utf-8?B?RDdxZDRQcTNSa0M0Q2JsYjNxbUkvY0h4NmhOSDNmazk4azVsNlJiM05aS1hz?=
 =?utf-8?B?NlhGbnVka0JtSXhmS3cvWHFYZ3o4Mng4NXl2dnpuYm4zOUZvZkRJWHRLWWpY?=
 =?utf-8?Q?mpautK3AqvP4Pq82rYhfjLSzpNdST5w3kN7i/Vi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 753a3182-4ccc-4cc2-a6a3-08d97d7c15e0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4177.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 03:50:15.3862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t06ouw+hBQervS7O76OG+Wi9n6pDhDBMVSA4PiSslludwV2kE61SNCkz0QtfNpAvu9SQ8Q4ixYkqC7SDDOWKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On 9/1/2021 5:45 AM, Rafael J. Wysocki wrote:
> On Wed, Sep 1, 2021 at 4:14 AM Deepak Sharma <deesharm@amd.com> wrote:
>>
>> On 8/25/21 11:07 AM, Rafael J. Wysocki wrote:
>>> On Thu, Aug 19, 2021 at 2:43 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
>>>> AMD CPU which support C3 shares cache. Its not necessary to flush the
>>>> caches in software before entering C3. This will cause performance drop
>>>> for the cores which share some caches. ARB_DIS is not used with current
>>>> AMD C state implementation. So set related flags correctly.
>>>>
>>>> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
>>> Applied as 5.15 material under the edited subject "x86: ACPI: cstate:
>>> Optimize C3 entry on AMD CPUs", thanks!
>> I might need to send subsequent patch for this. Can you please point me
>> to git and branch where this has been merged.
> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next

Still I am not able to see this patch merged on linux-next branch.

Thanks,

Deepak

>>>> ---
>>>>    arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
>>>>    1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
>>>> index 7de599eba7f0..62a5986d625a 100644
>>>> --- a/arch/x86/kernel/acpi/cstate.c
>>>> +++ b/arch/x86/kernel/acpi/cstate.c
>>>> @@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>>>>                    */
>>>>                   flags->bm_control = 0;
>>>>           }
>>>> +       if (c->x86_vendor == X86_VENDOR_AMD) {
>>>> +               /*
>>>> +                * For all AMD CPUs that support C3, caches should not be
>>>> +                * flushed by software while entering C3 type state. Set
>>>> +                * bm->check to 1 so that kernel doesn't need to execute
>>>> +                * cache flush operation.
>>>> +                */
>>>> +               flags->bm_check = 1;
>>>> +               /*
>>>> +                * In current AMD C state implementation ARB_DIS is no longer
>>>> +                * used. So set bm_control to zero to indicate ARB_DIS is not
>>>> +                * required while entering C3 type state.
>>>> +                */
>>>> +               flags->bm_control = 0;
>>>> +       }
>>>>    }
>>>>    EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
>>>>
>>>> --
>>>> 2.25.1
>>>>
