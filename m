Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3E29ADEE
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 14:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbgJ0Nu5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 09:50:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46402 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbgJ0Nu4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 09:50:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id 33so1485176edq.13;
        Tue, 27 Oct 2020 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UpTv+N44qmDZNKSKOpBL1gv18cc8KZ331d2Wj1p0YQg=;
        b=iVBDSqXPbyhMom5M/1h/9OcQTUUSnjymUB4Hbi7C7uMD/QVVeedzxVl2zLQa4ESuR9
         gdsutuRaBNgvI0Hwfwndoil8xPNV2vDfT5jcPE8fanTz0J1XvfVP0MfF/kMdV4tH6MCn
         iO9xdNfMEX41DdMg2t0HvKjNjBvzi1WnJubsffwjg+NyFtfH9q3ZsHw+tHAMAcaIghLH
         VNgDS2enn8MUaA+nOhVH+mU6Map5nA6SoyNr5cAKK6hdjwr63AglMPcnhU5QbeXyUWPg
         yzKckeFV2spRM2FHSK7C47aAfkbmRN0RgBDEDeRFY9YdYrhm/p4QVskIzctUV8UIymWS
         GeTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UpTv+N44qmDZNKSKOpBL1gv18cc8KZ331d2Wj1p0YQg=;
        b=m7aEw4PLKUX/737rj1WV7YjizA7/lwifh+KOSSgOFdPnG137dGyX7VjqS3BJJR1gr7
         PIS1Ia3SlPiQwXPV22Z51QlGO9AiZGRtW5kAAMazeDZcQlu7OO4Q2q3Q4E75NAyJCNma
         UhqrFeKRtpQj3iFPBjy+UjuUuJMNCBXyAav+ULsk332zk4YwO12z6Pk607DZ/roRQZbc
         ZqekfgWD30oDyT9PhZHH2Xj4mWS9MbT2gfxgpj6tetMuCRM8/bNmNpbJ2aVUl6NS2KNu
         VJyCKE/SPXNOHCa6KvfDaWyZm1UlzEnzYMNkg29kL4ewJgblN4tW2CqU/1KoCO4pSXA3
         aaWA==
X-Gm-Message-State: AOAM530kWhVj18wve5wthui3v7gmHuHNaXe21NR6+wDYRE8oMr+QKWMj
        6vpaiAz5uxVeSna67AspH0o=
X-Google-Smtp-Source: ABdhPJzoug3kqXmwuIlVZWpSCnC1WqKifa1HHV8r4AwHgTv48ReSSRME9k3xx42F9bEE4Xx6QKYLwQ==
X-Received: by 2002:a50:9ec6:: with SMTP id a64mr2283115edf.382.1603806653958;
        Tue, 27 Oct 2020 06:50:53 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id b8sm999899edv.20.2020.10.27.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 06:50:52 -0700 (PDT)
Date:   Tue, 27 Oct 2020 14:50:51 +0100
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
Subject: Re: [PATCH v6 31/52] memory: tegra20-emc: Use
 devm_platform_ioremap_resource()
Message-ID: <20201027135051.GL1822510@ulmo>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-32-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fDERRRNgB4on1jOB"
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-32-digetx@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--fDERRRNgB4on1jOB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2020 at 01:17:14AM +0300, Dmitry Osipenko wrote:
> Use devm_platform_ioremap_resource() helper which makes code a bit
> cleaner.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra20-emc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

I'm not a fan of this helper, to be honest, because I think all the
churn that we've seen with the conversions isn't really worth the 1 or 2
lines that it saves, but hey, looks like this is pretty broadly
accepted, so if Krzysztof likes it:

Acked-by: Thierry Reding <treding@nvidia.com>

--fDERRRNgB4on1jOB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+YJbsACgkQ3SOs138+
s6G9URAAtj7PIBjSjv1nses5GEAWNmBaiDfGSjpiLUkmRQdPi+MiY6E8ka3TCPaQ
Ekhqca6aM48b4MSYkHBvSpuECG8SZMrpXTofBh11pu4OaydcdUUASsgySz/x6ARu
zK+qwwSxvPvtq6a4YYcbts0aJu4y0Gk9Sw4zXjMl0mvuB03J0yTYlWgJuFGNv92K
gGqj4cUqhkHR3WcJ9rmv7wgYo78DfNhYvM0Ux5EemnRiGpzWljNDYpTVwPaK/vlT
D9WcDj3EZpxi/hwCZLy8IsIhamHoM+BZGtkuXh77BNqz1zpKLCj+YuC4pg4D6+ux
UN3UmGNW5HK7HIc2eqMOXd7srzlQZc9jYyt0VSxYeukp5/KYCwVHhVT2zL1ryxfK
lVnWEu1SMM4+pRFLRWvgHUoTsfA0QW//fFdvB8x0nH1mEO0LLKFrnY4ariB1j9/a
wpcwTfKlSTw75KeK2sjOIQFZsVtlorIqPhRyS57fqPstxeoVfDQ8n6z+OjuZ6TWQ
Br5RGkUloMKCM0f92oWT0oPJCFUrkNFrMrXdETQ3Y0vcHQeJaER36h8ddCxB0PJt
fEOT+057askejUvy4Tx+xXPw4zfxPBUZcZq4b2n6VRfAojW66mC+rv7Y1FHVSAbo
aU/pmuqSUPw4Z8eNVQe7ZHQjHvHVulA8PmLWXvCMfjlJBhErFf4=
=ihq2
-----END PGP SIGNATURE-----

--fDERRRNgB4on1jOB--
