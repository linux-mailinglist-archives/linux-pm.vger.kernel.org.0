Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFD23E8944
	for <lists+linux-pm@lfdr.de>; Tue, 29 Oct 2019 14:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfJ2NTU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 29 Oct 2019 09:19:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34685 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388119AbfJ2NTU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Oct 2019 09:19:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id v3so1979497wmh.1;
        Tue, 29 Oct 2019 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kdxUMNyvrqmNDL+Yjr/LEjpSdNLrL+LPXt7veHoTwW4=;
        b=b3wSn23Z4i+0IrRlbFOcNoWAIP/x9vHeXOi8LxwEGCEA/ONEmNtnfL7pRIn2SkrKvr
         7mg2RR9IVPf7mxxXUsz27+YUEs/jiL9mroJN2miG+VYnEzEr/5nlO32gkKu1+r+okF7w
         nWJpkzZtTHi+K768tIS1ObSpSTU7Okmcp7/J3JoryOgg/degccm9PWwWlWBtmL9Blhsg
         8ZT6E1GF1Zpp4XNLDjD8rnJqlr6a068cnIhw8iAZfTeeWNaISiJs/voLdFBpZZtd56cR
         Pju3LuYMwo3XqjoaBus4UgTyaVadHgUU69C/zYsjwiZ8Cr1az95HK4N8AuPS2Lr3GCwo
         JIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kdxUMNyvrqmNDL+Yjr/LEjpSdNLrL+LPXt7veHoTwW4=;
        b=uR06uwASJruwRdivIeREkQnDq/NH8lu8K3sp+BpuIr9NPqp9H5sxzPrxJGIlpAMucZ
         f9vIKJZOkeWD/fjkyQ0krHwvepq8HBMBgAbSGLbGkcir/rJ9YLysU7tuY49W2xK3T4Jg
         MLszml8xECSw70SsAXsQXszncs+qStFd25Iys0uNzkDxpuvlknhLYT3yJStLyLm+hRdC
         crDKR9nBJqHvbuLcDQ7fNbl4GQLdowxRxmExLDxTROizfUuTGPWzrnxGYRniUOI90BFy
         CZPvHceN8Hrnukldt52CxITlPBnjaHksqAdsdwqHEokRfQKbRnboqtEikk8oRvYSuCfD
         SLIA==
X-Gm-Message-State: APjAAAVbKwYq1aEVfT8RrqcRdSZ2SoKVOLfn11sj8RCdDjUMk9hn8Nox
        zsaNnc9yhyB/kptxhttYB4btGX5A
X-Google-Smtp-Source: APXvYqxZTORaJEUXE+fRevzkoDHJ0mmVXxjMng546tuGAb05XITEMi0ysWfNJUsxW/dkz4mBlx57Iw==
X-Received: by 2002:a1c:a90f:: with SMTP id s15mr4115278wme.100.1572355157476;
        Tue, 29 Oct 2019 06:19:17 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id 200sm3330915wme.32.2019.10.29.06.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:19:16 -0700 (PDT)
Date:   Tue, 29 Oct 2019 14:19:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 09/18] clk: tegra: Add missing stubs for the case of
 !CONFIG_PM_SLEEP
Message-ID: <20191029131915.GE508460@ulmo>
References: <20191015170015.1135-1-digetx@gmail.com>
 <20191015170015.1135-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
Content-Disposition: inline
In-Reply-To: <20191015170015.1135-10-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2019 at 08:00:06PM +0300, Dmitry Osipenko wrote:
> The new CPUIDLE driver uses the Tegra's CLK API and that driver won't
> strictly depend on CONFIG_PM_SLEEP, hence add the required stubs in
> order to allow compiling of the new driver with the CONFIG_PM_SLEEP=3Dn.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  include/linux/clk/tegra.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Applied to for-5.5/clk, thanks.

Thierry

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl24PFIACgkQ3SOs138+
s6GpQA/+ObhDGFKfUw2kmzmVofglBZKfac9iUKEOtJRjpACY1HQzbddmh7XDV0kz
x3ZpXS/64v2SYFT1MEDg+P0HIE9VEMhn0gTuht4eH6koVffOmKQW0mMcnmNXA0vT
Xz4DSqpdEa+1povmLaifTj6FAGsuT2FQXuK+eWA0UFkW3407KhhazMuwuJvlQ77J
0bq78zIdwRH33kP6MgZvTF94dggX02TsRt8x3FQxGjo6lxan5qe18h06/sTUGW4j
QvshCliwMiCaSskcQCULJYuRX9f54Iu6HkcmqURzP1LohAM4o7NnFboxKorGQAbY
76j6WB6i7O5isg5Ng0wV3YH/xHTuptMzX12iniF3BqwYWXab2J2qyNQ7ipnFlDvY
Y9m2caM4cPfILsUozrjvQqGWOkg8EujGzDhEOkqwGI1zj2rE0QzSTZbYFLYNp2ka
jHVMR+TN2Q4pwBTOPmJ4r2hPoy9KvTTEfLMU6T931lPPjNSKONvlr0oNz7fxVE2H
1adqcQRShR6hM1UzuFA3J9mjP8bqYFPYRIMVazpM6nQMwHTDSq9j/IIHp7LpFuVr
uDxLZYmA+mP7Sbo2eBAK3qwrR2Hgnyv4+tyLquKGuns+1mdP2B3+Nkw8Xrpf8b5c
RRWen5QU639f+YV7G6qxSxhljZri59qMYqGoQojtUZxIvMdNtyo=
=lnmo
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
