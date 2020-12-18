Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D182DE75E
	for <lists+linux-pm@lfdr.de>; Fri, 18 Dec 2020 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgLRQWM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Dec 2020 11:22:12 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:32874 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728293AbgLRQWL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Dec 2020 11:22:11 -0500
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Dec 2020 11:22:07 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1608308461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L2CAO3iiBeA9I9w0/HNRYmGWpLAu7ksdCukh+7d5C8U=;
        b=Z42xlzmF3n4r30V7jV7tj8Poubowy2oXEzod8tMZUytGaz3E1UEtpzM8cPRcQDywI682s0
        hTgGgQzb6IQUKyKVb9JPaMxOZfUYBn7z5/UvouvWYfLuKMxNWncd7GL0LqFZ2h1VYpPTG8
        ii2W9nezVysgpEvJVnlIzBQ9FUSeqsY=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-9-dA7nWOPgM3q800OqcXPa8Q-1; Fri, 18 Dec 2020 17:11:49 +0100
X-MC-Unique: dA7nWOPgM3q800OqcXPa8Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PE0DWPXU5ZDQXb6eI7IXM4BqWj07F0EMuE+jun5t/ipdRO7FW1aHYhuKzNk52kTh1PXv3K8hZHJF7Dxj/qKMrjVjbvhnuBMrnWODfI9H+c4zxO5s1nnLUqXQEGxR/gwTtO2deBC7FIYyEv+4IVrkboSVQnkMTJ8deevzBomUjREIJtefWyytISIM6zMnZ3OsM4AloGSB/orgSKYvwnZW8l2JLKGlfmx1bPyDp3vSNUlH5DyGp+3Z5aToiqmBsJ/vzqQCEMZCiKpnQJJLFtkKJ6C+/IRrfDn3qZjbNjOcyYuoFdbvXueB5AXYikmPmBsoZIYxO2p8c3xI2ZA3T+tRlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2CAO3iiBeA9I9w0/HNRYmGWpLAu7ksdCukh+7d5C8U=;
 b=M+ve603Pmd4V0XpCScs/NHbFst9zn+tCOvV7ONdmO10nzU4Fjhpj875s1gPVlIZCQ8oX5KCIYpJrlnuCCQIquW8fw9aezBxJsKT9ld0pc0bOAea3AydAoaBED2HeSDlKwp8ZBsr2UlA7567pYaZSwU6bzLAsZTqLsRrVDez4CE9X2kJ34vXX1dxmR05tFpRnsTc0Ys/JpbiFLz5vbz3jwSruLfVOgvpFoY1fg/vH+anjduwdn23vYdF7ajPHM05wzlNJgcTSYyUpQvCU+DqNwmN+GLWLm3xIhJuuxi8YwBEGVCN3dbsoBlW94svYbDm2R4RIQ0g/tCOTMDbWLRmztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28)
 by AM8PR04MB8033.eurprd04.prod.outlook.com (2603:10a6:20b:234::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.17; Fri, 18 Dec
 2020 16:11:47 +0000
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::797c:6e40:f893:4082]) by AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::797c:6e40:f893:4082%6]) with mapi id 15.20.3654.028; Fri, 18 Dec 2020
 16:11:47 +0000
Message-ID: <1608307905.26567.46.camel@suse.com>
Subject: Re: [PATCH v2 0/3] cpufreq: Allow drivers to receive more
 information from the governor
From:   Giovanni Gherdovich <ggherdovich@suse.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>
Date:   Fri, 18 Dec 2020 17:11:45 +0100
In-Reply-To: <3827230.0GnL3RTcl1@kreacher>
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.250.132.148]
X-ClientProxiedBy: AM0PR08CA0028.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::41) To AM0PR04MB4530.eurprd04.prod.outlook.com
 (2603:10a6:208:70::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-ni6k.dhcp.prg.suse.com (195.250.132.148) by AM0PR08CA0028.eurprd08.prod.outlook.com (2603:10a6:208:d2::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 18 Dec 2020 16:11:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0175d76-1a35-44f2-0f9f-08d8a36f9ee7
X-MS-TrafficTypeDiagnostic: AM8PR04MB8033:
X-Microsoft-Antispam-PRVS: <AM8PR04MB80335441C72A89DD3C5AC11393C30@AM8PR04MB8033.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mLWZtLzYBSzaV998dGQmTa7FdaI9p/5qCULjP2iHltB7Xr1n3S4G9f74DSC6EPy6RNKeaU1JP5x/rkjBUuekvuyVzKoCw4cy5pRy0028U8HnEciM22rUBKCRtqxyYlaWpvCGrH1pmccAqzfiJQCTNzfhYXz2kBuOw48MZ6eAhAyx2IOmgjwMAhd+7bQ9wSfZi6JjGEZZOX9GntIk723wLwROV/haAvPqMdkhKxTDrJRJ5DXh5Efrss39zPwBmGdygR7oBSWRXWURqr56G+iPw6SMWNIAsl1hbQ33+C9ijyvGQ1/Xu1PZCG8slYsfOe+mczymkiUSIncGGWKJ+e22LHpToi20C7oBsX7d2qr3slcSMKy+CfCxjBV8gaFKHYTp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4530.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(136003)(39850400004)(66946007)(8936002)(66556008)(8676002)(316002)(5660300002)(7696005)(26005)(54906003)(52116002)(6486002)(2906002)(110136005)(186003)(4001150100001)(36756003)(16526019)(83380400001)(103116003)(478600001)(4326008)(66476007)(956004)(2616005)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?KzNwb0RUb1J2VzAxNm1JejZlS3ExMGhhSWJjdkgzVkExYXRqV1R4ZFpTUUdG?=
 =?utf-8?B?M0JZWVQvWTF2N3ZSVk1uU0RZWllQN1pTSHd4cWFHdWF2eFRPZTNYK0E4Q0ZB?=
 =?utf-8?B?Mm9pQVkzTktCS3JUSzA3RFlSWHM2SzFSQWExc3ZYbnNaa0dYcXJSRHlqQTVu?=
 =?utf-8?B?NHpLeDJoNzhtTzBBVG1rY2x0NXVQTWhNeFhXM090NmNvQ1M4VEllazJEZmZj?=
 =?utf-8?B?UEtTZkY3V0h1Mmk2ZEk5Nmxrb05ZdVdtSjR0N2dlRGw2YW13elhvV0Q1SE4z?=
 =?utf-8?B?WFFXcnJiRXF4UTVmbEtvS1M5cFhGMHRBTDFsaHowejRObkl4czltS1ZyVy9W?=
 =?utf-8?B?ZkN0MjBNRzM1L3RBMDVieFlISlJrS2VkLzVHTElhUGRoV1M2VFlsaStMeHpI?=
 =?utf-8?B?c1ltNldFdGlXbG9wbkVqSjBwYTh3WFlwSzl3Y1NWQTdDTkl2OERjaXl0S2RY?=
 =?utf-8?B?TUV1ZWdDRWNWaWlDNFI0ZCtKYzkyM3NoVVd1RzZ2K3lscHdqaEdFQS9xS3p0?=
 =?utf-8?B?REUrZ0tyYkNHbFV1Qm9vOURBMktjaEk0OUdaZ1hheHJpM2g5cDB1ZFgxcDYx?=
 =?utf-8?B?TlJmeWF2cWV0Lzk2VmNXOG1UUWtDdEt3OUdVVnlSODI4ajN4ZitKQnJyTk9y?=
 =?utf-8?B?YTJnaDN1aXBlL0pRQ3lXM0tXRHhtQmtOSEFKbTJoTmtIL0tGVHVVWTZmTnRh?=
 =?utf-8?B?bFVBWUVPV25URHN0eHFEV1ZFUHdSUUtLZWxKUWtVTEtHYXJLcmNmNUZ1bldS?=
 =?utf-8?B?MmlIN05tL2hxWXkxQ2o4UmdVMzRUemhXTHh0VUVxcnZ6VFJWeWY3NGlqcnJt?=
 =?utf-8?B?aFBVcmYxQU9WNnREQmloeS9QV3VYTjg5d291cjVVNmlUNFo3dUN5UzhNbTE0?=
 =?utf-8?B?ZVlzY3BENEp0UVExOWkxTHNmUjVZRWJEaVA0ZTJPUFpLNms0YTU1NUFPVnRX?=
 =?utf-8?B?VytNTFo2Umg5OGNsUkFCWXU0UEQvb0NzMHRmSEhoSCtxUWZMWTk3cTVKV1g3?=
 =?utf-8?B?S1pCbWtYSUNMd1d2YXRwaURFMzUrVHJ4Z21WV3NBVDZ4KzArT2FFY0JiOHlZ?=
 =?utf-8?B?dUxZN1JJM25mWXI2c0hPTUNEMkVpYitoVmc1Q1Q5b1QxL2RFUlJNdUJ6VTIw?=
 =?utf-8?B?c0JYbFhoM3B4MXRud3hSSFdyajQrVWVYTnozamp5S2xYNERMNGVnaVQwQ3pt?=
 =?utf-8?B?TUJuYjFEaytOZWM2bkp1SWdxYWZFcXpMOWRuOW1tTG40TGEvZllPTHoyZ2JV?=
 =?utf-8?B?RGhNK05BamRYRnpmRWU3OXZmMXpoQlovdURBRXlkRkIyUC9zdDhGMzFrNVpi?=
 =?utf-8?Q?Oyc5iQ0GsaztY/L+/02z0Qww1Joh3knL+T?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4530.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 16:11:47.4985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: b0175d76-1a35-44f2-0f9f-08d8a36f9ee7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaLEzgvE5N8AHFyTFQthwNmamd3sEFI8ch0OwGbF/EtIDD1zW/7/22d+gtrvVvF14wN2T/XTbxOBvQgrAcxCTx/xuTSnFIpqQ/WuYZAbhkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8033
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-12-14 at 21:01 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> The timing of this is not perfect (sorry about that), but here's a refresh
> of this series.
> 
> The majority of the previous cover letter still applies:
> [...]

Hello,

the series is tested using

-> tbench (packets processing with loopback networking, measures throughput)
-> dbench (filesystem operations, measures average latency)
-> kernbench (kernel compilation, elapsed time)
-> and gitsource (long-running shell script, elapsed time)

These are chosen because none of them is bound by compute and all are
sensitive to freq scaling decisions. The machines are a Cascade Lake based
server, a client Skylake and a Coffee Lake laptop.

What's being compared:

sugov-HWP.desired : the present series;  intel_pstate=passive,  governor=schedutil
sugov-HWP.min     : mainline;            intel_pstate=passive,  governor=schedutil
powersave-HWP     : mainline;            intel_pstate=active,   governor=powersave
perfgov-HWP       : mainline;            intel_pstate=active,   governor=performance
sugov-no-HWP      : HWP disabled;        intel_pstate=passive,  governor=schedutil

Dbench and Kernbench have neutral results, but Tbench has sugov-HWP.desired
lose in both performance and performance-per-watt, while Gitsource show the
series as faster in raw performance but again worse than the competition in
efficiency.

1. SUMMARY BY BENCHMARK
   1.1. TBENCH
   1.2. DBENCH
   1.3. KERNBENCH
   1.4. GITSOURCE
2. SUMMARY BY USER PROFILE
   2.1. PERFORMANCE USER: what if I switch pergov -> schedutil?
   2.2. DEFAULT USER: what if I switch powersave -> schedutil?
   2.3. DEVELOPER: what if I switch sugov-HWP.min -> sugov-HWP.desired?
3. RESULTS TABLES
   PERFORMANCE RATIOS
   PERFORMANCE-PER-WATT RATIOS


1. SUMMARY BY BENCHMARK
~~~~~~~~~~~~~~~~~~~~~~~

Tbench: sugov-HWP.desired is the worst performance on all three
    machines. sugov-HWP.min is between 20% and 90% better. The baseline
    sugov-HWP.desired offers a lower throughput, but does it increase
    efficiency? It actually doesn't: on two out of three machines the
    incumbent code (current sugov, or intel_pstate=active) has 10% to 35%
    better efficiency. In other word, the status quo is both faster and more
    efficient than the proposed series on this benchmark.
    The absolute power consumption is lower, but the delivered performance is
    "even more lower", and that's why performance-per-watt shows a net loss.

Dbench: generally neutral, in both performance and efficiency. Powersave is
    occasionally behind the pack in performance, 5% to 15%. A 15% performance
    loss on the Coffe Lake is compensated by an 80% improved efficiency. To be
    noted that on the same Coffee Lake sugov-no-HWP is 20% ahead of the pack
    in efficiency.

Kernbench: neutral, in both performance and efficiency. powersave looses 14%
    to the pack in performance on the Cascade Lake.

Gitsource: this test show the most compelling case against the
    sugov-HWP.desired series: on the Cascade Lake sugov-HWP.desired is 10%
    faster than sugov-HWP.min (it was expected to be slower!) and 35% less
    efficient (we expected more performance-per-watt, not less).


2. SUMMARY BY USER PROFILE
~~~~~~~~~~~~~~~~~~~~~~~~~~

If I was a perfgov-HWP user, I would be 20%-90% faster than with other governors
on tbench an gitsource. This speed gap comes with an unexpected efficiency
bonus on both test. Since dbench and kernbench have a flat profile across the
board, there is no incentive to try another governor.

If I was a powersave-HWP user, I'd be the slower of the bunch. The lost
performance is not, in general, balanced by better efficiency. This only
happens on Coffee Lake, which is a CPU for the mobile market and possibly HWP
has efficiency-oriented tuning there. Any flavor of schedutil would be an
improvement.

From a developer perspective, the obstacles to move from HWP.min to
HWP.desired are tbench, where HWP.desired is worse than having no HWP support
at all, and gitsource, where HWP.desired has the opposite properties than
those advertised (it's actually faster but less efficient).


3. RESULTS TABLES
~~~~~~~~~~~~~~~~~

Tilde (~) means the result is the same as baseline (or, the ratio is close to 1).
The double asterisk (**) is a visual aid and means the result is better than
baseline (higher or lower depending on the case).


| 80x_CASCADELAKE_NUMA: Intel Cascade Lake, 40 cores / 80 threads, NUMA, SATA SSD storage
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|            sugov-HWP.des  sugov-HWP.min  powersave-HWP  perfgov-HWP  sugov-no-HWP   better if
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|                                         PERFORMANCE RATIOS
| tbench         1.00           1.89**         1.88**        1.89**        1.17**       higher
| dbench         1.00           ~              1.06          ~             ~            lower 
| kernbench      1.00           ~              1.14          ~             ~            lower 
| gitsource      1.00           1.11           2.70          0.80**        ~            lower 
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|                                    PERFORMANCE-PER-WATT RATIOS
| tbench         1.00           1.36**         1.38**        1.33**        1.04**       higher
| dbench         1.00           ~              ~             ~             ~            higher
| kernbench      1.00           ~              ~             ~             ~            higher
| gitsource      1.00           1.36**         0.63          1.22**        1.02**       higher


| 8x_COFFEELAKE_UMA: Intel Coffee Lake, 4 cores / 8 threads, UMA, NVMe SSD storage
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|            sugov-HWP.des  sugov-HWP.min  powersave-HWP  perfgov-HWP  sugov-no-HWP   better if
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|                                         PERFORMANCE RATIOS
| tbench         1.00           1.27**         1.30**        1.30**        1.31**       higher
| dbench         1.00           ~              1.15          ~             ~            lower 
| kernbench      1.00           ~              ~             ~             ~            lower 
| gitsource      1.00           ~              2.09          ~             ~            lower 
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|                                    PERFORMANCE-PER-WATT RATIOS
| tbench         1.00           ~              ~             ~             ~            higher
| dbench         1.00           ~              1.82**        ~             1.22**       higher
| kernbench      1.00           ~              ~             ~             ~            higher
| gitsource      1.00           ~              1.56**        ~             1.17**       higher


| 8x_SKYLAKE_UMA: Intel Skylake (client), 4 cores / 8 threads, UMA, SATA SSD storage
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|            sugov-HWP.des  sugov-HWP.min  powersave-HWP  perfgov-HWP  sugov-no-HWP   better if
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|                                         PERFORMANCE RATIOS
| tbench         1.00           1.21**         1.22**        1.20**        1.06**       higher
| dbench         1.00           ~              ~             ~             ~            lower 
| kernbench      1.00           ~              ~             ~             ~            lower 
| gitsource      1.00           ~              1.71          0.96**        ~            lower 
+ - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
|                                    PERFORMANCE-PER-WATT RATIOS
| tbench         1.00           1.11**         1.12**        1.10**        1.03**       higher
| dbench         1.00           ~              ~             ~             ~            higher
| kernbench      1.00           ~              ~             ~             ~            higher
| gitsource      1.00           ~              0.75          ~             ~            higher



Giovanni

