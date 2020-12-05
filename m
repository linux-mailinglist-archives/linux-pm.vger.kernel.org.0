Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E6A2CFF12
	for <lists+linux-pm@lfdr.de>; Sat,  5 Dec 2020 22:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgLEVGX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 5 Dec 2020 16:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLEVGX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 5 Dec 2020 16:06:23 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF12C061A4F
        for <linux-pm@vger.kernel.org>; Sat,  5 Dec 2020 13:05:36 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id q8so10621510ljc.12
        for <linux-pm@vger.kernel.org>; Sat, 05 Dec 2020 13:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l7PcuRvH2lvNTCeViNhB8nA3QkFXJkV9Gl2IRDNWkAw=;
        b=VKbz9r/11ppxewhAL3MRcb/GtaNpPtPYglYTdQDNmV0TCXIFdrgcgMtkArIqGTjpK7
         UejGaSzbAOJ2VsO+HniC52RRbh3zRcocpAwHidbbQL+lV4MhGXb21C5vgNi7NbjWhihv
         RKpFyCje/tVLzFokQhPrO3m7BfSWIMANQusS6nsfGqZkdfo5fF5ruIq5Yv8a4TDAJmx3
         L9d1POmHfSKtCXYfWHc8XBxvBoLAJ+lvUQOVFOlYDR4146NiO5CIFUUI3FU/jTjV8AIF
         k5pBy0Z+4wbfCFxYZXA30GpXUXDLRZzyQ8kiqdL4kW9dfMHcc0gf9wvq7mEuMlxkjLN9
         kSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l7PcuRvH2lvNTCeViNhB8nA3QkFXJkV9Gl2IRDNWkAw=;
        b=rYBu0kk0bvghareJDC4aa+w9yeAUv0mjQ2GTXKRNLC13aYxB6NVA9IU+NPBwC8BFwO
         WaewLLf8o5xOLg21DN5z1ezi8JWMha94OaxXGuEDqTXmpx5Dmpl6kS4ubixGdFrL6khi
         VZM+1Af5vkotFiwLuc8TQPquv7JF+xxEPCOgL80gUSl5rrqFLGpSm19BS3gpB+DYQrBO
         ndJM1wAl42ENAk5fw9gfieTG1OBmBUEbfFUp3Aa82bdElx8ozDXSLEFgs1lW6bKvwlbU
         YDnUqymP2cYaiwDiVxzFxiRt4oxgtyOEN4GhyIz8S3GTWUQcsBVTlGZz+CPwy1UDenUO
         SUCQ==
X-Gm-Message-State: AOAM5304B9jqm9SVfIYH1EFI4t5++RCg5YMEKa5C+dfvIdGj50TSwRY+
        uB7OgFvsSrzXnREz48ZT1ElHpw==
X-Google-Smtp-Source: ABdhPJxUfR3PGDS+RKxcbacmYSpIPDJpurEtbRQcNlhGoXkpPQ40eJomWsVIVOXgu0j4y+sfskWZFw==
X-Received: by 2002:a2e:720c:: with SMTP id n12mr6257982ljc.424.1607202333043;
        Sat, 05 Dec 2020 13:05:33 -0800 (PST)
Received: from [192.168.0.150] ([94.25.229.141])
        by smtp.gmail.com with ESMTPSA id j27sm146451lfm.178.2020.12.05.13.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Dec 2020 13:05:32 -0800 (PST)
Subject: Re: [PATCH v10 00/15] qcom: pm8150: add support for thermal
 monitoring
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
 <20201205170830.4d56ecb7@archlinux>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <4de94396-54c7-e741-b288-3a3868515f7b@linaro.org>
Date:   Sun, 6 Dec 2020 00:05:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201205170830.4d56ecb7@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 05/12/2020 20:08, Jonathan Cameron wrote:
> On Fri,  4 Dec 2020 05:54:54 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> 
>> This patch serie adds support for thermal monitoring block on Qualcomm's
>> PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
>> to support thermal zones provided by this thermal monitoring block.
>> Unlike the rest of PMIC thermal senses, these thermal zones describe
>> particular thermistors, which differ between from board to board.
> 
> I've just taken another look through the various IIO parts in here and
> I think they are fine.
> 
> My assumption is that given the timing this isn't going to make the merge
> window now.  Hence I'll be looking to do an immutable branch based on rc1
> once it's available (assuming everyone else is fine with this version).

Thank you! Another option might be to merge all iio changes this cycle 
(if it's fine with you) and have all the rest go via respective trees in 
the next merge window. I'm fine with either of the options.

> 
> Thanks,
> 
> Jonathan
> 
>>
>> Changes since v9:
>>   - In patch 12 add comments to the code as requested by Daniel Lezcano.
>>   - Change copyright comment in qcom-spmi-adc-tm5.c to clearly note
>>     driver history.
>>
>> Changes since v8:
>>   - Simplified qcom_vadc_map_voltage_temp() code by removing ascending
>>     tables support
>>   - Simplified qcom-vadc-common volt/temp mapping code
>>   - Implement suggestions by Matthias Kaehlcke: message formatting,
>>     rewrite comments, remove unused variable initialization.
>>
>> Changes since v7:
>>   - Move qcom-vadc-common.h header to include/linux/iio/adc/ dir.
>>   - Use explicit sizeof(var) instead of hand-coding 1 when accessing
>>     adc-tm registers.
>>   - Remove buffer read from adc_tm5_init().
>>   - Remove extra on-stack var from adc_tm5_get_temp().
>>   - Minor formatting changes as suggested Daniel.
>>
>> Changes since v6:
>>   - Added include <linux/bitfield.h> as noted by Jishnu Prakash.
>>
>> Changes since v5:
>>   - Reworked DT bindings:
>>     * Removed qcom,adc-channel, instead it is parsed from io-channels
>>     * Renamed qcom,hw-settle-time to include -us suffix
>>   - Re-added monitor enabling which got lost during refactored. Noted by
>>     Jishnu Prakash.
>>   - Use threaded IRQ handler as susggested by Jishnu.
>>
>> Changes since v4:
>>   - Added kernel-doc comments to ADC-TM structures
>>   - Used several sizeof(buf) instead of hand-conding register size
>>
>> Changes since v3:
>>   - Fix DT description to spell "thermal monitoring" instead of just TM
>>   - Fix warnings in DT example
>>   - Add EXPORT_SYMBOL_GPL(of_iio_channel_get_by_name)
>>   - Fixed whitespace chanes in qcom-vadc-common.c
>>   - Removed error message if IIO chanel get returns -EPROBE_DEFER
>>
>> Changes since v2:
>>   - IIO: export of_iio_channel_get_by_name() function
>>   - dt-bindings: move individual io-channels to each thermal monitoring
>>     channel rather than listing them all in device node
>>   - added fallback defaults to of_device_get_match_data calls in
>>     qcom-spmi-adc5 and qcom-spmi-adc-tm5 drivers
>>   - minor typo fixes
>>
>> Changes since v1:
>>   - Introduce fixp_linear_interpolate() by Craig Tatlor
>>   - Lots of syntax/whitespace changes
>>   - Cleaned up register definitions per Jonathan's suggestion
>>   - Implemented most of the suggestions from Bjorn's and Jonathan's
>>     review
>>
>>
> 


-- 
With best wishes
Dmitry
