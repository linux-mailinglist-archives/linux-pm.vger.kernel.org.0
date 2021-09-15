Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8CA40CC65
	for <lists+linux-pm@lfdr.de>; Wed, 15 Sep 2021 20:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhIOSNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Sep 2021 14:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhIOSNj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Sep 2021 14:13:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D733DC061574;
        Wed, 15 Sep 2021 11:12:20 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso2820546pjq.4;
        Wed, 15 Sep 2021 11:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SvTGV/EwYbpT949M265y3feZdG0GQPEcYHnVzA9XpeU=;
        b=WZzmWUaRYFUp7XyiDzJ0JwTqRG3Pw2RdpRu/7oki7r4BiZdSVOvryhNE2fLyB5H3CB
         Tj8pCwnP+Nu2cMaN1Oalx4Ru6DgZkW49vvVrsfBmrSK7mYSxmVtil0/x1esua93D662e
         SR+41Mujdsvnn7drijMFKZ8ioHbcjRg/c7rnQSDRfODa4KzhfcD8mD/zBdlKBNfejmWY
         MhX6pBckBV3NKZovGXDLpBIXDu1O0vpnKfT0ZP7Vc6fzFVlqcrOMuGRUqO0lemd7SMr+
         BC9seL8u3hszQjfkgRGNCg5o3FI6+/6tRc9ldq8vrg/5Kpp1kd2dP7V0FLCaL+ru4LwL
         /LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SvTGV/EwYbpT949M265y3feZdG0GQPEcYHnVzA9XpeU=;
        b=7Jo5+VVz3Yvnx+mHue8QBJk5W4M3NWrN4WKjiYzf6th0PRPL69IBD4qBC/Uuv0wc3J
         FJCGJqIFi9Nf8obr2G6PNHQmr2GbeKCs05YFK5KAdDvH0ipS9A+ZdPPY/Cxfuf2iTjF7
         DtEiiT6vU5t/ZcV2E1LIt/OgItVfl8HaqT3Z+hUkME2XKGInw3WFn6Z1oF4i+GI9spJ+
         bzlMCd30G8fobMH9n+JqaaBESpSxGETYuM2/UFKpUl6F1siGvN//vAFXdYhEfE27Lr8v
         aHA47YyVked1mjO6K9Q6VYkziYTXwVzQwwJN6aYbe/UvORds+3nsbij9372l5cjYFaKJ
         Qmug==
X-Gm-Message-State: AOAM5312cM5A9dlIz4mBmiJAn3FI1hkevOz0QiU+uRG06BmFVV2vbV79
        KJ7Rv10Wtv5KZU/nTP7w2JU=
X-Google-Smtp-Source: ABdhPJxXRAyNmmsZYN4Df/qr27CfQsUOPlxdXZTsnl2dcUmPMfR0iCuwyWfQ76OBzcbaCkTZ2Qi1eg==
X-Received: by 2002:a17:90a:7d03:: with SMTP id g3mr1170487pjl.242.1631729540219;
        Wed, 15 Sep 2021 11:12:20 -0700 (PDT)
Received: from [172.30.1.2] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v13sm580440pfm.16.2021.09.15.11.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 11:12:19 -0700 (PDT)
Subject: Re: [RFC 05/19] devfreq: imx8m-ddrc: Use the opps acquired from EL3
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Rob Herring <robh@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Georgi Djakov <djakov@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-serial@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1631554694-9599-1-git-send-email-abel.vesa@nxp.com>
 <1631554694-9599-6-git-send-email-abel.vesa@nxp.com>
 <b52430cc-1216-8b3e-baec-7d3fffc1274a@gmail.com>
Message-ID: <a8ccf50b-cb05-675e-aef1-50f33783b0c0@gmail.com>
Date:   Thu, 16 Sep 2021 03:12:12 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <b52430cc-1216-8b3e-baec-7d3fffc1274a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21. 9. 15. 오후 12:29, Chanwoo Choi wrote:
> Hi,
> 
> OPP is mandatory for devfreq driver. Also, must need to add
> the OPP levels to  devicetree file, it is better to show
> the supported OPP list for the developer who don't know
> the detailed background of driver. If there are no any
> critical issue. I prefer the existing approach for the readability.

Also, by keeping the existing approach, the user is able to
select the their own OPP entries among the all supported frequencies
from EL3. Even if the some clock support the multiple frequencies,
the user might want to use the a few frequency instead of using
all supported frequencies.

> 
> On 21. 9. 14. 오전 2:38, Abel Vesa wrote:
>> i.MX8M platforms get their dram OPPs from the EL3.
>> We don't need to duplicate that in the kernel dram dts node.
>> We should just trust the OPPs provided by the EL3.
>>
>> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
>> ---
>>   drivers/devfreq/imx8m-ddrc.c | 50 +++---------------------------------
>>   1 file changed, 3 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.c
>> index 583123bf2100..f18a5c3c1c03 100644
>> --- a/drivers/devfreq/imx8m-ddrc.c
>> +++ b/drivers/devfreq/imx8m-ddrc.c
>> @@ -321,38 +321,9 @@ static int imx8m_ddrc_init_freq_info(struct 
>> device *dev)
>>           if (freq->dram_core_parent_index == 2 &&
>>                   freq->dram_alt_parent_index == 0)
>>               return -ENODEV;
>> -    }
>> -
>> -    return 0;
>> -}
>> -
>> -static int imx8m_ddrc_check_opps(struct device *dev)
>> -{
>> -    struct imx8m_ddrc *priv = dev_get_drvdata(dev);
>> -    struct imx8m_ddrc_freq *freq_info;
>> -    struct dev_pm_opp *opp;
>> -    unsigned long freq;
>> -    int i, opp_count;
>> -
>> -    /* Enumerate DT OPPs and disable those not supported by firmware */
>> -    opp_count = dev_pm_opp_get_opp_count(dev);
>> -    if (opp_count < 0)
>> -        return opp_count;
>> -    for (i = 0, freq = 0; i < opp_count; ++i, ++freq) {
>> -        opp = dev_pm_opp_find_freq_ceil(dev, &freq);
>> -        if (IS_ERR(opp)) {
>> -            dev_err(dev, "Failed enumerating OPPs: %ld\n",
>> -                PTR_ERR(opp));
>> -            return PTR_ERR(opp);
>> -        }
>> -        dev_pm_opp_put(opp);
>> -        freq_info = imx8m_ddrc_find_freq(priv, freq);
>> -        if (!freq_info) {
>> -            dev_info(dev, "Disable unsupported OPP %luHz %luMT/s\n",
>> -                    freq, DIV_ROUND_CLOSEST(freq, 250000));
>> -            dev_pm_opp_disable(dev, freq);
>> -        }
>> +        if (dev_pm_opp_add(dev, freq->rate * 250000, 0))
>> +            return -ENODEV;
>>       }
>>       return 0;
>> @@ -360,7 +331,6 @@ static int imx8m_ddrc_check_opps(struct device *dev)
>>   static void imx8m_ddrc_exit(struct device *dev)
>>   {
>> -    dev_pm_opp_of_remove_table(dev);
>>   }
>>   static int imx8m_ddrc_probe(struct platform_device *pdev)
>> @@ -407,16 +377,7 @@ static int imx8m_ddrc_probe(struct 
>> platform_device *pdev)
>>           return ret;
>>       }
>> -    ret = dev_pm_opp_of_add_table(dev);
>> -    if (ret < 0) {
>> -        dev_err(dev, "failed to get OPP table\n");
>> -        return ret;
>> -    }
>> -
>> -    ret = imx8m_ddrc_check_opps(dev);
>> -    if (ret < 0)
>> -        goto err;
>> -
>> +    priv->profile.polling_ms = 1000;
> 
> This change is not related to role of this patch.
> Need to make the separate patch.
> 
>>       priv->profile.target = imx8m_ddrc_target;
>>       priv->profile.exit = imx8m_ddrc_exit;
>>       priv->profile.get_cur_freq = imx8m_ddrc_get_cur_freq;
>> @@ -427,13 +388,8 @@ static int imx8m_ddrc_probe(struct 
>> platform_device *pdev)
>>       if (IS_ERR(priv->devfreq)) {
>>           ret = PTR_ERR(priv->devfreq);
>>           dev_err(dev, "failed to add devfreq device: %d\n", ret);
>> -        goto err;
>>       }
>> -    return 0;
>> -
>> -err:
>> -    dev_pm_opp_of_remove_table(dev);
>>       return ret;
>>   }
>>
> 
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
