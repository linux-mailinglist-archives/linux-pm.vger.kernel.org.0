Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AA910D570
	for <lists+linux-pm@lfdr.de>; Fri, 29 Nov 2019 13:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfK2MH1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 29 Nov 2019 07:07:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46953 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2MH1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 29 Nov 2019 07:07:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so31430412wrl.13;
        Fri, 29 Nov 2019 04:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+N/7DMl4CedVAQrQO+Pfkl4aemWOSpdG5unraM7Cwd4=;
        b=YOnB3ATGhb/zbN7DTa6DfvpSPT17E9DYZiOdVVl18KhKLvxbkGmJj0tnlVLr+o0G+i
         7bnYdlScQv7y6MpuFbjtvSklZZ5icXuHPOWyhh2zsw2rCd/Lju+VM5cMzU30Zl/DqabN
         ggVYD2eG8GKLo5uFneN6jz6MwAV1DJGw6lBP/5NPeXnrKKrc72QwUPOYxKW0Os4vAG/t
         v4QjjrRdX6GTlMXd7JdSAVg4lzNoUsYaLnqDQf+0EeBaWaWXuqHRPgs0aloSVm+wXmIH
         +RNmr+Ny0qmqaeQFErSJ1YXclSWKHChnlZAFWDAu8BtPL4BwLlLbLNvXEBFJGpqKRI08
         n7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+N/7DMl4CedVAQrQO+Pfkl4aemWOSpdG5unraM7Cwd4=;
        b=h8Es9Wz00ShNcjJKh/VpogEMGeGyglNooORiZVQT0EBnPSfP/UYRIwBGh2kWQky4sb
         Oe/WMa40jfq7o9O5cwaUh2YbiCR5fAmzP3oRXImxUZDosf/lRM8EDD9Ad61lJMm0KVGu
         TnhMERXyEc8pyV/bOiEUvamOeThUy+bdldtXv0K+mD0GrsefOje4AnHjmptq1rkshHrU
         RMWlJe6hGuaZ6Oc1RvzLCur9Nti4VKdRQwnQkWvoX2m/1jmW3o7Fy4QlqMo+z3TFr3XB
         RXuhOmHdoBNECWT3VLlHP7PBRba8Fj/RZxiOLYBJhs81BJHn+aswjiTtZtCKYFn/hJoM
         Jr6A==
X-Gm-Message-State: APjAAAVSD5tIt/msvR6LuvvsxzNj2cmljB9UaGvDBh7uJDbjLYAMflFs
        mfm4yorpOxa1+bSGxTIBmpc=
X-Google-Smtp-Source: APXvYqxb5gkufdCipztR8VBYgrSK+q2xQLkzqjPIx7YyyrjOFlK51+/rSkQ3rYqZiAu+vfvLa9kSkg==
X-Received: by 2002:adf:f7c4:: with SMTP id a4mr38879232wrq.272.1575029242555;
        Fri, 29 Nov 2019 04:07:22 -0800 (PST)
Received: from localhost (pD9E518ED.dip0.t-ipconnect.de. [217.229.24.237])
        by smtp.gmail.com with ESMTPSA id d9sm25545682wrj.10.2019.11.29.04.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2019 04:07:21 -0800 (PST)
Date:   Fri, 29 Nov 2019 13:07:19 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 1/2] PM / runtime: Allow drivers to override runtime PM
 behaviour on sleep
Message-ID: <20191129120719.GF2771912@ulmo>
References: <20191128160314.2381249-1-thierry.reding@gmail.com>
 <20191128163623.GA2382107@ulmo>
 <2310325.iNVD75376c@kreacher>
 <4149037.GOuMSCS4uT@kreacher>
 <20191129094303.GB2770902@ulmo>
 <CAJZ5v0hhMSmLBr+M5CxCrfrcJHH2DzYkRFJBVyBymP0xs35Yzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7J16OGEJ/mt06A90"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hhMSmLBr+M5CxCrfrcJHH2DzYkRFJBVyBymP0xs35Yzw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7J16OGEJ/mt06A90
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2019 at 11:22:08AM +0100, Rafael J. Wysocki wrote:
> On Fri, Nov 29, 2019 at 11:08 AM Thierry Reding
> <thierry.reding@gmail.com> wrote:
> >
> > On Thu, Nov 28, 2019 at 11:20:01PM +0100, Rafael J. Wysocki wrote:
> > > On Thursday, November 28, 2019 11:03:57 PM CET Rafael J. Wysocki wrot=
e:
> > > > On Thursday, November 28, 2019 5:50:26 PM CET Thierry Reding wrote:
> > > > >
> > > > > --0F1p//8PRICkK4MW
> > > > > Content-Type: text/plain; charset=3Dus-ascii
> > > > > Content-Disposition: inline
> > > > > Content-Transfer-Encoding: quoted-printable
> > > > >
> > > > > On Thu, Nov 28, 2019 at 05:14:51PM +0100, Rafael J. Wysocki wrote:
> > > > > > On Thu, Nov 28, 2019 at 5:03 PM Thierry Reding <thierry.reding@=
gmail.com>=3D
> > > > >  wrote:
> > > > > > >
> > > > > > > From: Thierry Reding <treding@nvidia.com>
> > > > > > >
> > > > > > > Currently the driver PM core will automatically acquire a run=
time PM
> > > > > > > reference for devices before system sleep is entered. This is=
 needed
> > > > > > > to avoid potential issues related to devices' parents getting=
 put to
> > > > > > > runtime suspend at the wrong time and causing problems with t=
heir
> > > > > > > children.
> > > > > >=3D20
> > > > > > Not only for that.
> > > > > >=3D20
> > > > > > > In some cases drivers are carefully written to avoid such iss=
ues and
> > > > > > > the default behaviour can be changed to allow runtime PM to o=
perate
> > > > > > > regularly during system sleep.
> > > > > >=3D20
> > > > > > But this change breaks quite a few assumptions in the core too,=
 so no,
> > > > > > it can't be made.
> > > > >
> > > > > Anything in particular that I can look at? I'm not seeing any iss=
ues
> > > > > when I test this, which could of course mean that I'm just getting
> > > > > lucky.
> > > >
> > > > There are races and such that you may never hit during casual testi=
ng.
> > > >
> > > > > One thing that irritated me is that I think this used to work. I =
do
> > > > > recall testing suspend/resume a few years ago and devices would g=
et
> > > > > properly runtime suspended/resumed.
> > > >
> > > > Not true at all.
> > > >
> > > > The PM core has always taken PM-runtime references on all devices p=
retty much
> > > > since when PM-runtime was introduced.
> > > >
> > > > > I did some digging but couldn't
> > > > > find anything that would have had an impact on this.
> > > > >
> > > > > Given that this is completely opt-in feature, why are you categor=
ically
> > > > > NAK'ing this?
> > > >
> > > > The general problem is that if any device has been touched by syste=
m-wide
> > > > suspend code, it should not be subject to PM-runtime any more until=
 the
> > > > subsequent system-wide resume is able to undo whatever the suspend =
did.
> > > >
> > > > Moreover, if a device is runtime-suspended, the system-wide suspend=
 code
> > > > may mishandle it, in general.  That's why PM-runtime suspend is not=
 allowed
> > > > during system-wide transitions at all.  And it has always been like=
 that.
> > > >
> > > > For a specific platform you may be able to overcome these limitatio=
ns if
> > > > you are careful enough, but certainly they are there in general and=
 surely
> > > > you cannot prevent people from using your opt-in just because they =
think
> > > > that they know what they are doing.
> > >
> > > BTW, what if user space prevents PM-runtime from suspending devices b=
y writing
> > > "on" to their "control" files?
> > >
> > > System-wide suspend is (of course) still expected to work in that cas=
e, so how
> > > exactly would you overcome that?
> >
> > I suppose one way to overcome that would be to make it an error to write
> > "on" to the "control" files for these devices.
>=20
> Seeing suggestions like this in messages from seasoned kernel
> developers is seriously disappointing. :-/
>=20
> > Currently doing this is likely going to break display support on Tegra,
> > so this would be a good idea in this case anyway.
>=20
> PM-runtime has always allowed user space to prevent devices from being
> suspended and it seems that this has not been taken into account by
> Tegra display support developers at all.
>=20
> > Again, I could avoid all of these issues by avoiding runtime PM in this=
 driver,
>=20
> I don't quite see the connection here.
>=20
> Preventing a device from suspending should never be a functional
> problem.  It may be an energy-efficiency problem, but that's something
> for user space to consider before writing "on" to a device's control
> file.

That's really a question of how you define suspension. In the case of
display drivers we have the somewhat unfortunate situation that in most
SoCs the display "device" is actually represented by a collection of
different devices. On Tegra specifically, for example, you have a couple
of display controllers, then some "encoders" that take pixel streams
=66rom the display controllers and encode them into some wire format like
LVDS, HDMI, DSI or DP.

Prohibiting suspension of any of the individual devices causes problems
because it effectively makes the whole composite display device not
suspendable. Doing so in turn usually means that you can't change the
display configuration anymore because devices need to be powered up and
down in order to change the configuration.

I consider powering up and down the devices a form of suspension. Hence
it seemed natural to implement using runtime PM.

It sounds to me like userspace preventing runtime PM is problematic in
most scenarios that involve composite devices because it makes all of
the interactions between the devices a bit complicated.

> > but I would end up reimplementing some of the same concepts. I'd
> > rather use something that's supported by the PM core and that might be
> > useful to other drivers than reinvent the wheel.
>=20
> Which doesn't have to be by using PM-runtime suspend for the handling
> of system-wide suspend, at least in my view.

Well, runtime PM is very convenient for this, though. It would allow the
same code paths to be used in all cases.

Thierry

--7J16OGEJ/mt06A90
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl3hCfUACgkQ3SOs138+
s6Gc8hAAkAjQ+kMUIwlH197LtaLHZiI6ADyLbUGvKCYMT220/Z44zyM5noBTbP3m
aeV7J8VqteaV9SNervT7xMbqBmWkBoBeB7sFfK+3acSqk4uV7yusrM9xYTEZYsGW
Hq/ZM2gfyjbXAdOffa9qK2cNJHcJt3Bbd6uyamK16XMvRgiji59SRakEXMchNF1t
7sMuYZ4YEXJm9a+ol1JEZtzOMJSQsq918+LyiVhX/InWndOdC3Rpil57aUX9Xy4Q
hyI7oCTOtnJK4bb5k5VjTc/gSF70jQo2S17sVWdxE4n/PyayQevu1AmQE2gGEEQn
zz/JxHwlSwJ6+tFmBhx1+p0aI5r3nqGBU8ZEb2CnFmrC63LpdiknK1VTFkmkIbEq
/KtGMp9stFrUXHVybauxuvi2K4oAqozXpkULaekNVGPoTJj6rQLVlONnQ5KGLBq7
3im4IhIIw+QgQPO68f6NDpUsddbj76cfuLOQYaGWH0dAFHHClA0Y9vhBVDMb14oJ
HgISQ3xXQmBaJ7fyxJGdaZ5azT/NnCtGC4rXcDz1Ru2CS7/Ac22iBOicu4VHL0lq
+gEfSX3GGGRY9KC0Exaxx382WeJ1ZMJsZ83zyoMARuUP6Toc4sRJRVo3Aq0pfxdQ
GXhrmbGwACm3I0wT97pVazfDn5UM3zcUQ2noq86rj18TBe15G0k=
=JaNk
-----END PGP SIGNATURE-----

--7J16OGEJ/mt06A90--
