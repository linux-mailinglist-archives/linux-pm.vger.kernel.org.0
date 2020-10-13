Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D159D28D638
	for <lists+linux-pm@lfdr.de>; Tue, 13 Oct 2020 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgJMVbm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Oct 2020 17:31:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgJMVbm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 13 Oct 2020 17:31:42 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50C9621582;
        Tue, 13 Oct 2020 21:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602624701;
        bh=vWAc6/uDDUGElUaAfDOKgXveygt5RpMJ7/yFtcLKEsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+XNdCqfTjrU7sQiF0xQDflawlK+bJX5fVJ7TvkZ2H2FupoovrQoZlGLE/cj0DMT0
         kQVQ5LA5bt4RFMAQgXzCWSmbfAevrMUKrmQmApBa/eqaGWPs9+cQL2Z0h66CV+r2+Q
         9A7jIyZ4aN0Zkf8weZkjkLhPE5xcNxvs0EHMOFDU=
Received: by earth.universe (Postfix, from userid 1000)
        id 5705E3C0C87; Tue, 13 Oct 2020 23:31:39 +0200 (CEST)
Date:   Tue, 13 Oct 2020 23:31:39 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: power: Add the bq25790 dt bindings
Message-ID: <20201013213139.rj5vvitgo3znj7fb@earth.universe>
References: <20201009144112.3007-1-dmurphy@ti.com>
 <ac52ca59-74f4-7ffd-544c-4a542e799ae5@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ms7dhtfyoseouiz4"
Content-Disposition: inline
In-Reply-To: <ac52ca59-74f4-7ffd-544c-4a542e799ae5@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ms7dhtfyoseouiz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Tue, Oct 13, 2020 at 01:03:52PM -0500, Dan Murphy wrote:
> On 10/9/20 9:41 AM, Dan Murphy wrote:
> > Add the bindings for the bq25790.
>=20
> Also any updates on this series?

Sorry, It's not gonna make it into this merge window. I did not
yet fully review it and merge window is already open. I can say
you are at least leaking USB notifier on driver removal, since
you never call usb_unregister_notifier() for that case (similar
to Ricardo's submission).

-- Sebastian

--ms7dhtfyoseouiz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl+GHLgACgkQ2O7X88g7
+pp8ZRAAl4dM1MwYHzNCWp8Qdsac8glJJfSk2CeH8pfWMgyOml9Kh4YsQh4C7fFK
cqnE9V/6YVGsD/0GXoM5ptwlnIZxEV2GWqbLiIA1Fo+T/BZuicDiDFJh2fFiJ2ny
SgBfyNzhcJRcrHkP/2QYqZEeInfHiPzdlHPzEFAmif5HCCZdqNHbpA3FXnulW2to
cp7iKTejWCDE50OD7uNcIjPhL7mBLLZZh/JNc08ajhsXI8Aj34iYtCX/foGLy4p3
vaWpM3iZC/C7aeeVN1S2Q/rkEofzGnz9WJNJnPsshyhLpkYrTDnkXR3dTqzgH9U6
Sonb45s79+/ZJW5mR/qCYjQ3ngW+3KhPavH5toodioFxEHQJXcjfGxtlm5xNuxnL
bH15YBlTmGSQNTE8osvXf6O/N+HsmbQ1soqogEZOIhxXOJqsQrXONyWNQGy2822q
QbdonrASURD1C3qVxH5O2+BOzCEK/CikUFaKOpv4/2L5C94BRCOrSj8eXzUWgHXP
u3ZoZeo/V/A588sBU9GVOH1Yr8xI3NGDAg/pV4dHq+P9zpRlAcn7TP9jd0LWzkyh
1BaoLUCNxUnj68ZF7KuoQSlgg8liVru2Qf1nKb/63Q2k4XpfBbjv3W410V1xijqN
blIYlVM3cMFPt1HffizNiSRdRzq9M7JeQ+2fKZoOnxoRxNX9D8k=
=Ykzz
-----END PGP SIGNATURE-----

--ms7dhtfyoseouiz4--
