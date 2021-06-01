Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7338397252
	for <lists+linux-pm@lfdr.de>; Tue,  1 Jun 2021 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhFAL24 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 1 Jun 2021 07:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbhFAL24 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Jun 2021 07:28:56 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F0BC061574;
        Tue,  1 Jun 2021 04:27:13 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so1685394wmh.4;
        Tue, 01 Jun 2021 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qWpmyIqtIiEUNSYz2jvtQ/oVSnnO93CuP3bxTaEEH8I=;
        b=r+kkXsYq3sSGQafJpKn6sgxGQLTlUDBebSrbgmbhJitf7gvLWz+0ZjyGCe176QU6Sh
         uSrjn6Dzs78XGXw3TdpLZ6VhQrIIEsOR6jSx+i2pUd2JXSrZ39txZ3VGYismfaVlNFIL
         5ubSJFe9ULHRj4Niq6Suo/TUp+a24ijAfHTzOFARjlTfc39znKtGxAxneZ/oGAphWrbo
         ywRr2ZHMsVr2ibmVRMmA1H9qCe2jq1V3v5KMEMNWZdjICqLtfsylmys3zPDfjP/1isaO
         dPYJFCXJ/Odo80HoKNHvJEMsnvZoR2ggpuqvO9V5LIaQI+jxUETpimQJwl5Q2Cx+OlBo
         W48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qWpmyIqtIiEUNSYz2jvtQ/oVSnnO93CuP3bxTaEEH8I=;
        b=NB0UNKQ/tvcVKycVRjy9mddY+mwf1ufCEVxSC06k73mHs8hRcC6nhDfXGWW8ZCc1cb
         WKMTrE9a+F3wqorr5ZaGrrShdEOVV46HWLCPwRwhFzSOTIKeHdaqXJOIMgaThXO7btwm
         kQogOVTuwJLoFt9VAnEIL74eE8YB/JltbdIy23Os8eadhTA5wHECnwHDQ5MCok4c/yjC
         k+c/M8+sCKwV+p7O7A51LUq8nRUgMNkL3A01KXN+hsLrOn5zKjssDsdxVHfUlOgbD+gq
         FqN4PBJ05eCTVqXG0Mg9PBiSPRpE86ca2k59d9DQYRIkSp0WYG4YgYUlvAf/2UVZnFA0
         qaDw==
X-Gm-Message-State: AOAM5314YLqI5dcU5TYORnXG4pgOM3q6Wt3b03PfCExCs70CoJDYw2oa
        6Ji4BtD8OfM9PAn5kKSKWTY=
X-Google-Smtp-Source: ABdhPJxvQ8WhehZVdy3tmkC1NX1tpqvNgKfauz5YL2BWLrZ5cejOZ7TFVHM3a/I6nIzbe5ep1PnUZQ==
X-Received: by 2002:a1c:acc5:: with SMTP id v188mr25576027wme.60.1622546831842;
        Tue, 01 Jun 2021 04:27:11 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id m65sm7292051wmm.19.2021.06.01.04.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 04:27:10 -0700 (PDT)
Date:   Tue, 1 Jun 2021 13:28:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: devfreq: tegra30-actmon: Convert to
 schema
Message-ID: <YLYZ7qgBP1ZNnM3w@orome.fritz.box>
References: <20210601022319.17938-1-digetx@gmail.com>
 <20210601022319.17938-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="JH7CJL7a1vXi50s7"
Content-Disposition: inline
In-Reply-To: <20210601022319.17938-2-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--JH7CJL7a1vXi50s7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 01, 2021 at 05:23:18AM +0300, Dmitry Osipenko wrote:
> Convert NVIDIA Tegra ACTMON binding to schema.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 ---------
>  .../devfreq/nvidia,tegra30-actmon.yaml        | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,te=
gra30-actmon.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegr=
a30-actmon.yaml

Acked-by: Thierry Reding <treding@nvidia.com>

--JH7CJL7a1vXi50s7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC2Ge4ACgkQ3SOs138+
s6HKuA/6An4z1SGtqnbFCDWDEs+HOPnz4oY3MoRvz3aNdGVM7ihxEoWg60fZU0I1
FO0qOk79VGjonY94IwCyP2hX5iuupnQvI0S/2stHYkh03Ieq57NNLCpZ0Kj9Dm0L
gcaUo6VWiUeD6zKrS3VCO5baBbTFgJeUE1ht4CA5ASyf/L6jJNCeiwzrIBDt0l3D
d97Wp8Xkmrh0enXikio2RuTKS7geTjmnNIbnQP+Jc5z6GYAfv/e48Fpow22Ngy62
695rySSp0s1fm2SPUX+8Yk9y/bsXWaaTgi5yzq3gLARKpIjQxAF1hWG0Ay2++qMj
xFqGhHIZCnn+1AXVo3G7lzR+ZBM99DxZlLf0lGVJbeYaqACGdzorK+6rfjGC9i3e
GPAFi2jz7/lXfQnndDxmdmIlmLy+zMWDdkNWql6vSxW7G8I+u8o+i3KLrYV4YM4v
2sFfoLtDRo/wIW6ASRWiusSJ2yAOStvRKtp7yBjBi75VDff/1j2csaZ/v9c0UBBD
hYuVyqqKuaBiEbHFmJj4eXZP9Teaq8gb8eqGh08xNLJ7EBM97SxvqEb0FAtQ4H+X
r660+OMNujiXzYVXcG6shyLUpDuaqAYSamFeN05jn+OwR+gzRpO3B545qLnT46hl
YzT8y6SldNThhutN91iVHH/ounRJ7R4TXz+4OebA4oCqtdcQ87o=
=zgu9
-----END PGP SIGNATURE-----

--JH7CJL7a1vXi50s7--
