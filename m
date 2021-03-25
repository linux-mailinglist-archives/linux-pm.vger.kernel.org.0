Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0A234948C
	for <lists+linux-pm@lfdr.de>; Thu, 25 Mar 2021 15:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhCYOtd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCYOt3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 10:49:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066DBC06174A;
        Thu, 25 Mar 2021 07:49:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d191so1339297wmd.2;
        Thu, 25 Mar 2021 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SWvMHK4Ot07NYjs1TXQxHKnMoJ0tlX8FET1AI29AVZg=;
        b=aqniE4xUchEMgXVFlAfySinuErd1wsZkzuNF6K0y8IG8kaOUIfUufGVbP3IwOq7GnO
         T9Cl8iG2I8LrPrRr8NxQrYQUY8BPqjphyCUSavaa+AxFXVBWbCmbgIXYRAZeSB3OgIKW
         VcIpoWqNHxtg7gQ8ND3tPbzTuRTFkMV0m0jBHM+Mm1F9XWeu/z0a6nupn2zHyhrbYvsQ
         kGthDsHIFeaOP8KDeYgmgdMx/0AFZfvXUuuX2Fg/9mpfBfGA6+uh7mxheCwsRshT4V8Z
         mp3bmeMOLAf1a6xMMoOxQKffBHOCxsHW+QOyqEu9omzRQsunSemHYf6VB8FYfq7uf1PT
         QXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SWvMHK4Ot07NYjs1TXQxHKnMoJ0tlX8FET1AI29AVZg=;
        b=FCoTfOKPeXcvGh0cM+fBTz+IuiEunmmrHQiddm/LUPseHI1k1O5JGUTLwRhBNG9K9W
         QKQTSGvuyFzMFtPYzVktevNgpwWMFFUEdHanVutqdnyfrdJw7ksBd3WhyejvOkuLgl+V
         2OrNRqugTIn5kPHP4PGUKtDvDbsrS3XSzzVJkDIvQOhOByD5L+Vm84JgUHJBn+jMq/TR
         hbll0CR28weD9m4iRfUo3X8Dn3BufBqZ/ui5fF8AndKvTEwGkLsrE1d9sfO+SXfHIMMe
         kYDWq7GbtZhYApR2W+CVcIx3vyAFNLX6TeV44J26vmosX/9F+dkHUrmHTAAIcrIFi7vv
         QIcQ==
X-Gm-Message-State: AOAM533/+Yq4076jn/R8Y4zr2h1Z+DjhJlNWClkYVVjbS/mZWyqBvGxi
        dIloYdGuymw3A+rL0rFkLTM=
X-Google-Smtp-Source: ABdhPJxIjM6YO03HPGXR9x2Aq4ifABfHiBTvBqGsj9bs6OhqGRpc7VI3dZTXyRSRrsLs0/EtdBuZAg==
X-Received: by 2002:a7b:c188:: with SMTP id y8mr8266237wmi.76.1616683767692;
        Thu, 25 Mar 2021 07:49:27 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id l9sm6259966wmq.2.2021.03.25.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:49:26 -0700 (PDT)
Date:   Thu, 25 Mar 2021 15:49:48 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] dt-bindings: power: tegra: Add binding for core
 power domain
Message-ID: <YFyjDNYAkbTQU5G0@orome.fritz.box>
References: <20210314164810.26317-1-digetx@gmail.com>
 <20210314164810.26317-4-digetx@gmail.com>
 <20210323224826.GA1490612@robh.at.kernel.org>
 <fd60e507-37b4-acc1-b19a-a3904cd13f65@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AKB8U57WCp8yhm9E"
Content-Disposition: inline
In-Reply-To: <fd60e507-37b4-acc1-b19a-a3904cd13f65@gmail.com>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--AKB8U57WCp8yhm9E
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 24, 2021 at 02:01:29AM +0300, Dmitry Osipenko wrote:
> 24.03.2021 01:48, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Sun, Mar 14, 2021 at 07:48:07PM +0300, Dmitry Osipenko wrote:
> >> All NVIDIA Tegra SoCs have a core power domain where majority of hardw=
are
> >> blocks reside. Add binding for the core power domain.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../power/nvidia,tegra20-core-domain.yaml     | 51 +++++++++++++++++++
> >>  1 file changed, 51 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/nvidia,teg=
ra20-core-domain.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/nvidia,tegra20-co=
re-domain.yaml b/Documentation/devicetree/bindings/power/nvidia,tegra20-cor=
e-domain.yaml
> >> new file mode 100644
> >> index 000000000000..4692489d780a
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/nvidia,tegra20-core-doma=
in.yaml
> >> @@ -0,0 +1,51 @@
> >> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/power/nvidia,tegra20-core-domain.y=
aml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: NVIDIA Tegra Core Power Domain
> >> +
> >> +maintainers:
> >> +  - Dmitry Osipenko <digetx@gmail.com>
> >> +  - Jon Hunter <jonathanh@nvidia.com>
> >> +  - Thierry Reding <thierry.reding@gmail.com>
> >> +
> >> +allOf:
> >> +  - $ref: power-domain.yaml#
> >> +
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - nvidia,tegra20-core-domain
> >> +      - nvidia,tegra30-core-domain
> >> +
> >> +  operating-points-v2:
> >> +    description:
> >> +      Should contain level, voltages and opp-supported-hw property.
> >> +      The supported-hw is a bitfield indicating SoC speedo or process
> >> +      ID mask.
> >> +
> >> +  "#power-domain-cells":
> >> +    const: 0
> >> +
> >> +  power-supply:
> >> +    description:
> >> +      Phandle to voltage regulator connected to the SoC Core power ra=
il.
> >> +
> >> +required:
> >> +  - compatible
> >> +  - operating-points-v2
> >> +  - "#power-domain-cells"
> >> +  - power-supply
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    power-domain {
> >> +        compatible =3D "nvidia,tegra20-core-domain";
> >> +        operating-points-v2 =3D <&opp_table>;
> >> +        power-supply =3D <&regulator>;
> >> +        #power-domain-cells =3D <0>;
> >=20
> > AFAICT, there's no way to access this 'hardware'?
> correct

To avoid exposing this "virtual" device in device tree, could this
instead be modelled as a child node of the PMC node? We already expose a
couple of generic power domains that way on Tegra210 and later, so
perhaps some of that infrastructure can be reused? I suppose given that
this is different from the standard powergate domains that we expose so
far, this may need a different implementation, but from a device tree
bindings point of view it could fit in with that.

Thierry

--AKB8U57WCp8yhm9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmBcowwACgkQ3SOs138+
s6ETIxAAmh5YGcmIWmbAM0xfHAlBQir8X7TqZ4NdKhevxGI5RuvKoShdRwnT2YtR
MO8mtDXq2c0O5kWkx0XPl53tf06Q1Kdn1VNcAAZ7afPnvAylEme3zBuUJUzK/vX+
f1jp1jXtZtYka2l9XZ1IIynGvFgY+nlAmI8+LRAzl5QDUbE7+WkUVBOcwFKRrTzW
Fff1gfSWjAVav4DuzFQ1lrmikuAdxc/yXpiRzYofWBipdr7yXqL7+HfCDikQfyF0
vV7lNEi4LT4Jh8M32fb2X+RlVwZUG+gnn+tpKPG/n0j/hfdCyGlp4zElLVff9MX+
IXyrU08//EzZCGx/R5JoaBvvtQrdhakv0P3pknVFFvnuMGt/Z+XOKj5kTwRfzlCx
Ag+v7Yt1T5ujtFGp+r6Mh0wvaUyd1JSVoAqc2k8DrDJL3jnafUPEFFtjxUehPHZo
NrZzfuPHk11uvRw+TSkdRFMjb7jO/+8OxitcFYnYff41YiRpu+CgohsBsMnmBnJN
XoZMr/7tjd6CGkfvzcipH1zhQhQSMzAis0K+AO8zFLczTRImcVdTczA7DpxugJX9
kHL3R4kVBZN6o3cVRDIbIyV09WuU1v1snSwoGLTpTP+o2/ymlcJUZIjm+8MkbF8G
WJe/KQ7/tytxfzDm4Nov979REyChdesDw+RSt/ij9l0WrPm6xZU=
=Rodt
-----END PGP SIGNATURE-----

--AKB8U57WCp8yhm9E--
