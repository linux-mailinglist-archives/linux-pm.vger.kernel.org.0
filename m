Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2832E74F3EE
	for <lists+linux-pm@lfdr.de>; Tue, 11 Jul 2023 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjGKPnp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Jul 2023 11:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjGKPnI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Jul 2023 11:43:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A18C10EA;
        Tue, 11 Jul 2023 08:42:54 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc244d384so60339435e9.0;
        Tue, 11 Jul 2023 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689090173; x=1691682173;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dYkIVAZXWVX4d2XXeeAGh0C7Fz570/7R4cfKcgzr7xM=;
        b=T2CpvTIaIbPDKjJ5YVIA4ke79D2vU13ltJkDu3hEYYT38x9IvL0ujvxlw7yFVfesbN
         U48N4AJ3OUkwGg5ea/5jzux45iFRoWq9o4x5OVFko73IoWlz8M3OCnsfiApLP9OHSzKi
         sn9uaW7ZoxxyXG0f5Z2B47vhoh3UIVuDPdpo8GZE4jK+rzSrXtAHS6AJLvIVZ5VwXLga
         /xc1q9dDQT9mB867Wa0DfMbNsDXP9rLUPTdA1GiZRc5691ige8/jyuZEyjkK7GuS682O
         8VGVv/hbZ+3WH3Br1UafqwtzxnQqrkqKqJt1GRdnw7TWSzZq0xZD882vkKTX/hcfyiQT
         no0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689090173; x=1691682173;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYkIVAZXWVX4d2XXeeAGh0C7Fz570/7R4cfKcgzr7xM=;
        b=C7VLcnm+VFrfpKcGSsiLZrbGvYTul1L7dP10hBscN1n2qUge8X4/OJ2Vlt1eiIqusB
         MS0q9nyXJBxWNUoFcBNL9goPxYpW065Tgn8qf5E6mEJODuKY6Vu66gLlyV6m0CXYzgL2
         eplhGu4kNSxOat635PbGsZLU50174TDsXGJEW2VNpOGHNnbgCF4nTjUBfIfuEaeOXWyl
         LoqYbVUOPweGetouzSoYTZtNVLhl8mh8CfrGK7tilWskqbVseq5141oH1Ecrbu7Pq+uE
         +u0K+hw7A+oadFub0dF5XH3JbF6j1dQxKJl2G9XBIzCk4YboQLsSfg1j1JIAVB0dt9AE
         9tzw==
X-Gm-Message-State: ABy/qLb9R9PB7MBywzVq638xOeRIcWOhab5Ac/YOmIAWJ95gRcUqIWSt
        3WNqaatDSn2R0ojWo85lS3NGfpH1pAM=
X-Google-Smtp-Source: APBJJlFW86hBRt0IpFq/pliN6JI4YKtM0YwYa0MQwtzpGnECPTVzremtVJfCW2S2nC8lLTC/Aws1qw==
X-Received: by 2002:a05:600c:234b:b0:3fc:dd9:91fd with SMTP id 11-20020a05600c234b00b003fc0dd991fdmr7229551wmq.40.1689090172348;
        Tue, 11 Jul 2023 08:42:52 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bcb0a000000b003fb739d27aesm13212223wmj.35.2023.07.11.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 08:42:51 -0700 (PDT)
Date:   Tue, 11 Jul 2023 17:42:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jon Hunter <jonathanh@nvidia.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 00/10] thermal: tegra: Do not register cooling device
Message-ID: <ZK14edZUih1kH_sZ@orome>
References: <20230414125721.1043589-1-thierry.reding@gmail.com>
 <fa218582-0ac1-ea8e-fcaf-222bdcf2bc6a@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DlpEOaqtXO5oFliO"
Content-Disposition: inline
In-Reply-To: <fa218582-0ac1-ea8e-fcaf-222bdcf2bc6a@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--DlpEOaqtXO5oFliO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 11, 2023 at 10:25:16AM +0200, Daniel Lezcano wrote:
> Hi Thierry,
>=20
> do you have an update for this series?

Yeah, I've been working on this on and off for a while since I ran into
some complications with this version. I need to find a block of spare
time to go over the latest version again and do some testing. Hopefully
I can get around to that within this week or next.

Thierry

--DlpEOaqtXO5oFliO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSteHkACgkQ3SOs138+
s6GELRAAh3ZZvukzF3k/5LWmdv2+B+5P8ow14YghjTcKEGabnDXfWVbculyh2MgD
5sClWfrFlsx5ohAsOSAtImsnqmOGeXH9pMPukBVYYfNGVRy11r1oX6l1NWRc1EwA
8fYjseIMPaUqwOLD2Q/i9Ksjc4PtAqeloH+UI6iNZI/Z7SrUgtLRBGdtkNjW3nNj
9LjuDZtb+pad0iV7Ij4L1F6K6Vkem6/81LADfT+hhb2n6A/Ynk9KlXtYHySqQVAF
SyOk3dVBo8i8g//kxjOPdiXd4pFF3YKyGMt3t9sQqFQwFD9X639MYxpxmxwSU+Ji
4JaOxjV99p1meA9OKAKrZO9e6QlmEdaEuiA3T13/8DQ7pp4Nx9NI3DO5iUeJZ6/A
Hg5qN+tmwcM7To3TVWvsc+WompqJ1HZ4gmJ1sffIKc/7akRV7uqc0UFI8w4fTK8a
m1lOxmzDctvpgLz+yF18yNvSZhoUvljXarhy6TC16EoYWf1ozt57zXG1kPmPnnDc
+EnTRysa1MXSRUm8OFEvv33PmY6f4SMA0RvDlROxcfXyy698OFm6cMLXMBL48PSi
2c+YpR8CfAvYXxCqpRSbPBRY+EFDeEVccdjDsUFEx73MItKbq4I77MjNUvg9yXHz
2BHR2ejRKyLSN55o2bl5SukcJUXgRGdGMiaF3lu0B2HtxhispL8=
=qpDd
-----END PGP SIGNATURE-----

--DlpEOaqtXO5oFliO--
