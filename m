Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F81B16C92
	for <lists+linux-pm@lfdr.de>; Tue,  7 May 2019 22:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEGUtG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 May 2019 16:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfEGUtG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 May 2019 16:49:06 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED85205C9;
        Tue,  7 May 2019 20:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557262144;
        bh=UgQi0e7oHFXGjN1t4VrSnFtRC24frVRuEPTYfkilrW0=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=wxmG5tUCN0ycumdAr5/YRmGR0VS6AW087jInglKNSFP74iCaL9HDqJd0HLwAUYT/F
         TNmpN2BxlDjHfQzQm3/94TRUXspHIbucrf9jvaUpSHO+GHrTTODDiGrafiurVmYr3b
         9cRG+CeH6C9+gOusj5zihFQMz3pxy+0EUL75anQU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1557215457.2147.90.camel@mtksdaap41>
References: <20190430112012.4514-1-roger.lu@mediatek.com> <20190430112012.4514-2-roger.lu@mediatek.com> <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com> <1556777971.12123.35.camel@mtksdaap41> <155691770027.200842.16164651681407381397@swboyd.mtv.corp.google.com> <1557215457.2147.90.camel@mtksdaap41>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 1/3] dt-bindings: soc: add mtk svs dt-bindings
Cc:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        Angus.Lin@mediatek.com, devicetree@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, Andy-YT.Liu@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, HenryC.Chen@mediatek.com
To:     Roger Lu <roger.lu@mediatek.com>
Message-ID: <155726214346.14659.17800352563837760252@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Tue, 07 May 2019 13:49:03 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Roger Lu (2019-05-07 00:50:57)
> Dear Stephen,
>=20
> Sorry for the late reply.
>=20
> On Fri, 2019-05-03 at 14:08 -0700, Stephen Boyd wrote:
> > Quoting Roger Lu (2019-05-01 23:19:31)
> > > On Tue, 2019-04-30 at 13:31 -0700, Stephen Boyd wrote:
> > > > Quoting Roger Lu (2019-04-30 04:20:10)
> > > > > diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt =
b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > > > > new file mode 100644
> > > > > index 000000000000..355329db74ba
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > [..]
> > > > > +
> > > > > +               svs_gpu: svs_gpu {
> > > > > +                       compatible =3D "mediatek,mt8183-svs-gpu";
> > > > > +                       power-domains =3D <&scpsys MT8183_POWER_D=
OMAIN_MFG_2D>;
> > > > > +                       operating-points-v2 =3D <&gpu_opp_table>;
> > > > > +               };
> > > >=20
> > > > It looks like you need multiple OPPs for a single device, because i=
t has
> > > > different independent power supplies it wants to associate the OPP
> > > > tables with?
> > > Yes. SVS has different controllers inside the hardware in order to
> > > calculate and optimize different OPP table voltage part.
> >=20
> > So is there more than one SVS register region that needs certain devices
> > to be powered on or at least have their power domain enabled so that the
> > SVS hardware can read the voltage and adjust accordingly? I should read
> > the driver I suppose.
> No, basically, each SVS controller (aka SVS bank) only has one SVS
> register region that needs to be powered on for the init.
> In MT8183 SVS case, SVS has four controllers (banks). Each SVS bank
> needs corresponding power domain to be on for its init.
>=20
> #SVS bank corresponding power domain
> svs_cpu_little: Needs CPU-A53 power on for init
> svs_cpu_big: Needs CPU-A73 power on for init
> svs_cci: Needs CPU-A53 power on for init
> svs_gpu: Needs MFG_2D power on for init
>=20
> P.S SVS driver will use pm_runtime_get_sync() to turn on power before
> svs bank init and pm_runtime_put_sync() to turn off power power after
> svs bank init.

Ok. How are you making sure that certain CPUs are powered on?

>=20
> >=20
> > >=20
> > > > Why can't these OPP tables be attached to the devices that
> > > > use them, i.e. CPU, GPU, CCI, etc.? Seems odd that those devices do=
n't
> > > > have OPP tables that this hardware block can look up somehow.
> > > Those OPP tables are attached by our DVFS node (please refers below
> > > patch). SVS just shares with their OPP table and help optimize these =
OPP
> > > tables' voltage part.
> > >=20
> > > Add cpufreq DTS node to the mt8183 and mt8183-evb
> > > https://patchwork.kernel.org/patch/10921675/
> >=20
> > Cool thanks for the pointer.
> >=20
> > >=20
> > >=20
> > > > Similarly,
> > > > the power domains should probably be part of the devices that are u=
sing
> > > > them and not these sub-nodes that are mirroring the other hardware
> > > > blocks in the system?
> > > Oh. There is a svs controller in GPU power-domain. We need to turn on
> > > GPU power so that svs controller can work functionally. Therefore, we
> > > add GPU power-domains in our svs_gpu sub-node.
> > >=20
> > >=20
> >=20
> > Sorry, I'm not really following what you're saying too closely. I think
> > I get it but it sounds complicated.
> >=20
> > I'm mostly wondering if having properties like svs-gpu =3D <&gpu_node>,
> > and svs-cci =3D <&cci_node> would work for you. The idea would be to li=
nk
> > this hardware block to the nodes that it's going to adjust the OPPs of.
> > Once you have the node, use some sort of OPP API to get the OPP table
> > for a device_node and adjust it at runtime for the current OPP.
> Yes, I understand your idea. Thank you. I share my design purpose and
> the troubles I encountered when linking other hardware block.
>=20
> #my design purpose
> 1. SVS bank doesn't need all the resources in other device node like
> cci_node. Therefore, I model SVS sub-nodes to declare what svs bank
> needs.

Do you mean that there are other properties in the cci_node that the SVS
hardware block doesn't use? That doesn't sound like a problem to me. I
view nodes in the SoC bus as all memory mapped IO devices and it sounds
like SVS is a hardware IP core that's off to the side in the system that
has some sensors that goes into various other IP blocks in the system.
It's correct to model the registers and interrupts, etc. as one node for
the one hardware block that's delivered by the hardware engineers.

>=20
> #troubles - linking other hardware block
> 1. I don't know how to get cpu devcie after we link CPU node
> (svs_cpu_little =3D <cpu0>). I use "get_cpu_device(unsigned cpu)" in Linux
> driver to attain cpuX device generally.

This should probably be some sort of list property that points to all
the CPUs in the little and big clusters. Then the code can iterate
through the node pointers and look for an OPP table in any of them by
combining of_cpu_node_to_id() with get_cpu_device()?

> 2. Our MT8183 has three gpu-related node as below, svs_gpu need the
> reference of gpu (OPP table) & gpu_core2 (power-domain MFG_2D) to make
> sure svs_gpu can init and update gpu OPP table. I don't know how to
> refer two nodes by one property. Therefore, I model a svs_gpu to declare
> what it needs.
>=20
> gpu: mali@13040000 {
>         ...
>         power-domains =3D <&scpsys MT8183_POWER_DOMAIN_MFG_CORE0>;
>         operating-points-v2 =3D <&gpu_opp_table>;
>         ...
> }
>=20
> gpu_core1: mali_gpu_core1 {
>         ...
>         power-domains =3D <&scpsys MT8183_POWER_DOMAIN_MFG_CORE1>;
> };
>=20
> gpu_core2: mali_gpu_core2 {
>         ...
>         power-domains =3D <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> };

These three nodes should be combined into one node for the GPU. The
power domains will need to be referred to by name. Luckily we have
support for multiple power domains in the kernel now so this should
work. Let us know if it doesn't work for some reason.

>=20
> P.S MT8183 GPU won't do upstream. So, there is no patchwork weblink to
> refer.

Sure.

