Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23628F32DA
	for <lists+linux-pm@lfdr.de>; Thu,  7 Nov 2019 16:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfKGPVZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Nov 2019 10:21:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40959 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbfKGPVZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2019 10:21:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id f3so2853899wmc.5;
        Thu, 07 Nov 2019 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tUz9lo/9z4UAAly/Z67v9gZOTHnCyevqoBRgRavRjsw=;
        b=tnfOQCfKS48H+K7xacz5HFV2JFSpKKz9GqPzCKBy4p/x5x2hN8mOivcNoFPSfFBM8B
         CimxXeTk/32+Cxx0NZ9r1V0ya08lTNBBFMhqXNbG0ILKJIKQA+jUpvNMFPKgIdtZTcnE
         cWK30MRynSSxLEL/sPdHLsBNy8upE4KmkeAojnzxT+Uk4MMbvzbOjIRhCra9pkWDQR2m
         mcfgFtIewpyqCt/Uw83QZgnK/8Ds49b+alrIlEtpk2BUDSAjyF1gsFXe17Z6EUhrgVN+
         SiTWmyEqilyngUf+KeU7WDSm7WhhlYaX2Q1X457k6GXKc5zdpqBv+8TGzPElAJUKClTz
         iD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tUz9lo/9z4UAAly/Z67v9gZOTHnCyevqoBRgRavRjsw=;
        b=TIGJTSAzd8+BvslOO2wOZ+AnEoWuhCp4fHqWfyxNr3rc8PNOP0seTVREk7zcxPdjHc
         QpbNCMrR6NuWlQRg3pkljB44uAK2aSk2FDlhtPQ+dGQGEZIxLy+9BtpZf8oHfD7Sz8E4
         OlmxzVrypD627F1GqVzOAe7FyRexRH+bREClVsKxuQIBIdI1TCjDVgZ0B7cej2D8zTw3
         MvXwO/JS3GCgMrB6Bs1sEzzxl3NPL7ao+fUkguIkw3uZcBZ0lSum9uvNvEfEFF/luFHm
         yKsQf9pLU6COGWcATInSaZ2KU0nmKfPBOK6GyC9HnPVNF06YLIkjrZ+yeH1nq3c41BaS
         Y7UQ==
X-Gm-Message-State: APjAAAUJZOOBIKOMjsZxVOCVTFL2dMreb885X1uXdzSy+WrfPXKwolZS
        /jMwbQ/VlNFizwF00NX4tl4=
X-Google-Smtp-Source: APXvYqzUoO54SjCKN5o/wY+n0JSUgqyAlyIDjV70oqVl5A7OH+1xnZNUrJJ3e8+hC0nkaF/X9fycDg==
X-Received: by 2002:a1c:1d41:: with SMTP id d62mr3402052wmd.32.1573140082266;
        Thu, 07 Nov 2019 07:21:22 -0800 (PST)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id x8sm2459912wrm.7.2019.11.07.07.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 07:21:17 -0800 (PST)
Date:   Thu, 7 Nov 2019 16:21:15 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        jason@lakedaemon.net, jonathanh@nvidia.com,
        linus.walleij@linaro.org, marc.zyngier@arm.com,
        mark.rutland@arm.com, stefan@agner.ch, tglx@linutronix.de,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v9 07/22] clk: Add API to get index of the clock parent
Message-ID: <20191107152115.GA2580600@ulmo>
References: <1565984527-5272-1-git-send-email-skomatineni@nvidia.com>
 <1565984527-5272-8-git-send-email-skomatineni@nvidia.com>
 <20191106231005.F2CD820869@mail.kernel.org>
 <fcc43ccb-8c6e-d518-4c70-503501706ffd@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <fcc43ccb-8c6e-d518-4c70-503501706ffd@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2019 at 03:54:03AM +0300, Dmitry Osipenko wrote:
> 07.11.2019 02:10, Stephen Boyd =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Quoting Sowjanya Komatineni (2019-08-16 12:41:52)
> >> This patch adds an API clk_hw_get_parent_index to get index of the
> >> clock parent to use during the clock restore operations on system
> >> resume.
> > =20
> > Is there a reason we can't save the clk hw index at suspend time by
> > reading the hardware to understand the current parent? The parent index
> > typically doesn't matter unless we're trying to communicate something
> > from the framework to the provider driver. Put another way, I would
> > think the provider driver can figure out the index itself without having
> > to go through the framework to do so.
>=20
> Isn't it a bit wasteful to duplicate information about the parent within
> a provider if framework already has that info? The whole point of this
> new API is to allow providers to avoid that unnecessary duplication.
>=20
> Please note that clk_hw_get_parent_index is getting used only at the
> resume time and not at suspend.

I agree with this. All of the information that we need is already cached
in the framework. Doing this in the driver would mean essentially adding
a "saved parent" field along with code to read the value at suspend time
to the three types of clocks that currently use this core helper.

That's certainly something that we *can* do, but it doesn't sound like a
better option than simply querying the framework for the value that we
need.

Thierry

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3ENmgACgkQ3SOs138+
s6HBehAAoWy2oqQjgS7Lk2yJnxhX9j8cHmxS30B66WKwZ/Enod8p3/tHOIreOs7Q
na8sE7nhvDP6ULJjCNNjrBtZ+rm9EfK9n4jUV6Y10wH8PVpFyN8Xnobp5yipT4uD
V65DF1MPG1xYfG7ksHXFJRpXlWPuVWQzaxTKSVpQuzbqRtpyoXCYTy50u68TUz5X
Qs8XOQAmrcG2DqflYdDdra1OVqjPlL6gShB9nrzkIoCg41mqnQ/j6iqC9yPa0rXv
k765USRxiD9gdYPksBVf5WJx7Bf3oECYEkhxP6XalKDp/b/USIEOElTqwe7uFSW6
oL5MhWWlM/aOGvtR5lt8cawc2Z9oGzg7Ts2Z6Ot1iDV8Un+NPobcGBXFIw5y6zP2
pEKbHMCxSBx8X86zlMxhIg2g0NGZu3xkKWTa+9KnANa8MRGDCfacHPoRy/XA2qGh
ufM4+hfz8fFJk1ODxS/f4RbMp6XwXfL3X5UvVVhiKNBm44H3ZpD8398RolwT6yQS
rFMpF8SC00/t5f34ZPU2gZkBDZheqFfX/d94EVUXUxcJ7xndVVqXgGrWlFjKnYVw
hovXum6/3HTiMjyVQW3HfgaU8fa+Oazny1okGE0rXkrV5Ii/XFtAQyVv2Q7oGNOK
TrfKd5/oJr6Eu1zqpToS+HmUhTZGQp0NL1QF9BrUd4+WvLNmsWs=
=PNuJ
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
