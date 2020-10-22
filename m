Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E42965C9
	for <lists+linux-pm@lfdr.de>; Thu, 22 Oct 2020 22:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503605AbgJVUKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Oct 2020 16:10:49 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:35035 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2503973AbgJVUKs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Oct 2020 16:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1603397443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g9E4aiLkBkGBG1hlHOtSRBRwKWXmXuuLsvRYzl5LgBQ=;
        b=ALEJGvj7wDFWojFDCeMCn+DvYH6yjVdNuicEBKUi//TGDoL5Z/LzX423MOyC58kOo9jlMW
        WKayADZriVkXfIpRP+G3n7GqXDEjsXgK7KNcPGw1HoBTD6VUksSkrzdgkb0iAzPxrs1fnl
        yJo0624i+swORAR7qHCPkumClhMA7gM=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-33-nl4vWBCMMPiC44PRBx_v7A-1; Thu, 22 Oct 2020 22:10:41 +0200
X-MC-Unique: nl4vWBCMMPiC44PRBx_v7A-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kko2idL1G7hyVps4VqcUEB9cJGNfzdvDizuEMgLmy6eZ8soaIVpkJ001oqueR4oFNpZ4yntN8onfKB2r5IQ227tGjRpsQJnTtG0IN99dZ/SfvyBP7UhgYURCZB6bzii264E8JEeBAJPXtD0pxoLePsXbgOcii6NcOpUHB69W0CyQxetDY8O0bjQRRHl7tklL7vYM7D0UR8CMHdyBaOgPgKJdbpVetog3T787JwQosLwPsrh77R9Ri6LyQCOBMrMD3YBqOqK0Qjk/SfmeTkNknWcCn9/9OUdKEZYIzAE93xlXr0A13wkeDZ2Qqk4uYqxMx8/6I3rcPXMvaHmK5M9OMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9E4aiLkBkGBG1hlHOtSRBRwKWXmXuuLsvRYzl5LgBQ=;
 b=im5jvjk0GiB119Y/hLhHUk0ibdJ2+j2MPPhD2XBrJ0SmBheJIQWqSfRpoZg06B57OVYzSDfl0fszfELMOaiEuNgS8oKCl7QIcXcPoLz5bqjreuflDId05yx+UbWx9CKh/yaB8uKM/YjEJNmcxgc//8lOWzaScaIujPAcxTVL824qfp5k5INz1ueEeqt8z4g3AB1R+t7Fa5QGYBCRWppgIe/EXPynZSmuxlz3mVeriCxSMou2W+jsv/hHNROTJgkAdwTVjYupmIST6Am0tArEfofXwn8gEFNo6IqonqEX1ilf88sU+Mkq/dIG/P6mxmn9HWc3FEyM9k+Z98K7bez+Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28)
 by AM0PR04MB4017.eurprd04.prod.outlook.com (2603:10a6:208:5b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Thu, 22 Oct
 2020 20:10:39 +0000
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::29a3:4b8b:de0:7f3c]) by AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::29a3:4b8b:de0:7f3c%7]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 20:10:39 +0000
Message-ID: <1603397435.16275.45.camel@suse.com>
Subject: Re: default cpufreq gov, was: [PATCH] sched/fair: check for idle
 core
From:   Giovanni Gherdovich <ggherdovich@suse.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mel Gorman <mgorman@suse.de>,
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
        Len Brown <len.brown@intel.com>
Date:   Thu, 22 Oct 2020 22:10:35 +0200
In-Reply-To: <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
         <34115486.YmRjPRKJaA@kreacher>
         <20201022120213.GG2611@hirez.programming.kicks-ass.net>
         <1790766.jaFeG3T87Z@kreacher>
         <20201022122949.GW2628@hirez.programming.kicks-ass.net>
         <20201022145250.GK32041@suse.de>
         <20201022152514.GJ2611@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2a02:830a:b003:a100:70cf:f004:73cb:aa82]
X-ClientProxiedBy: AM4PR0202CA0020.eurprd02.prod.outlook.com
 (2603:10a6:200:89::30) To AM0PR04MB4530.eurprd04.prod.outlook.com
 (2603:10a6:208:70::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:830a:b003:a100:70cf:f004:73cb:aa82] (2a02:830a:b003:a100:70cf:f004:73cb:aa82) by AM4PR0202CA0020.eurprd02.prod.outlook.com (2603:10a6:200:89::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend Transport; Thu, 22 Oct 2020 20:10:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3acce817-01cf-41d9-6275-08d876c68b3f
X-MS-TrafficTypeDiagnostic: AM0PR04MB4017:
X-Microsoft-Antispam-PRVS: <AM0PR04MB4017FE278E815DC65B8428AB931D0@AM0PR04MB4017.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LiiKbfXpWd8jBk9Z8W9m7CBVQ/Td91RkWonsqAYN9KFWXoZMeNOaCymDtE46+N6jSCqRLDmcLCnWJ9uJbBKVDPhgOdUrKQmqfpRBZ96Im9ymRAdE8FM0vQTJ+mxZljfAakD2McfqHR5NerPAaQMDhtGcE1AhzcwuAapB2oPby/+1fwI0wEYAw7wnz2vZsSv8qJMM27fujotsGV1yNbbJm7aezh/xQnuKKWwwiPPv7ZIKj/h7dih6UyzI4end2MgWlRq9F7eNXHQyppIL/NKJHgkjwEJ3zv6fKmlGhLQFzP9kerSf25MS8bVgxhdyo7Zy9xP+Hhjlu9B03zVlICwu4QkTDg+jqJy+9sv9ct+lUPJCQvti5nq+zTzYNVRX0ZYIeLik09RSHxmGq3bUk2uXmFU+7dCt2X5Gbprds/5d3PJE2Iij2SlsELZfI8jnVokJv+cp3B5cZHnCTNZOIGAAeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4530.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(346002)(366004)(39860400002)(110136005)(54906003)(8936002)(6486002)(478600001)(186003)(103116003)(16526019)(966005)(316002)(8676002)(52116002)(36756003)(5660300002)(7416002)(4326008)(2906002)(2616005)(66476007)(83380400001)(66946007)(66556008)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fZcOr7JCOOSua1DGvLzmy23bIQHdI9KjH28sD8lrZFdDLAnJSPMInNGWU9ZiDP8SSNdHbDB+cKd3DhcLz8dwDeHMnIqctAtzXtRfEgXk1DVsdRo4bcq8LcQ5iaagw/efHzMCClQz0akEl+ZeqxjjX9bO2IEqwg1Zz4k/R6vQTW950CYLQq5H4Bm9fQ63bOJIAjItcF/tMRfOPf8TmVGzB18Qaufe3IXJ+HFFVvjEW7S3xWWKIPdpg+13J8MAHpnbi3UvcsPQagVIsyTyStGPuSsW957vLBBf9vBQu/rfw5k3SYo2AZwTZFhUs2SJlGG66etADGomISJ0TB/3iGiOrg52i7/J079zEIJouIANBDfNHjH2NUyXMU1hg8JwYWwV1u+LYnoMzW2MfWrCf1EMCuKL40VNp+Epf4QSHwlsZ9BgRn773Yegf/ptMDE6UUgaWTp/4HflTtc9uumt7A8NrNIwXLfdPi9DfODKANFTRPcp77dvHJpI/IGk2w9on51SSky+tAKt4bCvMM6r0P+D2kng971wa/nwjEKyXUdKMPCyTC2Z0FZL62BGD5RPmB34QAMN0OHZCRQTnSlEanO4HarPJpwiVDvAq+0AXRlSROhiNBp6OM1dm9ecBaEH3g0Mpw8DORGCXx6F4O1Fk5X+tGqoPEOz5LPYPediDkiH/Aqk1w2o7DCa/8eY6OEOY1AH3Q+wGl9hkpx+Xcl5AgPmgg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3acce817-01cf-41d9-6275-08d876c68b3f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4530.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2020 20:10:38.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhbgDDIPVHa0VaH1kU9+GwREC6BcOnUzYCSDPQ0heBSFlIdG+qAa0lIyuD7vBLa7yhIB/OOmQ0375vHfIF4K3IupBVonRAVRMo7dWAku6sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4017
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Peter, Rafael,

back in August I tested a v5.8 kernel adding Rafael's patches from v5.9 that
make schedutil and HWP works together, i.e. f6ebbcf08f37 ("cpufreq: intel_pstate:
Implement passive mode with HWP enabled").

The main point I took from the exercise is that tbench (network benchmark
in localhost) is problematic for schedutil and only with HWP (thanks to
Rafael's patch above) it reaches the throughput of the other governors.
When HWP isn't available, the penalty is 5-10% and I need to understand if
the cause is something that can affect other applications too (or just a
quirk of this test).

I ran this campaign this summer when Rafal CC'ed me to f6ebbcf08f37
("cpufreq: intel_pstate: Implement passive mode with HWP enabled"),
I didn't reply as the patch was a win anyways (my bad, I should have posted
the positive results). The regression of tbench with schedutil w/o HWP,
that went unnoticed for long, got the best of my attention.

Other remarks

* on gitsource (running the git unit test suite, measures elapsed time)
  schedutil is a lot better than Intel's powersave but not as good as the
  performance governor.

* for the AMD EPYC machines we haven't yet implemented frequency invariant
  accounting, which might explain why schedutil looses to ondemand on all
  the benchmarks.

* on dbench (filesystem, measures latency) and kernbench (kernel compilation),
  sugov is as good as the Intel performance governor. You can add or remove
  HWP (to either sugov or perfgov), it doesn't make a difference. Intel's
  powersave in general trails behind.

* generally my main concern is performance, not power efficiency, but I was
  a little disappointed to see schedutil being just as efficient as
  perfgov (the performance-per-watt ratios): there are even a few cases
  where (on tbench) the performance governor is both faster and more
  efficient. From previous conversations with Rafael I recall that
  switching frequency has an energy cost, so it could be that schedutil
  switches too often to amortize it. I haven't checked.

To read the tables:

Tilde (~) means the result is the same as baseline (or, the ratio is close
to 1). The double asterisk (**) is a visual aid and means the result is
worse than baseline (higher or lower depending on the case).

For an overview of the possible configurations (intel_psate passive,
active, HWP on/off etc) I made the diagram at
https://beta.suse.com/private/ggherdovich/cpufreq/x86-cpufreq.png

1) INTEL, HWP-CAPABLE MACHINES
2) INTEL, NON-HWP-CAPABLE MACHINES
3) AMD EPYC

1) INTEL, HWP-CAPABLE MACHINES:

64x_SKYLAKE_NUMA: Intel Skylake SP, 32 cores / 64 threads, NUMA, SATA SSD storage
------------------------------------------------------------------------------
            sugov-HWP   sugov-no-HWP   powersave-HWP   perfgov-HWP   better if
------------------------------------------------------------------------------
                                  PERFORMANCE RATIOS
tbench        1.00        0.68           ~               1.03**        higher
dbench        1.00        ~              1.03            ~             lower
kernbench     1.00        ~              1.11            ~             lower
gitsource     1.00        1.03           2.26            0.82**        lower
------------------------------------------------------------------------------
                             PERFORMANCE-PER-WATT RATIOS
tbench        1.00        0.74           ~               ~             higher
dbench        1.00        ~              ~               ~             higher
kernbench     1.00        ~              0.96            ~             higher
gitsource     1.00        0.96           0.45            1.15**        higher


8x_SKYLAKE_UMA: Intel Skylake (client), 4 cores / 8 threads, UMA, SATA SSD storage
------------------------------------------------------------------------------
            sugov-HWP   sugov-no-HWP   powersave-HWP   perfgov-HWP   better if
------------------------------------------------------------------------------
                                  PERFORMANCE RATIOS
tbench        1.00        0.91           ~               ~             higher
dbench        1.00        ~              ~               ~             lower
kernbench     1.00        ~              ~               ~             lower
gitsource     1.00        1.04           1.77            ~             lower
------------------------------------------------------------------------------
                             PERFORMANCE-PER-WATT RATIOS
tbench        1.00        0.95           ~               ~             higher
dbench        1.00        ~              ~               ~             higher
kernbench     1.00        ~              ~               ~             higher
gitsource     1.00        ~              0.74            ~             higher


8x_COFFEELAKE_UMA: Intel Coffee Lake, 4 cores / 8 threads, UMA, NVMe SSD storage
---------------------------------------------------------------
            sugov-HWP   powersave-HWP   perfgov-HWP   better if
---------------------------------------------------------------
                        PERFORMANCE RATIOS
tbench        1.00        ~               ~             higher
dbench        1.00        1.12            ~             lower
kernbench     1.00        ~               ~             lower
gitsource     1.00        2.05            ~             lower
---------------------------------------------------------------
                    PERFORMANCE-PER-WATT RATIOS
tbench        1.00        ~               ~             higher
dbench        1.00        1.80**          ~             higher
kernbench     1.00        ~               ~             higher
gitsource     1.00        1.52**          ~             higher


2) INTEL, NON-HWP-CAPABLE MACHINES:

80x_BROADWELL_NUMA: Intel Broadwell EP, 40 cores / 80 threads, NUMA, SATA SSD storage
---------------------------------------------------------------
              sugov     powersave       perfgov       better if
---------------------------------------------------------------
                        PERFORMANCE RATIOS
tbench        1.00        1.11**          1.10**        higher
dbench        1.00        1.10            ~             lower
kernbench     1.00        1.10            ~             lower
gitsource     1.00        2.27            0.95**        lower
---------------------------------------------------------------
                    PERFORMANCE-PER-WATT RATIOS
tbench        1.00         1.05**         1.04**        higher
dbench        1.00         1.24**         0.95          higher
kernbench     1.00         ~              ~             higher
gitsource     1.00         0.86           1.04**        higher


48x_HASWELL_NUMA: Intel Haswell EP, 24 cores / 48 threads, NUMA, HDD storage
---------------------------------------------------------------
              sugov     powersave       perfgov       better if
---------------------------------------------------------------
                        PERFORMANCE RATIOS
tbench        1.00         1.25**         1.27**        higher
dbench        1.00         1.17           ~             lower
kernbench     1.00         1.04           ~             lower
gitsource     1.00         1.54           0.79**        lower
---------------------------------------------------------------
                    PERFORMANCE-PER-WATT RATIOS
tbench        1.00         1.18**         1.11**        higher
dbench        1.00         1.25**         ~             higher
kernbench     1.00         1.04**         0.97          higher
gitsource     1.00         0.77           ~             higher


3) AMD EPYC:

256x_ROME_NUMA: AMD Rome , 128 cores / 256 threads, NUMA, SATA SSD storage
---------------------------------------------------------------
              sugov      ondemand       perfgov       better if
---------------------------------------------------------------
                        PERFORMANCE RATIOS
tbench        1.00         1.11**       1.58**          higher
dbench        1.00         0.44**       0.40**          lower
kernbench     1.00         ~            0.91**          lower
gitsource     1.00         0.96**       0.65**          lower


128x_NAPLES_NUMA: AMD Naples , 64 cores / 128 threads, NUMA, SATA SSD storage
---------------------------------------------------------------
              sugov      ondemand       perfgov       better if
---------------------------------------------------------------
                        PERFORMANCE RATIOS
tbench        1.00         1.10**       1.19**          higher
dbench        1.00         1.05         0.95**          lower
kernbench     1.00         ~            0.95**          lower
gitsource     1.00         0.93**       0.55**          lower


Giovanni

