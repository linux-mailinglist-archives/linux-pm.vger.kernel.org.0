Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9781344E4
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 12:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfFDK4a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 06:56:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33521 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfFDK43 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 06:56:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so2881984wru.0;
        Tue, 04 Jun 2019 03:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ry2pfD34ydwB5Q3uWxvQLjhj2qFtTOB3/HIRqMCnCUw=;
        b=kKOgvU9Js8dHmWGKKVlViyQludRecB3DYbR2p3WgO3A2jOqrw6EHkhy5xM2FNYUsvJ
         s9XaOEzI+1Egv2zwaXAo3S+kbP7oyX4rYwvPuztA6C6Z1DL1qXKuNtk00OwPU81l2qwy
         vXzV2M35ChGp44clYtmdLyBpj5iLLPtfbIpF4ncZUMEAMS6IS1H9YiJG3t2966ffFHqe
         mHhR+d46e/mUa9HyHQ2TWYK8XbVRTI7+to3Zz0FiSexorS3sbUtKxOnXn3J/98BxRf4L
         SUbvC5KV5tmRt1mkieFYDp4li0vXC76lfXt4lAYEccNle9RWyiekjDnnkrV3u6wksAFd
         P17w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ry2pfD34ydwB5Q3uWxvQLjhj2qFtTOB3/HIRqMCnCUw=;
        b=OhfcFbxHgyhQKZB2nc56sAYlchyslA4UY2/KcbnkX0LGOo5AJ2tt7qu74FUnRIlnHi
         APm8Vj0VuijanxtfZUkCECvyXZMzALlJGo20E1aXNQPl6P9U5vNiM6TV6C3tBpFZUM8w
         3a0TbW0BY0bmXk/d2HIyRcwOoDZB5v57nbBphYxFBkZWQUTjT01VjXWcjBKgVQ9AZnSR
         L/unYkxXa+Iaj0BcfeKBJZD4J3SHsXx8ykbs9VuGM6ypR92uF1eIZQju7fsHWnJzcx9y
         EPna4G6/vB/e6u4UUQE6jnPwcNokR84GueR5jqk12C7cT32iDNsR4v2dUB4pqB7U8HES
         cJgA==
X-Gm-Message-State: APjAAAWKTTMaCOzqNM1Nelok3WjFM0tneEacZQukfyiEWnWSFxzvCSLg
        WMdjzofZRuediLNxmL6h280=
X-Google-Smtp-Source: APXvYqzqBHKehdlBqV2crCVaLmAjcmRMwtptUBVxJC8wy/A9TE8PUMl8dzYFuwMlTGgD7u81ngm86A==
X-Received: by 2002:a5d:4909:: with SMTP id x9mr43269wrq.226.1559645787597;
        Tue, 04 Jun 2019 03:56:27 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id u13sm3027365wrq.62.2019.06.04.03.56.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 03:56:26 -0700 (PDT)
Date:   Tue, 4 Jun 2019 12:56:25 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/16] PM / devfreq: tegra: Replace write memory
 barrier with the read barrier
Message-ID: <20190604105625.GC16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-4-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:02AM +0300, Dmitry Osipenko wrote:
> The write memory barrier isn't needed because the BUS buffer is flushed
> by read after write that happens after the removed wmb(), we will also
> use readl() instead of the relaxed version to ensure that read is indeed
> completed.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2TlkACgkQ3SOs138+
s6H9PhAAjyyQ3koVZYH/hahMlqPEixyEjfbN26+C7gkROXuFYnQQZupAVw1l69RQ
6yxAwwLOrmabKNH7xdqGJaTNHc+7WF7kJQATGndqDIUhAOyoicu/yUlT7SGKQam1
t2mtSOYPHDkB7v0xRFlagPLzzzYEiYkBv+2KnkSqQBvw1q4Hof6NbbFLcyzFN39X
tcAgRQ851lZz+51r1ip2CEeFXrTt7c3Lb1ZbcpN9oMyiby/DQhT/IkRtI/mTw+jd
LKGDNV5xXLGADtea4yyzyttGNaJxaVKa0ZIBnmSxoeUlXnSlJfpYvkK/xnFSx+m3
az9WhqvkAu3zYM8XsZMjuXIwMOwHvEP8dARBd6pR8HtdtDR9AXUOtgwQImQtWAUc
7gDccXxkUtx0k7Y33izZMS/qnPSHWYyw+9+6bHdgvgGkvw9na8eVIj7FPXX+BEo/
BrQBF7AfQ035H21h3qhjXZeUkgADMeKgxlizvNSvcfm+UeNP+kK3Wo2MnXHqZiJp
K9rcqJOkaxtt9mDoHkMLkmrSe7ykYelMnTu/Su9aOPC+oDVSnOoLQatQmKzt5c9K
Vu7uizim3K/RCQRaowMILmT1/CHzjoW1LGTdKmF8gPYdt6n9DTdkMzhoCo3jTNyP
FdDj2FVrBhZemfZYiOpXbNAQh2pvWpwr+TFNFoEDH0RI50eMr1Q=
=l/Ef
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
