Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B852C58806D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Aug 2022 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiHBQm1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Aug 2022 12:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238247AbiHBQm0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2022 12:42:26 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D7BE1D
        for <linux-pm@vger.kernel.org>; Tue,  2 Aug 2022 09:42:24 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id c185so17124553oia.7
        for <linux-pm@vger.kernel.org>; Tue, 02 Aug 2022 09:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XES7wOqlXUr/qAejOlLvtCN7ks5gH2R5PvCE/JidLOk=;
        b=4190d3+JrkiXhDd+sEF76kgxj6+rjjafOclUfGhVQ6bOozxT9Wn4y66Vb/qVrbpLpT
         QY6K/IWx8s9qTFEFYQWnUGQbI4OTIczlUW71FgSpQvhkpyU2VUTMGiBS0SCvdlPAySSP
         J7ot53zo0npr67bdtHTGR2gtbYbwgL6hfeskiS2wp9nuD8UWMx81wjhdcgT/VYFVFoZL
         EaMOjo2KntIH1TtxFFdwR9GyoyLOESzTyS7rK5HnWUBJQXT2hpQPzM1E4M0XakUwldhB
         I+lb3e5yNobtOQ+Tqutwd5QkzB70jrT7rSrZDpEMQfy18BiWraO+oRwvvwj0vJQZnHj0
         hOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XES7wOqlXUr/qAejOlLvtCN7ks5gH2R5PvCE/JidLOk=;
        b=NzfqMlM9j7I8cWFMq12LPtJ+SYzw9ckeBIkdwmWzAeeZSW9wbsK2rjg4SqPrGguQ3M
         LY5TGYcKfebN0ThQSaRmZR1X6cXXMRjoo3dNCDXVWOe1bhZWDGAeeXH3dePs/AYQgABJ
         pNEk0J20jIXT0lu9ftHXvTAsG7tYim3agITCRyx0pkEI1VjGRxBiOZT8Cx+UQmnol3Vb
         Ud8u2jsrNsx50Rdk4z34lOPyBHdvjQ3iUQmj4jiyxpS86Qn6CdO/OLdg0eZS66ADfK8T
         gjFtfip+sN+KcByFD869ioZGplEyMA3pdIatv3Y+FSNFoIUhso+jm88J9F2mWDfIMUa2
         a4hw==
X-Gm-Message-State: ACgBeo1NEr7A9gZGz1U/GtsRXPfXngJ0qUVRwVZYhOKpW1eWLOaE54Nl
        v+mZz5dyNGuDC37wleq56lgKuIQ+a2Wr+OZapg+xrw==
X-Google-Smtp-Source: AA6agR4pbZzxkfXf2vgKt5XgxIFfJ96rDqgrFxG9oPGYy6ZZkYcmom/pVDu6PVLSc9rn8xz3Lwm1V5HA4C/B+oET/Yc=
X-Received: by 2002:a05:6808:1b20:b0:33a:b9ab:30d8 with SMTP id
 bx32-20020a0568081b2000b0033ab9ab30d8mr163535oib.8.1659458543668; Tue, 02 Aug
 2022 09:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210630135942.29730-1-kabel@kernel.org> <20210630225601.6372-1-kabel@kernel.org>
 <20210702163035.nmb5pniwpqtmaz4b@pali> <20210708143451.4htvdop4zvjufrq6@pali>
 <20210715193321.z3vswz6x4rzvw2fd@pali> <20210808193026.xuyaufi5wqnrcakd@pali>
 <20220801123616.uol4wrs6trttumsg@pali> <BN9PR18MB4251768A59D38A44C264E1FEDB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801141254.ojljy2lewgrkga3f@pali> <BN9PR18MB42514ADBD547CADD93BD7646DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801175645.bnknpfg26acbat7c@pali> <BN9PR18MB42518C761E574D862D30CDA7DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
In-Reply-To: <BN9PR18MB42518C761E574D862D30CDA7DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Tue, 2 Aug 2022 18:42:12 +0200
Message-ID: <CA+HBbNEHRhU4HOK-NGGLxak0UUfwjZvtkuLtzCk=fvSaS=MMEA@mail.gmail.com>
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

On Mon, Aug 1, 2022 at 8:50 PM Elad Nachman <enachman@marvell.com> wrote:
>
> Hi Pali,
>
> Could you please provide the crash dump / call trace?
>
> Also, if you can please annotate with printk the exact voltage/frequency =
changes taken by the driver, up to the point of the crash?
>
> This will help understand the sequence of events leading to the crash.
>
> Thanks,
>
> Elad.


Hi Elad,
Here are 2 bootlogs, but I dont think they are of any use as the
traces are rather random
and they are always different, like a real voltage issue:
https://gist.github.com/robimarko/113216f566ccf159dfd33933889da042
https://gist.github.com/robimarko/990d757870d44a3c5acdfeb957547705

Here is a bootleg with the frequency changes, OPP points that are set
by the CPUFreq driver are also here:
https://gist.github.com/robimarko/1a81b0c6e93735b75ff4461d405c8033

I am still digging to print the voltage changes as _set_opp_voltage is
not being used.

Regards,
Robert
>
>
> ________________________________
> =D7=9E=D7=90=D7=AA: Pali Roh=C3=A1r <pali@kernel.org>
> =E2=80=8F=E2=80=8F=D7=A0=D7=A9=D7=9C=D7=97: =D7=99=D7=95=D7=9D =D7=A9=D7=
=A0=D7=99 01 =D7=90=D7=95=D7=92=D7=95=D7=A1=D7=98 2022 20:56
> =E2=80=8F=E2=80=8F=D7=90=D7=9C: Elad Nachman <enachman@marvell.com>
> =D7=A2=D7=95=D7=AA=D7=A7: Wojciech Bartczak <wbartczak@marvell.com>; Mare=
k Beh=C3=BAn <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gr=
egory CLEMENT <gregory.clement@bootlin.com>; Robert Marko <robert.marko@sar=
tura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>; Anders Trier Olesen <ande=
rs.trier.olesen@gmail.com>; Philip Soares <philips@netisense.com>; linux-pm=
@vger.kernel.org <linux-pm@vger.kernel.org>; Sebastian Hesselbarth <sebasti=
an.hesselbarth@gmail.com>; linux-arm-kernel@lists.infradead.org <linux-arm-=
kernel@lists.infradead.org>; nnet <nnet@fastmail.fm>; G=C3=A9rald Kerma <ga=
ndalf@gk2.net>
> =E2=80=8F=E2=80=8F=D7=A0=D7=95=D7=A9=D7=90: Re: [EXT] Re: [PATCH v2] cpuf=
req: armada-37xx: forbid cpufreq for 1.2 GHz variant
>
> Hello Elad!
>
> Robert (in CC) tested this proposed change. But increasing delay to
> 100ms does not help. CPU still crashes early during boot.
>
> On Monday 01 August 2022 14:15:27 Elad Nachman wrote:
> > Hi,
> >
> > As first step, please try to increase the delay to 100ms, see if it hel=
ps.
> >
> > Elad.
> >
> > -----Original Message-----
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> > Sent: Monday, August 1, 2022 5:13 PM
> > To: Elad Nachman <enachman@marvell.com>
> > Cc: Wojciech Bartczak <wbartczak@marvell.com>; Marek Beh=C3=BAn <kabel@=
kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gregory CLEMENT <grego=
ry.clement@bootlin.com>; Robert Marko <robert.marko@sartura.hr>; Tomasz Mac=
iej Nowak <tmn505@gmail.com>; Anders Trier Olesen <anders.trier.olesen@gmai=
l.com>; Philip Soares <philips@netisense.com>; linux-pm@vger.kernel.org; Se=
bastian Hesselbarth <sebastian.hesselbarth@gmail.com>; linux-arm-kernel@lis=
ts.infradead.org; nnet <nnet@fastmail.fm>
> > Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq =
for 1.2 GHz variant
> >
> > Hello Elad and thank you for response!
> >
> > This errata is already implemented in the kernel for a longer time by G=
regory's commit:
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_stable_linux.git_commit_-3Fid-3D61c40f35f5cd6f67ccb=
d7319a1722eb78c815989&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-T=
xXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3D-E-AwB9STVx8xgapaCNSpDJIPPnkrzrWkZX0uF=
z2bfNGFnckZelT_XaovUUPrNIg&s=3D4EUcdDWB_gqnEV8nREQi9E_iym5bjoM6l5zLrbh_GVs&=
e=3D
> >
> > There is also 20ms delay after L2/L3 to L1 state switch.
> >
> > Any idea what could be wrong here? Or is something more than above comm=
it needed to correctly implement that errata?
> >
> > On Monday 01 August 2022 14:01:07 Elad Nachman wrote:
> > > Hi Pali,
> > >
> > > There is an errata for that.
> > >
> > > "
> > > Switching from L2/L3 state (200/300 MHz) to L0 state (1200 MHz)
> > > requires sudden changes of VDD supply, and it requires time to
> > > stabilize the VDD supply. The solution is to use gradual switching fr=
om L2/L3 to L1 and then L1 to L0 state.
> > > "
> > >
> > > I would also add additional delay for the VDD supply stabilization.
> > >
> > > FYI,
> > >
> > > Elad.
> > >
> > > -----Original Message-----
> > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > Sent: Monday, August 1, 2022 3:36 PM
> > > To: Elad Nachman <enachman@marvell.com>; Wojciech Bartczak
> > > <wbartczak@marvell.com>
> > > Cc: Marek Beh=C3=BAn <kabel@kernel.org>; Viresh Kumar
> > > <viresh.kumar@linaro.org>; Gregory CLEMENT
> > > <gregory.clement@bootlin.com>; Robert Marko <robert.marko@sartura.hr>=
;
> > > Tomasz Maciej Nowak <tmn505@gmail.com>; Anders Trier Olesen
> > > <anders.trier.olesen@gmail.com>; Philip Soares
> > > <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian
> > > Hesselbarth <sebastian.hesselbarth@gmail.com>;
> > > linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> > > Subject: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq fo=
r
> > > 1.2 GHz variant
> > >
> > > External Email
> > >
> > > ---------------------------------------------------------------------=
-
> > > + Elad and Wojciech from Marvell
> > >
> > > Could you please look at this issue and/or forward it to relevant Mar=
vell team?
> > >
> > > Maintainer Viresh already wrote that we cannot hang forever for Marve=
ll and patch which disables support for 1.2 GHz was merged:
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_l
> > > inux-2Dpm_20210809040224.j2rvopmmqda3utc5-40vireshk-2Di7_&d=3DDwIDaQ&=
c=3Dn
> > > KjWec2b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ=
&m=3D
> > > 5nMMKyKOOM3XdMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&s=3D=
cXi
> > > CZByknfz1rOIgJl4fJHl1KLLRq2shHul2-VPpYP0&e=3D
> > >
> > > On Sunday 08 August 2021 21:30:26 Pali Roh=C3=A1r wrote:
> > > > Gentle reminder. This is really serious issue. Could you please loo=
k at it?
> > > >
> > > > Adding more MarvellEmbeddedProcessors people to the loop: Evan,
> > > > Benjamin an Igal
> > > >
> > > > On Thursday 15 July 2021 21:33:21 Pali Roh=C3=A1r wrote:
> > > > > Ping! Gentle reminder for Marvell people.
> > > > >
> > > > > On Thursday 08 July 2021 16:34:51 Pali Roh=C3=A1r wrote:
> > > > > > Konstantin, Nadav, Ken, Victor, Jason: This issue is pretty
> > > > > > serious, CPU on 1.2GHz A3720 is crashing. Could you please look=
 at it?
> > > > > >
> > > > > > On Friday 02 July 2021 18:30:35 Pali Roh=C3=A1r wrote:
> > > > > > > +Jason from GlobalScale as this issue affects GlobalScale Esp=
ressobin Ultra and V7 1.2 GHz boards.
> > > > > > >
> > > > > > > On Thursday 01 July 2021 00:56:01 Marek Beh=C3=BAn wrote:
> > > > > > > > The 1.2 GHz variant of the Armada 3720 SOC is unstable with
> > > > > > > > DVFS: when the SOC boots, the WTMI firmware sets clocks and
> > > > > > > > AVS values that work correctly with 1.2 GHz CPU frequency,
> > > > > > > > but random crashes occur once cpufreq driver starts scaling=
.
> > > > > > > >
> > > > > > > > We do not know currently what is the reason:
> > > > > > > > - it may be that the voltage value for L0 for 1.2 GHz varia=
nt provided
> > > > > > > >   by the vendor in the OTP is simply incorrect when scaling
> > > > > > > > is used,
> > > > > > > > - it may be that some delay is needed somewhere,
> > > > > > > > - it may be something else.
> > > > > > > >
> > > > > > > > The most sane solution now seems to be to simply forbid the
> > > > > > > > cpufreq driver on 1.2 GHz variant.
> > > > > > > >
> > > > > > > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > > > > > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada
> > > > > > > > 37xx")
> > > > > > > > ---
> > > > > > > > If someone from Marvell could look into this, it would be
> > > > > > > > great since basically 1.2 GHz variant cannot scale, which i=
s
> > > > > > > > a feature that was claimed to be supported by the SOC.
> > > > > > > >
> > > > > > > > Ken Ma / Victor Gu, you have worked on commit
> > > > > > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gith=
ub.
> > > > > > > > co
> > > > > > > > m_MarvellEmbeddedProcessors_linux-2Dmarvell_commit_d6719fdc=
2
> > > > > > > > b3
> > > > > > > > cac58064f41b531f86993c919aa9a&d=3DDwIDaQ&c=3DnKjWec2b6R0mOy=
Paz7x
> > > > > > > > tf
> > > > > > > > Q&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3D5nMMK=
yKOOM
> > > > > > > > 3X
> > > > > > > > dMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&s=3Db9=
cDK
> > > > > > > > em t70OiTJF6KXj0ySzbxpsB_nuteXJE87via80&e=3D
> > > > > > > > in linux-marvell.
> > > > > > > > Your patch takes away the 1202 mV constant for 1.2 GHz base
> > > > > > > > CPU frequency and instead adds code that computes the
> > > > > > > > voltages from the voltage found in L0 AVS register (which i=
s filled in by WTMI firmware).
> > > > > > > >
> > > > > > > > Do you know why the code does not work correctly for some
> > > > > > > > 1.2 GHz boards? Do we need to force the L0 voltage to 1202
> > > > > > > > mV if it is lower, or something?
> > > > > > > > ---
> > > > > > > >  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
> > > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > index 3fc98a3ffd91..c10fc33b29b1 100644
> > > > > > > > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > @@ -104,7 +104,11 @@ struct armada_37xx_dvfs {  };
> > > > > > > >
> > > > > > > >  static struct armada_37xx_dvfs armada_37xx_dvfs[] =3D {
> > > > > > > > - {.cpu_freq_max =3D 1200*1000*1000, .divider =3D {1, 2, 4,=
 6} },
> > > > > > > > + /*
> > > > > > > > +  * The cpufreq scaling for 1.2 GHz variant of the SOC is =
currently
> > > > > > > > +  * unstable because we do not know how to configure it pr=
operly.
> > > > > > > > +  */
> > > > > > > > + /* {.cpu_freq_max =3D 1200*1000*1000, .divider =3D {1, 2,=
 4,
> > > > > > > > +6} }, */
> > > > > > > >    {.cpu_freq_max =3D 1000*1000*1000, .divider =3D {1, 2, 4=
, 5} },
> > > > > > > >    {.cpu_freq_max =3D 800*1000*1000,  .divider =3D {1, 2, 3=
, 4} },
> > > > > > > >    {.cpu_freq_max =3D 600*1000*1000,  .divider =3D {2, 4, 5=
, 6}
> > > > > > > > },
> > > > > > > > --
> > > > > > > > 2.31.1
> > > > > > > >



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
