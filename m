Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D037F33D939
	for <lists+linux-pm@lfdr.de>; Tue, 16 Mar 2021 17:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhCPQXd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Mar 2021 12:23:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42918 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbhCPQWb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 Mar 2021 12:22:31 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E112A1F448E2
Received: by earth.universe (Postfix, from userid 1000)
        id 8F7163C0C96; Tue, 16 Mar 2021 17:22:27 +0100 (CET)
Date:   Tue, 16 Mar 2021 17:22:27 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>
Subject: Re: [PATCH 08/38] dt-bindings: power: supply: bq24735: Convert to DT
 schema format
Message-ID: <20210316162227.jzueo7cowo6l6isv@earth.universe>
References: <20210312154357.1561730-1-sebastian.reichel@collabora.com>
 <20210312154357.1561730-9-sebastian.reichel@collabora.com>
 <CAL_Jsq+i=sB7nDzBeF3nRa8FuM_8v=P2SMXQ5XNmuP3b615CKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n7dmtxlqxosh2w67"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+i=sB7nDzBeF3nRa8FuM_8v=P2SMXQ5XNmuP3b615CKg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--n7dmtxlqxosh2w67
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 15, 2021 at 12:24:09PM -0600, Rob Herring wrote:
> On Fri, Mar 12, 2021 at 8:44 AM Sebastian Reichel
> > +  poll-interval:
> > +    description: |
> > +      If 'interrupts' is not specified, poll AC adapter presence with =
this interval (milliseconds).
>=20
> Needs a type.

Ack. Just out of curiousity: Do you know why this was not pointed
out by dt_binding_check?

-- Sebastian

--n7dmtxlqxosh2w67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBQ20MACgkQ2O7X88g7
+pp3oQ//ZweRKl1A3rsPG11nw4lfVHgUP/DsB2mF+4kJM/MVAf/4tiD2KPY0Hvk/
d+VjK7KG3aKcEJ7rJIx/AI0cXlACCCz3/qhXhmaqWGZmI8zNlqKDLuTU7Pr8cDs7
l6JcaJ7ieSPwfaQeCljZ/aB+NRVf6FvENPoH+uqCKqIV+w9XPsMAgHd34cMepoVO
tCNzG2Y5BEJPY8kdPMX7nIsQ0xQRRrHXnnR3qB890KiZ+ym4sE3blyu9WVPbSKSI
Mqbsg7zV4wpVzZ6bjinDFXj8YERlgeLjcLkudsFsjQ4AsVyUaSuf8x0THmXUmNJU
F1pfRRpWMa+aDlUYXBCc9AEkJH6XUnELr2iv4UvbNI+1tAFZC/YJIPqvDx3V96bH
NP2Ei40c2JnPEOPNm6Bfcyd7ncetmLN4ezaT39/MHrBIqu7W0NL8O0cx8jg3Omoo
8o5D7U4ph94ZVGhkfNL5obps4IC40uXLSHiZtLgzdTvHZJOIaXPjENtsTixheKdY
uDcDAz0HhTU2xI9XQS++4FRAirla8txtdiI2Y4sXVGETjR/gpZNLQZ5JueDMuhTF
tY0TOrRqRsdekRKhas3PP0TIcFwof5yLYuVKSN5EMQEpgDsmABCzVrmwSk0UkESV
pZUFOPBftPT9XZKDkaLGrbX4Lwwslh5IKgsiVxmKgy1+xPxvzpw=
=ba+0
-----END PGP SIGNATURE-----

--n7dmtxlqxosh2w67--
