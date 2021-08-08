Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8023E3C89
	for <lists+linux-pm@lfdr.de>; Sun,  8 Aug 2021 21:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhHHTat (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Aug 2021 15:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhHHTas (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 8 Aug 2021 15:30:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6B2460E96;
        Sun,  8 Aug 2021 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628451028;
        bh=3205nher1EnmQYqUzYAVh5dzqykzMDiyMH8xLp3a8nU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNo0HkydcZ2DcUhtWkCrrYzowWPYgTI7r9h9dzNA90HvPim5/0hRpvjg+Nujykf0t
         bPlkzq+A5jPsDuukjFE5gg/WsI2ElOEHRbBpnp03/bQLLIYQcq9HTyT4hQZWsljj4d
         2/ngaNyLleTnVOCbVGT2Mp7l89pqtkPHvAUrm3LEM82jZ6VZsdPbdKmGwNCwg94U11
         APzhVqTeq47YKcfnnWxQDgfdtDR8lqZP1ke9HCLPF/I70eqJ5SV42rfelqxNvhvl7f
         U3kBQ0c2skaRxohZJP1uV5XfINtfORZx5QsJ9NHNDLHBtyYE0koF5eanaZ4GbYBlSt
         lxLJi5ZCIb4qg==
Received: by pali.im (Postfix)
        id 4447C13DC; Sun,  8 Aug 2021 21:30:26 +0200 (CEST)
Date:   Sun, 8 Aug 2021 21:30:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Porotchkin <kostap@marvell.com>,
        Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>,
        Victor Gu <xigu@marvell.com>, Evan Wang <xswang@marvell.com>,
        Benjamin Huang <gdhuang@marvell.com>,
        Igal Liberman <igall@marvell.com>,
        Jason Hung <jhung@globalscaletechnologies.com>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        linux-pm@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, nnet <nnet@fastmail.fm>
Subject: Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz
 variant
Message-ID: <20210808193026.xuyaufi5wqnrcakd@pali>
References: <20210630135942.29730-1-kabel@kernel.org>
 <20210630225601.6372-1-kabel@kernel.org>
 <20210702163035.nmb5pniwpqtmaz4b@pali>
 <20210708143451.4htvdop4zvjufrq6@pali>
 <20210715193321.z3vswz6x4rzvw2fd@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210715193321.z3vswz6x4rzvw2fd@pali>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Gentle reminder. This is really serious issue. Could you please look at it?

Adding more MarvellEmbeddedProcessors people to the loop: Evan, Benjamin an Igal

On Thursday 15 July 2021 21:33:21 Pali Rohár wrote:
> Ping! Gentle reminder for Marvell people.
> 
> On Thursday 08 July 2021 16:34:51 Pali Rohár wrote:
> > Konstantin, Nadav, Ken, Victor, Jason: This issue is pretty serious,
> > CPU on 1.2GHz A3720 is crashing. Could you please look at it?
> > 
> > On Friday 02 July 2021 18:30:35 Pali Rohár wrote:
> > > +Jason from GlobalScale as this issue affects GlobalScale Espressobin Ultra and V7 1.2 GHz boards.
> > > 
> > > On Thursday 01 July 2021 00:56:01 Marek Behún wrote:
> > > > The 1.2 GHz variant of the Armada 3720 SOC is unstable with DVFS: when
> > > > the SOC boots, the WTMI firmware sets clocks and AVS values that work
> > > > correctly with 1.2 GHz CPU frequency, but random crashes occur once
> > > > cpufreq driver starts scaling.
> > > > 
> > > > We do not know currently what is the reason:
> > > > - it may be that the voltage value for L0 for 1.2 GHz variant provided
> > > >   by the vendor in the OTP is simply incorrect when scaling is used,
> > > > - it may be that some delay is needed somewhere,
> > > > - it may be something else.
> > > > 
> > > > The most sane solution now seems to be to simply forbid the cpufreq
> > > > driver on 1.2 GHz variant.
> > > > 
> > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> > > > ---
> > > > If someone from Marvell could look into this, it would be great since
> > > > basically 1.2 GHz variant cannot scale, which is a feature that was
> > > > claimed to be supported by the SOC.
> > > > 
> > > > Ken Ma / Victor Gu, you have worked on commit
> > > > https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/d6719fdc2b3cac58064f41b531f86993c919aa9a
> > > > in linux-marvell.
> > > > Your patch takes away the 1202 mV constant for 1.2 GHz base CPU
> > > > frequency and instead adds code that computes the voltages from the
> > > > voltage found in L0 AVS register (which is filled in by WTMI firmware).
> > > > 
> > > > Do you know why the code does not work correctly for some 1.2 GHz
> > > > boards? Do we need to force the L0 voltage to 1202 mV if it is lower,
> > > > or something?
> > > > ---
> > > >  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
> > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > index 3fc98a3ffd91..c10fc33b29b1 100644
> > > > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > @@ -104,7 +104,11 @@ struct armada_37xx_dvfs {
> > > >  };
> > > >  
> > > >  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> > > > -	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
> > > > +	/*
> > > > +	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
> > > > +	 * unstable because we do not know how to configure it properly.
> > > > +	 */
> > > > +	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
> > > >  	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
> > > >  	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
> > > >  	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
> > > > -- 
> > > > 2.31.1
> > > > 
