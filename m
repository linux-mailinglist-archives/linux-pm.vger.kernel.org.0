Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC588101947
	for <lists+linux-pm@lfdr.de>; Tue, 19 Nov 2019 07:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfKSGWB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Nov 2019 01:22:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39032 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfKSGWB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2019 01:22:01 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so22324068wrp.6;
        Mon, 18 Nov 2019 22:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1rucZOnyetLd94mF1aXTUSwUZpO4J9hb+NJb0ai8vFE=;
        b=cqOldHL2Fbskf34UXRisIW8xfOKPOpcaEkt7VJOpETlRI8EiQ4v/xXBmAnZHJ02r+b
         7linaddW0d7+9jU49067+BKYqjMGCgzLWJRAU8KfYJeNy/JXC6sSg6kS+NFQ0EzsMdAx
         cJbzmzcyPxHaeMTbBk7KVpST2zXgyeDTGg4I+thz0wdFHUsYgYu8F9qOtkmiyO3Ar9To
         RtH4uEfax7k1hjKqLA3+fK48l33LoZVtYzYSNY0FyDUnZJytCGq5So+XpbxBdfu9sJuq
         zlXBbX/uWQLmJLqXWCUbJLcpSVtntvB+igtW00Ud25KD7hy4g5jLzO58gljcf6CKk/jj
         mm3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1rucZOnyetLd94mF1aXTUSwUZpO4J9hb+NJb0ai8vFE=;
        b=KYmPaxYqkpl9wyzT1L1ofz/dBo/7uHWqAg8SBYEfmiaM6K2Q2eY1OK0TO+NdjqLDtr
         1zhg4cPUVRYp+6XyllgFgll9pYMU0ILVGpOa4BnQ0yRRXGkN9Y35XMeVnhs+w629jup2
         ZRiAIe3vo8Swz03sZHe1MOz0qSm5jnLeWrMw4+9y8IZYLBjN+tZuThICVmRSPv4Zwn0E
         VFwBB95zcUVydkYrTDtxph0QMquvWQefTslDFZVPVz6dQ6/WZHtSq4YoT8eInxlzrZF6
         zCH2Nzk4y7aOyLQ1SXgKK0J3wTqj8zGyqc830hiwo8y/IEPKayT2OnPRvQT5ALNYSUQQ
         psAw==
X-Gm-Message-State: APjAAAWqgupbKQIS2D4jW9C+tzmXkvX5nyVTwBhgFqCjc5gtMv2jNydc
        FAbdu9hjSvcX1upjQgLyTqA=
X-Google-Smtp-Source: APXvYqwhxSs5gn497nXuCyF13nOyYh9LQMvu3SeCm3wVm8i6pXsyt6Zi+dsn8Nll6z4VgyQ3J4rHDQ==
X-Received: by 2002:adf:f282:: with SMTP id k2mr938619wro.387.1574144518738;
        Mon, 18 Nov 2019 22:21:58 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id v6sm26570144wrt.13.2019.11.18.22.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 22:21:57 -0800 (PST)
Date:   Tue, 19 Nov 2019 07:21:56 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 02/29] dt-bindings: memory: tegra20: emc: Document new
 interconnect property
Message-ID: <20191119062156.GB2462695@ulmo>
References: <20191118200247.3567-1-digetx@gmail.com>
 <20191118200247.3567-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Content-Disposition: inline
In-Reply-To: <20191118200247.3567-3-digetx@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 11:02:20PM +0300, Dmitry Osipenko wrote:
> External memory controller is interconnected with memory controller and
> with external memory. Document new interconnect property which designates
> external memory controller as interconnect provider.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra20-emc.txt        | 4 ++++
>  1 file changed, 4 insertions(+)

Do we really want to describe this particular connection? It's pretty
static and the only real connection here is the EMC frequency, so the
whole interconnect infrastructure seems a bit overkill.

Sounds to me like we could piggyback on top of the existing
nvidia,memory-controller property of the EMC to make the connection.

Thierry

>=20
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,=
tegra20-emc.txt b/Documentation/devicetree/bindings/memory-controllers/nvid=
ia,tegra20-emc.txt
> index add95367640b..7566d883f921 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20=
-emc.txt
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20=
-emc.txt
> @@ -12,6 +12,9 @@ Properties:
>    irrespective of ram-code configuration.
>  - interrupts : Should contain EMC General interrupt.
>  - clocks : Should contain EMC clock.
> +- #interconnect-cells : Should be 1. This cell represents external memory
> +  interconnect. The assignments may be found in header file
> +  <dt-bindings/interconnect/tegra-icc.h>.
> =20
>  Child device nodes describe the memory settings for different configurat=
ions and clock rates.
> =20
> @@ -20,6 +23,7 @@ Example:
>  	memory-controller@7000f400 {
>  		#address-cells =3D < 1 >;
>  		#size-cells =3D < 0 >;
> +		#interconnect-cells =3D < 1 >;
>  		compatible =3D "nvidia,tegra20-emc";
>  		reg =3D <0x7000f4000 0x200>;
>  		interrupts =3D <0 78 0x04>;
> --=20
> 2.23.0
>=20

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3TigQACgkQ3SOs138+
s6G61A//YQ1bHyFyTWdlNKJqA9a7DjovHIcjcT3WDnbK6wRVgBR3Tp5l7VeVBU8+
uZrFCL1O8xk48XDUgEYlhLsdy/270Yv5dET6tw4ZnPxTsV8Npe/30cgwOpaI/jpA
ARHft7E8Wo6wl7ND1mXH1eJAgoOOHvXfF1fqeaCC1koZSDNR+S0K4RlzjUA8Mnwq
pL8IWCUR0j4qVKpR0W1b23EVIzdR2AGwx9eh34yFcsvofuc/JXAD/8c4L6X6gVOR
4W5OmiM/2XKPAhMgCYskLgJd7EAXop74GWHeXk5s7eePQdiA+NRAFCCFsQeY45qK
6ixWzORLpQeAuSVFLLBikA7wF6Qg/kHkEI/2OXuK/dKVoRqkDaOPq76lfhQEOpHn
JMlwk09OHNTJK1jqeW5+L4S7MhWJiOM159LG6Qf4/ynfXnv+ntbak4AlpzPUmuAU
4j2oHWHnzcCcBHSCkREHc1LvNDBrS3jXgwynxzhekpWDEEnpQl4vyiMPww8zT47j
jbHWifgp4cGH9dqbUKjo1JwgxktQNksLGUyceuGBlQVmlnEhoP678RCyQloiluYN
WmkMtgUU6U4IXHjLh++bsAWQ3L83B5h9aQr3mqAzlqC4nyg0hs+T4PGzVFQHKZBo
ecnLi7yruBFGflWvgMpsO/JLBecsGZO2mS1tiH9sigxYS3FXKT8=
=wXrm
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
