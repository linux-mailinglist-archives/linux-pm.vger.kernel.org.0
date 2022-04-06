Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF064F6359
	for <lists+linux-pm@lfdr.de>; Wed,  6 Apr 2022 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbiDFP2W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 Apr 2022 11:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiDFP2K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 11:28:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC43B65123D
        for <linux-pm@vger.kernel.org>; Wed,  6 Apr 2022 05:27:55 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b19so2935153wrh.11
        for <linux-pm@vger.kernel.org>; Wed, 06 Apr 2022 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h8e9c9TFI1Ly317ektcSlehbJcZeEtFyP3Jc0716Rsg=;
        b=LV6wALCpMHHr46kiK8gkmcvr2YLzPCAKmsaVuq5XqGfKVJXSyOhh/YEsG7xInDy6+z
         W0+3pgyAvv4l2G//HgfffD3nJfgfvItnx0vctg/6reEx7Uh96dD0jMTreTFVcH7sHzzv
         6wgIq0sXTa0Zf6jHsItnXFWRXJ4jXcF7JJPpT7mMXpMLd6RRZRTIxNclr7FyPRDBnp6N
         FDjl8WsySRKECNtwO4KGzFt/KEKhjPQd6hU50fNEpsKsQwIAwc6grgw6hWZJUmDNsv+W
         cY1+mwvaemjyxZmm0MnZniahMOzye+1unzb7c9xCmnkv98aufrT/NNxLLM2xzQ869YfX
         VnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h8e9c9TFI1Ly317ektcSlehbJcZeEtFyP3Jc0716Rsg=;
        b=agPXmsAkEk3yzXlZI+Yeb261JnijBzuuf6SuEjiS8HAjNFyzGqU4wZ+gfmRMAaF2RI
         Q8hKE9kVflcqU7GfLdKIvFk83z6uzEJum17OEIfblmQekZX3fx0BAzdZQkgQeV1XuTj7
         qYIZA+89DasqyJO/onC+3T2gaLUnVSCjFcx2DwvDnJpD6ptGAcCZhEdIa/3U1Oa4G0k8
         4RfZNeGKcXOdOeMe4KE+H9OJedZJp4CzsMfjvEPapLOM0e0i95pfy9vtKeBRL78eJ8O9
         sk+dOL8/QQadVbFtQ1Sv6OlK6zTMoLr2KE7SOZ+jFhpCY0Wd6YnMxF6lJnsC6JrdDWLw
         ZO1g==
X-Gm-Message-State: AOAM5334RKex2jk6zSx7XVkznVIWTCqiTwBpFvMAQKWI4vcozoaKbwJI
        LTCLsrpRUvXfb4wDJBztFvqXRQ==
X-Google-Smtp-Source: ABdhPJy/OzQ9KZJRJ6ogkuMUdiWA0ngNr+hQxdEQ1m/9ZsRyly6QpHYTlpGwFvGEqTI2jU8aIJ7ngQ==
X-Received: by 2002:adf:f10e:0:b0:206:1837:b5a9 with SMTP id r14-20020adff10e000000b002061837b5a9mr6334860wro.347.1649248071925;
        Wed, 06 Apr 2022 05:27:51 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ed2f:f020:261f:c14c:d23b:d177? ([2a01:e34:ed2f:f020:261f:c14c:d23b:d177])
        by smtp.googlemail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm4809146wmh.33.2022.04.06.05.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 05:27:51 -0700 (PDT)
Message-ID: <a422b297-45ea-1e9c-65a9-817b8dae796e@linaro.org>
Date:   Wed, 6 Apr 2022 14:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RESEND PATCH V5 0/4] thermal: qcom: Add support for PMIC5 Gen2
 ADC_TM
Content-Language: en-US
To:     Jishnu Prakash <quic_jprakash@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        mka@chromium.org, dmitry.baryshkov@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, quic_aghayal@quicinc.com,
        rui.zhang@intel.com, quic_subbaram@quicinc.com, jic23@kernel.org,
        amitk@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm-owner@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <1648991869-20899-1-git-send-email-quic_jprakash@quicinc.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1648991869-20899-1-git-send-email-quic_jprakash@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/04/2022 15:17, Jishnu Prakash wrote:
> Resending patch series to thermal tree.
> 
> Changes in v5:
> Fixed some compilation errors in patch 4.
> 
> Changes in v4:
> Addressed comments given by Jonathan (for using put_unaligned_le16)
> and by Dmitry (for using separate init function and correcting args_count)
> for qcom-spmi-adc-tm5.c in patch 4.
> Added init function in patch 3.
> 
> Changes in v3:
> Addressed comments given by Jonathan for qcom-spmi-adc-tm5.yaml.
> Addressed comments given by Dmitry and Jonathan for qcom-spmi-adc-tm5.c.
> Split patch for qcom-spmi-adc-tm5.c into two parts, one to refactor
> code to support multiple device generations and the second to add
> actual Gen2 ADC_TM changes.
> 
> Changes in v2:
> Split IIO file changes into separate patch.
> Addressed comments given by Dmitry for qcom-spmi-adc-tm5.c.
> 
> Changes in v1:
> PMIC5 Gen2 ADC_TM is supported on PMIC7 chips and is a close
> counterpart of PMIC7 ADC. It has the same functionality as
> PMIC5 ADC_TM, to support generating interrupts on ADC value
> crossing upper or lower thresholds for monitored channels.
> 
> Jishnu Prakash (4):
>    dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
>    iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
>    thermal: qcom: Add support for multiple generations of devices
>    thermal: qcom: add support for PMIC5 Gen2 ADCTM
> 
>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 ++++-
>   drivers/iio/adc/qcom-vadc-common.c                 |  11 +
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 486 +++++++++++++++++++--
>   include/linux/iio/adc/qcom-vadc-common.h           |   2 +
>   4 files changed, 569 insertions(+), 40 deletions(-)

Applied, thanks



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
