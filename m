Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8815CCEC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2020 22:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgBMVGT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Feb 2020 16:06:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgBMVGT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Feb 2020 16:06:19 -0500
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA5CE206B6;
        Thu, 13 Feb 2020 21:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581627978;
        bh=0k7c0ULe1lXlvkdOAK687I5knZOYpG1zM7rIY2J1x8o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjcFDYuU7oTqSD7VBy7dlfHr5pBpgLlsSGrT7NYlbiF7CkKt5HicozhbVP25dJIRt
         SuyfLbjHCVbryrapB6I/Xr2/QmTJ/xd7Cj0KLYO5/I/pX6ImwzSbom8OnViHJQi6GP
         g0iZmm+nimAn13RULqmok03k+KCxkMrAvtCgEHT0=
Received: by earth.universe (Postfix, from userid 1000)
        id 884683C0C83; Thu, 13 Feb 2020 22:06:14 +0100 (CET)
Date:   Thu, 13 Feb 2020 22:06:14 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 17/28] drivers: hsi: Call cpu_latency_qos_*() instead of
 pm_qos_*()
Message-ID: <20200213210614.2n4xbt3wbd6ltntj@earth.universe>
References: <1654227.8mz0SueHsU@kreacher>
 <5212477.aCSzomBNgy@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uu4yb2e2brmudxu5"
Content-Disposition: inline
In-Reply-To: <5212477.aCSzomBNgy@kreacher>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--uu4yb2e2brmudxu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 12, 2020 at 12:13:17AM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Call cpu_latency_qos_add/remove_request() and
> cpu_latency_qos_request_active() instead of
> pm_qos_add/remove_request() and pm_qos_request_active(),
> respectively, because the latter are going to be dropped.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

>  drivers/hsi/clients/cmt_speech.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_s=
peech.c
> index 9eec970cdfa5..89869c66fb9d 100644
> --- a/drivers/hsi/clients/cmt_speech.c
> +++ b/drivers/hsi/clients/cmt_speech.c
> @@ -965,14 +965,13 @@ static int cs_hsi_buf_config(struct cs_hsi_iface *h=
i,
> =20
>  	if (old_state !=3D hi->iface_state) {
>  		if (hi->iface_state =3D=3D CS_STATE_CONFIGURED) {
> -			pm_qos_add_request(&hi->pm_qos_req,
> -				PM_QOS_CPU_DMA_LATENCY,
> +			cpu_latency_qos_add_request(&hi->pm_qos_req,
>  				CS_QOS_LATENCY_FOR_DATA_USEC);
>  			local_bh_disable();
>  			cs_hsi_read_on_data(hi);
>  			local_bh_enable();
>  		} else if (old_state =3D=3D CS_STATE_CONFIGURED) {
> -			pm_qos_remove_request(&hi->pm_qos_req);
> +			cpu_latency_qos_remove_request(&hi->pm_qos_req);
>  		}
>  	}
>  	return r;
> @@ -1075,8 +1074,8 @@ static void cs_hsi_stop(struct cs_hsi_iface *hi)
>  	WARN_ON(!cs_state_idle(hi->control_state));
>  	WARN_ON(!cs_state_idle(hi->data_state));
> =20
> -	if (pm_qos_request_active(&hi->pm_qos_req))
> -		pm_qos_remove_request(&hi->pm_qos_req);
> +	if (cpu_latency_qos_request_active(&hi->pm_qos_req))
> +		cpu_latency_qos_remove_request(&hi->pm_qos_req);
> =20
>  	spin_lock_bh(&hi->lock);
>  	cs_hsi_free_data(hi);
> --=20
> 2.16.4
>=20
>=20
>=20
>=20
>=20

--uu4yb2e2brmudxu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl5FukIACgkQ2O7X88g7
+pqOqQ//RpRCO95YyRcMTmNlCqFgCPcHQlREw9A44Up8RaFsdmuPueMUyiTcMuL7
aZFY1ocvZDw4QUEKZ0k2l3A3fnrf80SafS/tT8muaP/iloYL3AsjfaEFrNmk/fX4
6gf1IJrYDdp6S7fj26cz321Yln8jgpz2fRsJ+O9WGBUYbwAtY8I9XXxw4qZ0jizf
YlMX+9OiJdUTJKhHbJs/bIoOgCYpY9m6hFVhoYmTpBzD6RD746UlAP4Y1XNUR8yL
K7hbxxfKmt24pHoCeIy9gQ+aXHpeKj+d9Id8L9PSxrxdFwH6VmgKoR3ZzKFrLpmS
1ZCOu6oVyC/apJzIJJOf7kRKPfiCxdRdJMItDsYwtVKYPb5EfBmC0btEH5g6IHOA
b7Ue7D+/vM02XzPoYiSoHRoTSzhIQvTtpt176r1GaSL2gVO3Q5BYcfn3N6ho9Y5Y
3q38i/o2raXkR/WSyRjsH6JVVfF/aIXOpGccNXTAgJw6m8DUlthMshbvrAaHdEhF
RL7pdwiPUAKy6Y7Ijn308wMl/tKkz1+KWNde6lpN6KieGfnTX1/8Nut2siw5n0R+
lq45oFMP4aslARb7T5XpxPdN3jk9LyQDghzkEiqVD15BplxPlFba08jcUPIL8UDh
hBYXc8K1p6pu3NOBgGkrYchFasncXGE5WoEuVaifaCFOCBAwh10=
=3487
-----END PGP SIGNATURE-----

--uu4yb2e2brmudxu5--
