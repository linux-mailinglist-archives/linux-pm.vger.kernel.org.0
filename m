Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F91B2C5B5F
	for <lists+linux-pm@lfdr.de>; Thu, 26 Nov 2020 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404652AbgKZSDA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 Nov 2020 13:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404651AbgKZSDA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:03:00 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C0DC0613D4;
        Thu, 26 Nov 2020 10:03:00 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id z7so3064810wrn.3;
        Thu, 26 Nov 2020 10:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KCIFTIKdiTLQ7RBGiS17aYYYkXPMsSyAUycnWynj4NU=;
        b=edsYOVIOCEWiXs+uDSXXPTClxHFbJTTe4UmFJ/B3uWEesOzFfGBUu4BvzNzppU8GCR
         T1R9M5o65kPn5GdH7x5t6CWstEtPuq1ZygYIlUU4ZOD7DMrcIX6oiyScXLH+Nm9P4RyY
         atx+Jm2FHT5+WkcuW6q5IPpbayL5sqbyiiOfX1p+F3YKBW+wpUorThBBphaCDAOfPTPM
         vLERAy6UuwPYFR/CeZYdsMgcCwilvw92+IhoanpIKJsHgwO9SuhDMjfAr4p6yFpv6rxq
         IPJpLuI9fIo2t4W6ObEr0gSHl9ofwdYs3nE3Hmuh+jzKFEvxwPt3JQLR+NdKWgK2dJgH
         uqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KCIFTIKdiTLQ7RBGiS17aYYYkXPMsSyAUycnWynj4NU=;
        b=DrE+2CN28PflUn4nR0APIgjm1vm8sytAI2HiYfI8jlvsJLHKXPIE+rBAY56mjAdgUE
         DKpTD02iVdQ9VpfSVR3sDs90R+LbvoWN733//974EgRDi9PNq6nmT064KCXPiAOc/If+
         QJZW42J4OrKAXdqo2APkZqgvrnTgpkzroaz+a9yct2csEtx30XlgLj7wrKwTvrkfbDHI
         /tt9WWgB2sHcBI7GUKrsEfsSXBv81JtRTmuIn/qCU62NkP4d0IlNYF+6QO4qb8pwOpre
         /PioX2jmRkV8HRrhDRf8M7n2R7jPaPv+97D141JRBySo1NPeEc5Mjtaj1BGXj0N47COp
         FLLA==
X-Gm-Message-State: AOAM532vd5Rvyu+zBSv3ymZDMYyuiKghJG4EKyVMwIK0LYgCswDe9iSG
        o/M5nKth0LRAyCEWpOqBavE=
X-Google-Smtp-Source: ABdhPJx3NzSy7dWcWv10tXnuy+HO3uIq/rvc1ScDj1tBBUvgfWkRz4C0ZwV80uNZePoQIb134m4gvQ==
X-Received: by 2002:a5d:6783:: with SMTP id v3mr5332228wru.45.1606413778716;
        Thu, 26 Nov 2020 10:02:58 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id c190sm3666653wme.19.2020.11.26.10.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 10:02:57 -0800 (PST)
Date:   Thu, 26 Nov 2020 19:02:55 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 17/47] dt-bindings: memory: tegra20: Add memory client
 IDs
Message-ID: <X7/tz8KwCBEgA6vi@ulmo>
References: <20201104164923.21238-1-digetx@gmail.com>
 <20201104164923.21238-18-digetx@gmail.com>
 <X7/lLaZJNp+Vfczk@ulmo>
 <20201126173922.GA7048@kozik-lap>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="abXpfoLbeV2BRxSZ"
Content-Disposition: inline
In-Reply-To: <20201126173922.GA7048@kozik-lap>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--abXpfoLbeV2BRxSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2020 at 06:39:22PM +0100, Krzysztof Kozlowski wrote:
> On Thu, Nov 26, 2020 at 06:26:05PM +0100, Thierry Reding wrote:
> > On Wed, Nov 04, 2020 at 07:48:53PM +0300, Dmitry Osipenko wrote:
> > > Each memory client has unique hardware ID, add these IDs.
> > >=20
> > > Acked-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > ---
> > >  include/dt-bindings/memory/tegra20-mc.h | 53 +++++++++++++++++++++++=
++
> > >  1 file changed, 53 insertions(+)
> >=20
> > Is there any chance you could drop these dt-bindings include patches
> > (17, 18 and 19) so that I can pick them up into the Tegra tree? The
> > device tree changes that I was going to pick up depend on this and
> > fail to build if applied as-is.
> >=20
> > I was looking at your linux-mem-ctrl tree and had initially thought I
> > could just pull in one of the branches to get these dependencies, but it
> > looks like the dt-bindings patches are on the for-v5.11/tegra-mc branch,
> > which the ARM SoC maintainers wouldn't like to see me pull in for a
> > dependency on device tree changes.
>=20
> Partially you answered here. :) Since you should not pull my branch into
> a DT branch, you also should not put these include/dt-bindings patches
> there.  SoC guys will complain about this as well.
>=20
> These patches are also needed for the driver, so if you take them, I
> would need them back in a pull request. SoC folks could spot it as well
> and point that such merge should not happen.
>=20
> > If this is all fixed at this point, I'll just have to push back the
> > device tree changes to v5.12, or perhaps see if the ARM SoC maintainers
> > are willing to take a late pull request that's based on v5.11-rc1.
>=20
> Yeah, that's a known problem. I asked about this Arnd and Olof in the
> past and got reply with two solutions:
> 1. Apply current version of patch without defines, just hard-coded
>    numbers. After merging to Linus, replace the numbers with defines.
>=20
> 2. Wait with DTS till dependencies reach Linus.

What I've done occasionally in the past was to put these kinds of
patches into a separate "dt-bindings" branch that I could use to resolve
dependencies from device tree files. The ARM SoC maintainers never had
any issues with that approach.

I guess this is a bit of a special case, because the DT includes are
ultimately really a part of the device tree, so mixing them both isn't
problematic.

Thierry

--abXpfoLbeV2BRxSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+/7c8ACgkQ3SOs138+
s6GvWhAAhYKoK8A9tZy063DCPqqf86bEShf5PNCBAoCHKugibe2N4Zlj8bv5XFFz
l3Z6p7r0GpSIJM6gHoM+HRzRuN/E2NPE6SMnRCS8aIYoCD3BoTHTzJ7UcTHCc6Wf
4BnFEomaF7Fmm/Ad2TKacDsPu3SXNfeWNOGIzGzMExpege12kd2tOZ2dfZmINgC3
fMG3C0muiu045x1PARJQbjkWfB3ND3QtCAgru5MMw/gYwD7rosIKYHdftmYjNLOX
X0wc1FwVejm4yoOYsMWrNWTzs5tX8ptDrdgwCKz7hJRHGInoDrgGN/vxNMZhbtLW
SV/BiqsQEoEfYf51PCC77FPZe0F+pQlve4XG2sOKCmH4ULJKgzKfDumAUaCmCRbs
FfqpD42Ec88gwXxgJegvlg0NI2ox+t4sIDIPSSwpM+jugMnbrxR6H96jXUABhOXx
rGyOCrOkANmbFLORyCG5+WfG4CntJvXJnUWA9OzNk+UXen7vs55R/8oISeV+gegS
p1FLTXeXsMUCSSts7va7xg6Kcei15TaU1eA7G36SIU2f216pzogO4mFhccz+6YY6
PM7VZXibb/f6nyY9sz3wqAwk4RylS1D/JVMRer5vwxKl0ZBRsHCIfQCDX/0QUteb
PNv2UxrFhaHfUog8rr3/b1hp/1PiGGdXMTUvG6h+JA1xiAF3ct0=
=AuDL
-----END PGP SIGNATURE-----

--abXpfoLbeV2BRxSZ--
