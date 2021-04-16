Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F26C361EF4
	for <lists+linux-pm@lfdr.de>; Fri, 16 Apr 2021 13:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbhDPLnN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Apr 2021 07:43:13 -0400
Received: from mail-dm6nam12on2076.outbound.protection.outlook.com ([40.107.243.76]:49120
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235434AbhDPLnM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Apr 2021 07:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lzPO3JwGa4ZxdPLc2qEniUyYbwVlgzqeTZscX/+uSLQlfFx1WiBy9WjXfsYwn+B9dP6vuQdyJLpfGBHXBmRNDQ/q9DpA3o1vRC7eMiRJnJub+sszdB3psGtS2d3mdRYJWUMNtZDfYOGnaysYpRg1T4gcfMkMHbRroYP1Abitk0b87cMP8L1ajk1ThNakvXV8RK386A5Y3m4puZsv8q4lv3aoEfYVY1aB2SicVJK9k70wRlMtJYIbMx7bNPfeYe5SuYLhlyTQBsMFNXmEmwoTxjL2kojhrcDfBKI/BaalPenNIzDUu+2gZkLComK+a74dVnjuSMudAcilFesfTWucEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjVYAf1JNdqjyc4T2S4Wx7AvHCg63ijm/nNAjLfdG/w=;
 b=QqEIuuY/9Hecndyojm6nWehOqn/ZGU/FtiJjGMG3shmdsM+lh3hgxSp+dnljrwaVo8FOtbiSt+TZ5pCveaKsJdxrDMwNG6OXwJzwwTE7yjD6bITJ2sdjqnPS0fDkSWH6O7YGi20QcxfQdZBsEl2KlPukcBwdvwWXx63O4+CLS2kk5amSKrqx3JqWylU0OFxn3RJOminPp3UvyEjF5PcAn118C/fmcZLtcqP1G5z6x8rAVPgnbOEbbBR/dAkvFwX+hRM2CRUTOEParWae6/E51BHbyLB81QZ4F+TcuJC1W92DZGoMpYi7QtpZUYpLYQtbF2cKreKdOyS6BqWNTt+nZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjVYAf1JNdqjyc4T2S4Wx7AvHCg63ijm/nNAjLfdG/w=;
 b=NNNt7NucubmBTxGXT23ksQZdnRuktf5kROTr+HmWw8rubZ3qe4aQQGBIMF4jaUEk/EDOiBd2H/ZRUTGS/2hpFDjyQXA6bzNQLn4kJkls3AorcuAQm2b91JT8ghcZY/2B7HlRHoWiCmkWz4o/jAV00XYxKlbboNxnLMOCSfbvLMY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 11:42:42 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::3e:b8e1:a378:413b%8]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 11:42:42 +0000
Subject: Re: [PATCH v4] tools/power turbostat: Fix RAPL summary collection on
 AMD processors
To:     Calvin Walton <calvin.walton@kepstin.ca>, lenb@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210330213825.77294-1-terry.bowman@amd.com>
 <17d15837848eddd8445b206356531b9b5aae644b.camel@kepstin.ca>
From:   Terry Bowman <terry.bowman@amd.com>
Message-ID: <68be4830-36ec-85ad-56ae-ee3cf9b9589c@amd.com>
Date:   Fri, 16 Apr 2021 06:42:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <17d15837848eddd8445b206356531b9b5aae644b.camel@kepstin.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [47.184.150.125]
X-ClientProxiedBy: SN4PR0201CA0023.namprd02.prod.outlook.com
 (2603:10b6:803:2b::33) To SA0PR12MB4512.namprd12.prod.outlook.com
 (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.254.14] (47.184.150.125) by SN4PR0201CA0023.namprd02.prod.outlook.com (2603:10b6:803:2b::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 11:42:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9500498-a0cb-4824-e48b-08d900ccbea2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4446:
X-Microsoft-Antispam-PRVS: <SA0PR12MB44460AE971C5CBDD81FA8E31834C9@SA0PR12MB4446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDBL4c1UeL+iOT9D78Ni0eChK9ll/bnp4Ud9kqr0v3NNd71AXLSp7tejEW2rx+r7XyUIc010C+wMlA6XsGb7Ou/H81T8pt+Ngb/YVjRJIqNAZeJBLlio4eaaXsKj/JOBSiqdzOGKGw9YD2YexBsNECUK+FLbPHQdqCvHIHFy0SYhhD9oBJ5MRe36s6puszHCKDzNcIVuXFRJhVnVIynl7qjdvcAdbtWsz/4nDYNcwrJrRQumtsZggD+mI20wBm74UHEfDy3uDJq5QqaC277LbpvAgKG/K0YXBM0GbgLnsyZjqqVWVxGrgCE8JiYJklGdeaIb/PmnKRa63YM2suOMh60+Q82gL5NU8ZmwsiTn0qqKLc+Lf8txxzj8nlDDHAVVP+Qno0KSqFLcLC88jhq3Qgfbtx9ikQmMq9fJmYU47LWfuNonBX6H0qsGhoq4TUMfWqfH9nUIqChxHI9yVkHLo/Dv/9C4QHrWBWjduHbT9XfIXDJb1Wet6GNT8DYrNXQRbPfzurA0HE8X6QGVmYi41pofObC+Esqx6KPBiNMqJpcJiedrWQBLmyjjlKCIE20HVA4hBl0Q7KL4gR56DHYLNgqvhxsP2VoBlc9Y3h2Ti+KWKAigwWRvpulJZavINMraONpP2DvhNdXrSUUDB8OK4EDoaqAp96K7e7iCUpiMltQ3aWasnfE/sLv08x+BAvnle+m70yNxIQuEION9gtxb6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(66556008)(66476007)(8676002)(5660300002)(86362001)(38100700002)(38350700002)(31696002)(26005)(44832011)(66946007)(2906002)(36756003)(478600001)(16576012)(4744005)(316002)(8936002)(6486002)(16526019)(186003)(956004)(2616005)(52116002)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Vk5EcGlNeHVKRDBRVVZrYldwRVZDT0s1OFNyUU0wWHRQbkZjdVZYQXlJQWhG?=
 =?utf-8?B?M1FFVW1QaWJROTRBVjN1Q2JDUFltYm4zOFpUZWk3b2NEc3JuTVRMZWxLaGVQ?=
 =?utf-8?B?ZGkyZncvTi9QT1k1Q2FDMVZPdmlGVFBqMEhYMGhMOXhPNlpXcW96aFNtTGZX?=
 =?utf-8?B?TmVsc05HOHdQT3pCeTNPN3dkU0crMWp6bTZJV0ptdlJTWVZsUWZsenBlRWVJ?=
 =?utf-8?B?d0ZRUmpBcG5VVGkxM2N4MWZKNENvbG8xZ1piNlZJaFIvelhKbG9Mbkw0L0xQ?=
 =?utf-8?B?L0N0RjJ4ZkVBZ20reSszV29lM1FsTkFHVFlncVNrZC9zZFFoZXVTVDBNUmJa?=
 =?utf-8?B?cHp1dmNZTzljcHNQOWJiMnRMZG10SmxhSVRpQkVBQXpGY3FDeFVjVG8xNWpT?=
 =?utf-8?B?Tnd5UldaNU90YzNOSVlZcG12Ni9xMDlyemxWUkhROFI1em9tTnV5NFJIdXhs?=
 =?utf-8?B?QUM0MUx4R3d0dERVY3p3Q3VCN1R4RWYxRG8vZFpTZ3J3VGtZNllSRHBBaGxD?=
 =?utf-8?B?RFU4RW9VaDdyZ3JQSUE0MllyWUUxc3pQakVhSHdkck52YUV6cUc4blFwbTBD?=
 =?utf-8?B?OE5KQWFsa0tRZ0dnODhLL1lUbmdJVGFYZzh5cml3R2o5ZVg1bVhSYXFkcnUr?=
 =?utf-8?B?ZGptOWJ5aEd3a3hpT2lLZjRHRUYvYmdwU3NLTW9kdGN1R0Z3aFQxQlBaay92?=
 =?utf-8?B?TTNObnZTdGxvNlZlQkU3MEpBcllDU1g3NXFrY0ducTZlNHdUa1lac3R5Z2cz?=
 =?utf-8?B?Nm1GZUhpMGdiYnVmRWNNK2lveUlxaGo1THM3Q2ZxQzFDQTJuaHlJWmlxRk9T?=
 =?utf-8?B?RFVzYjB5K3grVE1nZ20ybXZ2M0VyVDgzQm9CWGZVQ0lPZVFSaUZwbGtOdkhl?=
 =?utf-8?B?V251bXY0ZlhVUEQzb2FSaWZuMDB1eEc5WGdsdmlNV0dhcFBkYVdkUmRYcjM3?=
 =?utf-8?B?SHFBR0xVd0dJa1FZQ3g5K2RWRWo4dHRXM2VwOUVNNXdZeS9xbW1UQmJWbFpF?=
 =?utf-8?B?ZkxJeC9JVlMxd1I4Z3BVaTFSc0VQaFBpblNZamF0enhya0JVOXZ4Zmw4dXZF?=
 =?utf-8?B?TSsyTk1XeGxTeThTZHkwMUc5TzQyYlRFajhPQkxLV2xFSFFVZjhCaVlPdUR6?=
 =?utf-8?B?UDU4cC9ick5oelFIaFluc3N1Sk1tU3IvU0lMOU5HL3BzUllKazcwUXNXS0hx?=
 =?utf-8?B?MUxpeWRGZ1UvWFpZeWVrNUUvWGlPM01qNWdwTGhmNFd2QmJCMC8wUnUvUmJD?=
 =?utf-8?B?VnlUOS9COHhnb2J6RkNUY2tCK0NkTGlZdFIyQlprM0dTay96UWo5bUlRbVh1?=
 =?utf-8?B?Qmd5blpjKzNac21rU1QvWTk5alRrS0RDSndFK3pzTFRpdjk3cHJqU29VY2JH?=
 =?utf-8?B?dnhPQzBVaFlVMW5kcFF1Q3ZaaW1qN1RoTjNJay9kL2xlSEV2ZlYxakhGOEVn?=
 =?utf-8?B?UndZTFd2QmhEMStPejdjYXM0RUNIMEd0OVNtM1JvZnQ3WE9tb1JYcEtpKzVy?=
 =?utf-8?B?aHhkWkt4VU1tN25aaEpXbUUrSzNzTXNuajgvS1E0WU1hSnNYTm1NWXI3M3ph?=
 =?utf-8?B?Q3ZvcUN3TUQ2bGdXTW9reXF0cmt3a0ttcFZ5dlhCQWlhL3hFd00ySDVYWUZr?=
 =?utf-8?B?ZW9qMk1xYnd3bDg0cHNKU0o5Z3FEZGVlYXdDR1FXZGRSdkRzMUtYQnZ3MVBo?=
 =?utf-8?B?QVEwNnBjRjI3eXBoU0xSK2lnTGJPa2ZWMTc0c2E5RGcvQWhnd0dDK1NaZWx6?=
 =?utf-8?Q?pdsCERMmTqGqXGN1ZAJFLDUC0DNOpvp9NdQywIU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9500498-a0cb-4824-e48b-08d900ccbea2
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 11:42:42.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djlkgJ27LzBh8ksMqnH9tUO9rZEt2bFlV+eYoMU+vpGO/DYwNmd7Qpsg1W0Lr6kAlUIPZj8w/k25Ou8apDQHAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Calvin,

Thanks for the feedback. I'll begin making the change and testing. I'll 
respond with V2 patch in this thread.

Regards,
Terry


On 4/14/21 9:13 PM, Calvin Walton wrote:
> On Tue, 2021-03-30 at 21:38 +0000, Terry Bowman wrote:
>> +int idx_valid_amd(int idx)
>> +{
>> +       switch (idx) {
>> +       case IDX_PKG_ENERGY:
>> +               return do_rapl & MSR_PKG_ENERGY_STAT;
> This isn't correct - MSR_PKG_ENERGY_STAT is the MSR offset, not a bit
> mask for the do_rapl bit field.
>
> The presence of MSR_PKG_ENERGY_STAT (along with MSR_RAPL_PWR_UNIT and
> MSR_CORE_ENERGY_STAT) is indicated by the RAPL_AMD_F17H bit in do_rapl,
> and can be checked with:
> 	do_rapl & RAPL_AMD_F17H
>
>
