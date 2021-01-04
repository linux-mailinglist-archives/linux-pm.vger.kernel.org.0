Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B462E9D00
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jan 2021 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhADS2n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jan 2021 13:28:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:44436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbhADS2m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 4 Jan 2021 13:28:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B65E21D94;
        Mon,  4 Jan 2021 18:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609784881;
        bh=hkJleZJl1Rf3/RagFDK72zYpmnsQEELyt+FwMdkhA20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nrhvpqyppjdFjvEh4LE2eQvRyYnvNBvPZFthAe4+6OPM/pE9mdhpaeTtBPrVtt1//
         M/X/Ogq1/cMHGzI6oJ9IsdxR16TZIDUwcLtoFPRfiORj/YfQgiAD9MBmaTaIla30mu
         jbBXUlf3lyJyx60ayPDwgNx7u6Dkkxopyu7eavt75PjlwIfSCy2JHY9rhQeWMkHCPm
         bkc6X4Q6BhgLHKGk42jUq6DYfs9bTzmWn1tL4AiXQvMcpc0LVDvt8wdJKnr46QDGfM
         GEliG0iKl09Ehuvgctw2fPW5It2NqJk54+ji4W71k0ffSwU9PA28yupmUggThlR7CV
         ewHkMcuHLa4wQ==
Date:   Mon, 4 Jan 2021 18:27:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Timon Baetz <timon.baetz@protonmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 2/8] regulator: dt-bindings: Document max8997-pmic
 nodes
Message-ID: <20210104182734.GH5645@sirena.org.uk>
References: <20201230205139.1812366-1-timon.baetz@protonmail.com>
 <20201230205139.1812366-2-timon.baetz@protonmail.com>
 <20210104135156.GB5645@sirena.org.uk>
 <20210104181825.GB27043@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6cMF9JLEeZkfJjkP"
Content-Disposition: inline
In-Reply-To: <20210104181825.GB27043@kozik-lap>
X-Cookie: Stupidity is its own reward.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--6cMF9JLEeZkfJjkP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2021 at 07:18:25PM +0100, Krzysztof Kozlowski wrote:
> On Mon, Jan 04, 2021 at 01:51:56PM +0000, Mark Brown wrote:

> > > +- charger: Node for configuring the charger driver.
> > > +  Required properties:
> > > +  - compatible: "maxim,max8997-battery"

> > > +  Optional properties:
> > > +  - extcon: extcon specifier for charging events
> > > +  - charger-supply: regulator node for charging current

> > > +- muic: Node used only by extcon consumers.
> > > +  Required properties:
> > > +  - compatible: "maxim,max8997-muic"

> > Why do these need to appear in the DT binding?  We know these features
> > are there simply from knowing this is a max8997.

> If you refer to children nodes, then we do not know these entirely
> because the features could be disabled (pins not connected).  In such
> case these subnodes can be disabled and MFD framework will not
> instantiate children devices.

We can indicate the presence of features without adding new compatible
strings, that's just encoding the way Linux currently divides things up
into the bindings.  For example having an extcon property seems like it
should be enough to figure out if we're using extcon.

--6cMF9JLEeZkfJjkP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/zXhUACgkQJNaLcl1U
h9D9jgf9EGbTkevPAL1mlthdswaXnEuKys1fjzyruP7TkivQxwr9r7bGCPunJhDU
MPrg801loRBn+jNA4/VHXyAxmkW7/7Q8mOSzzaegFaP5ls4rSQEmd8iyTGmpK6AZ
05U2KiOzin5hn3giiXAZ266C2n7IxdmdFwdZHDzrb96qiCTUMWQ07lASykjTwXR1
fT6FYeLNA/IeHZiXQuG5+MkYndcctydBLiKAK7GxLzVcd7Fq2CMu9g+38+qinIo+
RMc6UbQ3OoeBlaUO3hinZupwORs7U0sb1lBEfranFSMQj52sZI+DAaR0YWgW969g
zQlwBhKlaFHLIMBfd3muUrGNnxnxbw==
=/aRX
-----END PGP SIGNATURE-----

--6cMF9JLEeZkfJjkP--
