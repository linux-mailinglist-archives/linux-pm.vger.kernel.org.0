Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA0434532
	for <lists+linux-pm@lfdr.de>; Tue,  4 Jun 2019 13:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfFDLPy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Jun 2019 07:15:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36181 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfFDLPx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Jun 2019 07:15:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so12337666wrs.3;
        Tue, 04 Jun 2019 04:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=21jzshqWNqSbM0BX274WNFCpCR6MybR0WXpj9Ydnmuc=;
        b=QLTU0iqIXTKYR3p3pIlaqQSowFqrI44j5zZUe1nuUegljYX0lk2fuEaUrwA7KgxAii
         RSzsSsFrTsQ57X+9c6T7CNjeFw/ZP8jG95ry7a/8TSXqFZbt33cMXp6HZkzfEAbYi84Q
         MnIKlxgBeYRCkOsyNcSbjy5o9p1W8ilPTOa/K5lFMqgBOmG2jO+aemATnXKCfJXPZ10D
         9tIk28prDW8rhQp2UnnqY2yJBqFVMWDcE5IyREZItJPwMmfKvGKKj4DhNKkFhO5CMe8m
         EXqOMOvCiDTQQkeQ/EGsT+/AOywUkAUbOjJZ3TZTzO1BK7dMSjYpcwtyM7tOi2VY4yH0
         j5aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=21jzshqWNqSbM0BX274WNFCpCR6MybR0WXpj9Ydnmuc=;
        b=XpqxlEBg9ZOvCU0Z2pzhHnggCiK6Ne+NEQcIRJQyPL+oyWBQ17FttrYo96dAJ8BS0y
         7f1JxdLy9+8SOTYzbFNDVJc1F0SL2kYjFbVpADTbH5+bNM+z8nMBsyI+6kq7DuenuXKu
         GbaLHKm9TWrtgS7DrA4n+BSpUXmcOk9kp25eAZtVnxdSchCvD+sWMVTWi4krt9XaTkgm
         yHQYoi7RyPUaVF+C8tlp6Ymv/WmiG4Tjz68YUcWK1LMS4UMlmdJwBlUbVasGrJThMnPg
         tBCl0TLxQx8ReDI1BVDgW1E1hAZxLLwEOPMptDOrX6k0tIA4lFNyWt7FUGtTAwkVahBz
         zuTQ==
X-Gm-Message-State: APjAAAWOuMhqItCdSHswMPP8kwpCxUzspC4DadGmRNgKZix8w5DbimfU
        +M6Hx1AejEWz1JbvKOs0oBtJyWSB
X-Google-Smtp-Source: APXvYqxMv5qyaol0KKPRkCuyZ/+L08VqNNfhJrqgHPLK2TbBWXxKeal+Itx75wDtuyX8iIbXSD9iBA==
X-Received: by 2002:adf:eb42:: with SMTP id u2mr19214347wrn.80.1559646951759;
        Tue, 04 Jun 2019 04:15:51 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id s9sm7577558wmc.11.2019.06.04.04.15.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 04:15:50 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:15:50 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 11/16] PM / devfreq: tegra: Move governor registration
 to driver's probe
Message-ID: <20190604111550.GK16519@ulmo>
References: <20190501233815.32643-1-digetx@gmail.com>
 <20190501233815.32643-12-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huBJOJF9BsF479P6"
Content-Disposition: inline
In-Reply-To: <20190501233815.32643-12-digetx@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--huBJOJF9BsF479P6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2019 at 02:38:10AM +0300, Dmitry Osipenko wrote:
> There is no need to register the ACTMON's governor separately from
> the driver, hence let's move the registration into the driver's probe
> function for consistency and to make code cleaner a tad.
>=20
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/devfreq/tegra-devfreq.c | 43 +++++++++------------------------
>  1 file changed, 12 insertions(+), 31 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--huBJOJF9BsF479P6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlz2UuUACgkQ3SOs138+
s6Fa/xAAs8/9N6QKLabrkCEp1ToGj+FPPRziPGrEF4FIVRI0CrWTozbqCUuSW8Eb
rEp2+kYShvkK/pJcWnxUNnfXYthbe3YJgpqdZsaZlmCUZ8BueuKi7z5hY9GHouM4
zX/X3nXzxib7mMP8+Rtv3jXyJs58bqW/uxT4Jo8udtWwhWj4VOL922XOHXKTxjKa
qZFO4vcdr4eRhvKCx+Up4eK2k8gcZW275NL60VPGhrF5Xkwv1oqVBc/GNrSnbQap
54EUU3VECtFfWJ8Z/TNZjgDaI0C70sDeZIjZBTQ9CucQZjnIqPFk3UMAL004X/QF
wp24N1LZzDPq+ymcFlZGqc1Lnzz3peebcu+ddL/uQIYuetddt+QVDzmwyyiCvnXG
bRlk0ibhdUEBW7/iogajwF62VJHNjk3qWGf9u7GCkVTUDaR/eaiFuHyj2dgFTUQ8
QWGSZ9G0FxZzNQX04yTd1+sWHeF6y6LNFW3/++iN2w0nI7T9/c3wYaheLrr//dC6
5+Zw9LaiU7P0v96xwgA3XgCyZwh2eze6V01yOJte+USSeR0DwLvGJNzq5MDI5fUh
a3MzkrWtDVbfExgWNWIidARnlPgvwSIoExNeJ6r40uWDNEunAj3vuiA2tushly3H
kXY/xyTe1tR2KNana6MfL9O6/FcVZi5AflGjyHToD3T5Ok2hx2E=
=xHPf
-----END PGP SIGNATURE-----

--huBJOJF9BsF479P6--
