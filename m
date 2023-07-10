Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C90474D917
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 16:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjGJOeV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 10:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJOeU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 10:34:20 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10A8F1;
        Mon, 10 Jul 2023 07:34:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992f6d7c7fbso589117866b.3;
        Mon, 10 Jul 2023 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688999658; x=1691591658;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VcKK1Rn8MBifaFhnfJH1d1V6xUVFxqhh/HMxXJpwRg=;
        b=NuPD+2FakNFFQWksx7/KRk7jDKLGC//fliR3u8qCDcDL0QfvBa0xke62DVRz8lqLkD
         NSXoNNQyjQjCBXP6/WpRxKKO8hRtZ1NDjOvy8ZLbDUsy0D8uNYroIIsiTZoFN8hz/Xsj
         0Dh0FI4767cdlh8QCIBhOb6+NOkykfmt1Q+HJ2CxWFg6gabbTwKtOWm/0VwPddafFCHW
         C074kNK0s6Uepl4r/z3yVsYr1mBdhhxetvmGJt98EJ6qPJVn5tlmlSHU34xPFfpuIUme
         FWaRKe8brB/Lwc6RxOhv1q2RFpEAy8hbnFTDR4r8ptazzswJQwW2OR8hNG6FLs5yi3XI
         8ZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688999658; x=1691591658;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VcKK1Rn8MBifaFhnfJH1d1V6xUVFxqhh/HMxXJpwRg=;
        b=T3AUXyKkxQ1qmUxVKFTvo65pmcq26O+yMYN2DOkYIoBm/hAhfdoUy+XhtayOM82dg1
         x+k9ShirQC1iyFxgYOWcTBcXgovif4FY3EpdoI22q4VDeh4nL+1W7ZONoOAMv9PW6pF7
         sT/0l4IQbx/xX/OaLLIpD/IPrBz/RHEukbdYRB4ITDMWCUGEKf78iCpbupmPlLHWrym3
         6QICS6ovmnkJoqp3bpONwuLM59CRny/pKJNxR3V1HhiHg6yrLWamhL5hW0J8eZadrne8
         HhBgGfQXJLi9DPixuHYOtg1BugraVsb0R/YP6A8L1OwmOCuPQQ7HhEouu+BCT3Web5V+
         Pnxw==
X-Gm-Message-State: ABy/qLYCSUsC+YawJM5/+uSKgsVwNOV/zSpvRGiv25WLGhv4Y9dwYK5d
        qCve2W7IMKcjRA4qNn2ucy4=
X-Google-Smtp-Source: APBJJlGmy5cIfvmO3gYMnka5MY13S83UelOEPHJr4A1Iue79HwEh6hYNV6Y8xpig8ySSxtuemoDdkQ==
X-Received: by 2002:a17:906:7a08:b0:974:1ef1:81ad with SMTP id d8-20020a1709067a0800b009741ef181admr13253437ejo.4.1688999658062;
        Mon, 10 Jul 2023 07:34:18 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906854700b00993b381f808sm6250529ejy.38.2023.07.10.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 07:34:17 -0700 (PDT)
Date:   Mon, 10 Jul 2023 16:34:15 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: tegra: Convert to json-schema
Message-ID: <ZKwW58xHD0cGfxvM@orome>
References: <20230707133333.2998802-1-thierry.reding@gmail.com>
 <d6386a66-4cc2-9358-e65e-b09e614800c3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p2dfuO8HITkMwyVw"
Content-Disposition: inline
In-Reply-To: <d6386a66-4cc2-9358-e65e-b09e614800c3@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--p2dfuO8HITkMwyVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 10, 2023 at 10:09:18AM +0200, Krzysztof Kozlowski wrote:
> On 07/07/2023 15:33, Thierry Reding wrote:
[...]
> > +          nvidia,cpu-throt-percent:
>=20
> Missing type

Isn't this already taken care of by core/property-units.yaml? That has
anything matching "-percent$" marked as int32-array. I suppose I could
override this with just uint32 to narrow it further down, but I was
under the impression that overriding standard properties this way was
frowned upon.

Thierry

--p2dfuO8HITkMwyVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSsFuUACgkQ3SOs138+
s6HfuxAAhFZs3b1U1LjUvi/cPFPraGPcqmUsGdwwk1bvW6/1by0VLppetoF+LZzN
b2xeZI9xyqaGZVwbBclqoKzNryz1Epuj9zEMKuCTyvczFEEJdbdnde6mWuVlgYVB
vnEX0hm56lWFjah3+QrQj0QZLVSeeNWpmRSL+eDI99Ar90inQuKfVCvXZpYsa5QV
HCwKL4EE05b11W7O97ZECKDwhurLf8TkErXmR6RLwXsn3LymqkzsMVE4aKCV1kox
15xPszIA17k7AYCsgIQVXmJXIwZcI4fpQq+VfjD/gzPwVk7o6k/Ctqp8mUyuITsE
jKSsHwe/i/qwmgJbrEv867SvQZssEuLVzILsWHPOJmyR+mlHqIHGKEjwtsgrS6eT
xMSIr53353z8bvtI6vUEsNSbryNnSUwl0Ly7rbvDcBkhclJ7ODCfeXLiD+QwHYdd
4qqFg9Y8QLMNCx6G7hFSjCkfOJbr5zBX/6rVJct/fttR19sWMMVuq7m8RpY+d4ha
dQQDQtntbo6WtdCM8uO73nbesb8Hp3+ePY8APHpWh9UxSLwuTyprjpwBahBfiPY0
gKgOs0tK94m4bAlL5A7N/+9C/igB6/hhHvGfUwcbQTUCvPwSU/9ZBHtI7b/Rhqb+
lZOSSAz1SZWif+TROMK3l6buxvWruTLEVIJ+P3sw4UnMz8tZVkk=
=C7Jj
-----END PGP SIGNATURE-----

--p2dfuO8HITkMwyVw--
