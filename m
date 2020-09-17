Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1026D8F1
	for <lists+linux-pm@lfdr.de>; Thu, 17 Sep 2020 12:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIQKZR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Sep 2020 06:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgIQKYc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 06:24:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6325C06174A;
        Thu, 17 Sep 2020 03:24:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e16so1474198wrm.2;
        Thu, 17 Sep 2020 03:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mbSyrXaB6x0uRILB61Wkf7+cX6ZlyMYWrL4hs1gHbHk=;
        b=gfceiSzaB8Nnf7qomDOBRUqsx5riJF0+KWhUt3XOPFw6uF1r82zXOaTH1yHZSB+Y0P
         kRjKReTsc/PEwCFkqKG1a8t8G9WrDRTr2ZVZqgfYqjsU+Dco3s+BcOJmBL5LjynYsJwc
         75IH5e1CRIoZjn7klYMDsjfFlOFX1Wm4JI+dG39QnYdlpXDnex/qXfqUiogLTnPvJHnk
         Td66VwOdx7diEOeFZ0EA2vKliAylfxOn1f/AU01sUJAkU10yyZTu9PRsD51wQfefoqMh
         /b0Ua+G3mBQ1w2f3dgMUxo4jYIIx8R7vEAFCREc5GGrHZKhLKZSLWdoIVsrV498xpXmj
         bZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mbSyrXaB6x0uRILB61Wkf7+cX6ZlyMYWrL4hs1gHbHk=;
        b=CtFx5kYa1XfEtUBjhz8KVCPbuyPywFgLlZE8wsnkkckx6ox1ANJxsSz7PHtAHcmxlF
         PoaC949MdBExkwORmrNJ94P7eC7sCRZwoPbWmGEQURQ8Galv964G5C2ONvzuIBHigeO4
         USwIm6oDJaEEuDe+MdxRG9B7Vx7U8OHbgk8pam5bBgkT7dd4pgUXn7kG2nggwdHwjB6/
         TZ1fw0zb+TXkS4eHDLlj9tJcjOfccvnKJBiTbINgwYqiydIQeEcqg6QK3ELTtLSwi1OX
         6ur5J0grBlelsNIeYD/7VuUKKLyt6kOv+3E8EDJGAFEVA/giZmZPnKVCs6V44xSIqPCA
         lWVg==
X-Gm-Message-State: AOAM5327X80AqS+lyVb57E0vkt+Fk6HeTkA0DTipjH4NhAOjK2NpQhra
        tcWpkDQYb264i+gTIEZ21NA=
X-Google-Smtp-Source: ABdhPJwkDqZBiZgCgqM3GMmtRjgoJytsoG6W51PCnDbrTObT3FQOtupIWynXi/IQFlFDxT68XtvnjQ==
X-Received: by 2002:adf:ec92:: with SMTP id z18mr33664199wrn.53.1600338270476;
        Thu, 17 Sep 2020 03:24:30 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 189sm10572790wmb.3.2020.09.17.03.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 03:24:29 -0700 (PDT)
Date:   Thu, 17 Sep 2020 12:24:27 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Bruce E . Robertson" <bruce.e.robertson@intel.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jonghwa Lee <jonghwa3.lee@samsung.com>,
        John Stultz <john.stultz@linaro.org>,
        Vinay Simha BN <simhavcs@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH v3 10/10] ARM: tegra: nexus7: Add SMB347 battery charger
Message-ID: <20200917102427.GF3515672@ulmo>
References: <20200813213409.24222-1-digetx@gmail.com>
 <20200813213409.24222-11-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Wb5NtZlyOqqy58h0"
Content-Disposition: inline
In-Reply-To: <20200813213409.24222-11-digetx@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--Wb5NtZlyOqqy58h0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2020 at 12:34:09AM +0300, Dmitry Osipenko wrote:
> From: David Heidelberg <david@ixit.cz>
>=20
> SMB347 is a battery charger controller which is found on the Nexus 7
> device.
>=20
> Signed-off-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../tegra30-asus-nexus7-grouper-common.dtsi   | 24 ++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

Applied to for-5.10/arm/dt, thanks.

Thierry

--Wb5NtZlyOqqy58h0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl9jOVsACgkQ3SOs138+
s6Hb9A//eMV5LhK75LgaLj13IX1SiABYu8XXVwvH1mo1JTc8hpnEgJvp3d0m7GC/
NQaGrFXLx2hCj0OMOMI+ELMNkoDW5thD7j32dQj9NvvW39I1YzgmQGN3g5uQi1Y/
R+ZN3z5LzLJ0dt0d4uuO+Wg2DNtJqoXADQx9CHZZGfGViCZK6mh2woJoMKCf4aE+
57MlLGNUjnnqWvEwEFhWOEA5tLpDFGPFiC9l7TppIrVvybL19TGf7yqREW2TMrB7
2fswTsTQ9m7R5L5Q6WpjT3jfhr3kjx8Yu+OawQ59NlBymZ9tfjKKXXSJCphgymvA
ZUzbYUskuNzfU3Smod19gHtaLqshl21fCJEMNbSZpsekTxhZMTh/vleHmSYg3qQh
YW6gmSEtNBxxpaQwLIdu4Jv9TlL+6evUbrYNh5Do6hHUxfvGVjyn7w+IKLJ5rZbr
zoWvmGw+iwnSN9FAbnCNFfiw1G/MW6XfTsuo7G+rZ3STUQWCQSk9GcIyyfAAw3Qn
XKAyk7xJcRnaTQ2q12/zgQDsTl7Zk4hQwmZ0vPKDlsKPm6eCOrjL95s1D9mNYDhz
Bf5KfWWOQ+jdzyDRdmtkEO++pDZzNbYS9CC7lIiv9pkUDvvguupCzoilzwRezri4
DHEe/m+M/XWfUe7NrTjCB+MSwwmwuApAEB9nm0LNAeudeMD7kqs=
=cv0b
-----END PGP SIGNATURE-----

--Wb5NtZlyOqqy58h0--
