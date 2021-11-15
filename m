Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EDF450831
	for <lists+linux-pm@lfdr.de>; Mon, 15 Nov 2021 16:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbhKOP0S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Nov 2021 10:26:18 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53734 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbhKOP0L (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Nov 2021 10:26:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F110C1F44DD6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1636989795; bh=96pwfBhib6AtAt1+NSZ8dfT793UJUl/HGScVnPW5RqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=InkUKeJ8aRbJILrGO7p4UvygSiFVuq4lgsceJ/wInfPIOrGRpdmESSgXfTxFTgheW
         +/fe2+zETZjJO1kRlzzxbYj0KcMoVXIfZp0Id5ZtykXqyMhtQP9T7U8FUnl7ywDUph
         aAiDmTv5wmPWN9TpY3qIFfcP2EwRrGlkttRIff7pAI0bupu9n77Njqdv4Kl+OJoL61
         r+naLVUTfEvw+EaBnETFSlV4ZNiuw/f4BG7TJXFaF4yx5hQQXbeYN1nq7RkJnvQxGK
         tZV71opzDgXIQyS8Yv09hy1ZIzsiuhu1TD5aJWRzTVqY6PdKZZS+ICArhapedDth+K
         v/dlnnUVSFk2w==
Received: by earth.universe (Postfix, from userid 1000)
        id 601CE3C0F95; Mon, 15 Nov 2021 16:23:13 +0100 (CET)
Date:   Mon, 15 Nov 2021 16:23:13 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Yauhen Kharuzhy <jekhor@gmail.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] bq25890_charger: Enable continuous conversion for
 ADC at charging
Message-ID: <20211115152313.5ls7asfwuj4eclzb@earth.universe>
References: <20211107202001.54579-1-jekhor@gmail.com>
 <20211107202001.54579-4-jekhor@gmail.com>
 <3414874a-3dd0-24b2-92be-f59392dba810@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5p4k55ebvfjneoh2"
Content-Disposition: inline
In-Reply-To: <3414874a-3dd0-24b2-92be-f59392dba810@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5p4k55ebvfjneoh2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 07, 2021 at 09:48:38PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 11/7/21 21:20, Yauhen Kharuzhy wrote:
> > Instead of one shot run of ADC at beginning of charging, run continuous
> > conversion to ensure that all charging-related values are monitored
> > properly (input voltage, input current, themperature etc.).
> >=20
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
>=20
> Thank you for finding this! This explains why all the ADC returned
> values like current_now where 0 when charging, I thought this was
> just something which was only supported while not charging, heh.
>=20
> As before, the patch subject prefix should be: "power: supply: bq25890: "
>=20
> Otherwise the patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> Sebastian, this really is a pure bug-fix patch, any chance you
> can pick this up for a future 5.16-rc# pull-req ?=20
>=20
> Regards,
>=20
> Hans

Thanks, queued to power-supply's fixes branch.

-- Sebastian

--5p4k55ebvfjneoh2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGSe2EACgkQ2O7X88g7
+prhAg/9EZFrg1lNoAOmRw7NjQ6TGZBWATtk3Oz8q/E6SV80NCJYm18u5ZzPdI/1
2GJdMliZqPj9Nt8mHRuRDmQylFZresXkOaZb/yJmHXugU0H8ul2LkONYkdfOithF
V7VLkM4MdNnXtAU5tmr2JilDVKNih6WT4GwvRQDwndU4pdjRnl2vwJ05NDry4cuA
OEqI/FCo4S16HtjbX1CZ3JOCkNW23a7RoMuUD2fe/1mtHo0SaMdv391sbMzb4jHa
uM1E/viJXYxaeBq+ftPegQILoLfkrSJX/KCJLHHPx0wQTZmGqd3zRnPtZkTBuNry
I+nfLXDy8BmsOxO8qwZpBlXsrczDBpwMNjWZfLYcDPswIcZ9Re2KA6EEwdTIVBNr
xiELKAww8M6Jr4Ii4Lf/OnmiV3UCoxh7tK1lG99pAI2nJIdsotgs87lVohvJl4rV
/OOQmsLcMjDzk9UU30pyKn7jPMn1GxeRfHuqkfVNt1XzyWd6v81VlBMp+DRzK0yr
S3XDPkjlyFpQRLID9ZDilxIRVAJvRUrecoY8F7OAHZ7Ak49d3Bl3qxc6DQqM3RYu
3F3JgqrQJQj4hRBZrS7a65ZJXXzI0hKTEpx5NfsMHqOQVZLrytVPVKhzwZlBNKCE
h06hPyU7unZp2+UA0hhlDIVBgJzD/aIXcmlSpMgy+SKCGeOJBGQ=
=/hbq
-----END PGP SIGNATURE-----

--5p4k55ebvfjneoh2--
