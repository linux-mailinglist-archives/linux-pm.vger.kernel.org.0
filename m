Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17E6297608
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 19:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753772AbgJWRqn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 13:46:43 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:20000
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753430AbgJWRqm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 23 Oct 2020 13:46:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJyH18LdMhssM44f6nThgsx4JTLrJcNnQoAdseBaYcmGK4yChyRlXZL98yisMSrNK3bfnrRLrrWtVqjzVgiHzhZaWgvdj90gP8V4FeDlUR7Tgf+3d0Vbg1eC745k66/px4toNHstYVYUpB/qBd77HaXUoM35v8suhWhBeLugQQ9kD50ekcE9ZsEGGBNhHYV+ketZjcawar4VSV924lvNjM3kdg6eUI/bd2UkSKB9l8bR/pRFYxQjiR4KH2kcUUNAJro1RFMZ569nLXR2nTj54/rn5vc5WnLPaPNs0PEWBbe7bUvjM6U0+kp/A/MtPO36bTBJsWgMqwwHM0L1svZOSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDd11/k0i/QGsLq37yEZtppfA/ycpY4NyowrcBrG1Zw=;
 b=g6KsGXdBkQgIoRN81WPoiZs20fcgtvVP4GOKCY3t2cs9QLAGufO8QvR6JY49UzEvpWpeebZWDhrjntHPfoJUlfyZ4LasvTT/Oi9ZvdcN/bvZIimYz5/vlus1Yh9t5HZi8wSiNp/uUAsIlPfQEjt9Hj1ilceCvG+FKnV6QsjPJQcrgJtiFUNvd1B/7dKz1BLFAXBLdTLODiZGGF+IHLua1asJhd6RQM2lukcTy9PdPpzN4XeRq1QfAdXyFIyUyUPsxwrsSxNYqe8NEP4PUD2C6FkdANW8XwuT68wgMHCAM3ZR5GfPBjYBbKy7+EkgP1KsS1vKICibR2MlmbGABW4/0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDd11/k0i/QGsLq37yEZtppfA/ycpY4NyowrcBrG1Zw=;
 b=kpehrnj1GuEqmrb/8kPTMK5BKiZWI4NBMWE/SVMy0Mu7ignWgUgAgKRpiMhfWY1sbDUPLPaFJICVgKMX+uJ8xxbvLiSsw/h3JnFR5gN5bWg6ryShQj+0zzTBh1gJtjbEVJJSL0o5+K0J+vHaoVRl1THrVe0FxqQx/OUS3Meiyws=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18; Fri, 23 Oct 2020 17:46:38 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::e442:c052:8a2c:5fba%6]) with mapi id 15.20.3499.018; Fri, 23 Oct 2020
 17:46:38 +0000
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle core
To:     Peter Zijlstra <peterz@infradead.org>,
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
        suravee.suthikulpanit@amd.com,
        "Fontenot, Nathan" <Nathan.Fontenot@amd.com>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <34115486.YmRjPRKJaA@kreacher>
 <20201022120213.GG2611@hirez.programming.kicks-ass.net>
 <1790766.jaFeG3T87Z@kreacher>
 <20201022122949.GW2628@hirez.programming.kicks-ass.net>
 <20201022145250.GK32041@suse.de>
 <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
 <1603397435.16275.45.camel@suse.com>
 <20201023070310.GK2611@hirez.programming.kicks-ass.net>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <4a0db95a-1ba2-21f5-5c9d-67b9f82ed130@amd.com>
Date:   Fri, 23 Oct 2020 12:46:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201023070310.GK2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.79.209.213]
X-ClientProxiedBy: SN6PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:805:f2::44) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR04CA0103.namprd04.prod.outlook.com (2603:10b6:805:f2::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Fri, 23 Oct 2020 17:46:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b5fabc76-1e51-48d0-dbe3-08d8777b9795
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB494205BF83EF1F32BF853C7BEC1A0@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d81OGCOBswi/RtwpT57XHm2RVYmPRbn9ArynTbYc1smHOuPaA981rAG0yIwsxgDwxWZTvkA91KU/KoxRkI058Crx7MYJCvIzZhGMvnHajH/6StFGY7hpClAm4BdwBmibaXya1L43oEk1sxLtmkr0icHR+RaSkUIF+V3Uh5rnKrmdKqjqd5h5cPI+In8CXH4K7UUfykPx8x9quYJaP7iXXGTyQU4wJ/o8PzuBEUdhWtA+dFpplxy7P1Z5CMYVY7mCGJX8PHG06h9LV4AfuixcsbG4QUo3ho7q4uXvejZY2mGw9mNjbiHFnlIpotoECU41IbVeTcXmvPEyaZQKrPaUFIpdNJ058m3Nmau7YFROdQVu1S8L4nDInkkNztRoUo7k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(36756003)(53546011)(86362001)(4326008)(2906002)(31696002)(66946007)(52116002)(956004)(7416002)(6506007)(66476007)(5660300002)(110136005)(54906003)(26005)(83380400001)(4744005)(2616005)(66556008)(478600001)(316002)(8676002)(16526019)(6512007)(8936002)(186003)(6486002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: l2uyZJ8ubmh4BzfyAr50/rIlOFv9RFdHcBR33WVLYn1JPqGEAc1DuxdIrstWoPS8sjMTlzDQg2a426Xbt1XsMujehgEOpkgnZZlJLQyd14nR8lqB+3k0kBxeVlGCZWgGo4fPcYG7po9hdrCPLxG3xtZEngCgrBuZw9sqxtdQ90O/4BMsNGBwfJVy6njn56Zk8fAMKatOdYm5JxKL2+9w87mLlt5upCJjHzSTGVmeyhczhjfWr29s7Adb2bCK+6GW34biRu1YbTF83RPc0FGFB7HaYgsQHJAFY6yKpJww3TfkHy8qJI7RnsdWNVnJz2JsNm0edTKUdveIk+hi7oNrzYdTlc/2DkkuOV8D9BjVUyfuNyb3k5469Ocu/9of7DYr6Xs71AHDXGzcfHsEg84B5pL0UxhhSQDHv/rzak8xhu8XWU3N65/Weu2F7NhNw5DFInsGn82gFDJWiZ0zXUS67nK8uSxJ+bIm+3SioEyq/hGgD7QIa931EXzzfIvOE4C1gEQjURzMBRgW5tKrPjJsdCPG8lWtnfHkW/Q/ge1Xaz/8FeWK9Nn3bqU7q/usB2jHCWalot642eGz7JbyyrsJlOV2qB9ANYBY77KX9TzcSvJBj/fsyb2UCrBJx3gRgDU0nzrfFjSLsyYDCRjdu1BILQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fabc76-1e51-48d0-dbe3-08d8777b9795
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2020 17:46:38.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWWIaDxhSn0+gqLl2hxtwUsesJD238Ogj/h/VvNCFde4jNv3FPeyPTVPUhURHwm3xT8Ue69ldyHpL9CZy4QR6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/23/20 2:03 AM, Peter Zijlstra wrote:
> On Thu, Oct 22, 2020 at 10:10:35PM +0200, Giovanni Gherdovich wrote:
>> * for the AMD EPYC machines we haven't yet implemented frequency invariant
>>    accounting, which might explain why schedutil looses to ondemand on all
>>    the benchmarks.
> 
> Right, I poked the AMD people on that a few times, but nothing seems to
> be forthcoming :/ Tom, any way you could perhaps expedite the matter?

Adding Nathan to the thread to help out here.

Thanks,
Tom

> 
> In particular we're looking for some X86_VENDOR_AMD/HYGON code to run in
> 
>    arch/x86/kernel/smpboot.c:init_freq_invariance()
> 
> The main issue is finding a 'max' frequency that is not the absolute max
> turbo boost (this could result in not reaching it very often) but also
> not too low such that we're always clipping.
> 
> And while we're here, IIUC AMD is still using acpi_cpufreq, but AFAIK
> the chips have a CPPC interface which could be used instead. Is there
> any progress on that?
> 
