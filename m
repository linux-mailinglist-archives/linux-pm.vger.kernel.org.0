Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C261C7746
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 18:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgEFQ6h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 12:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgEFQ6g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 May 2020 12:58:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47386C061A0F;
        Wed,  6 May 2020 09:58:36 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so3567576wmh.0;
        Wed, 06 May 2020 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=urL/1Hl7CbQz1tvWJVXBDZwwE0k+bC9CyG/pLzAD9eY=;
        b=n4ITJP8ZUmskRYarZpj4We/HSjgI/T0Hg9NqtQwemLwUNJVGtEKpWyCyCTp1JMhzQh
         sUs5YCX/fPYV0E4aDGpKnBg3LUKq/lpro2RImH9LrwMIO/vQnundwo84smYOpH8b2Bll
         UpYdAtyetbFM3nd9p4PwYvIUqay9wFG/oBUaY6v2jmHSzGu82RYkuOi3Z7Yuwduvgkvr
         sSKy8B7jfObi65qrK4fWP2YP5cANwiWkDBKhmALtBdfJqeq9Ej5dNDE+cKe9eIGyyEkt
         oE5oVjtEFr5prUat//7+XyuWae2oXYL7JsF+NQJCwBXjKqbzj8sofzwWLoPEMIWN5rsd
         7C7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=urL/1Hl7CbQz1tvWJVXBDZwwE0k+bC9CyG/pLzAD9eY=;
        b=Z/P9exuENOfcsLabHAj50PGlmUoCa+GS9XD/MsFMjLnB4VASLFop/73mnPPBUxZ3DN
         t+opijYYem7dbv4juAg/mS1hSVEgm/DaeMgV6x7nZGQqX7tPxnU7fAiTs59ulJTpFpqE
         xMsF6UGolLhduuFxkE0se8+k3nq3dEPY3Vm70wklSvHViyJvr8r9W1ZMwk0xU7oVb2dc
         hzjAdXrpiFYxa3aWcer5FjfOzWpE2oRKVPI6FUBXi50uM61zFTuAjruRYsOkdepzTNto
         VmJiiiTu4bqCdHiz/Y9ncJenxmC9cGux10v/MBd4VwMyOCXEE8dWwmUm52Uebf/FvN9R
         0oCA==
X-Gm-Message-State: AGi0PuaeLxCxw+ujsFwFWN+ccnyoQVUaNXs6qiq1GsR7LOuMl6Nq9NJk
        hzlzAEZYqPkMWWJzbHDY4gU=
X-Google-Smtp-Source: APiQypLL8NcQW71SlaZlZM66Xm2JGhE9FIsxnUUClaZ7Wp7fOFdRjERSk9KK8D941iPG5yUy/53sng==
X-Received: by 2002:a1c:a4c2:: with SMTP id n185mr5853495wme.104.1588784313927;
        Wed, 06 May 2020 09:58:33 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id l16sm3551225wrp.91.2020.05.06.09.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 09:58:32 -0700 (PDT)
Date:   Wed, 6 May 2020 18:58:31 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mikko Perttunen <cyndis@kapsi.fi>, Sumit Gupta <sumitg@nvidia.com>,
        catalin.marinas@arm.com, will@kernel.org, jonathanh@nvidia.com,
        talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com, devicetree@vger.kernel.org
Subject: Re: [TEGRA194_CPUFREQ Patch 1/3] firmware: tegra: adding function to
 get BPMP data
Message-ID: <20200506165831.GD2723987@ulmo>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
 <20191204091703.d32to5omdm3eynon@vireshk-i7>
 <20191204093339.GA2784830@ulmo>
 <20191204095138.rrul5vxnkprfwmku@vireshk-i7>
 <20200407100520.GA1720957@ulmo>
 <20200427071800.GA3451400@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline
In-Reply-To: <20200427071800.GA3451400@ulmo>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2020 at 09:18:00AM +0200, Thierry Reding wrote:
> On Tue, Apr 07, 2020 at 12:05:20PM +0200, Thierry Reding wrote:
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
> > > >=20
> > > > That said, I'm wondering if perhaps we could just add a compatible
> > > > string to the /cpus node for cases like this where we don't have an
> > > > actual device representing the CPU complex. There are a number of C=
PU
> > > > frequency drivers that register dummy devices just so that they have
> > > > something to bind a driver to.
> > > >=20
> > > > If we allow the /cpus node to represent the CPU complex (if no other
> > > > "device" does that yet), we can add a compatible string and have the
> > > > cpufreq driver match on that.
> > > >=20
> > > > Of course this would be slightly difficult to retrofit into existing
> > > > drivers because they'd need to remain backwards compatible with exi=
sting
> > > > device trees. But it would allow future drivers to do this a little=
 more
> > > > elegantly. For some SoCs this may not matter, but especially once y=
ou
> > > > start depending on additional resources this would come in handy.
> > > >=20
> > > > Adding Rob and the device tree mailing list for feedback on this id=
ea.
> > >=20
> > > Took some time to find this thread, but something around this was
> > > suggested by Rafael earlier.
> > >=20
> > > https://lore.kernel.org/lkml/8139001.Q4eV8YG1Il@vostro.rjw.lan/
> >=20
> > I gave this a try and came up with the following:
> >=20
> > --- >8 ---
> > diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot=
/dts/nvidia/tegra194.dtsi
> > index f4ede86e32b4..e4462f95f0b3 100644
> > --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> > @@ -1764,6 +1764,9 @@ bpmp_thermal: thermal {
> >  	};
> > =20
> >  	cpus {
> > +		compatible =3D "nvidia,tegra194-ccplex";
> > +		nvidia,bpmp =3D <&bpmp>;
> > +
> >  		#address-cells =3D <1>;
> >  		#size-cells =3D <0>;
> > =20
> > --- >8 ---
> >=20
> > Now I can do something rougly like this, although I have a more complete
> > patch locally that also gets rid of all the global variables because we
> > now actually have a struct platform_device that we can anchor everything
> > at:
> >=20
> > --- >8 ---
> > static const struct of_device_id tegra194_cpufreq_of_match[] =3D {
> > 	{ .compatible =3D "nvidia,tegra194-ccplex", },
> > 	{ /* sentinel */ }
> > };
> > MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
> >=20
> > static struct platform_driver tegra194_ccplex_driver =3D {
> > 	.driver =3D {
> > 		.name =3D "tegra194-cpufreq",
> > 		.of_match_table =3D tegra194_cpufreq_of_match,
> > 	},
> > 	.probe =3D tegra194_cpufreq_probe,
> > 	.remove =3D tegra194_cpufreq_remove,
> > };
> > module_platform_driver(tegra194_ccplex_driver);
> > --- >8 ---
> >=20
> > I don't think that's exactly what Rafael (Cc'ed) had in mind, since the
> > above thread seems to have mostly talked about binding a driver to each
> > individual CPU.
> >=20
> > But this seems a lot better than having to instantiate a device from
> > scratch just so that a driver can bind to it and it allows additional
> > properties to be associated with the CCPLEX device.
> >=20
> > Rob, any thoughts on this from a device tree point of view? The /cpus
> > bindings don't mention the compatible property, but there doesn't seem
> > to be anything in the bindings that would prohibit its use.
> >=20
> > If we can agree on that, I can forward my local changes to Sumit for
> > inclusion or reference.
>=20
> Rob, do you see any reason why we shouldn't be able to use a compatible
> string in the /cpus node for devices such as Tegra194 where there is no
> dedicated hardware block for the CCPLEX?

Rob, can you take a brief look and provide some feedback on this? I'd
like to get this merged for v5.8 and where to instantiate this is the
only thing holding this up at this point.

Thanks,
Thierry

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6y7LQACgkQ3SOs138+
s6H8fhAAsblr+qgCiB7yS180H3p6InsOYHfDulKJs1Q5JgPntHbYFHnkkOY8ciHS
3FYgPS7F1UEbIq3hSKsd9W/eEaAEPI9wCah03JEUQwhICaIJRDjyT8ZRN4hNxtDW
DBI0TfsGIz+DwjbNkfYdjoSzACDUKtq4ROeJxo2qIUdAwNxlQ5c0coSma3EgPocA
AUwQ2dn+26tXF6ghTdmwT30rrXAHsZ8mMAawS0FmFgXIQhRrRTTmoMz+Khi8H8/I
UfKmF5wHXnWRGMViKrlotwr5imKryi5IWHjTTgppCNHHWZXqRVgfjz1d8VIMxSrd
hPchNhx+kE43wsf030h2TAhmdQ4YONqRCthET4UmAcK2H+OzOIpwdb9ukJxx0NxU
5EGuPpOGeZc8pIkWtGt9tbKmxUf4CijBbc01FbTXAnX6oVl12MnXu2QiyMXNh9qM
AEyuxG0cbKDDSVDqnjqiZtsBiicNnsR3aZE/bKLWA3ZaoloqKJTKM/c1k0WV/ea8
OPE5lmwoEJCtIL2I/TYKaOexVYuXcO2JjLNVhJ7gKbXB0CGblDygcvvKV/bbivSU
Osn/wiXGz8fen/IBfWGG5VAwXr79aMn89EJeKkUqXGMhJ+CW+Lk5XhA4WxGE/44/
POtwuKsO4lFKLthTmNkAwhy4zLnYTRJ769DSUzNdpaRs1h4+lcU=
=frvo
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--
