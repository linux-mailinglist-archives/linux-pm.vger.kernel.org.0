Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEBB2E1C81
	for <lists+linux-pm@lfdr.de>; Wed, 23 Dec 2020 14:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgLWNH7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Dec 2020 08:07:59 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:49014 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728358AbgLWNH6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Dec 2020 08:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1608728809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ogV8qzBEfLipZ9h5n1xOzYS+XPOgGWLzX2qIcnRtCc=;
        b=gukpLdTeueQBN99I2NsMh4j1/rAxv1dSzvMIWTqxxerZFJyj8Hle1vrfeUtXXhl4H9SRCf
        FTFZ5x5WG558J6v4bUULdQ3SHeMROlS9GIVOtFun4MXNUvQ2ivrvnAdenLTOYvG1UN6Bn6
        oLQmTLOx0tE33asLFzvFU3WX+G12yt4=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2057.outbound.protection.outlook.com [104.47.14.57]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-3-CqvHcIv5NAW2Be5LVeSWYw-1;
 Wed, 23 Dec 2020 14:06:47 +0100
X-MC-Unique: CqvHcIv5NAW2Be5LVeSWYw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1fqwvbuBB/3SOCb6b7sC4mslCU+6fP+VliHcRs2EtsQONicKaXQFXIfdV869rZl1KPCPmvU8mhHbegtvQkFTqVx9NqxxhVNGSfSftL0xITSE7Til47/YEhytBdVT40MLgC/LUZf1/1zbUrA0Xgj0lZgBUV8q37i0wWFCztnJxarwD3cC0Doh80fHpY6Vzge8RiJXk3gOt1iKG3lnAu5XC5GGRttxiH52ymevhotrKN8GLPeYdqjsM2eTPcAYO6TB4BdlEquCAeD8h4mja9pbfYqj8AQU2mL6pnsWzArvDzV3/5gfyxRWiAYVzpkfrh5434hf4mCNxQB9TFU+NMerQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ogV8qzBEfLipZ9h5n1xOzYS+XPOgGWLzX2qIcnRtCc=;
 b=Jgrv27ih2hZAi7REsCVSGGyGJ4hm/OPpKM+2YqkCK3U/TaVOmXyy8Yabu/iMFcczVVVZnEPHVOJqQub0VxDzYS9c6/JOFseF5+TBBF9nRomxhpoKwMsfcekJ07y2KATd7SGAMTGMg1NCwblKcrPTZbba0cBEd1rR9gwEo3MSl8tBrscMN0I+MqCQwtR2/GLcJtHBuOEBKzBPSjW+kUxLlcFpOAkCn6keolekePDnse1G01Ihhm8JUeH5pGePBnzDFZRNv+q2oLNNkLkNHhI4kV2eVsoDx4s+wvNYSvlNTnpukOmCXzhYsNr7yCqwN4pwSypSXA+Wm4WQQh834MmVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com (2603:10a6:208:70::28)
 by AM8PR04MB7266.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Wed, 23 Dec
 2020 13:06:46 +0000
Received: from AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::797c:6e40:f893:4082]) by AM0PR04MB4530.eurprd04.prod.outlook.com
 ([fe80::797c:6e40:f893:4082%6]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 13:06:46 +0000
Message-ID: <1608728803.14392.59.camel@suse.com>
Subject: Re: [PATCH v2 0/3] cpufreq: Allow drivers to receive more
 information from the governor
From:   Giovanni Gherdovich <ggherdovich@suse.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Doug Smythies <dsmythies@telus.net>
Date:   Wed, 23 Dec 2020 14:06:43 +0100
In-Reply-To: <CAJZ5v0jfgFRqXisWQUH0J-Xfvh_jjWw8mC_AKyd-tAgRNamj9Q@mail.gmail.com>
References: <20360841.iInq7taT2Z@kreacher> <3827230.0GnL3RTcl1@kreacher>
         <1608307905.26567.46.camel@suse.com>
         <CAJZ5v0jfgFRqXisWQUH0J-Xfvh_jjWw8mC_AKyd-tAgRNamj9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.250.132.148]
X-ClientProxiedBy: AM0PR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::25) To AM0PR04MB4530.eurprd04.prod.outlook.com
 (2603:10a6:208:70::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux-ni6k.dhcp.prg.suse.com (195.250.132.148) by AM0PR01CA0156.eurprd01.prod.exchangelabs.com (2603:10a6:208:aa::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Wed, 23 Dec 2020 13:06:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a510baf-8681-49b0-91cb-08d8a7439a10
X-MS-TrafficTypeDiagnostic: AM8PR04MB7266:
X-Microsoft-Antispam-PRVS: <AM8PR04MB726648E4E864D690767C58BB93DE0@AM8PR04MB7266.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+5ksENAh3GItP0BpTD62KUiv2g1xnneJ77RAr8bgjJhe/HeAhCDj21dTcEbH+ehmGto+ZB+f5HJDVpNKYThKqXs6QF2/b66PFw6JHRkO1sdq2cgsrOJmGhevZ06+vUPGGVa2kcmpUC1Is8+NvQV2OFpu+eHjJ0uGhndJMA13bi2vVsZwyzmP8wopGfYr57/2BROlR4FXlb0/HCGVvTnYzWQ1vyG4xQWBRV/2w314ByZttaOaQh75zLdEcxDGT1uN0ZopTZUrovlrTYcS0i3o2VUux0u2kbBGFDwmY1xz9ViprTF19J3fpfdncqR6ke4cQqyX4sJiQiw+cS1hd9ngyeEO/YG5CP/GQhufew6JbGFmrZC0FLweDlV8S+b8JP+jBWzEHQdguUX1NEA+JH8MU+xJJ3+73hswPoLVzmuoot41wEQVIW/cypxn7xmKnEx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4530.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(39860400002)(376002)(396003)(66946007)(7696005)(52116002)(2616005)(53546011)(2906002)(36756003)(6486002)(956004)(66556008)(66476007)(83380400001)(4326008)(26005)(54906003)(103116003)(6916009)(316002)(16526019)(8936002)(5660300002)(478600001)(186003)(8676002)(4001150100001)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V1VGdEFCdndxNDZaaU5xakxwY3NFcCtjSFIycGlobFdQQkxNb3lxSEJKSFpJ?=
 =?utf-8?B?WWVnck81Y0lkQUV4T1RQNms5eUtSRXhVZXN2Qk00VzRhTU5ZSE9CdDJHcXUw?=
 =?utf-8?B?Ukl5QVAxeEJMNjVQa1lnU2hnb3cxcGNDV1NiZ2lZcldKYURNbGNmdkRLQlhl?=
 =?utf-8?B?cFAvdTh6S2lNL1RUNEs3aVhCN1VoVkt5NkdHTWJIQXZGQUhFbWtYVitLSm1E?=
 =?utf-8?B?Q3FBT2JiRnBTT1k3YlozTnk1aWVxc2Z6SGFQUnFHZkRLRzZLQytpVEpEN3BV?=
 =?utf-8?B?d0RNNGw2OHJzL0dCMEw1bXROMVRPSFIxUU5RZnowa3dLVFFiK2dhcUc1OXhh?=
 =?utf-8?B?aURocW13UWVXdWV5WTFNQ1M2clQ4aEZHcTBkMlhGVUM0ZTJUTElST1M4UjFU?=
 =?utf-8?B?SHdsZjNkQlNFczVNUmtSK2wycFZOWUhGNVlPbjk4R2tERjUvOElyWmxkdFZ3?=
 =?utf-8?B?YWh0a0ViZnJoNkFQS29VelNrY3pZUUhRaHdjYWt2UEJQaUt4a1BaTU9yQ1VV?=
 =?utf-8?B?WjZueGUxbm1lTUhTaG9LU0FNVFhRbjZxZW96emlEOUVRSzczNk9KbVZnZEsz?=
 =?utf-8?B?RjQxanEzS3NiUjh2YTdkUk9BclYydHYvaWFLZ3ppeS80eU85elozRkhielBu?=
 =?utf-8?B?czdMd0I3OUZFc1ZCeitvTklxUS9rZFVSSmZPc1FJakN4NlljZXNscjBwMk1l?=
 =?utf-8?B?TktxU0JqNXlILzdacWw0b1g1SUhnSDc4Y1luaTFkWi9UY2JRWXdtUmJXaXFQ?=
 =?utf-8?B?T1dSdWprNjhsYndGV2QxbGlFb3BQRVUrSEhwWWFoOUYxak5lUUoyMEFvdldw?=
 =?utf-8?B?NmxoYU5WYlpINURCOXRKZ0lHT2xVMHIwWkVGZDljdkpzdVloQnZpTTNPOVBE?=
 =?utf-8?B?SlNtRjQxSmg3UFpxUHZvQkErbUV3US9pTlJ6OFFSa1VucWVXZWlYLzlyaCtl?=
 =?utf-8?B?aEs4Y0tOSHczSnhtek5nWkgwVzZwSXBmZjJWR2toZEQ0bk5DMmhScjVxN0pI?=
 =?utf-8?B?UjIzSUZnem5Ea09aRm9pUEY1dk85bUt4c0xNV1ptbGpOaEdOWU9xM1p4YjZr?=
 =?utf-8?B?U2M0anA2VkxGRWtHYzUrd2tackcyNmJ0TGJocFpMN1lnNzU2OEQxeE03N08w?=
 =?utf-8?B?dStCUmoyNzE2TUQ0Ym8yV1RONy9aLzl5aFc0WnRjSXRVU2IyaGJzS1EwRCtz?=
 =?utf-8?B?dGlLbmtYOUUxRmRXYUtCWXpJUWM0dmpERERFcE9IcGs3UFl3UndGN3Z2d1d3?=
 =?utf-8?B?dENpRU9Ud0p2OWRhQ1dPck05Q3U2OE9lNk5UTTdJTDVJQ1JpVWN2OUNlMGlJ?=
 =?utf-8?Q?6YlkmuWx9Xa2/R3d5YhANoiJruhzHOV2eZ?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4530.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2020 13:06:46.0460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a510baf-8681-49b0-91cb-08d8a7439a10
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K1/RUPqtqHdPTSYwNjHBxPW1RJWeFeklnDdZjbANs7X8vhfYGKUtdnh17IyEeSJedfRhzx13KPU7RZpj4ZrZvO8VkXWyv37s9cc8LYU32j8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7266
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2020-12-21 at 17:11 +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> On Fri, Dec 18, 2020 at 5:22 PM Giovanni Gherdovich wrote:
> > 
> > Gitsource: this test show the most compelling case against the
> >     sugov-HWP.desired series: on the Cascade Lake sugov-HWP.desired is 10%
> >     faster than sugov-HWP.min (it was expected to be slower!) and 35% less
> >     efficient (we expected more performance-per-watt, not less).
> 
> This is a bit counter-intuitive, so it is good to try to understand
> what's going on instead of drawing conclusions right away from pure
> numbers.
> 
> My interpretation of the available data is that gitsource benefits
> from the "race-to-idle" effect in terms of energy-efficiency which
> also causes it to suffer in terms of performance.  Namely, completing
> the given piece of work faster causes some CPU idle time to become
> available and that effectively reduces power, but it also increases
> the response time (by the idle state exit latency) which causes
> performance to drop. Whether or not this effect can be present depends
> on what CPU idle states are available etc. and it may be a pure
> coincidence.
>
> [snip]

Right, race-to-idle might explain the increased efficiency of HWP.MIN.
As you note, increased exit latencies from idle can also explain the overall
performance difference.

> There is a whole broad category of workloads involving periodic tasks
> that do the same amount of work in every period regardless of the
> frequency they run at (as long as the frequency is sufficient to avoid
> "overrunning" the period) and they almost never benefit from
> "race-to-idle".There is zero benefit from running them too fast and
> the energy-efficiency goes down the sink when that happens.
> 
> Now the problem is that with sugov-HWP.min the users who care about
> these workloads don't even have an option to use the task utilization
> history recorded by the scheduler to bias the frequency towards the
> "sufficient" level, because sugov-HWP.min only sets a lower bound on
> the frequency selection to improve the situation, so the choice
> between it and sugov-HWP.desired boils down to whether or not to give
> that option to them and my clear preference is for that option to
> exist.  Sorry about that.  [Note that it really is an option, though,
> because "pure" HWP is still the default for HWP-enabled systems.]

Sure, the periodic workloads benefit from this patch, Doug's test shows that.

I guess I'm still confused by the difference between setting HWP.DESIRED and
disabling HWP completely. The Intel manual says that a non-zero HWP.DESIRED
"effectively disabl[es] HW autonomous selection", but then continues with "The
Desired_Performance input is non-constraining in terms of Performance and
Energy optimizations, which are independently controlled". The first
statement sounds like HWP is out of the picture (no more autonomous
frequency selections) but the latter part implies there are other
optimizations still available. I'm not sure how to reason about that.

> It may be possible to restore some "race-to-idle" benefits by tweaking
> HWP_REQ.EPP in the future, but that needs to be investigated.
> 
> BTW, what EPP value was there on the system where you saw better
> performance under sugov-HWP.desired?  If it was greater than zero, it
> would be useful to decrease EPP (by adjusting the
> energy_performance_preference attributes in sysfs for all CPUs) and
> see what happens to the performance difference then.

For sugov-HWP.desired the EPP was 0x80 (the default value).


Giovanni

