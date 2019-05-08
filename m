Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E73A1795E
	for <lists+linux-pm@lfdr.de>; Wed,  8 May 2019 14:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfEHMXl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 May 2019 08:23:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61947 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727575AbfEHMXl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 May 2019 08:23:41 -0400
X-UUID: 0258ad8330e14eaa8eb091acd65846a1-20190508
X-UUID: 0258ad8330e14eaa8eb091acd65846a1-20190508
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 235792297; Wed, 08 May 2019 20:23:37 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 8 May 2019 20:23:35 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 8 May 2019 20:23:35 +0800
Message-ID: <1557318215.29634.7.camel@mtksdccf07>
Subject: Re: [PATCH 1/8] arm64: dts: mt8183: add thermal zone node
From:   Michael Kao <michael.kao@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <fan.chen@mediatek.com>,
        <jamesjj.liao@mediatek.com>, <dawei.chien@mediatek.com>,
        <louis.yu@mediatek.com>, <roger.lu@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
Date:   Wed, 8 May 2019 20:23:35 +0800
In-Reply-To: <c6cf6170-331d-8ffc-d272-e5d8ee648eda@linaro.org>
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
         <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
         <CAJMQK-isJf6f+OubbCdoXs8L2cup=rm3Z8Mr7Q26QshMP-0wxA@mail.gmail.com>
         <20190503164651.GB40515@google.com>
         <c6cf6170-331d-8ffc-d272-e5d8ee648eda@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: AA13AA691B0CF73F1B5A1F4F47777D55CE9FB045FE730AE38B5FDF7571CED59C2000:8
X-MTK:  N
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 2019-05-06 at 12:43 +0200, Daniel Lezcano wrote:
> On 03/05/2019 18:46, Matthias Kaehlcke wrote:
> > Hi,
> > 
> > On Fri, May 03, 2019 at 04:03:58PM +0800, Hsin-Yi Wang wrote:
> >> On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
> >>>
> >>> Add thermal zone node to Mediatek MT8183 dts file.
> >>>
> >>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> >>> ---
> >>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
> >>>  1 file changed, 64 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> >>> index 926df75..b92116f 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> >>> @@ -334,6 +334,67 @@
> >>>                         status = "disabled";
> >>>                 };
> >>>
> >>> +               thermal: thermal@1100b000 {
> >>> +                       #thermal-sensor-cells = <1>;
> >>> +                       compatible = "mediatek,mt8183-thermal";
> >>> +                       reg = <0 0x1100b000 0 0x1000>;
> >>> +                       interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
> >>> +                       clocks = <&infracfg CLK_INFRA_THERM>,
> >>> +                                <&infracfg CLK_INFRA_AUXADC>;
> >>> +                       clock-names = "therm", "auxadc";
> >>> +                       resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
> >>> +                       mediatek,auxadc = <&auxadc>;
> >>> +                       mediatek,apmixedsys = <&apmixedsys>;
> >>> +                       mediatek,hw-reset-temp = <117000>;
> >>> +                       nvmem-cells = <&thermal_calibration>;
> >>> +                       nvmem-cell-names = "calibration-data";
> >>> +               };
> >>> +
> >>> +               thermal-zones {
> >>> +                       cpu_thermal: cpu_thermal {
> >>> +                               polling-delay-passive = <1000>;
> >>> +                               polling-delay = <1000>;
> >>> +
> >>> +                               thermal-sensors = <&thermal 0>;
> >>> +                               sustainable-power = <1500>;
> >>> +                       };
> >>> +
> >>> +                       tzts1: tzts1 {
> >>> +                               polling-delay-passive = <1000>;
> >>> +                               polling-delay = <1000>;
> >>> +                               thermal-sensors = <&thermal 1>;
> >> Is sustainable-power required for tzts? Though it's an optional
> >> property, kernel would have warning:
> >> [    0.631556] thermal thermal_zone1: power_allocator:
> >> sustainable_power will be estimated
> >> [    0.639586] thermal thermal_zone2: power_allocator:
> >> sustainable_power will be estimated
> >> [    0.647611] thermal thermal_zone3: power_allocator:
> >> sustainable_power will be estimated
> >> [    0.655635] thermal thermal_zone4: power_allocator:
> >> sustainable_power will be estimated
> >> [    0.663658] thermal thermal_zone5: power_allocator:
> >> sustainable_power will be estimated
> >> if no sustainable-power assigned.
> > 
> > The property is indeed optional, if it isn't specified IPA will use
> > the sum of the minimum power of all 'power actors' of the zone as
> > estimate (see estimate_sustainable_power()). This may lead to overly
> > agressive throttling, since the nominal sustainable power will always
> > be <= the requested power.
> > 
> > In my understanding the sustainable power may varies between devices,
> > even for the same SoC. One could have all the hardware crammed into a
> > tiny plastic enclosure (e.g. ASUS Chromebit), another might have a
> > laptop form factor and a metal enclosure (e.g. ASUS C201). Both
> > examples are based on an Rockchip rk3288, but they have completely
> > different thermal behavior, and would likely have different values for
> > 'sustainable-power'.
> > 
> > In this sense I tend to consider 'sustainable-power' more a device,
> > than a SoC property. You could specify a 'reasonable' value as a
> > starting point, but it will likely not be optimal for all or even most
> > devices. The warning might even be useful for device makers by
> > indicating them that there is room for tweaking.
> 
> 
> The sustainable power is the power dissipated by the devices belonging
> to the thermal zone at the given trip temperature.
> 
> With the power numbers and the cooling devices, the IPA will change the
> states of the cooling devices to leverage the dissipated power to the
> sustainable power.
> 
> The contribution is the cooling effect of the cooling device.
> 
> However, the IPA is limited to one thermal zone and the cooling device
> is the cpu cooling device. There is the devfreq cooling device but as
> the graphic driver is not upstream, it is found in the android tree only
> for the moment.
> 
> As you mentioned the sustainable power can vary depending on the form
> factor and the production process for the same SoC (they can go to
> higher frequencies thus dissipate more power). That is the reason why we
> split the DT per SoC and we override the values on a per SoC version basis.
> 
> You can have a look the rk3399.dtsi and their variant for experimental
> board (*-rock960.dts) and the chromebook version (*-gru-kevin.dts).
> 
> Do you want a empiric procedure to find out the sustainable power ?
> 
> 
> 
OK, I will add the cooling map. But the tzts1 ~ tzts6 don't need to binding cooler.
The "cpu_thermal" is max value of tzts1 ~tzts6. And cpu_thermal bind
cooler with IPA. tzts1~6 don't need to add cooler. So, do I just add
cooling map without any binding any cooling-cell?

I think thermal framework will add estimated sustainable power. Maybe I
should add by myself. What's procedure do you recommend to find
sustainable power?


