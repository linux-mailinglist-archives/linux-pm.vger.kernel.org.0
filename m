Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CDF1C7693
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgEFQev (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 12:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729774AbgEFQev (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 12:34:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8AFC061A0F;
        Wed,  6 May 2020 09:34:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so2967833wrt.5;
        Wed, 06 May 2020 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CitFOW6lSCwIM6aw5NC/+3Zn/prCPjR6lg9nFJoDblU=;
        b=pw9fk+/IZaZeW50iJflg9PhbuzRdzLg808N7u2Fez6ORNPCvTn4U/En6ZNVoy1q4FA
         Uf2pw1nwS6gqTx7REZYSdawIUha1dkYjj5r1GCU/1ewCeJNxsQKgmOXOSNXcWKYK1DJv
         62t3uKrx2SaH1SGCgedfOSjOpTYD54k6Z5B5iF7CiXeid7vlco/BKhnHnxAMHMw3Fvd3
         jHIeXwoKTqsg30eMuCBNDlkQstSOdVxKxTzyBAwbaRlTR/Y0n8rSdp+UuSreOzzEJjPg
         b5mc100rw6sjev7bTHgNhYKGi6aKdzd9aiak1/oSe+et1Acb0Ut90fGpODCSBRRDTUcc
         DOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CitFOW6lSCwIM6aw5NC/+3Zn/prCPjR6lg9nFJoDblU=;
        b=VyutDvXPuLzIi/YXK0slCVj5U1YImhmCJluTn5NkrclbRbXqUIzKjE8xp1KKeRkyP8
         sDaAXJXtHc+yVvQzbKpXatEiV3MbUqyrSl/cBGDIQdxgjt2k5fJupQSYLnDql4ca7gP9
         OjjZMccsjE78wRxF61o4s7vkgvYVGE1lVGxV0g9VR0fPlZFfSQvCsCrdDTocwSBI/Ggf
         5551fNpx85hteVbLzR3D2xdWURjG68kl02OONQ4dsj7NaDNhWaixCCoZufM99e529e3D
         cHaOPaM5+CFoUWdDnqF6pDFH16HvZkXzcDYF29WJOnsZcBfPn/Yf8zWM+LL7gwz15FLm
         8/6w==
X-Gm-Message-State: AGi0PuZoaYzlVYxkGKnsf+qcDFj1EihYvLxSnoiV/2m6mu1DjdaAMr84
        tbIMe1FSmrvr3AchCaqFi7c=
X-Google-Smtp-Source: APiQypK1bdGwO4NQxd7pKQ9BlCG76pCZhDO/3C0TjjeFDAcxUmgUbDnUVkcYYf++x/xrrPP+67mExA==
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr10771365wrr.18.1588782889895;
        Wed, 06 May 2020 09:34:49 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id b23sm1506720wmb.26.2020.05.06.09.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:34:48 -0700 (PDT)
Date:   Wed, 6 May 2020 18:34:47 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] firmware: trusted_foundations: Different way of
 L2 cache enabling after LP2 suspend
Message-ID: <20200506163447.GC2723057@ulmo>
References: <20200324224335.5825-1-digetx@gmail.com>
 <20200324224335.5825-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lMM8JwqTlfDpEaS6"
Content-Disposition: inline
In-Reply-To: <20200324224335.5825-3-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lMM8JwqTlfDpEaS6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 01:43:34AM +0300, Dmitry Osipenko wrote:
> ASUS TF300T device may not work properly if firmware is asked to fully
> re-initialize L2 cache after resume from LP2 suspend. The downstream
> kernel of TF300T uses different opcode to enable cache after resuming
> from LP2, this opcode also works fine on Nexus 7 and Ouya devices.
> Supposedly, this may be needed by an older firmware versions.
>=20
> Reported-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Tested-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/pm.c                     |  4 ++++
>  drivers/firmware/trusted_foundations.c       | 21 ++++++++++++++++++--
>  include/linux/firmware/trusted_foundations.h |  1 +
>  3 files changed, 24 insertions(+), 2 deletions(-)

I split this up and applied it to for-5.8/firmware and for-5.8/arm/core,
respectively.

Thanks,
Thierry

--lMM8JwqTlfDpEaS6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6y5ycACgkQ3SOs138+
s6FCSRAAh02WAmouPtmya248FjU/uaRY3IDf6ewTOb0PsVokeZQB4biQYVvIN7CW
l15w6+90Ni3RTxe6g3GewA8IIxmRYet1RGeRIFYo2ZhLCL5SurzOcQp1V7NO3Jg3
UrgHSCOlmZM3W55qOwucjdolZINuXvhqbgscHdDHn3hbfJ7vciHSAVvKR+eDijU7
xL+UZJ72i2UVgFwnu0ecREIPLDzzRSbwTP7z5Aedelr6RyNpjJFpwXL1ARRIpV+B
f5AVWvyn4PqKrHgav+N7mPAccVXu3NImsa6e+GlPq6JJCMt2bD8a7FBXha0Xp+z9
LcF3Fwv3H7ZWfGiqqtTrhBADXUaj3fkJ8zQzbeHR5W5DvYJFkaZtIuAtH4/Rissh
Fnk0j3kJ+WRUD3/CdAKpOdMEcqmQW4eU5JWHFrEqXtwICE51tKiF7qnLtgwNsrll
m/Y4dCq7l4KsKAHQSU4/H53PuJkyAlQW5UKCIdOzizqjMtRQCjvQFsq46WSYD9uK
b7WW44l8UpUHfKGT7hSQfHhi5OHucY5otFCx81rTj3Dyv6ckLbd5igPAZk8cylMg
HXfxegHGR0f1Tb8HfUsBbs/fNUFnhPNsWgM0nMvbmxNbpKH9LCeOlKSdY1y/WpWy
OEJiuem6uaohDNwOC+tUOEBhRn06wZcOpGkQOBNm3qswQkXecos=
=+mgt
-----END PGP SIGNATURE-----

--lMM8JwqTlfDpEaS6--
