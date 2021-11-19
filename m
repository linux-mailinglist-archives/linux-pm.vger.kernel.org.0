Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA49456E15
	for <lists+linux-pm@lfdr.de>; Fri, 19 Nov 2021 12:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbhKSLTk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Nov 2021 06:19:40 -0500
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:29184
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229521AbhKSLTk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Nov 2021 06:19:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhbT3bA44XJM9Tn8FKC943tufL7nprFT2GYcXAKovJD93hgW4kbXuj3X+e8psro7nJ03pCPLcpWw2qgulBE4Ocive9DKlE0rd5PNssNR0+Ejn/LM0zb7pvN1RYfgWZCrjzpaTuE5onGhIuNjBXBQOWCOMp6x2RLNnQ8qvTl4H5W5KLUlFNHhDg4G+lyDlYgF37cvfD/M4j0atkfkzT0rpdWwaaSruRz5ZDFx50yjmXBlaHxMK1XSv1H5dQ4SfUlHThMg25DT6sWN7M5ESOZ2Sdf6HZfS6Vk4QiQUkF24iq9vqIba8fN9rAcoXW7Z/g7RhWeUF/ejcM/Ou5KaKMlOVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dw1xn0LvobH2LOMNznseUNX9RKlfyowFvnuIzsQdFfM=;
 b=oTEBglZg4j/TQrPDFyCJzvF3PkUySqJgQX3BViJHokIiaeUMuqIq7JPqlzWRsv5/Riy5JjC2IeAC5nvwL4TOGeHebI/im3QpAkUDGx0sGqU7kW2s3MHdlI64igHwwRGNWML8aMrpDktXpvilp+q0fKoU548MQHtoJ929/S3TWQL6eHke/D8w39RY/aF9hyhpn5axAb0pMs1iMBTj5bGB4vjRiuhmnVbXA73QGiNuKOcHBk1JPo6s0oKsNiKsR5bUdRpPI00y/5VJg3cru48MFqNqUQHsV7fqTMoOmf4sevfLp6pNWpNF7L7B4i37DeV+gzTd8YT4WhCLNN9lkkCpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw1xn0LvobH2LOMNznseUNX9RKlfyowFvnuIzsQdFfM=;
 b=BR7VcrtzcUxzgzISf8uZP376uKhT5sNr+QckYZNRDD5kNMdzK6huLRwbJEXc9iodaeAAUgGqNF/5n7xOQjSSZtKDdk30jNX8/G7geIAhWQxncSCprMx8pVW2gJabIBpsaafCxBtVfmd1LC9f+Q/OHloyb4hkQY11eUdnZhj9vps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1591.namprd12.prod.outlook.com
 (2603:10b6:910:10::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 11:16:36 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 11:16:36 +0000
Date:   Fri, 19 Nov 2021 19:16:05 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 06/22] cpufreq: amd: introduce a new amd pstate driver
 to support future processors
Message-ID: <YZeHdVexjhXN45qn@hr-amd>
References: <20211119103102.88124-1-ray.huang@amd.com>
 <20211119103102.88124-7-ray.huang@amd.com>
 <YZeAohkzXVQ7Nd2Z@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZeAohkzXVQ7Nd2Z@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: HKAPR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:203:d0::19) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HKAPR04CA0009.apcprd04.prod.outlook.com (2603:1096:203:d0::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 11:16:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0002eac-4818-4392-6455-08d9ab4e0cce
X-MS-TrafficTypeDiagnostic: CY4PR12MB1591:
X-Microsoft-Antispam-PRVS: <CY4PR12MB15917653697336E822F25A62EC9C9@CY4PR12MB1591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7pH7XSpFkOZ1jIDEi4xuJ6fOyBDxXVqY9jms50TUlekz973aZeqEXOSyPa5Evq8XCoC+ydfPS0zhKJGJ3XKQRTbhaTaAOxr/HJqjwpi8tWGtcAuclJ134xOiKR9HcheXoBXTvrh8OQEMLfonCM1wxeaj3ifhs0painDNZWXXePs4NGezJCc2Xb+6pq+pWMYklbHAfSmxYWED8+uIO3Uu6xXzCJSKL4MY0A+hkh+ezQpMFrtRCBMPLRyPVGvAa36ln4iZsEoRlZuYGGlFMyjCRImM4hFnJn0KxEmxvzbFAlfTrhU11waZkKfhnqDuLYag7FUgtp02zCEQQvxnGQS6OmDwpLva/f6R3aZ4w3SrboW1CmAo1n/WUhSrYE+d55IALWxvsHDjJ/ROUQ/9+PFI4KuSYXB5Q/9N5YKw30dgACN0LJTNQs+fn3i12rjcBUz99rf0KPwGsfpd5DtsIJ39fCn3P8Cdf1TTbCireZZsfypyn0rEGWHmUw6Qplm6CuyuKMzjwSyaJ6Fy7dsMojikafgMBAPelCjqEPjQcL0TNLjy7XU2JRl6bOP7NhKCJAy1flm+TPI3og1VsCUy/olB/pLBq4qGotWNAVzBT+ic0AIirrP8gryfpBYp/oCJ0M1SZAkt32Q7lPtbHPMRb1JHJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(6916009)(38100700002)(66556008)(66476007)(508600001)(186003)(54906003)(316002)(7416002)(55016002)(26005)(6666004)(4744005)(5660300002)(8676002)(8936002)(33716001)(6496006)(2906002)(9686003)(956004)(66946007)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JOdoV7N4B4mPChMFqH+hXamibSsW4OXOP48kJifwPcQCeeDjx7VDthMh0HG3?=
 =?us-ascii?Q?4j4kX94Iqj4WmvemnaFg14+0sMB/33H8ESpLaDgqJLN6IYwmBG42gj/3EMGb?=
 =?us-ascii?Q?zF2HZ7PtoBX5c9blDhGCPHmycSY8I+Mc3fA2LD04ZLV7lG6rOWB3f9bpQbua?=
 =?us-ascii?Q?yCA/0HXnYzmYIvhRiKjGxLOsEjsX4qusRfPOBfLANR90EL2tuLSaDwMuZ1m/?=
 =?us-ascii?Q?9HL3uIAjFhLpzgpM5Z+4P0FdJcHuLHQZ9piQVO/EBU30PjV8u8RMXz2u9XUh?=
 =?us-ascii?Q?Iae4bcFA8nIR/CA7LrnEyNiZkGAGpR9wawRXxS5/K2HAnyCkjoWcJPJh70KX?=
 =?us-ascii?Q?yz1SylPQX61ZrRnuJmIzgnmcdpnHlZZfIfjyt1v7slM57I+F9DGSL4gFe2th?=
 =?us-ascii?Q?M9PrdFTMJdFzFwmknqunpdc7MX1RqalhSL8F4VSV5vDbeEOIN039nJR+s1SW?=
 =?us-ascii?Q?+Iy44mQazMezucJ6NriwZbZon+qzIpM3IkgOr4z86mf4N0XpbX5biwp+T3SE?=
 =?us-ascii?Q?rjoFDhS93xJYnK2GE2I/dUHyqFuuMeuWioVlJkffK6BRiNkqRPDutbey9eUf?=
 =?us-ascii?Q?Jz8ZjepUYJy+sbXO7TGQ53CeE01GT4M9iXmXQBpHayHL8APl6Vqo8zVmLxlK?=
 =?us-ascii?Q?S//nZcuXgZa/d8ew4x7jr3UA/5Hn76uecOPvulOqr3RIty+T15f3N5ScVkjJ?=
 =?us-ascii?Q?S7rbUZSY1/0c5DeR89xgCZr/P+ohdzjxiYenheGI/+Vo7BXB8P0dVqbKky6h?=
 =?us-ascii?Q?hUZnZcuvK1/0KNzHYQaoq3gu29IvxLw5BD2SJ7wkvz7STm66hikd93TGijjh?=
 =?us-ascii?Q?1rYOUnkUlqTl9y+Nf6TR7xhRI8s78OS4Zk4UtYD6uBQyLKCqi+/LvC+9rL2l?=
 =?us-ascii?Q?RXkwClitPvaQaTukTbSwiBJx2CwXW8o0KLxqTg9WNIU26hS76aem4WF0OC5P?=
 =?us-ascii?Q?aRdKQlqwf2235/o0hIfWUfxvY+O+YWp27wuR7zc04du9XNmgNhl9Mx3bLIC0?=
 =?us-ascii?Q?W/motOozRDuH/8B5548wRGLQegwRHiEi/pdc9uGeItQGVNGpuaSdVhhdQoON?=
 =?us-ascii?Q?nIN9J/Ye9ZPjwE4U/d9huqEwAFvA9BCNDfo82qfgWYFhWT7MLjQyD7smmDPK?=
 =?us-ascii?Q?mXfSHLOHoW9xQXe0ifdAwGeX4pk22ARqWuqG93PDGnXCNgR40BJxrljW0o9M?=
 =?us-ascii?Q?osjBzYYmXoqhaORRdgUJlhTE1RGAIR8BVmG7bUdvx29H32HsVXLiJa6WYugc?=
 =?us-ascii?Q?6hATxciXLQpqXtF3V2mcCeGB9Ss7tPr8ZE1sDmW8EooZN4HSL2zoG0qWwybq?=
 =?us-ascii?Q?eO+xSq+35M59ZnD5QosL0+5AVRxbD2grn6vg7bX2/1hqcDy4CHV6k7s6PIpd?=
 =?us-ascii?Q?EPQHPwmtBA9LeoUKcRfYcYG4t1ZJrP//8bnAAmMtjkS9PF5gVKRWbeiDpVGn?=
 =?us-ascii?Q?c19jCL0jy64Bp0ElCEM4NDE6EiHrvtIb6XV+XgB32ZwpXF41Ac1HEYAqZgsZ?=
 =?us-ascii?Q?IBeWhz5CsRZ2dOdYnkSzvCKIneaOZYHouvWnj3nv4mXrpo50dr4BZOXH+hmW?=
 =?us-ascii?Q?IXmQneWXvqVcMvENSMkRBU4CR0bVJQ153i7tCTO6Ci2j4oscu1cu2X3bU1jy?=
 =?us-ascii?Q?ybIwTOgEC0rVp5HGRCqAawI=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0002eac-4818-4392-6455-08d9ab4e0cce
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 11:16:36.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9JVNaAyIGTYPATRkiunItW/KRxebWmGuDNalihpyT95M6Yxta6HuOUH51SHuEiM4IKxPC17qBrkWbnGo+a5Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1591
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 19, 2021 at 06:46:58PM +0800, Peter Zijlstra wrote:
> On Fri, Nov 19, 2021 at 06:30:46PM +0800, Huang Rui wrote:
> > +static inline int pstate_enable(bool enable)
> > +{
> > +	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
> 
> Strictly speaking that ?: is superfluous, a _Bool when cast to scalar
> type will have exactly that value.

Right. Will update it to "wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable)".

Thanks,
Ray
