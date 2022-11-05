Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4E61DDFC
	for <lists+linux-pm@lfdr.de>; Sat,  5 Nov 2022 21:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiKEUVb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Nov 2022 16:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiKEUVa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Nov 2022 16:21:30 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFC913DFC;
        Sat,  5 Nov 2022 13:21:30 -0700 (PDT)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E71B66602366;
        Sat,  5 Nov 2022 20:21:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667679689;
        bh=Ju13tIA7HkUYV57aem6z/qdyub2dsPXBhW6VfhnNUh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPy9overUVqP1vkftFHaZx7J3Ualq7YI7gGwM2G+esDeIh5/OBSw/NWTIN9NmXJs0
         xZpUpd9QhM7WQ7ofzb6tOZc25iPfawDALkebig9ahy2MNM6ONgXxu3hEdFNdJigeL4
         vXPYehEGeXMucWLhj7RMhsIdbsNwSoCpDR6995sC8xc+oGNzZ9cD9xEocLY8b0rqY0
         WyFZD1Lfl88Vx6ws0kqve/CwX0tRFsaBf8w/djr7uobM15LhLyJ1YA191CF2+Fv4UT
         zlYIH+eUMS0Co3owrKGHY+7tC8c5cC/d5pg7b7ON08TwrJx4DGJQsKF73+08Qfm821
         y+UARCTocWTsQ==
Received: by mercury (Postfix, from userid 1000)
        id 074A21062C1F; Sat,  5 Nov 2022 21:21:27 +0100 (CET)
Date:   Sat, 5 Nov 2022 21:21:27 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Orson Zhai <orsonzhai@gmail.com>, Lee Jones <lee@kernel.org>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Dmitry Osipenko <digetx@gmail.com>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Purism Kernel Team <kernel@puri.sm>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: power: supply: maxim,max17042: allow
 power-supplies
Message-ID: <20221105202127.yecpvgdqxdarodwb@mercury.elektranox.org>
References: <20221102184501.109148-1-krzysztof.kozlowski@linaro.org>
 <20221102184501.109148-3-krzysztof.kozlowski@linaro.org>
 <166759890804.2894757.9957388407173837405.robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ecarqkduelppuy7j"
Content-Disposition: inline
In-Reply-To: <166759890804.2894757.9957388407173837405.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--ecarqkduelppuy7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 04, 2022 at 04:55:08PM -0500, Rob Herring wrote:
>=20
> On Wed, 02 Nov 2022 14:45:01 -0400, Krzysztof Kozlowski wrote:
> > MAX17042 Fuel Gauge uses power-supplies supplies:
> >=20
> >   arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb: fuel-gauge@36: '=
power-supplies' does not match any of the regexes: 'pinctrl-[0-9]+'
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >=20
> > ---
> >=20
> > Changes since v1:
> > 1. New patch
> > ---
> >  .../devicetree/bindings/power/supply/maxim,max17042.yaml        | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks, queued.

-- Sebastian

--ecarqkduelppuy7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmNmxcYACgkQ2O7X88g7
+prj0A//WtKcjH9Ao7yMy59PQ2I6qxJCNjPM4XNxNVLy0carhItc7vkdDcPj+CZP
sybnYYKkDMnNGYA3v6AnFHM8nqVe/wrSyAUQNUUmGgujyO8ik+psaAuwIUzLDsh/
MCDOSn4BVvGwtm9tRU5kz9p0R1f/Wy9a030irkgYf+S/Z6uJX+yjWDI3YML2fP0N
g5CIkWdI9ILo9JVn0K+0Q6o8Zsq+Y4V1nHiGMb5YM1kmTy+2ptYaLY+NdwK6AX9S
exNOiZIkiFoNwZLYT7f/wRl5u6ZR7xrt62nOBOztSlcBHOPKU6TADi5qP8MTG/ic
qUyknEjQRuIce+KpXBQQPDozqkIl+o9ajEisjebD7GM/eXo51NgtWouGMN7X1C1Q
EThDuv6kqL8vFt6AHzDRZVXYQR7siVWRqSdaqEddmU6uMhQkLHSOdA1WV0NieZjX
LrV1nwgPyyI4+MPaU/Hqjv/LpS6CXG746VG0ATykR6Zk2cYMm0ZcWjfrqPO+6P96
woNESaWyLeUA0FZ+d4I7MlZ6RSStRbd97GIfl98Fw2jhLuSARUtlxAQbibH0yr/w
5cYAPcSLEQhR8yp0QZNk0pYWsqhgJG1NVfhqlfLTTSN54asXAlG8xXPkthv+O1pF
0d0bV33zKL+z4sVNvoYJX4xBckaE/RO48vB+mRBpSanIGnlxXmw=
=FbLi
-----END PGP SIGNATURE-----

--ecarqkduelppuy7j--
