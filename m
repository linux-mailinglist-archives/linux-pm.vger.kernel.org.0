Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18ABB10CD23
	for <lists+linux-pm@lfdr.de>; Thu, 28 Nov 2019 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfK1Quc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Nov 2019 11:50:32 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39988 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfK1Qub (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 11:50:31 -0500
Received: by mail-wm1-f67.google.com with SMTP id y5so12349469wmi.5;
        Thu, 28 Nov 2019 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WUkl5jnRGfV/kV8cyt6Eg+72AaYhmkjbi+1i7ecJ1mo=;
        b=oCI2+ouwC6FFFtwC3HQe79/vZiJy/YQyFyQwhwV/ymbxp3MvaqFahpwedaEfj3OrdD
         CuftaRGF0xFpDINRHILhK+cH1tHhFQHfcomOVj8tA9J+v1PZQlceN9zKnUFwempR5po/
         akAoN1D9mpSJsG1+QmiNFMAzdOecVbRvq3CM50/jSHNn9DfEw04pDNiR+nchVHhsAHcY
         ogdXmFfca6ppxNYpCccsY4/OUm+QH8iC2PMyTrKXBFhN3dwTbkC9cwbu6HY3V2iWfUHy
         kBoKPAJfNNgiFhHGAmb20bV0eCdmC4qimpNUVfsGWM68GiK0LndjbjxsMYd1hNfcDN5U
         AZrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WUkl5jnRGfV/kV8cyt6Eg+72AaYhmkjbi+1i7ecJ1mo=;
        b=SutU9PjNvgQKASs4XuIHXuKD/tUo4ybyBWar0NF7QuaqAjKTv9NJd3PYwnPoR/7CDK
         kr3f8WTxwEZvWyCE8diqvWNl8StU5XO6nE8zXRb4uGdebXbqb1GMWagJ9sRNVlYTl6a2
         +KOXgAkS6D/KG0GYjBxAWNlUCIS8l/Iu+VktBgN53z2ivJn1+e4r4RjfSl+pn8PtLI5I
         AXq7WCy83gm4d9EMBUhwFVPIARNlLpkySukjoBJ9af9ezhswt0IosOENzGDczPbre8m1
         CJgn6lTYA3gkv2YfBYZ/N4JDdSE8jxTwB+dpBB3laFCkIr3eUpbKvOXxpwgQ03BqkqeL
         XOaw==
X-Gm-Message-State: APjAAAUKtlZMEFdvNvq7WS/BVeFlPByhbvuMLIqo4RQPtSc0nHgvoTT3
        cgQZ+CMn/qpsiu5TUitG6hc=
X-Google-Smtp-Source: APXvYqw/Rk1HO4LPlPbWBMuiTAgE3dOIrv9Mn4hWI/VmFC5SoleWU4B7t57e/CasMTGHHDYv4kv2KA==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr10852998wmo.143.1574959829103;
        Thu, 28 Nov 2019 08:50:29 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id a15sm25776678wrx.81.2019.11.28.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 08:50:27 -0800 (PST)
Date:   Thu, 28 Nov 2019 17:50:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
Message-ID: <20191128163623.GA2382107@ulmo>
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
 <20191128160314.2381249-2-thierry.reding@gmail.com>
 <CAJZ5v0haOB1vc8aKk11RR-OnfLHChcqa+z7QkeKyN66s6xM3OA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0haOB1vc8aKk11RR-OnfLHChcqa+z7QkeKyN66s6xM3OA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 05:14:51PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Currently the driver PM core will automatically acquire a runtime PM
> > reference for devices before system sleep is entered. This is needed
> > to avoid potential issues related to devices' parents getting put to
> > runtime suspend at the wrong time and causing problems with their
> > children.
>=20
> Not only for that.
>=20
> > In some cases drivers are carefully written to avoid such issues and
> > the default behaviour can be changed to allow runtime PM to operate
> > regularly during system sleep.
>=20
> But this change breaks quite a few assumptions in the core too, so no,
> it can't be made.

Anything in particular that I can look at? I'm not seeing any issues
when I test this, which could of course mean that I'm just getting
lucky.

One thing that irritated me is that I think this used to work. I do
recall testing suspend/resume a few years ago and devices would get
properly runtime suspended/resumed. I did some digging but couldn't
find anything that would have had an impact on this.

Given that this is completely opt-in feature, why are you categorically
NAK'ing this?

Is there some other alternative that I can look into?

Thierry

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3f+tAACgkQ3SOs138+
s6F4mBAAqcwu+TStcK/qpZpkwObpVPR3H5IoPOrDpq8MN9UfrWpbf4uaAcUPdVMj
7yMCZQT8etpz6ZSoyDATX4QqU5RYmAYcYQpVEzHNQ4WryTkba8Z6ElbOZMhlESfs
rNIHFvtYsBwvjPCq4VV4gdjodlKiarKCsKogOwP4CmPGOph0j4bdwyxpuUMhB+bd
nrxkDeDzHNGHqRgg9uGVt23icJnMqlWAl+NCkxvTCzpt3r0BwT2TW4xnZ6IEx9Rx
rcimhfWk9WxMkAKeYK1q9CZBwSeaEMkZ9LtmH242j9rTQj7UiEKnWgm8ogzIsq2X
/ZtPeZ95g5cNGzMJTrmxvteNvoIv2ROaKiOI12HrEAfFtFoHt9sotcNS0awSm5eG
6Yfle+/XfnVyBk+3mPX43r6hULcicnLY281NZ0YP+Av8y40HD0I+ynrjtByj/c3M
XZGsgVEPPNioiPPhKo3i+mbIGqfTiA1NeCb6EP+zHaMkqsswxSLlSckGXb3O3rdc
W0C0KZByR7PkzohlsTSnuV5edDwXWM0lfsBWEtL4PJG7ukNYHCifM4B2IW6ANc40
ACLA3rShB7oY9fuxtVDd4/Q/CK4r+4qLntQ9cF09g0NKUgs7HnIXKbMdcd0WYyWB
5S3TBt8Bir2B64eaa5x/Sr12uLRm+kkzWQMopKNUpI3Dt4Q8D1k=
=U0Wg
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
