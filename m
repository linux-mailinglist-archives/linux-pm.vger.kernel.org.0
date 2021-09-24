Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB72A416B48
	for <lists+linux-pm@lfdr.de>; Fri, 24 Sep 2021 07:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhIXFnu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Sep 2021 01:43:50 -0400
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com ([40.107.244.62]:29884
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229727AbhIXFnu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 24 Sep 2021 01:43:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVu27zjFcW1P+t5xOEnQEBjPjJ2AwaYe/9TYA4YowwsFen8V8axBPlgdYTZdNirW124ixjObvGiAnrIAgrl+GpzwCyvdoj+VgulxtTpgcKOooHzDD5IRAEQUCuHxGqMDEyUJhHMS+E23jTaNP8Ji8DnSlWLCAF9iJdCslFdMkTV325kB/4atXckyPRea3Mi3uf2RtDAb+gkbX+2HXLAvY9JzHyxDgbFYRLFkJEMUnUCxtKFMix40QrhBEbG5uTB639xNdp/U+H5iRKlNRtPVPzvRZwnc40CXmUQTHhBWsyyvHb5icDMQIMLFRsY+P0E3LHvESRdnzntMcLX/TjbWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6ppsGqGoRDymBmxKy2G/2Hj9xNWOFvN7mShq3rjf8hs=;
 b=NG7hLBEZSX1GwRrHVd18W6wQE6ydiYlriAZ0d/77Nd9qhCcK5o/0NxX6PPKWXyLZSJ/SqCuulqLWbtzxgq1Z9vguY+pVqCmCFb5xy85Opc5f4vl55naEwoMQfxsPNoLAGs0WaU26akDTCa3Mzy1Vq2jAf1GqZtb9tNM9RGUViZlLnVmfCDf/aen7+F1BqzMI9WuiAPE6/VSR2X8zDxVCjXyMJE14b+544UN3EbyUu9YbcW7QikZH1L5wkb8hyl58hK/0bHI+0zHuIXf6B7pPoxlgX07k8448Qio3554enm59sM94pVKfhv/sV+PVtTVB/vo7MQp1CVRhH91KRAxn4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ppsGqGoRDymBmxKy2G/2Hj9xNWOFvN7mShq3rjf8hs=;
 b=Di7h8ShcYYqB4/5u/+exEgCOUsIiEHz9SHPIoU4vMDlyLyoiUJ3FYVCO24YOWcLkZlRZ1bLDt1WJBOKXrtGD+rmaX67etz44YJ8/cXuF12agTJ86ti9OtpPHEIAgByqjKhYTaM36K6FyGMT7cABWz3SWDD6GcCzXq7K9to9vd8A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4177.namprd12.prod.outlook.com (2603:10b6:a03:201::14)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 05:42:16 +0000
Received: from BY5PR12MB4177.namprd12.prod.outlook.com
 ([fe80::b99c:d841:a12b:6f95]) by BY5PR12MB4177.namprd12.prod.outlook.com
 ([fe80::b99c:d841:a12b:6f95%6]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 05:42:15 +0000
Message-ID: <1f4a2197-2559-49fb-0f59-ae3365be9d05@amd.com>
Date:   Thu, 23 Sep 2021 22:42:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
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
 <a20fc6ba-14fa-e9b9-de69-54b9eaf20e73@amd.com>
 <CAJZ5v0gp=_T7b9YVDBfdC11DzzY8Xovxm659-X6i_bJxoV1LgQ@mail.gmail.com>
From:   "Sharma, Deepak" <deesharm@amd.com>
In-Reply-To: <CAJZ5v0gp=_T7b9YVDBfdC11DzzY8Xovxm659-X6i_bJxoV1LgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::28) To BY5PR12MB4177.namprd12.prod.outlook.com
 (2603:10b6:a03:201::14)
MIME-Version: 1.0
Received: from [192.168.4.54] (24.6.106.221) by SJ0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:a03:33e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 05:42:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ced5fd4-f11e-4164-5dec-08d97f1e109a
X-MS-TrafficTypeDiagnostic: BY5PR12MB4145:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4145802BAF353C43CB7298BEE9A49@BY5PR12MB4145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B7qNaqf1hRHUNFSXmiyDNcNZffbhkPesVLB/YlIihgNLDwTWD0SaTNi7xB3Mk0CW1Rw3VS6WqlH78eiUaNRq6dnc+564Oafo48hMpuhD0mUBQSSzfanrbKyGDSH0FZo9XhhHqTPxY9BSmvAqrbM3qq/jgt8+mXr7MdFc/bHspLEn/uKuX2S485xHjoeZ0unOFom8INJuQDLFtfjZ58oFjShKQebVhzNPkC0pnghfb4AagXohP25ncmA2PG4FEMEuIXiACFjVClLIAHTg+Y++m51WdIGgelWrtQVWVxA++eUz2UceFhYsU7lFx2JZyrifL73Npa0P8aTEF7QEv2EmHbbT2mVKDixLA/szMeg0+pEZo4efggIJ6EjyEiBLImzdOi0/c1p9TMxO4Mr7eQZ613Zu/+/fR7/cfDnpLEaFpKnPahTGXpFT6YQJZmGOK8aOn2VcUAVvdbQsIRngc6Gc+F0lbRtx/HV+wMtK5icWGcJJhoPhPuq6+EWDaahIfpssz5PGp4CGlVG5lN3HJGNQ+20giLKG9hhW6VzoYDln390BNQu9GN3nUYkE2HOQ8FB4hEUpz0cDGjgSEK5sy7nGCfZ5gzxk88OyBuI3KhxeSpZllZ5k1GIw9CfGpWCFXz3FQmxKw4WTDZM9XKOF9nzQD3SuEBqX7SOQ4CpOdg/iBq9989ErozNUuIarmf49WWFfmxDmDsmA4W7MGa19kRqjYmovF6my3/aKt3fvVBJIRVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4177.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(7416002)(53546011)(6486002)(4326008)(16576012)(316002)(8676002)(66946007)(186003)(8936002)(54906003)(66556008)(66476007)(5660300002)(6916009)(956004)(508600001)(38100700002)(36756003)(2906002)(26005)(31696002)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THBUZW4zdlRYTWFUNXZDems4cHlLK0JBQ2tzVUNCSng0enpaYlNCWEptNlBF?=
 =?utf-8?B?dnVmUXM5WWE5Y2ZFL3Z0a0R1Z292QTRkQTZ3M2NMcEZBcGlRZ0hVUWNmL3Rw?=
 =?utf-8?B?aUtaS3NVOFFidDZ1SW9iQXNCNTNkbXVNM0w4UGxSZi92ODNaRjAvN1pCTjB4?=
 =?utf-8?B?N2JUdEtCVHVia3MvSTgyRlpIRnZmUHBEeDBJYU9DZ2o2TXR1NUplbitkKzhW?=
 =?utf-8?B?ZG1HOUtxWjdpdnBzQmFGazRlUEVSRytvZXJCUFJveWhaRWhvZUp3TUFxVUtr?=
 =?utf-8?B?L200OXVmOFBFNmIwWmprYjVNdFBoclJlUlpSZE05VHAvY1F4bHg3azNHSlhD?=
 =?utf-8?B?MHFSdnhUUVBFVGRGWWhVbWd2c2J1Uy9nMmRTSkkxcDlvK2dYVW9jOVVKaGgz?=
 =?utf-8?B?VGFnUzRnY2F6cHdObTE5OTJiczlmNGUwYUg2bHhwUFJjWkhabkU4V3lsQVhW?=
 =?utf-8?B?MGRweGk2aGljWkRDVFczOFFTUlBOamliMVJiR25tc2d5UG56dlB6NlA5UlQ5?=
 =?utf-8?B?VzIrZFFQQVJ4elNrcTJmd2JLcmRhY0k4WEJ5MjlZdHcvMGl3ek1ETEpUcWdQ?=
 =?utf-8?B?YmlvNWttNWNyZlFHRW9OOEFGaUc3azBOd2tOOGVBTmFpamxGeHpOZFlmQ3l2?=
 =?utf-8?B?YUpIWUJZTVZoRUFlamNMWHl2Mzd5NFErTkdOc3N4UUYwLzJXVUIzQnN6b1Qv?=
 =?utf-8?B?NVdqRWJtQ0tvMjJmWjFHaU9ueEI2MU84QW9rcjAyVS9kbHpkb1NaczJSSVJv?=
 =?utf-8?B?dExDYlBqNzlsaTlLN1lJK0VXdmZ4cjFDdktvTDNqWGw5N1RZL0E1a09vbFJQ?=
 =?utf-8?B?bjF5ano1SkZEK3ZkUGY3Y0U5Q01CTk1mcEVpVnZoOFlxR1NSRno2MDFvVjZ5?=
 =?utf-8?B?dXA4YVNmWjYwQVhDdTFwb3lzTnEwbnV3Y1lNcUdwK0pOLzNPdExTL2NERXdM?=
 =?utf-8?B?dkpEcC94K2Z1c1kwN245Mmx5WXNZNmhETUIzRlBqeTJScUdiMXFoOEJEdDdo?=
 =?utf-8?B?djc3QmFGamdYWTgwYlJndE5UNVI0Y3dFeHBMMDhXK0haZWpLOFV2VWw1SFY3?=
 =?utf-8?B?YWxOR3YrU0FRTkZ6dG5WTTN3OVpCRHkvMDA1L0VhaHhKQTZsbFU4b0F6TmU0?=
 =?utf-8?B?RjRoN2toUVZGczJLTUhURi9FMTJRbmNPVTNUR3FndnhOV3ZGZjhQMVZISnJr?=
 =?utf-8?B?M0s1dDNtVkNaRXRYR252Q0JxWFcvWXRXS2pxbWRGRjMzUW9GMFo2K2FvUmNz?=
 =?utf-8?B?a3R5YmhZeUNTWS95S0d6V2ZXcCthL3lRTzdMelRuUlgyTDAvUm1selBTS0Ru?=
 =?utf-8?B?NGQ3UE1vRTh4aU9jbzZYR1FueElPNk5iUWo0Uyt2MnEvOEM4ckdVeE9GS2l2?=
 =?utf-8?B?K2dyM2NGWmsxSEVaeHBQbDZCTkxxRE9McHNGRTFKbGJnRUN1bWI1N2xTK1Q5?=
 =?utf-8?B?YU56Z1d0bDc3dm5nWkxaYkxzYWw2R21qKzFxU2NhSWFkMkxoVVE5RzJ3NXl2?=
 =?utf-8?B?T3lqNnhjYm1DcWNCU0xjem5xWkV5TnU2TUpjdGRZUUh1cmliMnV3a20rNTUw?=
 =?utf-8?B?TGNQS0JpaGdIU1RpL1FjVS82YWdNOG5QRDA0c1NLZ0Jkd0ErREJWVVhDbkt5?=
 =?utf-8?B?WkllNTVlZ0JKbU5iV09iSzhibVhMNThad2VMS3Q3eXh2d1ZyYy9UNlVlTGl3?=
 =?utf-8?B?NUFVMW52a0JwRUhnS2VDbkZvUXhQbTlSSWhPVVhvZ3RFRUxoeEREY3lrK2hX?=
 =?utf-8?Q?D5j8PDQbHO74Yc2nkFXawl4PdxjTywA5Ti0jVl7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ced5fd4-f11e-4164-5dec-08d97f1e109a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4177.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 05:42:15.6652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLoUdws3cmV8aNXHSixZ1ABRQ49tyY3G2e93FDwai0jXOuQAHv7QXd3wrQBs1weON63f+/acckLs3VzoMkA6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/22/2021 5:47 AM, Rafael J. Wysocki wrote:
> On Wed, Sep 22, 2021 at 5:50 AM Sharma, Deepak <deesharm@amd.com> wrote:
>> Hi Rafael,
>>
>> On 9/1/2021 5:45 AM, Rafael J. Wysocki wrote:
>>> On Wed, Sep 1, 2021 at 4:14 AM Deepak Sharma <deesharm@amd.com> wrote:
>>>> On 8/25/21 11:07 AM, Rafael J. Wysocki wrote:
>>>>> On Thu, Aug 19, 2021 at 2:43 AM Deepak Sharma <deepak.sharma@amd.com> wrote:
>>>>>> AMD CPU which support C3 shares cache. Its not necessary to flush the
>>>>>> caches in software before entering C3. This will cause performance drop
>>>>>> for the cores which share some caches. ARB_DIS is not used with current
>>>>>> AMD C state implementation. So set related flags correctly.
>>>>>>
>>>>>> Signed-off-by: Deepak Sharma <deepak.sharma@amd.com>
>>>>> Applied as 5.15 material under the edited subject "x86: ACPI: cstate:
>>>>> Optimize C3 entry on AMD CPUs", thanks!
>>>> I might need to send subsequent patch for this. Can you please point me
>>>> to git and branch where this has been merged.
>>> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
>> Still I am not able to see this patch merged on linux-next branch.
> It was there, but got dropped before the merge window due to the
> unclear next steps.
>
> I'd rather see this resent along with the subsequent patch you were
> talking about.
Thanks for the clarification. I will resend patch with subsequent 
changes which will have support for zen onward CPU's.
