Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F0B2BAFCD
	for <lists+linux-pm@lfdr.de>; Fri, 20 Nov 2020 17:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgKTQOx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Nov 2020 11:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728235AbgKTQOw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Nov 2020 11:14:52 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74621C0613CF;
        Fri, 20 Nov 2020 08:14:52 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id s13so10277029wmh.4;
        Fri, 20 Nov 2020 08:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FFWnWYZcQ5avXl3lvd2ucy1Id+Wc6XT8WzFu7vwWU4Y=;
        b=eQGp8pIUeuaEQeX98mp3aS2FUAXx4MX9UiGAGO7Yo1MJwb29xTS78eD7US7mJoUuwp
         yTQu4jTqmMToVTJbfQ4shkcYXkCfoP7eOyX40A3InPqgm2qfZTMEdbAqHX0gEsMngnGi
         Q17tGnJTYTd5CknrfcI1Bsooz6jwmgE9tmQVFt1BrXh7azL3Z94gjEzgp/HHBRsrSwSJ
         b4uXLFynD2SLH96WUGaKmT2x0TWgKZV/u4u8uZ+QxG+EWNV8V9q+GAXH95oyGwtoD38S
         vLZTrZv7qEfE6NKWo936w+lHvbuuxfbnR2C6orhh3E3wKCWnPpHy/qiFRod1y/iAVSpm
         FoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FFWnWYZcQ5avXl3lvd2ucy1Id+Wc6XT8WzFu7vwWU4Y=;
        b=hMiKGtZ9mV7F75VJLo0ReYwmBE0M/rlFQFNY1IkC+z/P09eHC7KQ4FyejeFn1XZD/g
         RD0wejHkF8Qt6owgtQ6N8J76QFZGyB3jSgZF163IY7p4fnrGYx4NQI01R9W/Up6+zTxc
         /0S1N1YUTI8q92i9kp5SMRp7nIzRdlU8EI+++ULOXayLHbZPfx3wa0/pSzbrmCpoAT0B
         en4n1pLK097HjNKQdwJxBWc/T1LmCwj/ftPjIgqlZ/P9XWsKJAez+shREioA6LWOABb+
         pRM0Od3EswHL8LFwdsdL/qVJU/fIrbKXIswwhEqO2wPpiIHqg1Rr0TK87DaH4YyFLi4j
         cubw==
X-Gm-Message-State: AOAM532l69EuXFiynSssOqF3dEtzkOVx72EnCgrCYgedbyFh1zzIK2IZ
        nTvJXjTNBfsktOjUPpJEN9E=
X-Google-Smtp-Source: ABdhPJy2XDgwijo8VaB2DZKlnUp9CeN+gXcDNcwMD49y9cuFoUIVK5sJ09f1xY7XwSVPO2PjwcMEsA==
X-Received: by 2002:a1c:98c7:: with SMTP id a190mr10185952wme.7.1605888891255;
        Fri, 20 Nov 2020 08:14:51 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id i16sm5521078wru.92.2020.11.20.08.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:14:50 -0800 (PST)
Date:   Fri, 20 Nov 2020 17:14:48 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nicolas Chauvet <kwizart@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/6] thermal: tegra: soctherm bugfixes
Message-ID: <20201120161448.GB3870099@ulmo>
References: <20200927150956.34609-1-kwizart@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SkvwRMAIpAhPCcCJ"
Content-Disposition: inline
In-Reply-To: <20200927150956.34609-1-kwizart@gmail.com>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--SkvwRMAIpAhPCcCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2020 at 05:09:50PM +0200, Nicolas Chauvet wrote:
> When using tegra_soctherm driver on jetson-tk1, the following messages
> can be seen:
> from kernel: tegra_soctherm 700e2000.thermal-sensor:
>  throttle-cfg: heavy: no throt prop or invalid prop
>  soctherm: trip temperature -2147483647 forced to -127000
>  thermtrip: will shut down when cpu reaches 101000 mC
>  soctherm: trip temperature -2147483647 forced to -127000
>  thermtrip: will shut down when gpu reaches 101000 mC
>  soctherm: trip temperature -2147483647 forced to -127000
>  thermtrip: will shut down when pll reaches 103000 mC
>  throttrip: pll: missing hot temperature
>  soctherm: trip temperature -2147483647 forced to -127000
>  thermtrip: will shut down when mem reaches 101000 mC
>  throttrip: mem: missing hot temperature
>  IRQ index 1 not found
>=20
> This serie fixes two errors and two warnings that are reported in dmesg
> It was compiled and tested at runtime on jetson-tk1 only.
>=20
>=20
> v2:
>  * Add missing tegra210 device-tree properties
>  * Add the appropriate prefix for tegra soctherm
>  * Use SoCs condition over of_compatible
>=20
>=20
> Nicolas Chauvet (6):
>   ARM: tegra: Add missing gpu-throt-level to tegra124 soctherm
>   ARM: tegra: Add missing hot temperatures to tegra124 thermal-zones
>   arm64: tegra: Add missing hot temperatures to tegra132 thermal-zones
>   arm64: tegra: Add missing gpu-throt-level to tegra210 soctherm
>   arm64: tegra: Add missing hot temperatures to tegra210 thermal-zones

I've applied all these...

>   thermal: tegra: Avoid setting edp_irq when not relevant

and sent out a couple of patches that should make this obsolete since
the EDP IRQ does exist on Tegra124/Tegra132 according to the TRM.

Thierry

--SkvwRMAIpAhPCcCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+363gACgkQ3SOs138+
s6H2pQ/+MMxiIBRFmy/6/dypVrPooc60WsIjc80GtgWVNO+IPPV5ul7P/WWg3f0s
8v5ouEIeZxJgI/EV1mpXaDH4GjQfCFacRyxE/PcjFywqGduF8NhvvwIjnoAboQKK
FIzVrbZfsq0uc/2i9p+d1O7YFS+WJze4calgn37qY4qMdMBesiuZoLx06Pqa35P8
KO2/h6EsnokqmQMivYuu2ilkk9c44sCgGJ0cfJv8FLsLFYvEnWYZYvmoZ+y23SDO
aJhgAirhjq9HRt82kKIxU0jQnxdtiJlbaM4EYxthFTypXUHTI2+ma70Q1B7U2JJU
ElbfGdrtU9QnAVR1v9xAMVwwVKPe0JKWFC54uZauxE3MWtw1OZEnv66z8lmhvN7G
EiNS5TYUCItV4LYopqGOxTiGXhsMmrSwbqgeSHrnnKG23ha7OfBGx9QPNatsCnJP
3fpymVo+dKpEoDlB8gTZJ7F2cNxBOqSiK50cy9+vn52AzI5LG0jLq6uwZD8AtaZZ
Z5/jtgpMqWQaqSdQtj///19fGI2fwX51rNjvjSVFPx0dhuXuco7P+GKHgePCvZDR
HMDlHqelHsB7AH5369diVMtTo8Eby/HUzCKGnc2IwEdBCB56b6gJsyA3pYTJ8m7/
jsoT7fpA2h1dCxmkSmwFI/GQhmvGFOhvxEa0IFnhj6mia22zq+M=
=7fGd
-----END PGP SIGNATURE-----

--SkvwRMAIpAhPCcCJ--
