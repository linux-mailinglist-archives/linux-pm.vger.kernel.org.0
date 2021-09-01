Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F503FD11F
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238552AbhIACPu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 22:15:50 -0400
Received: from mail-bn8nam08on2043.outbound.protection.outlook.com ([40.107.100.43]:6209
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238102AbhIACPt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Aug 2021 22:15:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PEAkSYYJsEGImfbUO7oZ5DSr6sji77Fa4JsY9tmWM7pRZfFobU5LL7mL5t8eWZKGaY3fXkRJPTQmFyVRJ8ZJR98UItevPc7i8iWi+oRzwKR+S643xgrXg1Pfy0OHvpy10/bP3u+2o6NzhfjAe+TZKlzag5HYJYY+DpCx8u3HyOPulZDAHTyBbpWscZgvYlKKawacX6jKSlbbsBbeDa8zyt/khkEKdQvKFKEY2H9aiwJIJBUb6ZorhxOL76tgnRbgpqNObPHq6ECMibSThfrHjAXX7CT3LkOXAu+JZNX6ytQLL7j45TkEM/M3W/as8R04UqM7QrBcWyy+2J5ZLMHApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW9IGx+hobORSlGljlxFeduYORIo53Tb//4R5Kj86to=;
 b=BiZMK1BHtTw8hgwt1/aDl+KwVd/LGdFDi1W88i8Ltl2Bt7gqwIWaoLOjOPdxufh1drDoTDZMRdkvWq8ycUmd4h8EKtz8wlJ/D9OncAV73uKED1GEPn+SA/Que2nPpeULJiRzdPW2XWkewSVEfLcqOibnyaNJ9+9HwgG0wnfGfgA5ZHWlFEerPGlQ2ZQSXd+Y7JaaMWMd3NFoQsp8iWKBdUnPOExBpX1NAkgYr1YjqL9f7+m5d1ZWhqS4HhwIi1emqBrIfO5ObaWAhoI8ulgyTzlQMXYk8YOHv2LKrowhQx27pde/UlXd0SyLJB0EDTMYvwuNkUoGYxF6KnTOamzvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sW9IGx+hobORSlGljlxFeduYORIo53Tb//4R5Kj86to=;
 b=C83e4vxuQxM+0LM+KrOhQN1iSw9+Oh6i6rKyOwy8WsFaYW2kL0+IKu4FCpX+F6fPVkJtjecuRfiW+eM+4fuvqSnG2qWe4th0GZmejk9YNQe+cLzxxIXd5cRn7YNTXaWOKm0sjEaSjhzhURueTVYX63IoiHPpZl5uprncNf/efsA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 by BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 02:14:51 +0000
Received: from BY5PR12MB4177.namprd12.prod.outlook.com
 ([fe80::2022:1359:d604:339e]) by BY5PR12MB4177.namprd12.prod.outlook.com
 ([fe80::2022:1359:d604:339e%3]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 02:14:51 +0000
Subject: Re: [PATCH] x86/ACPI/State: Optimize C3 entry on AMD CPUs
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Deepak Sharma <deepak.sharma@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
From:   Deepak Sharma <deesharm@amd.com>
Message-ID: <951c4f8f-30ee-77d3-afb7-46e45c84213d@amd.com>
Date:   Tue, 31 Aug 2021 19:14:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAJZ5v0jWX=H=aZ25PzHdH05bRJvtYbGHfyTgH_68k4kfYkZc5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: BY5PR16CA0023.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::36) To BY5PR12MB4177.namprd12.prod.outlook.com
 (2603:10b6:a03:201::14)
MIME-Version: 1.0
Received: from [100.115.92.200] (24.6.106.221) by BY5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:a03:1a0::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Wed, 1 Sep 2021 02:14:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5f7dbc2-7b4b-4e1a-b3c9-08d96cee47fd
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB4758547F59ABDDC3295625ABE9CD9@BYAPR12MB4758.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNKMPm4h+GN1PfX7pFjQw+yb6Y4OB7dkhMt+NlPFjHrPcsQDF+eEgk3QZ8HZ2xLB9/uAJkj50hpl9vp1zHsld9Nk9HmP/ovvd0duWxfUfHOORnUaoWw+kao8yjsmMeknH2/H4wO7GUKO4iqCE8DLdSs57yi4dgo6imp8buSoCpD1/XC8aPu/Gf5cclLmmWWdggh/bZrLgaItWpusjeYsyptP+KQzVw1Y7P5MgXBT8UHRUBJQPVFx24VBh201+MY6m06PtTegXFtdomxQIYBKGI8nMCMiEDlcHxbpBA34ehNhjvVyCccgh3i6Q2g7Gng0Xx3+yhbSWz1NlCrJ0iLqbbIQWHTd9amOQMhY7vO1FNYOxt9IhvhyW5F7NwfZVNrSGqa6gqp7M1XXnhu4TqXLVi576TzPkX0EsYmU9JCstEitrRIOpcrJ8pTk5bSqI8BLs4qp27gNXN8INa8+fWeW38Iq3WLJhzptntvyiyait3YSaiXj4W+T1LuXYxd9XH1LVKJ79K6vjikgKwVioKgnjBHtpTkSdi6VTKD9V7oJs46+YNnYFmCSxDBSPd1vWma9dKcuLpWMh5i4JmbHpcXgTMttOvvxd7244I0NS6Q/iu6/X3pY/ZZTtIUIeZKBF7e/yg+KncSvB24qGSORNGDqYYLUkpxiAbK2+pXwHWUJ9+9p2nr8Lnu3kPqV1V8/wf+DmMlCeEDr8xF6fA5p3iWRWg8fWgxVhQs0aRfcJjmxuKj8xFY4uX2X0g6IXgqIRocth3JzRc+ZYAORF+REcWFrYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4177.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(31686004)(2906002)(5660300002)(6706004)(8936002)(66946007)(26005)(2616005)(956004)(4326008)(478600001)(6486002)(66556008)(66476007)(53546011)(6636002)(7416002)(6666004)(110136005)(36756003)(16576012)(38100700002)(186003)(54906003)(8676002)(316002)(31696002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elF4TEhKdGtDNEcyK1IxaGhzcEQrTTl2cWdWT3lOcHVvOVIxREUyYVB0TGlN?=
 =?utf-8?B?UEpPcnI0a0hSaEtRWUxiUzVLN1lSalptODRQSjA4U2I0VU9LRlBRRTRsNXoy?=
 =?utf-8?B?Zk9nK3lZNFgxVzVRL0N5K2NEN1ZjS3Q3eWlUa0Y0Z3Rzd1l2Nk1GQlEzYVQy?=
 =?utf-8?B?WEpDUVVBY1ZsV3FFT2ZIejUxNkhxSnBpZG15ZDF5d1NBYzFaQTV1UzZkbmpz?=
 =?utf-8?B?YnFUend6NFl3Tmo5K1pLTzE3eitTTVBuUVhwWE90amtZRTREVmFuM0NXUlNn?=
 =?utf-8?B?QnkyT0pKaUhIY2NZY3dDK1JsK0FiMkhNOFVNeG1ZVzFOTTJMcURia1k3UWlp?=
 =?utf-8?B?elBoRXJiNDNBeU12K0VUVWdKeHpFNlN5QmdncUJqaWNBbEJWL3Zub0w5MGtD?=
 =?utf-8?B?cHozaXZaSlVSQzh3UHFRZHVPOHYzak8zbmkwYythR3laR1RXUWRhVXh6TG5q?=
 =?utf-8?B?L2gwalpmVHNldml6Z2Q3bEMzTlFLNk91MXN1ZlFOY29EL2ZGZFNQenBaSzkr?=
 =?utf-8?B?NjhtWTNZVXlhaVZpK3hHRElydVJLeDd4dHRiTmtNSCtyUytwV1EzRE96THN4?=
 =?utf-8?B?UGhaNUlta251YVBKMlFsR3hvaTU2VjdsYmlzWmZOaUhIT0tNTVZ6TGlNTFp3?=
 =?utf-8?B?ejJqck55YmFXWDdCaE8rcGtHMEMwR2QraEE3bHNGV2JwdDZZOUdvK2ZQVGFn?=
 =?utf-8?B?OVN6N293b0xZTzFhd0lSbGVOaTduWlNGZzBNMFBaM3M0Z05OenB0WFhSWEJ0?=
 =?utf-8?B?MGZHN3o2UUkwdUtwQWlrcm0wZW9EbDRKVjN6WlNoVm0xbktxYkVzTDBlWm50?=
 =?utf-8?B?emlVVjZSUnptVSszK3JEckNUTmtRVzhxQnE3U3VackJDUHRrb1V4RGFES0ts?=
 =?utf-8?B?dVJ0a3lvWFZYTVJ0NUdzRlN5SkREdG5aclE5QXNoRXJMNXZBWG1wbmJ4L0hK?=
 =?utf-8?B?WDNRakxyK3QyQmRiQ29tdkJ0RTZaWnhqZ0hLRXBTS3lRN21mOWQxcUxpU0Ez?=
 =?utf-8?B?TEwrQnFFRVhpTWNiY1phaFBya0ZPUDVqMkhIODl5MWMzczJuZ2IvY2gyQkFD?=
 =?utf-8?B?RkphWWhvc2NTWDhvQjB4YjVzVGp5VFFodTNZdzBDRFlUTEF4ZDMzOE1UNnJY?=
 =?utf-8?B?Z1dRLzdVcHZ0ZnlMK2pWZTVla08wSEp1NDRDbk4rRHRjakVLZFZnWElWY0I1?=
 =?utf-8?B?NjRLZXZGQUpHSjQ4NTVReFZEUFJMUWhJMmNySzlUNSszcjNjcG9NSUI3c3RK?=
 =?utf-8?B?R2thWkI5RzNjRThSVXhoTnJsRVV0UEIybUUyT3d4aG52KzVwM2dVMkR0STdI?=
 =?utf-8?B?dVlZVmJZRDFZUGl4MlQrMVdpZUlCdUd3Sm1BbEF3bGoxTnNCejBsZnBBMm94?=
 =?utf-8?B?OTJZNEp0OUVRc0FuTTIrSkpKVlJYdStMV2NpZ0IzS3lsc0JJeFN6Sk9vbzR6?=
 =?utf-8?B?MVIrMXVyM0JLdnVsbmlXOC9LUGZRa2RMQWxobHBrNktJbEo3c2VOWElLT3Yv?=
 =?utf-8?B?NVlLWVdlbzhZQ0xOTHhsbjdlK3VJRHlwZm4vTXhwcFFLay9nTk05QWpSN0pE?=
 =?utf-8?B?aVVEM0xGNDdIVCtQNG9xZDA1TFd1Ym42M1BiUnVWa1NqNU9Db2NTdXNVNzlC?=
 =?utf-8?B?WHAyTzhRc1FvY0RVelVRSVd2SGlYT2h0elprYzFHdkh0bmhUYmVmeUxScmJR?=
 =?utf-8?B?UXFVOFN0eE9ZYmc2L1RRNVJ6K2V4cnpLOUMxaGhIMnkvUHZTVU9QbVVYZW0v?=
 =?utf-8?Q?PKNHS+oVRDA0QJCcIAwbA4DBFmFFfvZcpPYzbY8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5f7dbc2-7b4b-4e1a-b3c9-08d96cee47fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4177.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 02:14:51.6775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfhQAHvWLW/WNfDbP7d3JSpmDLbLY+2wv+AejLjOMD20ptYa/XbZ9oSrdrDscDCmPrsrrAwLBqZ0PaxcGOBs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4758
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/25/21 11:07 AM, Rafael J. Wysocki wrote:
> On Thu, Aug 19, 2021 at 2:43 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
>> AMD CPU which support C3 shares cache. Its not necessary to flush the
>> caches in software before entering C3. This will cause performance drop
>> for the cores which share some caches. ARB_DIS is not used with current
>> AMD C state implementation. So set related flags correctly.
>>
>> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
> Applied as 5.15 material under the edited subject "x86: ACPI: cstate:
> Optimize C3 entry on AMD CPUs", thanks!

I might need to send subsequent patch for this. Can you please point me 
to git and branch where this has been merged.

>> ---
>>   arch/x86/kernel/acpi/cstate.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
>> index 7de599eba7f0..62a5986d625a 100644
>> --- a/arch/x86/kernel/acpi/cstate.c
>> +++ b/arch/x86/kernel/acpi/cstate.c
>> @@ -79,6 +79,21 @@ void acpi_processor_power_init_bm_check(struct acpi_processor_flags *flags,
>>                   */
>>                  flags->bm_control = 0;
>>          }
>> +       if (c->x86_vendor == X86_VENDOR_AMD) {
>> +               /*
>> +                * For all AMD CPUs that support C3, caches should not be
>> +                * flushed by software while entering C3 type state. Set
>> +                * bm->check to 1 so that kernel doesn't need to execute
>> +                * cache flush operation.
>> +                */
>> +               flags->bm_check = 1;
>> +               /*
>> +                * In current AMD C state implementation ARB_DIS is no longer
>> +                * used. So set bm_control to zero to indicate ARB_DIS is not
>> +                * required while entering C3 type state.
>> +                */
>> +               flags->bm_control = 0;
>> +       }
>>   }
>>   EXPORT_SYMBOL(acpi_processor_power_init_bm_check);
>>
>> --
>> 2.25.1
>>
