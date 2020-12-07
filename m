Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA6E2D1CCD
	for <lists+linux-pm@lfdr.de>; Mon,  7 Dec 2020 23:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgLGWIu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 17:08:50 -0500
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:15936
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgLGWIu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 7 Dec 2020 17:08:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yy69Nray10q0ytir2YPGgdEIYH6UcbOreiZBx4DoqDuhyxTL1P/O5W9vYwOK5tXvkAar1UThZlW2REk4H/axLOlbvsMcqM62c1wd91IpEFs0TYtZWlze/OvugEXa5oj2pK+GW6KX3Wkf89Asd/NOGkVeKb+Vdoh4gMYK5tGZZkjvu/4SvmZINdcmMTu7ajDJjPO6gqCwIFadZrDSg6Xa3Hjue9yOt1Jt2Iflk9KaUwn/C62GfcCMjiRkZ1yo7yo4Yvwuk6UERW+L1u6r24kYD1CVj8KYjQPCp7+8WFjJXA5TcCPj4JChyQ16ut7tGcv2j8TuCUVm6/XLgr6aiJnN/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSnHcfgYeyDhdsB1DwIhSvzrSjMS81d2undBT3hnC08=;
 b=UcqQMT65ncVr3pdUPgTLAM3zW3RWpHQODD9YLPilA/j4E1MnUZa4xXTzYikfgO4gRy69zlWooixWwINY6lU+OrvBRMddlBzgXXem/Qj1Jut3rUB+aFJK2GD0NoiFHuR0XvY2ZPqwMo88ujQ78OV+uC9uKdoBp+o3k7KsKSHHL5DJ6FApJzIozZqIfh0aL7Ug4nADpxaWeyEY93ufSPNbm6Fg+oBpsnScLs+JpQDtKh7d9+aE1D/ffMG0rlbK1it33yjtZYilx0D5zn2qSba/sWww3VjjaGLL4Y9/IiBefilH5wU1VZi/4kFAvIsk/WcoQt/Wns7Mu2Y00uIX0jlfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSnHcfgYeyDhdsB1DwIhSvzrSjMS81d2undBT3hnC08=;
 b=mtJang7hPOGPWW1GV21j1HHZS2xhRpi3VmTrV9GPAgVKyHkoSRakXPre4tAMsPeSq3w/RkNPDLMl6ZzI2k7VrDKbJnNl48XmqeAfjDOOrME1oiL59gh3lV4MZDE48DyGx72/f96t2kUQ35F8wmo1mehnSsLYJ1dQ7vmoGq74Ibo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0149.namprd12.prod.outlook.com (2603:10b6:910:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Mon, 7 Dec
 2020 22:07:56 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::d0ac:8fdb:1968:2818%6]) with mapi id 15.20.3632.017; Mon, 7 Dec 2020
 22:07:56 +0000
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
From:   Wei Huang <whuang2@amd.com>
Message-ID: <e9b4ae11-1fe3-a660-bb65-d3ba55ffcc56@amd.com>
Date:   Mon, 7 Dec 2020 16:07:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20201207202610.GG20489@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA9PR13CA0109.namprd13.prod.outlook.com
 (2603:10b6:806:24::24) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.205] (165.204.77.11) by SA9PR13CA0109.namprd13.prod.outlook.com (2603:10b6:806:24::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.8 via Frontend Transport; Mon, 7 Dec 2020 22:07:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b7fc3e13-417d-49d8-4da6-08d89afc8d4d
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0149:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0149D486F8C6598A55EF3B77CFCE0@CY4PR1201MB0149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qUAIQ8b2tcge17z4K/3NiG3A/cOjOtPXoDmKQwWby82o+te0SSbKD88D0n+7bJxSGabwtPeyIl5cIMY1+OkkrrsfHzGfE8TWC3nRLlhbLUaPzB2A84Y9UjjnRpeY/BEccpd+UIH6Rd+9cGo734jTQkDTSuYom03YiKL3NOBiS8axY9ZP7ja7jVYpyJhxprIG1pplZi9f8XVem6ZKCeel/djWofMfDN7gaF/wS1C4U/QLnAf9GzB7ltAmNj63ljOg7D/4tY/pv0ryztg+eRO8p5KBAsyS9ruDKQTDJuXzDJ1KIVxKWUkClRHRgY0gpjO7gsWivBzcYJVeOwFd4+efyKfvYkz6kYw9HX3K4+7Q1z42v/TxBTFhxjYNnX5vqa2F7y5D9NNthK0jgW1RNxLt1WrQj7d18JodWWPPRyFQQx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(53546011)(2906002)(66556008)(8676002)(4326008)(478600001)(6916009)(8936002)(66476007)(31696002)(31686004)(16526019)(956004)(26005)(36756003)(66946007)(316002)(6486002)(83380400001)(52116002)(5660300002)(186003)(16576012)(2616005)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RE50QWR1RmlGZWdWb0t0dk5rTHBuZnc5WGtlVG1RZStQY2RvcWp1UFBGUkZ4?=
 =?utf-8?B?S01pUnJRYzNGWklpcXhsSEVUdzZqamlHdTFnV2piOXR6UG10RHh0MUp4SmNC?=
 =?utf-8?B?M2VRV2wyVVZMOHZ2dHMyZTYxWTVyNnBNVXRkcjNmWEVnR3U4S1kvcUR6VEhx?=
 =?utf-8?B?b3QxN2VKeE5KaTBXMmhlVWlvcEJ6dW5naTI4UjlVcE50d0JsWG9zaG5zU0FK?=
 =?utf-8?B?Wjdrem9NencxNEk3ZWdEZXFkY1o5MDFwU1ZNNTVBbTYwWXdlaXNMNUdYQndp?=
 =?utf-8?B?QlV2aFlYR0phQVhMWEZmUUJ3Ni9kZmY3bzJueCsyMUtmczB2R0dISThuUWkv?=
 =?utf-8?B?NGQ3V1FINWxMYzUzb2JSOW1ZVjM4SUIwb21wb3I1WnZEaU5iN2lFYmFJVVVU?=
 =?utf-8?B?RUI5dUJ0UmZVejI5WDF5RDFJU1hXbmRzZSs3M0s4OHZzVzhUZlNTOXFWMXl4?=
 =?utf-8?B?M0NXMG5JY2tITFFTSGI4YWpsVlE5NjZYeFZHQlY4enlEVWhpbk93UDgxVHpU?=
 =?utf-8?B?cDhaNTZhUnJBL2l4R1FmYTFaTlZaTlhpb3p3SWZoWjFONWpPcDU2S2Nac1lJ?=
 =?utf-8?B?cUFsMzBQK0xtUUlXSmwzREpNN214c0lRNjdCL1Z4THo3RUtMbXh4UE1yZGNj?=
 =?utf-8?B?eHY1REVjZ09Od3BZRU1JcUc4TmIwTEpKT25EKy9LZVRnRnB0YXoyZmpHV1NZ?=
 =?utf-8?B?cXdNdnJVMFVRdDdINnJKcWwwcVhYWW55aUVZQmU0QVRtQjdOWkpXNTl4eGll?=
 =?utf-8?B?cVdXUG9Qb1BQUmU2WUdJV25xWDgyclgrQ0lDQU1JMUJReVNuWTR0b3VaRVd5?=
 =?utf-8?B?eFQ0UVVCVjBNWVZjOHNMQ3k3ZG1MSzJPMWtnTnFmSThZSmVRL0R5ajZ6Z0g0?=
 =?utf-8?B?RjRublVQWWVVYXZyU3lic2w2dlJJazRhNXpBOUZpRitWUzFXb3lFcVMwR05k?=
 =?utf-8?B?RzJZNzFJZTY0d1RNbHdTWWpkSFNXK1NDUkFRZ3JyV3JDa0J3MXlKc2sxRzZ6?=
 =?utf-8?B?NGZWc0pncytJcTg1RFJUU3Rjem4vR1A1Z3owMGpEMUJnZ2ZwNkJYUzJ1ZjlX?=
 =?utf-8?B?dmlrT3F1SEZ6bjBZNkY0eXFpS09nQ0ZoWGNZR0VWbDZJbHVKR2N3ZCtmaDVy?=
 =?utf-8?B?NEczWEc4YkZ0MnZtb2crYUdUVVRoWFpwbVBPME5KQWczaVRXTEZPaWVjbmhP?=
 =?utf-8?B?TXA3d3VYekJmYjl4YXZLNVpncytNRFVCcVZjbUpCVW1pWG9TU3loaWY5VUtQ?=
 =?utf-8?B?aEQwL0dBcjFFY3dYRzRmZ3dwa2lOdE9WdzRRaGhaUTRoVWp3cEFVYjFhdTJu?=
 =?utf-8?Q?tWAqphH3ypaGyDNFzixDxFwWo0YWpgTCER?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 22:07:56.4635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fc3e13-417d-49d8-4da6-08d89afc8d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ul/dNJuezd9/9f9ISlPr7ksyKoyrju3IBdZkcbi29I00MVwsAyimuOEszGBaTitU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 12/7/20 2:26 PM, Borislav Petkov wrote:
> On Mon, Dec 07, 2020 at 02:20:55PM -0600, Wei Huang wrote:
>> In summary, this patch is fine if Punit already verified it. My only
>> concern is the list can potentially increase over the time, and we will
>> keep coming back to fix override_acpi_psd() function.
> 
> Can the detection be done by looking at those _PSD things instead of
> comparing f/m/s?

Not I am aware of. I don't know the correlation between _PSD
configuration and CPU's f/m/s.

> 
> And, alternatively, what is this fixing?
> 
> So what if some zen2 boxes have correct _PSD objects? Why do they need
> to ignore the override?

I think we shouldn't override zen2 if _PSD is correct. In my opinion,
there are two approaches:

* Keep override_acpi_psd()
Let us keep the original quirk and override_acpi_psd() function. Over
the time, people may want to add new CPUs to override_acpi_psd(). The
maintainer may declare that only CPUs >= family 17h will be fixed, to
avoid exploding the check-list.

* Remove the quirk completely
We can completely remove commit acd316248205 ("acpi-cpufreq: Add quirk
to disable _PSD usage on all AMD CPUs")? I am not sure what "AMD desktop
boards" was referring to in the original commit message of acd316248205.
Maybe such machines aren't in use anymore.

> 
> Hmmm?
> 
