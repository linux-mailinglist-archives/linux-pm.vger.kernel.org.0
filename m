Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8404F341F89
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 15:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCSOfv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 10:35:51 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44700 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhCSOfr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 10:35:47 -0400
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 2.0.3)
 id 9de933e05a2b666b; Fri, 19 Mar 2021 15:35:45 +0100
Received: from kreacher.localnet (89-64-81-50.dynamic.chello.pl [89.64.81.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id EE65E668FB8;
        Fri, 19 Mar 2021 15:35:44 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC][PATCH] sched: Optimize cpufreq_update_util
Date:   Fri, 19 Mar 2021 15:35:43 +0100
Message-ID: <5452200.DvuYhMxLoT@kreacher>
In-Reply-To: <20210319073751.qz2ytpxl2ikrt2b7@vireshk-i7>
References: <20210318212826.GW4746@worktop.programming.kicks-ass.net> <20210319073751.qz2ytpxl2ikrt2b7@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrudefkedgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvjeelgffhiedukedtleekkedvudfggefhgfegjefgueekjeelvefggfdvledutdenucfkphepkeelrdeigedrkedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekledrieegrdekuddrhedtpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehvihhntggvnhhtrdhguhhithhtohhtsehlihhnrghrohdrohhrghdprhgtphhtthhopeguihgvthhmrghrrdgvghhgvghmrghnnhesrghrmhdrtghomhdprhgtphhtthho
 pehrohhsthgvughtsehgohhoughmihhsrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhpohhimhgsohgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhg
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Friday, March 19, 2021 8:37:51 AM CET Viresh Kumar wrote:
> On 18-03-21, 22:28, Peter Zijlstra wrote:
> > Also, is there a lock order comment in cpufreq somewhere?
> 
> I don't think so.
> 
> > I tried
> > following it, but eventually gave up and figured 'asking' lockdep was
> > far simpler.
> 
> This will get called from CPU's online/offline path at worst, nothing more.

I'm not sure if I understand you correctly, but for completeness the callback
is also set/unset on driver registration and governor switch.

> > +static void cpufreq_update_optimize(void)
> > +{
> > +	struct update_util_data *data;
> > +	cpu_util_update_f func = NULL, dfunc;
> > +	int cpu;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		data = per_cpu(cpufreq_update_util_data, cpu);
> > +		dfunc = data ? READ_ONCE(data->func) : NULL;
> > +
> > +		if (dfunc) {
> > +			if (!func)
> > +				func = dfunc;
> > +			else if (func != dfunc)
> > +				return;
> > +		} else if (func)
> > +			return;
> > +	}
> 
> So there is nothing cpufreq specific IIRC that can help make this better, this
> is basically per policy.

Well, in some cases the driver knows that there will never be more that 1 CPU
per policy and so schedutil will never use the "shared" variant.

For instance, with intel_pstate all CPUs will always use the same callback.

> For example, on an ARM platform we have two cpufreq policies with one policy
> covering 4 CPUs, while the other one covering only 1 (maybe because we didn't
> add those CPUs in DT or something else), then also we will end up separate
> routines.
> 
> Or if we take all CPUs of a policy offline and then bring them up one by one, I
> think for the first CPU online event in that policy we will end up using the
> sugov_update_single_freq() variant for some time, until the time more CPUs come
> up.
> 
> So traversing the way you did this is probably something that will work properly
> in all corner cases.

Agreed.

It might be simplified in some cases, though, AFAICS.



