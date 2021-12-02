Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9043D466905
	for <lists+linux-pm@lfdr.de>; Thu,  2 Dec 2021 18:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376287AbhLBRZK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Dec 2021 12:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbhLBRZK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Dec 2021 12:25:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7385C06174A;
        Thu,  2 Dec 2021 09:21:47 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 040F01F469B6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638465706; bh=qh2JLdc2/XxdWEDpXV64bL1kvfarfDUoYjEGQ03NKvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EV0uCbcQdDZcFBgSmqgYs/WUcmMyYZBKtnOGQQVZswtrnk6Ov7+7y2NPMVnPJcR6G
         QqaDSYTI4oUcMrBaxFxAzYxWb1U9QSy3QrYCb6K4EoBszo4sk3E38y+Fbr09Ky4t39
         RUmuHM2hr6vgd3KA6boqrZ3ve8GOdZALUwjNHf7whmX9hhA/F01JzTMKKxbJSrs51G
         +JaRCw1r7gkJ5pOC6mSMIdT/HFpiLWwsbWriIjnb8HcWxBe2GzxqTzQOooI9lhT4O0
         w+7ZyrryWrCfy6JqU1u27Ia4Ay0kaVvbMH2+Sp9pat+H7SfXFzQB3RJmA6vkYD5wJ9
         B92eE+mNEmyIw==
Received: by earth.universe (Postfix, from userid 1000)
        id 7266F3C0CA8; Thu,  2 Dec 2021 18:21:43 +0100 (CET)
Date:   Thu, 2 Dec 2021 18:21:43 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH RFC 0/3] reset: syscon-reboot: add "reg" property support
Message-ID: <20211202172143.44bwtgiiagczfqlr@earth.universe>
References: <20211102152207.11891-1-zajec5@gmail.com>
 <CAL_JsqL5qJZz8K7330cOhV8x86097LUE7oFNx5Qu3M4XLL+gMg@mail.gmail.com>
 <8f02af47-d9dc-a29d-b839-e10969a448d0@gmail.com>
 <CAL_JsqJB+KneifCaybF7ng0KuwbLgtYk3UMKjkFNOL5Bj8U2pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rb3arto6kdwkg5ns"
Content-Disposition: inline
In-Reply-To: <CAL_JsqJB+KneifCaybF7ng0KuwbLgtYk3UMKjkFNOL5Bj8U2pg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--rb3arto6kdwkg5ns
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 12, 2021 at 04:32:48PM -0600, Rob Herring wrote:
> On Fri, Nov 12, 2021 at 4:23 PM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com=
> wrote:
> >
> > On 12.11.2021 23:18, Rob Herring wrote:
> > > On Tue, Nov 2, 2021 at 10:22 AM Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail=
=2Ecom> wrote:
> > >>
> > >> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> > >>
> > >> During my work on MFD binding for Broadcom's TWD block I received
> > >> comment from Rob saying that "syscon-reboot" should use "reg" proper=
ty.
> > >> I'm not sure if my understanding & implementation are correct so I'm
> > >> sending this RFC.
> > >>
> > >> What bothers me is non-standard "reg" property usage. Treating it as=
 a
> > >> simple (unsigned) integer number means different logic when it comes=
 to
> > >> ranges.
> > >
> > > It shouldn't be. The idea is that 'reg' works like normal. See below.
> > >
> > >> Consider this example:
> > >>
> > >> timer@400 {
> > >>          compatible =3D "simple-mfd", "syscon";
> > >>          reg =3D <0x400 0x3c>;
> > >>          ranges;
> > >
> > > ranges =3D <0 0x400 0x100>; // Just guessing for size
> > >
> > >>
> > >>          #address-cells =3D <1>;
> > >>          #size-cells =3D <1>;
> > >>
> > >>          reboot@434 {
> > >
> > > reboot@34
> > >
> > > Just reading 'reg' is fine, but really, Linux should be either getting
> > > the translated address or have a function to get the offset from the
> > > parent base. IOW, it should also work if you just changed 'reg' to
> > > '<0x434 0x4>'.
> >
> > Are you aware of anyone working on support for getting translated
> > address? Do you recall any efforts on implementing such a helper?
>=20
> All the DT address functions give you translated addresses. It's the
> latter that doesn't exist that I'm aware of offhand. It's just
> of_address_to_resource() on the child and parent nodes and then
> calculate the offset.

Has a new version beent sent with this change, that I missed?

-- Sebastian

--rb3arto6kdwkg5ns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGpAJkACgkQ2O7X88g7
+pp/eRAAm5idb1KmqRkMs2dbt4p4xGRpm0sDiOd+PEEzgt1i77STK69jBrcUUJmT
I5xBbXkyjKpq1M17axa1c66xzuhCoNLUXzkpzSmreagTgOYWETcrlZYD5j6h7A+R
QMJEgRzmiq5p2z+b3bH3658+2D4vaOJFvIzaRuZfyVoulecVX138wrmNQ+cOuTYc
WZlWRJVSgLK0CRbO8ppNkQA7bxgp+5gJyE85ZESsRAZhPI8vePu3CsNz7SU4LeZh
Z00ln0QpTSm4luWAPe22n84by6oh9KsUZ4x7L1l5lmvsQLn5aQi39JMg+424bB4A
ftI8B9lXF9oy7NoR0EGSEhWwb1pTpvn96Mfi/m5N7AwTW/19OvKiA+BMAezSs6zc
mFr4cl1TwNkbYV2Jt8XvYksIOP+hcA0ueU1Xtd12iImZaZVR7yafv652VENF85TF
GsBJ4znkLByhGvAf0a0Eu4dPbG1960pWZc+lRGb0Zeu1u2+HkUCg4rB5+mbssIRl
iJ6gMZ5P+4hLPmvwY9SKphFPW3kTL9kMB6J3ptwwB2YNvjCtmkoeBHJ2kreidYUG
12ILmJKgXQcBu9hBnZBbOa2PsFbMkQPl+nSnozENgYNvQR/qknZwAV9cueGVy359
WFMBfuKBoIj4keWdsX6PYtCCLeHmHqTo9i1ORfTBXrRJFlDCH8w=
=dLER
-----END PGP SIGNATURE-----

--rb3arto6kdwkg5ns--
