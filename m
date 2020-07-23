Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E932F22B260
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jul 2020 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgGWPVA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Jul 2020 11:21:00 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:40871 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbgGWPVA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2020 11:21:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id F13195809AD;
        Thu, 23 Jul 2020 11:20:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Jul 2020 11:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=u
        vamDLmFMG67kHSwtBzzrekOA3Min6/oHJ8rJdAHzuI=; b=jRITkwnmyBayVcHM3
        JGfBP+XmHcCj6q7MUNHeqxd8aE6zdtnPefyWU4M0KAX07OZlOmtmv4lfIRi3+6oK
        kUtMOiC1wy+EOMcP5OVgFuoqv+7uu9L6iAE88OFzRsT+IIo7G7qpwPR33zUKil8y
        SDsGZXsQlcYTyODrLYhobYOZxppi9H0esDahJBESxiG4PKEjteC49FTB0Ri3bzJT
        VtJAaSRU1Mo4LE7YTpRwKy97iFeUlEG24jneh58mal6b40xtnVemVdd84BBxeub6
        BewVDHT05d7p7ElEdfP9/Ot15NwhSxIqiIeOpFfxrZAobaKGHB0x7Ws+nA7hJ7B4
        rmwkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=uvamDLmFMG67kHSwtBzzrekOA3Min6/oHJ8rJdAHz
        uI=; b=IKL4UzwdZXrOkQmcA3d+TejurpkjNZYXHQXpe3CvmMq5WmIpj6S/ABIQ/
        pGUc6SGWmRT7/yqN177HYN+wnqaAeGPmUpTG8Mt4f6jyle/0H0HvJtMAv9+lakSp
        AAUKOrQWFQZrkmZ5ADIMlSYlEr0fK0aJRli/NoXg1OxP09ZYthWwHzlUHg+teURt
        PIFG4M5ZX2HPfKUL2EVFsoLjxPkLOeJffD91adXgRAYa2Fxa/IUhpseuyooLokzq
        j8XCcfm3gZoSF27qyUFvXqBpnAkl1p3KYTtSzOKRYm6ZDWhwHHLXTqJJagEk+WnI
        Sg1DquwvWiLJTIE8BEfVwJEX370+A==
X-ME-Sender: <xms:2aoZX3n4RN5-xkPXPgFbqZ6fKPg25F9Up298zDEICw4JHcIuhlg2MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrhedugdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttdejnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfejjeekjedttdethedtfeelteefffduvdevvdfhtdeiudetleejgeelfeef
    uedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:2aoZX62dHOA8uaufwwTV5WcEcfC4a_A43mt8JIw38YjjY4Wty7sk0w>
    <xmx:2aoZX9rotHqnEfQRPY14bCwgu6dbn_GlnJIqxNaj7kcLcRZvK0f-Pw>
    <xmx:2aoZX_lsFsI_Xp_vZheN1vfbfi8Mi443YYgZTq2g83HnZV6Uz8y8-g>
    <xmx:2qoZXyntTGWJVGGT0QGvZsR3T3P9bEYf00ctmCS_xhonZxc98OyEsA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D43CB3280067;
        Thu, 23 Jul 2020 11:20:56 -0400 (EDT)
Date:   Thu, 23 Jul 2020 17:20:54 +0200
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
Message-ID: <20200723152054.hrtahg77ycg5ovud@gilmour.lan>
References: <20200708105527.868987-1-megous@megous.com>
 <20200708122542.73o3lbhgvbdw5c4z@gilmour.lan>
 <20200708132924.r6f5id2evprhybec@core.my.home>
 <20200708133654.fp7k4whl2qmn5ygy@gilmour.lan>
 <20200708134441.4lfuh7nwtqnkkg2a@core.my.home>
 <20200708135748.l4zncodhhggurp6s@gilmour.lan>
 <20200712232942.eecoekr25i3wu2iq@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200712232942.eecoekr25i3wu2iq@core.my.home>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 13, 2020 at 01:29:42AM +0200, Ond=C5=99ej Jirman wrote:
> Hi Maxime,
>=20
> On Wed, Jul 08, 2020 at 03:57:48PM +0200, Maxime Ripard wrote:
> > On Wed, Jul 08, 2020 at 03:44:41PM +0200, Ond=C5=99ej Jirman wrote:
> > > >
>=20
> [...]
>=20
> > > > Yeah, but on the other hand, we regularly have people that come up =
and
> > > > ask if a "legitimate" EPROBE_DEFER error message (as in: the driver
> > > > wasn't there on the first attempt but was there on the second) is a
> > > > cause of concern or not.
> > >=20
> > > That's why I also added a success message, to distinguish this case.=
=20
> >=20
> > That doesn't really help though. We have plenty of drivers that have
> > some sort of success message and people will still ask about that error
> > message earlier.
> >=20
> > > > > And people run several distros for 3-4 months without anyone noti=
cing any
> > > > > issues and that thermal regulation doesn't work. So it seems that=
 lack of a
> > > > > success message is not enough.
> > > >=20
> > > > I understand what the issue is, but do you really expect phone user=
s to
> > > > monitor the kernel logs every time they boot their phone to see if =
the
> > > > thermal throttling is enabled?
> > >=20
> > > Not phone users, but people making their own kernels/distributions. T=
hose people
> > > monitor dmesg, and out of 4 distros or more nobody noticed there was =
an issue
> > > (despite the complaints of overheating by their users).
> > >=20
> > > So I thought some warning may be in order, so that distro people more=
 easily
> > > notice they have misconfigured the kernel or sometging.
> >=20
> > I mean, then there's nothing we can do to properly address that then.
> >=20
> > The configuration system is a gun, we can point at the target, but
> > anyone is definitely free to shot themself in the foot.
> >=20
> > You would have exactly the same result if you left the thermal driver
> > disabled, or if you didn't have cpufreq support.
>=20
> Right. Though I hope there's some middle ground. I mean all of those dev_=
err
> in error paths of many drivers are there mostly to help debugging stuff.

Adding all the error messages you have in that patch seems like a good
middle ground to me, and we could definitely use more of them in some
other drivers (like the USB PHY)

> And even though I was part of this driver's development, it took me quite
> some time to figure out it was the missing sunxi-sid driver causing the i=
ssue,
> with complete silence from the driver.
>=20
> Maybe this can/will be solved at another level entirely, like having a de=
vice
> core report devices probes that failed with EPROBE_DEFER some time after
> the boot finished and modules had a chance to load, instead of immediately
> for each probe retry.

The thing is that there's never a point in time where "all the modules
had a chance to load". If you're loading the modules on demand and have
an hotpluggable bus, that might happen after a second or after a year,
you can't say.

The actual fix for this would be to use the on demand probing that seems
to be in the works and avoid EPROBE_DEFER entirely, but that probably
won't happen in a near future.

Maxime
