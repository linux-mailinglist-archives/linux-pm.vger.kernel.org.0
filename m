Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC745CA6C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Nov 2021 17:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbhKXQz2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Nov 2021 11:55:28 -0500
Received: from gloria.sntech.de ([185.11.138.130]:34306 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233149AbhKXQz2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Nov 2021 11:55:28 -0500
Received: from ip5f5b2004.dynamic.kabel-deutschland.de ([95.91.32.4] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mpvVH-0006PD-AE; Wed, 24 Nov 2021 17:52:15 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Robin Murphy <robin.murphy@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     robh@kernel.org, arnd@linaro.org, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Add powerzones definition for rock960
Date:   Wed, 24 Nov 2021 17:52:14 +0100
Message-ID: <2457824.5MrYSl4YA0@diego>
In-Reply-To: <f2609d56-f014-3713-8f73-c7ca9c7cba60@linaro.org>
References: <20211124125506.2971069-1-daniel.lezcano@linaro.org> <bf994aa8-df18-22d0-e718-2c8b406a5cc8@arm.com> <f2609d56-f014-3713-8f73-c7ca9c7cba60@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, 24. November 2021, 17:41:34 CET schrieb Daniel Lezcano:
> On 24/11/2021 14:49, Robin Murphy wrote:
> > On 2021-11-24 12:55, Daniel Lezcano wrote:
> >> Add the powerzones description. This first step introduces the big,
> >> the little and the gpu as a powerzone place.
> > 
> > These look more like SoC-level properties than board-level ones - should
> > they be in rk3399.dtsi?
> 
> Yes, it makes sense
> 
> If Heiko is fine with that I can add this description in the rk3399.dtsi
> file

Sure. Robin's suggestion sounds very sensible as these properties are
quite specific to the soc itself.


Heiko

> 
> >> ---
> >>   .../boot/dts/rockchip/rk3399-rock960.dts      | 45 +++++++++++++++++++
> >>   1 file changed, 45 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> >> b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> >> index 1a23e8f3cdf6..83540bdb64cd 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> >> @@ -61,6 +61,51 @@ bt_active_led: led-6 {
> >>           };
> >>       };
> >>   +    powerzones {
> >> +
> >> +        PKG_PZ: pkg {
> >> +            #powerzone-cells = <0>;
> >> +                        powerzone = <&SOC_PZ>;
> >> +        };
> >> +
> >> +        SOC_PZ: soc {
> >> +        };
> >> +    };
> >> +};
> >> +
> >> +&cpu_b0 {
> >> +    #powerzone-cells = <0>;
> >> +    powerzone = <&PKG_PZ>;
> >> +};
> >> +
> >> +&cpu_b1 {
> >> +    #powerzone-cells = <0>;
> >> +    powerzone = <&PKG_PZ>;
> >> +};
> >> +
> >> +&cpu_l0 {
> >> +    #powerzone-cells = <0>;
> >> +    powerzone = <&PKG_PZ>;
> >> +};
> >> +
> >> +&cpu_l1 {
> >> +    #powerzone-cells = <0>;
> >> +    powerzone = <&PKG_PZ>;
> >> +};
> >> +
> >> +&cpu_l2 {
> >> +    #powerzone-cells = <0>;
> >> +    powerzone = <&PKG_PZ>;
> >> +};
> >> +
> >> +&cpu_l3 {
> >> +    #powerzone-cells = <0>;
> >> +    powerzone = <&PKG_PZ>;
> >> +};
> >> +
> >> +&gpu {
> >> +    #powerzone-cells = <0>;
> >> +    powerzone = <&PKG_PZ>;
> >>   };
> >>     &cpu_alert0 {
> >>
> 
> 
> 




