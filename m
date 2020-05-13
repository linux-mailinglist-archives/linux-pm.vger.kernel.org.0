Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48F21D0F90
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 12:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbgEMKSJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 06:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732472AbgEMKSI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 13 May 2020 06:18:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD0A205ED;
        Wed, 13 May 2020 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589365088;
        bh=I/etr7tb5pVcU15Ld+7AmzN46K/PSY2XStZBs1Iyxi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tCmDeiMQ2Gwu3uggX8Iby1+2OcM1gzJ3EQq/8ZwDZOqhbEchp6fSR5N4Lz2Je0mil
         dmRKfjx/HtC0ii44Ew2C0nUXuraCnklQdzvASEn8KMHo4ZUcbFpMnu27gULanzu+cQ
         rPh5SQSNtoCAs609rC3Z54TAXoxWAjrxwDh3p2G4=
Date:   Wed, 13 May 2020 11:18:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>
Subject: Re: Question about OPP regulator for Panfrost Devfreq
Message-ID: <20200513101805.GA4803@sirena.org.uk>
References: <CAJiuCce9ZxeXnQzEW_3dbBDNZmmtWmKeft0hX+F9+SYu80NU=Q@mail.gmail.com>
 <20200511052530.iazkduojnba3abil@vireshk-i7>
 <CAJiuCcfRmDbBxEms=HAFQhaiBTznEd1of3TOcnAAc2yuTq0XtA@mail.gmail.com>
 <20200513054601.nvwsjhk6i4bjmgt7@vireshk-i7>
 <CAJiuCccd+ycnmirL7chtMom0uqbQ8cX9VQf_ZAvhzTto9VSDbA@mail.gmail.com>
 <20200513091922.qnpjx4kw2m3jv2ry@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20200513091922.qnpjx4kw2m3jv2ry@vireshk-i7>
X-Cookie: Long life is in store for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2020 at 02:49:22PM +0530, Viresh Kumar wrote:

> @Mark: Regarding enabling/disabling regulators from the OPP core, what

My name is spelt Mark.

> about skipping that only for the regulators that are enabled at boot,
> i.e. to avoid the issue we faced earlier, (by exporting a helper from
> regulator core for that first) and then applying this patch again:=20

As ever if you have requirements for the voltage of a regulator you
should use regulator_set_voltage() to tell the core about it.  The core
cannot be expected to infer these requirements without being told by the
users.  If you need the voltage to be a particular level when you enable
the regulator you should set that voltage.  Why can't the code do that
instead of trying to add these complex and fragile bodges?  Randomly
skipping applying configurations some of the time is not going to make
anything more robust or easier to understand.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl67yVoACgkQJNaLcl1U
h9A9OAf/aYng9O0+IouyI83svDM+xFRGaoJYuXUUhtDv0EdqVenpM9XpPmG7OsYk
c4t9+BhyCOjadNfnSpu84BEC4v62Bqiyhm5kp0/qE2bCeU2RGaiSYm1JyXtcW0oq
aDn2tCc7u8NwgYKu9I39QDX4JXx0ZJMq1QLtZhxWpMDTLIozryOJDH5gyDsGh2E7
tekCCZCRkvHkQkkU5xKpB/TmdZGSGt/vFH+swbbqfmdJxbRjJdceqKQ03naSUXga
XRNMiLD9C9EbK7OY0eqkuENwTYwAZrJGgejbKPM1WQBDvYcRX0KM51vIlMgyTmyk
F7i2L+/gdYjqZ4e+5DSdryaHgjxk2A==
=uH9f
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
