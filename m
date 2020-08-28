Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B02C255FC2
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgH1RdJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 13:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgH1RdI (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 13:33:08 -0400
Received: from earth.universe (dyndsl-095-033-159-123.ewe-ip-backbone.de [95.33.159.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E3C2074A;
        Fri, 28 Aug 2020 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598635987;
        bh=dVXhorCySV7p0XUAWBV8r7NvXycdCFYPc1TRtnibkH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XI8iOVvVyQ9dMHhUCxnfRWh5a5w6FGRz5T1tY1ZvwTXpaL5dMCzERUYBAN2GSvkJo
         9iq4uXhAW4qtfVnhtZ6em2gZis/BUAURXIJ54KbZCU3CHDaA0+NuF0KAkfQTi+dagy
         gc9Ig2Trhh8DCnMBHa2V4iNUD755yOOmY/drytY8=
Received: by earth.universe (Postfix, from userid 1000)
        id 078BA3C0C82; Fri, 28 Aug 2020 19:33:06 +0200 (CEST)
Date:   Fri, 28 Aug 2020 19:33:06 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     krzk@kernel.org, jonghwa3.lee@samsung.com, tglx@linutronix.de,
        kstewart@linuxfoundation.org, baolin.wang7@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] power: supply: Charger-manager improvements
Message-ID: <20200828173305.u5n66ll57gn2b76s@earth.universe>
References: <BN6PR04MB06603115D277DF264D9380E8A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="curnqtretflpgrou"
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06603115D277DF264D9380E8A3BC0@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--curnqtretflpgrou
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 14, 2020 at 04:04:25PM -0700, Jonathan Bakker wrote:
> Charger-manager is a virtual driver for unifying chargers, fuel gauges,
> extcon devices, and a thermal device into a battery management system.
>=20
> Unfortunately, it has been broken since commit 830ae442202e ("extcon:
> Remove the deprecated extcon functions") when the extcon internal API
> was changed but some drivers were not updated.  Additionally, it had
> some race conditions and was unnecessarily complex.
>=20
> A number of these patches come from a Tizen git tree(1); they have been
> rebased and the commit messages cleaned up.
>=20
> These changes have been tested on a couple of first-gen Galaxy S devices
> based on s5pv210 with a modified max8998 driver so that a charger
> regulator is exposed.  In addition to the max8998, this hardware has
> a max17040 fuel gauge, fsa9480 extcon, and a generic thermal resistor
> for temperature sensing.
>=20
> 1) https://git.tizen.org/cgit/platform/kernel/linux-exynos/log/drivers/po=
wer/charger-manager.c?h=3Dtizen_5.0

Thanks, queued. I hope this does not trigger more people to use it.
We really need a proper core feature for this.

-- Sebastian

--curnqtretflpgrou
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9JP8oACgkQ2O7X88g7
+prZ+A/+KIUCbI6mn4h5I1HAy0txA5dSSTOsqLZ2UMCL12zN46q53vgjv69PBHxt
+bBSnmDRPd3rW+EDe693lHBDKoxJ/A7lqQENeFw0lMsDaAHEsW7RKlF/rOIDIPKB
DdbXJqfw3CQWBGZ35OCnTEGUDdH20EJINATS7B/8yVsbMYwnax6NENSj8iSSQf1B
9IqW+rg63n+d9TFC85qL0L39bBOx13TxnYiG0BCdKRaZA3HMb2+FyHdMDyvi/nY7
I577cq6GZb/uD+s2sbl575PwWfZpsn1OBhidmCpXg9lN6+dzPv6RnwaHDlAiM4Cq
D6Pb/njPdIddJ3uMe7RptQgoh+wAL0gFZ5zHEY5jOMYOYxjMiNYGdvgzPkEYwogy
EZTLJhGCtMQk6LLPnxrtWWJRztOkkul8BIWJyYLBz+dDL/7AF2gSmT7u+YVhfUj5
DagDgufuAspY3ZLz16Omz5m/9u0MRe+KDocnTQNNS5NvR+AvxTlmNspqbu+G1yDq
c6k4ZYuo/zvSU0sbaSICcDCvnQkXAoDLw8la1KvBnjZZM5kOh7sW1I7UI0dATVTn
BoY41Uxx13wyckHgatpgAZO7NT9okBmY3l18awz01zZAQo4b1w7+/ZS8RkiMB5YQ
uwG5WFPgdVuooK5LUO0Yew66rQFMgBy0HnEYSHmqX8oLBOLRw5M=
=2ELG
-----END PGP SIGNATURE-----

--curnqtretflpgrou--
