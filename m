Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEBC521EBC5
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 10:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGNItt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 04:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgGNIts (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 04:49:48 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C20EC061755;
        Tue, 14 Jul 2020 01:49:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so20350880wrv.9;
        Tue, 14 Jul 2020 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+N9LNhgV2ZUiGn2thD2dhrb9kbQNFZhCqoXnUosFcmY=;
        b=aO4ClOBHbWGRSfcjppygSuPeglb+wtXpvaRN6nL/qPZ2VfphqCrfFV/Na9Fpgt/Mb0
         fApKRa6Y6SLOdtO2Dwk76f2GFk5tO6jSjXDc1zGbZMNwpVnc/Aa0ailAmTjAUt23qJnS
         dT9beAwipVQ+uKsVNitijXXmy6E3BwBeLxyd0kTRj0+G/vxMcorUB5y25JLuK09I1/KT
         vZfe5wrQsTh5TB91pcY0aqXf0nMIOpoN7BPBJLm4d81TsXwaQpp0gzo87/zRlidLwKue
         /wFprDG82Ga0gQ2JJcCCnCbz+yYMPcLf4gWbLGfCnmIYEMfdqCVG/2OSSNGd6tngK744
         9yJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+N9LNhgV2ZUiGn2thD2dhrb9kbQNFZhCqoXnUosFcmY=;
        b=TJi+z+iG+5wKuqchjsjXvkdK4Gk+CEs8OiiTwbLc+DnXhq22PD7byQz3JytWxjMJ8S
         1kE6VHsbgEMOi50K/vg+fxHnzeV2dlKjdQvGjUCHAl2tGbUEEvHzWi5pRJ+LDrPZVHHP
         3uBxrkjY/rLiiQl4KkyNPUGyh0E9lCZ5Rx3g6cp+vQ+MUGIJ8VcEN3e1Mtbm/SoRtoHn
         uc9cuMyALziZHrjURe+H2DUgu3y/b4N6mjp+zJn68nK0khFcww+fQ+jyeAxtVH0NZ2AY
         MyRESpFRCHCJt/2eDYJeTlFQgrkADM8YzyoSu9RqapC6w+Ky1lX915CltKhB50TAAT6i
         G8DA==
X-Gm-Message-State: AOAM5335gAm4TBwhmroWcJj1clXJUNPo0SAsMgZEHINz4umnkC8IkrKn
        YQrL03WEYV8RxlD+E89Y9w/8xXJ1
X-Google-Smtp-Source: ABdhPJx0RDN83W/SP0fzVcl6zerbR0vOCq7puAhfsvL8nJgU2JHMiamQsuJj7lZt/urL82jW80FpSw==
X-Received: by 2002:a5d:6b08:: with SMTP id v8mr4041881wrw.2.1594716586982;
        Tue, 14 Jul 2020 01:49:46 -0700 (PDT)
Received: from [192.168.1.109] ([212.104.123.97])
        by smtp.gmail.com with ESMTPSA id f12sm26670542wrw.53.2020.07.14.01.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 01:49:46 -0700 (PDT)
Subject: Re: [PATCH v3 2/6] dt-bindings: power: supply: Extend max17040
 compatibility
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Bakker <xc-racer2@live.ca>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <20200624155633.3557401-1-iskren.chernev@gmail.com>
 <20200624155633.3557401-3-iskren.chernev@gmail.com>
 <20200713190310.GA546410@bogus>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Message-ID: <c4dc5045-48ee-a27b-98a8-22fdb37d6ba9@gmail.com>
Date:   Tue, 14 Jul 2020 11:49:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200713190310.GA546410@bogus>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 7/13/20 10:03 PM, Rob Herring wrote:
> On Wed, Jun 24, 2020 at 06:56:29PM +0300, Iskren Chernev wrote:
>> Maxim max17040 is a fuel gauge from a larger family utilising the Model
>> Gauge technology. Document all different compatible strings that the
>> max17040 driver recognizes.
>>
>> Some devices in the wild report double the capacity. The
>> maxim,double-soc (from State-Of-Charge) property fixes that.
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>>  .../bindings/power/supply/max17040_battery.txt    | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> index 4e0186b8380fa..554bce82a08e6 100644
>> --- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
>> @@ -2,7 +2,9 @@ max17040_battery
>>  ~~~~~~~~~~~~~~~~
>>
>>  Required properties :
>> - - compatible : "maxim,max17040" or "maxim,max77836-battery"
>> + - compatible : "maxim,max17040", "maxim,max17041", "maxim,max17043",
>> +         "maxim,max17044", "maxim,max17048", "maxim,max17049",
>> +        "maxim,max17058", "maxim,max17059" or "maxim,max77836-battery"
>>   - reg: i2c slave address
>>
>>  Optional properties :
>> @@ -11,6 +13,10 @@ Optional properties :
>>                  generated. Can be configured from 1 up to 32
>>                  (%). If skipped the power up default value of
>>                  4 (%) will be used.
>> +- maxim,double-soc :         Certain devices return double the capacity.
>> +                Specify this boolean property to divide the
>> +                reported value in 2 and thus normalize it.
>> +                SOC == State of Charge == Capacity.
>
> This can't be implied by the compatible string?
>

From what I can tell - no. Here are multiple examples of downstream code:

For max17043:
- single soc [1]
- double soc [2]
- both (toggle with macro) [3]

For max17048:
- single soc [4]
- double soc [5]
- both (toggle with dts) [6], docs [7]

For max17058:
- both (toggle with macro) [8], this device is single
- both (toggle with dts) [9], this device is double [10]

[1] https://github.com/LineageOS/lge-kernel-sniper/blob/9907b1312e9b4c5c4f73ac9bf2e772b12e1c9145/drivers/power/max17043_fuelgauge.c#L383
[2] https://github.com/LineageOS/android_kernel_lge_v500/blob/b4fe00e1f8f09c173a6c28a42ca69ff9529cc13b/drivers/power/max17043_fuelgauge.c#L307
[3] https://github.com/LineageOS/lge-kernel-p880/blob/c5795644a60338f88c7aa29208efadde835ea769/drivers/power/max17043_fuelgauge.c#L406
[4] https://github.com/LineageOS/lge-kernel-star/blob/d963160ebd8e64263ed740d5f1e1a0324085a826/drivers/power/max17048_battery.c#L168
[5] https://github.com/LineageOS/android_kernel_samsung_p4/blob/b190cf1bf4ca0e597a51c820a323f2aa3b2c8585/drivers/power/max17048_battery.c#L192
[6] https://github.com/LineageOS/android_kernel_htc_flounder/blob/03e0b4f36fc60c226adacdb48306df9ec65de33b/drivers/power/max17048_battery.c#L248
[7] https://github.com/LineageOS/android_kernel_htc_flounder/blob/03e0b4f36fc60c226adacdb48306df9ec65de33b/Documentation/devicetree/bindings/power_supply/max17048_battery.txt#L23
[8] https://github.com/LineageOS/android_kernel_asus_moorefield/blob/c3eae894ce8092c2a9a51f9a4924c8df714d6b3c/drivers/power/ASUS_BATTERY/max17058_battery.c#L551
[9] https://github.com/LineageOS/android_kernel_motorola_msm8916/blob/415000d938de1aa46206043e06f033edf33557ce/drivers/power/max17058_battery.c#L225
[10] https://github.com/LineageOS/android_kernel_motorola_msm8916/blob/415000d938de1aa46206043e06f033edf33557ce/arch/arm/boot/dts/qcom/msm8916-harpia-p0a.dts#L59

>>  - interrupts :             Interrupt line see Documentation/devicetree/
>>                  bindings/interrupt-controller/interrupts.txt
>>  - wakeup-source :        This device has wakeup capabilities. Use this
>> @@ -31,3 +37,10 @@ Example:
>>          interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
>>          wakeup-source;
>>      };
>> +
>> +    battery-fuel-gauge@36 {
>> +        compatible = "maxim,max17048";
>> +        reg = <0x36>;
>> +        maxim,alert-low-soc-level = <10>;
>> +        maxim,double-soc;
>> +    };
>> --
>> 2.27.0
>>

