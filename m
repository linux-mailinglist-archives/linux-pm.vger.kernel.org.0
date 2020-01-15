Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9EB013CDC4
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 21:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgAOUJq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 15:09:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35124 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729449AbgAOUJp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 15:09:45 -0500
Received: by mail-io1-f65.google.com with SMTP id h8so19219252iob.2;
        Wed, 15 Jan 2020 12:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NKbYYUka2OKZl4ULarL65Qmdbkm/KqJ8pMqUhGAd4ic=;
        b=IW94MIKQnRJuCWNAIbEg66dP4sSfY2MlwF3d4QPhaUqhcd5zsyV1TAgedJgnZSZ6H6
         On4TLLoZpPPLHfJf23fZ68fTE+uLmaQZ4TgsDi9dbYKvKNe5/IkSaop2cp4G2LiO97aM
         M+5ai6iWxB3f2TQOp/qMFSVbZR1G4n8WFEuki7EPZBSer+aIAQf27Z0SczhjUJcGpIPY
         PTs/NeS2xFLDqQfu7Oz6pqgcKMPWFu1Xw7dh5N0pO2D2vDrE6S9/Ov430aZ8OO2knkyU
         LD0Om1fpEgccfatYeyiNPCHwVB1UO1mgSncyTKfyZSH7NozxojPJ2wsWCQziGzwJdeJK
         7R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NKbYYUka2OKZl4ULarL65Qmdbkm/KqJ8pMqUhGAd4ic=;
        b=Dwpj2m0pasFr8+8D5kirj1dDv4PtMLb0friENJMdvI/yjABKMpPeo+ZugGfH/yjotn
         u2Wso9eqC19u/bwptmLILasvgV/UHbcnqLChgQdsWxESHvjC/tb7gfZnchvpoZcq5v5U
         +v4+lS7rKm5nJef/R76rqTZB9AnQujow83flXf14AFV3zAIsyz/iR1IxcPujI4ByburH
         fE+gu9pNS4WhgbH0WNy1v/EEhTNyteVHNUtIhezOtywcQWqTVxMjbUmvLiqy61XprmQn
         fQOhn5ZvU2430V57Z2rfh4BnqW9Akwy6grjUbVF9nemV8wccYCABtop973EeNJ9BmNso
         fpFg==
X-Gm-Message-State: APjAAAU9R/YTmOzQXJuYoOUNxR9p2KlKXYtPtM8+ALX0Yz1WsjzhUuXT
        mjvitwJqr4U4VFcpHUSyXdn3+26PTQtokMiZaf8KwGX7hd0=
X-Google-Smtp-Source: APXvYqzEelNgyROBJYflB/UDF8ucW2Iqu/rx2Jz8VeF4PW5oJv5kdmaJKPWGZq1eoHVN8/OV48Fg1QBRED9VfMlAxPo=
X-Received: by 2002:a02:a38a:: with SMTP id y10mr25168560jak.55.1579118984323;
 Wed, 15 Jan 2020 12:09:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574458460.git.leonard.crestez@nxp.com> <CAHCN7xKNwit8ueUO0OkebfYh=4hsL7_+DRWEbn2dEt0H322W4w@mail.gmail.com>
 <VI1PR04MB70231CA0E3C4574211518359EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xJNy0z2hvWbM3UhLni5ruS+sCLeBH8BKiYexe3Sp=6Q0w@mail.gmail.com>
 <VI1PR04MB70235951BC137515BDD2FDC7EE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xKHJAb8k1A+WC3EUOmgLTx-Kbjw_5EsmwyhDkkOKCsmGQ@mail.gmail.com>
 <VI1PR04MB702379645745FB697033FE6BEE530@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <CAHCN7xLOgh+E5Gw+2v4RUuZANHa+CkW=ACHL5NALMcSRfRY8eQ@mail.gmail.com>
 <CAHCN7xKjpN_XEGLj-1jMG5mBbF=su67k+10frheLt+L1XaR0-g@mail.gmail.com> <VI1PR04MB7023DA37F366D4C770D7312EEE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023DA37F366D4C770D7312EEE350@VI1PR04MB7023.eurprd04.prod.outlook.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 15 Jan 2020 14:09:32 -0600
Message-ID: <CAHCN7xJc8yMe683wsB1e1TdE26FX1oMFT_i_hshkEECrJ52oHg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] PM / devfreq: Add dynamic scaling for imx8m ddr controller
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Angus Ainslie <angus@akkea.ca>,
        Alexandre Bailon <abailon@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 13, 2020 at 5:36 PM Leonard Crestez <leonard.crestez@nxp.com> w=
rote:
>
> On 10.01.2020 20:34, Adam Ford wrote:
> > On Wed, Dec 18, 2019 at 10:42 AM Adam Ford <aford173@gmail.com
> > <mailto:aford173@gmail.com>> wrote:
> >      > > U-Boot booted and Linux booted, but I still get:
> >      > >
> >      > >     imx8m-ddrc-devfreq 3d400000.memory-controller: failed to i=
nit
> >      > > firmware freq info: -19
> >      >
> >      > Which version of u-boot is that, upstream? I'm subscribed to ubo=
ot
> >      > mailing list and I see that imx8m support has its own separate i=
ssues
> >      > but my familiarity is limited :(
> >
> >     U-Boot 2020.01-rc4-00244-gf39abbbc53-dirty (Dec 18 2019 - 09:27:40
> >     -0600)
> >
> >      >
> >      > I've only ever tested with NXP uboot and the NXP version of mkim=
age:
> >      >
> >      >
> >     https://source.codeaurora.org/external/imx/uboot-imx/log/?h=3Dimx_v=
2019.04_4.19.35_1.1.0
> >     <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fsource.codeaurora.org%2Fexternal%2Fimx%2Fuboot-imx%2Flog%2F%3Fh%3Dimx_v20=
19.04_4.19.35_1.1.0&data=3D02%7C01%7Cleonard.crestez%40nxp.com%7C5babd2cb3f=
ec4dc0a21008d795fbbc4a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6371427=
80735473321&sdata=3DLhleGMcJzjiNsPbVxmPbvgRVMnl%2F2HxUqVYKcgCFiEg%3D&reserv=
ed=3D0>
> >      > https://source.codeaurora.org/external/imx/imx-mkimage/
> >     <https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2Fsource.codeaurora.org%2Fexternal%2Fimx%2Fimx-mkimage%2F&data=3D02%7C01%7C=
leonard.crestez%40nxp.com%7C5babd2cb3fec4dc0a21008d795fbbc4a%7C686ea1d3bc2b=
4c6fa92cd99c5c301635%7C0%7C0%7C637142780735483320&sdata=3DenJQ9hgVkIG7frJ9v=
6QBQAgJBL8j3hWB7RAKa8XhPaw%3D&reserved=3D0>
> >
> >     I will try your versions and see what happens.
> >
> >      > My bootloader prints the following BuildInfo:
> >      >    - ATF 70fa7bc
> >      >
> >      >    - U-Boot 2019.04-00019-g4d377539a119
> >      >
> >
> >     Thanks for your help.
> >
> >
> > I wanted to try again after everything was merged into linux-next.
> >
> > I am using the U-Boot master (as of 10 Jan 2020), with ATF from
> > 4.19.35_1.1.0 from Code Aurora.  I have tried your ATF, but I don't see
> > any change in behavior.  I have made the DDRC a module, but I still get
> > the same error message.
> >
> > [    2.204554] imx8m-ddrc-devfreq 3d400000.memory-controller: failed to
> > init firmware freq info: -19
> >
> > Is there something else I can try?
>
> Yes, the NXP branch of uboot from Code Aurora (my commit hash is above).
>
> I understand you want to use uboot and atf master, apparently they both
> need to be patched for this feature to work. It would still be
> interesting to validate.

I was able to get the 8MM to work with this new driver using the uboot
branch from Code Aurora.  Could you point me to what in U-Boot needs
to be pulled forward to the mainline?  I'd be willing to help if I
can.

Thanks for your help.

adam
>
> --
> Regards,
> Leonard
