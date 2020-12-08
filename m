Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E42D218F
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 04:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgLHDpj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 22:45:39 -0500
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:53632
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbgLHDpi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Dec 2020 22:45:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUNEe5eIZdwn0wELo6dRayy26m6Fk9dBWpI0JerQPQY/hrbUlE++u3/4RXcUVmxeBxBt/ee1PP+bI/FZW3WThEeoM9wecQvvUVi2sHpkN7NaM7gB+W3Pi0kjPFMkUKjtkFG9CM0mbbsJ6n+kbzZAcEJI8/TceszFWUONtO0oyvmgR5Ae7Snc4W30ZQT6gwzB443Rf+U/yjnUuhRxZ33NZsHBwZiE5IgA/UBlqzr/QwPnWPpcLYwEi5R8ECeWhergh4LZlbRk6Uz9g693nRQwb/nAWYeKug+KkjJCMjRICYEwM4C9qaAG03rl0BY+VlY3XZCMfn29klMyNvtD/wISQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG0WBYs3R4qpDLgPnVy+eEm/SltcUCRYSDfMCAj1CWU=;
 b=Xb6qeyKCRvuBRJxcK/fJRo4hwGwJ8HuEMsDDpbDJUaQXG+i87lUWEqIRq6rI073EuL/Z+8zCCAvWo3v2Nr5DQXnuVMFv8CtKZZ6VvQWfCyWWAkSpgcW3oirmQZF05bgjUNHJlxulQ+J1sHBLYCBm01Fw/c5DKTlvngusrgOqcGDjw6zYv7QdetWzn2LDdVt7qt/ib8BSZ3hdRqhlgOpirivf0RkJdqk5pCxzcYtRuMO5R1NwodtU6+fpX7FLiokep87ZMtRfmjrC1T8XibgUXPiJLf7M7/yMEomf4ET6ofp05L2x8Yk7ldBUo+nXa2eaz9x8KbvsYcj5BeZCqsmq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nG0WBYs3R4qpDLgPnVy+eEm/SltcUCRYSDfMCAj1CWU=;
 b=xi0vkPt/BYMBALp7d6pUI2B2YuQj7Lo6bbpnwJDqjVHm/V/McxCUHQ+pSBS4i3O9vrESajISyyfQK66MM36NBeu7do3kMVPSc+4JbwPKdiKott6Nb9ajJIo/3ZEy/p5cErt802NyxMbKFyy2qjF4rmZahHhnLDbKrXtGFuGZOMw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB2487.namprd12.prod.outlook.com (2603:10b6:903:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Tue, 8 Dec
 2020 03:44:46 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818%6]) with mapi id 15.20.3632.017; Tue, 8 Dec 2020
 03:44:45 +0000
Subject: Re: [RFC PATCH 2/4] cpufreq: acpi-cpufreq: Add processor to the
 ignore PSD override list
To:     Borislav Petkov <bp@alien8.de>
Cc:     Punit Agrawal <punitagrawal@gmail.com>, rjw@rjwysocki.net,
        wei.huang2@amd.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, x86@kernel.org
References: <20201125144847.3920-1-punitagrawal@gmail.com>
 <20201125144847.3920-3-punitagrawal@gmail.com>
 <cadb5d57-5aaf-79bc-e30e-502d5e522689@amd.com>
 <20201207202610.GG20489@zn.tnic>
 <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
 <20201207223057.GJ20489@zn.tnic>
From:   Wei Huang <whuang2@amd.com>
Message-ID: <8260faca-4a0d-8e06-c5ba-3ecdd0619e2f@amd.com>
Date:   Mon, 7 Dec 2020 21:44:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201207223057.GJ20489@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: CH2PR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:610:20::30) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.205] (165.204.77.11) by CH2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:20::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend Transport; Tue, 8 Dec 2020 03:44:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e25205b-3c26-4291-7b15-08d89b2b9b06
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2487:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2487A748FB4570067C60ABE8CFCD0@CY4PR1201MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eEtWqKi5YTzz39nFRuzCAtHRsEDHk5OpxwDaqr7j9TXc8lrXPy3yob68M0y1QqOtybb6g6ZlzAlkRVL0ZF3Q0aiKMhPERgWeQXi1t9rtIkbgVikApIJbh0flbzU6PX+/f3RNRjyMdH+/8LopbpLEo2SyBvaSm9pB2j/ThWzBs+l+t17eCvWxg1BsEJz8WEFUIZQr6DApu4C6LqyEr4O1sDYd64iKpSjAQb9x6Uj6EaDlQEqJHxYuGWBkjdFCe0tgimKZZpuctlOSmkRBFrJgwI5Ww50KnQd+NLmgOUcQqhaRtq8zyMyBmcHFYehv9/ImfFX0FdfYPAAmjLDGB9Zu4dAcSNmCAT8VnXHVgrR41yS0jeXElZ82KBf6iV33icbjVcVDfbpP2QmWnBpu/NRMYt0UFe80EnDEkYa6/s3cNQY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(31696002)(4326008)(52116002)(478600001)(2616005)(6916009)(5660300002)(8936002)(16576012)(8676002)(2906002)(31686004)(956004)(186003)(316002)(83380400001)(66946007)(6486002)(66476007)(36756003)(66556008)(16526019)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZlpuREdsMnplQVNEbnhpemhxaDRVa2EvdTJ6eDRQK2U3cHF3dllMNWpTL3lT?=
 =?utf-8?B?VUhja1dEWkZCNjVHMmxOT2dWcUtqWDZSMldsR1hMTlJkSmNNekMzd0tqN3Nn?=
 =?utf-8?B?RE1MZVNmTzhQZGZTNG9VUmFiTTFkV3ZVTHNIRWdYVjhFSTg2RVpxODczRlN0?=
 =?utf-8?B?Sks3ZkhuTldzeitMZmZQWEVRUUJaTW44Q2JzWnBINGc1MGxFeFNxMWJqR2Nq?=
 =?utf-8?B?bEQ5WDlrUGxqK1YySldOZ2grREFmODBIV21OaE5pY1dkOE9wREhGUzVBSUdD?=
 =?utf-8?B?M280SXY1cldENHVEZk9NQXpobnNIeUZjakk2S21uWWFJU3ZTSlJqOENmOWZx?=
 =?utf-8?B?VlIrZlR3Z3hQT0NKWEI4N1I0VUI1Rmhta2pZc3lid1RVWUNjL3IwUjlpaC9y?=
 =?utf-8?B?WnJMeVBrQmVkWjJSTTlBeUs2Mm1ySHJBZ3ArM2RzWDVIY0V0VUkyaVM2bllW?=
 =?utf-8?B?dXdZK1hwQmMwVnRjWkFZbFRlRE1JY2dVK3VDMVBzS1dGWkhVZzhCTE52cEU2?=
 =?utf-8?B?OWJ4K2ZLWGpFbnVtUnB6VHh3Z2NGaG95QlAvWDdwS28wL2RXVlR4WWFyY2lH?=
 =?utf-8?B?WnRrWEdOQXFCQk1FYjJBOHpwRVZyVFZoZGV4UFdNVkZmL0lxWUZLdHgyMHJS?=
 =?utf-8?B?UkQrN3FJbGZVWWQ3SFZNL3U2ZzRKM21lTC9paG42UHFpOEJDL3o2WjNvbVNN?=
 =?utf-8?B?cGFEcU9Mc2NNb1FLTUFwRnlEdWttYWJqOFprR1hyclRTTEJVMVhDMlQ1VFgy?=
 =?utf-8?B?bFdlVC9FZld1Q1ViWC82SEhCUHJVRFNoUEZJZnNhMExTWngraFdxajRYc1Qz?=
 =?utf-8?B?cFpZcC9yVmVtY29YaWVyZEdtWWhnT3A0WlVLR1BOSHVVOWR5NHNCaXFRbmdS?=
 =?utf-8?B?cEFWTlZwR0dYOHRWckw4MFVMSHJNSW8yMnN2dU82SlZoSklqMmR1ZzNHM2F2?=
 =?utf-8?B?emllSklXQVhkVTdVRC9ScFJBZzlHL0ZmZWs1SmdGM2F1Z0FxZVU5OFkveU5r?=
 =?utf-8?B?Y0o0ZzlwclhWbmRwSTZDdG1ZVlptY3crS3NkanREck1qamZLWWxUd0xWNTBY?=
 =?utf-8?B?VkdWS0haaDUxZVRSbHB0VzBGSGt6MDFTdENmaGxqNmExZVJMV29ML0xwR3pr?=
 =?utf-8?B?d0FqYlNJd0dJanJNZkcvbXlvQmM0TWVMY3ZpWlRnWjFZQmlpZ2ZzTDJ2dDFG?=
 =?utf-8?B?bHloazdiN2ZPMEVrTytjckJhM3psWnpocUQzNUhhUE14ZlNCdVZTOXNLN2lT?=
 =?utf-8?B?OTUxbUxHSWJtODJwc0h5bjhCZWczNUhLUklra1BZNjFsNFYrU2dabTBVdlBT?=
 =?utf-8?Q?KtHOqrxImO+62WWRSgEyWAJG7f4wMc7FJ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 03:44:45.8747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e25205b-3c26-4291-7b15-08d89b2b9b06
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GqiydSXEsNVwtd+wW4SWg8xjMrxnVFk7JN81e2x1JtQSHlco2wcaba8Kk72yx8ol
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2487
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/7/20 4:30 PM, Borislav Petkov wrote:
> On Mon, Dec 07, 2020 at 04:07:52PM -0600, Wei Huang wrote:
>> I think we shouldn't override zen2 if _PSD is correct. In my opinion,
>> there are two approaches:
>>
>> * Keep override_acpi_psd()
>> Let us keep the original quirk and override_acpi_psd() function. Over
>> the time, people may want to add new CPUs to override_acpi_psd(). The
>> maintainer may declare that only CPUs >= family 17h will be fixed, to
>> avoid exploding the check-list.
>>
>> * Remove the quirk completely
>> We can completely remove commit acd316248205 ("acpi-cpufreq: Add quirk
>> to disable _PSD usage on all AMD CPUs")? I am not sure what "AMD desktop
>> boards" was referring to in the original commit message of acd316248205.
>> Maybe such machines aren't in use anymore.
> 
> * Third option: do not do anything. Why?

I am fine with this option, unless Punit can prove me that I am wrong,
(i.e. some Zen2 is broken because of acd316248205).

> 
> - Let sleeping dogs lie and leave the workaround acd316248205 for old
> machines.
> 
> - Make a clear cut that the override is not needed from Zen3 on, i.e.,
> your patch
> 
>    5368512abe08 ("acpi-cpufreq: Honor _PSD table setting on new AMD CPUs")
> 
> 
> Punit's commit message reads "...indicates that the override is not
> required for Zen3 onwards, it seems that domain information can be
> trusted even on certain earlier systems."
> 
> That's not nearly a justification in my book to do this on anything < Zen3.
> 
> This way you have a clear cut, you don't need to deal with adding any
> more models to override_acpi_psd() and all is good.
> 
> Unless there's a better reason to skip the override on machines < Zen3
> but I haven't heard any so far...
> 
> Thx.
> 
