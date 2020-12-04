Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B61F2CEC8D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 11:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgLDKzz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 05:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbgLDKzz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 05:55:55 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF1C0613D1;
        Fri,  4 Dec 2020 02:55:14 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id bo9so7982619ejb.13;
        Fri, 04 Dec 2020 02:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZVHRkY74QqA19RttFo/wULshSGOsZW8klkt6NVWYoo=;
        b=qj/3tjMoeXOe2c3vj5xiHLFIMzV2808MIHS6nPhgJGtl2xS/5/oSuXMJk1umAoUZiO
         mlg/JkWv127enYGmzsb/JxtLAGxCCRUkkhWplg5CSgpZOD/Q1npHSBIDh0m7HYqrnKcZ
         mgAqUoqN/HhnX8D7sGBYV3br7IyH1MFnLvjVjgss1cXRNOk8oM1oSGStmi5NSrANz7Pj
         NDgomGmHYrE2jI8ouoWHvUKnRNFbYjltmSwXjxw9kyGK7YWpZ1G1+7s/H26SiP9TcGZq
         7a0fqFL9IHIO9HRA4ucdRlrKsr5Yijfg7WBvV+ROGWmrx0QvLE/PCqEcLwtiket7yA2P
         n2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZVHRkY74QqA19RttFo/wULshSGOsZW8klkt6NVWYoo=;
        b=R0qGrg92vPUx5Yi3/lpBcpQSj7I2sJVJDWIyE2j26Z2qSeEKvL+eseOpucG79/0xHj
         UjJgVHsHpm83pMiUvRD3mmPPYgA5KcckA0UTmnk9iB9ZyKXCUqOUx/+wzXTrMeeX0Hun
         p4/oQZTsKqrbvVDtRek5jZdlbIuCx0+QXOgfDQvgpu2/XcpgH6wWuEnhJJHlImYDsloS
         GRlCrn8/m4z16+NP0+/HMMLs3J2K5/8zgDNG41aU0LA+HWh7jGGB8iFDveZVXJmZk7D4
         M2fvFJPb7GUiNY8hC2Kiw/fWnAUF3twAGWmTEe12Y8o7Nc2jMx76w4lJYO6hGboNZMkG
         xk/g==
X-Gm-Message-State: AOAM532joeOz/eMwLY1BCxajS+vO5FdIE+vnvd4gF4nBbVTWdhUaoYkN
        K/6+MpLMSGd50zTGWqPs6So=
X-Google-Smtp-Source: ABdhPJzYGBSvFfb1PryFqIG3QjzCcTZMt/TAJIAzLmMdeBaPsKSLQfu5BbRP6wfUPylDyV79KCZoZA==
X-Received: by 2002:a17:906:55d0:: with SMTP id z16mr6412324ejp.466.1607079312560;
        Fri, 04 Dec 2020 02:55:12 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id q26sm2883583ejt.73.2020.12.04.02.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:55:11 -0800 (PST)
Date:   Fri, 4 Dec 2020 11:55:10 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH] driver core: Reorder devices on successful probe
Message-ID: <X8oVjvg/xkwQHjVC@ulmo>
References: <20201203175756.1405564-1-thierry.reding@gmail.com>
 <CAJZ5v0g_FC6Pikrvk2PK=XMvAwqjaNOcYXHYS6eqv6Zc0JgqNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1wXjCVfT6aRuHw9I"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g_FC6Pikrvk2PK=XMvAwqjaNOcYXHYS6eqv6Zc0JgqNQ@mail.gmail.com>
User-Agent: Mutt/2.0.2 (d9268908) (2020-11-20)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--1wXjCVfT6aRuHw9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 03, 2020 at 07:17:30PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 3, 2020 at 6:58 PM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Device drivers usually depend on the fact that the devices that they
> > control are suspended in the same order that they were probed in. In
> > most cases this is already guaranteed via deferred probe.
> >
> > However, there's one case where this can still break: if a device is
> > instantiated before a dependency (for example if it appears before the
> > dependency in device tree) but gets probed only after the dependency is
> > probed. Instantiation order would cause the dependency to get probed
> > later, in which case probe of the original device would be deferred and
> > the suspend/resume queue would get reordered properly. However, if the
> > dependency is provided by a built-in driver and the device depending on
> > that driver is controlled by a loadable module, which may only get
> > loaded after the root filesystem has become available, we can be faced
> > with a situation where the probe order ends up being different from the
> > suspend/resume order.
> >
> > One example where this happens is on Tegra186, where the ACONNECT is
> > listed very early in device tree (sorted by unit-address) and depends on
> > BPMP (listed very late because it has no unit-address) for power domains
> > and clocks/resets. If the ACONNECT driver is built-in, there is no
> > problem because it will be probed before BPMP, causing a probe deferral
> > and that in turn reorders the suspend/resume queue. However, if built as
> > a module, it will end up being probed after BPMP, and therefore not
> > result in a probe deferral, and therefore the suspend/resume queue will
> > stay in the instantiation order. This in turn causes problems because
> > ACONNECT will be resumed before BPMP, which will result in a hang
> > because the ACONNECT's power domain cannot be powered on as long as the
> > BPMP is still suspended.
> >
> > Fix this by always reordering devices on successful probe. This ensures
> > that the suspend/resume queue is always in probe order and hence meets
> > the natural expectations of drivers vs. their dependencies.
> >
> > Reported-by: Jonathan Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> Saravana had submitted a very similar patch (I don't have a pointer to
> that one though) and I was against it at that time due to
> overhead-related concerns.  There still are some, but maybe that
> doesn't matter in practice.

I suspect that any overhead would be offset if we can get rid of the
deferred probe reordering and the recursive provider/consumer reordering
as discussed with Saravana in that other subthread. Even if we can't do
that, this is a one-time cost per device and therefore shouldn't have a
huge impact.

Besides, as the example above and Saravana's in the discussion in June
shows, there are certain cases where we just have no other way of doing
the sorting correctly, so I think we need this for correctness.

> Also, I kind of expect this to blow up somewhere, but since I have no
> examples ready from the top of my head, I think let's try and see, so:

I'm slightly worried about that, too. But I did give this quite a bit of
thought and I can't come up with a case where this would blow up. Maybe
the one case where this might break something is if some combination of
drivers specifically rely on the suspend/resume order to be *different*
=66rom the probe order. That's a bit far-fetched and I would think that
either driver would have a workaround in place to deal with that somehow
so this might actually unveil such workarounds and gives us an
opportunity to do things right.

But I think it'd probably be best to feed this into linux-next sometime
soon after v5.11-rc1 to get broad exposure and see if there are any
cases where this causes trouble.

Thierry

--1wXjCVfT6aRuHw9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/KFY0ACgkQ3SOs138+
s6G9lRAAhfBZXVT9ayiJKp15iatSLW3Slg5kS+4d9TkFVwiXlNBHodXi1nXvVkYI
Rvxva5NByxLlbPUJJBXIYBMuvPB4rryq76gGViJEwoIx97qkmjlMUNJzU39wlC7V
P43rWwzTTJIyo4vXUnQtB5nhKSxw7rG5Izdx9l/tmZHsGw9vXXjBURwrQyR8STWx
VotUMHShFWOkWW5gq7TVo8fUhuDrVA+os52xUZk+Vpf4OnlSEmeh3ofk/KtYW/fB
OYf4I/MKbortHP4PFcnFBgnMwGL4ls7OpPiEgo8nMNdPF8DFnbOEhL7Ks8VnWa5J
JLrDV2v1lva4T069LHwy+WRC6LoDLkTpOGaXSWmQvF21uN7Anj0RF9Ux6D2yiAGv
4MlwOOHmO4SFnXsqeKeuAJhFgUEiIUbsmfYS8pekaeE8ZxRMjxnuUx6SycC+neEK
7+yKY65f/7AbIGLRehgGXLw5yCLSMpj3fhpIqym7d53515I7ovHJ0G3kdO//dc/J
/WUJNs4SiIo+2Y/P8DcW2KHQIVM+mbMrQa0ybGgf/+xkosCKmFEv7RQ9Mk6iXyLg
EbayCS9iMjUI+olDnsA57mcIwCm2+UQSt1GbSRcjYkTe7SHUiZhGjZVACJ0sCpOL
kC3vBCTpnRiWtPAqUR03VmttLD4m/iD2W33wjc7PB2vWEXk2+S0=
=j820
-----END PGP SIGNATURE-----

--1wXjCVfT6aRuHw9I--
