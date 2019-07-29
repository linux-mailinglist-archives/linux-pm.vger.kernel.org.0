Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9F97853E
	for <lists+linux-pm@lfdr.de>; Mon, 29 Jul 2019 08:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfG2Gvg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 02:51:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44934 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfG2Gvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 02:51:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so60465014wrf.11;
        Sun, 28 Jul 2019 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v90YPXKI4GUWpeIkXpR1C/gf5jGZt8lyB8cJkCXtAs4=;
        b=HkFo8r+Mhc+dka46pBgHKGgOw300fimW1/wLqx0AmkfjaZpUky+65lpB0YHCCHXq8I
         DNUww9oNMwYxY56VcouIsLPOlKK3SktU6LgDv4UEFjwyqkz2b/P5+ScZt0H3eGTJW3A2
         8003IepoQ+HaHMZ1Z7331VSbRmg8wg2JAvu997kFwUJm9mWpki0eGK7K7n4tLuqI5p29
         m4u99JVqEfPTKWF27b8F+WOXiMZNnnjKinn2mo9MNgxmdPZqH6GC+9vrKUkXfmWWUv+O
         w2BxlKjy43/0WUQNjClkBMCBZb43GasqxlgND/BF43ZnnOjHqHKsfiSduFdo0Ke3XSTB
         1KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v90YPXKI4GUWpeIkXpR1C/gf5jGZt8lyB8cJkCXtAs4=;
        b=Nqgos51BIcnJAMH7fvw9mtL0W0ZMNiwRHkKJaQPYoHKoG+fqExUwa28WclTUfr+Nvh
         1O3pf3Tpfz/0GdEMVGl4zeDX8Z4QquUzQxpFv9ELZG1K2IPbXw9u+OuOT3n8+z9DZecu
         B3r7vWU+L3C1knfT8ayDCdNdyrKG67ie9yY5ZBkVYoC59QIfEIrlUj8cuH7rdtxBOL7c
         8eZo7zQywAIWjrpp7ZyllW/9PmoeVfv03SgLANQG4pAPKSXZGZwUt/I6B+u53UfQ4NS7
         Wc+YdW17+pbRdB0+nzCTjWM7qp3KK7Lc+ygisj1lQjRbyq9shVkXcNrGqBfcoihvmxXD
         LHLA==
X-Gm-Message-State: APjAAAXftNOqzJcMGis4JXPi6XKCCd/jBqMaC9Yi9vHbMFmwxKaVFFcx
        xaWKBQ6Z5oe87s8IzCA703r3Fb4GdGrQMchPtTs=
X-Google-Smtp-Source: APXvYqyv4uaMyeWcmvjY2UgFAZuoyar5QPXZqVXSg2irz44SilVKKkvVl6fLEdJb4ibwa0xYbImEpjtIbRtvw/3pXqY=
X-Received: by 2002:a05:6000:14b:: with SMTP id r11mr44289431wrx.196.1564383092966;
 Sun, 28 Jul 2019 23:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190705045612.27665-1-Anson.Huang@nxp.com> <20190705045612.27665-5-Anson.Huang@nxp.com>
 <CAEnQRZAZNMBx3ApVmRP8hYPw0XY_QgR-saE6WLcT8oZmHPCxSA@mail.gmail.com>
 <DB3PR0402MB3916233A56CF5DF778115716F5C30@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <CAEnQRZCrZybzcy__u4p_Eq4zSVc2ESyfKLk5sPf1JYba1JSOiA@mail.gmail.com>
 <20190727161736.4dkfqgwftre67v56@fsr-ub1664-175> <DB3PR0402MB391600891BA75DFFA9674058F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391600891BA75DFFA9674058F5DD0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 29 Jul 2019 09:51:21 +0300
Message-ID: <CAEnQRZB6tmYFA8wwh0Fm49LTTDuCLq-SWVfrcUkRWWBo=0U13w@mail.gmail.com>
Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag for IMX8MQ_CLK_TMU_ROOT
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Abel Vesa <abel.vesa@nxp.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Carlo Caione <ccaione@baylibre.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 4:29 AM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Abel/Daniel
>
> > On 19-07-27 09:33:10, Daniel Baluta wrote:
> > > On Sat, Jul 27, 2019 at 9:19 AM Anson Huang <anson.huang@nxp.com>
> > wrote:
> > > >
> > > > Hi, Daniel
> > > >
> > > > > Subject: Re: [PATCH 5/6] clk: imx8mq: Remove CLK_IS_CRITICAL flag
> > > > > for IMX8MQ_CLK_TMU_ROOT
> > > > >
> > > > > Hi all,
> > > > >
> > > > > latest linux-next hangs at boot.
> > > > >
> > > > > commit fde50b96be821ac9673a7e00847cc4605bd88f34 (HEAD ->
> > master, tag:
> > > > > next-20190726, origin/master, origin/HEAD)
> > > > > Author: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > > Date:   Fri Jul 26 15:18:02 2019 +1000
> > > > >
> > > > >     Add linux-next specific files for 20190726
> > > > >
> > > > >     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > >
> > > > >
> > > > > I know this is crazy but reverting commit:
> > > > >
> > > > > commit 431bdd1df48ee2896ea9980d9153e3aeaf0c81ef
> > (refs/bisect/bad)
> > > > > Author: Anson Huang <Anson.Huang@nxp.com>
> > > > > Date:   Fri Jul 5 12:56:11 2019 +0800
> > > > >
> > > > >     clk: imx8mq: Remove CLK_IS_CRITICAL flag for
> > > > > IMX8MQ_CLK_TMU_ROOT
> > > > >
> > > > >     IMX8MQ_CLK_TMU_ROOT is ONLY used for thermal module, the
> > driver
> > > > >     should manage this clock, so no need to have CLK_IS_CRITICAL =
flag
> > > > >     set.
> > > > >
> > > > >
> > > > >
> > > > > makes the boot work again.
> > > > >
> > > > > Any idea?
> > > >
> > > > I just found if disabling SDMA1, then kernel can boot up, it does
> > > > NOT make sense TMU clock is related to SDMA1, I will check with des=
ign
> > and get back to you soon.
> > > >
> > >
> > > Hi Anson,
> > >
> > > Applying Abel's patch:
> > >
> > > commit 8816c47db6a82f55bb4d64f62fd9dd3af680f0e4 (HEAD -> master)
> > > Author: Abel Vesa <abel.vesa@nxp.com>
> > > Date:   Tue Jun 25 12:01:56 2019 +0300
> > >
> > >     clk: imx8mq: Mark AHB clock as critical
> > >
> > >     Keep the AHB clock always on since there is no driver to control =
it and
> > >     all the other clocks that use it as parent rely on it being alway=
s enabled.
> > >
> > >
> > >
> > > The kernel boots up again.
> > >
> > > It make some sense. I don't understand though why having
> > > IMX8MQ_CLK_TMU_ROOT as critical also "unhangs" the kernel.
> > >
> >
> > OK, so this is how it works.
> >
> > By removing the critical flag from TMU, the AHB doesn't stay always on.
> > With my patch the AHB is marked as critical and therefore stays on.
> >
> > The sdma1_clk has as parent the ipg_root which in turn has as parent th=
e
> > ahb clock. And I think what happens is some read from the sdma register=
s
> > hangs because, for whatever reason, enabling the sdma1_clk doesn't
> > propagate to enable the ahb clock. I might be wrong though.
> >
>
> I can explain why Abel's patch can fix this issue, the AHB clock is a MUS=
T
> always ON for system bus, while it does NOT have CLK_IS_CRITICAL flag set=
 for now,
> when SDMA1 is probed, it will enable its clock, and the clk path is sdma1=
_clk->ipg_root->ahb,
> after SDMA1 probed done, it will disable its clock since no one use it, a=
nd it will trigger
> the ahb clock to be OFF, as its usecount is added by 1 when probe and dec=
reased by 1 after
> SDMA1 probe done, so usecount=3D0 will trigger AHB clock to be OFF.
>
> So I think the best solution should be applying Abel's patch as you menti=
oned upper, the TMU
> clock patch is NOT the root cause, it just triggers this issue accidently=
=E2=98=B9
>
> But I saw Abel's AHB patch is still under discussion, so I think we need =
to speed it up and make
> kernel boot up work for development. AHB/IPG are always critical for i.MX=
 SoCs.

Thanks Anson,

Your explanation makes a lot of sense. We will take care today of Abel's pa=
tch.
What do you think about Fabio's patch? I also think this is a valid patch:

http://code.bulix.org/pd88jp-812381
