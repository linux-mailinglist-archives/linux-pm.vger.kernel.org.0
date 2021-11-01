Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F38B4415BE
	for <lists+linux-pm@lfdr.de>; Mon,  1 Nov 2021 10:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhKAJFn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Nov 2021 05:05:43 -0400
Received: from mail-dm6nam11on2072.outbound.protection.outlook.com ([40.107.223.72]:31361
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230520AbhKAJFm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 Nov 2021 05:05:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVeACK+XEJ9zCcE0UhjiIjElptrlBTfYdg3B95lYxwaNLEKjF1xUC7AGgSglZuGb7nUuBKK4FEwZcx57JjffCPUemV3slJwKFPt7C25VaFKi39bapnJoQ8gk5ONWfl7qb0z7rN85CerZe4kDnktTfLaENjGAQmTjfuChjMo+C82YU5WtNWurwx+FHcts61h6kbPJ2SDhC9kNmqpfOnNF0fYHs8LSRCbmJyc9cMeVMDQpkKBgcGUc5e/tzYAkKpdIsbsOpOnTXqbw3SjtpB4xP1IvcCjXEDQPRrn24bh0+aYQWC5TkigmAeJArA4AFQvq/yjZMyEvHNC/BWbOK6ammQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u8wmKfO7m+gsIrUcEBgmMJ9jSzgStz19yFzo9zSqcr0=;
 b=YGuVKwY727dg9fF9HW7alO5jLtEUUTBkIjuNSuFgFgp0ZHEHjf1E9NzRLeMukNUSypyEzKA+1wSOiYUNlCBMrzkYJbdDArNrXoYAKOJ7K+ROvWsmYQsLkClhU6O2hcsjF/i2tH7bKRB7xREjB9LnkB4iNVQBPMVVnkJ7G7LmSzTMmNvMXhO8sAp7On5+AJYwxMvrFZ28HQkRBdYIsYY0e1jTGGrUxCONXnOl1futbT2HxQuuYDwpzv91Nz0unxfKGJrjPlPT7J5CnxXRVFzAUdlNS6tb09opZon5sw+5ftapE4eYTI9qHtLKSjphGhwzGiqPunH532krHXOTcuffGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u8wmKfO7m+gsIrUcEBgmMJ9jSzgStz19yFzo9zSqcr0=;
 b=4GwSsiJW3zry/AV+ZxqPGgbtl0usvzbALHHXtj6qThqiBxrBseD++XmUJrn+UAHyAXp7t4Eo2czWcUdZrO+XKJX0IO+X6gc7OjnEB6ouWe35Mdrljjp+iLMMm8WHk9geixCLNY3t4HD8JfO38MUlBR+0VXoIGaoQ0ufYuvO2aMQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1864.namprd12.prod.outlook.com
 (2603:10b6:903:11c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Mon, 1 Nov
 2021 09:03:07 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4649.019; Mon, 1 Nov 2021
 09:03:07 +0000
Date:   Mon, 1 Nov 2021 17:02:43 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
        Steven Noonan <steven@valvesoftware.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>,
        "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 08/21] cpufreq: amd: add acpi cppc function as the
 backend for legacy processors
Message-ID: <YX+tM7FOQBKqHetw@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-9-ray.huang@amd.com>
 <16386852-7ccb-47de-5b29-b64481b59237@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16386852-7ccb-47de-5b29-b64481b59237@amd.com>
X-ClientProxiedBy: HKAPR03CA0021.apcprd03.prod.outlook.com
 (2603:1096:203:c9::8) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HKAPR03CA0021.apcprd03.prod.outlook.com (2603:1096:203:c9::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.6 via Frontend Transport; Mon, 1 Nov 2021 09:03:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 558f681d-5dbb-4e12-fd22-08d99d166b8d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1864:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1864DC91DAF775A0CD5533C7EC8A9@CY4PR12MB1864.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uizw43o6o6IVXvAMAHQ4jRprpvgN2aRB3E2rkG9leeQohp4zU/z0dS+kAAXVsCDwc09ad8lYJ7PXiI2q8G52C0HN3Gr/5yEybWN67naQA60XdknLh5WSO0p+He6uvQi0J6IA4pNSsZN5pnP57LG48IBGKw/HMe0HDZYhUAFUZHaTGlLPqQB9Sd2+fg6L6Q1RRao/EMRFF6kmB/QhkJF7vrDKQ+eMOA2Y25SNocIqfiVugH4+eXKcCP+NMHhn9VO2flqDx1v0bFhdWNP+DDs2qeUjVq61C+b+JsZDVEfZtIbtmRAguSmqGmvIdSqkzK8xzYM5Yr8PH112+NETMkXESohvizajEK1zEZCwDuP1uTwqAzQksSEhuDOW2G9rfHpVMzO/BEmB56KXDukiNUg/e6bAasCpN2VbjFb9ZvGoTlW1qlPlnewcFRP8/tGEg2/0NNhoRiTKepQN7XU31lq6Z6rZ0tgZqTuk0navInIzh8GIkg/a1VKNadFjkfgy8gpOrE95kiGkK7yQEpbEH25V+wB0R0TdkcjjINF+hVkMaWvXOLT9b+x2157jOUcZ86dnfocS7o/0QvOq1lYDh43iPHQOTzm5/9STni97hgEJEg2dp8UKNRmibuS5Hbg89EsM57l3dNZFD7FaJbUEGvoP2t8go6qiNYD1P+BCGTHLt5Hf/R0F1jVM+Of2YJxko5ig
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(508600001)(9686003)(316002)(6862004)(55016002)(83380400001)(66476007)(8936002)(66556008)(33716001)(54906003)(38100700002)(8676002)(5660300002)(6496006)(956004)(26005)(4326008)(53546011)(66946007)(7416002)(186003)(86362001)(6636002)(2906002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Akvo65018BgQB8XnDv3mmVYzEH2GqNmm0i2voME7rFTrKWpoO95FVPg4TCtR?=
 =?us-ascii?Q?dIt8KazLtEqBZkjezpfvrvykPVqr6/Erybu2AJeCjCuJ/R1IgwhPSGBXUpP1?=
 =?us-ascii?Q?1HohIXYP3e7c/WcvLh3luejSMP8k1AHGiS4gT8UsgcxNemRp6aAL4GxPo6de?=
 =?us-ascii?Q?fQgWrfD4rKa9Vxc1a11CjfQ4JDx9vREJPn5/m5JlbKj06iauuQ66/UZfbhgI?=
 =?us-ascii?Q?V4cuQk/l7PLrUc25GgMOcRYt1U2eGbEGAivv7YqM5tkRLqpum28lutwg28sX?=
 =?us-ascii?Q?eVeHjVHcUABD8cWnJbJy/e6YIaaoNtCQKqEg9u4SnuLw49cn96P8efl/KSsp?=
 =?us-ascii?Q?3w9W0gK/nex0RAB87Y6KFfHtRQb5I6AXT5Gi/thGIZE6YK7MieUuTKWnY3fN?=
 =?us-ascii?Q?k1KBWmQMxsg2Nb9GGkixj9YjusCLVkKuLVaj2ao2qSTBCAUIYjshCHH8TFO3?=
 =?us-ascii?Q?mM1eAlN2rZV5Sxlxr2bOYLCl/uNAr8V/cHjkIFG4DHhx6qYAn0RhaPu8m223?=
 =?us-ascii?Q?KSAR2gWToVeoCJ4UoZuCxUk8TFSHEvbTGInV88jTj0P4za2cNUtniGwRXMgk?=
 =?us-ascii?Q?75Bj+aR4k9OqIQI1l/E8qaPEfFhotiofQsDQHbBKX/n7AbrkfZ6qsL7lQal7?=
 =?us-ascii?Q?w6DH+sdVmrdDjJkcM+UnY5IjZ4bKFaPDh+kucsq9NFF3YOL1Ouo+hnpULF3R?=
 =?us-ascii?Q?/kSpVEsgD/y42ufAzWLYJRtHbU+2r1gqUiIUGXbREg9P0A/WAegCIq0mkOR7?=
 =?us-ascii?Q?k750vRaMolAf4GUXJd2zzqzQ7/il5BnC14Jj4YIZhq9Cca+kmYW7GnrI7ILI?=
 =?us-ascii?Q?uFC0FMEsK4+SoSHwO8jbQ+Itqd3wbDtnYV5op5omZkO9MRGGAkXZI5uPaNaz?=
 =?us-ascii?Q?ER0fpE44hAVyQhP9H1l3q0ShYhusXO6GkTJYu9UCsoXL11hrRpXxTYGnkllK?=
 =?us-ascii?Q?gTK0stlnzTqI2U+C6/32mb1RGzCziQ8D+JPBVF//lVkgwNLh0CX6uuyqJJ5D?=
 =?us-ascii?Q?cDCC5Jvblr+mygRIh1mP3CuR3BeipFm97eZzFcPhtbT48q80TnSy0TvchJ8v?=
 =?us-ascii?Q?/QZODh8qEcqlZrL1f88XpWWUDnAQJ/L9WbRxm0rHg31WVkbKKo1bMbOUYFte?=
 =?us-ascii?Q?83CbCHlmLpmnAOgOTNyR4oxqg+SJCaYCYfSq5k43tP9FkTYf7qwjb9oNG85k?=
 =?us-ascii?Q?oF4L24g6tS3u6XIiDkvW0IFLWO5Pv6bfnM8A23CAcLHqs0uDF7arMIpMcRmv?=
 =?us-ascii?Q?wkXmlyR06+zxRJA8XLRP/qlwKhJxjoAKMOo5crRRe6AVHUya3PmdIqH13/x2?=
 =?us-ascii?Q?+/fXLvLyxCDE0RzfRU59WXmTrSq3Gh0sJOVk0nx2uTQuxrdgfB6cvRIB+FE+?=
 =?us-ascii?Q?5WzpO3E9o2uQDKAES4ii7SA6uQY1iOVmc0awTyuidP7lHtLD4UK/KBdz2GXh?=
 =?us-ascii?Q?WARvZqOG3vXfd8qtCkXQDqwaeQ6DoZrvj2YTk2B75ufmWSm8DohUrMlcdmQm?=
 =?us-ascii?Q?gLG9lM7cdPDJo5s+GyUGZbd33qWiaf0Dk6QFhFKVh1qAqduxOHzxWjXti0eL?=
 =?us-ascii?Q?+n3pKfIpIFAx89+1PiztQ757/T3UmYNujNVBiZUNpL8w9SFmhJnLsQcFR/xK?=
 =?us-ascii?Q?REmPTe+4jHdei0G2mry9sew=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558f681d-5dbb-4e12-fd22-08d99d166b8d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2021 09:03:07.0853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xgG2MpLsnZsADYRDFtDwi/CGDF4tGpcwBR0opOMYWVyUOpMpKPCXsSjmNSlL3bopYbhaQEeAYvkftF6M1ub/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1864
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 29, 2021 at 10:20:09PM +0800, Limonciello, Mario wrote:
> On 10/29/2021 08:02, Huang Rui wrote:
> > In some old Zen based processors, they are using the shared memory that
> > exposed from ACPI SBIOS.
> 
> I don't think this is only "old" processors.  I think there are "new" 
> processors that just don't happen to implement the MSR too.
> 

Yes, I will correct the description.

> > 
> > Signed-off-by: Jinzhou Su <Jinzhou.Su@amd.com>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >   drivers/cpufreq/amd-pstate.c | 58 ++++++++++++++++++++++++++++++++----
> >   1 file changed, 53 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 55ff03f85608..d399938d6d85 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -73,6 +73,19 @@ static inline int pstate_enable(bool enable)
> >   	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable ? 1 : 0);
> >   }
> >   
> > +static int cppc_enable(bool enable)
> > +{
> > +	int cpu, ret = 0;
> > +
> > +	for_each_online_cpu(cpu) {
> 
> I wonder if this should also be changed to present CPU instead of 
> offline CPU.  Otherwise could this turn into a situation that the user 
> starts with some CPU's offlined and enables them later but this doesn't 
> end up applying to the CPUs that were started offlined and changed?
> 

Yes, make sense. It is actually similiar with previous acpi_cpc_valid fix
patch. I will update it in V4.

Thanks,
Ray
