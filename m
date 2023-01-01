Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDADE65ABBE
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 22:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjAAVdn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 16:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjAAVdl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 16:33:41 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A132710BD
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 13:33:40 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m18so62780797eji.5
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 13:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yyX96uVGJMMaNM8wZZWyXIyRqapSrshMe1zf2VI54Gc=;
        b=gSw5fX1Bkm7fQmXRIRnGTyyos+zIm+kBLxXP81KQpsb3rLEabKuUAbHFc3zYDXnWbs
         AGjnENSsuIA9DPgm6QM/wXLIoq/IQ7jBnzxyDYNg/FGfwEKGIfg2x27FyhCI7Xo9OwTQ
         ygZUVFs79gcCVrwujTUUTHSf+GHYcGTa88YGaqkgeXAEShwLBYbyNHFh9bSxB+/WVmxW
         yrjGG0q3DeSv4SA2WYrtz2qLAmT67GyE5lMyTb16pO41/JofWyYesQ8PqUGBmsmqq8mq
         i77+4PyJq0tAeMMr58zyQRSZhBTyf4uirsCvZqH6BQaR9ULl21lVr8xoUKjTLYonDjXD
         8BRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yyX96uVGJMMaNM8wZZWyXIyRqapSrshMe1zf2VI54Gc=;
        b=cBNzOurM1doID+K6E+wWxYlbzLB7Djadms95CJTy6pVCzQy8dqvRdtMmCqL6SP/ZH2
         NZXJ4aJzHSazv6jWO63ccQ5At4woh7fhfOF2eJkjavmYgc7J25hKvJqQm07iaoZEBL08
         KnM/H6yj5PzN5Jmi2lZphlcLzLRfgFiqGeSVvnZXysFgk/R2gnLVu//+02ZHyy3tjLH7
         NJtn96u9Yno7padJ0u7hf0A4QcbSzJs1bhXVAl+5BancnRNGOqTBFYljmrqOc9hZxux2
         4yzThGa4JpZuY0mQK0/MTEXRdQs3Z7nMYLVVqsa83NK/siE/RspviNq1bEEbsnoIl9/B
         YccQ==
X-Gm-Message-State: AFqh2kpHd0y3ceqlyOq1DZ3pY7+Lel7Hfp2CAALdLU12pm4Mf6fnTo9I
        Dxr/aJRa8/k2UR9lD+iYWYcSKQ==
X-Google-Smtp-Source: AMrXdXuIzVKHbCr/cOQ9XZLjyA7akuauNPpkKOy2DJ228mNpxKjLLqaiW0w47WAi5TfUVRXgYtr0fg==
X-Received: by 2002:a17:906:b043:b0:7c0:d23c:ead3 with SMTP id bj3-20020a170906b04300b007c0d23cead3mr33986334ejb.27.1672608819181;
        Sun, 01 Jan 2023 13:33:39 -0800 (PST)
Received: from ?IPV6:2001:1c06:2302:5600:5825:7f8d:c381:cef4? (2001-1c06-2302-5600-5825-7f8d-c381-cef4.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:5825:7f8d:c381:cef4])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906829500b00782e3cf7277sm12056805ejx.120.2023.01.01.13.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 13:33:38 -0800 (PST)
Message-ID: <fde591a3-1e1c-c186-a119-5d2af48d2ae5@linaro.org>
Date:   Sun, 1 Jan 2023 21:33:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 07/20] thermal/drivers/tsens: fix slope values for
 msm8939
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Shawn Guo <shawn.guo@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230101194034.831222-1-dmitry.baryshkov@linaro.org>
 <20230101194034.831222-8-dmitry.baryshkov@linaro.org>
 <7298fd96-14ec-c82b-8005-bb5dd912a055@linaro.org>
 <fc6f9558-46c6-a7f6-7f41-afad418c8f7b@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <fc6f9558-46c6-a7f6-7f41-afad418c8f7b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/01/2023 21:30, Dmitry Baryshkov wrote:
> On 01/01/2023 22:24, Bryan O'Donoghue wrote:
>> On 01/01/2023 19:40, Dmitry Baryshkov wrote:
>>> +static int __init init_8939(struct tsens_priv *priv) {
>>> +    priv->sensor[0].slope = 2911;
>>> +    priv->sensor[1].slope = 2789;
>>> +    priv->sensor[2].slope = 2906;
>>> +    priv->sensor[3].slope = 2763;
>>> +    priv->sensor[4].slope = 2922;
>>> +    priv->sensor[5].slope = 2867;
>>> +    priv->sensor[6].slope = 2833;
>>> +    priv->sensor[7].slope = 2838;
>>> +    priv->sensor[8].slope = 2840;
>>> +    priv->sensor[9].slope = 2852;
>>
>> How are you coming up with the last value here ?
>>
>> https://github.com/android-linux-stable/msm-3.18/blob/60a8d8af3751b9dc22894fe68b3964ea94ae7888/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L525
> 
>  From this DTSi. There was a separate configuration for 8939 v3. And I 
> don't know why Qualcomm completely ignored it for later releases (3.14, 
> 3.18).
> 
> https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.3.7.c26-03900-8976.0/arch/arm/boot/dts/qcom/msm8939-v3.0.dtsi#L613
> 

Fair enough

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
