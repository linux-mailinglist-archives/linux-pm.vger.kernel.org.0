Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 287D9101971
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 07:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfKSGec (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 01:34:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47000 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfKSGec (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 01:34:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id b3so22351033wrs.13;
        Mon, 18 Nov 2019 22:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=STYck0ldpmlPgUWK/QtmnwfKy44OyOjUVjCG3r/tKEs=;
        b=btWLNutlP2kDY/yLaixh/BuLXocKTIXi9Ge/nc2DSdpsZX3wYLJ8Va1hZj8xQh+5ve
         iQ7046zUAQFVSyyc9bYlRZNYXpVAhyfjVCVsoORr8Ght4Oh73ERcgnlCHKs0Is77j/Ai
         7TLjUMW+5IDBBSYBaQoWf55T5ETIK8T5jtd3t92ndP6tm3FvbYhzQFmAHC6d12UHiRt7
         sgy5G2u1jw8Q0iCDYYTPJAsEitOV9NWFcj7tZuzq827+rUhMNDYLN1vlJHgba2WpSZ+n
         m3neIJRvPGUsuRaKNs6bR8d9Uuaq1s6KxKMcb7xqh1zHh/22AixIq62t39PCTiwclEi1
         5Hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=STYck0ldpmlPgUWK/QtmnwfKy44OyOjUVjCG3r/tKEs=;
        b=QOCHNq3fClP1pmZXIBug+HH4NmOCCyX1j21sZWUsgoT3s2K0aOmpOArgr0ke4l2Y8Y
         RRpGPntjfXIxmM6ksJ8zoD46sIAPYfyfTCRHv1mCHPJkNhPkdorypXuKn44WjnUi2Qcf
         AC2I0J04AuU2rMOgjln8FcuAT+OFqh39pMQGnpTCYZIYSXPydM+HdWDBKxRtsyXFPmdX
         KPLdjSK8cHBHkTgmJIJea8xztOf5p9QaBKAc/rA5VP8lM1O0CQUyA11qE67dl93YSk7O
         cdWbl78Kk13RnwMXjR3Vznh0IgnHrJXEFY1BO0PgFFPU+YC9LrR+8IUD8jIZePjokXIK
         1AeA==
X-Gm-Message-State: APjAAAVyjzr7CoxSYIlnIys8MNLrcG3Zj3NQTNg69JT6jnk33NpQKWU7
        PKL2sP3imv6MwORGeR1ptWU=
X-Google-Smtp-Source: APXvYqzhNxj3/SJm0AqF0zMY4b2l3tY6B3JVFHzcm50DLbqWtLqLll98yGl8UaG/HY2uDbZ8yq8Icw==
X-Received: by 2002:adf:f203:: with SMTP id p3mr36441140wro.2.1574145269573;
        Mon, 18 Nov 2019 22:34:29 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id q15sm25965385wrs.91.2019.11.18.22.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 22:34:28 -0800 (PST)
Date:   Tue, 19 Nov 2019 07:34:27 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 14/29] memory: tegra: Add interconnect nodes for
 Terga20 display controllers
Message-ID: <20191119063427.GG2462695@ulmo>
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-15-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="I3tAPq1Rm2pUxvsp"
Content-Disposition: inline
In-Reply-To: <20191118200247.3567-15-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--I3tAPq1Rm2pUxvsp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 11:02:32PM +0300, Dmitry Osipenko wrote:
> Add initial interconnect nodes that allow display controller driver
> to perform memory bandwidth requests using interconnect API.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra2=
0.c
> index a8098bff91d9..dfcd9fdb7ce7 100644
> --- a/drivers/memory/tegra/tegra20.c
> +++ b/drivers/memory/tegra/tegra20.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2012 NVIDIA CORPORATION.  All rights reserved.
>   */
> =20
> +#include <dt-bindings/interconnect/tegra-icc.h>
>  #include <dt-bindings/memory/tegra20-mc.h>
> =20
>  #include "mc.h"
> @@ -280,6 +281,17 @@ static const struct tegra_mc_reset_ops tegra20_mc_re=
set_ops =3D {
>  	.reset_status =3D tegra20_mc_reset_status,
>  };
> =20
> +#define TEGRA20_MC_ICC(_name)				\
> +	{						\
> +		.name =3D #_name,				\
> +		.id =3D TEGRA_ICC_MC_##_name,		\
> +	}
> +
> +static const struct tegra_mc_icc_node tegra20_mc_icc_nodes[] =3D {
> +	TEGRA20_MC_ICC(DC),
> +	TEGRA20_MC_ICC(DCB),
> +};
> +
>  const struct tegra_mc_soc tegra20_mc_soc =3D {
>  	.clients =3D tegra20_mc_clients,
>  	.num_clients =3D ARRAY_SIZE(tegra20_mc_clients),
> @@ -290,4 +302,6 @@ const struct tegra_mc_soc tegra20_mc_soc =3D {
>  	.reset_ops =3D &tegra20_mc_reset_ops,
>  	.resets =3D tegra20_mc_resets,
>  	.num_resets =3D ARRAY_SIZE(tegra20_mc_resets),
> +	.icc_nodes =3D tegra20_mc_icc_nodes,
> +	.num_icc_nodes =3D ARRAY_SIZE(tegra20_mc_icc_nodes),
>  };

As I mentioned, we already have most (if not all) of the information
that we need for this in the various struct tegra_mc_client tables.
Those tables also contain some definitions for latency allowance
registers that we are eventually going to need to do more tweaking as
you suggested in your cover letter.

Thierry

--I3tAPq1Rm2pUxvsp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3TjPIACgkQ3SOs138+
s6EdSBAAkJq6NUF8h85zOp4aN7BmEM9zr6aQU87PcpheYtxkxBSWJB3FL3ZbULKr
uWUELJntyp3KXLEuosHFkUZTpvhzDhhyVi5pZ9r45M45uGgZqO1pMPunN9Ha1Uku
8RzxboJvFEGLAok5/9XW9tsotQ/wjhRQKIQWgzGfxLz2jFEWF0nPc5akod1RHQTz
dcmDT9D9gDXJqiAHJINlHxfA6O+pkTI3s7K2qr0O9C4ao+xgSOqcjWqr0yCOggw2
GSerhri3lwwbEAQk8FMi10nIU0gD8DDOD3iVGNqnR6djOzkZMMEfG2i5RzWzHk7G
ijkE6CnihiZwbDIUKdE9XBQGOp+fdEGnaznERMG1GWyi68u+nSmkGDnCtivJkL8j
yur3Wdk2RoLyVii0RScej4aAndbyVNhRslgPEhu0hs1e6YNI44L1i6LcAZFck87N
q/KQl6aiOpVajQ+7eiHgHOeYQYGXcz/GGRWToOmo9RHAu1gMqVdG03wgpAKDYkkQ
ls3DMn/qSgfH6YeuKWPes9x4gQgXtAtx22hlXxXC3P5cSw4XWXpiQFv9YLN3I/zs
SLrm0uaV8jsjyI0fF8dWO2RWQMlkyKj/kGQIL44ZRiYgO4iop1Rc3dIUPpn/NtYe
bOPFW64ShM7Ex2qHSHhiHnv60kq1YqYAUo1mxFa7XE12ygIkn3s=
=85iP
-----END PGP SIGNATURE-----

--I3tAPq1Rm2pUxvsp--
