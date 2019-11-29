Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF3410D3AC
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 11:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfK2KIV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 05:08:21 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55598 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2KIU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 05:08:20 -0500
Received: by mail-wm1-f68.google.com with SMTP id a131so9230944wme.5;
        Fri, 29 Nov 2019 02:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eu3Xl8hEwDnIvTaWXL4rXxBWeQHM1+1iHv4GaF+LWpc=;
        b=m3oTvwTAzVynoxn5WI53WCnvBPzYD78S7+sT7mKjgHv4voFRP0OdaMkIJuEU1PSVss
         bjs5JB6CohR+1K8dqcnKIIR5XCC7TZvwYzr/DXhFCX8PdhxsLf8AyMOTGse2/bDhDP14
         jLv8gM5XUox5PUgYtHRAHs85Fvqp6LdYwb9lc4PT4ek20cjm6LxTkBtLZLIFMk1TGVrM
         +SvhCXRSOLQAnbR5hX2XKhX1hm4uWmgv4HDauf9IdjRAKvaDYu9sidfdA53nBZOTxsUJ
         wO62ZwFH8ryjM73Y2pHQSA5ldWLLMR58xVIi5m1YQzcgs1oxuLUk5GZkAgN9kGu6bmic
         iv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eu3Xl8hEwDnIvTaWXL4rXxBWeQHM1+1iHv4GaF+LWpc=;
        b=STS1dyL6iZxnshD4/EVT41nitrF80FXk23vzzFlcW3tbPPjgdTiMpE6+wbvwKaexxA
         5zIoNe4m68FuMtxLQs3YlxSuxKv7Lbw2aVM8OWhYFp4msxrELBVKgcldCF6GmdSA1y4u
         tBw170Wxi+CY8tu0quTrqLSYYJ+41ZZ2E6o28sp8IUd9P8v5UtgLfEo1R5ne/SJioktV
         RlW2lK3zWe9rR3AsbshhkJZgdE+jgY4Nz1hRK3b1NjZSzCrD0YW4UresccQ4ZDTwQc6v
         HthwK6+LNNWTaJkBBjpZEleMkcshq4+DBCUzJ2kILNfyIbBWzaCM/pG1NRtnKLh6rZr3
         SvTg==
X-Gm-Message-State: APjAAAUzybT68uUyugbQRxs5Wm7ysUiOIB7noU5ixeKlf7aL+PmK/P7H
        yeYx6A9Wkkvik5WMXaL9cCo=
X-Google-Smtp-Source: APXvYqxmt6bDK65hV97R69/h1oYm3HP5bIZRSaC7+2NieNOnUvKCBtTxQAw+nRzzrqLkPkMuYyfBVw==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr4453109wmi.65.1575022097294;
        Fri, 29 Nov 2019 02:08:17 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id n10sm8157007wrt.14.2019.11.29.02.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 02:08:15 -0800 (PST)
Date:   Fri, 29 Nov 2019 11:08:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
Message-ID: <20191129094303.GB2770902@ulmo>
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
 <20191128163623.GA2382107@ulmo>
 <2310325.iNVD75376c@kreacher>
 <4149037.GOuMSCS4uT@kreacher>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <4149037.GOuMSCS4uT@kreacher>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 11:20:01PM +0100, Rafael J. Wysocki wrote:
> On Thursday, November 28, 2019 11:03:57 PM CET Rafael J. Wysocki wrote:
> > On Thursday, November 28, 2019 5:50:26 PM CET Thierry Reding wrote:
> > >=20
> > > --0F1p//8PRICkK4MW
> > > Content-Type: text/plain; charset=3Dus-ascii
> > > Content-Disposition: inline
> > > Content-Transfer-Encoding: quoted-printable
> > >=20
> > > On Thu, Nov 28, 2019 at 05:14:51PM +0100, Rafael J. Wysocki wrote:
> > > > On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@gmai=
l.com>=3D
> > >  wrote:
> > > > >
> > > > > From: Thierry Reding <treding@nvidia.com>
> > > > >
> > > > > Currently the driver PM core will automatically acquire a runtime=
 PM
> > > > > reference for devices before system sleep is entered. This is nee=
ded
> > > > > to avoid potential issues related to devices' parents getting put=
 to
> > > > > runtime suspend at the wrong time and causing problems with their
> > > > > children.
> > > >=3D20
> > > > Not only for that.
> > > >=3D20
> > > > > In some cases drivers are carefully written to avoid such issues =
and
> > > > > the default behaviour can be changed to allow runtime PM to opera=
te
> > > > > regularly during system sleep.
> > > >=3D20
> > > > But this change breaks quite a few assumptions in the core too, so =
no,
> > > > it can't be made.
> > >=20
> > > Anything in particular that I can look at? I'm not seeing any issues
> > > when I test this, which could of course mean that I'm just getting
> > > lucky.
> >=20
> > There are races and such that you may never hit during casual testing.
> >=20
> > > One thing that irritated me is that I think this used to work. I do
> > > recall testing suspend/resume a few years ago and devices would get
> > > properly runtime suspended/resumed.
> >=20
> > Not true at all.
> >=20
> > The PM core has always taken PM-runtime references on all devices prett=
y much
> > since when PM-runtime was introduced.
> >=20
> > > I did some digging but couldn't
> > > find anything that would have had an impact on this.
> > >=20
> > > Given that this is completely opt-in feature, why are you categorical=
ly
> > > NAK'ing this?
> >=20
> > The general problem is that if any device has been touched by system-wi=
de
> > suspend code, it should not be subject to PM-runtime any more until the
> > subsequent system-wide resume is able to undo whatever the suspend did.
> >=20
> > Moreover, if a device is runtime-suspended, the system-wide suspend code
> > may mishandle it, in general.  That's why PM-runtime suspend is not all=
owed
> > during system-wide transitions at all.  And it has always been like tha=
t.
> >=20
> > For a specific platform you may be able to overcome these limitations if
> > you are careful enough, but certainly they are there in general and sur=
ely
> > you cannot prevent people from using your opt-in just because they think
> > that they know what they are doing.
>=20
> BTW, what if user space prevents PM-runtime from suspending devices by wr=
iting
> "on" to their "control" files?
>=20
> System-wide suspend is (of course) still expected to work in that case, s=
o how
> exactly would you overcome that?

I suppose one way to overcome that would be to make it an error to write
"on" to the "control" files for these devices.

Currently doing this is likely going to break display support on Tegra,
so this would be a good idea in this case anyway.

Again, I could avoid all of these issues by avoiding runtime PM in this
driver, but I would end up reimplementing some of the same concepts. I'd
rather use something that's supported by the PM core and that might be
useful to other drivers than reinvent the wheel.

Thierry

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3g7gsACgkQ3SOs138+
s6EVug/9HqCpLtpdbbVrtjPoxbNJrqEWax5uT49sxuFt5RJrCLXtGy7r/tMjI8Nr
mLZzLi7K3KRc9rQxnhqq8voZs+VhB96gFfiWRJwhy96+XM05OW0k2TW/rCxqMmtY
E7k3U8ymoAooH7olBza6c6VkY1fO/Egd+MTAW143hDBliLEOgWJLWH1E7vunPR+6
EyXPFR0hU9rG5nOD2OszZ073z5MV+HrQX6GnUsFlcCQq33I/u+5c2MqqOJqGnMHt
oBs+nxgmpGzU8HPTRlAEhNWtS6vkGe0mzfAq9qb/5Oss7SP6IgsqnM3K95B3x2Fy
tfDZnW1O/kbcApP0fJZJsRVjAu8yMcIarqya1QOf1X04rkpib0Mcha7SE/mMewU6
aDtR21B5oJQi2ye5cZjwEJu9IMqukB+KArFPSxlTXjhmyhqg0dkZB4Qc7to2OIGk
icdlZCBvEvqySTWBi8/YzHNyquUfRfs3Fbuj/IleFfxXG7YORGauoRjw2yNZycAE
Cv//Xk0ToJ72TOXu46JLi5srl2+yfeNvSRDvJO2tds2hXUucljadJZfnC9Kn96pP
0DqZfYG+hggfikWOo7JjfYCQAPJTM98dfYr++2Gy6xr6V/BPuQYRYLvPBNk+Cog1
KjETnPb2+opO4nLqR0aedzRh7/O/CjQvbCFJptnBSAmzGfpBAxw=
=1ZX3
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
