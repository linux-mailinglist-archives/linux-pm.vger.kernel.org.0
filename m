Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24EF5E8F70
	for <lists+linux-pm@lfdr.de>; Sat, 24 Sep 2022 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiIXS7C (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 24 Sep 2022 14:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiIXS7B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 24 Sep 2022 14:59:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B99E4D154
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 11:58:59 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z20so3438157ljq.3
        for <linux-pm@vger.kernel.org>; Sat, 24 Sep 2022 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YIW3vTRVXsuTcD11RiZoOeP6j7SOFSgAsNn7hMGMgbY=;
        b=sSSFPkuXvSYtGG6t6dyEfy9byoHF+HB+rsJ+ZnT5aiRhvxC0DgaO5uOyM4pNnQOuDW
         Ci52znBsyWrWFNMhRKisYK7h4URCV+IlzJUjWWSDxH2yvSrPILJqcIN7s76XUIaeXyGf
         srw0yBGp/5w1HfuPVM72eRvMj8vDWeaFllHv3w4mOLsb5zKVkJejqFn26QLg+uA7DMM5
         L7SRRCM+nU6QE3kyLu4tXKab4hfhyYqTakDihUFO8QSIJnEBII6+wTm4sa664L7467Cm
         ynIsGAkxa1KTS+9KnyYhU0mNxTYgB+pEx9ccnitPujpXv9BvTY5tACj5X74flsXLx9/g
         +gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YIW3vTRVXsuTcD11RiZoOeP6j7SOFSgAsNn7hMGMgbY=;
        b=TTEtu3nv1Y3CXGlVgI8P8ePJl5DsvZn40WWxxYZ/NSdHS7SrqkK+U2RmKbMYIk/73e
         ei3A1eZoYf8Qn3HgZOEs5/YXTH2GWLZGJp+hx1o3BAmdIlQtgdLaK11SV6nJjAR+lKvO
         6Uz2TJvSzxjZ1kZOjQOZkTXi/OREDNxGgFPXKg2puEgxEO8PwMskzf01tDcers1pCUjt
         7vyiizRgqNTvEtvNFSpIW/8W1c8I1LnAgNQmHw94KHKVPMmI2KM2/b/g7aTLX+TR72m+
         zfbq2pWtaNpopHDZOVyRGNL2SqIZBg9TTrB00F2Rm3plH5ZYKczCUTnLZB+i6NsJ13dV
         mKSA==
X-Gm-Message-State: ACrzQf0xb298AqcMONHIiebbLASvb6qhU1sO/ezhKYmHtjn84OCTahuE
        9nuAi5V/+K/IMXrLZbISBJQ5Zw==
X-Google-Smtp-Source: AMsMyM5RXdMxotovE2D7bZQJ6DTIQzxiMq2tSkXPLbItuXnX8MnAxMcaV5bzumt9nVjHNKuTXqaiug==
X-Received: by 2002:a05:651c:499:b0:26c:677a:a531 with SMTP id s25-20020a05651c049900b0026c677aa531mr5209188ljc.319.1664045937527;
        Sat, 24 Sep 2022 11:58:57 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id j21-20020a05651231d500b004946e72711bsm1965982lfe.76.2022.09.24.11.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 11:58:57 -0700 (PDT)
Message-ID: <93a790fb-20dc-0f31-2eed-09f5b538bea9@linaro.org>
Date:   Sat, 24 Sep 2022 21:58:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH 00/10] thermal/drivers/tsens: specify nvmem cells in
 DT rather than parsing them manually
Content-Language: en-GB
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org>
 <YyyaH1ZXF9IvLpwd@gerhold.net>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YyyaH1ZXF9IvLpwd@gerhold.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On 22/09/2022 20:23, Stephan Gerhold wrote:
> Hi Dmitry,
> 
> On Sat, Sep 10, 2022 at 03:46:51PM +0300, Dmitry Baryshkov wrote:
>> Historically the tsens driver fetches the calibration data as a blob and
>> then parses the blob on its own. This results in semi-duplicated code
>> spreading over the platform-specific functions.
>>
>> This patch series changes tsens calibration code to use pre-parsed nvmem
>> cells rather than parsing the blob in the driver. For backwards
>> compatibility the old code is left in place for msm8916 and qcs404, two
>> platforms which have in-tree DT files. For msm8974 the original function
>> is left intact, since it differs significantly (and I can not test the
>> code on msm8974). For all other affected platforms the old parsing code
>> has been dropped as a part of this RFC.
>>
>> The code was tested on msm8916 and qcs404 only, thus it is being sent as
>> an RFC.
>>
> 
> Thanks a lot for working on this!
> 
> After thinking about this for a while I wonder if we can go even a step
> further: Can we drop SoC-specific code entirely for 8939 and 9607 and
> match the generic compatible (qcom,tsens-v0_1)? This would allow most
> v0.1 plaforms to use generic code like for qcom,tsens-v2.

While this idea looks appealing, I think it's a bit against our custom 
to put hardware details into the driver rather than putting them into 
the DT. So, I think, the 8939 will have to stay as is, while for the 
9607 and maybe several other devices it should be possible to create a 
fallback entry.

> 
> AFAICT with your changes only the following remains SoC-specific:
> 
>    - hw_ids (actually only needed for 8939 since 9607 has standard IDs)

As I wrote, I wouldn't put this into DT.

> 
> While two other things are already handled:
> 
>    - num_sensors (the driver supports "#qcom,sensors" in DT already)
>    - tsens_calibrate_nvmem() shift (AFAICT in downstream msm-tsens.c
>      everything except 8916 uses shift = 2. 8916 needs special handling
>      anyway for the backwards compatibility)
> 
> Having the generic compatible would allow me to add MSM8909 without any
> code changes at all (just DT schema addition).
> 
> For 8939 we could read the hw_ids from the DT with something like:
> 
> 	qcom,sensors = <0 1 2 3 5 6 7 8 9 10>;
> 
> And actually there are two revisions of 8939, the older one has one
> sensor less (msm-3.10: msm8939-common.dtsi vs msm8939-v3.0.dtsi).
> This could also be easily handled from the DT without any code changes:
> 
> 	qcom,sensors = <0 1 2 3 5 6 7 8 9>;

Usually we only care about the latest revision of the chip, earlier 
revisions typically correspond to engineering samples, never hitting the 
actual consumer devices.

> 
> The diff could be something like the following (I did not test it yet).
> 
> What do you think?
I'd like to sort the calibration data for 8976 first. At this moment I'm 
waiting for the 8976 data to be tested. Also it would be nice to be able 
to cleanup the 8976 calibration code.

-- 
With best wishes
Dmitry

