Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DF670DA90
	for <lists+linux-pm@lfdr.de>; Tue, 23 May 2023 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236204AbjEWKam (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 May 2023 06:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbjEWKal (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2023 06:30:41 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC6FF
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 03:30:40 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso3807534e87.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2023 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684837778; x=1687429778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/T9opHzMSw2R0AZ40N9B37p3pMgsnkJKDx5J8AZzmBw=;
        b=tRCziY5FD1lkGf8nKeQnWUtC2+ERps6DDPpk5yUmC55lO42H5ojtarEofe+3Xcm6rP
         2bjfgs8JMr68U5JjKwaCkXMaSWFL8LCooihu9NoITjoxZ9kN6KTw+Jdb9fz8NCY5H5Qy
         Gup1Tnx01gCFsPphfjbRg4/TJ8awUbbHTEbHchk3A+Nz4EBhFkgOEYUo23fnR7kH/2Yw
         1mPYJSAx77KMtXmkTcPX9tR/nbVjhbcTYHpL1YTHQQGiuc0SqyU1Jc69dmPjBZsw5M75
         7AwwsfE5NOWtWBw9HcnUPDCBj6ubXCvCsflSUGoWYlYA/96SJNIdMztOnNL4MnTTdLB3
         cL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684837778; x=1687429778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/T9opHzMSw2R0AZ40N9B37p3pMgsnkJKDx5J8AZzmBw=;
        b=C5HQGHluVUwGnNdTc4kFD4sZey7BE3rZvbqixQ0NPEGmKzPTp1QmVtlbaIq36M9W0n
         O+Ub2pGHYbr5u/wL8KwVjBAwFHq855DvlH8oYACowgpQpovetnysMOet+fU/y3XXOZFk
         Gs9DYMFcvTG0eNbrHJkMEOtzSuPVDgu7I2P1XFvGK4399X6SQG2O5myR21qGnTweVdUb
         MayV/CLMJe3YdwbSl9pvj1kXKjLao+seXmdEIyn7XWOHT5+z1nNZGyf8/BP6MQ/Msk6p
         ICFRLuXI6zGSCvmi/CwluKqGtgVhLUOtpbsMagiqyy5uc+/tIlnk7FVFGP+ADP8Lgct+
         L2xw==
X-Gm-Message-State: AC+VfDwp4iN9tM8LEXoXPKO1mgQX9Jm/UJsq5CvSRZrDz+5ybnHksw/P
        N7SM5FFJ3kgkId4r4CFMTaKRNA==
X-Google-Smtp-Source: ACHHUZ7NlztXsyfEPG7uRIrR/BDOKoTQuncAxl6jYjrOJQ0nYDERu3ZThn0B0l/rvpMhua0FzNqdag==
X-Received: by 2002:ac2:4c8e:0:b0:4f3:b97c:2d88 with SMTP id d14-20020ac24c8e000000b004f3b97c2d88mr3307217lfl.63.1684837778508;
        Tue, 23 May 2023 03:29:38 -0700 (PDT)
Received: from [192.168.1.101] (abyk138.neoplus.adsl.tpnet.pl. [83.9.30.138])
        by smtp.gmail.com with ESMTPSA id b1-20020ac25e81000000b004f14591a942sm1279869lfq.271.2023.05.23.03.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 03:29:38 -0700 (PDT)
Message-ID: <87b5dda1-be2b-d123-e026-176d4c732b3f@linaro.org>
Date:   Tue, 23 May 2023 12:29:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] interconnect: qcom: rpm: allocate enough data in
 probe()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <e0fa275c-ae63-4342-9c9e-0ffaf6314da1@kili.mountain>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <e0fa275c-ae63-4342-9c9e-0ffaf6314da1@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 23.05.2023 12:27, Dan Carpenter wrote:
> This was not allocating enough bytes.  There are two issue here.
> First, there was a typo where it was taking the size of the pointer
> instead of the size of the struct, "sizeof(qp->intf_clks)" vs
> "sizeof(*qp->intf_clks)".  Second, it's an array of "cd_num" clocks so
> we need to allocate space for more than one element.
> 
> Fixes: 2e2113c8a64f ("interconnect: qcom: rpm: Handle interface clocks")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
> v2: allocate enough space for the array
> 
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index f4627c4a1bdd..6acc7686ed38 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -436,7 +436,7 @@ int qnoc_probe(struct platform_device *pdev)
>  	if (!qp)
>  		return -ENOMEM;
>  
> -	qp->intf_clks = devm_kzalloc(dev, sizeof(qp->intf_clks), GFP_KERNEL);
> +	qp->intf_clks = devm_kcalloc(dev, cd_num, sizeof(*qp->intf_clks), GFP_KERNEL);
>  	if (!qp->intf_clks)
>  		return -ENOMEM;
>  
