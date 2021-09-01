Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23E73FD116
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 04:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhIACL6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 22:11:58 -0400
Received: from mail-bn8nam08on2075.outbound.protection.outlook.com ([40.107.100.75]:16832
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230333AbhIACL5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 22:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHzSjHSkuVzGC5/XAjMCfyMk6FWORKwz95ibMwXHngXWKGkVlMVFC5EVC5eJBjMsjavOC0RGlYbU2KWMETsiHQ/58XZYMad6bpXyhqO6Ns/JafZm+HDILdJnwerPdAqMPw3cpszbzk0LiLrtN8s3GHqRh3EtSObucv2XdZ2kwdBNKyEcU6xL7EnGxbLVr6BQ/9vpuACeKy0QPk7Qcy1DAU5AT3nM1JrTkvRRtHmLqHzpb2XJEvw7mEQhhZ8K9hRXtvRViKvtnjeBQymzuzzQVrVvrJ7VroJoc33gklMBRImUdhZ4GtxoNmXM6ZSq8KIlSqaVGhZNuhY/B3G3agFJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+jBa0It+oWwSIPoV8sfRgAtbLvh9TwTN090j6l0Yoc=;
 b=K+srWv7aGtk87Fg96DZ2S6TM1ggWK24OwGiQ3iIJFiVYpyRov3bj0mW6UxJLNo6BecZ4Dl8qiLohBiJhyd8FjSZQfvmUSI6N9TCk9RNd2E1gb0PGJHBh3FPO1SIuAe8m7dLEPUzuKs3R5jBuYWFtqm46KBfwLKcieITETWulp262v43nDq7Ns9yOTVIISXJ4FWr2mBY/T8oEPhG1sBjR67USHSewS1JXx+F7h5EWPWsVDfNtik6jLe6LKyjn+v1tlUuAuncCTNb1HiuH5h2OXBuksx+7w7NtIOYAMqPxtkck2XVPoWs6/VCFi8bBqeCAlPCHQHNzevJHAZEmmhGR5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+jBa0It+oWwSIPoV8sfRgAtbLvh9TwTN090j6l0Yoc=;
 b=dYs/nn6eiGf3CswX9EXO1lUfFe9M2ag2aQWl4lxaHpwPYLLKrSsQLRdQ28RduK/uwNGcRyiE7cfvIfjnYR3B4RzFgwieg18aqJJnihv47Ya4FmGTgfs5aUhbkvBnpNEyr01NZENfS6b486PqnPNNub3VNTMyl+i/G/cnHx0klHI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 by BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 02:10:58 +0000
Received: from BY5PR12MB4177.namprd12.prod.outlook.com
 ([fe80::2022:1359:d604:339e]) by BY5PR12MB4177.namprd12.prod.outlook.com
 ([fe80::2022:1359:d604:339e%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 02:10:58 +0000
Subject: Re: [PATCH] x86/ACPI/State: Optimize C3 entry on AMD CPUs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Deepak Sharma <deepak.sharma@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20210819004305.20203-1-deepak.sharma@amd.com>
 <8735qv3j12.ffs@tglx>
From:   Deepak Sharma <deesharm@amd.com>
Message-ID: <e588b04f-7b61-8d5c-dfe4-2be725c49ff8@amd.com>
Date:   Tue, 31 Aug 2021 19:10:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <8735qv3j12.ffs@tglx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:a03:180::28) To BY5PR12MB4177.namprd12.prod.outlook.com
 (2603:10b6:a03:201::14)
MIME-Version: 1.0
Received: from [100.115.92.200] (24.6.106.221) by BY5PR13CA0015.namprd13.prod.outlook.com (2603:10b6:a03:180::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14 via Frontend Transport; Wed, 1 Sep 2021 02:10:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d545eda-6aed-439c-a4ba-08d96cedbcd3
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4758F8FC488E0FD6AB549367E9CD9@BYAPR12MB4758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRcRMz6NohYkNGfPzP/AZu25coRigpzTEqHDGIQKPfUP5EE5cXKDZkLLbprgnqHCasxhXamq1FxYWqLS+/9Jhbt0UqhVQuEut3oR0ZgbL5o/tt1QMrIhS07NHvwC36BPL1yoVGueZGzLlA8ppRv5CstBQ/2QmNLbUwkxdkbS5s4KTgwZ373bwVETlafIvy2j9HgjghFFVZEgycHVwHRhLRNswDa8dvGgqllBCSBQFx4y6B1LVTf+o4DnS/ER0lwhJ/zmJ/IL9emQpc3BK23uwZ1ULr2z20JConjORRFjlmA+FLUbDWSPQyKN28qubHwIINvybSKLajrnd5XV/MKO2ADzwqiKH63Z2AbcJJ1IBMnCrdStcodGtEvElR7EX3F+BOF68kD25srUk0ocNa5pYpMY61J3cskVkSVKUw+Eu2WtezvD1I4Doe3ocwieszq0lPOtvXV/5pzScequKvwI1nJcXIrRc9P6Ka/2Z6L/GWc+qaMqTlyhM8Hvv7gs1pM3LTXe8nod2QZLxfHGitWXvcZ0wDZwpfhZHzKI9+N9kfgdm8AvbUl7ExMlfuwQuItGvOS48sCEcSX4jA98CKHrHOItNcqitY5V71Np7J+O+Ox6N2iKvwdO6XNs/HGj+i5JOjz2nAej0SLf/xapVPHn6NHp1GQ9soatGXSylwpfv/IONuimMQUd11kDNXqr6Cj8LgtAoojwkfNbYal5gVXDtqTIintShN7TYLdTdEt/J58+cnkbiQrquM0dn4GPA6Z9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4177.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(31686004)(2906002)(5660300002)(6706004)(8936002)(66946007)(26005)(2616005)(956004)(4326008)(478600001)(6486002)(66556008)(66476007)(53546011)(6636002)(7416002)(110136005)(36756003)(16576012)(38100700002)(186003)(54906003)(8676002)(316002)(31696002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHI1dFNVSDNCZ1BFc3oyZExINGxiWUhJdVFUUlNwMXRPNlpWK3lVZnZaaGgz?=
 =?utf-8?B?VFJZeDA0cnc5RFo2djZxTm1sQU1MaHRIcFUvUHNBb3R6RTRuakExVFZNUHpN?=
 =?utf-8?B?dnhxQml4L0NySWNscXBWNXNlTWJFazUxT2VWa3I4TmRwUkFwU3VaQzViNWxE?=
 =?utf-8?B?Uk9PVU1GSi9OdEU2VU81NTZ4aEhkeWowblMyazl5M1VRTHdWSHg1NmtzRzNr?=
 =?utf-8?B?Z0xRREFnY0ZyY1pFc2ZVOXBtRk9HaWs5YlVwL3BuL0pCSUJQM0JKbjU1K0wx?=
 =?utf-8?B?VjZjU1JMTW8yMisyc1JqZ3lCWTRvRHZqK3M1MXo4SHdMNjRYaHpFd2VPVmR4?=
 =?utf-8?B?WUNQaGhtemU2dDZWb2trS3NobU92U0RBUWJ0MitabEdOcDBPZ3g5a1hYKzhG?=
 =?utf-8?B?VHJhTkEyMkhaZGh3aUdwMzFTZ1pvQ0wzMmdGa1ZUb2FsUFY1OXdXekdnc3JT?=
 =?utf-8?B?cEdkT1d6Z2RsdnEwMjZKcGVEVjlSdUlaZ2JpaXhmMWYwSnFrdG41L0JMMEZD?=
 =?utf-8?B?RnZtb1hPejlPN2Jabnh2VCtzUW5POXdDWlRaME9BS3B1UTh1K0taQ2NJRHNh?=
 =?utf-8?B?TlpoNjBqT2syWjJhT09VWk9rclBoV2RlMWJKdHdacGs4a2J6THlLNllWRkE0?=
 =?utf-8?B?b2VIU3hMcFYvaWdkcDdSdGdDVmVTeHEvSEp5MlhKRVEwUm1yVnRGQm0vSlBw?=
 =?utf-8?B?NmpwSzc1Tjh5YmpEeUVGSE15WFpDWnREZWlKZW9JL2NvcVNlWGduWkZaeThL?=
 =?utf-8?B?N3dNcHBPOEZWbkRBMDlyRHFTdVVrczYxOElxbVNsa01vRXFaUEpPYm1jNlpt?=
 =?utf-8?B?M2RDSkhGRG5xb011QjM4aG9UZStnR0VwVWZ2Y0FCR2Y0T2Mrem04bUQ5b2dM?=
 =?utf-8?B?R2gwUUc5Q1RJMGJKMUZXRVI3R0Y4N2xPVWFPU1o2YWpjMjRGRmJTR1lkMGVT?=
 =?utf-8?B?QXc3RWZCc2NMS1JoRUM1Zm1Qd1BDd2NSVkV2bllJWGI2aXdoYmQ1aDYvak0y?=
 =?utf-8?B?eGxrZnpFY2RwWlFKbkRWZTgxZE1oV0I0R3BlZXFYQlZkUlBicnM1YXJETEFW?=
 =?utf-8?B?aTZoZ0pZVHlmY2xWNHFWZG9lZ1k1QXpiZTBmYU02K1h5TkZpLzR1RWRaMVNI?=
 =?utf-8?B?cTNBM2RUSmpxNTl5VmhTOVg2RlBrdjFWZUh5MEZId2M2NC9qMzNTSS81a1l6?=
 =?utf-8?B?b3JWYnJBYkJYSXg1aWJmenFoMm9WQ0EwNW1uRTdlbXRCNlR2aWpBRXdvTFJM?=
 =?utf-8?B?OFlqaGxlU0thaEw2MVNUbEpnenY0c1YzTExlT3Rmek1ZTTBTVXhMaWRkRXlF?=
 =?utf-8?B?bWtsRytpN0h1azViT1lJdU03QnVISk9uanFsRStJbEZBWE1mT2o4bDFlOHNp?=
 =?utf-8?B?dUhBclVkRUVlSnlqbC80RjJCTUJ2cGorMGFxMDVHSE9NRG4xV1JKOHJpSVR6?=
 =?utf-8?B?U1lTc2FFSHFHcmkrNnRVTFZyZGhWeHJVZlUzVWRaL0xOY2dTZTlXdmtKTHV6?=
 =?utf-8?B?OGdkZW9MY1poVlJLWFZvVG1DRXg3UTdHLzczdnRpUjJJYzlTN0l3YWVSTE82?=
 =?utf-8?B?SmlQS1J2YjlIR3BpSFdQT1dJU0JOTy9DWElnSHNuQlNweFQvdWQrZ1cwL2xL?=
 =?utf-8?B?d2M0RGN6Wjl6REh3VUpEYjlWN3dlaXNHMkloQ1pUM3VubkpnaFduMW5ta0hD?=
 =?utf-8?B?bm9FSmhEc2RETXduWFIxR090Rk43bVU3NGNsRTlldUc0TXJ6MTJLdHlqTmxq?=
 =?utf-8?Q?mFELRF/Pd6XrvP0jWXGKym5Hl3N5Y8/F0ZFazJD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d545eda-6aed-439c-a4ba-08d96cedbcd3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4177.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 02:10:58.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28jzvd7mD/lLLNOy1axp6JT20ZIYiRjzmTsLinYwfErQ2yyLal9nLaOQVVAK2SUuiz2+ePt1QWoQ9nj8TFvBJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4758
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/26/21 4:04 PM, Thomas Gleixner wrote:
> On Wed, Aug 18 2021 at 17:43, Deepak Sharma wrote:
>
>> AMD CPU which support C3 shares cache. Its not necessary to flush the
>> caches in software before entering C3. This will cause performance drop
>> for the cores which share some caches. ARB_DIS is not used with current
>> AMD C state implementation. So set related flags correctly.
>>
>> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
>> ---
>>   arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
>> index 7de599eba7f0..62a5986d625a 100644
>> --- a/arch/x86/kernel/acpi/cstate.c
>> +++ b/arch/x86/kernel/acpi/cstate.c
>> @@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>>   		 */
>>   		flags->bm_control = 0;
>>   	}
>> +	if (c->x86_vendor == X86_VENDOR_AMD) {
>> +		/*
>> +		 * For all AMD CPUs that support C3, caches should not be
>> +		 * flushed by software while entering C3 type state. Set
>> +		 * bm->check to 1 so that kernel doesn't need to execute
>> +		 * cache flush operation.
>> +		 */
>> +		flags->bm_check = 1;
>> +		/*
>> +		 * In current AMD C state implementation ARB_DIS is no longer
> Fine for current implementations, but what about older implementations?
We are internally discussing about its validity on much older 
implementations. Will send subsequent patch based on the conclusion.


Thanks,

Deepak

