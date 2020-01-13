Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D32E0139A5F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2020 20:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMTyk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 14:54:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:45416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728512AbgAMTyk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 14:54:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5FFCAACAE;
        Mon, 13 Jan 2020 19:54:38 +0000 (UTC)
Message-ID: <9a69ed8892ad7ba8bb38cc96bb781432e8218d1a.camel@suse.de>
Subject: Re: [PATCH V5 0/4] ARM: Enable thermal support for Raspberry Pi 4
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Date:   Mon, 13 Jan 2020 20:54:36 +0100
In-Reply-To: <fee791c9-afdc-fd3e-2ab9-d5e45e23f7f0@linaro.org>
References: <1578941778-23321-1-git-send-email-stefan.wahren@i2se.com>
         <250b15ef-636f-d964-3eba-0067c07e5a9c@linaro.org>
         <4a2b7974-db0f-bd0d-21f5-ccdc0ad2bc30@i2se.com>
         <fee791c9-afdc-fd3e-2ab9-d5e45e23f7f0@linaro.org>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-FDWcctfo8Ek2gLiRNQ/T"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-FDWcctfo8Ek2gLiRNQ/T
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-01-13 at 20:24 +0100, Daniel Lezcano wrote:
> On 13/01/2020 20:20, Stefan Wahren wrote:
> > Hi Daniel,
> >=20
> > Am 13.01.20 um 20:10 schrieb Daniel Lezcano:
> > > Hi Stefan,
> > >=20
> > > how do you want the series merged?
> >=20
> > i'm not BCM2835 maintainer anymore, so the final decision is up to
> > Nicolas or Florian.
> >=20
> > But if i can make a wish, it would be nice to take as much as possible
> > via the thermal tree, because Nicolas already sent the pull requests fo=
r
> > 5.6.
>=20
> Ok, I can take the series if it is fine for everyone else.

Sounds good to me. Thanks!

Nicolas


--=-FDWcctfo8Ek2gLiRNQ/T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl4cyvwACgkQlfZmHno8
x/5MsQf9FaeEislffa+3ktu4lfHtF7FI7qha+TqSexWbULp/KR+FqxLUwGgYtMxk
8eWvp3HnWKM0Zu84LODrnkElT7llhS7ZuaCXi8kEqFPQRer6lKlO6L+qcVvwm0F+
7dluGuHS3LfByHXO0XWAGI1ySijeZz5T6eQwiJQNOx49e86yEli/KJUDImrNHqIV
sZZ5f3XsBSAjwV/V0LD1BzXgoNlijVueLOeMgdsHRrexIpGzJl5EcRpTvrQ493nR
QwVhvyrRuC9YhbqIzTYNL/yBzbMOs9RRi9xyMG23qJ8ui29Lbnotk1MTn1XZEAH/
BXo1OWkWzrkuWOv0mHHYxkd59Qu3DA==
=/pF3
-----END PGP SIGNATURE-----

--=-FDWcctfo8Ek2gLiRNQ/T--

