Return-Path: <linux-pm+bounces-14937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F9F989F2A
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 12:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71688B21B08
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2024 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB3718A6CD;
	Mon, 30 Sep 2024 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1+Yilfn"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5A189F35;
	Mon, 30 Sep 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727691194; cv=none; b=bMFBOnWcMZ4K9T3mUPa8nW3F+TqJrcmj6oPkEYln9+UxhyyC8h3cLRq6ZLo1HpN2ynPgo3BxLWhnL88NlRMyP6xXnhCW3WQraG2XiMeS1v9Ww6sXtyAZL+PaKuSVTXaojIhp2KX1NlTLFDJajD+Hnrk1DMDgS0XiJKWLGwQ7lS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727691194; c=relaxed/simple;
	bh=PlMn12m/YDLJX6CGIA4X7g5ySMWRXwywQnMxGBadu6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jyWvZX+ldyW0WUWngQIXPkFqFbyI26aqhbZ9cLeWwjGVeLv9dsMtGSvqpul29QtzgfABW3U23btZX71b6S6NL2IENmOLLkfWXfVPCVs55+VQJs4fOQNdJNY3t9a6MsQEwfWsnZxRnqzC1NKhZRc87IhfQVOFJXm6Hir38P7fVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1+Yilfn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso697653166b.0;
        Mon, 30 Sep 2024 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727691191; x=1728295991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R6pcZYDGpExPDliSOuce9JHJM/oFY8zuqaXv7LJ0SI8=;
        b=R1+Yilfn/l0imQzAjL84mbEOmM8afdYk8gTWMwaQ8Li8GFisXFyVua5be4UuDz9Ghf
         T1jqHhEAUUtRKGUbhhk/z4BoKeBBjj7EjJWDrlBleS4wBt2aejWZy16F+oWBTrdS9T+x
         WlaX887sN9cLOEPa2fEY+AQs6YD1YV94nmcj7ihQ7YkvceUwFCZQP5FFxyVd8ABDPH3C
         xZRF/Wz/yCkoSPi0wpxQJo5gS11SOvrVnn2pyADG0RnAC1GAfcJcXfTi9iS9OCuHVbp1
         QWb+dTEZmdhB2y90ibENO8VZ293ni5Y0BN5O5J4KTDhDPC/D93Ku2cUDNWpx2O2i+UjP
         sLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727691191; x=1728295991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6pcZYDGpExPDliSOuce9JHJM/oFY8zuqaXv7LJ0SI8=;
        b=ro5naOV+v4gvU5E9b8S4Vw8PKrm36rqslKvUIP5Wlnna9g1EbAiHiuUnncuYWHAyhJ
         onjfTLJIyDgIGE69fmWS1q6WF9zcW/GUnfJYCt3soCZO5Ils1LVvA/vpQoHzwe+JwA8j
         EpPMAR5IpLtWpNG0/9bQCleEzM5p/u65mJwmm7Hf2kkV5kYUIYLqbkMh42F70FRmSKez
         7j6AgOQuKhqaVzkJKMVS0Cc0gJLmjt8jkMjhdIZpBfZ5ZzHdWteYbWlFzykxfXZPeX1y
         dJnOLLTmJEGVbZnBEIYObVAEIS24DBwox3I1TQc56Sic6uHOWiHzdTY+8ZZAdXZKzpQo
         mKcA==
X-Forwarded-Encrypted: i=1; AJvYcCU2HG7dsO/iuN2+lKWTn/tK5bX8BIkxWd1YDzX0IV9eLsKmN+oqj4Btt5BzcSTV54MWPhqEGW8GDBOa1yU=@vger.kernel.org, AJvYcCVVMNcCI1B7agyDM0CvUzXIpwuVT2ZXj4scs/+xUmyHv2RRIbmQAeHCz/V/MJaGn5jRzqg+x9RN6Yc=@vger.kernel.org, AJvYcCW+HBzXFtVGL8gkEvaD0t1dzo1jxqGbycIlfv20yZAi7nzjs91SNaX7nIXd5K++nHp4gFvgqvoyXpl+lwlkeg==@vger.kernel.org, AJvYcCW4NQNCbUB3j6YvYE9+TBqhOjjwr+3ma8FeMRaspjkl4r0ikltuhW+rBf/ItIbeXbYhKEKI0OGni0Ocsh3Y@vger.kernel.org, AJvYcCXwjQb/ZfkbJ4Y+TfHrbHUErVAPVyzJTzsdI31V4DTPnmMa1cJ3ayRp7qexrriBcIeRZiU7K8+9tZF2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6PzqGPf2NQLY6KKustX5N1Jb4t6dAzqdLx8cCNdujYIwEA8u4
	PVKbHHlEiSwbTmA/pkB/qIAjqBB4kCnqnhK844vuSu+KAkunhvcR
X-Google-Smtp-Source: AGHT+IHiDwmAlbvA79BbqZfqJufqIEN+i8Zje5kiLK8A6GTms4OXnpuYCdwY1SEiJAsZMYFJeszZ0g==
X-Received: by 2002:a17:907:a41:b0:a80:f358:5d55 with SMTP id a640c23a62f3a-a93c492a705mr1432068366b.33.1727691190323;
        Mon, 30 Sep 2024 03:13:10 -0700 (PDT)
Received: from [10.34.18.39] ([95.183.227.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c277723esm510060566b.7.2024.09.30.03.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 03:13:09 -0700 (PDT)
Message-ID: <692e70b4-d4c1-4b14-94f9-e612a23c43e7@gmail.com>
Date: Mon, 30 Sep 2024 13:13:04 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: power: supply: Add DT schema for
 Qualcomm SMBCHG
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Andy Gross <agross@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
 Alejandro Tafalla <atafalla@dnyon.com>,
 Konrad Dybcio <konrad.dybcio@somainline.org>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220808073459.396278-1-y.oudjana@protonmail.com>
 <20220808073459.396278-2-y.oudjana@protonmail.com>
 <9412f6ff-1fd7-31b5-56a7-12bda174f7f6@linaro.org>
Content-Language: en-US
In-Reply-To: <9412f6ff-1fd7-31b5-56a7-12bda174f7f6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Coming back to this patch series after putting it on hold for too long.

On 30/11/2022 7:24 pm, Krzysztof Kozlowski wrote:
> On 08/08/2022 09:34, Yassine Oudjana wrote:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>>
> 
> 
>> +      See Documentation/devicetree/bindings/power/supply/battery.yaml
>> +
>> +  interrupts:
>> +    items:
>> +      - description: Charger error
>> +      - description: Charger inhibited
>> +      - description: Charger precharge safety timer timeout
>> +      - description: Charger charge safety timer timeout
>> +      - description: Charger pre to fast charging switch threshold reached
>> +      - description: Charger recharge threshold reached
>> +      - description: Charger taper threshold reached
> 
> After discussing with Dmitry, it's current design of the PMIC (parent
> device) so it's fine. We would need to make bigger refactoring of
> drivers and bindings to change it to match other typical MFD PMICs. In
> current state it's the only way to express device interrupts.
> 
> Two more comments below.
> 
>> +      - description: Charger charge termination threshold reached
>> +      - description: Battery hot
>> +      - description: Battery warm
>> +      - description: Battery cold
>> +      - description: Battery cool
>> +      - description: Battery overvoltage
>> +      - description: Battery low
>> +      - description: Battery missing
>> +      - description: Battery thermistor missing # unconfirmed
>> +      - description: USB input undervolt
>> +      - description: USB input overvolt
>> +      - description: USB input source detected
>> +      - description: OTG regulator failure
>> +      - description: OTG regulator overcurrent
>> +      - description: Automatic input current limiting done
>> +      - description: USB ID pin changed
>> +      - description: DC input undervolt
>> +      - description: DC input overvolt
>> +      - description: Power OK
>> +      - description: Temperature shutdown
>> +      - description: Watchdog timeout
>> +      - description: Flash failure
>> +      - description: OTST2 # unknown
>> +      - description: OTST3 # unknown
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: chg-error
>> +      - const: chg-inhibit
>> +      - const: chg-prechg-sft
>> +      - const: chg-complete-chg-sft
>> +      - const: chg-p2f-thr
>> +      - const: chg-rechg-thr
>> +      - const: chg-taper-thr
>> +      - const: chg-tcc-thr
>> +      - const: batt-hot
>> +      - const: batt-warm
>> +      - const: batt-cold
>> +      - const: batt-cool
>> +      - const: batt-ov
>> +      - const: batt-low
>> +      - const: batt-missing
>> +      - const: batt-term-missing
>> +      - const: usbin-uv
>> +      - const: usbin-ov
>> +      - const: usbin-src-det
>> +      - const: otg-fail
>> +      - const: otg-oc
>> +      - const: aicl-done
>> +      - const: usbid-change
>> +      - const: dcin-uv
>> +      - const: dcin-ov
>> +      - const: power-ok
>> +      - const: temp-shutdown
>> +      - const: wdog-timeout
>> +      - const: flash-fail
>> +      - const: otst2
>> +      - const: otst3
>> +
>> +  otg-vbus:
>> +    type: object
> 
> I think I did not comment about this one - this looks like regulator.yaml.

Correct. Will add reference.

> 
>> +
>> +    description:
>> +      OTG regulator subnode.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - monitored-battery
>> +  - interrupts
>> +  - interrupt-names
>> +  - otg-vbus
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    battery: battery {
>> +        compatible = "simple-battery";
>> +
>> +        charge-full-design-microamp-hours = <4070000>;
>> +        charge-term-current-microamp = <100000>;
>> +        voltage-min-design-microvolt = <3400000>;
>> +        voltage-max-design-microvolt = <4400000>;
>> +    };
>> +
>> +    pmic {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        charger@1000 {
>> +            compatible = "qcom,pmi8996-smbchg";
>> +            reg = <0x1000>;
>> +
>> +            interrupts = <0x2 0x10 0x0 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x10 0x1 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x10 0x2 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x10 0x3 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x10 0x4 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x10 0x5 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x10 0x6 IRQ_TYPE_EDGE_RISING>,
>> +                         <0x2 0x10 0x7 IRQ_TYPE_EDGE_RISING>,
>> +                         <0x2 0x12 0x0 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x12 0x1 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x12 0x2 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x12 0x3 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x12 0x4 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x12 0x5 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x12 0x6 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x12 0x7 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x13 0x0 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x13 0x1 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x13 0x2 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x13 0x3 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x13 0x4 IRQ_TYPE_EDGE_RISING>,
>> +                         <0x2 0x13 0x5 IRQ_TYPE_EDGE_RISING>,
>> +                         <0x2 0x13 0x6 IRQ_TYPE_EDGE_FALLING>,
>> +                         <0x2 0x14 0x0 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x14 0x1 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x16 0x0 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x16 0x1 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x16 0x2 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x16 0x3 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x16 0x4 IRQ_TYPE_EDGE_BOTH>,
>> +                         <0x2 0x16 0x5 IRQ_TYPE_EDGE_BOTH>;
>> +            interrupt-names = "chg-error",
>> +                              "chg-inhibit",
>> +                              "chg-prechg-sft",
>> +                              "chg-complete-chg-sft",
>> +                              "chg-p2f-thr",
>> +                              "chg-rechg-thr",
>> +                              "chg-taper-thr",
>> +                              "chg-tcc-thr",
>> +                              "batt-hot",
>> +                              "batt-warm",
>> +                              "batt-cold",
>> +                              "batt-cool",
>> +                              "batt-ov",
>> +                              "batt-low",
>> +                              "batt-missing",
>> +                              "batt-term-missing",
>> +                              "usbin-uv",
>> +                              "usbin-ov",
>> +                              "usbin-src-det",
>> +                              "otg-fail",
>> +                              "otg-oc",
>> +                              "aicl-done",
>> +                              "usbid-change",
>> +                              "dcin-uv",
>> +                              "dcin-ov",
>> +                              "power-ok",
>> +                              "temp-shutdown",
>> +                              "wdog-timeout",
>> +                              "flash-fail",
>> +                              "otst2",
>> +                              "otst3";
>> +
>> +            monitored-battery = <&battery>;
>> +
>> +            otg-vbus { };
> 
> Why empty?

I was following similar bindings (see qcom,pm8941-charger and bq24190. 
What properties would I add here? There is nothing configurable with 
this regulator, only way it can be controlled is by enabling/disabling it.

