Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3785B6004
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 20:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiILSOP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiILSOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 14:14:14 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5870A419B9
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 11:14:12 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a8so16143856lff.13
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2022 11:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pphKVd2FpUZgthqe9J2k6pHmxdMAUCIqGEtgJJp9FHk=;
        b=MnO4fO2yLp8hCzWCwoN7+8I58BSrXzRDQtX2oBr5plpQqW3iCcpJER5OzI32hb/Po3
         Pfk1xc4f1fyM5i2YiwsZfbZfChnvmtg0FOjhvAyhxL7j6jU7QNnVZSFCqYdHuWxD6W5I
         ByeZ71lZN7P7d3aW4/kMuNhdiQ1eCjzqI0FA40iQUECBVxpXomjqZdBgPfSsTjoT7Zsn
         jLtXai7D1pGYD25MRXnuTREMMtBJDpyx+xZt2lh07d6PmygFOXTYvdwzurS0zyumFT0i
         A0sagUXCDQxjQa7lxDT+SVm6l4mvf53SecGCdYl4jiyl45EWo+qulv1l8zhsa05LTADu
         HbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pphKVd2FpUZgthqe9J2k6pHmxdMAUCIqGEtgJJp9FHk=;
        b=Rw/8j3S8O5Q7PEwZz617+iPAOcdMS9MrYwNpTAMVqjEd/4X0YDubGrIU2sjnugLahD
         tGQjiaubH+2STh3YsbjTs8ARTthkU/aMiIhhZX0OveUdcQX1Pmwod299rsneSof6907M
         xrGdXLgLzp5w8jqBJIoDqojlsQarSt2ImPEnbOgnjRIujN/6PciABNGAea2Sx+80ohRN
         tJxjF5QbVYI0GH/aUoGpz6dEcK56QScPXdqzRzy7dKS15vFFetxOfpI1M0TlCWjaTMrZ
         1CUT5Ma+EOuJXeiO/HWSbFJKbNUeWUUR9wxNh4BLk5prVjHozhnOJeFCWM/EMiTbDkVg
         AvIQ==
X-Gm-Message-State: ACgBeo3lUBG6vObSfDOmT9TqOcBee19Zdp1YSzCkTKwroWbVu2Mibd2p
        gTfvyxquMIAuD2B2R8A72hKwTg==
X-Google-Smtp-Source: AA6agR5CudFSUa17zwUnzqBC9l/1i9sEoxDOfEdCr8sclosfn/oqi/m5pbihf9dVim/I0WqX2R/6Gw==
X-Received: by 2002:a05:6512:3c88:b0:499:c78:5bb1 with SMTP id h8-20020a0565123c8800b004990c785bb1mr4872822lfv.503.1663006450720;
        Mon, 12 Sep 2022 11:14:10 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id y26-20020a05651c221a00b0026ad1da0dc3sm1205812ljq.122.2022.09.12.11.14.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 11:14:10 -0700 (PDT)
Message-ID: <2f658a69-a49c-67be-26b9-421095cde2b7@linaro.org>
Date:   Mon, 12 Sep 2022 21:14:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in Makefile
 and qcom/Kconfig
Content-Language: en-GB
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
References: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
 <CAA8EJpoM5nW=pVJB4zy4Jh9Q3gE4KOju2QVy_WtmUokKMyXtuw@mail.gmail.com>
 <75a5789e-9100-b398-1df2-50d49823831c@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <75a5789e-9100-b398-1df2-50d49823831c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/09/2022 20:11, Bhupesh Sharma wrote:
> 
> 
> On 9/12/22 1:08 AM, Dmitry Baryshkov wrote:
>> On Sun, 11 Sept 2022 at 21:42, Bhupesh Sharma 
>> <bhupesh.sharma@linaro.org> wrote:
>>>
>>> Introduce CONFIG_QCOM_THERMAL to allow better control
>>> over selection of various Qualcomm Thermal drivers
>>> available inside qcom/ directory.
>>>
>>> This is a preparatory change to allow new drivers to
>>> be added inside qcom/ directory in a more structured
>>> fashion.
>>>
>>> Cc: Bjorn Andersson <andersson@kernel.org>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: Amit Kucheria <amitk@kernel.org>
>>> Cc: Thara Gopinath <thara.gopinath@gmail.com>
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>>> ---
>>>   drivers/thermal/Makefile     |  2 +-
>>>   drivers/thermal/qcom/Kconfig | 12 ++++++++++++
>>>   2 files changed, 13 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>>> index def8e1a0399c..a12b647be0d1 100644
>>> --- a/drivers/thermal/Makefile
>>> +++ b/drivers/thermal/Makefile
>>> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)  += da9062-thermal.o
>>>   obj-y                          += intel/
>>>   obj-$(CONFIG_TI_SOC_THERMAL)   += ti-soc-thermal/
>>>   obj-y                          += st/
>>> -obj-$(CONFIG_QCOM_TSENS)       += qcom/
>>> +obj-$(CONFIG_QCOM_THERMAL)     += qcom/
>>
>> Following other platforms around qcom, I think just `obj-y += qcom/`
>> would work well enough.
> 
> I have no strong opinion on using `obj-y += qcom/` here, but I would
> still like us to define a CONFIG_QCOM_THERMAL like flag in the 
> qcom/Kconfig, similar to the ST platforms which use similar selection 
> mechanism via 'CONFIG_ST_THERMAL'.

`QCOM_THERMAL' is fine for me.

> 
> Thanks.
> 
>>>   obj-y                          += tegra/
>>>   obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>>>   obj-$(CONFIG_MTK_THERMAL)      += mtk_thermal.o
>>

-- 
With best wishes
Dmitry

