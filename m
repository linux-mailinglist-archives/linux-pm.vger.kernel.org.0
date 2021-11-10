Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C1344C132
	for <lists+linux-pm@lfdr.de>; Wed, 10 Nov 2021 13:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhKJMbg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Nov 2021 07:31:36 -0500
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:22881
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231298AbhKJMbg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Nov 2021 07:31:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwnyDj7AxwYUPFgG86/rwZKzBu4uU3/8mHJV8LN7aGUHm3SCOlBBlC+NEhgYoFutTmm7Xy9ecNjO3KEs53dHGEZdh4RAJhJLxz2NWrmJeDZdw7bLvbOxyd35Ryw5JNGgntKVNZK+F+NFBKJN7swq+mLk3ATNR+2yvbNhHCdQBr4yCmMyiFdiwhS0A8jRLSz0zcHWAg/u8xV8onRS2MypRfKY6H/a7UkXw8SIMBo/UQaMkFkURi2cIcozgPc5kXcocERwP3pFjPSPs3C6Lbd1UBKLgFN5n+4LVQPt5bKcKJ7qp4StZm6zg0TPcZP3NTETgRAOQVlTyFXqK/sD2VWFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltK+dLjVLcnH6eXlNnB0W8qZsjqslyklxkAWNMznTi4=;
 b=cneygVRRwt0SabUjOjekgiS5cELDJzbZqreeLuXgDscgM5mn23hPaI00TOgHSLPk07gETwD2qGnYuq0lYCzdKOIJvg3IGtJn3fZtPCUJkyaHSOdOAODGDO3E/NK2u7suaKOw8Bgur2zQ1xnyWDKTGDbqAQ49BtN9hkXB87Iczl7ydCTQYzLxgrZlbLMDhPyJvldNPWinJ8qJJwJts5tWiNemLcB1ydirsAznJGPG1QTt9IceF1KGJGi19PttZ5nUkDpQ0u9Z9CtSskJXb3ha5y/Z1UWh4ZjMmtQoWhfGdsHn91jrgjyrO87wUuPqmhryKJv0aXr8z+FvJ3ys9SZVOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ltK+dLjVLcnH6eXlNnB0W8qZsjqslyklxkAWNMznTi4=;
 b=1YtxP7jN/onhARyi3LKEwRKmgBANfjVPb1aQzIhDMV+K+QCQBmMgn4HOmcIedqkPs9pEC3mU3qzpHARWYxEYk1iukKlJbmr/6H2EEQdjvl0dEKBXiNWCZqv3zfA3lmrwViv4GVVHT6QhPoXHXz39hlXDqaJgzXptBi7IxXOPvMA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1381.namprd12.prod.outlook.com
 (2603:10b6:903:42::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 12:28:45 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 12:28:45 +0000
Date:   Wed, 10 Nov 2021 20:28:06 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
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
Subject: Re: [PATCH v3 11/21] cpufreq: amd: add amd-pstate frequencies
 attributes
Message-ID: <YYu61g+eyegKDnuN@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <20211029130241.1984459-12-ray.huang@amd.com>
 <b4a2b9df-1074-dc86-be76-7f47af202b9e@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a2b9df-1074-dc86-be76-7f47af202b9e@amd.com>
X-ClientProxiedBy: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2PR06CA0022.apcprd06.prod.outlook.com (2603:1096:202:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13 via Frontend Transport; Wed, 10 Nov 2021 12:28:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 679e7b04-992c-4e02-5ef8-08d9a445a36f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1381:
X-Microsoft-Antispam-PRVS: <CY4PR12MB138162F12F67EAE714EC15B5EC939@CY4PR12MB1381.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fuy4PHVMWGlxjml+BgcNRU4qXrLH+HqoPLD/nAmXuNvZLZzBqvYi18iMu0YaXspC+/aZ7CDCubXB+8xZr5QamaBiq3ISc6d/u6/zWyuGYkz7uP5bXbW04GOgE6oG6fOWhY1HCalcm+NzsKTWWOkHUsQ9TS3mccHwy4gd7bIcUB2q91W7ca6nyseJhIc0MLMi20x2ckaYRtplvdv9C7D8EvlTLEc41Z/rUS8z9hYmjIf+gCEvWw1/12IlEldCOmzMiyfzcgkTIO2L0xNKrbatTBY6MxtnBbMb9M7ef7c0Y5KaB/cQvaYpvWNOTavUO0ThnO+rP3mXmgAl8wpOG7X3PoaZO92cnFzmTYyT2CFi6awHJ3eG5Ix+QhwPzt+yS6IQSHsEOOWnbH+NDpsicYR/OX97R0anXPK5C3qu4Wtbbb5g/rqi4C181WeU0aNeCQNsmfvPazZtRBwY46EleLaz5U1qWCGZw+WRKktFHz0u7r5ycd89JBXfX1n12H8npCKsmJ9zKpnkaSSdiOeEIQGJ+baUwCSgPK2whzp8uyXcjJyKB+mEb3NlU4pxkj6+qoWn/EBzXGnHrpEpyAVCMCwABKUhanSpfBQuF8Cp4KDdbcWIFD1s+d6jjinvlmCI4TCVLtkFZyCCv7ihrKD5UlPA01jX4MMM7Duo1CZxdVidNnU+giQ0o1cpKyu3q3AntMxoAcIjiC7n816w3abL4KAs2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(508600001)(55016002)(316002)(5660300002)(54906003)(33716001)(53546011)(9686003)(66476007)(66556008)(2906002)(8676002)(6862004)(956004)(6666004)(26005)(8936002)(4326008)(6636002)(7416002)(38100700002)(86362001)(186003)(6496006)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KSRwkpYy7ONy9N7nk9IchuuT8J0EzaJ3S7gHJ6YUfJyHKOZi4cnrylyF8IsM?=
 =?us-ascii?Q?l/kZzs0J1ehaUZru0/afozztbMkBOEA+QGNNYvD/xwAN91jmJdSYYlAMs3YP?=
 =?us-ascii?Q?6DEFYLMQqsnOkin1ecVqtyzwiYe8rlsXobzWxiV1d8Fcgt8yvPva2mW5XEkZ?=
 =?us-ascii?Q?dHNctKFgXDTwkahpbjQO6h4gKln43j7Fp4LVUzDUD6uokBo0Vc2PDlXtDN20?=
 =?us-ascii?Q?QhxHcrhcocCIB/B3uDIpQNlLsIXID4I2lWUFTMlJbMVl4vfSJrT/Om/wyOvR?=
 =?us-ascii?Q?o0AWedB12KUHIHWAU4kh+2N5EXZLNVtSOm5J7JGEDyXiMFWtD25xgCxl9I5n?=
 =?us-ascii?Q?iSWQaanNtQ8IuHKfQM0+MU+yRm90pXel8QNEFPMFBHpxoauAqiA1U89jLTLP?=
 =?us-ascii?Q?eVxFQ5xtQ0OzPuHZqKZvPYSin5fKpLmAGVupKp1iD1EO/T12Ry0m9PAp4ye4?=
 =?us-ascii?Q?AHVCjez1Wrrzu7C8jXPgu7iucVSd31QZzbnK6Fyt/ZTnQxxSAgmeLzSeP6LN?=
 =?us-ascii?Q?Kaiuia4qFx9QwOdrHx8xmEEHpYbqBrXY2kU4nmKqrirb4QGU/qw18Q83/83+?=
 =?us-ascii?Q?ORzQcJc9QgZIp7Cv5E3lj5Oq+Rm+Z5cC+UhRr26nBpQDv9WphR06QdYYWNR6?=
 =?us-ascii?Q?7I19iGDQMhpLixuE3kGIU/YVEKdmrf/L74uj9iTcUvEHyOewy75HAnKmdg1T?=
 =?us-ascii?Q?UoTsY7Hn09eb9OC1ptI192SN7BLCR3DLPNL/zv0GqkS6LzYf/BVYgGQ5Hk7H?=
 =?us-ascii?Q?r1epkRUjt7kSSnhTJ9V8b7VyhBxk+sENpzz7I2xsMNXgWXwW9qHsbJC5/ugJ?=
 =?us-ascii?Q?8le5CBqQ2Ed1M7NjU2qpL3F7AF9T82QtzA+Slpbe+KWqL8A3JjOu8wondSWs?=
 =?us-ascii?Q?x37b2qvCs2Q5fOG2TOS4tW/nx9JKEMC9vS2xVYDXSBa14Z487qGPDSLDdS0M?=
 =?us-ascii?Q?GrMzALQJdh4RiRvfRR4aoHyPa11lVfn85JvE1L0J72+AnusI4pDgsVBdBJXO?=
 =?us-ascii?Q?XfjIbm5r2CJn9GpsA2Vj42eaz0RD7Slw+EGvfCuSxwrK4V8524NG1ulhZ5ur?=
 =?us-ascii?Q?c6nW0wk/0JgxyeAYEhQsch8NNTJ4ROe90jiNtCBdFOIiucPToSWdJXkwVBhd?=
 =?us-ascii?Q?+B/7z7IKNxjvPSYVc7OyMW/eOds7PrTgwow5Bjbs9JbwPk1grFl30O+KUZKk?=
 =?us-ascii?Q?6XBW/iRo9jvQTHRJPvqWD+XANH9lQeMyS5fHj/Bv5aWuL/LdsiHRhI35qZfD?=
 =?us-ascii?Q?FK/RNaAfqu0wfXeRCIzzArdxMsycP8orUpK3CSCvKCKWOOgf68tW2YUM4DXb?=
 =?us-ascii?Q?e8H+7H2y48G37/DvEhjiaQXTglIYzQBQzU4Ayut1tCtYbSRVD8CgUOeKiKUU?=
 =?us-ascii?Q?oPiuilTJg1UKARumySgh0lDLaMgG9+ST5Z5QjoFAxCiJzF3Uq7Z3spW4h75G?=
 =?us-ascii?Q?euGUreRhch3WOJ6diGVWGK5KufojzbRz766hD1Qd9fRoqZXBCU7WWqq/w8tj?=
 =?us-ascii?Q?NiAWrIzeePxAXY9t/mlLYmMmUYwyJRwwO25omVCSbu15CuQ9CYcKvPkFtGoy?=
 =?us-ascii?Q?bzFqyjmdwyCdA//i38h4IJ1xXy77fYeXuVn1n2a4wK2cbYl1A9MdYdDVHdKR?=
 =?us-ascii?Q?aQi8vxuJ1vVJHcSfLLCAcZY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 679e7b04-992c-4e02-5ef8-08d9a445a36f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 12:28:45.3618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JC02B0iQbyzPdbP2WewSrHNXASlvnpsyI+LyKV/JOV8vII4iPq0I6KA2wZjHwP0eA851v4ytDFEt164LSGzCoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1381
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 06, 2021 at 02:59:55AM +0800, Fontenot, Nathan wrote:
> On 10/29/21 8:02 AM, Huang Rui wrote:
> > Introduce sysfs attributes to get the different level processor
> > frequencies.
> > 
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > ---
> >  drivers/cpufreq/amd-pstate.c | 63 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> > index 9af27ac1f818..8cf1e80f44e0 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -485,6 +485,68 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
> >  	return 0;
> >  }
> >  
> > +/* Sysfs attributes */
> > +
> > +/* This frequency is to indicate the maximum hardware frequency.
> > + * If boost is not active but supported, the frequency will be larger than the
> > + * one in cpuinfo.
> > + */
> > +static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
> > +					char *buf)
> > +{
> > +	int max_freq;
> > +	struct amd_cpudata *cpudata;
> > +
> > +	cpudata = policy->driver_data;
> > +
> > +	max_freq = amd_get_max_freq(cpudata);
> > +	if (max_freq < 0)
> > +		return max_freq;
> > +
> > +	return sprintf(&buf[0], "%u\n", max_freq);
> > +}
> > +
> > +static ssize_t show_amd_pstate_nominal_freq(struct cpufreq_policy *policy,
> > +					    char *buf)
> > +{
> > +	int nominal_freq;
> > +	struct amd_cpudata *cpudata;
> > +
> > +	cpudata = policy->driver_data;
> > +
> > +	nominal_freq = amd_get_nominal_freq(cpudata);
> > +	if (nominal_freq < 0)
> > +		return nominal_freq;
> > +
> > +	return sprintf(&buf[0], "%u\n", nominal_freq);
> > +}
> 
> The nominal_freq valus is already reported in sysfs by drivers/acpi since this
> value is part of the ACPI spec. Is there a reason to have multiple sysfs entries 
> for the same value?
> 

I will clean them up in V4. Thanks!

Ray
