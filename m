Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F296A3315A1
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbhCHSOW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 13:14:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:49652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230490AbhCHSOB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Mar 2021 13:14:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 305AB6518A;
        Mon,  8 Mar 2021 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615227241;
        bh=NN2EdiQR/1KB14V2lMDtzBvuB5cMumLqu6/E5H9nAWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhOirhDyb9FlY5pap6WsMmv3JRDCz7mzXlMX6K4gUsBlJSAySR4uXTJ8tDD9GDsCu
         /zqg9NR3Q7cAYmx/mc2rBqQUUpTQY++rVrfn3gKAgxtxotfn3tEm7d+ohy04HLpVzT
         2yeRxwqA/KT5UDIgNHQrE9IG1wcc5esGRnXAqqrGrGJCzkIFbnvxZ2nO3/EQRdBpih
         +mRkOI5sXdaCDanFRBHCUN4qMu1KafFJJ5g1lCyK6b9hxCdTY7OSj98Nr/KUAJNrCZ
         H39wVQk+YGwx93P5Xsf9/KVaYqatjSZNbziOmPPndgTwcmjCFv/0RJiHI5Sq+ATE7S
         hHaA8d1Ov1d4g==
Received: by earth.universe (Postfix, from userid 1000)
        id 0AA393C0C95; Mon,  8 Mar 2021 19:13:59 +0100 (CET)
Date:   Mon, 8 Mar 2021 19:13:58 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: driver notification when switching between battery vs AC power?
Message-ID: <20210308181358.nxfdy4psvfv3mrwq@earth.universe>
References: <20210305080748.GA17954@lst.de>
 <CAJZ5v0gjO24-Gb-8ejTCkS2z6MFR7ZVAbYveVPkW1B_71u-LsQ@mail.gmail.com>
 <357ec08b83bef385162c23f37b4efa439a120947.camel@intel.com>
 <20210308075048.GA983@lst.de>
 <CAJZ5v0hRef89EyU8nvbU0UXYHcd7gjk1e4BLDYCzKH7WSNBsWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ih2y3nxf44lhwvys"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hRef89EyU8nvbU0UXYHcd7gjk1e4BLDYCzKH7WSNBsWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ih2y3nxf44lhwvys
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 08, 2021 at 04:29:31PM +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 8, 2021 at 8:50 AM Christoph Hellwig <hch@lst.de> wrote:
> > On Sun, Mar 07, 2021 at 09:53:06PM +0800, Zhang Rui wrote:
> > > Thanks for adding me in the loop.
> > >
> > > Yes, an ACPI notifier callback should be sufficient for this purpose.
> > >
> > > Usually, we get an ACPI notification upon AC plug/unplug, so what we
> > > need in the NVMe driver is to get the notification and then get the
> > > status of AC adapter. As ACPI AC driver always sends the AC events to
> > > acpi notifier chain, what we need is
> > > a) define a notifier callback, and in the notifier callback
> > >    1. ignore non-AC devices,
> > >    2. get AC status, you can refer to acpi_ac_get_state()
> > > b) register the notifier cb to ACPI notifier chain, by invoking
> > >    register_acpi_notifier()
> >
> > Not my direct priority now, but would there be any objections to
> > wire up a power_source_notifier method in struct dev_pm_ops to
> > avoid boilerplate code and ACPI dependencies in drivers?
>=20
> That would work for me, unless there is something more generic than
> the ACPI-based notification mechanism already in the power supply
> framework. Sebastian?

power-supply framework provides two things:

a) One can register into the power-supply notifier chain using
   power_supply_reg_notifier(). This should be triggered by AC
   plug/unplug (among other things) as long as the driver calls
   power_supply_changed() when online state changes. I took a
   quick glance and ACPI AC driver does not seem to call it at
   the moment. I think both calls to kobject_uevent() in the
   driver need to change into power_supply_changed() for this
   to work on ACPI based systems.

b) There is power_supply_is_system_supplied() to check if the
   system is supplied by a non-battery type device (which might
   also be USB-C).

-- Sebastian

--ih2y3nxf44lhwvys
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBGaWAACgkQ2O7X88g7
+ppgChAAiUAkVXfQ8/hDdjX4PyH37/8uuJlP7ZBhl9dsd0WNX/Jy+9oqCMldY3Yw
xuGeGDsA4MlV/0/RtQHl0Rv5UDnvDbmA5nzPbFY9uZeMvn1NGkc2Ohu2x0hqVEka
dvNMTS9hoFGvfc/7nR46rUjSroPAaVKywvvny7SypO+DVKI4OpJuetsqM8UhwpwU
Fhl8jaEFv/98jl68Il21nH/DqjtNubpxi1lL1jiq35c/wy1m90GQbn3l7fZ9wcvZ
8rFP1JiH0EUXsmx/8R6yH24WutJ8bVEJtn4ogvR+i+ByEJUtYv89TkyTQpeme+vU
8M8brVrfA8tRaH3ZIOBj1kIQGya4fAdXIeZFyr0oWXru6Cq/rgjAd/DD6aJUSDa9
C3xsEofIYgW1qfTSs0yLd7CZsQxwPbqQrvUfrgF0seF4QiTyWXOZFwCrYoFrEMcA
iWuxN+Buq8NCMuegUIR0vA5w5U9cXJ4F72RWtW72V28gozMLxw2a84xez1lgHpUE
FVlei10zZVrxMG8r24BvwfPhbzxoI/kkxMNJpIW1jukHnpcAPVKNRth41XwX+kg+
0H2V2Xzm2KepVx3+wmTmaG0U9rbrYbKVESt1rT6Du+gDdBaqSfFm7IhoGcTLjSm9
xYtu0zsr4vvPc5q5hCtH4FWYFKoPEix1mMowSrH7AEJfICEOxlU=
=Zolk
-----END PGP SIGNATURE-----

--ih2y3nxf44lhwvys--
