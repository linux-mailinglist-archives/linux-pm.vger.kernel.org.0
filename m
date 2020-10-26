Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCD299769
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 20:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgJZTxD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 15:53:03 -0400
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:13398
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbgJZTxD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 26 Oct 2020 15:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGioWhz4V5DaBhGixKt0mHR22+rB3t772RLx1/X+licmV2YY6FpjVwEVs2dS/O0YbF1DsGxlZ+Eyq2RnTAimREj2y7pxh5G0jDGDykfVbalBIVO/WgZnri0RZ51VrURgYB/kxxgstFoERYp6HqBuDTJMUb7XVIgs49sZNckN/KL9jgqzL+ZlTxHDKufIlE82sL/i9cjlemiSUtXrlxksv+r2qMWKa5IX0gcAneq1PGxVnGu4Kv/Lq4COUkhIWpFK9C/eB8Nq2hR2Wcqtc/4WJYFvrvhrVBFe6b9h1ndK/iuh33BZEOxfmfiuR8Z22Bd9bF+8Txmh55odlZToOLhRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PxUtzCNnA8nse59aN/H+iRaES4g4Lyqh/6gPhS3Y5A=;
 b=X1KBl+YPjnsy/enVVDttg2ZL1eqm676SGzo3m4nXJXQ3n0CCqaTEpqZsT2tiP9d6dQdkZ+SM7U8h7M02cYeJYBDAk7FWDPNLss8QzoF85GMIrl3mKBOIcTZsSc3u0xGi2mZlDMjZuIimpUtyBREpTKR62DqHjM8p6sB0kRcNSeWvgID24GVnjqqAWkKevkrXr87MYVdQ5Z4twdUUkfR3VM12UZWw9zKCnN0ans3yMuVGjeV5IglSI1gp+6QqHhiEHlhyZn28KklG6fS17LRSrrNNNumSUJAts76Ui7CWwBxVZmo5pZnZCbx94o/ChgVQuF76YVxRMO4Ex6+ItPvC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PxUtzCNnA8nse59aN/H+iRaES4g4Lyqh/6gPhS3Y5A=;
 b=xi4cfgBlr2pUxCtEsxBoAvgEXbgT0AlunGdsvRukGTk5291xbeM68gISa0v4XmYg7uEstMlJ7+7CdfFS/gY2OAle4qFlvU3CoYhgMNDQ6FdWitFN2eXrvC0U1EngXlRvZuAmdRaDyxfMY4z71340JP9FH3oucEPnsLREtFXnfPA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3804.namprd12.prod.outlook.com (2603:10b6:5:1cd::22)
 by DM5PR1201MB0234.namprd12.prod.outlook.com (2603:10b6:4:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Mon, 26 Oct
 2020 19:52:52 +0000
Received: from DM6PR12MB3804.namprd12.prod.outlook.com
 ([fe80::1511:26ca:70e:4014]) by DM6PR12MB3804.namprd12.prod.outlook.com
 ([fe80::1511:26ca:70e:4014%4]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 19:52:52 +0000
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        srinivas.pandruvada@linux.intel.com,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>, puwen@hygon.cn,
        yazen.ghannam@amd.com, kim.phillips@amd.com,
        suravee.suthikulpanit@amd.com
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
 <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de>
 <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
 <1603397435.16275.45.camel@suse.com>
 <20201023070310.GK2611@hirez.programming.kicks-ass.net>
 <4a0db95a-1ba2-21f5-5c9d-67b9f82ed130@amd.com>
From:   "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
Message-ID: <0a3abadf-181e-99dd-1304-86a34505dfe8@amd.com>
Date:   Mon, 26 Oct 2020 14:52:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <4a0db95a-1ba2-21f5-5c9d-67b9f82ed130@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SN6PR2101CA0022.namprd21.prod.outlook.com
 (2603:10b6:805:106::32) To DM6PR12MB3804.namprd12.prod.outlook.com
 (2603:10b6:5:1cd::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.217] (165.204.77.11) by SN6PR2101CA0022.namprd21.prod.outlook.com (2603:10b6:805:106::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.17 via Frontend Transport; Mon, 26 Oct 2020 19:52:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5bfe0828-2b6a-40e9-e47d-08d879e8b961
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0234C784C3A278C0B8CF4A12EC190@DM5PR1201MB0234.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9HWrV1toLSr/Z+Gndu366WJC7+x2JFULG8Rhjl6bSeGNDFiHeRvCz7OPdhDqy06lcnwMsiii79iEcvKUVW2R3d5kSgA+F3XR+RWWvz9AMt9Pf8HlW5UEnKdNjTCSphYfCg5fX1A0ZzLK+m8XCHoktBdZ5N4qyUlDb7/dHEC0nvjZlQ+/fu432g8jkEwFy3krXscbxHVTEtJYHN8hlpZoh9ut61Tw5JLqtHO4nO15Vk7AW+euh/vqhZ4ISpgaBe8HkKyxFQ+QGAtbt2rXs49i/qi/35BBApYKQzRFyAqJIQr6Gp7X+UgOx3YPuolqKK9Sskkj+s3rdKRe+lBg0Snk9SpoACQr/oHacMS8qe8+nUUR3RU97mhGUBg+EJQxwB+z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3804.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(2616005)(6486002)(4326008)(83380400001)(956004)(36756003)(478600001)(31686004)(31696002)(6666004)(66476007)(66946007)(316002)(26005)(52116002)(186003)(5660300002)(16526019)(53546011)(54906003)(16576012)(8676002)(86362001)(7416002)(8936002)(66556008)(2906002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IJOpxUxv9lNoy/BQl1qyZkmXWRg+NhDK0y2Kxsvuq7wRrAWopKIAVaNvOjMnLMI/PMr8e9QTMw8JUd84qHPAii09eskDnHApUXlQLkUxpXtncijEzPEjNmkkE6pppt0y0bepKtuejaWtyeUpiNOohUgM9GftiDvsZW8HbuMSy4U4AImURWYdlWx8aEtIsckMsmwDdhRVoUiY0ZzJ/CZ+11Fp7kbDd0REdgK62i7ABtilAPyDvWdB6iaV8sTJ9R+6YYJj92bLGREkP44f7aScaJgbSpKi+og91Umdmylmpg9dDl6wTYdEwwnrDRBoLafGQWE8IQegRzsPPzinQlTJQ1lTJOv4ibAQGTZvPeVLFKXe4j7iDLwcS9GpTy5w/hs69gn/yUQY2t/oQgF7XGFaTtPGU08kQkrIOPgyafAG52F3lT8FOOSE8jNZHlr0Z1k14L2Crf1P2VjaBx1Z8j0lw8uj/SmL2EiknV86P22XhNJj1ccHvxLZX9WjTCB1aBQ/nCZq1mA8TU8x6NYEwaJddKZKUYuJWFLpd3Ph+jO1QJ1Tvece1RDBE1a6aic675cJKxdGOjpNuQIwPu36FnBkgVYUGzS4xAcdsjGX9W3V5a199uUuHM8QvTwakMOatQ3dfpsQJgZQ3QafAa0J/lR8SQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfe0828-2b6a-40e9-e47d-08d879e8b961
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 19:52:52.5317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bqH2q4LBkUMtp8Bsj5nW9Wt5p2LExSxoRVaXhTThdq+5kBHFsOftVPAvv6MMGtRI0/bTdFDZ+eof6CP+Qhs0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0234
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/23/2020 12:46 PM, Tom Lendacky wrote:
> On 10/23/20 2:03 AM, Peter Zijlstra wrote:
>> On Thu, Oct 22, 2020 at 10:10:35PM +0200, Giovanni Gherdovich wrote:
>>> * for the AMD EPYC machines we haven't yet implemented frequency invariant
>>>    accounting, which might explain why schedutil looses to ondemand on all
>>>    the benchmarks.
>>
>> Right, I poked the AMD people on that a few times, but nothing seems to
>> be forthcoming :/ Tom, any way you could perhaps expedite the matter?
> 
> Adding Nathan to the thread to help out here.
> 
> Thanks,
> Tom

Thanks Tom, diving in...

> 
>>
>> In particular we're looking for some X86_VENDOR_AMD/HYGON code to run in
>>
>>    arch/x86/kernel/smpboot.c:init_freq_invariance()
>>
>> The main issue is finding a 'max' frequency that is not the absolute max
>> turbo boost (this could result in not reaching it very often) but also
>> not too low such that we're always clipping.

I've started looking into this and have a lead but need to confirm that the
frequency value I'm getting is not an absolute max.

>>
>> And while we're here, IIUC AMD is still using acpi_cpufreq, but AFAIK
>> the chips have a CPPC interface which could be used instead. Is there
>> any progress on that?
>>

Correct, AMD uses acpi_cpufreq. The newer AMD chips do have a CPPC interface
(not sure how far back 'newer' covers). I'll take a look at schedutil and
cppc_cpufreq and the possibility of transitioning to them for AMD.

-Nathan
