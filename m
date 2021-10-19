Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2631A433ED4
	for <lists+linux-pm@lfdr.de>; Tue, 19 Oct 2021 20:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbhJSS4j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Oct 2021 14:56:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:53445 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232717AbhJSS4i (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 19 Oct 2021 14:56:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="226064557"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="226064557"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 11:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="526765513"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Oct 2021 11:54:07 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 19 Oct 2021 11:54:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Tue, 19 Oct 2021 11:54:07 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Tue, 19 Oct 2021 11:54:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=INs6CvlPbdZboxdCAstaFKXPo97Zfz5cBMiwtojBe6Pti48Bx+HmrIdqn45Np2kqDEMYOgzag5mZTMfJ7+G/tLvaC8X6JGsuhU6abM01fP06HEVaNFhiN5NVSq/ZUWUQkK/LC2/YsvYFmHqc3OXsycaH825CGlbIZhG40e+jXwUNC8YIhhM4ya8/vGLYgvGhlqMujZKsw/3uI0FcG0UxCPQBZVOyrMhsORO6y37vF+ZTwgLV0MIPtAaHLMsxb3/EikNOygPIjIH79mYOXk1UeRfA+7A1RS23y1mAj4jVGLN9mM9ods7GIIiL2pPNtXMNFUSbgN/FT4iLPnyRUlZepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jL7cm34Hzy5kZDPXlubi+YxWQmVOrJOsdLAmBt5gPiU=;
 b=UuMuuxq73b4ZJc2UbmF6snz7yaBWxZvJ91tI0YfUe62Ea6e9ixn9KcyEltnOC1BTPbuy1TxViDD1BG08+7iH9PWig7lOb8d7ZyoA4mTSkFTKsYdUP8XgHVhM083qCwvX/8cAkqevQ60SB2xgl4+o3pXvqugJKf1S7g89S9A3gBYatsXLMaxQFwkQf06i2r5/uDQ8zZG2twP43IyxnbZLVChjRqujXpH76PyQVvdDNKAJqMczr9hHBlwgJMvkD0YFgqC8gJ+WyXM6tYZAeDzM+Wq7B2+7gz/oav1KZqpXdJUCmBGWdNIfr0zbC9I0qkxoPjrEGgwNJr2NO3RIJDKdxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jL7cm34Hzy5kZDPXlubi+YxWQmVOrJOsdLAmBt5gPiU=;
 b=rHh0Wth2SH27j5kvWs3AYMZkI8sQNIYEA5k9qoI29A+v8cR2wGS/j/Z1bV5rov1YhjYBEGlu8KPVRxo+Su1aQze1LHXxra2AradUeKoAssqMGxgUBC8kg5uxOGQnqOsDHRYGf8Z0dc7E86N675cHxND4rCAA2AsBDQfthh0EAHc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5326.namprd11.prod.outlook.com (2603:10b6:5:391::8) by
 DM5PR11MB1595.namprd11.prod.outlook.com (2603:10b6:4:c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.16; Tue, 19 Oct 2021 18:53:58 +0000
Received: from DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da]) by DM4PR11MB5326.namprd11.prod.outlook.com
 ([fe80::c61:d5d8:c71e:66da%9]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 18:53:58 +0000
Subject: Re: [PM] bfcc1e67ff:
 kernel-selftests.breakpoints.step_after_suspend_test.fail
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <lkp@lists.01.org>, <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20211014075731.GB18719@xsang-OptiPlex-9020>
 <51c0a15f-1941-f161-dcec-a7a9acc726f2@gmail.com>
 <e526de16-5efd-6474-20e1-3f96a2e3c524@intel.com>
 <6755cf07-fa5a-cbb7-c076-57c162a08c99@gmail.com>
 <d3cf18f1-2af7-5e4d-abe4-c882f25bd5c3@intel.com>
 <20aedfba-14e3-3677-d21a-b87610095445@gmail.com>
From:   "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <d36f79b4-472c-4852-7370-a011f9f556ce@intel.com>
Date:   Tue, 19 Oct 2021 20:53:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <20aedfba-14e3-3677-d21a-b87610095445@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::16) To DM4PR11MB5326.namprd11.prod.outlook.com
 (2603:10b6:5:391::8)
MIME-Version: 1.0
Received: from [192.168.100.217] (213.134.161.249) by FR3P281CA0030.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend Transport; Tue, 19 Oct 2021 18:53:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4759353e-a700-4fa6-505e-08d99331ce93
X-MS-TrafficTypeDiagnostic: DM5PR11MB1595:
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB1595EFE6E7EBE366573D9915CBBD9@DM5PR11MB1595.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOy0gY3hpto8jwjoJlvzpTx8leDOdCOgr/w3zrU5Ym1g/dRT0klQ9eQaimatJg4YPVzh94AxTIzrKgs4e0vufsz9n8HscHJXuNChZXLM84jLn0UxcLUPxrzUGg1zCYdThjVwOleUw7i2UhM+mbvqP8I/+pToKiugIx43NHf4kopiAFFy420/NuDU9kONB4d4G9ytKMtvRzxv5LyC1yFySkIcDSLXdct5PxL7Cnfku3zprFZmOgWazE3ThrDP9ofqWyGR4i68mOuhDmDXD9eHKI9kB+ez5+eq+aXHb6IYuBKOyiqvt/2y/VufUCMN0ts+RSepMJm9ul20j/pn5kGwF1GY/hNLX9vvi+6pMFuUsETJ1DVjti3K6BjBFCrOMTygU0GQFcA1wvXVI+2bnksgnVc35CLHOMua5whCgaT+mnssJIWHc/gSNo88Q4N9py7mx3RjGwfxpo8e6tULtFSNiD8aUeP4GUoGgtmgZUG4AFXBY1MGO8AEV77JRl9adid495B7s2gkNNBJKlcEH5lVOACjiGnI9r10xfBJqd0aT+1KAyf659LmhRxDpgRPA9jvvvIzEesL6Rz1t+osUbSMAcSo29jxtHIN5QRctmjBwu+pycwdP5Ta9zUjpE7NktAl9JMqc/ZadYR/UfY8rPfPiagiOtB1kUbMxvJ3M2bRa7DRqtpMi2lt6wZSyfWRFTTU5Kqn/LYR2l15IpTzWGQKCqrhz6kJVVipl+v6SC7uIU5olhzc6/dos7KYJo7Dj5Rit7ZiKrj9FQS19LNY/z8tx0TBNMVYnIPxcJ89IElh+zQgZt6pm2KZX/4h6OO5cnRWovqpnN28YGXW4SYQa2jhirPHRQSGmh48ZSlQkHKHLsg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5326.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(5660300002)(36756003)(82960400001)(83380400001)(2616005)(6666004)(36916002)(66946007)(956004)(53546011)(966005)(38100700002)(66556008)(66476007)(16576012)(316002)(508600001)(8936002)(31696002)(6916009)(4326008)(26005)(186003)(6486002)(54906003)(86362001)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFdpQUVlay9uK0JJTXVyQ2xiSWVidmlKditvSVI5YkRVd3JmczZiZHhPQWRU?=
 =?utf-8?B?MXNCa0R3c0hmL1lOc25rK0p6SzZjbEZsS1lJUGhUWDIwNndkTldWa0VvYWY1?=
 =?utf-8?B?TTlKZzNkK1ZsYWdmb21tRHhTU2VSY2dZQ1RzNzBJUTF2QkpxNHlpSC95dHFx?=
 =?utf-8?B?Z0w1TGF3L01Ba0V6UTV5UCtWakRyYUttV0RIVXhtTXo4enYxMzgvZkVqd0do?=
 =?utf-8?B?SVFWVkFYZGpXNm1iYUNybnVsRXV6ZThjU2NPN09DdlJsY21IYWoyZy95WGJW?=
 =?utf-8?B?d3g0YkxqaGh5SVZqQ1d4U3VIYUNMVk9YQ1FFSlc0aDZveFhKbUYyU3VvZkRa?=
 =?utf-8?B?OHZHSGtsR3pLMTJIZXdOUzVyRWxseDRoNXNsV3J5VDlzZndrRndydjFRZFcx?=
 =?utf-8?B?QnFOV3RjTXFwQkRaYzRSNEtjc2FQUmJnNXdmdmN0SFE0NmVOY2tweFhxMUdm?=
 =?utf-8?B?Wk5xV3BQYXlsRU8vc2FlRXB3MFZYcVkrckFoSXdrczZNK2ZmVXVYcDhvdDVJ?=
 =?utf-8?B?aWpqcEhWYmRaMmcwZERObU9Pc0s5clNMeUZhL3ByN3dCTlQyWDVrMytQQ2Z0?=
 =?utf-8?B?RlNPVlJPS3M2SDBZbVBRL0g0V1QydTVvbHVwSElvNDFPekRHR0hDZjJ1V2xL?=
 =?utf-8?B?NmFVeFpWMHdXRWo5dmVLNkxJOElSRHNINDdKdVhEblF5cVZlWlkzemJDWEk2?=
 =?utf-8?B?dlh2ZUNtcmxadEZJVTFnUlFYcFk2RUh5TTlUdlp3Sm43dFAydVdUVE1lSFZj?=
 =?utf-8?B?Z2R6MGwwanhUS3Y0VnlTYmVFZDdyU2JiQW82YjBsZm5wTzBVQUhFYld2UWw3?=
 =?utf-8?B?MXphaDJ5SXNNQ0tJV1R5YlIvV1pweENiSmQ5bDhhZXBwWEVIWHlPRGVGcE1y?=
 =?utf-8?B?dTZ2WkhxU3J6UW5lbm1COGFFYytFdHI4Q0F3WTBRbTlsOHo3d3Q2T0k1aTZG?=
 =?utf-8?B?bFFFSDBqVlROT3pFcnFDRUkzbU5WL21ScDhtc1k2bWxrQTlFWDlpTnNjQ1ZS?=
 =?utf-8?B?MEZ6RGttK2k4K1BUcnd1TDVrbjNNUFZIWnVDekNRUFQzL01TK0RXaXZlclJU?=
 =?utf-8?B?TjFCZjN6VkVEQ2JTY0ZqOGFuY0NqWFpQQit4VFBUZkRCeGdhai9Hb1NIOWdM?=
 =?utf-8?B?TElvbFNydWNhTGR0T0ZFbzladmV2azJ2ZGFQSWtxZHVEZmZtcHJQTGpWRHdH?=
 =?utf-8?B?UUx2aUxWTk1obzhhWFhWMEtTdTRobmVSWmJGZmVWKzV6UERtUUlTcVc1QnlE?=
 =?utf-8?B?Z0kwWFI3MGYxMENCMDc1UXVaOEo0aWtuYTdyN2JOUUVjZmZqeG1XNDNldWVI?=
 =?utf-8?B?emtTbUlOZ3JLTTE1ZVNqeHNwa0lRcW41aWR0bGl4MGVROXppWnJrMGlXUTVv?=
 =?utf-8?B?VURuS3Q2UFZDaFZ5eUdMVWhHYUJaRUVXVlQ2UmxpQ2JPRlVQMkJCeXh4SHRK?=
 =?utf-8?B?OU5WV0pKSndpdS8zcDVyUWU5d3hpUnRTRTQxQStXeWMvNmFDUTR5cGVVazFs?=
 =?utf-8?B?TEF5QllEcDJRRVBZVEFXYWcyTThjY2hXYjY1SnhCUC9BUjNQZ0VaVmZiZnhI?=
 =?utf-8?B?RDl4ZkhubVpCTFppS0ZkWHJxNUtXbXZXbmM5bFJmY2FZeHp4Q0Z6TFRlNGQy?=
 =?utf-8?B?cS9uV2pwUFNCbkdFTDJpWnQ2L3lYNUFNZkpQRjUycjB1VHpPWFhoWXNPZkNB?=
 =?utf-8?B?bjRXQko0MTFLbXBwVGIra3ZTTS95Q1g5OElNMTlWNlN1ZHMyd0JQbFNQTnJ6?=
 =?utf-8?Q?LigtJ3WQMD2Ko1pnPZEOLEx0Lbp1zEj5eaMvDJo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4759353e-a700-4fa6-505e-08d99331ce93
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5326.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:53:58.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeIx9eyoJ4tdYO76jwvU7f76fkyDS6/bfsfC9wTVQIuVan7zex/IfxKk5XXV8uvXtypDjPL+nb3hiZc8U3xVuYPLBf+M38FYhsBN5yrJmxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1595
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/15/2021 9:40 PM, Florian Fainelli wrote:
> On 10/15/21 11:45 AM, Rafael J. Wysocki wrote:
>> On 10/14/2021 11:55 PM, Florian Fainelli wrote:
>>> On 10/14/21 12:23 PM, Rafael J. Wysocki wrote:
>>>> On 10/14/2021 6:26 PM, Florian Fainelli wrote:
>>>>> On 10/14/21 12:57 AM, kernel test robot wrote:
>>>>>> Greeting,
>>>>>>
>>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>>
>>>>>> commit: bfcc1e67ff1e4aa8bfe2ca57f99390fc284c799d ("PM: sleep: Do not
>>>>>> assume that "mem" is always present")
>>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git
>>>>>> master
>>>>>>
>>>>>>
>>>>>> in testcase: kernel-selftests
>>>>>> version: kernel-selftests-x86_64-c8c9111a-1_20210929
>>>>>> with following parameters:
>>>>>>
>>>>>>       group: group-00
>>>>>>       ucode: 0x11
>>>>>>
>>>>>> test-description: The kernel contains a set of "self tests" under the
>>>>>> tools/testing/selftests/ directory. These are intended to be small
>>>>>> unit tests to exercise individual code paths in the kernel.
>>>>>> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>>>>>>
>>>>>>
>>>>>> on test machine: 288 threads 2 sockets Intel(R) Xeon Phi(TM) CPU 7295
>>>>>> @ 1.50GHz with 80G memory
>>>>>>
>>>>>> caused below changes (please refer to attached dmesg/kmsg for entire
>>>>>> log/backtrace):
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>> If you fix the issue, kindly add following tag
>>>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>>> Thanks for your report. Assuming that the code responsible for
>>>>> registering the suspend operations is drivers/acpi/sleep.c for your
>>>>> platform, and that acpi_sleep_suspend_setup() iterated over all
>>>>> possible
>>>>> sleep states, your platform must somehow be returning that
>>>>> ACPI_STATE_S3
>>>>> is not a supported state somehow?
>>>>>
>>>>> Rafael have you ever encountered something like that?
>>>> Yes, there are systems with ACPI that don't support S3.
>>> OK and do you know what happens when we enter suspend with "mem" in
>>> those cases? Do we immediately return because ultimately the firmware
>>> does not support ACPI S3?
>> "mem" should not be present in the list of available strings then, so it
>> should be rejected right away.
> Well yes, that was the purpose of the patch I submitted, but assuming
> that we did provide "mem" as one of the possible standby modes even
> though that was wrong (before patch), and the test was trying to enter
> ACPI S3 standby, what would have happened, would the ACPI firmware honor
> the request but return an error, or would it actually enter ACPI S3?
>
> In any case, I will change the test to check that this is a supported
> standby mode before trying it.

Unfortunately, I will need to revert bfcc1e67ff1e4aa8bfe2, because it 
breaks user space compatibility and that's got caught properly by the test.

What happens is that "mem" is a "pointer" to a secondary list of 
possible states and that generally is "s2idle shallow deep" and if 
s2idle is the only available option, it will be just "s2idle".

This list is there in /sys/power/mem_sleep.

It was done this way, because some variants of user space expect "mem" 
to be always present and don't recognize "freeze" properly.

Sorry for the confusion.


