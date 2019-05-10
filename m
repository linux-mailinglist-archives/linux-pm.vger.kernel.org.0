Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534081995D
	for <lists+linux-pm@lfdr.de>; Fri, 10 May 2019 10:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfEJIOT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 May 2019 04:14:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54208 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfEJIOT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 May 2019 04:14:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id 198so6429073wme.3
        for <linux-pm@vger.kernel.org>; Fri, 10 May 2019 01:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cWHo5Txl9QXPDY9hhLJBNpZNAb/E6O11ACMJb7uFruE=;
        b=xSThF7lB5TWfRxfGxyy3ivOZvb2XhLP10h3+AOn6cogd9xhaqoH1ZqQF19jE400CO/
         7B0uBw72QfjMPrGtyg5sFBXqEOTOfhjuG3SmL1PruU34PK4gda0VzpWsiLRrBoD/Y4lz
         Ni68dm1Wn/7sKRGcGYFJMVsnJHzss6Wm+wgcqGqTIe+i8Gl/n6X0wZSxM9q823/HciQC
         mTP2RIqbMrqEDvBYIjOBTFGhv9PLiHPemCk2UFcG7d/Vb03qDypXX2HZuT5PythlNY+x
         lqCmVTYaOuKZ3crEMzTwk1F2ffohwKLGs3atb6gd7tKC5vzLUvHu00QCIBv7EewQek+L
         ajPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cWHo5Txl9QXPDY9hhLJBNpZNAb/E6O11ACMJb7uFruE=;
        b=lIsQfiR7K31b3Wp9Ox7ZqZIMwbdGKEvH7P2mYEsFDLhWSut62K8kvGfH1xvVKlg2vr
         s3ABAIMV+oAFf+XR/HuCOUxbhc/fBMZvU6/n2E0dogY6fT9R6iOGbufEZ/aS1QURCRYX
         531azessTvAa/VZwmo+Oc9eMO9VLGtL6Mjk7NX5TJbxLHfefBYn0I2lYK4JP/DxU74+0
         RQp7j5s/yOrFVBfIVBKvirfGvCN7Ard13jbhUOOkKmF03jEgdctUdkxwrJ+Nr+9l2r4O
         5zaYXslocBtEav7pXPPS4Ncug9QxEnU/YozH3d0lC1il3QJ2wraxW+6gxQeP1o6/p2SF
         fNAw==
X-Gm-Message-State: APjAAAUmwjCq8WyJNd365YVUkaoaXIhZlomcevYwwURvC5funkAYQf5T
        TtmhndpPhIiaxmDUfnDO6bPgBXWV7L4=
X-Google-Smtp-Source: APXvYqwKrDGHEljWb7hbbcto22dMBPQWolTxs3ScElzx6cIEBfri/udj9nTfLOR8Ywqt0/s4fWgnpw==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr5713099wmc.28.1557476056785;
        Fri, 10 May 2019 01:14:16 -0700 (PDT)
Received: from [192.168.0.41] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 91sm8222241wrs.43.2019.05.10.01.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 01:14:15 -0700 (PDT)
Subject: Re: [PATCH 1/8] arm64: dts: mt8183: add thermal zone node
To:     Michael Kao <michael.kao@mediatek.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, fan.chen@mediatek.com,
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
 <c6cf6170-331d-8ffc-d272-e5d8ee648eda@linaro.org>
 <1557318215.29634.7.camel@mtksdccf07>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <12a0f86c-d6ee-6abf-8b2e-c901934dd1ae@linaro.org>
Date:   Fri, 10 May 2019 10:14:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557318215.29634.7.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/05/2019 14:23, Michael Kao wrote:
> On Mon, 2019-05-06 at 12:43 +0200, Daniel Lezcano wrote:
>> On 03/05/2019 18:46, Matthias Kaehlcke wrote:
>>> Hi,
>>> 
>>> On Fri, May 03, 2019 at 04:03:58PM +0800, Hsin-Yi Wang wrote:
>>>> On Thu, May 2, 2019 at 10:43 AM michael.kao 
>>>> <michael.kao@mediatek.com> wrote:
>>>>> 
>>>>> Add thermal zone node to Mediatek MT8183 dts file.
>>>>> 
>>>>> Signed-off-by: Michael Kao <michael.kao@mediatek.com> --- 
>>>>> arch/arm64/boot/dts/mediatek/mt8183.dtsi | 64 
>>>>> ++++++++++++++++++++++++++++++++ 1 file changed, 64 
>>>>> insertions(+)
>>>>> 
>>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi 
>>>>> b/arch/arm64/boot/dts/mediatek/mt8183.dtsi index 
>>>>> 926df75..b92116f 100644 --- 
>>>>> a/arch/arm64/boot/dts/mediatek/mt8183.dtsi +++ 
>>>>> b/arch/arm64/boot/dts/mediatek/mt8183.dtsi @@ -334,6 +334,67 
>>>>> @@ status = "disabled"; };
>>>>> 
>>>>> +               thermal: thermal@1100b000 { + 
>>>>> #thermal-sensor-cells = <1>; + compatible =
>>>>> "mediatek,mt8183-thermal"; + reg = <0 0x1100b000 0 0x1000>;
>>>>> + interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>; + clocks =
>>>>> <&infracfg CLK_INFRA_THERM>, + <&infracfg CLK_INFRA_AUXADC>;
>>>>> + clock-names = "therm", "auxadc"; + resets = <&infracfg
>>>>> MT8183_INFRACFG_AO_THERM_SW_RST>; + mediatek,auxadc =
>>>>> <&auxadc>; + mediatek,apmixedsys = <&apmixedsys>; + 
>>>>> mediatek,hw-reset-temp = <117000>; + nvmem-cells =
>>>>> <&thermal_calibration>; + nvmem-cell-names =
>>>>> "calibration-data"; +               }; + + thermal-zones { +
>>>>> cpu_thermal: cpu_thermal { + polling-delay-passive = <1000>;
>>>>> + polling-delay = <1000>; + + thermal-sensors = <&thermal 0>;
>>>>> + sustainable-power = <1500>; +                       }; + + 
>>>>> tzts1: tzts1 { + polling-delay-passive = <1000>; + 
>>>>> polling-delay = <1000>; + thermal-sensors = <&thermal 1>;
>>>> Is sustainable-power required for tzts? Though it's an optional
>>>> property, kernel would have warning: [    0.631556] thermal
>>>> thermal_zone1: power_allocator: sustainable_power will be
>>>> estimated [    0.639586] thermal thermal_zone2: 
>>>> power_allocator: sustainable_power will be estimated [ 
>>>> 0.647611] thermal thermal_zone3: power_allocator: 
>>>> sustainable_power will be estimated [    0.655635] thermal 
>>>> thermal_zone4: power_allocator: sustainable_power will be 
>>>> estimated [    0.663658] thermal thermal_zone5: 
>>>> power_allocator: sustainable_power will be estimated if no 
>>>> sustainable-power assigned.
>>> 
>>> The property is indeed optional, if it isn't specified IPA will 
>>> use the sum of the minimum power of all 'power actors' of the 
>>> zone as estimate (see estimate_sustainable_power()). This may 
>>> lead to overly agressive throttling, since the nominal 
>>> sustainable power will always be <= the requested power.
>>> 
>>> In my understanding the sustainable power may varies between 
>>> devices, even for the same SoC. One could have all the hardware 
>>> crammed into a tiny plastic enclosure (e.g. ASUS Chromebit), 
>>> another might have a laptop form factor and a metal enclosure 
>>> (e.g. ASUS C201). Both examples are based on an Rockchip rk3288, 
>>> but they have completely different thermal behavior, and would 
>>> likely have different values for 'sustainable-power'.
>>> 
>>> In this sense I tend to consider 'sustainable-power' more a 
>>> device, than a SoC property. You could specify a 'reasonable' 
>>> value as a starting point, but it will likely not be optimal for 
>>> all or even most devices. The warning might even be useful for 
>>> device makers by indicating them that there is room for 
>>> tweaking.
>> 
>> 
>> The sustainable power is the power dissipated by the devices 
>> belonging to the thermal zone at the given trip temperature.
>> 
>> With the power numbers and the cooling devices, the IPA will
>> change the states of the cooling devices to leverage the dissipated
>> power to the sustainable power.
>> 
>> The contribution is the cooling effect of the cooling device.
>> 
>> However, the IPA is limited to one thermal zone and the cooling 
>> device is the cpu cooling device. There is the devfreq cooling 
>> device but as the graphic driver is not upstream, it is found in 
>> the android tree only for the moment.
>> 
>> As you mentioned the sustainable power can vary depending on the 
>> form factor and the production process for the same SoC (they can 
>> go to higher frequencies thus dissipate more power). That is the 
>> reason why we split the DT per SoC and we override the values on a 
>> per SoC version basis.
>> 
>> You can have a look the rk3399.dtsi and their variant for 
>> experimental board (*-rock960.dts) and the chromebook version 
>> (*-gru-kevin.dts).
>> 
>> Do you want a empiric procedure to find out the sustainable power 
>> ?
>> 
>> 
>> 
> OK, I will add the cooling map. But the tzts1 ~ tzts6 don't need to 
> binding cooler. The "cpu_thermal" is max value of tzts1 ~tzts6. And 
> cpu_thermal bind cooler with IPA. tzts1~6 don't need to add cooler. 
> So, do I just add cooling map without any binding any cooling-cell?

For the moment, I suggest to drop the tzts1..tzts6 thermal zones
definition, so you save the discussion with required-optional field for
the cooling maps and you save multiple wake up on the system to poll
thermal zones to do nothing on them.

When multiple thermal zones or multiple sensors will be supported then
you can re-add them if that makes sense.

A side note, the 'max' approach will drop the performances of the board.
If there is one core overheating because it is 100% busy, the frequency
will be capped impacting the performances on all other cores.

> I think thermal framework will add estimated sustainable power.
> Maybe I should add by myself. What's procedure do you recommend to
> find sustainable power?

So the following assumes the values for the dynamic power coefficient
are correct as well as the resulting computed power per OPP.

Let's take the example there is one thermal zone with a cluster of 4
cores and the cpufreq driver acting on this cluster as a cooling device.

First step:

 - Use the stepwise governor

 - Run dhrystone on all cores for a long time

 - When the mitigation begins and the temperature stabilizes on the
desired trip point, capture the cpufreq transitions for, let's say a
period of 30 seconds.

 - Compute the total duration for each cpu freq state during this period

 - Compute the total energy for each cpu freq state

 - Compute the average energy for this period

 - Divide the average energy by the period, you have the sustainable power

Second step:

Nothing is perfect, so the value found above may need to be tweaked.

 - Add the sustainable power in the DT

 - Switch to the IPA

 - Run dhrystone on all cores for a long time

 - Read the temperature and verify it stabilizes at the desired trip
point and readjust the sustainable power if needed.

Please note, as the IPA is based on a open loop regulation P-I-D, it
should begin to acquire temperature before reaching the mitigation trip
point, so it is a good idea to add a trip point 5 or 10 degrees under
the mitigation trip point. The purpose of this 'pre-mitigate' trip point
is to force the IPA to read temperature in advance.

Hope that helps.

  -- Daniel







-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

