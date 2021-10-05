Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEA642336A
	for <lists+linux-pm@lfdr.de>; Wed,  6 Oct 2021 00:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhJEWW6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 5 Oct 2021 18:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbhJEWW5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Oct 2021 18:22:57 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECA5C06174E
        for <linux-pm@vger.kernel.org>; Tue,  5 Oct 2021 15:21:06 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id x8so684535qvp.1
        for <linux-pm@vger.kernel.org>; Tue, 05 Oct 2021 15:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xHu5SUa0KvSYg3r+SFZDDB6DZ4/1EXbWcPW3NE3eBV8=;
        b=mGLTs7eKVP2Mm3xWUXlknMwhSa++0+cb4Px74ojuoliqTl/wkZCOKltUHsuZn6aCLV
         1KSnuHn3IaxmCsEa4oDDE2pQkp/gOPVngmhjr7Daoc0vOP5qLR1b1owvq+OO2i3xbxBp
         g8YadytIdhE+bYkHtWf7paQIVUCwPLr+tJkdOVQnsU4otUosdnWEqS9aPTSe2Q1w/pU3
         7wglGjGVFDU+o+TEZPRY9iHNXG1olifTlNPmHqVmttNlHt67pqaD3P1ug53dXGn1NTuP
         b5WLfVSa8GXDzHBTYqvWHKuX/LEKLYYtAPG3yv11JwC9fMz//jAcpKIsKJ6w8zcPaOU3
         VnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xHu5SUa0KvSYg3r+SFZDDB6DZ4/1EXbWcPW3NE3eBV8=;
        b=B9FTJ3GWKSO6AuMhmfanG2Cw2x81cgWnCzH05WlhfYl1HNXkNZYV0fq7iXjvkr4zfB
         WbsAbKKjPVtmvbgkQP3zEsa5RJmZiQUHvlZEP8emaWngeCOJqLgD4p7Hs0/XSgZDYqbO
         XfZ8B1zFnF1q586hGKUCqgZ8ThrV8sCQaxI4yaliJB0cdthaGryAa8gFwyRZKoGODkIO
         3tpawAoYoGbZ3BsPB708ArF1OABfzY/v1TTTU2wkyD7pXEcNKdLr7t9wMi621XiPhBp6
         P0QJ+hcxBCTecAcNNoAK0nTPNIoKW4c9FMKL+Ceksbb9dlu02AnsJRbsJ5NG0BGGEucz
         vnog==
X-Gm-Message-State: AOAM531MC/gxU+1IQOfUD5vXa2gGu7Cl+xJTw/QJDTJmDN3VCW/7CWbj
        OtgU3GrpJBL5nonvYAx+BAlpGg==
X-Google-Smtp-Source: ABdhPJzjAupsXhXHKMOteyIzCV8vgaSi6fiq3olLstOYpJpR1Adq/ORdBRgP1XeVPmd6GrIqkPv8hw==
X-Received: by 2002:ad4:4664:: with SMTP id z4mr30100135qvv.16.1633472465623;
        Tue, 05 Oct 2021 15:21:05 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id b17sm11257816qte.97.2021.10.05.15.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:21:05 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sdm845: mtp: Add vadc channels
 and thermal zones
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
 <20210923212311.2877048-5-bjorn.andersson@linaro.org>
 <YVSzJZ8G43CLml3L@google.com> <YVtg3lcR1HMqVdAJ@ripper>
 <CAA8EJprYij6pWD1A17yr1+5-n5fKPW=YDA_-2+f8h6JnEh4myw@mail.gmail.com>
 <f136fbb0-be3e-aee8-7a68-1d16148c80ff@linaro.org> <YVzJDU5ROmrI2rQb@ripper>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <cb0d97b1-81c7-2d5b-45d3-00dd09815ddd@linaro.org>
Date:   Tue, 5 Oct 2021 18:21:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YVzJDU5ROmrI2rQb@ripper>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 10/5/21 5:52 PM, Bjorn Andersson wrote:
> On Tue 05 Oct 13:30 PDT 2021, Thara Gopinath wrote:
> 
>>
>>
>> On 10/4/21 4:56 PM, Dmitry Baryshkov wrote:
>>> On Mon, 4 Oct 2021 at 23:13, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>>>>
>>>> On Wed 29 Sep 11:40 PDT 2021, Matthias Kaehlcke wrote:
>>>>
>>>>> On Thu, Sep 23, 2021 at 02:23:11PM -0700, Bjorn Andersson wrote:
>>>>>> Downstream defines four ADC channels related to thermal sensors external
>>>>>> to the PM8998 and two channels for internal voltage measurements.
>>>>>>
>>>>>> Add these to the upstream SDM845 MTP, describe the thermal monitor
>>>>>> channels and add thermal_zones for these.
>>>>>>
>>>>>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>>>>>> ---
>>>>>>
>>>>>> In addition to the iio channels exposed by v1, Daniel wanted thermal_zones...
>>>>>>
>>>>>> Changes since v1:
>>>>>> - Enable the pm8998_adc_tm and describe the ADC channels
>>>>>> - Add thermal-zones for the new channels
>>>>>>
>>>>>>    arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 128 ++++++++++++++++++++++++
>>>>>>    1 file changed, 128 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>>>> [..]
>>>>>> +&pm8998_adc {
>>>>>> +   adc-chan@4c {
>>>>>> +           reg = <ADC5_XO_THERM_100K_PU>;
>>>>>> +           label = "xo_therm";
>>>>>> +   };
>>>>>> +
>>>>>> +   adc-chan@4d {
>>>>>> +           reg = <ADC5_AMUX_THM1_100K_PU>;
>>>>>> +           label = "msm_therm";
>>>>>> +   };
>>>>>> +
>>>>>> +   adc-chan@4f {
>>>>>> +           reg = <ADC5_AMUX_THM3_100K_PU>;
>>>>>> +           label = "pa_therm1";
>>>>>> +   };
>>>>>> +
>>>>>> +   adc-chan@51 {
>>>>>> +           reg = <ADC5_AMUX_THM5_100K_PU>;
>>>>>> +           label = "quiet_therm";
>>>>>> +   };
>>>>>> +
>>>>>> +   adc-chan@83 {
>>>>>> +           reg = <ADC5_VPH_PWR>;
>>>>>> +           label = "vph_pwr";
>>>>>> +   };
>>>>>> +
>>>>>> +   adc-chan@85 {
>>>>>> +           reg = <ADC5_VCOIN>;
>>>>>> +           label = "vcoin";
>>>>>> +   };
>>>>>> +};
>>>>>> +
>>>>>> +&pm8998_adc_tm {
>>>>>> +   status = "okay";
>>>>>> +
>>>>>> +   xo-thermistor@1 {
>>>>>> +           reg = <1>;
>>>>>> +           io-channels = <&pm8998_adc ADC5_XO_THERM_100K_PU>;
>>>>>> +           qcom,ratiometric;
>>>>>> +           qcom,hw-settle-time-us = <200>;
>>>>>> +   };
>>>>>> +
>>>>>> +   msm-thermistor@2 {
>>>>>> +           reg = <2>;
>>>>>> +           io-channels = <&pm8998_adc ADC5_AMUX_THM1_100K_PU>;
>>>>>> +           qcom,ratiometric;
>>>>>> +           qcom,hw-settle-time-us = <200>;
>>>>>> +   };
>>>>>> +
>>>>>> +   pa-thermistor@3 {
>>>>>> +           reg = <3>;
>>>>>> +           io-channels = <&pm8998_adc ADC5_AMUX_THM3_100K_PU>;
>>>>>> +           qcom,ratiometric;
>>>>>> +           qcom,hw-settle-time-us = <200>;
>>>>>> +   };
>>>>>> +
>>>>>> +   quiet-thermistor@4 {
>>>>>> +           reg = <4>;
>>>>>> +           io-channels = <&pm8998_adc ADC5_AMUX_THM5_100K_PU>;
>>>>>> +           qcom,ratiometric;
>>>>>> +           qcom,hw-settle-time-us = <200>;
>>>>>> +   };
>>>>>> +};
>>>>>> +
>>>>>
>>>>> The example in the 'qcom,spmi-adc-tm5' binding specifies 'qcom,ratiometric'
>>>>> and 'qcom,hw-settle-time-us' for both the ADC and the thermal monitor, so do
>>>>> several board files (e.g. sm8250-mtp.dts and qrb5165-rb5.dts). This apparent
>>>>> redundancy bothered me earlier, it's not really clear to me whether it's
>>>>> needed/recommended or not. Do you happen to have any insights on this?
>>>>
>>>> Hmm, you're right and I missed this in defining my channels. I've not
>>>> looked at this detail, just got reasonable readings from my thermal
>>>> zones and was happy about that.
>>>>
>>>> Dmitry, do you have any further insights why these properties are
>>>> supposed to be duplicated between the adc channel and the thermal zones?
>>>
>>> Because both ADC channel and thermal zone registers should be
>>> programmed accordingly.
>>>
>>> One not-so-perfect approach would be to use io-channels property to
>>> locate the adc's adc-chan node and to parse it. However this way
>>> thermal driver would have to know the exact structure of adc's device
>>> tree nodes.
>>> Another (even worse) solution would be to introduce qcom-specific API
>>> to query these properties from the IIO channel.
>>>
>>> Selecting between these two options I decided to follow the downstream
>>> path and just to duplicate these few properties.
>>
>> I know I am joining late to this party, since v3 is out. But before I send
>> my acked-by, wanted to check/state a few things.
>> To me, the not-so-perfect approach that you mention here is actually not so
>> bad, considering the thermal sensor driver already is aware of internals of
>> the adc device. The duplicating of node is kind of confusing.
>> Also did you explore using one of _channel_write apis in iio framework to
>> move all the writes into the adc device instead of thermal sensor driver ?
>>
> 
> To me the TM hardware block seems to just duplicate some parts of the
> ADC block. Without understanding why the two would need to be configured
> in sync, I don't think we should tie them together further.

You are right. It is duplicating most of the ADC parts except for 
temperature read for which it calls into the adc device. And I don't see 
any interface from the ADC driver that can be used to do the 
configuration TM needs. Hence the question, have we ever explored this 
path ?


> 
> In particular, I get the same readings with or without configuring the
> ADC channels, does this perhaps imply that the TM configuration is used
> to configure the ADC during it's reads (i.e. we don't need to define the
> ADC channels after all), or is this just a coincidence?

Maybe because of what we do in adc_tm5_init ?

If needed, we should be able to duplicate the read in the TM as well and 
get rid of ADC channels , right ? I don't like this half configuration 
in TM and half in ADC device unless there is a reason behind this.

> 
> There are other things in the PMIC, using the ADC seemingly without you
> having to explicitly configure the ADC and there's definitely things
> pointing to the ADC being "timeshared" between various users.
> 
> Regards,
> Bjorn
> 

-- 
Warm Regards
Thara (She/Her/Hers)
