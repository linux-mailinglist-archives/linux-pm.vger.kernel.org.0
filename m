Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2292F1CDD4B
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 16:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEKOcp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726173AbgEKOcp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 10:32:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD8EC061A0C;
        Mon, 11 May 2020 07:32:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id A41E32A17E0
Received: by earth.universe (Postfix, from userid 1000)
        id 921DF3C08C6; Mon, 11 May 2020 16:32:41 +0200 (CEST)
Date:   Mon, 11 May 2020 16:32:41 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: Re: [PATCH v2] dt-bindings: power: Convert bq27xxx dt to yaml
Message-ID: <20200511143241.nmkti7meahvj2swt@earth.universe>
References: <20200507183013.27261-1-dmurphy@ti.com>
 <20200510161721.257vprq6rqp64wu5@earth.universe>
 <fb9b240e-9bfe-1295-6fc4-700d886ea7c9@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gonlqgai5ywifdkl"
Content-Disposition: inline
In-Reply-To: <fb9b240e-9bfe-1295-6fc4-700d886ea7c9@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--gonlqgai5ywifdkl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2020 at 07:25:06AM -0500, Dan Murphy wrote:
> On 5/10/20 11:17 AM, Sebastian Reichel wrote:
> > This needs is missing the power-supplies property. The N900 DT
> > contains a bq27200 referencing the charger, so it should fail the DT
> > check without the property being listed here.
>=20
> Hmm.=A0 I ran the dt checker specifically on the binding and it did not f=
ail.=A0
> Unless I need to build some other DTs as well.
> Either I will have the power-supplies property

I just tried it myself. The problem is the way you are specifying
the compatible strings. This is the parsing result:

enum: ['ti,bq27200 - BQ27200', 'ti,bq27210 - BQ27210', 'ti,bq27500 - deprec=
ated,
      use revision specific property below', ...

You can see this in Documentation/devicetree/bindings/processed-schema.yaml=
, which
is generated by running the check. The compatible comments need a # as sepa=
ration
character like this to generate proper bindings:

properties:   =20
  compatible:   =20
    enum:   =20
      - ti,bq27200 # BQ27200   =20
      - ti,bq27210 # BQ27210   =20
      - ti,bq27500 # deprecated, use revision specific property below

-- Sebastian

--gonlqgai5ywifdkl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl65YgIACgkQ2O7X88g7
+posWhAAoqCX7rzM0wCNRMFqSMsFexYyyWQ7Tb5GYEH2eMIB8vqf6So+9KX5SSky
sDR4hXP0shO9Q/4EIXj/JyLlOAlulH8zrpuI6F44HHlt/bkPsFx7mV7Fk8LP/VTb
HrYFcZgza8Oa5bhNCnISS6yZTDi0BhIsqJnvVrTa+FbtcOsJQsUUecqUbYQDOgXL
cWDzjNtf+NzULVzk5gRDOz3WUMqNVlADb+3wnAOiY7OcLsW4B+1PKii5JeY6oI+D
Rm0zgttHKL4xagPrHRT29XVnhPs8G4IyevpIWLZodHeYvYo5jBYfQIxi6XFEsYIn
BOKq0fL4EuR6a/L9IDYZGnb0+lu9QWbHQ8SMVN/B5NOaLPG7tLf6kKPovbfIcEJB
RI/L+hvPllmQop4/VZ1ye0qXkuYd+2NQNXIYg2mfc+tKsT7IOQs2WF61XjG/xgws
lROSvCXrU345/LRDS1tldydmalU+aAhiFm0lZXape6gdARoJsGuwOkmTpC4m6SOm
rFU38S+qukE4weLdZQtL9nzw38ckjY9x/BwJjQGV0J3dnUHEjCnI9jYgEdoguRCG
iBjqz5mVCqFgtmfefpdk1Jor/wWBUU/XsLexn/IJMCefU29XWA3HHfGIsVlecu8v
ldXWlJ78Qj7NSyoF+6LjtH7hvWq8wMEApbgcU2L5cNkrFaJDWYE=
=h6cH
-----END PGP SIGNATURE-----

--gonlqgai5ywifdkl--
