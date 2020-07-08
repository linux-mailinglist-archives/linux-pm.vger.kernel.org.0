Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCCE218994
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgGHN5y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 09:57:54 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:60971 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729517AbgGHN5x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 09:57:53 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id D7958B4F;
        Wed,  8 Jul 2020 09:57:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 08 Jul 2020 09:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=9
        kajBv5LcN6biHj10xmYWD6ww0blwUZJfRS7upFl4XQ=; b=fc99Lu1uzhuM1p1vU
        iIbsKFvLRPRM9bvgqxieS26g783ug572WeI5tc5eSLdUSp3qyVkfmIqvFC9yOgiv
        iE4zFV5hHpEQPKZoFN2NWQ5rQbMFo0aNMDNIFnIxkc1g0iEUlYNRlERXse0Bcikt
        hfNl5vDImfUKRh/zzftkAUeLLha7j2N+7iKyQUPKMNn/YN6E95o8TRzoA3Vt/l1Y
        TtrEy1uT66yN5IqhZI8eO7b3tBPH1/XLNU8PNz7aWT5oH1W3hYvH65hOzQuQLblE
        P/Mmc4jd/GKVrmLUpLs5RGA94oqSAiJkTKOwCA+aCRl/wBigRZXjFP9Ie/iHzRey
        81a9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=9kajBv5LcN6biHj10xmYWD6ww0blwUZJfRS7upFl4
        XQ=; b=BFrD/y18Ac2osQkM5/6/8wiCLccoMvDH7criw+vfc2cV+iY8bk4r5LEjV
        ZTWlQu5SIK6JgKEoRWdlFVpbBHKaAN3Do/b2l3I/DpPp3OXzmlX3GGMXCmVNS/9o
        Rd/jjIvtm7mZNt5EvIiJ6khQnVYXUqsUmghK1IS0l8ceXgKgt0mDDZxfEbslQupw
        YmkamluN43P/ioOHBb2+ctQKz63bAdzSNFzYesQugt1+EPRvqS7lIt6tknYmhWvY
        rciXWCIYv/4bTK6zeXJMkG2dEa6ydrjz1RIfcPXxhmg+WYlpMR3CXieF6QGqllBp
        otpn85mRGlNtnvmV2wOIaRd3Yym8g==
X-ME-Sender: <xms:3tAFX35Ldk0fdHbqNZKI7f1ZA5ZfCSy0iPJrUUC796SRnDTXGH45vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudejgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejjeekjedttdethedtfeelteefffduvdevvdfhtdeiudetleejgeelfeef
    uedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:3tAFX850T2eREUR0hiEjRgCenhvAg50LsSwbMQgXCe6F5JvRC_HBeg>
    <xmx:3tAFX-cnDqk98TCuEUfrpO8ENZotQtJPnXx1oXLm3iQKIsdSJUvlhA>
    <xmx:3tAFX4LztxLrkynpBUHglls3XONSrYLcD1Eb7OeFEH-IM-NyuhYVTg>
    <xmx:39AFX4rO1_k_RntAi3iPyyZ0wGKvQqEY02raZjvR6neHclmVkY0h9KSgONQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3001B328006D;
        Wed,  8 Jul 2020 09:57:50 -0400 (EDT)
Date:   Wed, 8 Jul 2020 15:57:48 +0200
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
Message-ID: <20200708135748.l4zncodhhggurp6s@gilmour.lan>
References: <20200708105527.868987-1-megous@megous.com>
 <20200708122542.73o3lbhgvbdw5c4z@gilmour.lan>
 <20200708132924.r6f5id2evprhybec@core.my.home>
 <20200708133654.fp7k4whl2qmn5ygy@gilmour.lan>
 <20200708134441.4lfuh7nwtqnkkg2a@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200708134441.4lfuh7nwtqnkkg2a@core.my.home>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jul 08, 2020 at 03:44:41PM +0200, Ond=C5=99ej Jirman wrote:
> On Wed, Jul 08, 2020 at 03:36:54PM +0200, Maxime Ripard wrote:
> > On Wed, Jul 08, 2020 at 03:29:24PM +0200, Ond=C5=99ej Jirman wrote:
> > > Hello Maxime,
> > >=20
> > > On Wed, Jul 08, 2020 at 02:25:42PM +0200, Maxime Ripard wrote:
> > > > Hi,
> > > >=20
> > > > On Wed, Jul 08, 2020 at 12:55:27PM +0200, Ondrej Jirman wrote:
> > > > > I noticed several mobile Linux distributions failing to enable the
> > > > > thermal regulation correctly, because the kernel is silent
> > > > > when thermal driver fails to probe. Add enough error reporting
> > > > > to debug issues and warn users in case thermal sensor is failing
> > > > > to probe.
> > > > >=20
> > > > > Failing to notify users means, that SoC can easily overheat under
> > > > > load.
> > > > >=20
> > > > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> > > > > ---
> > > > >  drivers/thermal/sun8i_thermal.c | 55 ++++++++++++++++++++++++++-=
------
> > > > >  1 file changed, 43 insertions(+), 12 deletions(-)
> > > > >=20
> > > > > diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/su=
n8i_thermal.c
> > > > > index 74d73be16496..9065e79ae743 100644
> > > > > --- a/drivers/thermal/sun8i_thermal.c
> > > > > +++ b/drivers/thermal/sun8i_thermal.c
> > > > > @@ -287,8 +287,12 @@ static int sun8i_ths_calibrate(struct ths_de=
vice *tmdev)
> > > > > =20
> > > > >  	calcell =3D devm_nvmem_cell_get(dev, "calibration");
> > > > >  	if (IS_ERR(calcell)) {
> > > > > +		dev_err(dev, "Failed to get calibration nvmem cell (%ld)\n",
> > > > > +			PTR_ERR(calcell));
> > > > > +
> > > > >  		if (PTR_ERR(calcell) =3D=3D -EPROBE_DEFER)
> > > > >  			return -EPROBE_DEFER;
> > > > > +
> > > >=20
> > > > The rest of the patch makes sense, but we should probably put the e=
rror
> > > > message after the EPROBE_DEFER return so that we don't print any ex=
tra
> > > > noise that isn't necessarily useful
> > >=20
> > > I thought about that, but in this case this would have helped, see my=
 other
> > > e-mail. Though lack of "probe success" message may be enough for me, =
to
> > > debug the issue, I'm not sure the user will notice that a message is =
missing, while
> > > he'll surely notice if there's a flood of repeated EPROBE_DEFER messa=
ges.
> >=20
> > Yeah, but on the other hand, we regularly have people that come up and
> > ask if a "legitimate" EPROBE_DEFER error message (as in: the driver
> > wasn't there on the first attempt but was there on the second) is a
> > cause of concern or not.
>=20
> That's why I also added a success message, to distinguish this case.=20

That doesn't really help though. We have plenty of drivers that have
some sort of success message and people will still ask about that error
message earlier.

> > > And people run several distros for 3-4 months without anyone noticing=
 any
> > > issues and that thermal regulation doesn't work. So it seems that lac=
k of a
> > > success message is not enough.
> >=20
> > I understand what the issue is, but do you really expect phone users to
> > monitor the kernel logs every time they boot their phone to see if the
> > thermal throttling is enabled?
>=20
> Not phone users, but people making their own kernels/distributions. Those=
 people
> monitor dmesg, and out of 4 distros or more nobody noticed there was an i=
ssue
> (despite the complaints of overheating by their users).
>=20
> So I thought some warning may be in order, so that distro people more eas=
ily
> notice they have misconfigured the kernel or sometging.

I mean, then there's nothing we can do to properly address that then.

The configuration system is a gun, we can point at the target, but
anyone is definitely free to shot themself in the foot.

You would have exactly the same result if you left the thermal driver
disabled, or if you didn't have cpufreq support.

Maxime
