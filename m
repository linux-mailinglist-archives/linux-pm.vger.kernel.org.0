Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E14A34D5C2
	for <lists+linux-pm@lfdr.de>; Mon, 29 Mar 2021 19:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhC2RJH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Mar 2021 13:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhC2RIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Mar 2021 13:08:45 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70AC061574;
        Mon, 29 Mar 2021 10:08:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 12so6969046wmf.5;
        Mon, 29 Mar 2021 10:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y2ZHeMj4ec57luc4oS02DRiziRVFT/KvHjnr58lcOHE=;
        b=NrOmoj8+szpaD0TUhTvIHhUPkTOQ4tVlROIC1p2MCcryzroeZGHR3ttV2nqcQ6oH5c
         DB5Hsax5Ay315Hv2z6ey7gCtkk5cZa32qjHVVEnR1x+IhlGqsDYxvMT8bHXri9eH5OdU
         iV91ITQsfx4xQmpheYY61o487elN7DDJXcQOKAFwhDUqzEBUwQ62Om7I411XW8n00GlQ
         zN6pBQPrqEuT2ZLESk0oz4jpwGdimFrZxe21VX1PzHzHcwrjLpmavXsAVeKqM5ZocEy3
         PmlQBi6XAX1JpR9uGn5aIq2Xe0Oo6HdvSx8rG+0qKaby+UGTty7qiwGdhpaHSCn7wjDm
         oZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y2ZHeMj4ec57luc4oS02DRiziRVFT/KvHjnr58lcOHE=;
        b=VoQ3r4Z9Fec3TewuHI7i+G25+LascosOHrE4FnDehvDSjq/u2gaCvXEkyqg3V75HHH
         AOnDzp0tLs22ajLJb90uL5AWSPLP0wAEaSS+XAF7ejwoIl8KUkD0ejOMX32YQ4uVmxT0
         +B7MwAEz8mTPxbuR+HZ6eL4ONe4jotQpvPKGCkfzExvkHH1aGJlWQT2blB6CTifIRF2G
         YW/CjOkWlm3wmoQ0dFutA1YV1VcZ5vdnEsfyVqMlPNMXQ5KCl7df70FdeyZpfXyrBL1O
         i5hoXBCZxBnKTY7PQadxquV/BW2HY7lmapk4hfev71M93DVMVbyfMfoAFRwnGFhCREIe
         c09A==
X-Gm-Message-State: AOAM532dg6yxtUmy65OnBpOpsMP/LlnWcKYWFkey+vwwlg7U0Tph/kvu
        ZSKr6HXMurv+mmfXHYaCHvM=
X-Google-Smtp-Source: ABdhPJz/bx5hehJCuehhLrvgunl5jW1+LBDS5GpNha2CBGC2FnW+8T+XE8v2Vs/jtpJf5vn6ags7Iw==
X-Received: by 2002:a1c:1f4c:: with SMTP id f73mr100191wmf.25.1617037724150;
        Mon, 29 Mar 2021 10:08:44 -0700 (PDT)
Received: from ziggy.stardust (80.174.240.175.dyn.user.ono.com. [80.174.240.175])
        by smtp.gmail.com with ESMTPSA id c8sm34819213wrd.55.2021.03.29.10.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 10:08:43 -0700 (PDT)
Subject: Re: [v7,1/3] arm64: dts: mt8183: add thermal zone node
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Michael Kao <michael.kao@mediatek.com>
Cc:     fan.chen@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        srv_heupstream@mediatek.com,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20210316070144.28440-1-michael.kao@mediatek.com>
 <20210316070144.28440-2-michael.kao@mediatek.com>
 <CAJMQK-gQxMmq-4+Hb2vuTmz9T7XOZPV3=uwTp-8doHRVD4y_Jg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b4fb751f-c440-9a39-ea89-21c4543c9d8b@gmail.com>
Date:   Mon, 29 Mar 2021 19:08:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJMQK-gQxMmq-4+Hb2vuTmz9T7XOZPV3=uwTp-8doHRVD4y_Jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 22/03/2021 12:20, Hsin-Yi Wang wrote:
> On Tue, Mar 16, 2021 at 3:02 PM Michael Kao <michael.kao@mediatek.com> wrote:
>>
>> From: "michael.kao" <michael.kao@mediatek.com>
>>
>> Add thermal zone node to Mediatek MT8183 dts file.
>>
>> Evaluate the thermal zone every 500ms while not cooling
>> and every 100ms when passive cooling is performed.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> 
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>
> 

Applied to v5.12-next/dts64

Thanks!

> Tested this patch on mt8183 devices.
> 
>> ---
>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 85 ++++++++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index 5b782a4769e7..d3550af06408 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -657,6 +657,87 @@
>>                         status = "disabled";
>>                 };
>>
>> +               thermal: thermal@1100b000 {
>> +                       #thermal-sensor-cells = <1>;
>> +                       compatible = "mediatek,mt8183-thermal";
>> +                       reg = <0 0x1100b000 0 0x1000>;
>> +                       clocks = <&infracfg CLK_INFRA_THERM>,
>> +                                <&infracfg CLK_INFRA_AUXADC>;
>> +                       clock-names = "therm", "auxadc";
>> +                       resets = <&infracfg  MT8183_INFRACFG_AO_THERM_SW_RST>;
>> +                       interrupts = <0 76 IRQ_TYPE_LEVEL_LOW>;
>> +                       mediatek,auxadc = <&auxadc>;
>> +                       mediatek,apmixedsys = <&apmixedsys>;
>> +                       nvmem-cells = <&thermal_calibration>;
>> +                       nvmem-cell-names = "calibration-data";
>> +               };
>> +
>> +               thermal-zones {
>> +                       cpu_thermal: cpu_thermal {
>> +                               polling-delay-passive = <100>;
>> +                               polling-delay = <500>;
>> +                               thermal-sensors = <&thermal 0>;
>> +                               sustainable-power = <5000>;
>> +                       };
>> +
>> +                       /* The tzts1 ~ tzts6 don't need to polling */
>> +                       /* The tzts1 ~ tzts6 don't need to thermal throttle */
>> +
>> +                       tzts1: tzts1 {
>> +                               polling-delay-passive = <0>;
>> +                               polling-delay = <0>;
>> +                               thermal-sensors = <&thermal 1>;
>> +                               sustainable-power = <5000>;
>> +                               trips {};
>> +                               cooling-maps {};
>> +                       };
>> +
>> +                       tzts2: tzts2 {
>> +                               polling-delay-passive = <0>;
>> +                               polling-delay = <0>;
>> +                               thermal-sensors = <&thermal 2>;
>> +                               sustainable-power = <5000>;
>> +                               trips {};
>> +                               cooling-maps {};
>> +                       };
>> +
>> +                       tzts3: tzts3 {
>> +                               polling-delay-passive = <0>;
>> +                               polling-delay = <0>;
>> +                               thermal-sensors = <&thermal 3>;
>> +                               sustainable-power = <5000>;
>> +                               trips {};
>> +                               cooling-maps {};
>> +                       };
>> +
>> +                       tzts4: tzts4 {
>> +                               polling-delay-passive = <0>;
>> +                               polling-delay = <0>;
>> +                               thermal-sensors = <&thermal 4>;
>> +                               sustainable-power = <5000>;
>> +                               trips {};
>> +                               cooling-maps {};
>> +                       };
>> +
>> +                       tzts5: tzts5 {
>> +                               polling-delay-passive = <0>;
>> +                               polling-delay = <0>;
>> +                               thermal-sensors = <&thermal 5>;
>> +                               sustainable-power = <5000>;
>> +                               trips {};
>> +                               cooling-maps {};
>> +                       };
>> +
>> +                       tztsABB: tztsABB {
>> +                               polling-delay-passive = <0>;
>> +                               polling-delay = <0>;
>> +                               thermal-sensors = <&thermal 6>;
>> +                               sustainable-power = <5000>;
>> +                               trips {};
>> +                               cooling-maps {};
>> +                       };
>> +               };
>> +
>>                 pwm0: pwm@1100e000 {
>>                         compatible = "mediatek,mt8183-disp-pwm";
>>                         reg = <0 0x1100e000 0 0x1000>;
>> @@ -926,6 +1007,10 @@
>>                         reg = <0 0x11f10000 0 0x1000>;
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>> +                       thermal_calibration: calib@180 {
>> +                               reg = <0x180 0xc>;
>> +                       };
>> +
>>                         mipi_tx_calibration: calib@190 {
>>                                 reg = <0x190 0xc>;
>>                         };
>> --
>> 2.18.0
>>
