Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE2E45890
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2019 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFNJZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Jun 2019 05:25:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55221 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFNJZv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Jun 2019 05:25:51 -0400
Received: by mail-wm1-f68.google.com with SMTP id g135so1567211wme.4
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2019 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQycFeF8O/MCj3xXiN1geP8caLtxsTmz/1Q4H46qCII=;
        b=AvTHUA0nvvIuleQ4btqdI4j6kKv0X41qA7riYO/sKzRvrpTAplVAHRoT+GpsRgy3c4
         jrud0af8Jod367hqf82apN29+1wePA6JIXktb1YDuVNsU1Y+KVx3KKNSI29DE7QMhOPQ
         Yme7RnYJuVcVzRQ3ecwU1OhrKj46lDTUzlurS0AU/U35cHCa3V2bqbUcUoMt3axLHbfx
         wXS9Ku/YgdQkfZnojBucLJxIp0TdNvpZBihLPEljHeWfagsnCN+A5tpQMQPLijzDMMIN
         ZMuX9UrUOcHi6XVGgKSZ1PTNchWzF4/k9Hq5LtTGal1IgGv6wVoxqGIEqSBjdnAkyCXU
         KD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQycFeF8O/MCj3xXiN1geP8caLtxsTmz/1Q4H46qCII=;
        b=V/BFzuCsh69VZYVcX3j0EbhsgL/E+rlAuAgfyrjWksQPTuSBL9E9utjv942/VpcLOj
         LC4rGHr51hWJF2astusk2RNXN8kEDDRRJogME1/FKe4CV2KGU0ckS70WrrfZuweq6e7+
         IovumHuQXQrPGySlA7MF0cRGJUuvg3ouMtMg6hGIIJvYDWN1rIzIno61OIAD/sHzaS7+
         YH1MWiTDFjFyfX71arDwmd4nqpfh8VgYlVDzyFimOdKU9wLnyNAqs5ku/aiqfpSGFWSC
         A0lDEapcmg2rOY9mP7zT1e3S99f3S2QNi2hiW29unvo6U6CnghioM0G18K8IKpWD+loe
         sg4w==
X-Gm-Message-State: APjAAAXkyClxn9dJCFercsud2igDav8xUitwe3rvigZU9QXq4ibSxf0Z
        8YUigEioA6CfS/j04QMuHhk=
X-Google-Smtp-Source: APXvYqyaytM8J6jQYVS0XhFw1X9mRvKOjAyKDZ/IVN5OX4u4srU7nQgzlE/xgqW5vu3uj/6U6rB6Gg==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74mr7388361wmg.43.1560504349583;
        Fri, 14 Jun 2019 02:25:49 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id m21sm2232694wmc.1.2019.06.14.02.25.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 02:25:48 -0700 (PDT)
Date:   Fri, 14 Jun 2019 11:25:48 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wei Ni <wni@nvidia.com>, Yangtao Li <tiny.windzz@gmail.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: tegra: no need to check return value of
 debugfs_create functions
Message-ID: <20190614092548.GB15526@ulmo>
References: <20190613183753.GB32085@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <20190613183753.GB32085@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2019 at 08:37:53PM +0200, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>=20
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Wei Ni <wni@nvidia.com>
> Cc: Yangtao Li <tiny.windzz@gmail.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/thermal/tegra/soctherm.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0DaBsACgkQ3SOs138+
s6HjuA/9F5n34GKRrGINO1OeVwwc/8qAg/kQdJLjR2Plc7J5qSoAtOkhyFPUSedU
pg2hdp+Z8etsB04al11YBIAHX5F6fzOvYjzZq3gMPuy3bi0TGr7uiN5zraWFgFDJ
8ki4ulReo2QVkMu82wCLiaf48UmHgB3tH2ndQdAAwmjsHrCigfeJeWFj9HbV26xk
fJ7/Kfh3bd8mWDSa1jyt8yoyvOJeM11xfDwLOfV7HCqBuZEK+jrVIqxulQc9j2NY
qHbAAYO1L5HaAXKkR1YVr9Xl3e0niVmck5y0XTYbEqVXFenSLOAdnOhAinLL1188
DQ0yKLETF8WdFT6XKgfw4TURMYpbtHj65GIRmW6jWvjVUEskEYwPKfDsgaY1adVu
wy8wgbEQsw/YUgRwaK8ZpEYebF8I5LvQUltQBvGE+kFEHaY/RjsXmC0R6m+mmyog
JUwoKlX7grvSYt1p96+6+aEtdgLWcYCBwsetzpV1BrMAVXpvQ4RKBIPV3d1yqCPS
S/X+cc9yAh64igrhDYYdvUlIAcX5GMTbBR3wlVQSyod1+eWwa3inLuEe1i3PJLjA
XWXy8p+Umjnvg3BTwTJG+KPgjClLEd2dVjzMaqNp89G6HxPkPIWAnZsq2kHiI14Y
PXMajNZn6cqyLJtZQtpMQxFc1o5ZgDnP3/dv23pXzqwtvm+T3eA=
=4ImI
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
