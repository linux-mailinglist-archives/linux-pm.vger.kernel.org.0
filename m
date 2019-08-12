Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D897589B25
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfHLKRZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 06:17:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52127 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbfHLKRZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 06:17:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so11634786wma.1;
        Mon, 12 Aug 2019 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LUHWKrlv3HNtE6WpJRs+ppErRQ6HyXfaAOYd1oUIeGU=;
        b=sVDlNwPpgC0BjkbGpvQSy6teOifCQbvM2HlnPdr7U5LwsO8+cxBqUjRCwp8aJ6xkZh
         ASicGs8CwoyzR2ofwu057jmzmglvjG1NN8/QmYLVsruez8RLMxALvmOILlnqkyoOvjXX
         CiPuIxuMdogKBY17+M1+IE5Kg/dl4/oe+sWUnF/Ke6I0fV9066nTqIUgwS4vI25Rq7Kh
         /CPH/oIvMV9GW70oeiM5galSSxnGHC45npBkuNZUDj1l3qcuuTEt6t+FkIKFdmleYULx
         1tYWf7L39zd6NPkbVlqYBp7DUs6sSaly6qJheh+YMvHGxmfAIJUlvfYA6Q6oQ4H5Zz8Z
         xEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LUHWKrlv3HNtE6WpJRs+ppErRQ6HyXfaAOYd1oUIeGU=;
        b=JLNsUPmVbZ3kWAptEG92PRFchja3DXGHMeDHwbSkfhg6eZnNwgz2x8pV/58FbSqkQf
         JT/6WT0Bl5ssrcsauIFXhqFpFZuj3IMXe23+nhPv1d7sqgjMOOLLC4CnepsxhBDpLKzD
         1rVmLPCSRp7/OkTIHJDqVXIICWptcHD04HAfx9ULrwemfzsFkFTKMQjtdHc+n8CA0A5e
         SWyJtUtzjHiIS6W6b1jD47GQeTBxL8PviloKJhG0hJkj4wrwIh0Hkx/EKO3lAj2YXTdI
         KCrBDz2GDZySLWc7OFWeV53ZJDvYtXyCh6ZCE4CAswBK+K8S2rFmcBaHxIwDZPA+EKY5
         WmNQ==
X-Gm-Message-State: APjAAAVrkI6ptjuGMpgbI7Csax+SZwv93pbabCadgwrn1TGDV6up8pQo
        P4128PWnFqh17mKFNVG+0iE=
X-Google-Smtp-Source: APXvYqxTMqUT3tDz+Un7sn3NhO7hRNUeoeo7EqzcAubtM2zorEDjYyk+JdHHwdp2Rd4EpMEETtzKLw==
X-Received: by 2002:a7b:ce0b:: with SMTP id m11mr21097940wmc.151.1565605042377;
        Mon, 12 Aug 2019 03:17:22 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id z5sm10900441wmf.48.2019.08.12.03.17.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 03:17:20 -0700 (PDT)
Date:   Mon, 12 Aug 2019 12:17:19 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, tglx@linutronix.de, jason@lakedaemon.net,
        marc.zyngier@arm.com, linus.walleij@linaro.org, stefan@agner.ch,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, jckuo@nvidia.com, josephl@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, mperttunen@nvidia.com,
        spatra@nvidia.com, robh+dt@kernel.org, digetx@gmail.com,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v8 14/21] clk: tegra210: Add suspend and resume support
Message-ID: <20190812101719.GL8903@ulmo>
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-15-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3xQkynibq3FKlJyM"
Content-Disposition: inline
In-Reply-To: <1565308020-31952-15-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--3xQkynibq3FKlJyM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:46:53PM -0700, Sowjanya Komatineni wrote:
> This patch adds support for clk: tegra210: suspend-resume.
>=20
> All the CAR controller settings are lost on suspend when core
> power goes off.
>=20
> This patch has implementation for saving and restoring all PLLs
> and clocks context during system suspend and resume to have the
> clocks back to same state for normal operation.
>=20
> Clock driver suspend and resume are registered as syscore_ops as clocks
> restore need to happen before the other drivers resume to have all their
> clocks back to the same state as before suspend.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra210.c | 103 +++++++++++++++++++++++++++++++++=
++++--
>  drivers/clk/tegra/clk.c          |  64 ++++++++++++++++++++++++
>  drivers/clk/tegra/clk.h          |   3 ++
>  3 files changed, 166 insertions(+), 4 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--3xQkynibq3FKlJyM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl1RPK0ACgkQ3SOs138+
s6EALw//YUajBdPK4FtVwcA4OIK8GLJi4rRvPYUFKpGPdKoebx0XvmddXHMql1jz
Z/X4hPffkZ3qc7Dk849Dqqkr8pX3FFUKjIrn4HdlNYxXcHzGjtI3/FR5AA3VleFN
UcgaqzN248n5VL7QDw1xdwJ/OG1rluR9TbHx/Lqido8ohbGmeebrcSyqs9eeU92R
dpFqewgNOyBrr07g3yMgyV/ntGvFqBqjb48PLgZnXNhgt08N5F8P/hypIACSwE3N
o0q1GY/J8mzIRFWwOMRkw2I7NkHto07C+lumrq8R0UqtdVYC5j33lnnw6L7BhQcQ
ElQpej6y3XAMKTQt74Gf6bM3nYfJyiyh6c0MqGISkQOR5k6pBYXljOJlsIAOL3Qw
8adsNWCiEdaYPH6jWtm9I2PRRl2f2js9rMBla8RUW93e00lcN2JI4jLv/DkM/Rgf
0hiwsEn0UelnV0GlvecbbVMvWElj6OsdtkRprJ0tlu0UD9LEwvnkMlKikiJuFgq5
Bf1F89JCeMGixa+oLU1+R7zsSW5TiHuFcoUJZwB7okUIEN+i/3ZjfHlwh/iWOPx4
NffENeaDzZ/Pt0oMzEjNde9O5ezWXjOcOk5Hvq5b42CWoybtC+SLFV9MTNBYfaZb
hHwouuAzg/pvY2TBrNCm10lvbeoYBaINg+HwCcCxLZvUvBsQnEE=
=zcts
-----END PGP SIGNATURE-----

--3xQkynibq3FKlJyM--
