Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD6E344FD
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfFDLAr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:00:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34311 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfFDLAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:00:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so2009671wmd.1;
        Tue, 04 Jun 2019 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ry9qT3LbyuH/6y/zhnSI5kikIqB3kIMvxasnYGNS1uY=;
        b=pVPZmX4zNXZH5nPx9fxT/V81+drhOVhnBjF3iscpO3dNth3UoGAB2zpqv7msmG0OZ9
         wBvKCdbUZEiZJnImPy1L14F7ZMm/+Ilo64yqoWyFXroUyt/b0tvQjFUU6ylvojdTKayw
         ev1V12pH8ciH+Tcuym8v35LFZ/I1AtYJ6W47srMsadUMuh7mmvkiDU7DCB2rryMPtZj4
         hI7FZwJ80iixQeLi5671LcKawio/VFS3JqSuSEs+CuzsJF4c1cufb1CM0K9Qd8gP9baz
         QL2yIgVB53yhhVDhPouKyM2+BnUQvCMPQdUzne5O3e1J6Cy8AqD4cgDMZCiV475Yfbt3
         fVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ry9qT3LbyuH/6y/zhnSI5kikIqB3kIMvxasnYGNS1uY=;
        b=eLy6JXOMyq8Vp5ztkOAXArQAasdvsWYzYS7rQB2PHZTB8GONmVNCZF80O9mJf/IZ0a
         FCmLlaKmg3XvpxHDNmr5euMdCCZA4fm551TD2255bKlgQTosVrEsFsfItztmRSRRm8n/
         aGSNL331qleoS5F4MjhGxdzGkhL8vPNxRvKO6bbPZ4pozFWGDK8qjRNX/Ocafk6x2xo7
         UKFS5Ei9p5sntgLIHdJ9LPGcpKo255fzHX8H0P5LYTW3w5rzcjYt1e5d6UrIV9BGPmWr
         k/E5VqwsG1KBWZUO8SgR7sp+f/8Y3tEstIC+muQcLLtGlp3MhM8ejvodyGym07zCAghp
         rF7A==
X-Gm-Message-State: APjAAAX6JLSvdCDwHN/plhZjnXsv85YtEEw8RJeestS7aomc7sr6+Mfw
        P5JzCyGgHfc0XF4ESD6MNhZ6UjMw
X-Google-Smtp-Source: APXvYqymhanTOzaenE89rQ1PoRX/A0KxqmSKgazT/TpbMJSre8olIJO+7BRhkHu2o/azVvRpDaqMvw==
X-Received: by 2002:a1c:3c8a:: with SMTP id j132mr5557438wma.172.1559646044399;
        Tue, 04 Jun 2019 04:00:44 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z14sm14106358wrh.86.2019.06.04.04.00.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:00:43 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:00:42 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/16] PM / devfreq: tegra: Don't set EMC clock rate
 to maximum on probe
Message-ID: <20190604110042.GE16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-6-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:04AM +0300, Dmitry Osipenko wrote:
> There is no real benefit from doing so, hence let's drop that rate setting
> for consistency.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 2 --
>  1 file changed, 2 deletions(-)

Do you have any numbers to tell how long it would take for the EMC rate
to get incremented? My understanding is that ACTMON basically reacts to
system load, so I could imagine that not setting to the maximum
frequency after this is loaded might make the system slow in the short
term. Only after ACTMON has collected enough data to determine that it
needs to clock the EMC higher would system speed resume normal.

I guess technically this patch doesn't change anything if the system
already boots at the highest EMC frequency anyway, which I think it does
on many (although not all) devices.

Anyway, you said you've tested this and are satisfied with the
performance, so it can't be that bad:

Acked-by: Thierry Reding <treding@nvidia.com>

>=20
> diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devf=
req.c
> index c7428c5eee23..24ec65556c39 100644
> --- a/drivers/devfreq/tegra-devfreq.c
> +++ b/drivers/devfreq/tegra-devfreq.c
> @@ -653,8 +653,6 @@ static int tegra_devfreq_probe(struct platform_device=
 *pdev)
>  		return PTR_ERR(tegra->emc_clock);
>  	}
> =20
> -	clk_set_rate(tegra->emc_clock, ULONG_MAX);
> -
>  	tegra->rate_change_nb.notifier_call =3D tegra_actmon_rate_notify_cb;
>  	err =3D clk_notifier_register(tegra->emc_clock, &tegra->rate_change_nb);
>  	if (err) {
> --=20
> 2.21.0
>=20

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2T1oACgkQ3SOs138+
s6FJlw//S3HMd6zjiAiIh7sOMGPBFiOdIAVCsSgPmNITPRNUOkFt7n3cwIF39HRA
LEuKQhYt8l/N1kYwjbRT0bATl35PcVUITRGPcJh9Tg1SMJuO+hJ2jTRHQKpVJSQC
8qeGgOmhScOTSgqbFDR+a75q9HbQzSZXVY3WSnjXOMfzHQim4AqUg7EJp/X3Qma+
o7fUuJmHBQHmgc8LHoOATonOt6Qo6RF7xvJt0UEFzOpwzl8JwWKYw+XsqgdzXQKJ
u97CcKcgIhVOyQKdWMX7nOwHaLvZvLRjoshz6TgjnRjxo/KWklooLWVya3A/FfRd
uf5RG14aTC0rOqpyc92xvrTGcjjVEHYjR+xaAUYYFHTdXKE8iG2sX5G0uQttQwTi
kO2QRDqTmzhvHCjB1QFoa1WsKahUAuuL3Sz1QbujROBKhvLe3nSDAie19wS8vzOd
02D93BBMeTMaYZBJeX6+4cHStKUXChqmsGUuVEijo0ShDtm7Bu1yardeQjAGg0Fr
iVnltSo3nt/g72+ptJJz3zqOAU2OBRjEZPfakMXBFrAs8B8P7Ks/Gqw5uDGHlYBf
ydpVF78FHW7Ok2+KkqbtVwe06XM6/IY/m3MxfF7oEbIdMswtyBS9q6dHNrL+qSjy
6YaRiHpDrDkKHkvCaJ2MTuHy4oPJE3aEaHt9r89mfU57qJdHSYA=
=MC5w
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
