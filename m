Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE91DB86C
	for <lists+linux-pm@lfdr.de>; Wed, 20 May 2020 17:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgETPjA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 20 May 2020 11:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETPjA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 May 2020 11:39:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F3CC061A0E;
        Wed, 20 May 2020 08:38:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id x20so4354169ejb.11;
        Wed, 20 May 2020 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lrTobF+//sypbygbj7a9h5BUmFVPmTbiLPjpSTzpnAo=;
        b=u33UAPE2F4TuGcc02sR5LzQ+quAFj+whehfinPnJOl1NStC8JM3eYNdL6U0Ybi8Yy7
         wG3D9Z/UNVZZO8R5aWCYRsRDKM5xCKsLcjwj/fZ/kx9qiokdanMr90PGkhEXVstYJyDk
         kJb+VG/XE59RAPr5OyuLILoCFHq+yLZpn+CpUicNYmhgcC8ux3QLS2Cuqx5d6x2cpPIM
         6qPdp3kVPnuPiBLP99Yt3Wh0QvhjjKeH9m5pQizUUhiOmwLt6MkZeuogNzGWOG5BmKXK
         Fa69fImXcIzxHL/NPkNLIRAtbK0xxnpcaS1u1NZPGKmL3LEnvtfR2KGqGhEOH2iQSqmg
         XVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lrTobF+//sypbygbj7a9h5BUmFVPmTbiLPjpSTzpnAo=;
        b=sKg9QfXUw55SSfnzDCg251MJ+jcaay2wCGct0kU4hevb+UXyZa5L8m3aNX3x2XwYSF
         WiHMGR7kXBxfkuiDaVDgwhAppFc4ElLIV4uUpIWX1Q4AQKJXsOV04j0fOffjGANOKBGz
         BTOa2pWXgrkDcvoD6JAj7JraSa26EucnxYgYGHTqGYx0Wv/6z0qrbx8NQIZ/gED6bdPw
         n4TnPUaD3IPpbL9bzMQSaMItFbWNBkZu3gwM+7vU6EtBxYJs8Hm4A1+18EBsI9xjM4GI
         Hoxod9LOBUuL55B4rsjX1wuJ9x8aDRV1iuyOKzEEZdKaM+Mk7gnI0aoJtsINnToShGIG
         Wdgw==
X-Gm-Message-State: AOAM5316U6cju5ozei3c4jEJUnhkj1Sor/Vsh8jpjWNpsgMmpwERAH0u
        9+Qxqyg9VBlCB8/910VsDoI=
X-Google-Smtp-Source: ABdhPJxCa9cXryRI7mDzZxkdrborazNTMg/NupDM54261EzXxLYOmvN/VFsb5Rz1SSN3EV/Z2eRrmA==
X-Received: by 2002:a17:907:aae:: with SMTP id bz14mr3992140ejc.521.1589989138185;
        Wed, 20 May 2020 08:38:58 -0700 (PDT)
Received: from localhost (pd9e51079.dip0.t-ipconnect.de. [217.229.16.121])
        by smtp.gmail.com with ESMTPSA id z3sm2332359ejl.38.2020.05.20.08.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 08:38:55 -0700 (PDT)
Date:   Wed, 20 May 2020 17:38:54 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Sumit Gupta <sumitg@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        bbasu@nvidia.com, Mikko Perttunen <mperttunen@nvidia.com>,
        devicetree@vger.kernel.org
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
Message-ID: <20200520153854.GA2154237@ulmo>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
 <20191204091703.d32to5omdm3eynon@vireshk-i7>
 <20191204093339.GA2784830@ulmo>
 <20191204095138.rrul5vxnkprfwmku@vireshk-i7>
 <20200407100520.GA1720957@ulmo>
 <CAL_Jsq+rMYAZ=ub0U7qdHSsWgbQugodhvigFCxrFm49HwrCmAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+rMYAZ=ub0U7qdHSsWgbQugodhvigFCxrFm49HwrCmAQ@mail.gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 08:43:03AM -0600, Rob Herring wrote:
> On Tue, Apr 7, 2020 at 4:05 AM Thierry Reding <thierry.reding@gmail.com> =
wrote:
> >
> > On Wed, Dec 04, 2019 at 03:21:38PM +0530, Viresh Kumar wrote:
> > > On 04-12-19, 10:33, Thierry Reding wrote:
> > > > Yeah, the code that registers this device is in drivers/base/cpu.c =
in
> > > > register_cpu(). It even retrieves the device tree node for the CPU =
=66rom
> > > > device tree and stores it in cpu->dev.of_node, so we should be able=
 to
> > > > just pass &cpu->dev to tegra_bpmp_get() in order to retrieve a refe=
rence
> > > > to the BPMP.
> > > >
> > > > That said, I'm wondering if perhaps we could just add a compatible
> > > > string to the /cpus node for cases like this where we don't have an
> > > > actual device representing the CPU complex. There are a number of C=
PU
> > > > frequency drivers that register dummy devices just so that they have
> > > > something to bind a driver to.
> > > >
> > > > If we allow the /cpus node to represent the CPU complex (if no other
> > > > "device" does that yet), we can add a compatible string and have the
> > > > cpufreq driver match on that.
> > > >
> > > > Of course this would be slightly difficult to retrofit into existing
> > > > drivers because they'd need to remain backwards compatible with exi=
sting
> > > > device trees. But it would allow future drivers to do this a little=
 more
> > > > elegantly. For some SoCs this may not matter, but especially once y=
ou
> > > > start depending on additional resources this would come in handy.
> > > >
> > > > Adding Rob and the device tree mailing list for feedback on this id=
ea.
> > >
> > > Took some time to find this thread, but something around this was
> > > suggested by Rafael earlier.
> > >
> > > https://lore.kernel.org/lkml/8139001.Q4eV8YG1Il@vostro.rjw.lan/
> >
> > I gave this a try and came up with the following:
> >
> > --- >8 ---
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot=
/dts/nvidia/tegra194.dtsi
> > index f4ede86e32b4..e4462f95f0b3 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > @@ -1764,6 +1764,9 @@ bpmp_thermal: thermal {
> >         };
> >
> >         cpus {
> > +               compatible =3D "nvidia,tegra194-ccplex";
> > +               nvidia,bpmp =3D <&bpmp>;
>=20
> Is there more than 1 bpmp? If not you don't need this. Just lookup the
> node by compatible.

There no SoCs currently than need to differentiate between multiple
BPMPs, so yes, it would be possible to look up the node by compatible.
But we also used to assume that PCs would only ever come with a single
GPU or audio card and that's always caused a lot of work to clean up
when it turned out to no longer be true.

Also, we already have a couple of devices referencing the BPMP by
phandle like this, so having this in a CCPLEX node would keep things
consistent.

One of the reasons why we initially did it this way was also so that we
could make the dependencies explicit within device tree. If we look up
by compatible string, then the driver is the only one with the knowledge
about where to get at it. If we have the explicit reference we at least
have a chance of determining the dependency by just looking at the
device tree.

> > +
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> >
> > --- >8 ---
> >
> > Now I can do something rougly like this, although I have a more complete
> > patch locally that also gets rid of all the global variables because we
> > now actually have a struct platform_device that we can anchor everything
> > at:
> >
> > --- >8 ---
> > static const struct of_device_id tegra194_cpufreq_of_match[] =3D {
> >         { .compatible =3D "nvidia,tegra194-ccplex", },
> >         { /* sentinel */ }
> > };
> > MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
> >
> > static struct platform_driver tegra194_ccplex_driver =3D {
> >         .driver =3D {
> >                 .name =3D "tegra194-cpufreq",
> >                 .of_match_table =3D tegra194_cpufreq_of_match,
> >         },
> >         .probe =3D tegra194_cpufreq_probe,
> >         .remove =3D tegra194_cpufreq_remove,
> > };
> > module_platform_driver(tegra194_ccplex_driver);
> > --- >8 ---
> >
> > I don't think that's exactly what Rafael (Cc'ed) had in mind, since the
> > above thread seems to have mostly talked about binding a driver to each
> > individual CPU.
> >
> > But this seems a lot better than having to instantiate a device from
> > scratch just so that a driver can bind to it and it allows additional
> > properties to be associated with the CCPLEX device.
>=20
> What additional properties? A continual stream of properties added 1
> by 1 would negatively affect my opinion of this.

I don't expect there would be many. I think there's an earlier
generation of Tegra that requires a regulator and I can imagine that's
pretty common. But other than that I would expect this to be a fairly
narrow set of properties.

> > Rob, any thoughts on this from a device tree point of view? The /cpus
> > bindings don't mention the compatible property, but there doesn't seem
> > to be anything in the bindings that would prohibit its use.
>=20
> What happens when you have more than one cpu related driver in
> addition to cpufreq? You may still have to end up creating child
> platform devices and then gained very little.

That's only if you absolutely want to stick with the "one driver per
subsystem" model. I personally think that's completely obsolete these
days. If you have a CPU complex device that can do both CPU frequency
scaling and put the CPU into idle states, for example, then there is
really no reason to artificially split that into two separate drivers
just to match the subsystems that we have.

Most subsystems that I've come across work just fine if a single driver
registers with multiple subsystems.

I also know that some people like it better when things are nicely split
up into multiple drivers. But I really don't see how that simplifies
things. In fact in my opinion that makes things only more complicated
because you have additional boilerplate and then you need to be extra
careful about how these different drivers are ordered, and you need to
take extra precautions when sharing things like clocks and register
regions.

> You could solve this without DT changes. You can bind on node names.
> The driver probe can then check the parent compatible and return if
> not matching. I'm not sure if you could get module auto loading to
> work in that case. It would have to be based on the root compatible
> (rather than the driver match table) and be able to load multiple
> matching modules.

That sounds like it would get very complicated for something this
simple. Having a compatible string in /cpus seemed like the most logical
option because it would basically just work out of the box and the same
way we're used to from other devices.

Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7FTwoACgkQ3SOs138+
s6HtgRAAoeUk0qf8Bct3SQ/jQMddCSneyOM5x6zDbE8hKCketUK0TqO/qvpnY8/0
Z6ADqowq4mqkubUF1BcpiMl9aCiitULrsL2B6I8Nk+bUPNFKFA/m0EFdQgK3ASKo
yi0X+tzyi/jtlSrrjydYBtDoTenpcA2oEfjFADHJbeSCu4FAEjPHXRbAfyL/FzTB
q2gqkpe+1Ghsns9S9bS3Mu2vh181EiqSkTSXy2LX63SQqWxkqcVlxBIxG6C/wvYe
T0CAjytkCVHlTyIeI9cO3Yp8NKMBfP0TAnBA5q1FEdBhwEEmvBpKTe32BOZKxOcY
Mhl5zII7+KfOLyCd1EUF0PJgTKlNlNiX3k4OwbChBucSkN2hLUEvh16aqSsawCZf
kDed64TIPZRLqJL/83xoo1/o0lVDJ5OkqAgKgrX6tcM98RdwXb1rIsiweFoWzZHh
ArNOlzOCxnXtzpTjo5Dw+IqBnzbL0dCiFZRcuqkFKdtYXh2RJAZVdsZfOCJdkKfF
/HEy8rmfsC7NhWsJy5Ta3BDdlpCWzkcQGzib2vFMUWIjrjjHG4qMN/1PixQTpLfR
L4/CP3w7iZyJS211bZPFME1Wkdi6KNk3HiOVJO9TrgV5jEvcYIlwsksxhiO1vepu
tJ2nUmvo8NaZB3sTDFzs6xS6e0L4dMQbtphQxYpZDZkv0Oz2XWg=
=FxLW
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
