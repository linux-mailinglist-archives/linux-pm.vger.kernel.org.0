Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736E53451F8
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 22:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVVne (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Mar 2021 17:43:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40188 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbhCVVnB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Mar 2021 17:43:01 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9AF1B1F40E9F
Received: by earth.universe (Postfix, from userid 1000)
        id 5631F3C0C96; Mon, 22 Mar 2021 22:42:57 +0100 (CET)
Date:   Mon, 22 Mar 2021 22:42:57 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCHv2 00/38] Convert power-supply DT bindings to YAML
Message-ID: <20210322214257.3u6dkmygygnewpyl@earth.universe>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <CAL_JsqLASixNRTf712201w1nghxdaB28HsN7fdsjeogsoA=oQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eizakvp3oo4pli3f"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLASixNRTf712201w1nghxdaB28HsN7fdsjeogsoA=oQg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--eizakvp3oo4pli3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 22, 2021 at 10:25:49AM -0600, Rob Herring wrote:
> On Wed, Mar 17, 2021 at 7:49 AM Sebastian Reichel wrote:
> > Sebastian Reichel (38):
> >   ARM: dts: motorola-cpcap-mapphone: Prepare for dtbs_check parsing
> >   dt-bindings: power: supply: cpcap-battery: Convert to DT schema format
> >   dt-bindings: power: supply: cpcap-charger: Convert to DT schema format
> >   [...]
>=20
> Thanks! For the series:
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

How should we proceed with the DTS patch?

a) Tony takes DT through his tree, I take all YAML files through my tree.
   The verification might be broken for some time when being merged
   in wrong order. Looks like there are already quite a few warnings
   for in-tree DTS files, so it might be ok to have some more
   temporarily? It's obviously the most simple solution.

b) Tony takes DTS and the cpcap related patches through his tree;
   I take the other ones.

c) I take the full series through my tree.

d) I can merge the DT through an immutable branch and provide a PR.

I'm fine with either way.

-- Sebastian

--eizakvp3oo4pli3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBZD1UACgkQ2O7X88g7
+pp7lg/+PMI2OqAClTyTcBLzklUXDO2wu34sTaXoEdZ/Oo2KnPULp3+kPPb3nslF
nDXv6CpHuB8vyA5qvP8YvEVs4J2Wc4J4ZYvYlBsIaYbUUADwiHDANTTBySDOOg+p
oSpWMo9HooDD3w8Hq1wojldixeOI6WZmMFXCr5AqTxIVz/iCs2jjGjhYYsdATqUF
vAFJjGX0ICANhdWg9WxTnKElJ63vvPlDUmp9dQ/sfA+V27ws8zNqLjchv0h2Ifsa
71LCB1JgcveG5P+NYxPa9ZaOeGYlZgDXp41DuRsZMrEJ81R82jsUa3zhWEHjhw1Q
YVAjkbDFUykx041GOgLX78tTMhlEyK87RcncjlnIgxv2Hh6CjG3PswPS/vmtufBP
MgtCzTH084q9e+dPK01Hu79FORWnP8nkRBHSSxiMJF1cbZ89vMR36Yh9y4sNkBk8
MVg/tqenmPNYOsaltyQcRa7ApkAtaCjpzqG0m5Fk89ErqCDyZjtF8ujalZV6TQxs
rtVMYBRWW/5cAYbFn/F/S2mP61RtGXBjBmHoylhdBrnCq5FHBUcuFlOgmS8BYZHl
E26Wb9pZryWC5VWGhBrmHto/dsT93O6lBhk5+ZsbdgWfT4YZ13n9mmoRmSexJWlU
ckVZi/fnbtC2bmb3PKYwGcOmpoAEPfIL0u2CDxBQ+YvKCpuU574=
=ImNM
-----END PGP SIGNATURE-----

--eizakvp3oo4pli3f--
