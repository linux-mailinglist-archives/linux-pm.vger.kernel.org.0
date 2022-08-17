Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3607596C34
	for <lists+linux-pm@lfdr.de>; Wed, 17 Aug 2022 11:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbiHQJkr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Aug 2022 05:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235432AbiHQJkq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Aug 2022 05:40:46 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5536CD1B
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 02:40:44 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10ea9ef5838so14598775fac.3
        for <linux-pm@vger.kernel.org>; Wed, 17 Aug 2022 02:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=NCwPlV5qgORkPdAuxSFyisVsr5hWq+LfailWGFg1f4Q=;
        b=Z1ZOo8AN9rP9MnfVxFPFL4MiDCmtt+bt2mVH8mEY5TJmy5tNDbnXjJbvXVS0Yh/SsK
         SdpFFilixFckI13E374/ila+eaof+x/y286Fwve2WTxhzq3vOACbQq/X2xI2tn4KwkN9
         hFC/LAVmh2xvOvP2MVvCROjmiye9sbuuw0mulmCEpapx1OWOsCsjNqBWNixYDaiqjFzc
         GKKNLA/fWL0F1It95dOl4yGMQVthbSBzJmyuHmCUsqI2kBGcZVdam1otegT7BtQ6TRll
         qfwQSVhr5z64BUP8Q1yktWtinfGhqcvIcheghzjWOxvWvkwu1JEOIvn1ngkdPWM482W+
         4Prw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=NCwPlV5qgORkPdAuxSFyisVsr5hWq+LfailWGFg1f4Q=;
        b=FHO9YCrGOXMteiNzc0A4MlGl6abmbnzDrwExfpi2zB6RxtLqCfZYy/MK/MRhZs6vsp
         2X4FqBO9aXk5vsXIFt34wQzyhqMcPSYeD9Q/6n4qeb2sbYzGdbaI4NIRHIkhC5CKcnbl
         oXWvVdZiNJR9p75oL91HxDlSYAxe405dut6ZdQE4F/9cdyVVyMQD113qgn1+HLESUjZn
         ip9QYUBCSxEmdgieMcz33ygWPqC4VXlq8jWMAJRXsZBrjzU9oUrd1TW7Vz0WCAksBq35
         CNE0FHH1VrqoI0daNL/bvFLIDtuC4HUbLlqjGwxltTPNSUgc+3nRxa/UpZ0y9gBmUvoa
         BdhQ==
X-Gm-Message-State: ACgBeo17CMIsPkaxm7MGLBgzGW/0zfRa1MLfNSARhNHriTy6lTinb4/R
        c3n+IYgOrr9CkbTlid/TaEdXva5WMF1/8+AIfjbNsg==
X-Google-Smtp-Source: AA6agR4hS9Ij884Ou8O+c2D9oomshrcO+egicsLkozEt/GFPBUSBI45dbwjBYjZ+0s8DhZR8AG+zQdFp/JVkBfh2RwU=
X-Received: by 2002:a05:6870:3326:b0:10e:d664:d225 with SMTP id
 x38-20020a056870332600b0010ed664d225mr1306105oae.139.1660729243496; Wed, 17
 Aug 2022 02:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210808193026.xuyaufi5wqnrcakd@pali> <20220801123616.uol4wrs6trttumsg@pali>
 <BN9PR18MB4251768A59D38A44C264E1FEDB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801141254.ojljy2lewgrkga3f@pali> <BN9PR18MB42514ADBD547CADD93BD7646DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <20220801175645.bnknpfg26acbat7c@pali> <BN9PR18MB42518C761E574D862D30CDA7DB9A9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <CA+HBbNEHRhU4HOK-NGGLxak0UUfwjZvtkuLtzCk=fvSaS=MMEA@mail.gmail.com>
 <BN9PR18MB4251336FB8E017605FE4D088DB9D9@BN9PR18MB4251.namprd18.prod.outlook.com>
 <CA+HBbNHp9duBYT7JGa14rn_OKpQFLQikFrZ5ktD2sAKsxGM8TQ@mail.gmail.com> <20220802171736.n7jwtbssnwr5hojv@pali>
In-Reply-To: <20220802171736.n7jwtbssnwr5hojv@pali>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 17 Aug 2022 11:40:32 +0200
Message-ID: <CA+HBbNGKXu+TAT0i40MmACrmRuw_zB6PWSdRCn70B8h7qp6eLQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufreq for 1.2
 GHz variant
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Elad Nachman <enachman@marvell.com>,
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 2, 2022 at 7:17 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> On Tuesday 02 August 2022 18:56:07 Robert Marko wrote:
> > On Tue, Aug 2, 2022 at 6:52 PM Elad Nachman <enachman@marvell.com> wrot=
e:
> > >
> > > Hi,
> > >
> > > Unless the logs are misleading, then I see here:
> > >
> > > cpu cpu0: _set_opp: switching OPP: Freq 200000000 -> 1200000000 Hz, L=
evel 0 -> 0, Bw 0 -> 0
> > >
> > > Which violates the errata.
> > > If there is an interim step in between, I think it should be printed =
out in the debug so we can clearly understand what is the interim frequency=
 setting between 200 and 1200 MHz.
> >
> > This is printed directly by the _set_opp from the cpufreq core, so it
> > should be accurate.
> > Pali, am I doing this correctly or I need to print from the A3K
> > cpufreq or clk drivers?
>
> Hello! You need to print it from a3k clk driver. cpufreq core just ask
> driver to switch speed from 200000000 to 1200000000 and clk driver then
> change it with its own workaround function.
>
> The real change of Level is done at these places:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/dri=
vers/clk/mvebu/armada-37xx-periph.c?h=3Dv5.19#n548
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/dri=
vers/clk/mvebu/armada-37xx-periph.c?h=3Dv5.19#n592
>
> Check places where is done write operation to register
> ARMADA_37XX_NB_CPU_LOAD.

Ok, finally got time to try it.
I am now printing from the clk driver instead, hopefully in the right place=
s:
https://gist.github.com/robimarko/d297c81f70ef9620c830435bad8a6a8d

Trying to enlarge the wait to 100ms does not help.

Regards,
Robert
>
> > Regards,
> > Robert
> > >
> > > Elad.
> > >
> > > -----Original Message-----
> > > From: Robert Marko <robert.marko@sartura.hr>
> > > Sent: Tuesday, August 2, 2022 7:42 PM
> > > To: Elad Nachman <enachman@marvell.com>
> > > Cc: Pali Roh=C3=A1r <pali@kernel.org>; Wojciech Bartczak <wbartczak@m=
arvell.com>; Marek Beh=C3=BAn <kabel@kernel.org>; Viresh Kumar <viresh.kuma=
r@linaro.org>; Gregory CLEMENT <gregory.clement@bootlin.com>; Tomasz Maciej=
 Nowak <tmn505@gmail.com>; Anders Trier Olesen <anders.trier.olesen@gmail.c=
om>; Philip Soares <philips@netisense.com>; linux-pm@vger.kernel.org; Sebas=
tian Hesselbarth <sebastian.hesselbarth@gmail.com>; linux-arm-kernel@lists.=
infradead.org; nnet <nnet@fastmail.fm>; G=C3=A9rald Kerma <gandalf@gk2.net>
> > > Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpufre=
q for 1.2 GHz variant
> > >
> > > On Mon, Aug 1, 2022 at 8:50 PM Elad Nachman <enachman@marvell.com> wr=
ote:
> > > >
> > > > Hi Pali,
> > > >
> > > > Could you please provide the crash dump / call trace?
> > > >
> > > > Also, if you can please annotate with printk the exact voltage/freq=
uency changes taken by the driver, up to the point of the crash?
> > > >
> > > > This will help understand the sequence of events leading to the cra=
sh.
> > > >
> > > > Thanks,
> > > >
> > > > Elad.
> > >
> > >
> > > Hi Elad,
> > > Here are 2 bootlogs, but I dont think they are of any use as the trac=
es are rather random and they are always different, like a real voltage iss=
ue:
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gist.github.co=
m_robimarko_113216f566ccf159dfd33933889da042&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyP=
az7xtfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3Du39n7XPBdQVaoav=
iM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=3DjvmR3Myk443DelvNZv1Ok=
hmpqnMp9Y8mvzzYz2g13rM&e=3D
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gist.github.co=
m_robimarko_990d757870d44a3c5acdfeb957547705&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyP=
az7xtfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3Du39n7XPBdQVaoav=
iM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=3DXrMFeJpEGO5A4rIKjkHLN=
c4MHzPGOBKeOktDWCbQMAc&e=3D
> > >
> > > Here is a bootleg with the frequency changes, OPP points that are set=
 by the CPUFreq driver are also here:
> > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gist.github.co=
m_robimarko_1a81b0c6e93735b75ff4461d405c8033&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyP=
az7xtfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3Du39n7XPBdQVaoav=
iM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqEKfxSKLz-H&s=3D02ljqhQAdZki-JwDYNPKa=
StmzSkhuitBRP6R17iOZqA&e=3D
> > >
> > > I am still digging to print the voltage changes as _set_opp_voltage i=
s not being used.
> > >
> > > Regards,
> > > Robert
> > > >
> > > >
> > > > ________________________________
> > > > =D7=9E=D7=90=D7=AA: Pali Roh=C3=A1r <pali@kernel.org>
> > > > =E2=80=8F=E2=80=8F=D7=A0=D7=A9=D7=9C=D7=97: =D7=99=D7=95=D7=9D =D7=
=A9=D7=A0=D7=99 01 =D7=90=D7=95=D7=92=D7=95=D7=A1=D7=98 2022 20:56
> > > > =E2=80=8F=E2=80=8F=D7=90=D7=9C: Elad Nachman <enachman@marvell.com>
> > > > =D7=A2=D7=95=D7=AA=D7=A7: Wojciech Bartczak <wbartczak@marvell.com>=
; Marek Beh=C3=BAn
> > > > <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Gregory
> > > > CLEMENT <gregory.clement@bootlin.com>; Robert Marko
> > > > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>;
> > > > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soares
> > > > <philips@netisense.com>; linux-pm@vger.kernel.org
> > > > <linux-pm@vger.kernel.org>; Sebastian Hesselbarth
> > > > <sebastian.hesselbarth@gmail.com>;
> > > > linux-arm-kernel@lists.infradead.org
> > > > <linux-arm-kernel@lists.infradead.org>; nnet <nnet@fastmail.fm>;
> > > > G=C3=A9rald Kerma <gandalf@gk2.net>
> > > > =E2=80=8F=E2=80=8F=D7=A0=D7=95=D7=A9=D7=90: Re: [EXT] Re: [PATCH v2=
] cpufreq: armada-37xx: forbid cpufreq
> > > > for 1.2 GHz variant
> > > >
> > > > Hello Elad!
> > > >
> > > > Robert (in CC) tested this proposed change. But increasing delay to
> > > > 100ms does not help. CPU still crashes early during boot.
> > > >
> > > > On Monday 01 August 2022 14:15:27 Elad Nachman wrote:
> > > > > Hi,
> > > > >
> > > > > As first step, please try to increase the delay to 100ms, see if =
it helps.
> > > > >
> > > > > Elad.
> > > > >
> > > > > -----Original Message-----
> > > > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > Sent: Monday, August 1, 2022 5:13 PM
> > > > > To: Elad Nachman <enachman@marvell.com>
> > > > > Cc: Wojciech Bartczak <wbartczak@marvell.com>; Marek Beh=C3=BAn
> > > > > <kabel@kernel.org>; Viresh Kumar <viresh.kumar@linaro.org>; Grego=
ry
> > > > > CLEMENT <gregory.clement@bootlin.com>; Robert Marko
> > > > > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.com>=
;
> > > > > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soare=
s
> > > > > <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian
> > > > > Hesselbarth <sebastian.hesselbarth@gmail.com>;
> > > > > linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> > > > > Subject: Re: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid
> > > > > cpufreq for 1.2 GHz variant
> > > > >
> > > > > Hello Elad and thank you for response!
> > > > >
> > > > > This errata is already implemented in the kernel for a longer tim=
e by Gregory's commit:
> > > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel=
.org_
> > > > > pub_scm_linux_kernel_git_stable_linux.git_commit_-3Fid-3D61c40f35=
f5c
> > > > > d6f67ccbd7319a1722eb78c815989&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xt=
fQ&r=3DeT
> > > > > eNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3D-E-AwB9STVx8xgapaCN=
SpDJI
> > > > > PPnkrzrWkZX0uFz2bfNGFnckZelT_XaovUUPrNIg&s=3D4EUcdDWB_gqnEV8nREQi=
9E_iy
> > > > > m5bjoM6l5zLrbh_GVs&e=3D
> > > > >
> > > > > There is also 20ms delay after L2/L3 to L1 state switch.
> > > > >
> > > > > Any idea what could be wrong here? Or is something more than abov=
e commit needed to correctly implement that errata?
> > > > >
> > > > > On Monday 01 August 2022 14:01:07 Elad Nachman wrote:
> > > > > > Hi Pali,
> > > > > >
> > > > > > There is an errata for that.
> > > > > >
> > > > > > "
> > > > > > Switching from L2/L3 state (200/300 MHz) to L0 state (1200 MHz)
> > > > > > requires sudden changes of VDD supply, and it requires time to
> > > > > > stabilize the VDD supply. The solution is to use gradual switch=
ing from L2/L3 to L1 and then L1 to L0 state.
> > > > > > "
> > > > > >
> > > > > > I would also add additional delay for the VDD supply stabilizat=
ion.
> > > > > >
> > > > > > FYI,
> > > > > >
> > > > > > Elad.
> > > > > >
> > > > > > -----Original Message-----
> > > > > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > > > > > Sent: Monday, August 1, 2022 3:36 PM
> > > > > > To: Elad Nachman <enachman@marvell.com>; Wojciech Bartczak
> > > > > > <wbartczak@marvell.com>
> > > > > > Cc: Marek Beh=C3=BAn <kabel@kernel.org>; Viresh Kumar
> > > > > > <viresh.kumar@linaro.org>; Gregory CLEMENT
> > > > > > <gregory.clement@bootlin.com>; Robert Marko
> > > > > > <robert.marko@sartura.hr>; Tomasz Maciej Nowak <tmn505@gmail.co=
m>;
> > > > > > Anders Trier Olesen <anders.trier.olesen@gmail.com>; Philip Soa=
res
> > > > > > <philips@netisense.com>; linux-pm@vger.kernel.org; Sebastian
> > > > > > Hesselbarth <sebastian.hesselbarth@gmail.com>;
> > > > > > linux-arm-kernel@lists.infradead.org; nnet <nnet@fastmail.fm>
> > > > > > Subject: [EXT] Re: [PATCH v2] cpufreq: armada-37xx: forbid cpuf=
req
> > > > > > for
> > > > > > 1.2 GHz variant
> > > > > >
> > > > > > External Email
> > > > > >
> > > > > > ---------------------------------------------------------------=
---
> > > > > > ----
> > > > > > + Elad and Wojciech from Marvell
> > > > > >
> > > > > > Could you please look at this issue and/or forward it to releva=
nt Marvell team?
> > > > > >
> > > > > > Maintainer Viresh already wrote that we cannot hang forever for=
 Marvell and patch which disables support for 1.2 GHz was merged:
> > > > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.ker=
nel.o
> > > > > > rg_l
> > > > > > inux-2Dpm_20210809040224.j2rvopmmqda3utc5-40vireshk-2Di7_&d=3DD=
wIDaQ
> > > > > > &c=3Dn
> > > > > > KjWec2b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qh=
dlFrw
> > > > > > Q&m=3D
> > > > > > 5nMMKyKOOM3XdMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCL=
C&s
> > > > > > =3DcXi CZByknfz1rOIgJl4fJHl1KLLRq2shHul2-VPpYP0&e=3D
> > > > > >
> > > > > > On Sunday 08 August 2021 21:30:26 Pali Roh=C3=A1r wrote:
> > > > > > > Gentle reminder. This is really serious issue. Could you plea=
se look at it?
> > > > > > >
> > > > > > > Adding more MarvellEmbeddedProcessors people to the loop: Eva=
n,
> > > > > > > Benjamin an Igal
> > > > > > >
> > > > > > > On Thursday 15 July 2021 21:33:21 Pali Roh=C3=A1r wrote:
> > > > > > > > Ping! Gentle reminder for Marvell people.
> > > > > > > >
> > > > > > > > On Thursday 08 July 2021 16:34:51 Pali Roh=C3=A1r wrote:
> > > > > > > > > Konstantin, Nadav, Ken, Victor, Jason: This issue is pret=
ty
> > > > > > > > > serious, CPU on 1.2GHz A3720 is crashing. Could you pleas=
e look at it?
> > > > > > > > >
> > > > > > > > > On Friday 02 July 2021 18:30:35 Pali Roh=C3=A1r wrote:
> > > > > > > > > > +Jason from GlobalScale as this issue affects GlobalSca=
le Espressobin Ultra and V7 1.2 GHz boards.
> > > > > > > > > >
> > > > > > > > > > On Thursday 01 July 2021 00:56:01 Marek Beh=C3=BAn wrot=
e:
> > > > > > > > > > > The 1.2 GHz variant of the Armada 3720 SOC is unstabl=
e
> > > > > > > > > > > with
> > > > > > > > > > > DVFS: when the SOC boots, the WTMI firmware sets cloc=
ks
> > > > > > > > > > > and AVS values that work correctly with 1.2 GHz CPU
> > > > > > > > > > > frequency, but random crashes occur once cpufreq driv=
er starts scaling.
> > > > > > > > > > >
> > > > > > > > > > > We do not know currently what is the reason:
> > > > > > > > > > > - it may be that the voltage value for L0 for 1.2 GHz=
 variant provided
> > > > > > > > > > >   by the vendor in the OTP is simply incorrect when
> > > > > > > > > > > scaling is used,
> > > > > > > > > > > - it may be that some delay is needed somewhere,
> > > > > > > > > > > - it may be something else.
> > > > > > > > > > >
> > > > > > > > > > > The most sane solution now seems to be to simply forb=
id
> > > > > > > > > > > the cpufreq driver on 1.2 GHz variant.
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > > > > > > > > > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for
> > > > > > > > > > > Armada
> > > > > > > > > > > 37xx")
> > > > > > > > > > > ---
> > > > > > > > > > > If someone from Marvell could look into this, it woul=
d
> > > > > > > > > > > be great since basically 1.2 GHz variant cannot scale=
,
> > > > > > > > > > > which is a feature that was claimed to be supported b=
y the SOC.
> > > > > > > > > > >
> > > > > > > > > > > Ken Ma / Victor Gu, you have worked on commit
> > > > > > > > > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A=
__github.
> > > > > > > > > > > co
> > > > > > > > > > > m_MarvellEmbeddedProcessors_linux-2Dmarvell_commit_d6=
719
> > > > > > > > > > > fdc2
> > > > > > > > > > > b3
> > > > > > > > > > > cac58064f41b531f86993c919aa9a&d=3DDwIDaQ&c=3DnKjWec2b=
6R0mOyP
> > > > > > > > > > > az7x
> > > > > > > > > > > tf
> > > > > > > > > > > Q&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=
=3D5nMMKy
> > > > > > > > > > > KOOM
> > > > > > > > > > > 3X
> > > > > > > > > > > dMe_PerZRx8L7-D7MkWhCl7GxpXTPiotVf1TR4j8v3bpjQmRKCLC&=
s=3Db
> > > > > > > > > > > 9cDK em t70OiTJF6KXj0ySzbxpsB_nuteXJE87via80&e=3D
> > > > > > > > > > > in linux-marvell.
> > > > > > > > > > > Your patch takes away the 1202 mV constant for 1.2 GH=
z
> > > > > > > > > > > base CPU frequency and instead adds code that compute=
s
> > > > > > > > > > > the voltages from the voltage found in L0 AVS registe=
r (which is filled in by WTMI firmware).
> > > > > > > > > > >
> > > > > > > > > > > Do you know why the code does not work correctly for
> > > > > > > > > > > some
> > > > > > > > > > > 1.2 GHz boards? Do we need to force the L0 voltage to
> > > > > > > > > > > 1202 mV if it is lower, or something?
> > > > > > > > > > > ---
> > > > > > > > > > >  drivers/cpufreq/armada-37xx-cpufreq.c | 6 +++++-
> > > > > > > > > > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > > > b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > > > index 3fc98a3ffd91..c10fc33b29b1 100644
> > > > > > > > > > > --- a/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > > > +++ b/drivers/cpufreq/armada-37xx-cpufreq.c
> > > > > > > > > > > @@ -104,7 +104,11 @@ struct armada_37xx_dvfs {  };
> > > > > > > > > > >
> > > > > > > > > > >  static struct armada_37xx_dvfs armada_37xx_dvfs[] =
=3D {
> > > > > > > > > > > - {.cpu_freq_max =3D 1200*1000*1000, .divider =3D {1,=
 2, 4,
> > > > > > > > > > > 6} },
> > > > > > > > > > > + /*
> > > > > > > > > > > +  * The cpufreq scaling for 1.2 GHz variant of the S=
OC
> > > > > > > > > > > +is currently
> > > > > > > > > > > +  * unstable because we do not know how to configure=
 it properly.
> > > > > > > > > > > +  */
> > > > > > > > > > > + /* {.cpu_freq_max =3D 1200*1000*1000, .divider =3D =
{1, 2,
> > > > > > > > > > > +4, 6} }, */
> > > > > > > > > > >    {.cpu_freq_max =3D 1000*1000*1000, .divider =3D {1=
, 2, 4, 5} },
> > > > > > > > > > >    {.cpu_freq_max =3D 800*1000*1000,  .divider =3D {1=
, 2, 3, 4} },
> > > > > > > > > > >    {.cpu_freq_max =3D 600*1000*1000,  .divider =3D {2=
, 4, 5,
> > > > > > > > > > > 6} },
> > > > > > > > > > > --
> > > > > > > > > > > 2.31.1
> > > > > > > > > > >
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
> > > Web: https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__www.sartur=
a.hr&d=3DDwIFaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-TxXczjOcKPhANIFtlB=
9pP4lq9qhdlFrwQ&m=3Du39n7XPBdQVaoaviM32QcFaiO0KDs3BVzkeF-4zrqPKElNH3igH9KqE=
KfxSKLz-H&s=3D_aBokTETNVzTrHqewupr4PeLusBNf7LGrTmjI2hppFk&e=3D
> >
> >
> >
> > --
> > Robert Marko
> > Staff Embedded Linux Engineer
> > Sartura Ltd.
> > Lendavska ulica 16a
> > 10000 Zagreb, Croatia
> > Email: robert.marko@sartura.hr
> > Web: www.sartura.hr



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura Ltd.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
