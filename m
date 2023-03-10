Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F946B447E
	for <lists+linux-pm@lfdr.de>; Fri, 10 Mar 2023 15:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjCJOYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Mar 2023 09:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjCJOYa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Mar 2023 09:24:30 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B33117165
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 06:23:27 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e13so5183514wro.10
        for <linux-pm@vger.kernel.org>; Fri, 10 Mar 2023 06:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678458202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kkapvHp1JW76D9fYgnefjU4ylcODf/gc3UWuHHsi/fs=;
        b=aM9kNwoojbiz6e9hyfrekto839DjWbWIJi1/+JEA/talQoOPDXW+3D6UXdEPV0ocYk
         NUJLhlImRQQrx+4K8KROGW6B4y3KXX0BTImHwDkoweEVVW2QuI67MgaqvfAT1465hzZl
         Y+Yut4levWlI5U+Btouox6XpVKMuQIKDrXaGnxOVYvx+zqRH3ZExiUu6Thb0X9fhfXzB
         B/gevCnFIJCTSKibxXX8NqLBAkh4kiFWMoPou8X4Wtbxf8JJbckMohCuKUM06jjMxrBs
         A8BkvLeivXsyI58S+ueIp/OZDH457CvC+wmvIEtFw2fFbVXZYw3rGCUCye6fW5xoNhav
         Bzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678458202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kkapvHp1JW76D9fYgnefjU4ylcODf/gc3UWuHHsi/fs=;
        b=eFOD9o/QtDU3liXC+gEdSJjMk1O4BkbgZ4zArnDtwIbmiiYlQpCS3W0EFPCohY3Pvw
         lKZ0UP24qmpamSAsqlXbgKtGwi43/HzuYvjvotPpyyR0UGMldiOk1zKJ710O2GzwrpzA
         OyM80YZ9dptyN6PrJV8JpCxMU2Qw2JOqvEhXGsDLXnnI+7pOOCroV+byNp1+MqSbqw6L
         1mn1t4Gyg5LlLX4VhttySVRYqqOJeFV94za0GgysrFEDgRNk73LTGjd9daSfFba/Fvgy
         UPxjIXYDkE/bMpfqLYk/tYLLM0xiXWY+7h/PiBYEAEC8o0ZHLoFuucdbmM+wRU4za2QN
         Jx/g==
X-Gm-Message-State: AO0yUKVg2cgnoI+Esc6yPZJIhiQME2eXwAJx6eTX2QQC91mVCswqU3Kv
        G49DraqQ4RHYFX88lrsdnCKtSA==
X-Google-Smtp-Source: AK7set/cUAXhhoKSsswRZJ5ykSJd/dXzR9C1/AqaKk3LMcl953jw+t+uTxnBr5ukiS0fk7JchNTNAg==
X-Received: by 2002:adf:fc8e:0:b0:2c5:4c9c:e15d with SMTP id g14-20020adffc8e000000b002c54c9ce15dmr17240496wrr.17.1678458202669;
        Fri, 10 Mar 2023 06:23:22 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h6-20020a1ccc06000000b003e22508a343sm56335wmb.12.2023.03.10.06.23.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 06:23:22 -0800 (PST)
Message-ID: <937279a0-2e62-7061-3752-dfb94ee6d1f6@linaro.org>
Date:   Fri, 10 Mar 2023 14:23:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 9/9] interconnect: qcom: msm8996: Promote to
 core_initcall
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230228-topic-qos-v7-0-815606092fff@linaro.org>
 <20230228-topic-qos-v7-9-815606092fff@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-qos-v7-9-815606092fff@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2023 21:40, Konrad Dybcio wrote:
> The interconnect driver is (or soon will be) vital to many other
> devices, as it's not a given that the bootloader will set up enough
> bandwidth for us or that the values we come into are reasonable.
> 
> Promote the driver to core_initcall to ensure the consumers (i.e.
> most "meaningful" parts of the SoC) can probe without deferrals.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/msm8996.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index 347fe59ec293..1eb51ed18b0b 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -2109,7 +2109,17 @@ static struct platform_driver qnoc_driver = {
>   		.sync_state = icc_sync_state,
>   	}
>   };
> -module_platform_driver(qnoc_driver);
> +static int __init qnoc_driver_init(void)
> +{
> +	return platform_driver_register(&qnoc_driver);
> +}
> +core_initcall(qnoc_driver_init);
> +
> +static void __exit qnoc_driver_exit(void)
> +{
> +	platform_driver_unregister(&qnoc_driver);
> +}
> +module_exit(qnoc_driver_exit);
>   
>   MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
>   MODULE_DESCRIPTION("Qualcomm MSM8996 NoC driver");
> 

Its probably the right-thing-to-do to have interconnects probe earlier 
but, then, why restrict that to 8996 only ?

---
bod
