Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73260586FF2
	for <lists+linux-pm@lfdr.de>; Mon,  1 Aug 2022 19:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiHAR6K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Aug 2022 13:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiHAR5u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Aug 2022 13:57:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20896101D7
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 10:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2C49B8160E
        for <linux-pm@vger.kernel.org>; Mon,  1 Aug 2022 17:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B62C433D6;
        Mon,  1 Aug 2022 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659376608;
        bh=44LCcrouMZHC9BHhjLjbD3JPK6PchsuKX2t0WL9Nn7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rf/hBlDjHtaBzjplk3obAnyi8F6Vl6sAAcN+p0uSSVh4YGa3zHNjWSU2t9Ccv3haC
         07miiQ24FgBl62s55mdoMwTsiU6XKT22Bc0cMkbpBRTzLYtrsCgM7nNnHyzOlg/nEp
         eg8IFwvpLhcwH5/ySUqYtAtW7uSyMQVJvf67+Z7P0mLYMggUj9lv1IuVm6q6EocwVM
         +vM6IA16f4reSaww3vZDLi3MLXttQibpBEyds6rhRdTlp5OkjT24RCGs2UAY5KKjHE
         p5pl8fb2bdGpBkq6oUHJU4P4hNZZ+3Uc1J8J3rhJIId6DaFRKB9Q2V6PG58E88ru6w
         mIUca4euGUXnw==
Received: by pali.im (Postfix)
        id 2400F75F; Mon,  1 Aug 2022 19:56:45 +0200 (CEST)
Date:   Mon, 1 Aug 2022 19:56:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     Wojciech Bartczak <wbartczak@marvell.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nnet <nnet@fastmail.fm>,
        =?utf-8?Q?G=C3=A9rald?= Kerma <gandalf@gk2.net>
Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for
 1.2 GHz variant
Message-ID: <20220801175645.bnknpfg26acbat7c@pali>
References: <20210630135942.29730-1-kabel@kernel.org>
 <20210630225601.6372-1-kabel@kernel.org>
 <20210702163035.nmb5pniwpqtmaz4b@pali>
 <20210708143451.4htvdop4zvjufrq6@pali>
 <20210715193321.z3vswz6x4rzvw2fd@pali>
 <20210808193026.xuyaufi5wqnrcakd@pali>
 <20220801123616.uol4wrs6trttumsg@pali>
 <BN9PR18MB4251768A59D38A44C264E1FEDB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801141254.ojljy2lewgrkga3f@pali>
 <BN9PR18MB42514ADBD547CADD93BD7646DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR18MB42514ADBD547CADD93BD7646DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello Elad!

Robert (in CC) tested this proposed change. But increasing delay to
100ms does not help. CPU still crashes early during boot.

On Monday 01 August 2022 14:15:27 Elad Nachman wrote:
> Hi,
> 
> As first step, please try to increase the delay to 100ms, see if it helps.
> 
> Elad.
> 
> -----Original Message-----
> From: Pali Rohár <pali@kernel.org> 
> Sent: Monday, August 1, 2022 5:13 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Wojciech Bartczak <wbartczak@marvell.com>; Marek Behún <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gregory CLEMENT <gregory.clement@bootlin.com>; Robert Marko <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>; Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>; linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant
> 
> Hello Elad and thank you for response!
> 
> This errata is already implemented in the kernel for a longer time by Gregory's commit:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_stable_linux.git_commit_-3Fid-3D61c40f35f5cd6f67ccbd7319a1722eb78c815989&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=-E-AwB9STVx8xgapaCNSpDJIPPnkrzrWkZX0uFz2bfNGFnckZelT_XaovUUPrNIg&s=4EUcdDWB_gqnEV8nREQi9E_iym5bjoM6l5zLrbh_GVs&e= 
> 
> There is also 20ms delay after L2/L3 to L1 state switch.
> 
> Any idea what could be wrong here? Or is something more than above commit needed to correctly implement that errata?
> 
> On Monday 01 August 2022 14:01:07 Elad Nachman wrote:
> > Hi Pali,
> > 
> > There is an errata for that.
> > 
> > "
> > Switching from L2/L3 state (200/300 MHz) to L0 state (1200 MHz) 
> > requires sudden changes of VDD supply, and it requires time to 
> > stabilize the VDD supply. The solution is to use gradual switching from L2/L3 to L1 and then L1 to L0 state.
> > "
> > 
> > I would also add additional delay for the VDD supply stabilization.
> > 
> > FYI,
> > 
> > Elad.
> > 
> > -----Original Message-----
> > From: Pali Rohár <pali@kernel.org>
> > Sent: Monday, August 1, 2022 3:36 PM
> > To: Elad Nachman <enachman@marvell.com>; Wojciech Bartczak 
> > <wbartczak@marvell.com>
> > Cc: Marek Behún <kabel@kernel.org>; Viresh Kumar 
> > <viresh.kumar@linaro.org>; Gregory CLEMENT 
> > <gregory.clement@bootlin.com>; Robert Marko <robert.marko@sartura.hr>; 
> > Tomasz Maciej Nowak <tmn505@gmail.com>; Anders Trier Olesen 
> > <anders.trier.olesen@gmail.com>; Philip Soares 
> > <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian 
> > Hesselbarth <sebastian.hesselbarth@gmail.com>; 
> > linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> > Subject: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 
> > 1.2 GHz variant
> > 
> > External Email
> > 
> > ----------------------------------------------------------------------
> > + Elad and Wojciech from Marvell
> > 
> > Could you please look at this issue and/or forward it to relevant Marvell team?
> > 
> > Maintainer Viresh already wrote that we cannot hang forever for Marvell and patch which disables support for 1.2 GHz was merged:
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_l
> > inux-2Dpm_20210809040224.j2rvopmmqda3utc5-40vireshk-2Di7_&d=DwIDaQ&c=n
> > KjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=
> > 5nMMKyKOOM3XdMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&s=cXi
> > CZByknfz1rOIgJl4fJHl1KLLRq2shHul2-VPpYP0&e=
> > 
> > On Sunday 08 August 2021 21:30:26 Pali Rohár wrote:
> > > Gentle reminder. This is really serious issue. Could you please look at it?
> > > 
> > > Adding more MarvellEmbeddedProcessors people to the loop: Evan, 
> > > Benjamin an Igal
> > > 
> > > On Thursday 15 July 2021 21:33:21 Pali Rohár wrote:
> > > > Ping! Gentle reminder for Marvell people.
> > > > 
> > > > On Thursday 08 July 2021 16:34:51 Pali Rohár wrote:
> > > > > Konstantin, Nadav, Ken, Victor, Jason: This issue is pretty 
> > > > > serious, CPU on 1.2GHz A3720 is crashing. Could you please look at it?
> > > > > 
> > > > > On Friday 02 July 2021 18:30:35 Pali Rohár wrote:
> > > > > > +Jason from GlobalScale as this issue affects GlobalScale Espressobin Ultra and V7 1.2 GHz boards.
> > > > > > 
> > > > > > On Thursday 01 July 2021 00:56:01 Marek Behún wrote:
> > > > > > > The 1.2 GHz variant of the Armada 3720 SOC is unstable with
> > > > > > > DVFS: when the SOC boots, the WTMI firmware sets clocks and 
> > > > > > > AVS values that work correctly with 1.2 GHz CPU frequency, 
> > > > > > > but random crashes occur once cpufreq driver starts scaling.
> > > > > > > 
> > > > > > > We do not know currently what is the reason:
> > > > > > > - it may be that the voltage value for L0 for 1.2 GHz variant provided
> > > > > > >   by the vendor in the OTP is simply incorrect when scaling 
> > > > > > > is used,
> > > > > > > - it may be that some delay is needed somewhere,
> > > > > > > - it may be something else.
> > > > > > > 
> > > > > > > The most sane solution now seems to be to simply forbid the 
> > > > > > > cpufreq driver on 1.2 GHz variant.
> > > > > > > 
> > > > > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada
> > > > > > > 37xx")
> > > > > > > ---
> > > > > > > If someone from Marvell could look into this, it would be 
> > > > > > > great since basically 1.2 GHz variant cannot scale, which is 
> > > > > > > a feature that was claimed to be supported by the SOC.
> > > > > > > 
> > > > > > > Ken Ma / Victor Gu, you have worked on commit 
> > > > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__github.
> > > > > > > co
> > > > > > > m_MarvellEmbeddedProcessors_linux-2Dmarvell_commit_d6719fdc2
> > > > > > > b3 
> > > > > > > cac58064f41b531f86993c919aa9a&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7x
> > > > > > > tf 
> > > > > > > Q&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=5nMMKyKOOM
> > > > > > > 3X 
> > > > > > > dMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&s=b9cDK
> > > > > > > em t70OiTJF6KXj0ySzbxpsB_nuteXJE87via80&e=
> > > > > > > in linux-marvell.
> > > > > > > Your patch takes away the 1202 mV constant for 1.2 GHz base 
> > > > > > > CPU frequency and instead adds code that computes the 
> > > > > > > voltages from the voltage found in L0 AVS register (which is filled in by WTMI firmware).
> > > > > > > 
> > > > > > > Do you know why the code does not work correctly for some 
> > > > > > > 1.2 GHz boards? Do we need to force the L0 voltage to 1202 
> > > > > > > mV if it is lower, or something?
> > > > > > > ---
> > > > > > >  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
> > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > index 3fc98a3ffd91..c10fc33b29b1 100644
> > > > > > > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > @@ -104,7 +104,11 @@ struct armada_37xx_dvfs {  };
> > > > > > >  
> > > > > > >  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> > > > > > > -	{.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 6} },
> > > > > > > +	/*
> > > > > > > +	 * The cpufreq scaling for 1.2 GHz variant of the SOC is currently
> > > > > > > +	 * unstable because we do not know how to configure it properly.
> > > > > > > +	 */
> > > > > > > +	/* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4, 
> > > > > > > +6} }, */
> > > > > > >  	{.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
> > > > > > >  	{.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
> > > > > > >  	{.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5, 6} 
> > > > > > > },
> > > > > > > --
> > > > > > > 2.31.1
> > > > > > > 
