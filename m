Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC4134A1
	for <lists+linux-pm@lfdr.de>; Fri,  3 May 2019 23:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbfECVIX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 May 2019 17:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfECVIW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 May 2019 17:08:22 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D2522070B;
        Fri,  3 May 2019 21:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556917701;
        bh=aqcL29qHJsAYLqk55Q2wpnp7s9uGAqVZLA5M+CR6604=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=Dso9UErmUzkJ3ZamrjDEdNv4u7/1wbneeAfHXvB0+lZJsZyTrHTNLtHb+hfLwvKHW
         ywwvXyRhWET2LFDkF3ssEpv/9pyHMhRN5kW7vZAi+ps7oH3L3AnvaRqmaCjQ+sseat
         TAcev7toef6D8yexAqbmooLK868VgmlWzGanEY8w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1556777971.12123.35.camel@mtksdaap41>
References: <20190430112012.4514-1-roger.lu@mediatek.com> <20190430112012.4514-2-roger.lu@mediatek.com> <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com> <1556777971.12123.35.camel@mtksdaap41>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, Angus.Lin@mediatek.com,
        Andy-YT.Liu@mediatek.com
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC v1 1/3] dt-bindings: soc: add mtk svs dt-bindings
Message-ID: <155691770027.200842.16164651681407381397@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 03 May 2019 14:08:20 -0700
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Roger Lu (2019-05-01 23:19:31)
> On Tue, 2019-04-30 at 13:31 -0700, Stephen Boyd wrote:
> > Quoting Roger Lu (2019-04-30 04:20:10)
> > > diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Do=
cumentation/devicetree/bindings/power/mtk-svs.txt
> > > new file mode 100644
> > > index 000000000000..355329db74ba
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
[..]
> > > +
> > > +               svs_gpu: svs_gpu {
> > > +                       compatible =3D "mediatek,mt8183-svs-gpu";
> > > +                       power-domains =3D <&scpsys MT8183_POWER_DOMAI=
N_MFG_2D>;
> > > +                       operating-points-v2 =3D <&gpu_opp_table>;
> > > +               };
> >=20
> > It looks like you need multiple OPPs for a single device, because it has
> > different independent power supplies it wants to associate the OPP
> > tables with?
> Yes. SVS has different controllers inside the hardware in order to
> calculate and optimize different OPP table voltage part.

So is there more than one SVS register region that needs certain devices
to be powered on or at least have their power domain enabled so that the
SVS hardware can read the voltage and adjust accordingly? I should read
the driver I suppose.

>=20
> > Why can't these OPP tables be attached to the devices that
> > use them, i.e. CPU, GPU, CCI, etc.? Seems odd that those devices don't
> > have OPP tables that this hardware block can look up somehow.
> Those OPP tables are attached by our DVFS node (please refers below
> patch). SVS just shares with their OPP table and help optimize these OPP
> tables' voltage part.
>=20
> Add cpufreq DTS node to the mt8183 and mt8183-evb
> https://patchwork.kernel.org/patch/10921675/

Cool thanks for the pointer.

>=20
>=20
> > Similarly,
> > the power domains should probably be part of the devices that are using
> > them and not these sub-nodes that are mirroring the other hardware
> > blocks in the system?
> Oh. There is a svs controller in GPU power-domain. We need to turn on
> GPU power so that svs controller can work functionally. Therefore, we
> add GPU power-domains in our svs_gpu sub-node.
>=20
>=20

Sorry, I'm not really following what you're saying too closely. I think
I get it but it sounds complicated.

I'm mostly wondering if having properties like svs-gpu =3D <&gpu_node>,
and svs-cci =3D <&cci_node> would work for you. The idea would be to link
this hardware block to the nodes that it's going to adjust the OPPs of.
Once you have the node, use some sort of OPP API to get the OPP table
for a device_node and adjust it at runtime for the current OPP. It
sounds like it might be a little more complicated if the hardware goes
haywire when the device like GPU is powered down and the power domain is
shut off. Hopefully it isn't though, so that the driver can mostly sit
on top of the SVS hardware and poke OPP every once and a while when the
voltage needs to change, regardless of the power state of the device.

