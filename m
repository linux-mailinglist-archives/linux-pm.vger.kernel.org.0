Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772203EDACE
	for <lists+linux-pm@lfdr.de>; Mon, 16 Aug 2021 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhHPQWn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Aug 2021 12:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhHPQWm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Aug 2021 12:22:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364A9C061764;
        Mon, 16 Aug 2021 09:22:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 86B9B1F412B4
Received: by earth.universe (Postfix, from userid 1000)
        id B35603C0C9B; Mon, 16 Aug 2021 18:22:07 +0200 (CEST)
Date:   Mon, 16 Aug 2021 18:22:07 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Heidelberg <david@ixit.cz>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v6 05/12] dt-bindings: power: supply: smb347-charger:
 Document USB VBUS regulator
Message-ID: <20210816162207.v4ka4vtuajf5jpb6@earth.universe>
References: <20210731173842.19643-1-digetx@gmail.com>
 <20210731173842.19643-6-digetx@gmail.com>
 <20210806211314.sfjl5jke27hz3jj7@earth.universe>
 <dce19bb0-216e-bcd7-3db5-b2c074b4ca47@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="erjfwqt7yl2kd7cr"
Content-Disposition: inline
In-Reply-To: <dce19bb0-216e-bcd7-3db5-b2c074b4ca47@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--erjfwqt7yl2kd7cr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 16, 2021 at 06:39:09PM +0300, Dmitry Osipenko wrote:
> 07.08.2021 00:13, Sebastian Reichel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Hi,
> >=20
> > On Sat, Jul 31, 2021 at 08:38:35PM +0300, Dmitry Osipenko wrote:
> >> SMB347 can supply power to USB VBUS, which is required by OTG-cable
> >> devices that want to switch USB port into the host mode. Add USB VBUS
> >> regulator properties.
> >>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >=20
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Sebastian, you can pick up these patches into the power tree:
>=20
> dt-bindings: power: supply: smb347-charger: Document USB VBUS
> regulator
> power: supply: smb347-charger: Make smb347_set_writable() IRQ-safe
> power: supply: smb347-charger: Utilize generic regmap caching
> power: supply: smb347-charger: Add missing pin control activation
> power: supply: smb347-charger: Implement USB VBUS regulator
>=20
> The reset of the patches could go via the Tegra tree. It's probably a
> bit too late for the Tegra patches since Thierry already made 5.15 PR,
> but should be fine for the power. Thanks in advance!

Queued now.

-- Sebastian

--erjfwqt7yl2kd7cr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEakJ8ACgkQ2O7X88g7
+ppCOA//Uim7ycc5jXS9N7YcXL7DOj+86gG/dde8tv/tLAtvEWcyZvRNsJqO/P4q
jF8rSsiOytZ6PZi7swIU+/lBUIs2sVAY55+GGFAxMAf8ZVWu4b0hUHiMdrCAL3BZ
CCRP5NNT8HNQOetJ5Xt8zjpiBCZFy5OXim+F+JQF8w9H23co7DS1Fx2IjWJwulAF
5uwxEB5Hy9FxosI97g7LFKR37Qe2NwNNSxW3q9wDRqNri5HP64frhOut/tT6Wnmn
t1S1WD9m/JsP1QA9cofXKKF9enhXCdzLnDEWUqcZZol3cDm+LGsMdAnHCPmcsfJ+
iQpIXtJec6je5pPQpd9nbS/UlriErZSfoGEKrnIVTYLV+qOI+gY1Y0bt33HgChBy
LOnmVUTuBxGD2Za1pPray1bEeAV5hQI+H5BtWqar5Dk/xFsBMFMnxWymQn/bkD7j
GzI0daxC2IAaSIexsfoPnv1gM6DMrlV1Zuv1rpmaT3r/XV3Pk+FgnGifwW9R3CEW
KrDTTTKe48TxtNv92B+8WynRN1y2YBhAjuPtyvBOgVe7ohbphWAqjdYX+dBBi2mC
kjWfXAMTunUjnIkO3ik06UsC+h8+WMKwIwNb3zLbsp0COv91+bZi/O/gaQokvqmU
OTEYff6rwW/cuLzKptXhEwT61Q52jdbS44NSBcFv/kpLC9vgVwQ=
=AMiA
-----END PGP SIGNATURE-----

--erjfwqt7yl2kd7cr--
