Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FB65ABB8
	for <lists+linux-pm@lfdr.de>; Sun,  1 Jan 2023 22:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjAAVbD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Jan 2023 16:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjAAVbB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Jan 2023 16:31:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD19C15
        for <linux-pm@vger.kernel.org>; Sun,  1 Jan 2023 13:30:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bp15so39093028lfb.13
        for <linux-pm@vger.kernel.org>; Sun, 01 Jan 2023 13:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wadRULsNjGv3JLmdwEv3tAVRSsp8mW5cYkUY+ZGJhzA=;
        b=AF9kj3dVWZ7Tsys2r1tbj4hFa8TBqpVpKc21Llx+NHO68+OcaczkSKP6sF1bI3AGKX
         hQKHPUFIHvyfFk0UGC07iYza70Kown7r38hqEVlqg0wyDFYzDMc8nVbCdR8XhcAKK0p9
         InAVarPTbl+pN8avnfCgdEyhBxiClBb/qzECBtrEEYzujtfF32Rp/NG2ziXvmCunikrT
         MaGYwUxPGvKh4HtibZ7QK/ulw+yy1FuiB+XjKZZ0Zf0HCp0U/Yh55IN+0NpZ8x74eBIe
         pLoXUInJCW/L/YdKTUsGC2cKqYWS7tEcUYb4vNGOONgBsK1+8wdBqhY950ip57/RLcZU
         tsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wadRULsNjGv3JLmdwEv3tAVRSsp8mW5cYkUY+ZGJhzA=;
        b=F4pdEhYq2eKjYB7rnHyw5Hfr79ntMs0Wn+QmDWdaFZemIcW+rsTu/ODDQPmJk1Tx54
         rQaQHUKFHR0+ABPNI3Tk4/AbWBfvGfm63te5p8L7YvnxYNwsBN89DuF4p0YmH+GAAwMK
         zSu71iVK5IHdI+sEVY0kDYPSKCaPtvKS2T6OguehFjQMrnoY8iK+6Mp74g5n6+kCgH5r
         bbZR670RsRZ6x9IGdzNHhjwemXNoa9RvGgcVPWqaT0Drr/mV6aQraX1RBXhydmYTduDG
         7/BhfQ6mOnCSBu3NTUr7DSCK4ToRrGqnN9OdGulyLBGpqvnrgmfMQcLDsdM/9tIDWE7P
         fJig==
X-Gm-Message-State: AFqh2kqgvLvaEGuq/LRzOamN5kRpXPFcvfQdBUN2GKW12/fgDL2x/mhu
        6WIOWYKkN6VCHipp6xJLF0RdVn9ZKNbMxr/y
X-Google-Smtp-Source: AMrXdXs69AvJvDyXi9J0AjohK7USrhhVRpbBpawny2fOsJWeIZRyPHxGCzInQgBWLAsGHvuQdm80cg==
X-Received: by 2002:a05:6512:1505:b0:4b5:7bfe:4e44 with SMTP id bq5-20020a056512150500b004b57bfe4e44mr13080472lfb.6.1672608655217;
        Sun, 01 Jan 2023 13:30:55 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id bq25-20020a056512151900b004b592043413sm4240931lfb.12.2023.01.01.13.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jan 2023 13:30:54 -0800 (PST)
Message-ID: <fc6f9558-46c6-a7f6-7f41-afad418c8f7b@linaro.org>
Date:   Sun, 1 Jan 2023 23:30:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v6 07/20] thermal/drivers/tsens: fix slope values for
 msm8939
Content-Language: en-GB
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <7298fd96-14ec-c82b-8005-bb5dd912a055@linaro.org>
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

On 01/01/2023 22:24, Bryan O'Donoghue wrote:
> On 01/01/2023 19:40, Dmitry Baryshkov wrote:
>> +static int __init init_8939(struct tsens_priv *priv) {
>> +    priv->sensor[0].slope = 2911;
>> +    priv->sensor[1].slope = 2789;
>> +    priv->sensor[2].slope = 2906;
>> +    priv->sensor[3].slope = 2763;
>> +    priv->sensor[4].slope = 2922;
>> +    priv->sensor[5].slope = 2867;
>> +    priv->sensor[6].slope = 2833;
>> +    priv->sensor[7].slope = 2838;
>> +    priv->sensor[8].slope = 2840;
>> +    priv->sensor[9].slope = 2852;
> 
> How are you coming up with the last value here ?
> 
> https://github.com/android-linux-stable/msm-3.18/blob/60a8d8af3751b9dc22894fe68b3964ea94ae7888/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L525

 From this DTSi. There was a separate configuration for 8939 v3. And I 
don't know why Qualcomm completely ignored it for later releases (3.14, 
3.18).

https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blob/LA.BR.1.3.7.c26-03900-8976.0/arch/arm/boot/dts/qcom/msm8939-v3.0.dtsi#L613

-- 
With best wishes
Dmitry

