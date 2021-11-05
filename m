Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1EC4466C3
	for <lists+linux-pm@lfdr.de>; Fri,  5 Nov 2021 17:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhKEQNB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Nov 2021 12:13:01 -0400
Received: from mail-mw2nam08on2080.outbound.protection.outlook.com ([40.107.101.80]:15811
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232773AbhKEQNA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Nov 2021 12:13:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVlreiXUZBImK6KWz61uLXpJKl5XYIkAO2gWeIgTEdSj7KxgRogovZp/fdDzMsAGxALZs5dWSu/nbbikmhazTH5uOzaz4Xtxs2ZCgKQYKylWcOnwhjwdAy7R0IXEy/10zckpjwGeFAehgnPPdBDEhzldFSid7iM0BrCG04dhpNqQr1VYpxFSOgrPxHlVXDa/pNxFsYKW/ZweiB1QUSNA4EV1ZGjpiASFcijDBThI6lqMqLUJJj3cZh345JVFOcelTF2fp2zyOlicG0rDakBgANgBHUFjJK6nxsY6gfuDWXMsC8KgLpPUuAiF/rUFQF3XoSd0ThmSi60wUAMGqCZvbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2BKOYUExTthJpORxjBQFRHObc27PGmBWo94ZnkdsHc=;
 b=SEhSBL4fmqDBjxNWJ3i3uWNIfzoN0pC0IXRQL8gfGMQPwIpQdthZF9NuEFTSipzOfXNIuayMkluonUOhYhK5FoKE/LVnHSr8E9adCibOoXQ2EKKX1bVY8uCU4Wc/k2fkizexIx1wJjGAkgUus1N42ZvJn6LYBDYm79d26zzXSje22iiR3TBrn/FK+jtGHWbAi6skqm28xBSU7zZI5wjks0B10OfHAVhl37hbSn0uMo/EAI/+bkw9JKvR5np8vq1+ylwF8/Un61FR++Gj8Ra5guLqYllLsYO5V+OkxJdrZZERXjqqCw/rMvR7WNRixcQ/6olA2gvyppQAgr0BXrfzsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2BKOYUExTthJpORxjBQFRHObc27PGmBWo94ZnkdsHc=;
 b=Q0WXpUN0XU38KBA4LnTb0eza+TStAEf3gQSk2MCv/NJTEr39esNAGaCkgv9qN4Jyt8AINAkJm0PJt0DcL1S10yrA91Y5eB8muDNFiP8PuaMYezXdXANSGhv4tnyx+RHBOK6jl/BhbtBRYlWpSzRhEJ+8mWvYc13AqHnvDTzD5Y8=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0249.namprd12.prod.outlook.com (2603:10b6:4:57::8)
 by DM6PR12MB3979.namprd12.prod.outlook.com (2603:10b6:5:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 16:10:18 +0000
Received: from DM5PR1201MB0249.namprd12.prod.outlook.com
 ([fe80::85fc:d7b2:ba34:d7d6]) by DM5PR1201MB0249.namprd12.prod.outlook.com
 ([fe80::85fc:d7b2:ba34:d7d6%5]) with mapi id 15.20.4669.013; Fri, 5 Nov 2021
 16:10:18 +0000
Date:   Sat, 6 Nov 2021 00:09:59 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     Giovanni Gherdovich <ggherdovich@suse.cz>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
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
Message-ID: <YYVXV/sCbO0mPVK2@hr-amd>
References: <20211029130241.1984459-1-ray.huang@amd.com>
 <a0e932477e9b826c0781dda1d0d2953e57f904cc.camel@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0e932477e9b826c0781dda1d0d2953e57f904cc.camel@suse.cz>
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To DM5PR1201MB0249.namprd12.prod.outlook.com
 (2603:10b6:4:57::8)
MIME-Version: 1.0
Received: from hr-amd (165.204.134.251) by HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 16:10:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10b64974-5f95-4371-ad5f-08d9a076c267
X-MS-TrafficTypeDiagnostic: DM6PR12MB3979:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3979E4CC9A271AAE56255CF4EC8E9@DM6PR12MB3979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uF11hM0XTwnrBcoJWLFThSU3O9IDxFbJZpar1gv66faVk/jkymRhZGQOBPjTnCevSFYDSos4omdWxPjmyz4H7oJTTi6oLgzTpKc+3vfvzWlSL88r2biTYQ6M2U3G494m2jNlLOIVmzL/fbwAbYltPs0OSLrpb92Zl2zifgxQ9ExCr2PHIVkrrYemdUCbry5Du5l2L6+BPTq5ruuaoTwWdOeOLw4VjZNrk9cFaAnS3Fw6Sxnq3m+v2f6KgkIxqnn9OPm/GP6GgJg+/WnpOEMDkzuiid+2/VeX9zCVqKUTc/WGc8bqjSW/RiEDPCYZ9Seffxg+iWX8aFmK+aTeWEla4r19fe7v0mpkOMYsztC5lYP/9TSX5EC7MDUwuTTgxTOvCjjIFEQ1b39vbBJ89OwwSeyHn9xPQCiDNN3rbyvr9tL75UWBUpo7nLNHt9JA6rK+kty8rJWc8jtaPrO2aCfX+xIGo9GvV9FgnHLuiQbjlStjgAkL7xmHhczdqGfSxxv3QJB9Hq4gEQ1oZJtR5yWwtSFH704+jnX9/2sF352ZWgZsipUIWFEwbey5yXkra6CL2lTr4BTzxCPuPYwBoUbyA0JW7b/8kYftnzzGe3I3EnHMiiSfAaY1aVkHgMCDSRisTqcbwbSgbvTr+yPpq4iyow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4326008)(6496006)(66946007)(83380400001)(8936002)(7416002)(6916009)(8676002)(4001150100001)(33716001)(26005)(38100700002)(6666004)(54906003)(66556008)(66476007)(186003)(956004)(9686003)(55016002)(5660300002)(2906002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8BbzKcmyd6cwnhI88ywqrK492KnOpaPDX4o4P1p7c7XH7nBRRmpNqD6Q437?=
 =?us-ascii?Q?9XCN2ls31u+GG1DqhB899h4M4w+a7C0olUSndDGnlyO5mYyjG+I8/GbSMzzs?=
 =?us-ascii?Q?TakeKQyd58YF9+BiZortzFRaUQC9VLEizBUJLsCzMKjbwFXphLG5+6PC2cgG?=
 =?us-ascii?Q?LWC8z1KHYaZmjqlutbEZ/hIWsw2YIblWJW6QGdn1Zxgabh5lALi3RoKhJbOR?=
 =?us-ascii?Q?JcfW0PuZbJb4cy4ELBqu+Oaz6F+lmy18bFZkWsArvzoHY1cdEg7HWBdAGbCv?=
 =?us-ascii?Q?RcEXE/yIW2cs9S17fvRQg9pFWoOLipATZo1Y8h853H7QbIIMqogdE+zunT9h?=
 =?us-ascii?Q?lLESzMM4TgPVnAuzSQ+ytI+iuWueKoG1/mTxGiTeF5/ZLKfanmqcy1x4p5vX?=
 =?us-ascii?Q?cxieAkQlhl5kUTWevJd5sccwKwzKjwlwuq4GYvIm7NEPM6PYzQbMhuVGf4se?=
 =?us-ascii?Q?ulGFNEgM2eg1kIL4rPmo7F+FaArQUF8hG22xNjIaw9G+38BqXywWjdxDvI0e?=
 =?us-ascii?Q?AMG7ea3JrFQpZyFUajzpAUT8vVoSv/pmo7NR/sglNZTYzeEClALy+nqrz/IQ?=
 =?us-ascii?Q?BmM7ZjOIo/uSjCsA6Sv1w+o3nrpz5YVSP+c98bnYQ3gIrFucTM23sFf3Zcbw?=
 =?us-ascii?Q?oGkDn18oOXjj4zIEjtz3pIQt7tSnm7VRMRk4QMX8YMVBCKX7OStkuMHycl49?=
 =?us-ascii?Q?41lSJvSGU7ilpGrnlpXczI7fAbDtD70LXChdn3VTii1snh+XbtKOpHWdLg3d?=
 =?us-ascii?Q?8D9RdNfyBduYOuijePyWhlEim2ldC+ESTBx8icRDBstdzxzbR7+JuM+0OMdR?=
 =?us-ascii?Q?+00sOuOi+w5WigyFWDHZsy5+R3CEKZ68hSIKGN8dIXX02QOxUZUutL93uzrc?=
 =?us-ascii?Q?0eV/nl9TGIQYI1B0yRcHmd5xeLuONpW53mVnRr7Xdl/erJUUlK2yjX/b5Vxz?=
 =?us-ascii?Q?4mHqpjJFQYPY8cWYdvkEsot8DjguRUeCZl3heMZ+5ZxPN8iT74yKcRiTtKGt?=
 =?us-ascii?Q?Nchb1qOVSgjUyGi3ylmiXRD7iqbjvQRxK0U+KNB/pYb1p87NArIbhMQPDcqV?=
 =?us-ascii?Q?J6vie8S1OQQdt5WOMbFf0Ww/bJ3YezcSyFoad0pKEStGsp6FAK9JFDhH124f?=
 =?us-ascii?Q?yQflXQeHxFkVKg7mK5Tngl1qJ2zimQ6zsZFZMjQ5sfqKYlzinGsBw4X7t+Bk?=
 =?us-ascii?Q?qFkhRDLq6zCk+E9p4goM4Mqm7Hdimwzsc/2CGb9mo3AQO2JoYbApl3qYNWhm?=
 =?us-ascii?Q?ikseCI/PjMqGd+38YcbrgevpWo1A0dWTkR9JU7IUUWuPqbxLBgn4Hc4RjNd0?=
 =?us-ascii?Q?C+uBzg6dBN3kLqhPKeKBlffbdGqEaSmmavZVF1j3EhAMSLtCJXLazAjDwthI?=
 =?us-ascii?Q?dT54z6owZrJ+SPCnJS2fmqMdkn8QOP0JGp4G57FYxJBpCNQL+wrDKLZxE/dS?=
 =?us-ascii?Q?/90chEEz74B6ANtbvS64MkxaGrUStx4tmkXnQzYN4Kfb2zG7hCzb3Ds+vvYK?=
 =?us-ascii?Q?yUe1OaS98gvl8fiDYpZ4EyAGJqEKmKCfSW0tgOhFsVyWT7xbmVXhsFBbo2k6?=
 =?us-ascii?Q?ilyaWtX28eAvkDNlm58bzgFHx4hoYGiqidJiSb1YTr8iKR3lq5wxSLS7b+mC?=
 =?us-ascii?Q?5UXWh0EGGgUHKINYlzmydMU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b64974-5f95-4371-ad5f-08d9a076c267
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 16:10:17.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ALSJPWeDQ5PeQ/D5ct4zn4yCNJPekPmrLltUMo9Pqk3zeTrWKhKFPBn+QkpTRX5ygbyqdBwUOlDwnsqeadv+hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3979
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Nov 05, 2021 at 12:40:18AM +0800, Giovanni Gherdovich wrote:
> On Fri, 2021-10-29 at 21:02 +0800, Huang Rui wrote:
> > Hi all,
> > 
> > We would like to introduce a new AMD CPU frequency control mechanism as the
> > "amd-pstate" driver for modern AMD Zen based CPU series in Linux Kernel.
> > 
> > ..snip..
> 
> Hello,
> 
> I've tested this driver and it seems the results are a little underwhelming.
> The test machine is a two sockets server with two AMD EPYC 7713,
> family:model:stepping 25:1:1, 128 cores/256 threads, 256G of memory and SSD
> storage. On this system, the amd-pstate driver works only in "shared memory
> support", not in "full MSR support", meaning that frequency switches are
> triggered from a workqueue instead of scheduler context (!fast_switch).
> 

Hi Giovanni,

I am really appreciated for the detailed tests and analysis! Thank you!

The initial driver was developed on a mobile CPU (Cezanne) with 8 cores/16
threads which supports the "full MSR" solution. And we spent a lot of time
to debug with BIOS, SMU firmware, and hardware guys to bring up this driver
on this CPU. The test results we provided were based on those series of
processors.

For the processors with "shared memory solution", we bring it up in a short
time recently to hope more AMD processors to also support new driver. :-)
Although our CPUs comply with the ACPI standard theoretically, different
processors have different SBIOS and SMU firmware (I assumed you know this
in previous mail). In real case, we need to verify it one by one, because
there are some differences in SBIOS ACPI _CPC table and firmware
implementation.

Of course, right now, we can start to optimize other processors and "shared
memory solution" in parallel.

Would you mind that we add a module param or filter the known good
processors (mobile parts) to load amd-pstate. And others can use the param
to switch between amd-pstate and acpi-cpufreq manually? After we address the
performance gap, then we can switch it back.

> Dbench sees some ludicrous improvements in both performance and performance
> per watt; likewise netperf sees some modest improvements, but that's about
> the only good news. Schedutil/ondemand on tbench and hackbench do worse
> with amd-pstate than acpi-cpufreq. I don't have data for
> ondemand/amd-pstate on kernbench and gitsource, but schedutil regresses on
> both.
> 
> Here the tables, then some questions & discussion points.
> 
> Tilde (~) means the result is the same as baseline (which is, the ratio is close to 1).
> "Sugov" means "schedutil governor", "perfgov" means "performance governor".
> 
>              :        acpi-cpufreq          :        amd-pstate          :
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>              :  ondemand  sugov  perfgov    :  ondemand  sugov  perfgov  :  better if
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>                                        PERFORMANCE RATIOS
> dbench       :  1.00      ~      0.33       :  0.37      0.35   0.36     :  lower
> netperf      :  1.00      0.97   ~          :  1.03      1.04   ~        :  higher
> tbench       :  1.00      1.04   1.06       :  0.83      0.40   1.05     :  higher
> hackbench    :  1.00      ~      1.03       :  1.09      1.42   1.03     :  lower
> kernbench    :  1.00      0.96   0.97       :  N/A       1.08   ~        :  lower
> gitsource    :  1.00      0.67   0.69       :  N/A       0.79   0.67     :  lower
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>                                   PERFORMANCE-PER-WATT RATIOS
> dbench4      :  1.00      ~      3.37       :  2.68      3.12   3.03     :  higher
> netperf      :  1.00      0.96   ~          :  1.09      1.06   ~        :  higher
> tbench4      :  1.00      1.03   1.06       :  0.76      0.34   1.04     :  higher
> hackbench    :  1.00      ~      0.95       :  0.88      0.65   0.96     :  higher
> kernbench    :  1.00      1.06   1.05       :  N/A       0.93   1.05     :  higher
> gitsource    :  1.00      1.53   1.50       :  N/A       1.33   1.55     :  higher
> 
> 
> How to read the table: all numbers are ratios of the results of some
> governor/driver combination and ondemand/acpi-cpufreq, which is the
> baseline (first column). When the "better if" column says "higher", a ratio
> larger than 1 indicates an improvement; otherwise it's a regression.
> Example: hackbench with sugov/amd-pstate is 42% slower than with
> ondemand/acpi-cpufreq (top table). At the same time, it's also 35% less
> efficient (bottom table).

It seems the issue mainly from the processors with big number of cores and
threads. Let's find the similiar family threadripper or EYPC processors to
duplicate the test results. Will contact at you for details. :-)

> 
> Now, some questions / possible troubleshooting directions:
> 
> - ACPI-CPUFREQ DRIVER: REQUESTS ARE HINTS OR MANDATES?
>   When using acpi-cpufreq, and the OS requests some frequency (one of the
>   three allowed P-States), does the hardware underneath stick to it? Or
>   does it do some ulterior adjustment based on the load?
>   This would tell if a machine using acpi-cpufreq is less dumb than it
>   seems, and can in principle do fine-grain adjustments all the same.
> 

The acpi-cpufreq driver should request the frequency level to go, however,
the firmware has a policy to adjust clock as well according to the hardware
condition such as voltage, electricity, and temperature. Legacy ACPI
P-state doesn't have any transaction to firmware side. But on amd-pstate,
the firmware can detects the performance goals as the hints that driver
provides.

> - PROCESSING CPPC DOORBELL REQUESTS: HOW FAST IS THAT?
>   How long does it take the hardware to process the CPPC doorbell
>   request to change frequency? What happens to outstanding requests, if
>   they're not processed in a timely manner? Is there any queue of requests,
>   and if so, how long is it? Could it be that if requests come in too quickly
>   the CPU ends up playing catch-up on freq switches that are obsoletes or
>   redundant?

That's a good question. We need to consult with firmware and hardware guys.
Or any method, we can caculate it from software side.

> 
> - LIKE-FOR-LIKE: TRY BENCHMARKING WITH AMD-PSTATE LIMITED TO 3 P-STATES?
>   Could it be that to study the performance of the "shared memory support"
>   system against acpi-cpufreq a more like-to-like comparison would be to limit
>   amd-pstate to only the 3 P-States available to acpi-cpufreq? That would be
>   for experimental/benchmarking purposes only. Eg: on my machines acpi-cpufreq
>   sees 1.5GHz, 1.7GHz and 2GHz. Given that max boost is 3.72GHz, and the CPPC
>   range is the abstract interval 0..255, I could limit amd-pstate to only set
>   performance level of 68, 102 and 137, and see what it gives against the old
>   driver. What do you think?

That's good idea. We can give some experiments like this.

> 
> - PROCESSING CPPC DOORBELL REQS IS SLOW. BUT /MAKING/ A REQUEST, SLOW TOO?
>   Looks to me that with the "shared memory support" the frequency update
>   process is doubly asynchronous: first we have the ->target() callback
>   deferred to a workqueue, then when it's eventually executed, it calls
>   cppc_update_perf() which again just asks the firmware to do work at a
>   later time. Are we sure that cppc_update_perf() is actually so slow to
>   warrant !fast_switch?

That's a good question! I think your platform with "shared memory support"
is actually to read/write the memory in Platform Communication Channel
(PCC) to update the performance goals. However, acpi-cpufreq driver is
using the MSR registers with cpu_freq_write_amd()/cpu_freq_read_amd().

Is that possible that MSR register access faster than the memory doorbell
in PCC?

> 
> - HOW MANY P-STATES ARE TOO MANY?
>   I've always believed the contrary, but what if having too many P-States is
>   harmful for both performance and efficiency? Maybe the governor is
>   requesting many updates in small increments where less (and larger) updates
>   would be more appropriate?

I am thinking that, maybe, we can dig out better policy to control the
perf range.


Thanks again for questions / possible troubleshooting directions. They are
very helpful. Next step, let us find out what is the root cause of the
performance gap between acpi-cpufreq and amd-pstate driver.

Thanks,
Ray
