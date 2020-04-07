Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFF31A0AC3
	for <lists+linux-pm@lfdr.de>; Tue,  7 Apr 2020 12:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgDGKFZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Apr 2020 06:05:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36508 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgDGKFZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Apr 2020 06:05:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id k1so3201860wrm.3;
        Tue, 07 Apr 2020 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WWziHtBi4oc9djsFaUX7XQ3VCEDyA2EhaftZG+vRTmU=;
        b=DDJtqM0ZmFRZgkoIfjqJdHl3jmIlVS6XZRWpAl1W640TYYwj0oq1aQCqr6ap3+oXJP
         Kc+CTP22W4kFz075wcNPlgXk3WIA2OC06cMHalq/pNM3NkOSxpXQJHnnIN1T0e/TcL8b
         4Da9rKgxsLO+gXm78IdgUnGJbWWBCXW9qxF84EhqNYsncCFZnPXPDHTspg8A/EW5UqEd
         Usyjjklwodn/qRuRfGIsTsG2HS6JuC786EggwG53ZL5smZDXB+SnAHV4dGmsSadipRwI
         8BFWuNpzpawO5DCsGVwbrD+y2DF49Q0yGejQjO7XaC3xrXCP6EZ9DmrUO2haJJUgmaHo
         7RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWziHtBi4oc9djsFaUX7XQ3VCEDyA2EhaftZG+vRTmU=;
        b=FUDQ9JiRFe0OY5ulrgKEwwykIibWe6jjlMLuZT5xTx5sh1Qog1VdOWN0f6Z2kuJLDS
         YGNUIbDM9evpwzC3z53B2zYR9EMK0tt0dZgbKITA3IZHyAWffwGSl0FMjr5mwIDQRNpz
         AicTo/zioFvl8YKEB2++5GWv7ocojxehmdN+i4mYzVKi6gwBlstp+ejHXP05e1+FTx2k
         UQKH4P0yMHEMFpo4uXl+AXpNMYI+fOz4RNcdKsnEJnTp0c+3CjnFyxaz79Sv9PyMw6uZ
         TJc1L7wEnqBwK2F0h5rdGpJv98L2oNvsYwmryOaI7eS9wxaxUaL77Lmf2/I+OGPrG0FQ
         Q3Ig==
X-Gm-Message-State: AGi0PuZ/TVTajEb+YUYMf9qNKQV3S0xSGRkJWP30KfkT5Ml/zwQfOEBX
        ahPjlMjkNTwOzR899yOJW6M=
X-Google-Smtp-Source: APiQypKNqMTxJb7gtU/ZDGcNRW5WADi+fcwveFkxNyy/3NH2A8xr0eNmIy5j6DbGgVgXH5x924qrTQ==
X-Received: by 2002:adf:fe87:: with SMTP id l7mr1823086wrr.377.1586253922777;
        Tue, 07 Apr 2020 03:05:22 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id i2sm30490830wrx.22.2020.04.07.03.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:05:21 -0700 (PDT)
Date:   Tue, 7 Apr 2020 12:05:20 +0200
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
Message-ID: <20200407100520.GA1720957@ulmo>
References: <1575394348-17649-1-git-send-email-sumitg@nvidia.com>
 <20191203174229.GA1721849@ulmo>
 <9404232d-84ce-a117-89dd-f2d8de80993e@kapsi.fi>
 <20191204091703.d32to5omdm3eynon@vireshk-i7>
 <20191204093339.GA2784830@ulmo>
 <20191204095138.rrul5vxnkprfwmku@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20191204095138.rrul5vxnkprfwmku@vireshk-i7>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 04, 2019 at 03:21:38PM +0530, Viresh Kumar wrote:
> On 04-12-19, 10:33, Thierry Reding wrote:
> > Yeah, the code that registers this device is in drivers/base/cpu.c in
> > register_cpu(). It even retrieves the device tree node for the CPU from
> > device tree and stores it in cpu->dev.of_node, so we should be able to
> > just pass &cpu->dev to tegra_bpmp_get() in order to retrieve a reference
> > to the BPMP.
> >=20
> > That said, I'm wondering if perhaps we could just add a compatible
> > string to the /cpus node for cases like this where we don't have an
> > actual device representing the CPU complex. There are a number of CPU
> > frequency drivers that register dummy devices just so that they have
> > something to bind a driver to.
> >=20
> > If we allow the /cpus node to represent the CPU complex (if no other
> > "device" does that yet), we can add a compatible string and have the
> > cpufreq driver match on that.
> >=20
> > Of course this would be slightly difficult to retrofit into existing
> > drivers because they'd need to remain backwards compatible with existing
> > device trees. But it would allow future drivers to do this a little more
> > elegantly. For some SoCs this may not matter, but especially once you
> > start depending on additional resources this would come in handy.
> >=20
> > Adding Rob and the device tree mailing list for feedback on this idea.
>=20
> Took some time to find this thread, but something around this was
> suggested by Rafael earlier.
>=20
> https://lore.kernel.org/lkml/8139001.Q4eV8YG1Il@vostro.rjw.lan/

I gave this a try and came up with the following:

--- >8 ---
diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts=
/nvidia/tegra194.dtsi
index f4ede86e32b4..e4462f95f0b3 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -1764,6 +1764,9 @@ bpmp_thermal: thermal {
 	};
=20
 	cpus {
+		compatible =3D "nvidia,tegra194-ccplex";
+		nvidia,bpmp =3D <&bpmp>;
+
 		#address-cells =3D <1>;
 		#size-cells =3D <0>;
=20
--- >8 ---

Now I can do something rougly like this, although I have a more complete
patch locally that also gets rid of all the global variables because we
now actually have a struct platform_device that we can anchor everything
at:

--- >8 ---
static const struct of_device_id tegra194_cpufreq_of_match[] =3D {
	{ .compatible =3D "nvidia,tegra194-ccplex", },
	{ /* sentinel */ }
};
MODULE_DEVICE_TABLE(of, tegra194_cpufreq_of_match);

static struct platform_driver tegra194_ccplex_driver =3D {
	.driver =3D {
		.name =3D "tegra194-cpufreq",
		.of_match_table =3D tegra194_cpufreq_of_match,
	},
	.probe =3D tegra194_cpufreq_probe,
	.remove =3D tegra194_cpufreq_remove,
};
module_platform_driver(tegra194_ccplex_driver);
--- >8 ---

I don't think that's exactly what Rafael (Cc'ed) had in mind, since the
above thread seems to have mostly talked about binding a driver to each
individual CPU.

But this seems a lot better than having to instantiate a device from
scratch just so that a driver can bind to it and it allows additional
properties to be associated with the CCPLEX device.

Rob, any thoughts on this from a device tree point of view? The /cpus
bindings don't mention the compatible property, but there doesn't seem
to be anything in the bindings that would prohibit its use.

If we can agree on that, I can forward my local changes to Sumit for
inclusion or reference.

Thierry

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6MUF0ACgkQ3SOs138+
s6HaEQ/+PrLLpiP0PyCKw9EYMDnFCSTvnHIrXNeyiycSw3o6+KzTFZ/0H1gWoQQz
A9fdmSWvIO98e2aSMU6KwV+JN/AiOgYA9/oJG1hwKw6/M6z7hMrPeMntFgssE1EP
sGXeYATmFMuCWVqJ8j3+85eKeIAuwauCuf2JXEXBPYCIl/YWNbepLuhAXreDXfqk
rLtIJqDa5G4oCLshLkb1SR211kQM9uDX16EVLL1gc/gd7psSYqUMOxiVEGwMnL5t
h5y+JsMwp4M8CPM4Faq7dEbwKfXOhDJp+aZmMFcm5OEbwSZ7wSUdG3TgoYyEAqhs
O6PDf9IAR323R2Iz38VuwDIcus8arw4mRI7C6k1c+5Bz+mg9nTcbr2MkiDOvEsn7
PkII3xkaTsspdVCtFCIlyROHwVKtdjzyOcXS7t57cXyjrLatTtjCGw20889CzSjd
nTfT5MHCbeex/djcUYRi5Ewe0sT4KSGyud4DgMP9L+Tk87jRGhOUloW3g3DnNQg6
ucn72xKUFnVnlPFnkwXJucHnUdNSxC+FeTWk97Y96QpsdO47tNBNGMlejajIKWhO
p91cb7sD+IvYmCAK/UKtmC6n2rD50IphWxm4zJ2QIkyqsa5H3x2vFAI2CqGsefIa
JhsqKT+LsegNriVWHIFEZzBGj7WDOdvnD/tx12NLFcgyuGFlik8=
=emOZ
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
