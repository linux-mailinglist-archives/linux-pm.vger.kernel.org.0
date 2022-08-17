Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541DC5979FB
	for <lists+linux-pm@lfdr.de>; Thu, 18 Aug 2022 01:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiHQXKP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 19:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiHQXKO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 19:10:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEF53ACA00
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 16:10:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B5D9CCE1D96
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 23:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B69C433D6;
        Wed, 17 Aug 2022 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660777808;
        bh=g/T+cdMgv4NiyqVOdny6bpWQSlPLHgRqxYEakmMgjrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JNukOTKmkDKHJN7BdO0NhwaER/vPrN0RWG+7912wGzM4TUNtTuV0vml5A2x2nz/XC
         oxbSKj9kOYV86vuamJSxqRZXbXfl1QULlNXYmiHb8Ga4ytaoCET1u07oxmw8U0a2Tj
         pMwxIXIOM4LmHn1dazBlHxkNbUpOEbM1o4Yrnsna6pjXUNYhruQP8m2e5z7FOdZ6EN
         V2FouYW6QTmClyGagL/V4Zw5Rh6XKn7xycv+FkD58Xr3LDjtYkvxSgYEF1JJqPoZlo
         /ptZ+JR4q6vjLHxctnZoX6xxRuObz3lGie27SlanGHi+hRNWSciETBRqORUCDATs1o
         ZuwNPjjY+/Oew==
Received: by pali.im (Postfix)
        id 1458477A; Thu, 18 Aug 2022 01:10:06 +0200 (CEST)
Date:   Thu, 18 Aug 2022 01:10:05 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Elad Nachman <enachman@marvell.com>,
        Wojciech Bartczak <wbartczak@marvell.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
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
Message-ID: <20220817231005.5nonyify5os6opah@pali>
References: <BN9PR18MB4251768A59D38A44C264E1FEDB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801141254.ojljy2lewgrkga3f@pali>
 <BN9PR18MB42514ADBD547CADD93BD7646DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801175645.bnknpfg26acbat7c@pali>
 <BN9PR18MB42518C761E574D862D30CDA7DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <CA+HBbNEHRhU4HOK-NGGLxak0UUfwjZvtkuLtzCk=fvSaS=MMEA@mail.gmail.com>
 <BN9PR18MB4251336FB8E017605FE4D088DB9D9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <CA+HBbNHp9duBYT7JGa14rn_OKpQFLQikFrZ5ktD2sAKsxGM8TQ@mail.gmail.com>
 <20220802171736.n7jwtbssnwr5hojv@pali>
 <CA+HBbNGKXu+TAT0i40MmACrmRuw_zB6PWSdRCn70B8h7qp6eLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNGKXu+TAT0i40MmACrmRuw_zB6PWSdRCn70B8h7qp6eLQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 17 August 2022 11:40:32 Robert Marko wrote:
> On Tue, Aug 2, 2022 at 7:17 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Tuesday 02 August 2022 18:56:07 Robert Marko wrote:
> > > On Tue, Aug 2, 2022 at 6:52 PM Elad Nachman <enachman@marvell.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > Unless the logs are misleading, then I see here:
> > > >
> > > > cpu cpu0: _set_opp: switching OPP: Freq 200000000 -> 1200000000 Hz, Level 0 -> 0, Bw 0 -> 0
> > > >
> > > > Which violates the errata.
> > > > If there is an interim step in between, I think it should be printed out in the debug so we can clearly understand what is the interim frequency setting between 200 and 1200 MHz.
> > >
> > > This is printed directly by the _set_opp from the cpufreq core, so it
> > > should be accurate.
> > > Pali, am I doing this correctly or I need to print from the A3K
> > > cpufreq or clk drivers?
> >
> > Hello! You need to print it from a3k clk driver. cpufreq core just ask
> > driver to switch speed from 200000000 to 1200000000 and clk driver then
> > change it with its own workaround function.
> >
> > The real change of Level is done at these places:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/clk/mvebu/armada-37xx-periph.c?h=v5.19#n548
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/clk/mvebu/armada-37xx-periph.c?h=v5.19#n592
> >
> > Check places where is done write operation to register
> > ARMADA_37XX_NB_CPU_LOAD.
> 
> Ok, finally got time to try it.
> I am now printing from the clk driver instead, hopefully in the right places:
> https://gist.github.com/robimarko/d297c81f70ef9620c830435bad8a6a8d
> 
> Trying to enlarge the wait to 100ms does not help.

Could you provide also diff which you applied to driver?

> Regards,
> Robert
> >
> > > Regards,
> > > Robert
> > > >
> > > > Elad.
> > > >
> > > > -----Original Message-----
> > > > From: Robert Marko <robert.marko@sartura.hr>
> > > > Sent: Tuesday, August 2, 2022 7:42 PM
> > > > To: Elad Nachman <enachman@marvell.com>
> > > > Cc: Pali Rohár <pali@kernel.org>; Wojciech Bartczak <wbartczak@marvell.com>; Marek Behún <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gregory CLEMENT <gregory.clement@bootlin.com>; Tomasz Maciej Nowak <tmn505@gmail.com>; Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>; linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>; Gérald Kerma <gandalf@gk2.net>
> > > > Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2 GHz variant
> > > >
> > > > On Mon, Aug 1, 2022 at 8:50 PM Elad Nachman <enachman@marvell.com> wrote:
> > > > >
> > > > > Hi Pali,
> > > > >
> > > > > Could you please provide the crash dump / call trace?
> > > > >
> > > > > Also, if you can please annotate with printk the exact voltage/frequency changes taken by the driver, up to the point of the crash?
> > > > >
> > > > > This will help understand the sequence of events leading to the crash.
> > > > >
> > > > > Thanks,
> > > > >
> > > > > Elad.
> > > >
> > > >
> > > > Hi Elad,
> > > > Here are 2 bootlogs, but I dont think they are of any use as the traces are rather random and they are always different, like a real voltage issue:
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__gist.github.com_robimarko_113216f566ccf159dfd33933889da042&d=DwIFaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=u39n7XPBdQVaoaviM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=jvmR3Myk443DelvNZv1OkhmpqnMp9Y8mvzzYz2g13rM&e=
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__gist.github.com_robimarko_990d757870d44a3c5acdfeb957547705&d=DwIFaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=u39n7XPBdQVaoaviM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=XrMFeJpEGO5A4rIKjkHLNc4MHzPGOBKeOktDWCbQMAc&e=
> > > >
> > > > Here is a bootleg with the frequency changes, OPP points that are set by the CPUFreq driver are also here:
> > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__gist.github.com_robimarko_1a81b0c6e93735b75ff4461d405c8033&d=DwIFaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=u39n7XPBdQVaoaviM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=02ljqhQAdZki-JwDYNPKaStmzSkhuitBRP6R17iOZqA&e=
> > > >
> > > > I am still digging to print the voltage changes as _set_opp_voltage is not being used.
> > > >
> > > > Regards,
> > > > Robert
> > > > >
> > > > >
> > > > > ________________________________
> > > > > מאת: Pali Rohár <pali@kernel.org>
> > > > > ‏‏נשלח: יום שני 01 אוגוסט 2022 20:56
> > > > > ‏‏אל: Elad Nachman <enachman@marvell.com>
> > > > > עותק: Wojciech Bartczak <wbartczak@marvell.com>; Marek Behún
> > > > > <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gregory
> > > > > CLEMENT <gregory.clement@bootlin.com>; Robert Marko
> > > > > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>;
> > > > > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares
> > > > > <philips@netisense.com>; linux-pm@vger.kernel.org
> > > > > <linux-pm@vger.kernel.org>; Sebastian Hesselbarth
> > > > > <sebastian.hesselbarth@gmail.com>;
> > > > > linux-arm-kernel@lists.infradead.org
> > > > > <linux-arm-kernel@lists.infradead.org>; nnet <nnet@fastmail.fm>;
> > > > > Gérald Kerma <gandalf@gk2.net>
> > > > > ‏‏נושא: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq
> > > > > for 1.2 GHz variant
> > > > >
> > > > > Hello Elad!
> > > > >
> > > > > Robert (in CC) tested this proposed change. But increasing delay to
> > > > > 100ms does not help. CPU still crashes early during boot.
> > > > >
> > > > > On Monday 01 August 2022 14:15:27 Elad Nachman wrote:
> > > > > > Hi,
> > > > > >
> > > > > > As first step, please try to increase the delay to 100ms, see if it helps.
> > > > > >
> > > > > > Elad.
> > > > > >
> > > > > > -----Original Message-----
> > > > > > From: Pali Rohár <pali@kernel.org>
> > > > > > Sent: Monday, August 1, 2022 5:13 PM
> > > > > > To: Elad Nachman <enachman@marvell.com>
> > > > > > Cc: Wojciech Bartczak <wbartczak@marvell.com>; Marek Behún
> > > > > > <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gregory
> > > > > > CLEMENT <gregory.clement@bootlin.com>; Robert Marko
> > > > > > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>;
> > > > > > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares
> > > > > > <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian
> > > > > > Hesselbarth <sebastian.hesselbarth@gmail.com>;
> > > > > > linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> > > > > > Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid
> > > > > > cpufreq for 1.2 GHz variant
> > > > > >
> > > > > > Hello Elad and thank you for response!
> > > > > >
> > > > > > This errata is already implemented in the kernel for a longer time by Gregory's commit:
> > > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_
> > > > > > pub_scm_linux_kernel_git_stable_linux.git_commit_-3Fid-3D61c40f35f5c
> > > > > > d6f67ccbd7319a1722eb78c815989&d=DwIDaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eT
> > > > > > eNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=-E-AwB9STVx8xgapaCNSpDJI
> > > > > > PPnkrzrWkZX0uFz2bfNGFnckZelT_XaovUUPrNIg&s=4EUcdDWB_gqnEV8nREQi9E_iy
> > > > > > m5bjoM6l5zLrbh_GVs&e=
> > > > > >
> > > > > > There is also 20ms delay after L2/L3 to L1 state switch.
> > > > > >
> > > > > > Any idea what could be wrong here? Or is something more than above commit needed to correctly implement that errata?
> > > > > >
> > > > > > On Monday 01 August 2022 14:01:07 Elad Nachman wrote:
> > > > > > > Hi Pali,
> > > > > > >
> > > > > > > There is an errata for that.
> > > > > > >
> > > > > > > "
> > > > > > > Switching from L2/L3 state (200/300 MHz) to L0 state (1200 MHz)
> > > > > > > requires sudden changes of VDD supply, and it requires time to
> > > > > > > stabilize the VDD supply. The solution is to use gradual switching from L2/L3 to L1 and then L1 to L0 state.
> > > > > > > "
> > > > > > >
> > > > > > > I would also add additional delay for the VDD supply stabilization.
> > > > > > >
> > > > > > > FYI,
> > > > > > >
> > > > > > > Elad.
> > > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Pali Rohár <pali@kernel.org>
> > > > > > > Sent: Monday, August 1, 2022 3:36 PM
> > > > > > > To: Elad Nachman <enachman@marvell.com>; Wojciech Bartczak
> > > > > > > <wbartczak@marvell.com>
> > > > > > > Cc: Marek Behún <kabel@kernel.org>; Viresh Kumar
> > > > > > > <viresh.kumar@linaro.org>; Gregory CLEMENT
> > > > > > > <gregory.clement@bootlin.com>; Robert Marko
> > > > > > > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>;
> > > > > > > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares
> > > > > > > <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian
> > > > > > > Hesselbarth <sebastian.hesselbarth@gmail.com>;
> > > > > > > linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> > > > > > > Subject: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq
> > > > > > > for
> > > > > > > 1.2 GHz variant
> > > > > > >
> > > > > > > External Email
> > > > > > >
> > > > > > > ------------------------------------------------------------------
> > > > > > > ----
> > > > > > > + Elad and Wojciech from Marvell
> > > > > > >
> > > > > > > Could you please look at this issue and/or forward it to relevant Marvell team?
> > > > > > >
> > > > > > > Maintainer Viresh already wrote that we cannot hang forever for Marvell and patch which disables support for 1.2 GHz was merged:
> > > > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.o
> > > > > > > rg_l
> > > > > > > inux-2Dpm_20210809040224.j2rvopmmqda3utc5-40vireshk-2Di7_&d=DwIDaQ
> > > > > > > &c=n
> > > > > > > KjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrw
> > > > > > > Q&m=
> > > > > > > 5nMMKyKOOM3XdMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&s
> > > > > > > =cXi CZByknfz1rOIgJl4fJHl1KLLRq2shHul2-VPpYP0&e=
> > > > > > >
> > > > > > > On Sunday 08 August 2021 21:30:26 Pali Rohár wrote:
> > > > > > > > Gentle reminder. This is really serious issue. Could you please look at it?
> > > > > > > >
> > > > > > > > Adding more MarvellEmbeddedProcessors people to the loop: Evan,
> > > > > > > > Benjamin an Igal
> > > > > > > >
> > > > > > > > On Thursday 15 July 2021 21:33:21 Pali Rohár wrote:
> > > > > > > > > Ping! Gentle reminder for Marvell people.
> > > > > > > > >
> > > > > > > > > On Thursday 08 July 2021 16:34:51 Pali Rohár wrote:
> > > > > > > > > > Konstantin, Nadav, Ken, Victor, Jason: This issue is pretty
> > > > > > > > > > serious, CPU on 1.2GHz A3720 is crashing. Could you please look at it?
> > > > > > > > > >
> > > > > > > > > > On Friday 02 July 2021 18:30:35 Pali Rohár wrote:
> > > > > > > > > > > +Jason from GlobalScale as this issue affects GlobalScale Espressobin Ultra and V7 1.2 GHz boards.
> > > > > > > > > > >
> > > > > > > > > > > On Thursday 01 July 2021 00:56:01 Marek Behún wrote:
> > > > > > > > > > > > The 1.2 GHz variant of the Armada 3720 SOC is unstable
> > > > > > > > > > > > with
> > > > > > > > > > > > DVFS: when the SOC boots, the WTMI firmware sets clocks
> > > > > > > > > > > > and AVS values that work correctly with 1.2 GHz CPU
> > > > > > > > > > > > frequency, but random crashes occur once cpufreq driver starts scaling.
> > > > > > > > > > > >
> > > > > > > > > > > > We do not know currently what is the reason:
> > > > > > > > > > > > - it may be that the voltage value for L0 for 1.2 GHz variant provided
> > > > > > > > > > > >   by the vendor in the OTP is simply incorrect when
> > > > > > > > > > > > scaling is used,
> > > > > > > > > > > > - it may be that some delay is needed somewhere,
> > > > > > > > > > > > - it may be something else.
> > > > > > > > > > > >
> > > > > > > > > > > > The most sane solution now seems to be to simply forbid
> > > > > > > > > > > > the cpufreq driver on 1.2 GHz variant.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Marek Behún <kabel@kernel.org>
> > > > > > > > > > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for
> > > > > > > > > > > > Armada
> > > > > > > > > > > > 37xx")
> > > > > > > > > > > > ---
> > > > > > > > > > > > If someone from Marvell could look into this, it would
> > > > > > > > > > > > be great since basically 1.2 GHz variant cannot scale,
> > > > > > > > > > > > which is a feature that was claimed to be supported by the SOC.
> > > > > > > > > > > >
> > > > > > > > > > > > Ken Ma / Victor Gu, you have worked on commit
> > > > > > > > > > > > https://urldefense.proofpoint.com/v2/url?u=https-3A__github.
> > > > > > > > > > > > co
> > > > > > > > > > > > m_MarvellEmbeddedProcessors_linux-2Dmarvell_commit_d6719
> > > > > > > > > > > > fdc2
> > > > > > > > > > > > b3
> > > > > > > > > > > > cac58064f41b531f86993c919aa9a&d=DwIDaQ&c=nKjWec2b6R0mOyP
> > > > > > > > > > > > az7x
> > > > > > > > > > > > tf
> > > > > > > > > > > > Q&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=5nMMKy
> > > > > > > > > > > > KOOM
> > > > > > > > > > > > 3X
> > > > > > > > > > > > dMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&s=b
> > > > > > > > > > > > 9cDK em t70OiTJF6KXj0ySzbxpsB_nuteXJE87via80&e=
> > > > > > > > > > > > in linux-marvell.
> > > > > > > > > > > > Your patch takes away the 1202 mV constant for 1.2 GHz
> > > > > > > > > > > > base CPU frequency and instead adds code that computes
> > > > > > > > > > > > the voltages from the voltage found in L0 AVS register (which is filled in by WTMI firmware).
> > > > > > > > > > > >
> > > > > > > > > > > > Do you know why the code does not work correctly for
> > > > > > > > > > > > some
> > > > > > > > > > > > 1.2 GHz boards? Do we need to force the L0 voltage to
> > > > > > > > > > > > 1202 mV if it is lower, or something?
> > > > > > > > > > > > ---
> > > > > > > > > > > >  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
> > > > > > > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > > > > b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > > > > index 3fc98a3ffd91..c10fc33b29b1 100644
> > > > > > > > > > > > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > > > > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > > > > @@ -104,7 +104,11 @@ struct armada_37xx_dvfs {  };
> > > > > > > > > > > >
> > > > > > > > > > > >  static struct armada_37xx_dvfs armada_37xx_dvfs[] = {
> > > > > > > > > > > > - {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2, 4,
> > > > > > > > > > > > 6} },
> > > > > > > > > > > > + /*
> > > > > > > > > > > > +  * The cpufreq scaling for 1.2 GHz variant of the SOC
> > > > > > > > > > > > +is currently
> > > > > > > > > > > > +  * unstable because we do not know how to configure it properly.
> > > > > > > > > > > > +  */
> > > > > > > > > > > > + /* {.cpu_freq_max = 1200*1000*1000, .divider = {1, 2,
> > > > > > > > > > > > +4, 6} }, */
> > > > > > > > > > > >    {.cpu_freq_max = 1000*1000*1000, .divider = {1, 2, 4, 5} },
> > > > > > > > > > > >    {.cpu_freq_max = 800*1000*1000,  .divider = {1, 2, 3, 4} },
> > > > > > > > > > > >    {.cpu_freq_max = 600*1000*1000,  .divider = {2, 4, 5,
> > > > > > > > > > > > 6} },
> > > > > > > > > > > > --
> > > > > > > > > > > > 2.31.1
> > > > > > > > > > > >
> > > >
> > > >
> > > >
> > > > --
> > > > Robert Marko
> > > > Staff Embedded Linux Engineer
> > > > Sartura Ltd.
> > > > Lendavska ulica 16a
> > > > 10000 Zagreb, Croatia
> > > > Email: robert.marko@sartura.hr
> > > > Web: https://urldefense.proofpoint.com/v2/url?u=http-3A__www.sartura.hr&d=DwIFaQ&c=nKjWec2b6R0mOyPaz7xtfQ&r=eTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=u39n7XPBdQVaoaviM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=_aBokTETNVzTrHqewupr4PeLusBNf7LGrTmjI2hppFk&e=
> > >
> > >
> > >
> > > --
> > > Robert Marko
> > > Staff Embedded Linux Engineer
> > > Sartura Ltd.
> > > Lendavska ulica 16a
> > > 10000 Zagreb, Croatia
> > > Email: robert.marko@sartura.hr
> > > Web: www.sartura.hr
> 
> 
> 
> -- 
> Robert Marko
> Staff Embedded Linux Engineer
> Sartura Ltd.
> Lendavska ulica 16a
> 10000 Zagreb, Croatia
> Email: robert.marko@sartura.hr
> Web: www.sartura.hr
