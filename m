Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE92018FE
	for <lists+linux-pm@lfdr.de>; Fri, 19 Jun 2020 19:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387492AbgFSQ70 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Jun 2020 12:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733192AbgFSQ7X (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 Jun 2020 12:59:23 -0400
Received: from earth.universe (dyndsl-037-138-190-043.ewe-ip-backbone.de [37.138.190.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8329920732;
        Fri, 19 Jun 2020 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592585962;
        bh=QEJdhbyOnUeWnbiax7tEKQNwOmTqMXZxzYWiYDljOAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rc08OG7D16Q+Qsc7/RAENh215Af16ZgDPa1+QMKIaorAqjZhzP5mGriSZXLjtkJw6
         1YNgR5WVE3LnPmPRGsZ+aV2PhLuwQ91vqZBwUsgy87XKuk1YtXI1Dm4Alk17rkTsF+
         zmFx6UCBLMQdexsgelPF57I3Pd8nJdRWd+CHwjqU=
Received: by earth.universe (Postfix, from userid 1000)
        id E05493C08CD; Fri, 19 Jun 2020 18:59:20 +0200 (CEST)
Date:   Fri, 19 Jun 2020 18:59:20 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     =?utf-8?B?RnLDqWTDqXJpYw==?= Pierret 
        <frederic.pierret@qubes-os.org>
Cc:     linux-pm@vger.kernel.org,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Re: dummy-psu
Message-ID: <20200619165920.q6oj4w43rqxhoqlp@earth.universe>
References: <a8223cce-636f-578b-7304-eb0e4868e018@qubes-os.org>
 <ccb6ed3d-db27-1648-d4bd-94efc8508e41@qubes-os.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p3l6wfpc2mhxb4vz"
Content-Disposition: inline
In-Reply-To: <ccb6ed3d-db27-1648-d4bd-94efc8508e41@qubes-os.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p3l6wfpc2mhxb4vz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Fr=E9d=E9ric,

On Mon, Jun 15, 2020 at 06:44:11PM +0200, Fr=E9d=E9ric Pierret wrote:
> On 2020-06-05 16:02, Fr=E9d=E9ric Pierret wrote:
> > Dear all,
> >=20
> > I'm working on a kernel module currently called "dummy-psu"
> > (https://github.com/fepitre/dummy-psu) which creates a power
> > supply AC and a battery like in
> > 'drivers/power/supply/test_power.c'. After loaded, this driver
> > allows to modify integer values of the virtual psu created
> > through its sysfs attribute directly. String values are
> > currently set through module parameters. Such module allows for
> > example to test ACPI tools or desktop plugins.
> >=20
> > In the context of the Qubes OS project, it allows to setup into
> > a VM, PSU components with real information coming from the host
> > system battery or ac with some refresh time.
> >=20
> > I'm writing to you to know if you would be interested to have
> > such module integrating side to test_power.c.
> >=20
> > Another name could be "virtual-psu". Any kind of improvements
> > are very welcomed. Thank you.
> >=20
> > Best regards,
> > Fr=E9d=E9ric Pierret
>
> Dear all,
> Just a little ping to know if anyone has been interested in this
> project.
>=20
> Best regards,
> Fr=E9d=E9ric Pierret

I think it would be worthwile to have something like this for
the power-supply framework. This is useful for your VM case,
testing the power-supply API in a better way than test_power.c
and for peripheral devices with userspace drivers.

But I don't think it's a good idea to use the sysfs files as
input. There should be support to register multiple virtual
devices (e.g. battery and AC in your case, or multiple BT
peripherals). Also the sysfs interface does not allow you to
change multiple values atomically. I think the proper way is
to do it the same way as uinput and register a miscdevice.

-- Sebastian

--p3l6wfpc2mhxb4vz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7s7t8ACgkQ2O7X88g7
+pqNBxAAqR7gsWc1eqWZy+pdYSatISZVSQLZ29aIF7hBb/0JBE9iiFUTUQPM7ETn
+mIXrauWPHuCc2b5nEJvFVga8AYCnTUw7dlzmOs5epPWs9A/di2fwzVBYsdZb7Fo
FVtNs9CtYCPyqJH6Vw6lj4krYdfEAQmdU+MNp+FIlrl2/oAhqLGql6cjRwDmkIMp
wgNu6TgjiJ7UHBLMcCxixiyxqNts7eYqXxk8kzT1+kJO2U+24lMmGLi2rkoySox8
XcOQ9/U/Qo5KrjMqBFV+88NhNy1KSoHfAr+v3FQkgnJ0rmHPlZPJ6+L2TgQoPklD
RZru9uYm4X7f4zKpqcJrwkgOioFPYyB0tClNfXKbl/nIpIXSq55Z+RvGholndWjL
D2avhycbltlgJZQQpujrTGS2HEMn+qfr6cpYgKrPJIa1Nttu6CCnfvVHbVECVdpa
jtKUloE8mjLtMJ+P6r/6+zFy4oR1QuBZQT2pk8UVbMyJeG9jhZWQ8sY0H5c4u8ho
n9dC200sOtbRDaRTwCnxTHvYQDylJr7a51PzpnYAVV06yxF9QACLYErAeaazydPd
D5Ekxa5+hHdWTuMNzB0qXeV2JIJE/Vmhvfy7a6fSed91XVRLx/24xnuX7BZdYsB2
s5h2qs/dsFHuaWbO1bM7GSCrzy+wAes0tYARvCAPEgGZnu1klGA=
=G4tF
-----END PGP SIGNATURE-----

--p3l6wfpc2mhxb4vz--
