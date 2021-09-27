Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDC041944F
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 14:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbhI0Meu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 08:34:50 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52500 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbhI0Meu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 08:34:50 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 65BEA1F4269F
Received: by earth.universe (Postfix, from userid 1000)
        id 00C0F3C0CA8; Mon, 27 Sep 2021 14:33:08 +0200 (CEST)
Date:   Mon, 27 Sep 2021 14:33:08 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: max17040: extend help/description
Message-ID: <20210927123308.34bsk7u7sdxy7hzb@earth.universe>
References: <20210924122408.101323-1-krzysztof.kozlowski@canonical.com>
 <b71b75c7-966c-7452-907e-44ba0a56964b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itupn4mizyc3g5aw"
Content-Disposition: inline
In-Reply-To: <b71b75c7-966c-7452-907e-44ba0a56964b@redhat.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--itupn4mizyc3g5aw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 24, 2021 at 03:06:46PM +0200, Hans de Goede wrote:
> On 9/24/21 2:24 PM, Krzysztof Kozlowski wrote:
> > Reorganize the Kconfig driver description and mention all supported
> > models.  This helps when choosing drivers for given system.
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>=20
> Thanks, series looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>=20
> For the series.

Thanks, series has been queued.

-- Sebastian

--itupn4mizyc3g5aw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFRufwACgkQ2O7X88g7
+po6jhAAkbJ8Gk5eJY4pidW/5XeibJDxFJsGgoMc0ez3V78zDZwzLlGZ32ze+mVp
iSsdJDWf76flg41q6DjzZpYQRJ1eR2c+9LrHY6Hepk3pYwML0brlfxWys1rU/aKn
qqt8s84OXpLiKitaGsb21iUxFHLBR13apX/P0zTZg5cbY5oVxaB5pkMEheP0MmMW
4rAG8xUQnRmUAgU1FGAsxsZUnjPRYUIOD5CGdXzLQ3IySLkgdC5OqAR0KIW6h7/1
crAFTP8cD9lta6gHxV5/FJzMNEhGyaX5ZGuIB5pznGVgLQSErO/RUBZJZQxAr4Vt
rueUXKTkdIoms29V7B4n9Rg2eGdWC1PwRN/Uag7QbXQG5o99K+abHgIURw4KWwKt
WVQuIhkUpaqCHRwvB9zbCmvXoNSvIFwmTo7EwA61l4dXe1PUWmhk8/Ff2txPu5b2
AXdKCZIRvijG08o1Ucf6yhSjrkX8iUkc73o4hzSO8ugDXKi9my0HjR4s8b6MBdlT
Re6AZIx4FStH07/+la9brUP5XCo5WQxlhm0nwF43i8ep01EaFkVfn9q+5DFY0Z3H
lsNYUlthXEqMnR3sIvqYkjU4qW3zSdft1rtep1RI1utoQuYGHGmsmxO+eRUyOrML
Bxww4/6MNUgsFF+rfuZSVZI83nuU6IBwMDTowEQfyCch8HeWFQo=
=hDI8
-----END PGP SIGNATURE-----

--itupn4mizyc3g5aw--
