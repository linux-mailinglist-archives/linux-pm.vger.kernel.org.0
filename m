Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7F2447CAE
	for <lists+linux-pm@lfdr.de>; Mon,  8 Nov 2021 10:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbhKHJXl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Nov 2021 04:23:41 -0500
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:12792
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236719AbhKHJXh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Nov 2021 04:23:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRu4rCU4ZGUiDrYmy0Euz0xuNkbLEekKnxACE8wb/CYA4eqlXjN1Bac4FyhVUF+kbKbW86cSikStzn+8XOVdaYvrE727zwO1Zc4O0EAGSNT6YXWj5MrXIUHr0USUUFfmTCXM12w1AnZdYRrYzWFeXO4NYadQUv6dUF63TTthGees4/epahQRW8kAKtGzZN4+/u1pWJbFcSYcviXkiW6EQybXH2VfAkP2ENZDalghRKaUUZHJFhQyrNLQbh/pwefXd5yThuzREd7vemlTzCWUfqZr3HVJXuPBqKicCSGD2fb892qI6yEOz9HrgpJp4IYQlo+FmrahhpAfUc1+hSoj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tl2aHXBt8hzdPbwoAZxBmLvCbrmL+I2CzpyaPd7nfbE=;
 b=FRGbZzVBlbw3Gk5hJ06CE9Eq0PE8pJBv80YEv/YEMqyq+Pkk2AMn49SHj906vPNtPRlAWxw/TX9HHa8Hyvo+WA2MRjU/4mvwLxkiNtfOrm/f9v9Wbek4EFANUuLDM7dy25cB00aJojcyok+I6n/8aWl8AOl84wITeaTYDuORxKVnilAGLIqcgFfR5HsTVYAJmY2MpO0oXG3NS6loP0C5FLHOJ50T5OZRuy0g+hct5BXNPJV6K1xkWbMqq2qbqVrc8jhN8olOIRQu5uAnyNGhkLY0VL1xeWfyMts7xge6mKwUAY+BNST5tb+8CVOOGVFtDcb9TkAI4qErRiweqyxL5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tl2aHXBt8hzdPbwoAZxBmLvCbrmL+I2CzpyaPd7nfbE=;
 b=0pboANgsGlCmCl6dTUN7owUocuRXJGqwqAbLFv74Puz8aP1L5SfOmKuwrYiXrBxf9K6+CceZegCbJgk+KysqbgFgiRV12ufpm8SU4U4nRRi6+gesY/Mc+kxmVh9oAIH+Y20xQZTgvDe1Wf1JxqMN3xoxKkx/ZYHcFjz1gQGDKXY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16) by CY4PR12MB1782.namprd12.prod.outlook.com
 (2603:10b6:903:123::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.15; Mon, 8 Nov
 2021 09:20:50 +0000
Received: from CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697]) by CY4PR1201MB0246.namprd12.prod.outlook.com
 ([fe80::5d29:d78d:3e89:b697%3]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 09:20:50 +0000
Date:   Mon, 8 Nov 2021 17:20:24 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Matt McDonald <gardotd426@gmail.com>
Cc:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [PATCH v3 00/21] cpufreq: introduce a new AMD CPU frequency
 control mechanism
Message-ID: <YYjr2Oi3gqJPFm8x@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <a0e932477e9b826c0781dda1d0d2953e57f904cc.camel@suse.cz>
 <YYVXV/sCbO0mPVK2@hr-amd>
 <f9323c6fddd4a55d8ca4191a9539ebd056221045.camel@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f9323c6fddd4a55d8ca4191a9539ebd056221045.camel@gmail.com>
X-ClientProxiedBy: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To CY4PR1201MB0246.namprd12.prod.outlook.com
 (2603:10b6:910:23::16)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.3 via Frontend Transport; Mon, 8 Nov 2021 09:20:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d302b146-ce91-432f-ef51-08d9a2990e06
X-MS-TrafficTypeDiagnostic: CY4PR12MB1782:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1782CEBFC6D85CF5917A9D94EC919@CY4PR12MB1782.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T2LkblHqYTuctfsMvOpS+4SR4s2Ty8zz2ILSbSsDEQsDfI205XfDlqZuXForLCy5UpVUYfJ5/9fNhMgHKQpNZJ2cUuQUdnJgaWoy6BX+wECtpdSFglRxB/OUCnwp1WSdd1lrGzK+oSlz+kb8sc6ZFAMzrj4HuyKpsKxzELc00HHDJYlwQXvd49gZVGL56awMR/ZYB7ApiXTVFfMOUN6tMQhmeNH0BMzv5LybGLj9Iy+As8qEpUSPmFmYRCZP3OD1WYOgkz+SPYB3iCMkbCWr1FzYK1tI1HzcBdjIJckaQOEE2X0IpunluoFhUDESCEGx2v0GzPgdEVU1HzahjpRprhAZV9sFoaa7x63zO4/ImRwePwS1oU8MO5HBQaUyCiEtj5sCL7A4A2d1TN+vsXdsC5b53pXJDLUJ9RTOORDbI0GGo07wh236Y/vt4AcsCJ4KkmuLB+iyDb6ft9p8y/R6Mz6vENWlFHDgJa4gtVeby6vPisyzxHXUG/2F8y7fmQC18qS7OIwT242Qwiiz0tDLMy+AeOpgPxNdi7gvCWEkKPMDpbczZekUKLhvf3epBUX4sjyhJL+SMNJXLir3oag1kw+iSQ2W3soYRF5eizfz5os3E+f0a4zyFRuQ3krNbFoQBymYKt0LBd84AQmPgiR8Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB0246.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6666004)(7416002)(5660300002)(6496006)(54906003)(9686003)(38100700002)(33716001)(8676002)(26005)(956004)(55016002)(4326008)(508600001)(86362001)(66556008)(66946007)(6916009)(316002)(186003)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ml0ESYqGz0JMIzidYTR/srNi+pgv4/+xS2XanFrM0DwHh42k8E/wObXyV6?=
 =?iso-8859-1?Q?T/G5uzE1V/LCwWEPnkZQX3xdvw3HrrIJ0ZJQVxgkq4OajG8EpK/JLaUeWK?=
 =?iso-8859-1?Q?MpRmVq2G79v9Q6RANwMS9F9LgChCJ6IJaIO33QCQahxFC7rHRd0UsVJc49?=
 =?iso-8859-1?Q?OprsQi0UXvAqgUlDCxION50UlZtZdGs3VRlqEfEHY4ha3KIsDXp0cD7wdO?=
 =?iso-8859-1?Q?S0holv6F57JizaMzSiFHlHTxE8PjxU6l0pWEdIwJ2XPlOiKK2g/R2+vsz0?=
 =?iso-8859-1?Q?JghtGKz2bvMN4MILDWSKfb9ekoAT3PItFwLc6URbC8aLiSjeaQMJby/Hr6?=
 =?iso-8859-1?Q?voQbT7ennGtehFfU/NojVKT6HV93Kg44MXIyq/h24FL2eqppZjeyT+hY4O?=
 =?iso-8859-1?Q?H+dcknUgcZB1Z4IvbuTLEj3VLdU/99NEMf/QDSXiXs5Dx638ojPr4nOV4f?=
 =?iso-8859-1?Q?CKuCxU0FNzHTxrivOdKPpQeBHRvV29d/t+Kk3o5eATM82ae2nWkmqMiMmd?=
 =?iso-8859-1?Q?xEfIYAWs5MgD8KaiINQC1QwO5E9+6wBNLLiBPbdx0806S721USMyfxBWHv?=
 =?iso-8859-1?Q?4vS1hAoDgUxjS0itiSkvbsc9xibedra8g4cK+NK+kmU3jMMhNBkUk7HfpA?=
 =?iso-8859-1?Q?Ragx8Bk7SaxNnY0F5RdiKyExK1f1VzKaIk45CZ7LwpjERcSo4HC+oDrJai?=
 =?iso-8859-1?Q?uetHw5/c98xOlzUddXPAfEB8pjLWwlQ9gZsZJiYiDIUl/rNAFBevZsJgAS?=
 =?iso-8859-1?Q?Tc7gKu6Js4meFJX1jGnTBf3itYP0AZDn00nuKWzSjjrBGSo+vOqAXr+MVg?=
 =?iso-8859-1?Q?8zQ3fWTwB648FZJIBqDz5yxOMMw99RW+TV2XrHS0OKED78B++XkFyaKc4d?=
 =?iso-8859-1?Q?EFLjfeot7MMVEMzK6R3CgFeWkU44C+WeBqdds7DowplqJb8jtx+gQ6Izgi?=
 =?iso-8859-1?Q?9fncHDOO+q3KThotoGnG6At1kuVFyuAg/O2XyaPXok7yFyapxdn2/A9w+y?=
 =?iso-8859-1?Q?3/IZAwgNfOxpoBuBOWscBxUzbnoqQUKuH6sqtzojCGKxInK2Ck8mQu3Tkz?=
 =?iso-8859-1?Q?74+pyzjphDqq7TkZeasx1PJoJXVOjwZVZ0nvd9fMaT54JSfAVlkOXNSn8x?=
 =?iso-8859-1?Q?fPyC0DBqQvVZjQY19s3ARJ0SQbjAM/8xZSBy/Bfd9yfTABJqv8J8Ix3pdk?=
 =?iso-8859-1?Q?msCKNx2n6PquN5YIDx9zMfz57S4vNZTRnR72EQqMmPHzgMftq4Hwdu8eG4?=
 =?iso-8859-1?Q?6q8GE8qGlr4OwIayaYM4P/oaSgA1U64ziXE+kHN1byeTprQSgOeVIaWqQN?=
 =?iso-8859-1?Q?CnFtHIi3fRlCczuRbZlGSkn9lhaqa3kk6NIAVmor+z0EujPC1f8T6iaLgV?=
 =?iso-8859-1?Q?yQiGVb/6XfpAoMX0XOsy132Td2jqR6MSk6bxGNBQ8uQkR7ecQydBl5RtRz?=
 =?iso-8859-1?Q?bPJ8Vs12AdCGGnpqBbJXangjdL1r4cDBM5wBooVsqkP9lc3IvEqclEIoHs?=
 =?iso-8859-1?Q?Wn0YK471MHUQA9dCXk271wDG4JSqrd3pMB+PoTJIvBPZakzM/Y76g6g4XS?=
 =?iso-8859-1?Q?HJ1X/ouveTgoTyip1JSi4bZa8Fu/LudDf55yDG59sYX8iKhvwICdtqc3Zb?=
 =?iso-8859-1?Q?IS4pHNjz8ZCu9PnmARGnjt8v18YmTOfiNUTVauvcF5qBclwcmLLR6DEW93?=
 =?iso-8859-1?Q?R6akNrt0KcKLecqgI38=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d302b146-ce91-432f-ef51-08d9a2990e06
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0246.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 09:20:50.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nlbYoewSBqUOuqM5dYC0O4ZmEhjE/HJNzAI4ti9PLAztn+hPGsxdjAmPMO8a3zblP3jv3COXDbNvZu5GI8IXCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1782
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Nov 06, 2021 at 04:58:35PM +0800, Matt McDonald wrote:
> > > I've tested this driver and it seems the results are a little
> > > underwhelming.
> > > The test machine is a two sockets server with two AMD EPYC 7713,
> > > family:model:stepping 25:1:1, 128 cores/256 threads, 256G of memory
> > > and SSD
> > > storage. On this system, the amd-pstate driver works only in
> > > "shared memory support", not in "full MSR support",
> > > meaning that frequency switches are triggered from a workqueue
> > > instead of scheduler context (!fast_switch).
> 
> Huang, I've also done some detailed testing, and while many synthetic
> benchmarks seem to show minimal differences between this new frequency
> control mechanism and acpi_cpufreq, the general user experience seems a
> bit degraded, but most of all, gaming performance in many instances (if
> not all) is cut in half. Fully half. 
> 
> I have an RTX 3090 and a Ryzen 9 5900X, with 32GB (4x8) DDR4 3600. In

May we know the family/model id of your processors?

> Control with DLSS and RT enabled, on 5.15.rc5 with acpi_cpufreq, I get
> 120-130 fps at 1440p. The same exact kernel with v3 of AMD_CPPC gives
> me 50 fps. GPU usage is still at 100, but the CPU frequency is being
> reported as like 5100Mhz*, and other assorted weirdness, but most
> importantly the fps is stuck at 50. This is regardless of performance
> scheduler (schedutil, ondemand, userspace or performance). 

May we know your SMU version in your SBIOS?

Thanks,
Ray

> 
> *My CPU can indeed boost over 5GHz on a single core here and there, but
> this was constant and on all cores, so clearly it wasn't accurate.
> 
> Also, from the documentation it looks like there's supposed to be a way
> to fall back to acpi_cpufreq, but I found no such way to do that. If
> AMD_CPPC was built into the kernel, I had to use amd-pstate, there was
> no other option. Maybe I misinterpreted and acpi-cpufreq is only able
> to be used as a fallback for CPUs that don't support amd-pstate.
> 
> I know that gaming on Linux hasn't historically been one of AMD's
> priorities with their CPUs, but with the Steam Deck upcoming I would
> imagine this is a pretty important use-case, and I've tested multiple
> games and they all lose a full 50% performance. I'm happy to test any
> revisions or even kernel parameters or whatever else to try and get
> this sorted. 
> 
> 
> 
> > Would you mind that we add a module param or filter the known good
> > processors (mobile parts) to load amd-pstate. And others can use the
> > param
> > to switch between amd-pstate and acpi-cpufreq manually? After we
> > address the
> > performance gap, then we can switch it back.
> 
> 
> This would be something I would be interested to try.
> 
> > 
> > It seems the issue mainly from the processors with big number of
> > cores and
> > threads. Let's find the similiar family threadripper or EYPC
> > processors to
> > duplicate the test results. Will contact at you for details. :-)
> 
> This may be an interesting route of investigation, I could potentially
> try running a game with `taskset -c 0-7` or something similar. 
> 
> > 
> 
