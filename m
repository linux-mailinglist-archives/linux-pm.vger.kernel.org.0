Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F982D95BD
	for <lists+linux-pm@lfdr.de>; Mon, 14 Dec 2020 11:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgLNKD1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Dec 2020 05:03:27 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36923 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727892AbgLNKDS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 14 Dec 2020 05:03:18 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CFD95C00A8;
        Mon, 14 Dec 2020 05:02:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 14 Dec 2020 05:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=amRmQ6kJ4wJs0noEFH9sEvxlUhc
        WxV+gBUb0vY545Gk=; b=Nd4uKpPFPy4++0jaP85ctr5rqb5eKFLqae/0HC4BGd0
        dvy7mOha/sIzy1pf9oyUSluUrbpbvVtvU4N+yqymHKmAZRZfjmCqDyqDAyR3ZLwP
        s6HM6eAN4GrC0qoMkTslpNUup7GxmNh1dA2iOWLFviVprSwBfDVR7l/Hm2VU9xCS
        MpuXPEe3PI6Cr4GiMbWyxcMU+3VaVtsWCZDboejDx7DsAxaFF9XLWzom2zrHkiwl
        m85bN3iFHCiSbpSsdAvytGBTUsUIqHINpnHqOev8JXDR8M64Hck8JbxMR+6Ezq7g
        Kpx9JXSEnJXIv1ksf1dXX0X5zeVwWMQqySkh/Phn8uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=amRmQ6
        kJ4wJs0noEFH9sEvxlUhcWxV+gBUb0vY545Gk=; b=k6rNBoAqZOlzFMgg+1TyiH
        ssT14UA0NXlERSIllEuu9egxhHIid/r874lH+NALERuZnDr1nCHyMfkZPU5roAMU
        fyxG8MpmqRYKy0WkvC86ILP8eyUct0ggxjARigCycbotO5CA0ZuLy8pDSYzQUjon
        YZZgtOT46Ze+SDUZ51qhCIjPQOQbM0F2rwBeBe1vhp81I54p0URx3Y3BL+jyaBpp
        QxfldMDLMFn9s2ALESUd1F0QfqoiimU8Syt80f+RLo+3Wi8J+QHKjzIFPGvc1AiC
        zESmevqbUw1VzxmoN4BqTZ/w5DzaDkY7vYQGQCz/aXaUICKc7YshExpbNuKraHwA
        ==
X-ME-Sender: <xms:HTjXX2AshhZ9WJWn0s06B2rj8EI2ofbpyoDaSys6M3vzjHD9IdDFQQ>
    <xme:HTjXXwhBdZNXX8m3pP-hhRK4qTnLDo9xK-iPAFouSHhKpgx6gEd95IZev4uC4p4jf
    kC-Xb51ZKqlhie5BJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekkedguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:HTjXX5k4GvzTRwbdvdGhkU6ehZSG1M-RuITNiVFzAGwQ_MiebhZ6eg>
    <xmx:HTjXX0z78gXkDLXyI_cOrMoYJQFI_03FuiNOiBH70eA3ZnL1KkpZwg>
    <xmx:HTjXX7QLj6SINIO5ZU06kyyyEIvMbpCU0QQgkh6Ct2oFbFbyKH2CrQ>
    <xmx:HzjXX6FpV4vt_JVR-xTNanrO-1XdoLegzXG3iQO28GLFylAukNe6HA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9E55E240057;
        Mon, 14 Dec 2020 05:02:05 -0500 (EST)
Date:   Mon, 14 Dec 2020 11:02:04 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Michael Klein <michael@fossekall.de>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 1/3] power: reset: new driver regulator-poweroff
Message-ID: <20201214100204.ngkgfrghdp3ui3um@gilmour>
References: <20201211151445.115943-1-michael@fossekall.de>
 <20201211151445.115943-2-michael@fossekall.de>
 <20201212234116.cddx5yur7ox7itxv@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="owpjmxjpn4kxie67"
Content-Disposition: inline
In-Reply-To: <20201212234116.cddx5yur7ox7itxv@earth.universe>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--owpjmxjpn4kxie67
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Sun, Dec 13, 2020 at 12:41:16AM +0100, Sebastian Reichel wrote:
> Hi,
>=20
> On Fri, Dec 11, 2020 at 04:14:43PM +0100, Michael Klein wrote:
> > This driver registers a pm_power_off function to turn off the board
> > by force-disabling a devicetree-defined regulator.
> >=20
> > Signed-off-by: Michael Klein <michael@fossekall.de>
> > ---
>=20
> Thanks, queued.

Did you also merge the binding?

Maxime

--owpjmxjpn4kxie67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX9c4HAAKCRDj7w1vZxhR
xc00AP9jEjVYZXSI7H3vqoydj6aW2wvpjAdEzrskl2tUyH1HCQD/X8Uw3eC2F/+r
NgFHSRK73lK9elYfHzGDCkCl7mWsxgY=
=8mFI
-----END PGP SIGNATURE-----

--owpjmxjpn4kxie67--
