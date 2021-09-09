Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 891C9405D5B
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 21:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbhIITcm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 15:32:42 -0400
Received: from mail-co1nam11on2058.outbound.protection.outlook.com ([40.107.220.58]:23520
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231422AbhIITcl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 15:32:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic2eyuSsYpkwTKVo7KBMUrS7zRIWQ22L4pEWID2hHOpsjxdauf7KNkYSv9bSP/mb1IvXbWIhQXO6wGhQz1nsOpN7ixdipV0pqdI+VB5tiYSpQs7RjR4bN+Y/bLbrkPxU9HZlauUgecICNdjDhHFmFlOyiBsHBoV6KTEv6q2o+8f284UgKdvNjI9y0IVpv+hefu0LD5dCZvshRgkKmGY+AIu1gvmslWAnePrRVT55Mc18Ch3+Gn/kntNyraPcScxorRusPW8bmWqZs4bgJOaW6NQrOxKc4Fj5aWLX0diFWQKhsBTqo7LrYSZ0iCRxTFfn4WFL3Mrn9M+IxpMm1YxyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=p5s7fVjCFXAq3gW8XF221Vw6BhgO8FOD9VZ8560aptY=;
 b=c+BP0pROJRCsXZmJ6A0nnOWMuL34njzOISoGDN0623sd7lia8FRz6aYXDn6UEU11iP9rk5X4bjb/0Y8P5dLmK/BWYH54UBAVMPD/2p0H5GtdMpClEfTQb8Lvkg/7RRLKbRAb4fLjF2snUT2HhZYQOj2tTG8S/BT+LmgDCc0MEOstkxLIj4vaOHMV+clCWWVN4FjX1tdnobwUhxLh+f3hCjV1Kta0eOC08wU/KpYpoiTpjOoV3O15Ywl2z6qQ6P7IGxmzueUA6EySPO8OEwerKpMxmvbX5cAM0pnBFCvwm1hjYyIBbaM7PjfH9jj+sWtZhBQk5VBOgWR/booeJ9K+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5s7fVjCFXAq3gW8XF221Vw6BhgO8FOD9VZ8560aptY=;
 b=Eq0AFwInKQ9scAch1QBJBjPDWd8ibdsJNNOiHGEpH952YLrb6bT+kLJJGShWpuivxfha4Ofzy45Rpve8jnpSLv6RbrsfiHxeLPJPpyFA+oLhIkPlhx3fmfO0mhFuIdJ+92cxp21R4OETAQe3ua1K0yRpTahDdyf8FRvO4qWJTME=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4709.namprd12.prod.outlook.com (2603:10b6:a03:98::16)
 by BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 19:31:30 +0000
Received: from BYAPR12MB4709.namprd12.prod.outlook.com
 ([fe80::35a7:2615:6509:583]) by BYAPR12MB4709.namprd12.prod.outlook.com
 ([fe80::35a7:2615:6509:583%5]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 19:31:30 +0000
Subject: Re: [PATCH 04/19] cpufreq: amd: introduce a new amd pstate driver to
 support future processors
To:     Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        linux-pm@vger.kernel.org
Cc:     Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <20210908150001.3702552-1-ray.huang@amd.com>
 <20210908150001.3702552-5-ray.huang@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <c9601b78-10ce-e4c1-6056-3d1922c0ed41@amd.com>
Date:   Thu, 9 Sep 2021 14:31:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20210908150001.3702552-5-ray.huang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:806:f2::28) To BYAPR12MB4709.namprd12.prod.outlook.com
 (2603:10b6:a03:98::16)
MIME-Version: 1.0
Received: from [172.31.130.72] (165.204.78.25) by SN7PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:f2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Thu, 9 Sep 2021 19:31:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d01c0caa-d310-4cd0-cb5a-08d973c86c35
X-MS-TrafficTypeDiagnostic: BYAPR12MB3095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB309530B6D601F692C4987BB1ECD59@BYAPR12MB3095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MwBc4p81N3df4YYgY0gozgpXdCTZ52A+hTUAYE9K6YveoMzGOnNmuwiDq38b7/eMX/3Scdo4qwiFZMkK0E7cXcTTPlM91bfxjtbJg3NCVsifAMQA/8J1tkqR9ox6RaOf5PQMesTMdR4WSycB9NHvj8NrNRrwU2Rr6cGtzLePDoZEvby22jdKeTRf+OYxaA9cm8GbZ5rEwoEf66AYZyY4d6+a+mDZaFEYUxGPDkak89qoT4zSnGdnZWvNCwhgwCsMltQXAhKaBChUvDuUF2AtbhT6g4KovH9fhEek2bdKlYbQRsLDJgBkevpz+zEbT1zg4sHP7Vc1huW++JAnYkwzgGVanw765JBavTp5s4/1b92MYRak0QK9FG/wWVox8y+xEzgYblLXUKded0McL9sbhtdskMnM9/0S0pesIdPyffxnOok4L4B5pxsYDm2DfktKzZgUqUrtqtM6OWnOdPr8rG9DMZXRriHe1QZ+lyYqaMtqapRJpbiNYlZ48hmxbTXapRlgDPBIOkXD3c23wnftgUUYbS/Rj8PVGDkoUcqysKlIosKpRY+uD01D685AggtLhC+PbR42TPY2kweXJbxk3D//khOIgZ6zKJtD2g2yJ4EPycaHC42+h1XN1EbgduDCTU/h1VxnhpOWYTIQPfC5e0dbjmU5fFxqwpeaCOWeWCa5uOLYsVhSggZZLI5MfXifsTa59dLdrl1O+KH06DUyyOA7dXXGtCqm2p8RW+4dnKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4709.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(4326008)(110136005)(54906003)(5660300002)(316002)(8936002)(26005)(16576012)(53546011)(66556008)(66476007)(66946007)(186003)(83380400001)(478600001)(86362001)(31696002)(38100700002)(6486002)(2616005)(956004)(36756003)(8676002)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejFXUWQwcGtxQUwxZFdlSk5ob0dKOTdXUFMxcUF3YVk1YUVWYUtWNUw4SVVH?=
 =?utf-8?B?YnkyMGYxY2JobDMxUHRXVGhYSFdTNm5sYmVtdi9QVlM2UlFoTG1pVTlGRXVz?=
 =?utf-8?B?QzErSzBFdlg3dzRkUDdkVzBPV3Uvci9KS0FBWlUwZ1BianNBZ3FVVnFzZVVM?=
 =?utf-8?B?ZXprZVhVa0c0Mlk2VElxRTVpNDczMXJjREZUemM4OGZCNTZPMkNDazZ0K3k5?=
 =?utf-8?B?d2k0NGRabVBOc3JIV0REeHI3NEVUTVM5NjNtUzZzQnphL2RURHFMdmFVRUVp?=
 =?utf-8?B?cXk1TzVQNkw4NWZYVWpheHVKSkd6ZmJHNDJHMVRJdnljeUFtY1lKTU5uMlZU?=
 =?utf-8?B?dHlCdyt6RkNuQ0RZMGo4bGpEelU1TU1QdWlaYTJ3QkNGeFlRRW5nMEJwWGYv?=
 =?utf-8?B?WDJtREczb2h2MW9lMmxBeXBjcUFEa0dvdld6L1ZCZmxOSnV2a1poNTlxZmUr?=
 =?utf-8?B?WnRVWnZVVkliTzNhZHhQRnhhVm5URGI2dkJ3MDZCbDlNZTNUVHNtSjBjSWNv?=
 =?utf-8?B?b3JrUDNtdzlOcUtTZlZHYVcyOE9QS1JMOXR3RGRadmdhWk9Cejc2ajRCMnVv?=
 =?utf-8?B?TUtGRm5mYm5kMDFrVU9lemdQMGI5a0haT0E2T0FmRHNReWZpRGZmWmFJSTB2?=
 =?utf-8?B?ZTQvNFRWZmMwcERkQkV1eitwRDBPRFNjN29xN1VxZUlqcXYxN1JVRzZHSU5R?=
 =?utf-8?B?cEpOWWVQWFJ6b2YxN0ZqR1YxNzBDNUFSUE9CaE1va0hmWkFITi8vakMvdVdi?=
 =?utf-8?B?YkpFSGxETTVoYWRCRC9OREZFYnJxVTBLcGZVdzFmN1N3bVBNNEJyeGVIV1FI?=
 =?utf-8?B?UWlXTUV6djhwWktFQ3AvQ1QreWdTUWJneXdKTGV0a0VFUGpHbW9aektmS1hx?=
 =?utf-8?B?TndKTEQwSFhrMTdETDVkQkRNUWJUZUVncDFCcWlndDFqVEN2SnYyQkV6OGdt?=
 =?utf-8?B?a3REOGFYcWZHcjJwdlg4dm1McTBvQVBHcjBGZ0xJeDRETDRzRWdVWDIrNUVq?=
 =?utf-8?B?c2g5YUhjOUVDUWJMTTdkclJjMnNud25BL3g0eWtlMjVsR2NRNzFXZGJRcWdB?=
 =?utf-8?B?dkUvdDhWYW44ZE9ZOUhucWtGdUtDaWlwdlVnSkRiMFk4S1IrMmpJWmlhTFpa?=
 =?utf-8?B?a2pTT01NbVF1UXBSNlh6NmtoK2d0bitHRkJibndXaXRRZ2p1d0RlRUtEV1h5?=
 =?utf-8?B?ZFJFekJSUGVmMmJYeWpMcE9HZ2RETGVGUWFxYWFpUEt5M2VLMkhjbUw0K2sy?=
 =?utf-8?B?WWpLRFFKYm94bWlZWXZPdWIrS2c1M3haeHFETmYzWlRhWnlOQkc1eGNXMXNT?=
 =?utf-8?B?M2pQc3d6NHhVTGxFaDc0OWJ1MFVqalNwMDRndEl2dDMxWjVRVVBSNFJTYytH?=
 =?utf-8?B?N0dDaUVxdVBLcTZBWkt0ZjBRRWV5TmZTbDVzeFo2bHlLL3IwbnliWWg0ejBS?=
 =?utf-8?B?MzVDRjNwTDBDSkU0VVBoK0IvbnEyVWdpamMyd2lyMTdsM2RrUlp3eThLbFp2?=
 =?utf-8?B?QVNOQkFDbGNNaGlwRFhuWXVzeVhhWWFtalZ2NmlIN2N0VkxPdzcyMndCWlZ3?=
 =?utf-8?B?MlAxd2ErOGdhZXlwVk5XRGh6SjVGWkxrTlYvVmU3VE1maHBuRll0dGZuMzM1?=
 =?utf-8?B?Q3ZBUFg2d0pJb09JVzF6aEgwMTdvR29wWVhlZVlGY3doYm83ajRPTTM2WkZS?=
 =?utf-8?B?YWZwMk5CazZpbGx0MkpQRWo3bmFZVnNXcHJMeU1URGswQTh6S3pmV2xqOFg0?=
 =?utf-8?Q?XyeNbDQktKdkmMp84WtMxmy+jheq9DkXLiMgnYo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d01c0caa-d310-4cd0-cb5a-08d973c86c35
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4709.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 19:31:29.7954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4xX0VBeZL4To5185JdE1X2UvReBEqhSUdH9yqqLk+a/cI5VxOcWWLYmIqo1kwouMJm9ycQuYXzXG6fQFBnIZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 9/8/2021 9:59 AM, Huang Rui wrote:
> amd-pstate is the AMD CPU performance scaling driver that introduces a
> new CPU frequency control mechanism on AMD Zen based CPU series in Linux
> kernel. The new mechanism is based on Collaborative processor
> performance control (CPPC) which is finer grain frequency management
> than legacy ACPI hardware P-States. Current AMD CPU platforms are using
> the ACPI P-states driver to manage CPU frequency and clocks with
> switching only in 3 P-states. AMD P-States is to replace the ACPI
> P-states controls, allows a flexible, low-latency interface for the
> Linux kernel to directly communicate the performance hints to hardware.
>

This patch seems like it is just enabling CPPC on AMD and not a new mechanism
based on CPPC. Can you clarify?

Also, if this is just enabling CPPC, shouldn't the driver be named something
like amd_cppc and not amd_pstate? This isn't using P-states.
 
> "amd-pstate" leverages the Linux kernel governors such as *schedutil*,
> *ondemand*, etc. to manage the performance hints which are provided by CPPC
> hardware functionality. The first version for amd-pstate is to support one
> of the Zen3 processors, and we will support more in future after we verify
> the hardware and SBIOS functionalities.
> 
> There are two types of hardware implementations for amd-pstate: one is full
> MSR support and another is shared memory support. It can use
> X86_FEATURE_AMD_CPPC_EXT feature flag to distinguish the different types.
>

Looking at the drivers/acpi code for CPPC I don't think this distinction
between MSRs and shared memory requires a feature flag. Shouldn't this be
handled properly in cpc_read|write if the ACPI tables are set up correctly?
Please correct me if I'm wrong.

This would also remove the need for the additional indirection pointed
out by Peter.

Could you also provide an explanation as to why a new CPPC driver is need
instead of updating the existing cppc_cpufreq driver.

-Nathan
