Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B744C17968
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbfEHM1P (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 08:27:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:64834 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727750AbfEHM1O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 08:27:14 -0400
X-UUID: ce4ffa7adc814d1ea10e8df7d09b91d8-20190508
X-UUID: ce4ffa7adc814d1ea10e8df7d09b91d8-20190508
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 598058400; Wed, 08 May 2019 20:27:08 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 May 2019 20:27:07 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 May 2019 20:27:07 +0800
Message-ID: <1557318427.29634.8.camel@mtksdccf07>
Subject: Re: [PATCH 2/8] arm64: dts: mt8183: add/update dynamic power
 coefficients
From:   Michael Kao <michael.kao@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <jamesjj.liao@mediatek.com>,
        <devicetree@vger.kernel.org>, <louis.yu@mediatek.com>,
        <dawei.chien@mediatek.com>, <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <roger.lu@mediatek.com>, <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        <fan.chen@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 8 May 2019 20:27:07 +0800
In-Reply-To: <CAJMQK-jujDXt18M8610G4GpHdrikTD0ZZG_=C2YTt63UfxuHuQ@mail.gmail.com>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
         <1556793795-25204-3-git-send-email-michael.kao@mediatek.com>
         <CAJMQK-jujDXt18M8610G4GpHdrikTD0ZZG_=C2YTt63UfxuHuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 2019-05-03 at 15:16 +0800, Hsin-Yi Wang wrote:
> On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
> >
> > Add dynamic power coefficients for all cores and update those of
> > CPU0 and CPU4.
> >
> > Signed-off-by: Michael.Kao <michael.kao@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index b92116f..5668fb8 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -58,6 +58,8 @@
> >                         compatible = "arm,cortex-a53";
> >                         reg = <0x000>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <84>;
> > +                       #cooling-cells = <2>;
> Should this line be in [3/8] arm64: dts: mt8183: Add #cooling-cells to
> CPU nodes?
> 
I will fix the mistake at v2 patch list.
> >                 };
> >
> >                 cpu1: cpu@1 {
> > @@ -65,6 +67,8 @@
> >                         compatible = "arm,cortex-a53";
> >                         reg = <0x001>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <84>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu2: cpu@2 {
> > @@ -72,6 +76,8 @@
> >                         compatible = "arm,cortex-a53";
> >                         reg = <0x002>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <84>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu3: cpu@3 {
> > @@ -79,6 +85,8 @@
> >                         compatible = "arm,cortex-a53";
> >                         reg = <0x003>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <84>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu4: cpu@100 {
> > @@ -86,6 +94,8 @@
> >                         compatible = "arm,cortex-a73";
> >                         reg = <0x100>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <211>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu5: cpu@101 {
> > @@ -93,6 +103,8 @@
> >                         compatible = "arm,cortex-a73";
> >                         reg = <0x101>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <211>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu6: cpu@102 {
> > @@ -100,6 +112,8 @@
> >                         compatible = "arm,cortex-a73";
> >                         reg = <0x102>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <211>;
> > +                       #cooling-cells = <2>;
> >                 };
> >
> >                 cpu7: cpu@103 {
> > @@ -107,6 +121,8 @@
> >                         compatible = "arm,cortex-a73";
> >                         reg = <0x103>;
> >                         enable-method = "psci";
> > +                       dynamic-power-coefficient = <211>;
> > +                       #cooling-cells = <2>;
> >                 };
> >         };
> >
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


