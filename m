Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80881185C1
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2019 12:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfLJLDY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Dec 2019 06:03:24 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46664 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfLJLDY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Dec 2019 06:03:24 -0500
Received: from 79.184.255.117.ipv4.supernova.orange.pl (79.184.255.117) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 878d41276126c033; Tue, 10 Dec 2019 12:03:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: About CPU hot-plug stress test failed in cpufreq driver
Date:   Tue, 10 Dec 2019 12:03:21 +0100
Message-ID: <7300000.zMGgbreFFD@kreacher>
In-Reply-To: <20191210085744.ocdcpubkmac6mk3i@vireshk-i7>
References: <DB3PR0402MB39165E1B832597ADBAB241AAF55C0@DB3PR0402MB3916.eurprd04.prod.outlook.com> <40413247.HltoIgKm8r@kreacher> <20191210085744.ocdcpubkmac6mk3i@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, December 10, 2019 9:57:44 AM CET Viresh Kumar wrote:
> On 10-12-19, 09:50, Rafael J. Wysocki wrote:
> > Index: linux-pm/include/linux/cpufreq.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/cpufreq.h
> > +++ linux-pm/include/linux/cpufreq.h
> > @@ -599,11 +599,13 @@ static inline bool cpufreq_this_cpu_can_
> >  {
> >  	/*
> >  	 * Allow remote callbacks if:
> > -	 * - dvfs_possible_from_any_cpu flag is set
> >  	 * - the local and remote CPUs share cpufreq policy
> > +	 * - dvfs_possible_from_any_cpu flag is set and the CPU running the
> > +	 *   code is not going offline.
> >  	 */
> > -	return policy->dvfs_possible_from_any_cpu ||
> > -		cpumask_test_cpu(smp_processor_id(), policy->cpus);
> > +	return cpumask_test_cpu(smp_processor_id(), policy->cpus) ||
> > +		(policy->dvfs_possible_from_any_cpu &&
> > +		 !cpumask_test_cpu(smp_processor_id(), policy->related_cpus));
> 
> This isn't enough as you are assuming that only a CPU from policy->related_cpus
> can do remote processing. On a ARM platform (like Qcom's Krait, octa-core), all
> 8 CPUs have separate policies as they don't share clock lines. Though they can
> still do remote processing for each other as the clk registers are common.
> 
> Also policy->related_cpus can anyway update frequency for the policy even if
> dvfs_possible_from_any_cpu is set to false.

I know, see

https://lore.kernel.org/linux-pm/CAJZ5v0h0934-VBODZZJ8gEG2byuhQ+bomoCuTmmQZOBtqu5bKQ@mail.gmail.com/T/#mccadfdc557468072ab6c5525601a71d60070e99b



