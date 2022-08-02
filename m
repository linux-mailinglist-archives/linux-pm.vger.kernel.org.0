Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2127588088
	for <lists+linux-pm@lfdr.de>; Tue,  2 Aug 2022 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiHBQ5R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Aug 2022 12:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiHBQ4U (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2022 12:56:20 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4982140B0
        for <linux-pm@vger.kernel.org>; Tue,  2 Aug 2022 09:56:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id r13so17202639oie.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Aug 2022 09:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pT4ZjpeVT57Af3KVzsGaTofnC+IwD0Maex8TCGO8hyo=;
        b=2oaIMV5PFNAFU0kfTq/4DGWo5cV0pfn0WwiVbe24Un03/BJ3lhrdfpFL8Y5PIy+5bX
         CxH1KtEHIFd2Mlh5brm5VOMGhuGnwtqJdqCuNkLvu76VMqDypwCXr0JYAEvBRmCOgk4a
         LEbSUG+G52HS87/QGx5B6RKG5gyMu/fMqRUFn05WoP9uUX42FJ6A/aaQRe4XNzInanmt
         w2KjE+kDe2b6WQ2CBIJcAT8Lpdjm5tNk8RFUUbi9c5ikBZF3KuH7omkA2HCg2dND+UiP
         krO19nFY8IsiFWy2neSoZRuZEA05mND2fTtjbSFRnd3O7NubgMpuF/k1GK665rzbAI9L
         Ercg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pT4ZjpeVT57Af3KVzsGaTofnC+IwD0Maex8TCGO8hyo=;
        b=GaNE2R2MH9vuliYPCrmVHSVG4ifw1b8byrBb5k/IodDCvRU04W5YGxFnqLdYlsTg5L
         YD3vzkbUjwb6FD8iev9+YeEDHY8sF/wX1qS36NEgZoXzm/mVmnJpHKv3EynMb9jatJjt
         U5MEByFZkL9UNKAYvTe6PuydeRBnt1RH4ABN5S2CIhzZB/3rUa1z9p0ra2ucjaJzSYXl
         yWSi7YH+1i1NTBVOXGQOMFWtfteI0O29Oqjg64HHP6VvLiy/rDmLGAhQAK/r51vl4S5E
         iKdevL8cf1AgvWs25RnrR7KE6+Wdz0e70Sz1WdO+s0Uc48X7jxUyRYBwgLJZCcEfG6z2
         J7Lg==
X-Gm-Message-State: ACgBeo3F/CsRcVbMkuNtgd8qkBrVDoOCasTT9+DRt73WvhmRkycvSdVz
        5YUkBoaSyMjAp/itpx6mHRGP/9/IsIZwBs1DEQGWjg==
X-Google-Smtp-Source: AA6agR4jb4oPdZuWpJ18Ff20EJiIYbWbJAxVweJpKhEx7utcxPr9GB+oI/DobuMD7ADoUTedprqJ3G/0+548LMEz0Ic=
X-Received: by 2002:a05:6808:1b20:b0:33a:b9ab:30d8 with SMTP id
 bx32-20020a0568081b2000b0033ab9ab30d8mr184586oib.8.1659459378103; Tue, 02 Aug
 2022 09:56:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210630135942.29730-1-kabel@kernel.org> <20210630225601.6372-1-kabel@kernel.org>
 <20210702163035.nmb5pniwpqtmaz4b@pali> <20210708143451.4htvdop4zvjufrq6@pali>
 <20210715193321.z3vswz6x4rzvw2fd@pali> <20210808193026.xuyaufi5wqnrcakd@pali>
 <20220801123616.uol4wrs6trttumsg@pali> <BN9PR18MB4251768A59D38A44C264E1FEDB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801141254.ojljy2lewgrkga3f@pali> <BN9PR18MB42514ADBD547CADD93BD7646DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801175645.bnknpfg26acbat7c@pali> <BN9PR18MB42518C761E574D862D30CDA7DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <CA+HBbNEHRhU4HOK-NGGLxak0UUfwjZvtkuLtzCk=fvSaS=MMEA@mail.gmail.com> <BN9PR18MB4251336FB8E017605FE4D088DB9D9@BN9PR18MB4251.namprd18.prod.outlook.com>
In-Reply-To: <BN9PR18MB4251336FB8E017605FE4D088DB9D9@BN9PR18MB4251.namprd18.prod.outlook.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 2 Aug 2022 18:56:07 +0200
Message-ID: <CA+HBbNHp9duBYT7JGa14rn_OKpQFLQikFrZ5ktD2sAKsxGM8TQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2
 GHz variant
To:     Elad Nachman <enachman@marvell.com>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Wojciech Bartczak <wbartczak@marvell.com>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Anders Trier Olesen <anders.trier.olesen@gmail.com>,
        Philip Soares <philips@netisense.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nnet <nnet@fastmail.fm>,
        =?UTF-8?Q?G=C3=A9rald_Kerma?= <gandalf@gk2.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 2, 2022 at 6:52 PM Elad Nachman <enachman@marvell.com> wrote:
>
> Hi,
>
> Unless the logs are misleading, then I see here:
>
> cpu cpu0: _set_opp: switching OPP: Freq 200000000 -> 1200000000 Hz, Level=
 0 -> 0, Bw 0 -> 0
>
> Which violates the errata.
> If there is an interim step in between, I think it should be printed out =
in the debug so we can clearly understand what is the interim frequency set=
ting between 200 and 1200 MHz.

This is printed directly by the _set_opp from the cpufreq core, so it
should be accurate.
Pali, am I doing this correctly or I need to print from the A3K
cpufreq or clk drivers?

Regards,
Robert
>
> Elad.
>
> -----Original Message-----
> From: Robert Marko <robert.marko@sartura.hr>
> Sent: Tuesday, August 2, 2022 7:42 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Pali Roh=C3=A1r <pali@kernel.org>; Wojciech Bartczak <wbartczak@marve=
ll.com>; Marek Beh=C3=BAn <kabel@kernel.org>; Viresh Kumar <viresh.kumar@li=
naro.org>; Gregory CLEMENT <gregory.clement@bootlin.com>; Tomasz Maciej Now=
ak <tmn505@gmail.com>; Anders Trier Olesen <anders.trier.olesen@gmail.com>;=
 Philip Soares <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian=
 Hesselbarth <sebastian.hesselbarth@gmail.com>; linux-arm-kernel@lists.infr=
adead.org; nnet <nnet@fastmail.fm>; G=C3=A9rald Kerma <gandalf@gk2.net>
> Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq fo=
r 1.2 GHz variant
>
> On Mon, Aug 1, 2022 at 8:50 PM Elad Nachman <enachman@marvell.com> wrote:
> >
> > Hi Pali,
> >
> > Could you please provide the crash dump / call trace?
> >
> > Also, if you can please annotate with printk the exact voltage/frequenc=
y changes taken by the driver, up to the point of the crash?
> >
> > This will help understand the sequence of events leading to the crash.
> >
> > Thanks,
> >
> > Elad.
>
>
> Hi Elad,
> Here are 2 bootlogs, but I dont think they are of any use as the traces a=
re rather random and they are always different, like a real voltage issue:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gist.github.com_ro=
bimarko_113216f566ccf159dfd33933889da042&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyPaz7x=
tfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3Du39n7XPBdQVaoaviM32=
QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=3DjvmR3Myk443DelvNZv1Okhmpq=
nMp9Y8mvzzYz2g13rM&e=3D
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gist.github.com_ro=
bimarko_990d757870d44a3c5acdfeb957547705&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyPaz7x=
tfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3Du39n7XPBdQVaoaviM32=
QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=3DXrMFeJpEGO5A4rIKjkHLNc4MH=
zPGOBKeOktDWCbQMAc&e=3D
>
> Here is a bootleg with the frequency changes, OPP points that are set by =
the CPUFreq driver are also here:
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gist.github.com_ro=
bimarko_1a81b0c6e93735b75ff4461d405c8033&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyPaz7x=
tfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3Du39n7XPBdQVaoaviM32=
QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=3D02ljqhQAdZki-JwDYNPKaStmz=
SkhuitBRP6R17iOZqA&e=3D
>
> I am still digging to print the voltage changes as _set_opp_voltage is no=
t being used.
>
> Regards,
> Robert
> >
> >
> > ________________________________
> > =D7=9E=D7=90=D7=AA: Pali Roh=C3=A1r <pali@kernel.org>
> > =E2=80=8F=E2=80=8F=D7=A0=D7=A9=D7=9C=D7=97: =D7=99=D7=95=D7=9D =D7=A9=
=D7=A0=D7=99 01 =D7=90=D7=95=D7=92=D7=95=D7=A1=D7=98 2022 20:56
> > =E2=80=8F=E2=80=8F=D7=90=D7=9C: Elad Nachman <enachman@marvell.com>
> > =D7=A2=D7=95=D7=AA=D7=A7: Wojciech Bartczak <wbartczak@marvell.com>; Ma=
rek Beh=C3=BAn
> > <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gregory
> > CLEMENT <gregory.clement@bootlin.com>; Robert Marko
> > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>;
> > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares
> > <philips@netisense.com>; linux-pm@vger.kernel.org
> > <linux-pm@vger.kernel.org>; Sebastian Hesselbarth
> > <sebastian.hesselbarth@gmail.com>;
> > linux-arm-kernel@lists.infradead.org
> > <linux-arm-kernel@lists.infradead.org>; nnet <nnet@fastmail.fm>;
> > G=C3=A9rald Kerma <gandalf@gk2.net>
> > =E2=80=8F=E2=80=8F=D7=A0=D7=95=D7=A9=D7=90: Re: [EXT] Re: [PATCH v2] cp=
ufreq: armada-37xx: forbid cpufreq
> > for 1.2 GHz variant
> >
> > Hello Elad!
> >
> > Robert (in CC) tested this proposed change. But increasing delay to
> > 100ms does not help. CPU still crashes early during boot.
> >
> > On Monday 01 August 2022 14:15:27 Elad Nachman wrote:
> > > Hi,
> > >
> > > As first step, please try to increase the delay to 100ms, see if it h=
elps.
> > >
> > > Elad.
> > >
> > > -----Original Message-----
> > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > Sent: Monday, August 1, 2022 5:13 PM
> > > To: Elad Nachman <enachman@marvell.com>
> > > Cc: Wojciech Bartczak <wbartczak@marvell.com>; Marek Beh=C3=BAn
> > > <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gregory
> > > CLEMENT <gregory.clement@bootlin.com>; Robert Marko
> > > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>;
> > > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares
> > > <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian
> > > Hesselbarth <sebastian.hesselbarth@gmail.com>;
> > > linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> > > Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid
> > > cpufreq for 1.2 GHz variant
> > >
> > > Hello Elad and thank you for response!
> > >
> > > This errata is already implemented in the kernel for a longer time by=
 Gregory's commit:
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org=
_
> > > pub_scm_linux_kernel_git_stable_linux.git_commit_-3Fid-3D61c40f35f5c
> > > d6f67ccbd7319a1722eb78c815989&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=
=3DeT
> > > eNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3D-E-AwB9STVx8xgapaCNSpDJ=
I
> > > PPnkrzrWkZX0uFz2bfNGFnckZelT_XaovUUPrNIg&s=3D4EUcdDWB_gqnEV8nREQi9E_i=
y
> > > m5bjoM6l5zLrbh_GVs&e=3D
> > >
> > > There is also 20ms delay after L2/L3 to L1 state switch.
> > >
> > > Any idea what could be wrong here? Or is something more than above co=
mmit needed to correctly implement that errata?
> > >
> > > On Monday 01 August 2022 14:01:07 Elad Nachman wrote:
> > > > Hi Pali,
> > > >
> > > > There is an errata for that.
> > > >
> > > > "
> > > > Switching from L2/L3 state (200/300 MHz) to L0 state (1200 MHz)
> > > > requires sudden changes of VDD supply, and it requires time to
> > > > stabilize the VDD supply. The solution is to use gradual switching =
from L2/L3 to L1 and then L1 to L0 state.
> > > > "
> > > >
> > > > I would also add additional delay for the VDD supply stabilization.
> > > >
> > > > FYI,
> > > >
> > > > Elad.
> > > >
> > > > -----Original Message-----
> > > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > > Sent: Monday, August 1, 2022 3:36 PM
> > > > To: Elad Nachman <enachman@marvell.com>; Wojciech Bartczak
> > > > <wbartczak@marvell.com>
> > > > Cc: Marek Beh=C3=BAn <kabel@kernel.org>; Viresh Kumar
> > > > <viresh.kumar@linaro.org>; Gregory CLEMENT
> > > > <gregory.clement@bootlin.com>; Robert Marko
> > > > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>;
> > > > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares
> > > > <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian
> > > > Hesselbarth <sebastian.hesselbarth@gmail.com>;
> > > > linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> > > > Subject: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq
> > > > for
> > > > 1.2 GHz variant
> > > >
> > > > External Email
> > > >
> > > > ------------------------------------------------------------------
> > > > ----
> > > > + Elad and Wojciech from Marvell
> > > >
> > > > Could you please look at this issue and/or forward it to relevant M=
arvell team?
> > > >
> > > > Maintainer Viresh already wrote that we cannot hang forever for Mar=
vell and patch which disables support for 1.2 GHz was merged:
> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.=
o
> > > > rg_l
> > > > inux-2Dpm_20210809040224.j2rvopmmqda3utc5-40vireshk-2Di7_&d=3DDwIDa=
Q
> > > > &c=3Dn
> > > > KjWec2b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFr=
w
> > > > Q&m=3D
> > > > 5nMMKyKOOM3XdMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&s
> > > > =3DcXi CZByknfz1rOIgJl4fJHl1KLLRq2shHul2-VPpYP0&e=3D
> > > >
> > > > On Sunday 08 August 2021 21:30:26 Pali Roh=C3=A1r wrote:
> > > > > Gentle reminder. This is really serious issue. Could you please l=
ook at it?
> > > > >
> > > > > Adding more MarvellEmbeddedProcessors people to the loop: Evan,
> > > > > Benjamin an Igal
> > > > >
> > > > > On Thursday 15 July 2021 21:33:21 Pali Roh=C3=A1r wrote:
> > > > > > Ping! Gentle reminder for Marvell people.
> > > > > >
> > > > > > On Thursday 08 July 2021 16:34:51 Pali Roh=C3=A1r wrote:
> > > > > > > Konstantin, Nadav, Ken, Victor, Jason: This issue is pretty
> > > > > > > serious, CPU on 1.2GHz A3720 is crashing. Could you please lo=
ok at it?
> > > > > > >
> > > > > > > On Friday 02 July 2021 18:30:35 Pali Roh=C3=A1r wrote:
> > > > > > > > +Jason from GlobalScale as this issue affects GlobalScale E=
spressobin Ultra and V7 1.2 GHz boards.
> > > > > > > >
> > > > > > > > On Thursday 01 July 2021 00:56:01 Marek Beh=C3=BAn wrote:
> > > > > > > > > The 1.2 GHz variant of the Armada 3720 SOC is unstable
> > > > > > > > > with
> > > > > > > > > DVFS: when the SOC boots, the WTMI firmware sets clocks
> > > > > > > > > and AVS values that work correctly with 1.2 GHz CPU
> > > > > > > > > frequency, but random crashes occur once cpufreq driver s=
tarts scaling.
> > > > > > > > >
> > > > > > > > > We do not know currently what is the reason:
> > > > > > > > > - it may be that the voltage value for L0 for 1.2 GHz var=
iant provided
> > > > > > > > >   by the vendor in the OTP is simply incorrect when
> > > > > > > > > scaling is used,
> > > > > > > > > - it may be that some delay is needed somewhere,
> > > > > > > > > - it may be something else.
> > > > > > > > >
> > > > > > > > > The most sane solution now seems to be to simply forbid
> > > > > > > > > the cpufreq driver on 1.2 GHz variant.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > > > > > > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for
> > > > > > > > > Armada
> > > > > > > > > 37xx")
> > > > > > > > > ---
> > > > > > > > > If someone from Marvell could look into this, it would
> > > > > > > > > be great since basically 1.2 GHz variant cannot scale,
> > > > > > > > > which is a feature that was claimed to be supported by th=
e SOC.
> > > > > > > > >
> > > > > > > > > Ken Ma / Victor Gu, you have worked on commit
> > > > > > > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.
> > > > > > > > > co
> > > > > > > > > m_MarvellEmbeddedProcessors_linux-2Dmarvell_commit_d6719
> > > > > > > > > fdc2
> > > > > > > > > b3
> > > > > > > > > cac58064f41b531f86993c919aa9a&d=3DDwIDaQ&c=3DnKjWec2b6R0m=
OyP
> > > > > > > > > az7x
> > > > > > > > > tf
> > > > > > > > > Q&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3D5nM=
MKy
> > > > > > > > > KOOM
> > > > > > > > > 3X
> > > > > > > > > dMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&s=3D=
b
> > > > > > > > > 9cDK em t70OiTJF6KXj0ySzbxpsB_nuteXJE87via80&e=3D
> > > > > > > > > in linux-marvell.
> > > > > > > > > Your patch takes away the 1202 mV constant for 1.2 GHz
> > > > > > > > > base CPU frequency and instead adds code that computes
> > > > > > > > > the voltages from the voltage found in L0 AVS register (w=
hich is filled in by WTMI firmware).
> > > > > > > > >
> > > > > > > > > Do you know why the code does not work correctly for
> > > > > > > > > some
> > > > > > > > > 1.2 GHz boards? Do we need to force the L0 voltage to
> > > > > > > > > 1202 mV if it is lower, or something?
> > > > > > > > > ---
> > > > > > > > >  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
> > > > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > index 3fc98a3ffd91..c10fc33b29b1 100644
> > > > > > > > > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > @@ -104,7 +104,11 @@ struct armada_37xx_dvfs {  };
> > > > > > > > >
> > > > > > > > >  static struct armada_37xx_dvfs armada_37xx_dvfs[] =3D {
> > > > > > > > > - {.cpu_freq_max =3D 1200*1000*1000, .divider =3D {1, 2, =
4,
> > > > > > > > > 6} },
> > > > > > > > > + /*
> > > > > > > > > +  * The cpufreq scaling for 1.2 GHz variant of the SOC
> > > > > > > > > +is currently
> > > > > > > > > +  * unstable because we do not know how to configure it =
properly.
> > > > > > > > > +  */
> > > > > > > > > + /* {.cpu_freq_max =3D 1200*1000*1000, .divider =3D {1, =
2,
> > > > > > > > > +4, 6} }, */
> > > > > > > > >    {.cpu_freq_max =3D 1000*1000*1000, .divider =3D {1, 2,=
 4, 5} },
> > > > > > > > >    {.cpu_freq_max =3D 800*1000*1000,  .divider =3D {1, 2,=
 3, 4} },
> > > > > > > > >    {.cpu_freq_max =3D 600*1000*1000,  .divider =3D {2, 4,=
 5,
> > > > > > > > > 6} },
> > > > > > > > > --
> > > > > > > > > 2.31.1
> > > > > > > > >
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
> Web: https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.sartura.hr=
&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4=
lq9qhdlFrwQ&m=3Du39n7XPBdQVaoaviM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxS=
KLz-H&s=3D_aBokTETNVzTrHqewupr4PeLusBNf7LGrTmjI2hppFk&e=3D



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
