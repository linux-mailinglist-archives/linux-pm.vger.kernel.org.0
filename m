Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B190B445612
	for <lists+linux-pm@lfdr.de>; Thu,  4 Nov 2021 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhKDPNs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Nov 2021 11:13:48 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:45632
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231166AbhKDPNr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 4 Nov 2021 11:13:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYReN0exGSfihlGN/pW9A+j4RiAI1Iab1jhWD3AdMBdT35pDrhnpHsKvhPhE2kNV21/QUtWKNcoN0NfzuE2IZlnvy7PcDQyKKDsaf/1OgkifkbztPeX7XUZcSinnqf7UdjKt9EIndJV0ctSUGAn8ryu8JzWUxEnGS4CK++Rgd1EflYofQ3ptQGrHi9Bq84ba3ve87MnBDOv01nfHxfPL79r1JnN7FA8cGZKJaa3tAdXnP2lj3bveVNt4PLeDAI33Mb0E7I7NsTmwoxzyO16l1iSe1+7M30LIn6LrYt8InfDW34EJKbEsV/h9qRn3J90QntsEYzcjkEQsCnH977PSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ocDEdDKOWcSwJAq2raM4gq7dEAQIFEckiP6aEMB5HJ8=;
 b=D4m1mdBMNG5PD1Jjy6pbtFDGh5HVeVcv0k6SwHDuoM/j0ro8fUI73ioBt6YhcUAQtJKV4IxssQyqdCbPTKSZ3EVNuLKkk/sr/y7QYGOkxfzG4YIySRGHinsla3evOB3wwbtZ4SgdMYmmtg8raEU9Y3BvHv8g1Tf8Xk7f8cBHpW+6+KY4LPRjCZiuAc5Na0I0IQ1QW0Mpm22X5WM5a+mhj+NBxbUbISaTGdP88uZYl3LbyOsPCyUcBlEp+JaFEb9MWuGkYzNLDfBEr4vBklD57VNebru9o4GVZn7d3kWHWGenlEudpeXEIELl45hs2fW3lpBscCoU1dFCV+RqLqCzkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ocDEdDKOWcSwJAq2raM4gq7dEAQIFEckiP6aEMB5HJ8=;
 b=Pg7rSwUAvQR3nr5WWkwCPkNdIWSKWDwdj/JDhZsMk2UIom7ARyw1suewnR5qdeY3PhgQ4/jeh1bTrtlNaRC+zCzKyYYyCbtvFWTHWrlIAsoWdeYmpiEj3UcGu1qmM3yJnPZ8MTViuvq9P/dy9sAzeUWlbb8YB93qm2uSL2DcbK0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4709.namprd12.prod.outlook.com (2603:10b6:a03:98::16)
 by BYAPR12MB4727.namprd12.prod.outlook.com (2603:10b6:a03:99::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 15:11:04 +0000
Received: from BYAPR12MB4709.namprd12.prod.outlook.com
 ([fe80::8c48:13e2:dab3:65bf]) by BYAPR12MB4709.namprd12.prod.outlook.com
 ([fe80::8c48:13e2:dab3:65bf%6]) with mapi id 15.20.4669.013; Thu, 4 Nov 2021
 15:11:04 +0000
Subject: Re: [PATCH v3 06/21] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
To:     Huang Rui <ray.huang@amd.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-7-ray.huang@amd.com>
 <012f60e6-af5a-5102-b35f-7b14ac9ad198@amd.com> <YYIzwuzoqXRscqif@hr-amd>
From:   Nathan Fontenot <nafonten@amd.com>
Message-ID: <6e1831dc-9d7c-151c-ca83-594d249d6442@amd.com>
Date:   Thu, 4 Nov 2021 10:10:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YYIzwuzoqXRscqif@hr-amd>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0803.namprd03.prod.outlook.com
 (2603:10b6:408:13f::28) To BYAPR12MB4709.namprd12.prod.outlook.com
 (2603:10b6:a03:98::16)
MIME-Version: 1.0
Received: from [IPv6:2600:1700:271:b60:c780:6260:a8a1:c53] (2600:1700:271:b60:c780:6260:a8a1:c53) by BN9PR03CA0803.namprd03.prod.outlook.com (2603:10b6:408:13f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 15:11:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba2dc0b1-11a5-47c6-3f8f-08d99fa55190
X-MS-TrafficTypeDiagnostic: BYAPR12MB4727:
X-Microsoft-Antispam-PRVS: <BYAPR12MB47279FDD4C012901AC62C8B3EC8D9@BYAPR12MB4727.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNJt1H6U+yIo4xJRP2yyxGlvgeMfVak6jqmwVztYcOojabIVk1fPOTZ1HR818YBYD3xv2tHT41DVCtOvFXJqGKnz5q4lpmg4jRCEJFhcPO0TmA3NP4jhHk1L6YPXKcVfN2dCLw3JGzmf+eEL3+05/25p9XCmXOwNMG2fAdNA2BhpuNmME6O2xfJNAQqBsbnAYYt9y+L/OfzHOLzADR83mS8fv+aXmwIoS5HpKVMhrkMvvfrpLVfzJFDYx/e8bDL/T5q88N8OEvTdKT0Y7YCOTxIuhfPXaKrw7UDHQfKlWU/d10lOQeGJBPuwTJ60bt0rQNUvPlfrgP6N0Xg/7KF8rHEX/9URozpvH4lL9uJNYC7q43rjXY2O3DCrWvyRUICNSUX4qSPSA2PQgOLtE3Hum3Yt3CfZaeqPhTAYwmd302BkjDQ93TLDr72rchn7yvcLa4UtJ28blyv9xpQMGk+QIrr2cTtLr4FN2ERMxVfhZlxxQQvhelJ/Z1IdDvkLgDIu3labTswRifKsssJXHOwmY57nAOBfXzJsdUpF3MW10uceocOvUronulnZStNrGFu4Mi1SKTeRzVbEID2YMuhnlpw932HyOZ5X/LC4c2d9sWPnmno60qzCI4Q1QOD88QdBPrRk37O43f9KuaBSCoLCPDzlUyypFtDF7YKPaWrC7aXI5oxBKjUh7FoPRpf7/vWM6XjEXwCNvMHAd7DVU47UM2J8eUWtt1uSDWsFVX7jdsHaf3PITXE0uRDmYq2bsUgi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4709.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(110136005)(4326008)(316002)(54906003)(6486002)(31696002)(83380400001)(7416002)(36756003)(66476007)(66556008)(508600001)(186003)(53546011)(66946007)(5660300002)(2906002)(8936002)(31686004)(2616005)(8676002)(6636002)(2004002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckpzWmlodmV4TkUzdUJicHBRN2VYZFR6R2R5SHJvZGJMMm12RE5MU1I5OURG?=
 =?utf-8?B?UWZRRi9pWjJNaGJCTDdEbDZRYWdodWJGL1V1NllaYnJmTTJWNElZQ0Y1MSs4?=
 =?utf-8?B?Z0NsRjRKSWE3Q0F1QWhDdm9FNUwxNVIrV1VweDFrMFBESFZ6eDN3WWNzYnFF?=
 =?utf-8?B?M1VSSW81TFJhenJvQzEvUzNkZHNFVDdqT1QwY05BdHBaQmd5bnpxL0hqUDcr?=
 =?utf-8?B?OE5aN3puL25kZmdrS055MFNGeUF2TnZ3RkFMTkZjU2RBZDMrTGdZN010b0Y3?=
 =?utf-8?B?MENWSDdIN08xSWtySmhBMnRHR3VUWS9vRytrVWFabGFiK3NWKzRLVzUrRlN6?=
 =?utf-8?B?OGt4cjV6MmtLTU80K3QxVEtIL2xacHFBMHR2bnh2ajBQK01lWUVkeXo3SFk4?=
 =?utf-8?B?emtsVGpwSStCZHdCRmdTWEZubWcxZkQwMEhDWDlxU3BTZzZGamovTnM5ZWFE?=
 =?utf-8?B?bHZNVitsYUhrTmRnT3o4UGFHVTkrZU1KY0ZaOER0QXY4c3QzQXo2VE80WUtV?=
 =?utf-8?B?MnM5aDFYOUlrQnFkMnBDaWZNVm9wcHZrcHNTNmF0akZwOFEvUk9GbCtpTE1J?=
 =?utf-8?B?ZlRrZHF6MWQrNHV3cXQvUG5pZ081SlpZU1htUzhhWWpyTDBiQmhVMUpXWllQ?=
 =?utf-8?B?OWcwNDhTQTZvM1Z3SzVXOGpxWlBja293RDhPSUFORE5VNEM4a2syalcycHN4?=
 =?utf-8?B?RzJxQlV6bEoza1NCTFc0aWowZjVSMklPYXNwV0RQSDV2N1BLWDZRMW5zVDNF?=
 =?utf-8?B?VEg3L2VzRlFGektmNWpiSmxoQUExSWtWTkFDNStDUXlFUFR5L2xIOFAyaXY2?=
 =?utf-8?B?TzEzN21aSG9STTM2SFRvbDdnVWdEOXJlWE1hTUZicmNCZ1E3R1pBTHBHaytQ?=
 =?utf-8?B?ZlpPUkVDSDhEcUVQZTl0cXdYcVBXOXJhNzlqZTBnTGhsRC9DZkVhSStGbDdN?=
 =?utf-8?B?d0FCRFlDcDRCbWdObjJ2dFNaT1d1eWpsMktqdldBMjUwcmhlU245eXZkajdn?=
 =?utf-8?B?cG1ucHFVOGEyU0dwUXF5TkwzWXVwVUVEMzFWbyt4ZzNqWHVPVDgzNEprTTk5?=
 =?utf-8?B?Uk9PQ2g1Mm15UEIvUFE5bm4xeFp4ZUZVUmhXUE9Vc214dGNQSWJKemlFM0FD?=
 =?utf-8?B?dUJSUjZZZ21GSzAzb1R3RjhYdkhmd2VuRTg5cWVUNmtmVGNLRENJMHd1OEN0?=
 =?utf-8?B?SGI4dUpwYjQyUytNaUtQM05GRnRLdGRyWi8wV0pFczhyRzQ3bmRabVBUWmFk?=
 =?utf-8?B?Y2J6NHhCK3cxNmIydFduc3lUL2lVWGNkNDRYMEEza1FTaFR4eW42d1MwNk9O?=
 =?utf-8?B?SFcvNVk5Y2RkYmRxWGJtZ1d4OTM2S3lYNFhaNVh5UWNCUWtTOUZWTWNUWEpL?=
 =?utf-8?B?TE1BRTBZNzVwemN0V0lLUmV2RG9HaUUvT0lGWnJORkpLWTRuNjcrVHF6eGd0?=
 =?utf-8?B?ZUQzL200Rm9lNUtKRFlNeWRFTFRqUnd2VGxscm51dFdaN0p6NmMyVFZacG1y?=
 =?utf-8?B?bGRLK0tCSHVOenlDa2dGeVBuT3dPUWFQTkRhVmJwRGcvWjV5OU9ab01OakNC?=
 =?utf-8?B?WDFmTFZkRVpJcUhIaG9jbmMxT0VZUE9XV1R6aDFscmxpNVgyTnc0YXNZWXNu?=
 =?utf-8?B?THE2SE1hNExNTDQrWjdvL2FpZ1RZdmVXY2dmcTd3UGh0Z2RraHpvbk45S3B3?=
 =?utf-8?B?K3NWamxXRjY0ay95Z29hUUpNd3JoQnBNUTNJTUx2MnU4U3duWm4wZWV2K2FY?=
 =?utf-8?B?Nm56RjdwaTBLQ1JVL3lqbEpYTmJ0ZlFpL240cWtFTzFQajdzR2ZvZVZmSndK?=
 =?utf-8?B?bXBWclRoZnFONDdabzkyQnlIaXRLSzg1YVNDYWdQMzNKMCtZUlV4WVM0V0pt?=
 =?utf-8?B?Nm1zMGhIam43QzdyM0V3RFoxbzcya2lDVFlkQ3lvVTFGWDQzdmcrN3UxOGZY?=
 =?utf-8?B?RGdheitoWW0venVyTFVwcGx2U2xSQ1I1U3Y3QkpCeFdvQnVKYjRTMnd2WW02?=
 =?utf-8?B?bjZFOGVncENiRG5EUkRyMDhQWks1a2lsdjVuMDlOKzBBWFlXRkNrRU9ubExi?=
 =?utf-8?B?Yk5pQllscjhiQURwb2h3eldOcVpGUVR0aWlPN1Q5KzQrWDkwNkdNWi83M1NL?=
 =?utf-8?B?ZXZIdUhNdUVaTGhQRmROYW4wQlY0T21TMTFxWkVjeS9SWC9JQ0wvMmptZHll?=
 =?utf-8?B?ZU85VnQvTk1IQitnRjhDL0Fpd0NjR3M5RzJlbDBLblRxSDhCWWx2Y1NPMkFa?=
 =?utf-8?Q?fMkuoTNy3Im8kwyodaWtO7zs/cavxiIzVVihQnAPlU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2dc0b1-11a5-47c6-3f8f-08d99fa55190
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4709.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 15:11:03.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8e9XM2tKdWjRhyhkYCtjLn/vt/2ZxBIMae94htBJLhKgogCYVQTJQhsYzcci/rlRAAHmqgzgCivMpw0J+2ad0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4727
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 11/3/21 2:01 AM, Huang Rui wrote:

>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>> new file mode 100644
>>> index 000000000000..a400861c7fdc
>>> --- /dev/null
>>> +++ b/drivers/cpufreq/amd-pstate.c
>>> @@ -0,0 +1,413 @@
>>> +/*
>>> + * amd-pstate.c - AMD Processor P-state Frequency Driver
>>> + *
>>> + * Copyright (C) 2021 Advanced Micro Devices, Inc. All Rights Reserved.
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * as published by the Free Software Foundation; either version 2
>>> + * of the License, or (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License along with
>>> + * this program; if not, write to the Free Software
>>> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
>>
>> You should use a SPDX license identifier instead of copying the GPL text
>> in the file. See Documentation/process/license-rules.rst
> 
> The SPDX license identifier is an alternative way to instead of the common
> way to express the license at the top comment of the file. Acutally it's
> not mandatory, right?
> 

It's not mandatory but I believe using SPDX identifiers is the preferred method.

...

>>> +static int __init amd_pstate_init(void)
>>> +{
>>> +	int ret;
>>> +
>>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>>> +		return -ENODEV;
>>> +
>>> +	if (!acpi_cpc_valid()) {
>>> +		pr_debug("%s, the _CPC object is not present in SBIOS\n",
>>> +			 __func__);
>>
>> Do we need to print the function name here (and below)?
> 
> It's a soft reminder to tell the user where the message comes from.
>

True, but you do define pr_fmt at the top of the file so users will know
this is coming from the amd_pstate driver.

-Nathan
