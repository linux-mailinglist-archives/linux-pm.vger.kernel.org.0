Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96936409C39
	for <lists+linux-pm@lfdr.de>; Mon, 13 Sep 2021 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240815AbhIMSbn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Sep 2021 14:31:43 -0400
Received: from mail-dm3nam07on2074.outbound.protection.outlook.com ([40.107.95.74]:1370
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240285AbhIMSbl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Sep 2021 14:31:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJCcltXUmwginzE2R9C/PnTeIF4ZVcwWVxbCQVKfUqvVZa0q8uupiSU4UtS9cwWa3pKg1A+z/nmkG6MbGfVsA61aAkNkLwxqLJZLv6NuoXROO7EyPaJ6O0Zmo29yhu37RKeVdZB2RwESxQw/0fg4DZon8RLV5Or/LT8KavuYYxFDL1f0utw3A/43EEd66w+oAVEuWHdd1f1K2dYGxA6fPP46qJspF9n//oswAnO8oF7TKIIlX5J5SvSn7vZ7ijbh8O5+s9UC8uGFzeky1bd6CAQZ/B1sg5bMJ5M68HmkukQykFKO66ScLC/PnbzWqMTT0RPXYT+R5TVtcW3zKBOdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9e7sHDV4GfMfz9CUg16rSxvRiyBz/ff/vLEx5wxcILs=;
 b=kvJePJeGsdVwHYn2U6er09AZV7P+qNxQNo1DSuCqElphH+I3p1ML6wcMOwm6Hb3NRfflQkx9kx4gk05ieAna3FYPv6dFBRj36HzJ4u1uDf+4KSH9sagiYoEIFDBYSECz8NIh7dFu6hgeRh0Bs6qG6NGbabux/mGFeW0JsrtNsCy/5A/k8RRhUL/+Wa0KCUd5wpRkhRsVzKRwM8N3kj8JHrTdgZa64ZJ7BaGvzDIQPwf0Z4zLkeI0Glx1aqhyXPzOY1fwTkAUAVicJVXRq7pvQxGTzqdFWrowQKnN27qTLgj0jmzXzZuASz+JPFFY2agVhHwmEAPEq+igXWooYg6pGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e7sHDV4GfMfz9CUg16rSxvRiyBz/ff/vLEx5wxcILs=;
 b=REsv6J9QGP2uphSTpUOXIzQbOYMpfqgnuXRzY+MPvqrvrrBF3qBmnxu/jpXMBrap1ZrnAp/2bbPc9gJ6MUFpJ5Zr3RQWNbitZFtb7TaWb3eMSuWNTOLvFg2uewfKNGzsBfGMTBNJplk6zORmnvQkN9BMzXXwbzwsJgARsp+XQG4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Mon, 13 Sep
 2021 18:30:23 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::f909:b733:33ff:e3b1%4]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 18:30:23 +0000
Subject: Re: [PATCH v3 2/2] x86/acpi: Don't add CPUs that are not online
 capable
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20210908214146.8640-1-mario.limonciello@amd.com>
 <20210908214146.8640-2-mario.limonciello@amd.com>
 <CAJZ5v0gip6L0cDxUJq-LsG4khmS0QW=xs5jAQr+OY6i28XBnwg@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <c0af820a-9732-e67d-4697-4233783f3781@amd.com>
Date:   Mon, 13 Sep 2021 13:30:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <CAJZ5v0gip6L0cDxUJq-LsG4khmS0QW=xs5jAQr+OY6i28XBnwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:806:a7::22) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
Received: from [10.236.176.207] (165.204.77.1) by SA9PR10CA0017.namprd10.prod.outlook.com (2603:10b6:806:a7::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 18:30:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1261423b-70a3-4b49-4361-08d976e48c94
X-MS-TrafficTypeDiagnostic: SA0PR12MB4384:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4384A21094BBEEE59E5759CEE2D99@SA0PR12MB4384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xESRXkLQFElsB5spcRcMzs0iwQXIUrthUrsLPFtqRwMfVQtlQ8iPpIxshYxp0ZOC8/HwiE8D29ZqnEwk0TH9hGOu5l/3vmlVDO3U4KKZq6uYS/mEQooVmSvtS9hVkEE1q/yjAwLyuxctxR1w0OmOZqQFh9p3/Kl9qerTpCsGORcgcJ6clXEsw3nfVq2ym3J2ptgmoIJyLJelY5mPNPe7NxYoHEHZlt7n3EH9VU4W9GXLTLaoHOQ1RX/XFrwOZdSyJSak1yFqXxzGDNMTTffPJeRcQEa25lOVIo7qwmVceZHSr+FXj2hihVuXjJNI2fz+3TVagBYe6BSwRSCaU+bnr0bNAC847aPArzqHwOyIzfmmumGR76CTDArsoxJoJXWqbakwAmqhSNGWx40ZK8yu4WZgkkwWzlXel82AqSxAlg4714+0gI+ydcoi88lXmFr4tq4bdvcNiwUMypR7l+/gr2kPkWBhn4i40AH5vu32+Yy3hYZKu5xii3AFC5HNJZaNxbQYnotCc5y6T9hAXLnL/LTgRTGLeKEJVnQDv7ewa6aJLMOLTI3E4C3ZTte+qpBBo7f/s68ylW0oL4+lupdCXX2olbHiPgETzD2qbzn+6MzYMHHcohw4OjSBhBxiximLTyJx+FB/X6qE9neV3JrAYlNf3fOSFNUKunSr8w0bmB8oa5NHXpATwfdP17/z0QxP6QS4bnuk94nLPQXS9pMCgT9GQew4vSR3JbKyBkQGHNBdHpgx9igaD1Uk8C9fhtSUUDvkZDrU6ZNHMxJOqB9EdjjDvOVPRYy1V1HQO8FWsjL9bhVIn1hXgxhmB2KhwaJj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(7416002)(4326008)(8936002)(956004)(8676002)(83380400001)(31696002)(478600001)(53546011)(31686004)(66946007)(2616005)(36756003)(6486002)(966005)(110136005)(26005)(38100700002)(316002)(2906002)(86362001)(45080400002)(54906003)(5660300002)(66476007)(16576012)(66556008)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hzNWYvRFdmQlZud0Zaa0l0N0loNVVFaHo5SXVBOXk4c3NnWmFRZ0RobFZ2?=
 =?utf-8?B?VldmUUVZT2xzc0JJdmd6amw0OUFhUWlDVzZXR21TZm9aUG55M0xzcXJxMzNV?=
 =?utf-8?B?TnU4RFlzY0pESDd0MjhkU1VjS2IvdnFxc3NwSysrWmRvWit2TEpxNUM5SEtq?=
 =?utf-8?B?cWRUd1hobmI0Tjl1azFibEhzTTh3cEw0WGZyL3VYSUxWWC95RTVDaFJ2amg1?=
 =?utf-8?B?QnMyVGpBTDNRbTQ4MU9QTkhIdUttOW5TUHNIeFhOZ0w2UVdQQm8wZ3o2ekx1?=
 =?utf-8?B?WG8vcEp4TExyUHByenpWa0VLSWk0TUpINTU0aGV3T3FrMXN5dWc1YmYvcFZ6?=
 =?utf-8?B?RExIQVBUNUFDeDJBdytBdjViZkxCYVJnaDZjenFQZzd4bWsrUU1LVmlsU3Ev?=
 =?utf-8?B?aFRwRkRaRjlxMFE2cE92NGJvcTNSRk8zNGdwYi9NYUZoSXpFNUJ5a2dhZDZr?=
 =?utf-8?B?TlIyR3NmcXZ3ell1dHB0U1NwMXhwZGNjV2J1aWw0c3JWSmJjRTk4em5jWGFT?=
 =?utf-8?B?U1V6eGNXOUhYNDRoVUVCOFRtblNCKzBlbWZFUEpkNURENERhN0ZCbnhMbGM5?=
 =?utf-8?B?UUpiQnVRSVJ0K280Z0FFSDl0YVlMRDZDd1R1a2lsWVFpdHpTTENibktBNXh5?=
 =?utf-8?B?bHExVGtrODBPK2dIenFWaGNSUjVTejBxRlF5andSWC9BRlI1TFJqMlgyTXV2?=
 =?utf-8?B?QUh2eDRXWXo5SXBkazlpYVhvazNMV2NaU1dZRXFXVm5YMjhjd1ZHVzVOQXdX?=
 =?utf-8?B?RzdZWlNkMzNJcCs3MjhUMUg2ZTdCWkRlWmk0bUVqWGpWd0NGam1NbkM2Z2l5?=
 =?utf-8?B?NjdPZFJITzBvRGJXVnoyazJ3d3pLU05NYnBDSDhlYXNmZkhVaWIrMnc1OGx1?=
 =?utf-8?B?NEl2U0RvL3UzN2lmTTQ3MU5nbkZ0UDR6WXR6S3BDZTZZbi81MjFPZm0wNjln?=
 =?utf-8?B?UVU2dXNkd0hoL05rZEFNdSthTG1PVm9Kbnh1cWdIcnY0SmZLR2dYV3IxWDVG?=
 =?utf-8?B?TGlaZFU3M1V1b1VlNjNPRFZLNi9UYW1OZWRjNUx6ZGpDMWkwY21VbUlUTUNs?=
 =?utf-8?B?dWdpamZ2dVZhMFBuQTJLZHJneTBkVXExZHI2UzYyeXlZdUNNV05hK3d3TVox?=
 =?utf-8?B?eGYrWWUza3NRT1AyclpvemdvZDMyaHlxQ3I0Zjc1RWMwUDhlMWM5NGUxcC9k?=
 =?utf-8?B?WElBTzF5ZkF3VmgxK2hIK0ZLTm11clQ1MElWd2tpK0k3N0poQldmS0ppQ24w?=
 =?utf-8?B?Y0t6N2x1S2ZOR0FFeFMwbkNuaThiNHFDQ3ZFZDlINDQ5WkJDeUhzdlY1RWdP?=
 =?utf-8?B?N0wzOG5HaVRRdXdWWWVPNmlJVkpDd0R5a2pwejdPTUZ1THk5T1lYM24xRTNJ?=
 =?utf-8?B?Tkthd0NFZ2gyZ01EeDRPNXZHeGlHM2ZwK0t1WVdDRkxnWlRZK0o0RkVMOFMz?=
 =?utf-8?B?cFZKVHZmRVNDRUNlM09JVVFjSE8rYldUTk5ERkxyL2VyTm5MUTQ5dGQrRzdF?=
 =?utf-8?B?KzJOL2haMDlob1VCSnpGeWg1Yy80NGRyRTJXaDEvVEsxeUsxc2JEZ091M0Rp?=
 =?utf-8?B?MWVnaE1zSnc5QlBVK0pWdm1wWEJYdm1oWE84R1NMRzVUZUdRSVZHTjVaMC8x?=
 =?utf-8?B?M0M2TUk0UldGSGx3SWNmSGh2Tmo3TGExcENTaU1sQTlydWRJU3Z1OFQ4R0x5?=
 =?utf-8?B?a2R6OEFuSDVlaFNaalFGSU43NW45WmcrYUxDYkhuUW1jU1ZRY0MvZ2xKQXlM?=
 =?utf-8?Q?/69BMTjD6haIAWu3pG8tWZ+thNp85uLxNNFpVSb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1261423b-70a3-4b49-4361-08d976e48c94
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 18:30:23.3769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3GLwiIbMPnZLLNtEhXriv0yMzmwuEIdmrzRpSJrZaMQiZikydjwWlvmrentngO2WozBI0WoGe/TfrAvI5gQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 9/13/2021 12:23, Rafael J. Wysocki wrote:
> On Wed, Sep 8, 2021 at 11:41 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> A number of systems are showing "hotplug capable" CPUs when they
>> are not really hotpluggable.  This is because the MADT has extra
>> CPU entries to support different CPUs that may be inserted into
>> the socket with different numbers of cores.
>>
>> Starting with ACPI 6.3 the spec has an Online Capable bit in the
>> MADT used to determine whether or not a CPU is hotplug capable
>> when the enabled bit is not set.
>>
>> Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Fhtmlspecs%2FACPI_Spec_6_4_html%2F05_ACPI_Software_Programming_Model%2FACPI_Software_Programming_Model.html%3F%23local-apic-flags&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C081016240ab94e72822d08d976db3d0a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637671506287828485%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=0vIs%2BDryYFVrtT1DvhU6Ke1BDJe%2BsIhbxPu94NeXRBo%3D&amp;reserved=0
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> I've added the patches in this series to my queue, but given what this
> one does, I think that it's a bit risky, because it exposes the kernel
> to a new category of possible platform firmware bugs.
> 

Sounds good, appreciate the diligence.

> For this reason, I'd rather queue it up as 5.16 material (and of
> course x86 reviewer comments are welcome).
> 
>> ---
>>   arch/x86/kernel/acpi/boot.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> Changes from v1 -> v2:
>>   * Make the change only apply on ACPI 6.3 or later
>> Changes from v2 -> v3:
>>   * Make acpi_support_online_capable static and only valid if CONFIG_X86_LOCAL_APIC is defined
>> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
>> index e55e0c1fad8c..d915f01b582b 100644
>> --- a/arch/x86/kernel/acpi/boot.c
>> +++ b/arch/x86/kernel/acpi/boot.c
>> @@ -62,6 +62,7 @@ int acpi_fix_pin2_polarity __initdata;
>>
>>   #ifdef CONFIG_X86_LOCAL_APIC
>>   static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
>> +static bool acpi_support_online_capable;
>>   #endif
>>
>>   #ifdef CONFIG_X86_IO_APIC
>> @@ -138,6 +139,8 @@ static int __init acpi_parse_madt(struct acpi_table_header *table)
>>
>>                  pr_debug("Local APIC address 0x%08x\n", madt->address);
>>          }
>> +       if (madt->header.revision >= 5)
>> +               acpi_support_online_capable = true;
>>
>>          default_acpi_madt_oem_check(madt->header.oem_id,
>>                                      madt->header.oem_table_id);
>> @@ -239,6 +242,12 @@ acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned long end)
>>          if (processor->id == 0xff)
>>                  return 0;
>>
>> +       /* don't register processors that can not be onlined */
>> +       if (acpi_support_online_capable &&
>> +           !(processor->lapic_flags & ACPI_MADT_ENABLED) &&
>> +           !(processor->lapic_flags & ACPI_MADT_ONLINE_CAPABLE))
>> +               return 0;
>> +
>>          /*
>>           * We need to register disabled CPU as well to permit
>>           * counting disabled CPUs. This allows us to size
>> --
>> 2.25.1
>>

