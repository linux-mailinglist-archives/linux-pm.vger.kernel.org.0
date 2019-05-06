Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84014875
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2019 12:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbfEFKno (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 May 2019 06:43:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43371 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfEFKnn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 May 2019 06:43:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so1296848wro.10
        for <linux-pm@vger.kernel.org>; Mon, 06 May 2019 03:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uCi++m+hmflAtTf0wEp9JT3iL7NhPW7odYvIK611ma4=;
        b=SZr/UgT/IQ9sh8lvU0B3M5ekEWd0V/Cm4RNDe4ul6z8F9ZavaeSx4eVJh/dWCzqJUo
         oTscLrrY/6XZpLJTGkh9fAhyvrWiEEUWqYTiUjvzy7RILfvJUyKjB1lUQdxuFEYiil7r
         nCRgmM4BL9sZ78L4/HF73e2hVRJEu3F3ab0ClPhoe37o6TOmB6DiBJXN8kcntvnM6pq4
         gjSzS2FNGW7nUp5PX+fYaI5JzK7lhr7T8H89irVfl5xKre2OHu9snUmHscPcB8oaRGST
         UiXkA8lKGhXNOuprkmPEtZIzhKhsohMtE5PnGSV2mAwj8RYU58yVfGXg269G2yVol4UM
         YzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uCi++m+hmflAtTf0wEp9JT3iL7NhPW7odYvIK611ma4=;
        b=nuhZCUZM9jXWJ4MSl7pD9ygbmUAB6GU4KNaa7Ou117uZ5652nqa93Xp3nmJaHZ/LOj
         FojAez/TJR+LUE37/8nSQnK5orixwJBa7B26mhAqVglxDd/nFMKaczL20zxfY9ZzQFz3
         HwOE6MwtUhuI84+SW0PxYBMEmJh2OpjSU3cHRCTg+M/fymuJsZis9AmSU+TRP/8zcDcB
         wQAtud2uRzZC7+wXmVBSJGTAFKqk/tziik7TaTRXvgzh4xbkBUphFjdLgX8zLRbspmtG
         NObQmV7zD3k1C0Utpt+hecL1qRXu0du8ILfj6F/h0echB/8h2qAUuErFj8WGJLOt5yRh
         2hLw==
X-Gm-Message-State: APjAAAUezbJL+yGfOGyN4u7lLsYD8aSuIs4r0s7Vs0p1YIF49lhCK90Z
        ZG9BYLIgnTAOY+NRco06PygeWTw8WSA=
X-Google-Smtp-Source: APXvYqxMdxGiwDUmRg23C6IamUTuPcgy9FIEmdOIgUAB7rWrlG9hpuSisSfXusd7mNEl3e66L2oRLQ==
X-Received: by 2002:adf:ec0d:: with SMTP id x13mr17035465wrn.268.1557139421124;
        Mon, 06 May 2019 03:43:41 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id t18sm18987347wrg.19.2019.05.06.03.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 03:43:40 -0700 (PDT)
Subject: Re: [PATCH 1/8] arm64: dts: mt8183: add thermal zone node
To:     Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     "michael.kao" <michael.kao@mediatek.com>, fan.chen@mediatek.com,
        jamesjj.liao@mediatek.com, dawei.chien@mediatek.com,
        louis.yu@mediatek.com, roger.lu@mediatek.com,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com>
 <1556793795-25204-2-git-send-email-michael.kao@mediatek.com>
 <CAJMQK-isJf6f+OubbCdoXs8L2cup=rm3Z8Mr7Q26QshMP-0wxA@mail.gmail.com>
 <20190503164651.GB40515@google.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c6cf6170-331d-8ffc-d272-e5d8ee648eda@linaro.org>
Date:   Mon, 6 May 2019 12:43:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190503164651.GB40515@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/05/2019 18:46, Matthias Kaehlcke wrote:
> Hi,
> 
> On Fri, May 03, 2019 at 04:03:58PM +0800, Hsin-Yi Wang wrote:
>> On Thu, May 2, 2019 at 10:43 AM michael.kao <michael.kao@mediatek.com> wrote:
>>>
>>> Add thermal zone node to Mediatek MT8183 dts file.
>>>
>>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 ++++++++++++++++++++++++++++++++
>>>  1 file changed, 64 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> index 926df75..b92116f 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>>> @@ -334,6 +334,67 @@
>>>                         status = "disabled";
>>>                 };
>>>
>>> +               thermal: thermal@1100b000 {
>>> +                       #thermal-sensor-cells = <1>;
>>> +                       compatible = "mediatek,mt8183-thermal";
>>> +                       reg = <0 0x1100b000 0 0x1000>;
>>> +                       interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
>>> +                       clocks = <&infracfg CLK_INFRA_THERM>,
>>> +                                <&infracfg CLK_INFRA_AUXADC>;
>>> +                       clock-names = "therm", "auxadc";
>>> +                       resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
>>> +                       mediatek,auxadc = <&auxadc>;
>>> +                       mediatek,apmixedsys = <&apmixedsys>;
>>> +                       mediatek,hw-reset-temp = <117000>;
>>> +                       nvmem-cells = <&thermal_calibration>;
>>> +                       nvmem-cell-names = "calibration-data";
>>> +               };
>>> +
>>> +               thermal-zones {
>>> +                       cpu_thermal: cpu_thermal {
>>> +                               polling-delay-passive = <1000>;
>>> +                               polling-delay = <1000>;
>>> +
>>> +                               thermal-sensors = <&thermal 0>;
>>> +                               sustainable-power = <1500>;
>>> +                       };
>>> +
>>> +                       tzts1: tzts1 {
>>> +                               polling-delay-passive = <1000>;
>>> +                               polling-delay = <1000>;
>>> +                               thermal-sensors = <&thermal 1>;
>> Is sustainable-power required for tzts? Though it's an optional
>> property, kernel would have warning:
>> [    0.631556] thermal thermal_zone1: power_allocator:
>> sustainable_power will be estimated
>> [    0.639586] thermal thermal_zone2: power_allocator:
>> sustainable_power will be estimated
>> [    0.647611] thermal thermal_zone3: power_allocator:
>> sustainable_power will be estimated
>> [    0.655635] thermal thermal_zone4: power_allocator:
>> sustainable_power will be estimated
>> [    0.663658] thermal thermal_zone5: power_allocator:
>> sustainable_power will be estimated
>> if no sustainable-power assigned.
> 
> The property is indeed optional, if it isn't specified IPA will use
> the sum of the minimum power of all 'power actors' of the zone as
> estimate (see estimate_sustainable_power()). This may lead to overly
> agressive throttling, since the nominal sustainable power will always
> be <= the requested power.
> 
> In my understanding the sustainable power may varies between devices,
> even for the same SoC. One could have all the hardware crammed into a
> tiny plastic enclosure (e.g. ASUS Chromebit), another might have a
> laptop form factor and a metal enclosure (e.g. ASUS C201). Both
> examples are based on an Rockchip rk3288, but they have completely
> different thermal behavior, and would likely have different values for
> 'sustainable-power'.
> 
> In this sense I tend to consider 'sustainable-power' more a device,
> than a SoC property. You could specify a 'reasonable' value as a
> starting point, but it will likely not be optimal for all or even most
> devices. The warning might even be useful for device makers by
> indicating them that there is room for tweaking.


The sustainable power is the power dissipated by the devices belonging
to the thermal zone at the given trip temperature.

With the power numbers and the cooling devices, the IPA will change the
states of the cooling devices to leverage the dissipated power to the
sustainable power.

The contribution is the cooling effect of the cooling device.

However, the IPA is limited to one thermal zone and the cooling device
is the cpu cooling device. There is the devfreq cooling device but as
the graphic driver is not upstream, it is found in the android tree only
for the moment.

As you mentioned the sustainable power can vary depending on the form
factor and the production process for the same SoC (they can go to
higher frequencies thus dissipate more power). That is the reason why we
split the DT per SoC and we override the values on a per SoC version basis.

You can have a look the rk3399.dtsi and their variant for experimental
board (*-rock960.dts) and the chromebook version (*-gru-kevin.dts).

Do you want a empiric procedure to find out the sustainable power ?







-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

