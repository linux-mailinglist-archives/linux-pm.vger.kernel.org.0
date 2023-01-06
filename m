Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AD766017C
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jan 2023 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjAFNo3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Jan 2023 08:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjAFNo1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jan 2023 08:44:27 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35146625C0
        for <linux-pm@vger.kernel.org>; Fri,  6 Jan 2023 05:44:27 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id bp26so1013025ilb.3
        for <linux-pm@vger.kernel.org>; Fri, 06 Jan 2023 05:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5gc3unIBWzJHAWIDN45C88zkp/6OCUho9lqZyPufjzk=;
        b=gqYp7FhOkbantyFSIKTRHkGWc0d0+YLNm4WQlCvHvPZDGvuXg+1swbIIVjZaHeogZ1
         V8TWhPG/GkRph3px+LMtoRmB5DbnUEArZTj8mlX5W6prqOd6k8c4fV24syoVCrRvf2ge
         lqeGD8ZaQ80HlLlVapJ1MqQvpNgEiwvMIvx4Xy7hWYd6DLG/GROhxCd+YhKfQwsT+lp/
         w8okgdM8s9Rwzaxn1+GZwdoeR0ZKRa2bO0jLZl55nN2fCg2LltkDRjT3aK6JeSACVBq7
         xkD3GaGVJGAbvuAKlBzjqzUpVMH4IwfVZfb5/dVB8ZPjEm8KZ1X5zvtv9k2Uelm64Wbw
         bE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gc3unIBWzJHAWIDN45C88zkp/6OCUho9lqZyPufjzk=;
        b=AudGZRLLYAyMOsB+cr2baJ3ND8wMZAU2hYGMnXV/4GpmDPhUl0SReIBNBQvJtYTXQ/
         y1vsZcEp5FOBf6YBAL9gl0jaOuuwVOhE6bIN4U2xeSoOv6WVe7RWAlUVLOfC1ZpvWNqW
         1hHHIkW3ERlMcHHB0O9RYUEbwYzLgfDuSn+euMkvdky13hTtmmJ21JseDQLvHuKpSeQh
         az4D5nrKWkzfL66UNGpYdsGfvQEflxD2z/zKYIVm5tnFJTEiEDOVwfoAEjmM4M16yu7x
         xSMr0fN8ha7YHZjdi6CWrxg7Q1A34yifJ3RHkFHJBPXahSYKtMXENCAhzXF46Iygy0Bf
         5OaQ==
X-Gm-Message-State: AFqh2kpEFoJWqjaYRxe5wJpo7kEhXD/FDm3ivbGhv2P9D1lnFFbJHkfO
        ZBKMliPnENc4Sn/QFPEUqIn0lQ==
X-Google-Smtp-Source: AMrXdXsJ/zxj5qwdIbKfEFHYe96AKTYGUsuOsd1Cz4QnBRQAuQmGXpf2MHrdk2w+L87J7n5m550WGA==
X-Received: by 2002:a92:364f:0:b0:30d:6ea8:4f27 with SMTP id d15-20020a92364f000000b0030d6ea84f27mr6483784ilf.15.1673012666498;
        Fri, 06 Jan 2023 05:44:26 -0800 (PST)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id h15-20020a056638062f00b0038aaccd3bf3sm337639jar.39.2023.01.06.05.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 05:44:26 -0800 (PST)
Message-ID: <eeb9631c-4494-fc76-5ad4-5fdbdaa8786a@linaro.org>
Date:   Fri, 6 Jan 2023 07:44:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/9] interconnect: qcom: sc7180: drop IP0 remnants
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230106073313.1720029-1-dmitry.baryshkov@linaro.org>
 <20230106073313.1720029-4-dmitry.baryshkov@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20230106073313.1720029-4-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/6/23 1:33 AM, Dmitry Baryshkov wrote:
> Drop two defines leftover from the commit 2f3724930eb4 ("interconnect:
> qcom: sc7180: Drop IP0 interconnects"), which dropped handling of the
> IP0 resource in favour of handling it in the clk-rpmh driver.
> 
> Fixes: 2f3724930eb4 ("interconnect: qcom: sc7180: Drop IP0 interconnects")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

On this patch and the rest like it in this series, I suggest
adding a comment that indicates why there's a gap in the simple
numeric sequence.  Feel free to ignore this if you don't think
this is a good idea.  I'll give examples below, although I
don't fully understand why there's a master and slave on the
interconnect, but just a single clock for RPMH clock...

					-Alex

> ---
>   drivers/interconnect/qcom/sc7180.h | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/sc7180.h b/drivers/interconnect/qcom/sc7180.h
> index c6212a10c2f6..b691d97d56cf 100644
> --- a/drivers/interconnect/qcom/sc7180.h
> +++ b/drivers/interconnect/qcom/sc7180.h
> @@ -11,7 +11,6 @@
>   #define SC7180_MASTER_APPSS_PROC			0
>   #define SC7180_MASTER_SYS_TCU				1
>   #define SC7180_MASTER_NPU_SYS				2
> -#define SC7180_MASTER_IPA_CORE				3
	/* MASTER_IPA_CORE (4) is represented as an RPMH clock */
>   #define SC7180_MASTER_LLCC				4
>   #define SC7180_MASTER_A1NOC_CFG				5
>   #define SC7180_MASTER_A2NOC_CFG				6
> @@ -58,7 +57,6 @@
>   #define SC7180_MASTER_USB3				47
>   #define SC7180_MASTER_EMMC				48
>   #define SC7180_SLAVE_EBI1				49
> -#define SC7180_SLAVE_IPA_CORE				50
	/* SLAVE_IPA_CORE (50) is represented as an RPMH clock */
>   #define SC7180_SLAVE_A1NOC_CFG				51
>   #define SC7180_SLAVE_A2NOC_CFG				52
>   #define SC7180_SLAVE_AHB2PHY_SOUTH			53

