Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12B9819F6
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 14:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfHEMss (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 08:48:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34940 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfHEMsr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 08:48:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so84304397wrm.2
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oCcvAOHAqO79xgLqFQJG5nX7dFejuUKhdOvFqVtwuaQ=;
        b=FChwJRHWW3dzV7lekARV8knI19kr3MzoJn8IqdhP2RrgaIya3gGRxFzMMdCQx+/4Et
         SfeIjcJm4iL1rCJoTTV1Gm7sE9jr2PGwx3XIrr0p4kOTNDGLVeOJmNJg+OolThWDII41
         2UjZew70luwFIku1SOAptaZ5FVp3z7R/XqZ+6Qdxt7lK6EIot0c/SYpHfPtXpU08dJLe
         d42SuTPE9omXgun2WNbF6OAoPCq0SYKORw2F+ad8su6uj+VnerLYfGcGnt3fqrPWD4Yl
         MBZWeoB8EK/5OcFfRKZ2m4h35w6+F+5kXUd7mKHRVgABr4BH0rgCCjFtDSldjpbsTRwt
         mvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oCcvAOHAqO79xgLqFQJG5nX7dFejuUKhdOvFqVtwuaQ=;
        b=ZPdK7cUDjiJPdbfwd9jHFseMdGALOPQExddE86xhqwXHgKdD9YbjsBqtQMROPL7BQT
         j3bjtBUqRzuqn6cZWZRnzCBXJTeG/UA/5yQLOYrdCMOZFMvGh7pCGNE3DU0OHZZnbYdP
         8fakIX6mTP+dN4ynxJQoUmzHqdSUUCKIKv8+f1u74lwIz4ZbqwibHkZrOZZGQpXSnFNa
         4GcrvlajMKWR5kI+mvqKVImGxr+TIJE/mHSEpGey1+2/CcY0xogDmEs3lN4o0MSHRAeq
         VT5sa88OSz39ifyd3419IkL+yMA5KLmtwMi9bQxj+l2DHqLIKA6T7LTXoPwpM9NwRzEj
         qzSA==
X-Gm-Message-State: APjAAAVbo5k3w78e2lPcciHL632vVJOowCRiSCkb9RMRFq1O6WwZ8pbH
        Yop6B0UTeP8KcMBp8fkO4CIFmoz09XM=
X-Google-Smtp-Source: APXvYqwBfUtY4HHqJanim3CfED7337YIudrlcue/iSf8ew+PnhRdLMvdK0/Bpmpr1FNIz44UJYNDZg==
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr15344303wrv.146.1565009324012;
        Mon, 05 Aug 2019 05:48:44 -0700 (PDT)
Received: from [10.1.4.98] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id r5sm91425958wmh.35.2019.08.05.05.48.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 05:48:43 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] arm64: dts: meson: sei510: Add minimal thermal
 zone
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     daniel.lezcano@linaro.org, khilman@baylibre.com,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
References: <20190731153529.30159-1-glaroque@baylibre.com>
 <20190731153529.30159-5-glaroque@baylibre.com>
 <CAFBinCD-DUEjPgfUEJmHpPjw1ShZy7nemaFBKANmM5M42XBG4Q@mail.gmail.com>
From:   guillaume La Roque <glaroque@baylibre.com>
Message-ID: <805dc9fd-1c1f-a23a-27a7-d91908a95a13@baylibre.com>
Date:   Mon, 5 Aug 2019 14:48:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCD-DUEjPgfUEJmHpPjw1ShZy7nemaFBKANmM5M42XBG4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,


On 8/3/19 8:29 PM, Martin Blumenstingl wrote:
> Hi Guillaume,
>
> On Wed, Jul 31, 2019 at 5:36 PM Guillaume La Roque
> <glaroque@baylibre.com> wrote:
>> Add minimal thermal zone for DDR and CPU sensor
> so high DDR (controller?) temperatures will throttle Mali and high PLL
> temperatures will throttle the CPU?
> to get things started I'm fine with this, but I think it should be
> mentioned here

i will add in commit description

>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>>  .../boot/dts/amlogic/meson-g12a-sei510.dts    | 56 +++++++++++++++++++
>>  1 file changed, 56 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>> index 979449968a5f..2c16a2cba0a3 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
>> @@ -10,6 +10,7 @@
>>  #include <dt-bindings/input/input.h>
>>  #include <dt-bindings/gpio/meson-g12a-gpio.h>
>>  #include <dt-bindings/sound/meson-g12a-tohdmitx.h>
>> +#include <dt-bindings/thermal/thermal.h>
>>
>>  / {
>>         compatible = "seirobotics,sei510", "amlogic,g12a";
>> @@ -33,6 +34,53 @@
>>                 ethernet0 = &ethmac;
>>         };
>>
>> +       thermal-zones {
>> +               cpu-thermal {
>> +                       polling-delay = <1000>;
>> +                       polling-delay-passive = <100>;
>> +                       thermal-sensors = <&cpu_temp>;
>> +
>> +                       trips {
>> +                               cpu_critical: cpu-critical {
>> +                                       temperature = <110000>; /* millicelsius */
>> +                                       hysteresis = <2000>; /* millicelsius */
>> +                                       type = "critical";
>> +                               };
>> +                       };
>> +
>> +                       cooling-maps {
>> +                               map {
>> +                                       trip = <&cpu_critical>;
>> +                                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +                                                        <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +                                                        <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
>> +                                                        <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               ddr-thermal {
>> +                       polling-delay = <1000>;
>> +                       polling-delay-passive = <100>;
>> +                       thermal-sensors = <&ddr_temp>;
>> +
>> +                       trips {
>> +                               ddr_critical: ddr-critical {
>> +                                       temperature = <110000>; /* millicelsius */
>> +                                       hysteresis = <2000>; /* millicelsius */
>> +                                       type = "critical";
>> +                               };
>> +                       };
>> +
>> +                       cooling-maps {
>> +                               map {
>> +                                       trip = <&ddr_critical>;
>> +                                       cooling-device = <&mali THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>>         mono_dac: audio-codec-0 {
>>                 compatible = "maxim,max98357a";
>>                 #sound-dai-cells = <0>;
>> @@ -321,6 +369,7 @@
>>         operating-points-v2 = <&cpu_opp_table>;
>>         clocks = <&clkc CLKID_CPU_CLK>;
>>         clock-latency = <50000>;
>> +       #cooling-cells = <2>;
>>  };
>>
>>  &cpu1 {
>> @@ -328,6 +377,7 @@
>>         operating-points-v2 = <&cpu_opp_table>;
>>         clocks = <&clkc CLKID_CPU_CLK>;
>>         clock-latency = <50000>;
>> +       #cooling-cells = <2>;
>>  };
>>
>>  &cpu2 {
>> @@ -335,6 +385,7 @@
>>         operating-points-v2 = <&cpu_opp_table>;
>>         clocks = <&clkc CLKID_CPU_CLK>;
>>         clock-latency = <50000>;
>> +       #cooling-cells = <2>;
>>  };
>>
>>  &cpu3 {
>> @@ -342,6 +393,7 @@
>>         operating-points-v2 = <&cpu_opp_table>;
>>         clocks = <&clkc CLKID_CPU_CLK>;
>>         clock-latency = <50000>;
>> +       #cooling-cells = <2>;
>>  };
>>
>>  &cvbs_vdac_port {
>> @@ -368,6 +420,10 @@
>>         status = "okay";
>>  };
>>
>> +&mali {
>> +       #cooling-cells = <2>;
>> +};
> is there something device-specific in this patch? I'm wondering
> whether we can move all of this go g12a.dtsi to simplify maintenance
> in the future

this is depending of each board. actually it's same on all

but if a new one have a fan this value should be different or not.


>
>
> Martin


thanks,

Guillaume

