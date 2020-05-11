Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3451CDDE3
	for <lists+linux-pm@lfdr.de>; Mon, 11 May 2020 16:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgEKO5E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 May 2020 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgEKO5E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2020 10:57:04 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33409C061A0C;
        Mon, 11 May 2020 07:57:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 19A532A1856
Received: by earth.universe (Postfix, from userid 1000)
        id 01FF53C08C6; Mon, 11 May 2020 16:57:00 +0200 (CEST)
Date:   Mon, 11 May 2020 16:57:00 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: Re: [PATCH v2] dt-bindings: power: Convert bq27xxx dt to yaml
Message-ID: <20200511145700.lnytcr747snnolya@earth.universe>
References: <20200507183013.27261-1-dmurphy@ti.com>
 <20200510161721.257vprq6rqp64wu5@earth.universe>
 <fb9b240e-9bfe-1295-6fc4-700d886ea7c9@ti.com>
 <20200511143241.nmkti7meahvj2swt@earth.universe>
 <8674289c-038d-d811-4786-322d66072527@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lpudqiluygphtdpr"
Content-Disposition: inline
In-Reply-To: <8674289c-038d-d811-4786-322d66072527@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lpudqiluygphtdpr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, May 11, 2020 at 09:29:59AM -0500, Dan Murphy wrote:
> On 5/11/20 9:32 AM, Sebastian Reichel wrote:
> > On Mon, May 11, 2020 at 07:25:06AM -0500, Dan Murphy wrote:
> > > On 5/10/20 11:17 AM, Sebastian Reichel wrote:
> > > > This needs is missing the power-supplies property. The N900 DT
> > > > contains a bq27200 referencing the charger, so it should fail the DT
> > > > check without the property being listed here.
> > > Hmm.=A0 I ran the dt checker specifically on the binding and it did n=
ot fail.
> > > Unless I need to build some other DTs as well.
> > > Either I will have the power-supplies property
> > I just tried it myself. The problem is the way you are specifying
> > the compatible strings. This is the parsing result:
> >=20
> > enum: ['ti,bq27200 - BQ27200', 'ti,bq27210 - BQ27210', 'ti,bq27500 - de=
precated,
> >        use revision specific property below', ...
> >=20
> > You can see this in Documentation/devicetree/bindings/processed-schema.=
yaml, which
> > is generated by running the check. The compatible comments need a # as =
separation
> > character like this to generate proper bindings:
> >=20
> > properties:
> >    compatible:
> >      enum:
> >        - ti,bq27200 # BQ27200
> >        - ti,bq27210 # BQ27210
> >        - ti,bq27500 # deprecated, use revision specific property below
>=20
> Well honestly not sure why we need the comment either.=A0These are pretty
> self explanatory maybe we should just remove the additional comments

Fine with me.

> Any consideration on just removing the deprecated values?

Let's keep them with their comment for now. Removing them should
start with marking them as depracated in the binding and generating
a runtime warning in the driver, so that people become aware of the
problem. At least for ti,bq27500 we have mainline users At least for
ti,bq27500 we have mainline users.

-- Sebastian

--lpudqiluygphtdpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl65Z7cACgkQ2O7X88g7
+ppqdA//cnVvZhzbdTYQtJef4RbEImz6Dpb4yaZQRsYl/Kvnht05IlpKVHdUeuMm
i7TpqGuLK3s4PRLXERKcwT1wcr3glgES2anoxu6lobL1fojvABRjoBr+uleByPH6
QKh87h4Ink/IcPvoJ1Ce0wOZ+9gBrXVjUjylKaLKtq536sz2HTqavd3JAMN1FDeO
YRalhlyvoWBz8e0EigqdiIvxlihn+VKvDJSO2pzRcEHFdrJPvlt5whEUtZnNMo4Y
+GzfXEY1ycU8kgJ3LXZNBdvGUivfABZpj3T/tuWPp81xB6s+Cfrh0/Qh9WcJ7bx8
jeNcesEqoURB2SDIqx6arAYt8+jHm4Pz/azqTP6zOpNGpEWunVdU/VkoCicirw6P
zXmxVkpwLuQfb3TOD/DHwg66AcIBa8ZRMWrTxZXKb5XMrITbFq2Yn8Z0KFaa0ffC
AgA7SsqRxBgfsVQF/867+10O54bzlRhDkBZJN0G/m6+hTIg1C5xu7f3Full4u8XC
oXzRU06DTLdAXHW40DBNaGF8/yMUAkYZ3RKc2aP+c/HRm3PEOlYb/wYBwdTVb7FF
Yzspxp5CpZUXsIpekoae+RXw72uqhDNMdoni6v90JfZ2Ior90OGuyiB55cSCW1at
xHl5rOK5HtyXPefmsn+MbrC+JAloYaCHuQ3OF/5tRUOaDOtIuOs=
=oLwa
-----END PGP SIGNATURE-----

--lpudqiluygphtdpr--
