Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E27395822
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 11:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhEaJgk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 05:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhEaJgj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 05:36:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE5C061574;
        Mon, 31 May 2021 02:34:58 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so9226229wmc.0;
        Mon, 31 May 2021 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2W2a29UkYdWIPCQ3C6EBVixN1OZ2VkToAWAecp/EpX8=;
        b=YVJdRT0FnbiCRcP0ITT5KkT/t+E8K8/w4NnJRZkIQIyhd58oOHJ2XWdcxFdxpdsIqP
         G18orNJvNB5VjQ4ML31ZhhJaOk4tgDD04PhKJ3JlJM9mow6IhP+IM4LF2+c9cgVgOu76
         0tyDm8cMwlHOlnKnP0TT6ALG5H5c4WdoEdIURiFnFw8YYTMblEYlHCBAp2Yt2GEfNLei
         sNY9asUby+eX9aG25FkcVWYIlIsvx3hxtqqWyMWCW8NMQOnUFo4sANL0Qp3ZPkq0mIg4
         KDkXsyMH+jo6zjbvh8FSdEweKAz74Y6ILKWk66h01Uswgt0FFFs7tY2LYo49na79msx8
         N5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2W2a29UkYdWIPCQ3C6EBVixN1OZ2VkToAWAecp/EpX8=;
        b=I0qO1cKzV1rBQbcGY9Oo1Wc1FcPy6wvWlbUE3UIN1Z5yHRXKIO2ciMHem3H6WC0o4H
         clzPeg2KZ+MMwQCxrsvjbJDfPJm/Kh34oHcPuQrEhPheyT5vyLSts9TtdpG5GZGbsfE+
         RqcD7jddTcy4pm+YjmXghuofEVJVxsNA+sfwtXdMyvPxxutsBS4sKeit/c78xL4HGuSf
         1ryRDfEelYNkTgivWaQyI/aKjmiuYuN0Q7wjFF1kIO+ftmgma2o26brBgXqZz9JnG6Xb
         0UKCq5lQiuNsNJTyTRTgZrz8Xyp0OD2faJIKmAdnZ8D/a0mBBp+gR/1YzMYHl0TA/v8+
         KF7A==
X-Gm-Message-State: AOAM5323RwdE34H50FBh6lS8zPzIVD1AAbH2eM43kW3KweDHtkqLMrDG
        3wyJffogWehbjDclYzGiGBhxooLNwHQ=
X-Google-Smtp-Source: ABdhPJz2JWoIFrUNYbYz5RqG9kJ2dw/Du7UKX0Tv2ZUaY/vqFKp+DHXVzAnz69oF6ZH9I0nAjMu2ww==
X-Received: by 2002:a7b:c002:: with SMTP id c2mr20356102wmb.118.1622453697212;
        Mon, 31 May 2021 02:34:57 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id f18sm691284wmj.13.2021.05.31.02.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 02:34:56 -0700 (PDT)
Date:   Mon, 31 May 2021 11:36:29 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 3/7] dt-bindings: devfreq: tegra30-actmon: Convert to
 schema
Message-ID: <YLSuHejkyPg+DJ0Y@orome.fritz.box>
References: <20210510211008.30300-1-digetx@gmail.com>
 <20210510211008.30300-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lw9R1wTkEeyLOXza"
Content-Disposition: inline
In-Reply-To: <20210510211008.30300-4-digetx@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--lw9R1wTkEeyLOXza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 11, 2021 at 12:10:04AM +0300, Dmitry Osipenko wrote:
> Convert NVIDIA Tegra ACTMON binding to schema.
>=20
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../arm/tegra/nvidia,tegra30-actmon.txt       |  57 ---------
>  .../devfreq/nvidia,tegra30-actmon.yaml        | 121 ++++++++++++++++++
>  2 files changed, 121 insertions(+), 57 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,te=
gra30-actmon.txt
>  create mode 100644 Documentation/devicetree/bindings/devfreq/nvidia,tegr=
a30-actmon.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-a=
ctmon.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actm=
on.txt
> deleted file mode 100644
> index 897eedfa2bc8..000000000000
> --- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra30-actmon.t=
xt
> +++ /dev/null
> @@ -1,57 +0,0 @@
> -NVIDIA Tegra Activity Monitor
> -
> -The activity monitor block collects statistics about the behaviour of ot=
her
> -components in the system. This information can be used to derive the rat=
e at
> -which the external memory needs to be clocked in order to serve all requ=
ests
> -from the monitored clients.
> -
> -Required properties:
> -- compatible: should be "nvidia,tegra<chip>-actmon"
> -- reg: offset and length of the register set for the device
> -- interrupts: standard interrupt property
> -- clocks: Must contain a phandle and clock specifier pair for each entry=
 in
> -clock-names. See ../../clock/clock-bindings.txt for details.
> -- clock-names: Must include the following entries:
> -  - actmon
> -  - emc
> -- resets: Must contain an entry for each entry in reset-names. See
> -../../reset/reset.txt for details.
> -- reset-names: Must include the following entries:
> -  - actmon
> -- operating-points-v2: See ../bindings/opp/opp.txt for details.
> -- interconnects: Should contain entries for memory clients sitting on
> -                 MC->EMC memory interconnect path.
> -- interconnect-names: Should include name of the interconnect path for e=
ach
> -                      interconnect entry. Consult TRM documentation for
> -                      information about available memory clients, see ME=
MORY
> -                      CONTROLLER section.
> -
> -For each opp entry in 'operating-points-v2' table:
> -- opp-supported-hw: bitfield indicating SoC speedo ID mask
> -- opp-peak-kBps: peak bandwidth of the memory channel
> -
> -Example:
> -	dfs_opp_table: opp-table {
> -		compatible =3D "operating-points-v2";
> -
> -		opp@12750000 {
> -			opp-hz =3D /bits/ 64 <12750000>;
> -			opp-supported-hw =3D <0x000F>;
> -			opp-peak-kBps =3D <51000>;
> -		};
> -		...
> -	};
> -
> -	actmon@6000c800 {
> -		compatible =3D "nvidia,tegra124-actmon";
> -		reg =3D <0x0 0x6000c800 0x0 0x400>;
> -		interrupts =3D <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks =3D <&tegra_car TEGRA124_CLK_ACTMON>,
> -			 <&tegra_car TEGRA124_CLK_EMC>;
> -		clock-names =3D "actmon", "emc";
> -		resets =3D <&tegra_car 119>;
> -		reset-names =3D "actmon";
> -		operating-points-v2 =3D <&dfs_opp_table>;
> -		interconnects =3D <&mc TEGRA124_MC_MPCORER &emc>;
> -		interconnect-names =3D "cpu";
> -	};
> diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-act=
mon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.=
yaml
> new file mode 100644
> index 000000000000..2a940d5d7ab4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
> @@ -0,0 +1,121 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/devfreq/nvidia,tegra30-actmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra30 Activity Monitor
> +
> +maintainers:
> +  - Dmitry Osipenko <digetx@gmail.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |
> +  The activity monitor block collects statistics about the behaviour of =
other
> +  components in the system. This information can be used to derive the r=
ate at
> +  which the external memory needs to be clocked in order to serve all re=
quests
> +  from the monitored clients.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nvidia,tegra30-actmon
> +      - nvidia,tegra114-actmon
> +      - nvidia,tegra124-actmon
> +      - nvidia,tegra210-actmon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: actmon
> +      - const: emc
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: actmon
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interconnects:
> +    minItems: 1
> +    maxItems: 12
> +
> +  interconnect-names:
> +    minItems: 1
> +    maxItems: 12
> +    description:
> +      Should include name of the interconnect path for each interconnect
> +      entry. Consult TRM documentation for information about available
> +      memory clients, see ACTIVITY MONITOR section.

This used to be "see MEMORY CONTROLLER section", so I looked at the TRM
to see if this was perhaps a fix for an earlier typo, but looking at the
TRM (v3) I can't find a section named "ACTIVITY MONITOR".

Should this be changed back to "MEMORY CONTROLLER"?

Thierry

--lw9R1wTkEeyLOXza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmC0rhsACgkQ3SOs138+
s6Fm0A//XhaGu3HM5/zN6jACSzME1rL9Z3YBxmJ+qMYp0VZUp2dQW9PmFReGsR45
A3Ytplk/jkEawjdVzTss3CSjRl3veASJ/zwzU9D/xjuXdj2tdQZCYoo4pI3jt/Yj
kn4AwSBdL86vs0B/B1Dp8bpzsXKTOofBr+JsDnAhchAWjYUi94BqUlfAR7JHhPkS
3BO2bhbSHrWidNwpXsh8uyai/Ep91uU9ETZUGQrqqbZpDwPRLvOeQhP9A9kfclyu
9blxwK24jhEqN2i10ns/cJg8r4E0eb1tx5G/8INPrtEzxirg+U7nzGSQRWLQSPCC
MSP9jc8q+AgVnqx4gZG0aMCdTP5u9IlJHEaAf2NdDnJSbhnRGwae1KIANQTI7Ez2
GSGvLIhw4uvLhz1hRewbTuBAb3jfmJcPjiCAMuXCc/fjFxaD2ACnHkx6H8w25aV+
+8UrVW6cqWL2xPbR76IlbDHhNdNspfoNVtBvSuVMHneZDwOCc6Uowj7JsUpls7qm
6ty5VAxT+dj2MgILsVkADRJpZsz2FPDnyHLv6PDvQc8hjVDc2sx7t6gwVOw3A/XP
U+MxatjR9oeo+4WlWoFVw5fQjHpNWhCu1IWG8glwJDaWDQDgR30ibNwD+45oHqrY
oICaYIdKcIOng+A9o8K6HQGNEu4o+wyOaBLgnY+XIhHlTNqwC0U=
=lC/s
-----END PGP SIGNATURE-----

--lw9R1wTkEeyLOXza--
