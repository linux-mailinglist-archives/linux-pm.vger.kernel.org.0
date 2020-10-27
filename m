Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1F29AD0E
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbgJ0NSV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:18:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43676 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410298AbgJ0NSU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:18:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id dn5so1386324edb.10;
        Tue, 27 Oct 2020 06:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ndv9Qik7lTY419xLvwNWbUE1VGCODyUhzruthjY0r9Y=;
        b=t61DikpXoR+LU4gDAsmR2PQbB+Mvsw1XHyKVY6N83zXsiNcoB3Mc2FI9OyqF+8XZQm
         pklE+QKbnb8MsrQXIxcZxt12srTlVF6EH/agcEu5GNN3tg3LTaPwsWKCXe+c3TfmVirk
         Qyvkmo48kN3j075aNssoSyNy7/FrZdXcEOWvrOu2aKFNBIb7LG/AJo9sK5bYgyM2HpHP
         D9i9NeTU3S6JN4sBdsF5vlerQvYKnlyadVHVxftJZ83272Ct/cV07e+iZwZJXCwqkEeY
         y0ZdTtuoX8kQxKNHO6cQd4dJ1dvJbsx6eHM15wZEVCpLweRx76Pe71y3OkhCgvjYSBRS
         Z5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ndv9Qik7lTY419xLvwNWbUE1VGCODyUhzruthjY0r9Y=;
        b=uA6w2mZ38DmJcb5d1S/1qcoYEM2JMgUzIgqPiNvWNz6pc4eHM8EUyU2cq6pQGFLWuI
         xsPcP57UH171r1bNFSKd4/jhRWOjgqKo1jxsk3JCYtutIzDuqxL0qx6X3LTQtY64kmuA
         +d1RQgg4ovVhTig5Lk1IV03+offxvC5aTd/ijLbn5WUFUHaivHkV79BEfqXuY2ixyv4j
         DA3V0pTtJoFPkrVyK2S2jJeE690lOSWM5Mn2hXFRgi5b0STVtYChpLcYnRULego6GkgC
         VLoCKMglsej7KgabmIHGrIMJrZJ5f62LKs+VCM0YneSlNUXcO5mPtSksLFEyZinhDNYG
         YWrw==
X-Gm-Message-State: AOAM531OL6i9tkKpFsixfqPOyRTS/DPNbZ0Vj3uA8AAVPXryBZBjisxl
        +LkMjJUP1yG147MF1bCmihQ=
X-Google-Smtp-Source: ABdhPJxIpbVFo4VsH5MUVteFePSla4n5DhbT35d0dUBoD9Nz4n3pnzMiANoqRA/4cQ0HSevWabpUxg==
X-Received: by 2002:aa7:cd85:: with SMTP id x5mr2340028edv.0.1603804698412;
        Tue, 27 Oct 2020 06:18:18 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id j10sm1039876ejy.90.2020.10.27.06.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:18:17 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:18:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 03/52] dt-bindings: memory: tegra20: emc: Correct
 registers range in example
Message-ID: <20201027131815.GF1822510@ulmo>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-4-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:16:46AM +0300, Dmitry Osipenko wrote:
> There is superfluous zero in the registers base address and registers
> size should be twice bigger.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+YHhcACgkQ3SOs138+
s6ESow/+LZLmPofRTsh9zPA6RdjuJHtjyek0yRGuddZ4sHlXIn1hVoWO8NVOzrBf
naNUxbKU/MJeFlWbjmjWodFQGTTgHrp8iNGlbNwknnGnXsvUwaOR//SfHfH54BlD
CcdfTmZee8YOAw7NbWC70q8uYw0pnM+VhHwXXKAn/pVf3Z5tU/iaqspZPBuB+Fnc
ZhkSLVLG04PpLtoyRQwuJiOOfVDbFdPPJ27TyDt+v4e7ML4g0YpYAgTkIEB3Dn8w
A9am2xRbLHga6LCIgHuT/4D9FSwrq+q0TIZBn4McIvsp1i8oI8NQ9OisQM0K9tyD
YBFrcqnz4j5YHkijmcZp1gDzBTe8UxiDdDfMTfR5VOjm8Dbc1pckyCgGH/hXCDQa
/Eemqag7huNBBmAPGvBlQ8ZUfAygoOC7YiWvpZ9C9/7UzbGTQq/H3Tuu6FqQQNyA
ZJO1prc28+BaWvABP4Qxx3UbyQpIqGRhM2qMRIxt4+yw9Dvzxb/KyTraxVsXGtym
zkQ3qDQ/Wisj6L3iRn5Y9gaQ9liqZtHLovc7yt0UG48asa5qCWvVc5M37zSktPvs
UBCBsN/F+7Z3Mv9u1g+CvVik5GR9rpiKcEI/+eWAt0gndEC/3YVgzusYAoLDHVYm
5Zp+WTdv1j0HkpcdQrlRXEkdzcPOXhtl3Y6IAqPiFm5HGMLzSjY=
=opf4
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
