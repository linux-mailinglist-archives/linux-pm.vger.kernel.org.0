Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4437A1AE97
	for <lists+linux-pm@lfdr.de>; Mon, 13 May 2019 02:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfEMAew (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 May 2019 20:34:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3751 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727132AbfEMAew (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 May 2019 20:34:52 -0400
X-UUID: 9070c3f4360d43eeb6298196dbac0799-20190513
X-UUID: 9070c3f4360d43eeb6298196dbac0799-20190513
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1730307996; Mon, 13 May 2019 08:34:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 13 May 2019 08:34:41 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 13 May 2019 08:34:41 +0800
Message-ID: <1557707681.30313.68.camel@mtksdaap41>
Subject: Re: [RFC v1 1/3] dt-bindings: soc: add mtk svs dt-bindings
From:   Roger Lu <roger.lu@mediatek.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        <Angus.Lin@mediatek.com>, <devicetree@vger.kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>, <Andy-YT.Liu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <HenryC.Chen@mediatek.com>,
        <Nick.Fan@mediatek.com>, <yt.lee@mediatek.com>
Date:   Mon, 13 May 2019 08:34:41 +0800
In-Reply-To: <155726214346.14659.17800352563837760252@swboyd.mtv.corp.google.com>
References: <20190430112012.4514-1-roger.lu@mediatek.com>
         <20190430112012.4514-2-roger.lu@mediatek.com>
         <155665629219.168659.8221738507474891604@swboyd.mtv.corp.google.com>
         <1556777971.12123.35.camel@mtksdaap41>
         <155691770027.200842.16164651681407381397@swboyd.mtv.corp.google.com>
         <1557215457.2147.90.camel@mtksdaap41>
         <155726214346.14659.17800352563837760252@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Dear Stephen,

Sorry for the late reply.

On Tue, 2019-05-07 at 13:49 -0700, Stephen Boyd wrote:
> Quoting Roger Lu (2019-05-07 00:50:57)
> > Dear Stephen,
> > 
> > Sorry for the late reply.
> > 
> > On Fri, 2019-05-03 at 14:08 -0700, Stephen Boyd wrote:
> > > Quoting Roger Lu (2019-05-01 23:19:31)
> > > > On Tue, 2019-04-30 at 13:31 -0700, Stephen Boyd wrote:
> > > > > Quoting Roger Lu (2019-04-30 04:20:10)
> > > > > > diff --git a/Documentation/devicetree/bindings/power/mtk-svs.txt b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > > > > > new file mode 100644
> > > > > > index 000000000000..355329db74ba
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/power/mtk-svs.txt
> > > [..]
> > > > > > +
> > > > > > +               svs_gpu: svs_gpu {
> > > > > > +                       compatible = "mediatek,mt8183-svs-gpu";
> > > > > > +                       power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> > > > > > +                       operating-points-v2 = <&gpu_opp_table>;
> > > > > > +               };
> > > > > 
> > > > > It looks like you need multiple OPPs for a single device, because it has
> > > > > different independent power supplies it wants to associate the OPP
> > > > > tables with?
> > > > Yes. SVS has different controllers inside the hardware in order to
> > > > calculate and optimize different OPP table voltage part.
> > > 
> > > So is there more than one SVS register region that needs certain devices
> > > to be powered on or at least have their power domain enabled so that the
> > > SVS hardware can read the voltage and adjust accordingly? I should read
> > > the driver I suppose.
> > No, basically, each SVS controller (aka SVS bank) only has one SVS
> > register region that needs to be powered on for the init.
> > In MT8183 SVS case, SVS has four controllers (banks). Each SVS bank
> > needs corresponding power domain to be on for its init.
> > 
> > #SVS bank corresponding power domain
> > svs_cpu_little: Needs CPU-A53 power on for init
> > svs_cpu_big: Needs CPU-A73 power on for init
> > svs_cci: Needs CPU-A53 power on for init
> > svs_gpu: Needs MFG_2D power on for init
> > 
> > P.S SVS driver will use pm_runtime_get_sync() to turn on power before
> > svs bank init and pm_runtime_put_sync() to turn off power power after
> > svs bank init.
> 
> Ok. How are you making sure that certain CPUs are powered on?

Before SVS banks init, We add a qos request to prevent CPU from entering
idle for making sure CPU powers are on. Also, we'll remove this qos
request after SVS banks init are done.

pm_qos_add_request(&qos_request, PM_QOS_CPU_DMA_LATENCY, 0); //prevent CPU idle
pm_qos_remove_request(&qos_request); //release above request

> 
> > 
> > > 
> > > > 
> > > > > Why can't these OPP tables be attached to the devices that
> > > > > use them, i.e. CPU, GPU, CCI, etc.? Seems odd that those devices don't
> > > > > have OPP tables that this hardware block can look up somehow.
> > > > Those OPP tables are attached by our DVFS node (please refers below
> > > > patch). SVS just shares with their OPP table and help optimize these OPP
> > > > tables' voltage part.
> > > > 
> > > > Add cpufreq DTS node to the mt8183 and mt8183-evb
> > > > https://patchwork.kernel.org/patch/10921675/
> > > 
> > > Cool thanks for the pointer.
> > > 
> > > > 
> > > > 
> > > > > Similarly,
> > > > > the power domains should probably be part of the devices that are using
> > > > > them and not these sub-nodes that are mirroring the other hardware
> > > > > blocks in the system?
> > > > Oh. There is a svs controller in GPU power-domain. We need to turn on
> > > > GPU power so that svs controller can work functionally. Therefore, we
> > > > add GPU power-domains in our svs_gpu sub-node.
> > > > 
> > > > 
> > > 
> > > Sorry, I'm not really following what you're saying too closely. I think
> > > I get it but it sounds complicated.
> > > 
> > > I'm mostly wondering if having properties like svs-gpu = <&gpu_node>,
> > > and svs-cci = <&cci_node> would work for you. The idea would be to link
> > > this hardware block to the nodes that it's going to adjust the OPPs of.
> > > Once you have the node, use some sort of OPP API to get the OPP table
> > > for a device_node and adjust it at runtime for the current OPP.
> > Yes, I understand your idea. Thank you. I share my design purpose and
> > the troubles I encountered when linking other hardware block.
> > 
> > #my design purpose
> > 1. SVS bank doesn't need all the resources in other device node like
> > cci_node. Therefore, I model SVS sub-nodes to declare what svs bank
> > needs.
> 
> Do you mean that there are other properties in the cci_node that the SVS
> hardware block doesn't use? That doesn't sound like a problem to me. I
> view nodes in the SoC bus as all memory mapped IO devices and it sounds
> like SVS is a hardware IP core that's off to the side in the system that
> has some sensors that goes into various other IP blocks in the system.
> It's correct to model the registers and interrupts, etc. as one node for
> the one hardware block that's delivered by the hardware engineers.
> 
> > 
> > #troubles - linking other hardware block
> > 1. I don't know how to get cpu devcie after we link CPU node
> > (svs_cpu_little = <cpu0>). I use "get_cpu_device(unsigned cpu)" in Linux
> > driver to attain cpuX device generally.
> 
> This should probably be some sort of list property that points to all
> the CPUs in the little and big clusters. Then the code can iterate
> through the node pointers and look for an OPP table in any of them by
> combining of_cpu_node_to_id() with get_cpu_device()?

Okay. However, it becomes complicated when SVS banks link to other
hardware block to get desired OPP table and power-domains

1. We cannot guarantee the design decision of our SVS Hardware designer. They might put
controller in the hardware block whose dts node doesn't provide the OPP table and
power-domains that SVS bank wants.

#For example:
If there is a SVS bank that wants GPU OPP table but it needs two power-domains(GPU, Vencoder)
for init. Then, it becomes complicated and confusing when SVS sub-node tries to link many nodes.
Therefore, we want to add a sub-node to focus on what SVS bank requires.

2. SVS banks depend on other hardware's power only. All the SVS banks' control registers
are in SVS hardware. So, we think It's good that SVS sub-node describe what their bank requires.

3. We want SVS driver to have a generic way to attain device for using pm_runtime and OPP API.
If SVS banks link to CPU and other subsys device node. It means that SVS driver have to maintain
different topology in order to get CPU and other subsys device (e.g cci).

> 
> > 2. Our MT8183 has three gpu-related node as below, svs_gpu need the
> > reference of gpu (OPP table) & gpu_core2 (power-domain MFG_2D) to make
> > sure svs_gpu can init and update gpu OPP table. I don't know how to
> > refer two nodes by one property. Therefore, I model a svs_gpu to declare
> > what it needs.
> > 
> > gpu: mali@13040000 {
> >         ...
> >         power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_CORE0>;
> >         operating-points-v2 = <&gpu_opp_table>;
> >         ...
> > }
> > 
> > gpu_core1: mali_gpu_core1 {
> >         ...
> >         power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_CORE1>;
> > };
> > 
> > gpu_core2: mali_gpu_core2 {
> >         ...
> >         power-domains = <&scpsys MT8183_POWER_DOMAIN_MFG_2D>;
> > };
> 
> These three nodes should be combined into one node for the GPU. The
> power domains will need to be referred to by name. Luckily we have
> support for multiple power domains in the kernel now so this should
> work. Let us know if it doesn't work for some reason.

Cools. I'll inform our GPU maintainer to check it. Thanks a lot.

> 
> > 
> > P.S MT8183 GPU won't do upstream. So, there is no patchwork weblink to
> > refer.
> 
> Sure.
> 




