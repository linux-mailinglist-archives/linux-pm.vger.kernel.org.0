Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D53586B2D
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiHAMrD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 08:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbiHAMqo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 08:46:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF356B76
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 05:36:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8053961127
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 12:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F018C433D6;
        Mon,  1 Aug 2022 12:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659357379;
        bh=kZCEGskqalhxUksNqAHxXa4wKsmMgGTM0zR1HJDxJeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWwM21I5r6RewDjzByYaeHA/ymoaZz9e35S0xPyE4Dr846KRS93uvqNg1qZ2Ij2gv
         tsnB+g6oNIJnBkRMze8ubmlEDASesMb7oBKnw/gsE6BlwYuXfSqptCNmkccjNWBRe/
         XiAfUoFBcnq6wgfpRmpGj5xW+9d9bkQiHTyqOyFws4SL7MtJlOZrioQv+gdnnFSzh0
         54mvLsZZ8BcWHt+uk2TWzxCZGpzhxFGZia2mmbOrF0ovzF/UpdAdumgXsUXSIJlC5h
         z/wMpS9ST/H41tBXYfhLS/6GSnyLqoznhzdyU5jU+0X8wVdSgLnHXJF3gddtCWmrJC
         30jgHAWweAPHA==
Received: by pali.im (Postfix)
        id D8C9F75F; Mon,  1 Aug 2022 14:36:16 +0200 (CEST)
Date:   Mon, 1 Aug 2022 14:36:16 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Elad Nachman <enachman@marvell.com>,
        Wojciech Bartczak <wbartczak@marvell.com>
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
Message-ID: <20220801123616.uol4wrs6trttumsg@pali>
References: <20210630135942.29730-1-kabel@kernel.org>
 <20210630225601.6372-1-kabel@kernel.org>
 <20210702163035.nmb5pniwpqtmaz4b@pali>
 <20210708143451.4htvdop4zvjufrq6@pali>
 <20210715193321.z3vswz6x4rzvw2fd@pali>
 <20210808193026.xuyaufi5wqnrcakd@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210808193026.xuyaufi5wqnrcakd@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+ Elad and Wojciech from Marvell

Could you please look at this issue and/or forward it to relevant Marvell team?

Maintainer Viresh already wrote that we cannot hang forever for Marvell
and patch which disables support for 1.2 GHz was merged:
https://lore.kernel.org/linux-pm/20210809040224.j2rvopmmqda3utc5@vireshk-i7/

On Sunday 08 August 2021 21:30:26 Pali Rohár wrote:
> Gentle reminder. This is really serious issue. Could you please look at it?
> 
> Adding more MarvellEmbeddedProcessors people to the loop: Evan, Benjamin an Igal
> 
> On Thursday 15 July 2021 21:33:21 Pali Rohár wrote:
> > Ping! Gentle reminder for Marvell people.
> > 
> > On Thursday 08 July 2021 16:34:51 Pali Rohár wrote:
> > > Konstantin, Nadav, Ken, Victor, Jason: This issue is pretty serious,
> > > CPU on 1.2GHz A3720 is crashing. Could you please look at it?
> > > 
> > > On Friday 02 July 2021 18:30:35 Pali Rohár wrote:
> > > > +Jason from GlobalScale as this issue affects GlobalScale Espressobin Ultra and V7 1.2 GHz boards.
> > > > 
> > > > On Thursday 01 July 2021 00:56:01 Marek Behún wrote:
> > > > > The 1.2 GHz variant of the Armada 3720 SOC is unstable with DVFS: when
> > > > > the SOC boots, the WTMI firmware sets clocks and AVS values that work
> > > > > correctly with 1.2 GHz CPU frequency, but random crashes occur once
> > > > > cpufreq driver starts scaling.
> > > > > 
> > > > > We do not know currently what is the reason:
> > > > > - it may be that the voltage value for L0 for 1.2 GHz variant provided
> > > > >   by the vendor in the OTP is simply incorrect when scaling is used,
> > > > > - it may be that some delay is needed somewhere,
> > > > > - it may be something else.
> > > > > 
> > > > > The most sane solution now seems to be to simply forbid the cpufreq
> > > > > driver on 1.2 GHz variant.
> > > > > 
> > > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
> > > > > ---
> > > > > If someone from Marvell could look into this, it would be great since
> > > > > basically 1.2 GHz variant cannot scale, which is a feature that was
> > > > > claimed to be supported by the SOC.
> > > > > 
> > > > > Ken Ma / Victor Gu, you have worked on commit
> > > > > https://github.com/MarvellEmbeddedProcessors/linux-marvell/commit/d6719fdc2b3cac58064f41b531f86993c919aa9a
> > > > > in linux-marvell.
> > > > > Your patch takes away the 1202 mV constant for 1.2 GHz base CPU
> > > > > frequency and instead adds code that computes the voltages from the
> > > > > voltage found in L0 AVS register (which is filled in by WTMI firmware).
> > > > > 
> > > > > Do you know why the code does not work correctly for some 1.2 GHz
> > > > > boards? Do we need to force the L0 voltage to 1202 mV if it is lower,
> > > > > or something?
> > > > > ---
> > > > >  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
> > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > index 3fc98a3ffd91..c10fc33b29b1 100644
> > > > > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > @@ -104,7 +104,11 @@ struct armada_37xx_dvfs {
> > > > >  };
> > > > >  
> > > > >  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> > > > > -	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
> > > > > +	/*
> > > > > +	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
> > > > > +	 * unstable because we do not know how to configure it properly.
> > > > > +	 */
> > > > > +	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} }, */
> > > > >  	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
> > > > >  	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
> > > > >  	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} },
> > > > > -- 
> > > > > 2.31.1
> > > > > 
