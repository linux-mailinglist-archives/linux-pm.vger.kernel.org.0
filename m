Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF183218946
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 15:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgGHNhA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 09:37:00 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:37443 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729675AbgGHNg6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 09:36:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5D6D860B;
        Wed,  8 Jul 2020 09:36:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 09:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=P
        zfHrV4iVkzRgQmQMk6+h0X/sLAgn8pIAagUpIuv7T8=; b=ibfDKMW5rhD3yq18L
        mVyxmP6EvZnkoJNyNrBpNE9yx2xASmoO7f7L4kcxiUxrTIMjrdprJi5ugbAzHSnp
        zu56n8+ERDsNyJD1xO9DiWkCB+dHE26NEMzZCHerkSVjgEYesbjiHjmZqelkyRTN
        dF7yzqYpaxPIcnt0/GQaD7xavAkF4pAKyb8nSVr3DP7S0In6M5OhBpmCqwL6lT+t
        Wi7Lp7aRp/46KKGwOyLjwNL50rIhXC7dEMVQ1ZiyO9hCH4Vntu/WxFVGlM6bsZto
        TL5XTSfC28TPSiq1INbkTxli97CfzeSNFE31JhkW3kByg5ETQg+PMxuOWx0djayQ
        bXUfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=PzfHrV4iVkzRgQmQMk6+h0X/sLAgn8pIAagUpIuv7
        T8=; b=dM+0P6Xxl9ilZqNgMIcgwrZuBICK2Bc/91Z+O+JfrhiOFQrU3VqcVso29
        4twjdjqqPbY25acHFg/oWOKUWQ6//o/cxeaXQKB+5fm5vsP6pbKUX3Nbv+fiFw6G
        1XM5QZd/ZzStzXOH23fBRWmXL/gfO1vYN0vtHcl40wwLn+2HxYBQj9a7Ow63qnBC
        pMbfiAAKq6p4JAZuNmp1Z1dfHvFqd0X8+cw3maCWsFZQ0afCwfl2wpWumkh+V5k4
        CRCoxVOtLfKWsxjTjexZt1AxEZodty0hSUh7gvUIaBwgXor41OHSNpDaeoa4RXAs
        /spyWCfxtFNi2KOe33qghTiAL5uHQ==
X-ME-Sender: <xms:-MsFX0kC14Lb2YaTS8fbpH2EEi2tF_YfoZ5KuRuLWd26pZ6EigocyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejjeekjedttdethedtfeelteefffduvdevvdfhtdeiudetleejgeelfeef
    uedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:-MsFXz2r25JtN-kfFjqzz0h7L02SC76IytdNN3oJdVM-Gc_gDUFL8g>
    <xmx:-MsFXyoP_ZyKegWdOiaWkvDwWXFnCfjHYMN1h4Xj8lj1IvGSlCRYRA>
    <xmx:-MsFXwmd-t4utxh0vLwOvmy0If57qZQOWLM0B8J8XegndvuZZVpOQw>
    <xmx:-csFX7l-KmszxWZ6mANu4EnjnITWbJc3DSUN5HcyFMAtJd5eMg1t3Qj3ooU>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C4592328005A;
        Wed,  8 Jul 2020 09:36:55 -0400 (EDT)
Date:   Wed, 8 Jul 2020 15:36:54 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:ALLWINNER THERMAL DRIVER" <linux-pm@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: sun8i: Be loud when probe fails
Message-ID: <20200708133654.fp7k4whl2qmn5ygy@gilmour.lan>
References: <20200708105527.868987-1-megous@megous.com>
 <20200708122542.73o3lbhgvbdw5c4z@gilmour.lan>
 <20200708132924.r6f5id2evprhybec@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200708132924.r6f5id2evprhybec@core.my.home>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 03:29:24PM +0200, Ond=C5=99ej Jirman wrote:
> Hello Maxime,
>=20
> On Wed, Jul 08, 2020 at 02:25:42PM +0200, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> > > I noticed several mobile Linux distributions failing to enable the
> > > thermal regulation correctly, because the kernel is silent
> > > when thermal driver fails to probe. Add enough error reporting
> > > to debug issues and warn users in case thermal sensor is failing
> > > to probe.
> > >=20
> > > Failing to notify users means, that SoC can easily overheat under
> > > load.
> > >=20
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > ---
> > >  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-----=
--
> > >  1 file changed, 43 insertions(+), 12 deletions(-)
> > >=20
> > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_=
thermal.c
> > > index 74d73be16496..9065e79ae743 100644
> > > --- a/drivers/thermal/sun8i_thermal.c
> > > +++ b/drivers/thermal/sun8i_thermal.c
> > > @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_device=
 *tmdev)
> > > =20
> > >  	calcell =3D devm_nvmem_cell_get(dev, "calibration");
> > >  	if (IS_ERR(calcell)) {
> > > +		dev_err(dev, "Failed to get calibration nvmem cell (%ld)\n",
> > > +			PTR_ERR(calcell));
> > > +
> > >  		if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
> > >  			return -EPROBE_DEFER;
> > > +
> >=20
> > The rest of the patch makes sense, but we should probably put the error
> > message after the EPROBE_DEFER return so that we don't print any extra
> > noise that isn't necessarily useful
>=20
> I thought about that, but in this case this would have helped, see my oth=
er
> e-mail. Though lack of "probe success" message may be enough for me, to
> debug the issue, I'm not sure the user will notice that a message is miss=
ing, while
> he'll surely notice if there's a flood of repeated EPROBE_DEFER messages.

Yeah, but on the other hand, we regularly have people that come up and
ask if a "legitimate" EPROBE_DEFER error message (as in: the driver
wasn't there on the first attempt but was there on the second) is a
cause of concern or not.

> And people run several distros for 3-4 months without anyone noticing any
> issues and that thermal regulation doesn't work. So it seems that lack of=
 a
> success message is not enough.

I understand what the issue is, but do you really expect phone users to
monitor the kernel logs every time they boot their phone to see if the
thermal throttling is enabled?

If anything, it looks like a distro problem, and the notification /
policy to deal with that should be implemented in userspace.

> Other solution may be to select CONFIG_NVMEM_SUNXI_SID if this driver
> is enabled. That may get rid of this error scenario of waiting infinitely
> for calibration data with EPROBE_DEFER. And other potential EPROBE_DEFER =
sources
> will probably be quite visible even without this driver telling the user.
> So this message may not be necessary in that case.

That would only partially solve your issue. If the nvmem driver doesn't
load for some reason, you would end up in a similar situation.

Maxime
