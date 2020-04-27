Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8BB1B9831
	for <lists+linux-pm@lfdr.de>; Mon, 27 Apr 2020 09:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgD0HSN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Apr 2020 03:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0HSM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2020 03:18:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92455C061A0F;
        Mon, 27 Apr 2020 00:18:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so19184678wmc.5;
        Mon, 27 Apr 2020 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GSFLOVrCBMaE39ZARVJRO9s5UghXhwgRJUz+OPn7Ktg=;
        b=GtgYzpjjWTvcTiZ6qRjm+FPqX88Fj8nnNToX87F0QUUwa0pKXDv8hPNWRnboMNwfPT
         1sblJ3gFK1cjg4EH1LZ71qlvs4ZEyrYDCfSHBAnVWq9mG8uT9dPOupsy9uPMcNR9Xp+M
         eys0hV+fBwJHmSRlvmuEUAObzw4mewhHJowoHrmRqLMMQBSyljdOMdzHeAsnIxcb73n/
         55bEDqKZD+UFzt7Zhgq3Om55Hyjp2NI6i7jYtfqVGu4w/rGBMp+3xe9xap6Q86Jiit03
         +EIQk4x9QpOdfUyN9f8nlMpYWJjVPVAhPOwlm48ZSJubBNbZ4Gvsm+82Wsn23K1nQSfp
         aFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GSFLOVrCBMaE39ZARVJRO9s5UghXhwgRJUz+OPn7Ktg=;
        b=kOzz6WkOLnXvsLUuFb/N3GC7EEy5U6RjALPcBzQe+1JHr5/Z+ab3n0okX4DBp4I1A0
         X41a58YjMBzSXzmtonkw8qO5awKIZzuvGSZsRxBPRzHKZWgRV6TDeYGwXFNolfTDlejp
         2+Vb/jJJ5i3ETHRamieXCsDykKz6aqlOit9cZ3WFaA+MyekWAJhbJE7h4u7SUJRAZMnX
         U3XftDYzmDeGr9NkpuCdvYEIfocMnpgnCkOXk5cHBhSOF4N4y+VqxNce9AYBZpe9nC3z
         99EkynfFvtFeyfSfM1mpqqPVqEVUAh2cMS80vlgQHFSj56Oa6aj9efh+PWvtXgzSMdwb
         S+iA==
X-Gm-Message-State: AGi0PubNjiFeIhoSgVcXzpLLGII2eQDHt6rSGZh2Ov6Wzd956mXetsxZ
        ZPVW6DKP3pDF8Zv6tvkPZB4=
X-Google-Smtp-Source: APiQypKM/LXleIlMD+jgyvadAcE5+hCHSkKJPgy7DKl3nf8so7RrsI3ytrH2ncjwWK8OegXzmAod/Q==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr24250659wmj.6.1587971891138;
        Mon, 27 Apr 2020 00:18:11 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id s12sm13721240wmc.7.2020.04.27.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 00:18:09 -0700 (PDT)
Date:   Mon, 27 Apr 2020 09:18:00 +0200
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
Message-ID: <20200427071800.GA3451400@ulmo>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
 <20191204091703.d32to5omdm3eynon@vireshk-i7>
 <20191204093339.GA2784830@ulmo>
 <20191204095138.rrul5vxnkprfwmku@vireshk-i7>
 <20200407100520.GA1720957@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20200407100520.GA1720957@ulmo>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2020 at 12:05:20PM +0200, Thierry Reding wrote:
> On Wed, Dec 04, 2019 at 03:21:38PM +0530, Viresh Kumar wrote:
> > On 04-12-19, 10:33, Thierry Reding wrote:
> > > Yeah, the code that registers this device is in drivers/base/cpu.c in
> > > register_cpu(). It even retrieves the device tree node for the CPU fr=
om
> > > device tree and stores it in cpu->dev.of_node, so we should be able to
> > > just pass &cpu->dev to tegra_bpmp_get() in order to retrieve a refere=
nce
> > > to the BPMP.
> > >=20
> > > That said, I'm wondering if perhaps we could just add a compatible
> > > string to the /cpus node for cases like this where we don't have an
> > > actual device representing the CPU complex. There are a number of CPU
> > > frequency drivers that register dummy devices just so that they have
> > > something to bind a driver to.
> > >=20
> > > If we allow the /cpus node to represent the CPU complex (if no other
> > > "device" does that yet), we can add a compatible string and have the
> > > cpufreq driver match on that.
> > >=20
> > > Of course this would be slightly difficult to retrofit into existing
> > > drivers because they'd need to remain backwards compatible with exist=
ing
> > > device trees. But it would allow future drivers to do this a little m=
ore
> > > elegantly. For some SoCs this may not matter, but especially once you
> > > start depending on additional resources this would come in handy.
> > >=20
> > > Adding Rob and the device tree mailing list for feedback on this idea.
> >=20
> > Took some time to find this thread, but something around this was
> > suggested by Rafael earlier.
> >=20
> > https://lore.kernel.org/lkml/8139001.Q4eV8YG1Il@vostro.rjw.lan/
>=20
> I gave this a try and came up with the following:
>=20
> --- >8 ---
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra194.dtsi
> index f4ede86e32b4..e4462f95f0b3 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -1764,6 +1764,9 @@ bpmp_thermal: thermal {
>  	};
> =20
>  	cpus {
> +		compatible =3D "nvidia,tegra194-ccplex";
> +		nvidia,bpmp =3D <&bpmp>;
> +
>  		#address-cells =3D <1>;
>  		#size-cells =3D <0>;
> =20
> --- >8 ---
>=20
> Now I can do something rougly like this, although I have a more complete
> patch locally that also gets rid of all the global variables because we
> now actually have a struct platform_device that we can anchor everything
> at:
>=20
> --- >8 ---
> static const struct of_device_id tegra194_cpufreq_of_match[] =3D {
> 	{ .compatible =3D "nvidia,tegra194-ccplex", },
> 	{ /* sentinel */ }
> };
> MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);
>=20
> static struct platform_driver tegra194_ccplex_driver =3D {
> 	.driver =3D {
> 		.name =3D "tegra194-cpufreq",
> 		.of_match_table =3D tegra194_cpufreq_of_match,
> 	},
> 	.probe =3D tegra194_cpufreq_probe,
> 	.remove =3D tegra194_cpufreq_remove,
> };
> module_platform_driver(tegra194_ccplex_driver);
> --- >8 ---
>=20
> I don't think that's exactly what Rafael (Cc'ed) had in mind, since the
> above thread seems to have mostly talked about binding a driver to each
> individual CPU.
>=20
> But this seems a lot better than having to instantiate a device from
> scratch just so that a driver can bind to it and it allows additional
> properties to be associated with the CCPLEX device.
>=20
> Rob, any thoughts on this from a device tree point of view? The /cpus
> bindings don't mention the compatible property, but there doesn't seem
> to be anything in the bindings that would prohibit its use.
>=20
> If we can agree on that, I can forward my local changes to Sumit for
> inclusion or reference.

Rob, do you see any reason why we shouldn't be able to use a compatible
string in the /cpus node for devices such as Tegra194 where there is no
dedicated hardware block for the CCPLEX?

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6mhyUACgkQ3SOs138+
s6E+QhAApPHiPfSUuUkQgv2VAlF2+HUgVeHwtL5RjQhzcO2s/kaj5v9Cu2xSRvLh
GMg4cEYg8NBv4wDXxtm/OVf4+S5BKs1pX0vyM1xMhiUWgwAPTfkIxoQFmxUCoJUj
LAvCrk1kgGI3dOUdLNoAJh78o6J/OsNbCMlhi2q80RWYnJ9ckrqt6SsTmeHoegKb
9ftQoIfO4amqE56unSmbGL3/ebn3UbqM7JSuPe3LZNj5vxGz9Rz9l8DD6Oz+kVXq
E50KsubpwNUovQfJaBBN+63uLbTKbPtYSPoABTUG2N2KoY/q5vCgoeykCJu00LD1
yCZAJC+nG+paY+N29gUkfKloj249xu86thaRf7i0lVNWSgLkcB9Jc4T0aFdriBE/
wZHOJn39TpeHlok8IKuH5WHbwN4psYT9mXKrfDf2ZyQEytl+llD16oedc6QdcWhd
Qxrtfx6oa1hcKNPsngIukOAe8pzO438/AXpadny5aO9wMYpzZyjfsiCLpSKw+yBR
LuR2nPripZLEeIiD1uQZTnPJkMoCnEUgrxgAXbYqsJKScso3bTJDJgGbl3tW87cF
XR3ZZzMNsfQ9emD8/ps0P1x825v9m6kkL36eoS9A9ueXG/lMJQhQBuK/6l8HjHGd
vnFCTI6FVTQVgMNDJrero/MX4rqFeBc1WBE2pC0iGx0LIntAQSU=
=U6Hg
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
