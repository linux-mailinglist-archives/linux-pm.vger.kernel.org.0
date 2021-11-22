Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF23458815
	for <lists+linux-pm@lfdr.de>; Mon, 22 Nov 2021 03:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhKVCol (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Nov 2021 21:44:41 -0500
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:31328
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229686AbhKVCol (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 21 Nov 2021 21:44:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fEPXnPxLuthYWHRXPFpiDS4YimcNOGmomfp3thjbzES+oKghGmoQncm3MLm2bdUt77m9YIpHLup7nkL8jAtiYdXT9UGdT6QaPuypbvM775NffIhDpC9LNSEjUo94z8OwzC5jmTLoPvv2mf7DvQUmC1I6UwtM/nbinTxyEgVJU4uJ3CN90345YBNUi7D3v0FZr324g3K+me4W9eYb0+mB+TAXe2gc8HTHNnY2QEJiexB2/Ju9qEmFZGxEMZgEYAeTtN2O8CoEspXvsjddpbFoQx5oOkFOIcRB/7OGQKwF3Lma1QKrpGtAiGZod8WaFbjelM99xFrcPzfyioE1x+r2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JycNe1v4G4kl7XgrtFTwMXZfB5Xg5WQ4EkToFYQ2FaQ=;
 b=Vl8TsMZ+2Zkk4jg1UYnq+vxcqgKeh/4TwYoeK1YhzSi2di3Sl4CAY/5Bu3yBKpXxfSx6hWruXppmXRsUOe5/LQJxaPmxp329YIdWyl8s3UousW0E0Wk1BcBQGkVNOUoszKPYByG+VudAQA9sUSx5RJaC4D8IyEHRs3tExH9PzRSrchSRfWmZ50ImnRKNc1XUaLe9C2sY2Mwm2kxmWLTjudAEIexcIzp306Pyou5Ygzu0GsjK6N4O15CzMU2XGdXWHpmwXZHR8YPU1FIcuKev51aBrKcHUCmcCq3PTfvVUodal5+zns4lfHwtL+Ns8Yaee/lDoMSAKybh3XHr/gek0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JycNe1v4G4kl7XgrtFTwMXZfB5Xg5WQ4EkToFYQ2FaQ=;
 b=WIqby4cm0aNQIrXT0GFYNPmUHhDtUTMAmphMgAl749+vRDxBQpyqpcuT3FHiLEpKUU8M9vN0NolhPq5MxSE/4c5zyABKUo89SboiLM7j3p97Y+pc0MeEzfEL1ttoD8GPxfQXtsPD7CVp/KUaruPOqPErvizssgHmRRWtBssIYWc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22)
 by BY5PR12MB3682.namprd12.prod.outlook.com (2603:10b6:a03:195::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 02:41:30 +0000
Received: from BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193]) by BY5PR12MB4918.namprd12.prod.outlook.com
 ([fe80::d519:1ea0:33a6:8193%6]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 02:41:30 +0000
Date:   Mon, 22 Nov 2021 10:41:04 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Juuso Alasuutari <juuso.alasuutari@gmail.com>,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Cc:     "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "bp@suse.de" <bp@suse.de>,
        "Sharma, Deepak" <Deepak.Sharma@amd.com>,
        "ggherdovich@suse.cz" <ggherdovich@suse.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "steven@valvesoftware.com" <steven@valvesoftware.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v4 16/22] cpupower: add the function to get the sysfs
 value from specific table
Message-ID: <YZsDQBzfuW51LT+t@hr-amd>
References: <152fb29e-c558-ec2f-7ec6-65d7f62274b7@amd.com>
 <20211119221943.92479-1-juuso.alasuutari@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119221943.92479-1-juuso.alasuutari@gmail.com>
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To BY5PR12MB4918.namprd12.prod.outlook.com
 (2603:10b6:a03:1df::22)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by SG2PR02CA0047.apcprd02.prod.outlook.com (2603:1096:3:18::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Mon, 22 Nov 2021 02:41:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3faa81d7-5dd7-4a7e-2aab-08d9ad61968b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3682:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3682E898224D9A48196CC05CEC9F9@BY5PR12MB3682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jvR50DzUGjRCfix8Qe0FDRHU5bIdj6S322PJRzEAO2FymE46BUc8ETajZ6+9KTVRdDbmuDNqr4ZsX3erdZljXMemQtSvHbg7+Kl3adKykq2/ZwUXRuw75y1hwOKn+htRhQNRvllCvsbAge71TDCYFB/nEyu3qnOCK/e6pyjmZLqKWR3y000lOW1RwPQLrdMR+GCLiloxmoqUPBZXRmbRuEvYG2A5cVY3aJzvQyBpT8QpKrdPdOimfsWjT8KmKhomuSLHuD3HW7BWtchqHaEMgVqgj8eGfpkM+uSmITldTpLUwFnDX8fJ5i+4ZlvTlIEgZLkaR9FVMJqZE/PYbsFHNxhwHsbxmuhhZ2ezg0S5LCScv2A1H+3VqShWkmSXAtpbugRYfKN0OsM+YLRdHQoon5tWHINoSpIXzIDHcPAXTy7ti/H+EYC//kADMOTo+4LxjWYcZ/uAdCKp94hZlSRoOgbTAkDEZkHGrJ7RQyJ8T2GhpTttp7kLjuNal11vDx8v+eeCMYjXk0EU1/BNmi0m4CfBJsUkczoRUMH6dZ4F9nBqLAAL93/T8YDUf6BTRy8bvPR0l9qBNi4qdJ9ptswms+facDSQ9U+C0R6aeSvmzgOsKAQYgdBCTDhPG6Wr3QQbt6Fjd3GHuHqZNCPuVvkZsqbVUwCpscegbVBp56IAA1pKwZuXAFYH1VsTrGlDxdEsxGMqILTEKGgTKb1B+2GlrwLoe+9myRByWsKh0LSyNUc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4918.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6496006)(9686003)(55016002)(8676002)(54906003)(110136005)(316002)(6636002)(66476007)(956004)(86362001)(5660300002)(4326008)(53546011)(66946007)(66556008)(26005)(6666004)(186003)(33716001)(2906002)(38100700002)(7416002)(508600001)(83380400001)(15583001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bfbI1mYBqqE2T6Z/HirDJ2HS01/2bB+xA9kcvGFkbC3ywUF/Be3GGUTPSxA2?=
 =?us-ascii?Q?RmNnjCIRq8K44jnBsU4t2O2+A9sTbCmYmhG+jiiusPwqit9BjesM52A0G4bZ?=
 =?us-ascii?Q?5NdN8aSbu2dkiywcdoJI5baK1NMhfcLk8h533jkSNWPFWYJkGQSIAOUFvppI?=
 =?us-ascii?Q?5cGYaWMPUyEh6COkRW3Xo5oXbHo8tiURSU32NwA57LdBw7KPqkIhRFTSrem7?=
 =?us-ascii?Q?gzoYzd89PSMu2kIS0QcbiA/yvYD8mOLRMgX/iTlR7VxotkSKHq5W86Whl9Oh?=
 =?us-ascii?Q?kmNnzX0uRIXyAIuE0CmW2/fZ0Bt4N165Cq6rNo9ZmiZNELHsGhTfUCmIUc5B?=
 =?us-ascii?Q?SAHOwBbstiLHqhiq8YupRMvaivqsFapKtGaTRPxKibm18bnt+/3uNo1iyJKZ?=
 =?us-ascii?Q?y3iJP90IuKmI0ZwmhJTFSOh1/FeEoW9YzHB5jKaLuGMfYZvNrMLNYE6MgzPi?=
 =?us-ascii?Q?Z1A9acB2zVObNv1MSYAWdtMZxnE1rDufaKDRPs57BRFQ94TFzylA79Kmpk9D?=
 =?us-ascii?Q?QaTUT4bYmnaLxLyCNZ7hzNShz4BLGwp/kgNERuz4s+dj7EjSpUumZiJMCMFU?=
 =?us-ascii?Q?CWoioQ8URkDs/PEiHtsiySbeslsaFKOXH1AQ/BC3r+e87aUvpAnfSRBpND/X?=
 =?us-ascii?Q?OWRaQSBxISZP814dS1mGrp8IWjqLEQFXqysh3v6/NVgeuCWeDiHNLlAqmCGL?=
 =?us-ascii?Q?I0NqGzdzSeuMivWIq6/V9/eZKssi5/LbnVAPofY8L0gbfsS/OH6MyPFrLFzN?=
 =?us-ascii?Q?UhTL2u5vP+xKZudN/8goxJ80WZ2ZpfqaOC7DAPIWMBNThH+VhdoGevY/ZuPI?=
 =?us-ascii?Q?gftimTowDt8tt1gI2Wja7gtH1fsfxXo7Cg99YwLBIedfwnLx9VahLH0lKID5?=
 =?us-ascii?Q?AAkJHE+rNXmzNinsgmnYPzF9416jlqEATTEtUmATmgfNXW8OnzldYefkudKN?=
 =?us-ascii?Q?Y/tyh8FGL87vS3+5Tcy7PziuJJhNIVv//9/JoB7sLhD4RbvBuk5beOQYklrK?=
 =?us-ascii?Q?Yzc8txt7oVhoPBar09W3UNJ7UA6MPs8KIrxWFwygsrd5BkeJG3JxKX0upAMd?=
 =?us-ascii?Q?+ngFwMUhLJMZaC9a5OZseY1flDIJpHWQzcdYTz+WQNbzHaHO9nzg64t9sKmS?=
 =?us-ascii?Q?LLIE3y9rHWT6tx0mc3meaG9867ZAjC9YQiS/C/k7hUlo6lNb/Cv8QK5KlPrc?=
 =?us-ascii?Q?ErV4iLBhtsEy44RV66NJM9elzFFipxYeKBoey1FiIXESc/w/3Tv9SlAi0mUD?=
 =?us-ascii?Q?okFrF5ed/ksNLdbXjxSK3MyXc0OEbIWOyEue9xTuvIIbG4YOnq9Sx3cZXw63?=
 =?us-ascii?Q?CjkezQZQn2gOxe6so6K5DoGZMvtuSrDc2dVqa8ScrWMCFnLQHDbDqtmDDWFE?=
 =?us-ascii?Q?w1teyCGlRYDF0tlK0ZMe7HP+cep7DAlnvKM2hF+EEOKtiwl3WwqUj9PifS36?=
 =?us-ascii?Q?TjpV9qb2R1QDCsL78pUXClLvc8y/podgfrBeP38Ib5opljEabqTxPgJYO5lD?=
 =?us-ascii?Q?PsN3mJBitIzWnQh0YuzbF9shBacdDyTf1ZWhC0lMktmOD6oaBfyZDUT8JCc2?=
 =?us-ascii?Q?6fmsXdbM9sSnUW4Lc8V8+4VYK8YiK8omgdSZbJpjRGaxxA2Ln4SEFZXrs7Ce?=
 =?us-ascii?Q?RmoVa2g+oJ/AwsF7Htjihl4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faa81d7-5dd7-4a7e-2aab-08d9ad61968b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4918.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 02:41:30.3281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLsiSEEoIHOX+TTBzN9ThvpsEM2FLetQ0k1HR7cFFexJlVqhJ9uU4lNYhVNPbXVGJmOp4SHCLSu/465AG0xxuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3682
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 20, 2021 at 06:19:43AM +0800, Juuso Alasuutari wrote:
> On Fri, 19 Nov 2021 14:38:58 -0600, Nathan Fontenot wrote:
> > On 11/19/21 4:30 AM, Huang Rui wrote:
> > > Expose the helper into cpufreq header, then cpufreq driver can use this
> > > function to get the sysfs value if it has any specific sysfs interfaces.
> > > 
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >  tools/power/cpupower/lib/cpufreq.c | 21 +++++++++++++++------
> > >  tools/power/cpupower/lib/cpufreq.h | 12 ++++++++++++
> > >  2 files changed, 27 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/tools/power/cpupower/lib/cpufreq.c b/tools/power/cpupower/lib/cpufreq.c
> > > index c3b56db8b921..02719cc400a1 100644
> > > --- a/tools/power/cpupower/lib/cpufreq.c
> > > +++ b/tools/power/cpupower/lib/cpufreq.c
> > > @@ -83,20 +83,21 @@ static const char *cpufreq_value_files[MAX_CPUFREQ_VALUE_READ_FILES] = {
> > >  	[STATS_NUM_TRANSITIONS] = "stats/total_trans"
> > >  };
> > >  
> > > -
> > > -static unsigned long sysfs_cpufreq_get_one_value(unsigned int cpu,
> > > -						 enum cpufreq_value which)
> > > +unsigned long cpufreq_get_sysfs_value_from_table(unsigned int cpu,
> > > +						 const char **table,
> > > +						 unsigned index,
> > > +						 unsigned size)
> > >  {
> > >  	unsigned long value;
> > >  	unsigned int len;
> > >  	char linebuf[MAX_LINE_LEN];
> > >  	char *endp;
> > >  
> > > -	if (which >= MAX_CPUFREQ_VALUE_READ_FILES)
> > > +	if (!table && !table[index] && index >= size)
> > 
> > Should you validate the index before accessing table[index]
> > 
> >         if (!table && index >= size && !table[index])
> 
> The operator is wrong as well. I believe this is what was originally intended:
> 
> 	if (!table || index >= size || !table[index])

Yes, nice catch. Thanks. Updated it.

Thanks,
Ray
