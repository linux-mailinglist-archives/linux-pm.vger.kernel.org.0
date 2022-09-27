Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99645EBEB4
	for <lists+linux-pm@lfdr.de>; Tue, 27 Sep 2022 11:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiI0Jf1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Sep 2022 05:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiI0JfZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Sep 2022 05:35:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42396FF9
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 02:35:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v28so1232098wrd.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Sep 2022 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=nZKlStsukXTiXMspHE/cDk5Om1miIJs0rtHlxN58scw=;
        b=WgRuPgXbYPwOZJBGBtvGwIF6k9jaqXIuXShKS6mViB/1sb+TXAcASNRdmnfYTxow23
         e7zuPgopsZ0uDgLx9oIXmLukND7haDWAAEM3msOJ3+Bul4On0e3/hVpVhlIPKv/5tgvC
         iNgAG5DwHrl/0ZAFXghccez3HPu0zD7LCvoph755d69qQPVIRfo8xFdcDcW6udUA6Avf
         753Irtor7A5wxmWPdQNEbjASM7ZPl6ojeb7IK4Ts6GcuopmAFGrnnPFSmHUIZRZYJSB7
         ili1MC/txUR2YX4w0VQnwYqwnSHqOFCkHepxpVBDFcXbArHDttnC95VgS8Egzv1qAHOh
         imUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nZKlStsukXTiXMspHE/cDk5Om1miIJs0rtHlxN58scw=;
        b=AsRC1SI/jXWQS0CMlW/Hvj/sOqiBGmNqb/ROA8ydBaq5uiixkX4VlBMJTgdijDuDyz
         nvxDhK45Tlt0vxvPJHDNonpwPsIID1+GxWFQlRoZx1WqB2Uskic1KXzsFvNHCLTxoz9G
         tuN2gVNiLa8skdlzH7NID8UGtyWdgtoXtDLSlILLxfe2//14RTMJcI/e3QLz0l3n3sJy
         N10gv7KVw8cN7PeR+qd0vyPe1zX+qm3HjWZIvGBd7tp/G3PUvpxNCytScz2rsmWk6YX3
         hJEeSXrOWhRjy74OM3VHszw/W0/GmxL2PRP1Cpkjwj4nbHI1d8arSHyMuGtxJ/znVTtm
         63Ig==
X-Gm-Message-State: ACrzQf2tg1A5rBgo+rthOyla0gpmCZP1sdyREoZmr5bxtWXBZOOYmxMl
        aBJ0x/Hl92lz0h2Ag3bwK81b1OKPDiSr7A==
X-Google-Smtp-Source: AMsMyM59DN9FLmFmygbaxvKvQrOnMoCZWLcuZEwpCKhb6PyTPe6TeSvziEJhWS+XJUbDBjtSnEXWfA==
X-Received: by 2002:a5d:5887:0:b0:22b:1255:42e5 with SMTP id n7-20020a5d5887000000b0022b125542e5mr16623537wrf.114.1664271322835;
        Tue, 27 Sep 2022 02:35:22 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id g11-20020a05600c310b00b003b4fe03c881sm14137452wmo.48.2022.09.27.02.35.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 02:35:22 -0700 (PDT)
Message-ID: <49dacbf3-01e2-3687-f6d6-9346e418e98b@linaro.org>
Date:   Tue, 27 Sep 2022 11:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] thermal: qcom: tsens-v0_1: Fix MSM8939 fourth sensor
 hw_id
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
References: <20220811105014.7194-1-vincent.knecht@mailoo.org>
 <9ef673f2-4296-8761-4d7a-dca323ba272e@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9ef673f2-4296-8761-4d7a-dca323ba272e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 24/09/2022 18:38, Dmitry Baryshkov wrote:
> On 11/08/2022 13:50, Vincent Knecht wrote:
>> Reading temperature from this sensor fails with 'Invalid argument'.
>>
>> Looking at old vendor dts [1], its hw_id should be 3 instead of 4.
>> Change this hw_id accordingly.
>>
>> [1] 
>> https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/master/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L511 
>>
>>
>> Fixes: 332bc8ebab2c ("thermal: qcom: tsens-v0_1: Add support for 
>> MSM8939")
>> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Daniel, gracious ping for getting this patch into 6.1.

Applied for 6.1, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
