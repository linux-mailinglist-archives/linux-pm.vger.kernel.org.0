Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F061C710BD1
	for <lists+linux-pm@lfdr.de>; Thu, 25 May 2023 14:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240238AbjEYMMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 May 2023 08:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbjEYMMS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 May 2023 08:12:18 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BC6A4
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 05:12:16 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4eed764a10cso2268355e87.0
        for <linux-pm@vger.kernel.org>; Thu, 25 May 2023 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685016735; x=1687608735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvimAcS+ZqUCgtUPuylnz5rLyY+z8RpskX6gwW+E/gs=;
        b=tHwtdktVxcIOe67U/5tEhb9b4Vs3LQ8Au8IUUF8YfDGCGMomWdlLCk3QXkJFgLj8p6
         FMYINgLa7kSI1EqvwNxCLtJtAts1m1A6amNdCL/7Ap2SlYrMhsLaQQmSkX8qtN8r87kP
         FnvnGKGR2u/PTsuUDE7J0vFA1d5MlPgqVHlqs0TaZBE2DZbglVjtnxD+87xPwH4MUBz/
         fHTGkNMettCpuvdrzCpNfkoXaA23PmNk0fIuL9dhNLs8UwPdVqBSrtuNACwHzwuFkSuL
         nOYux+Dk9Ct67I6+gLvTN8c8BY9viIxRLvsYPA+Oyl3S30jUdqX7d3SBM2uAjeUO9vhY
         YeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685016735; x=1687608735;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvimAcS+ZqUCgtUPuylnz5rLyY+z8RpskX6gwW+E/gs=;
        b=iLzB5G+zMQxvlZmUn9AU2jjQI4n2OWSgH9SX89p8R5xXD8Gk9rlTEkD0I2lR/69EXX
         d0SMbDPbpS1hge7wEwzqEzfRs7fRRwqlDrSZVhN84nciB+0KULjiLG94hePdZXslx6+u
         mmQeYEOYwOHqUCiDAbxySm/gU+/8CMys9KHAEikQo8UxXpxzk2ybqs46Ip6l3GSHX7KM
         w6gfHCPbRqULpVU00Cd7M5QxTTuNdqBDD4ew+yXxnjkHY+jcUw9NXllTeUXK8BetMLte
         xDufmEqQa0JO8KiGXqkd1d03Hbq46wle7n8ZfHXPHC9do1mAwu4r6IlRkmrQQxTUzjTI
         QCQg==
X-Gm-Message-State: AC+VfDzGnE7lOjmcgFilp8whuwxyaWc0PdFelp0HO2pKbSushnNjn82O
        /D0TdODkkpcPE8lOV13Rg9YTrg==
X-Google-Smtp-Source: ACHHUZ5ejVEKFhSF38eME2EJbbEhNyTzcL8KFdPsj5cEn1qQqKTJi8YBxBDdH/wiasqax5rzbj3lCA==
X-Received: by 2002:a05:6512:515:b0:4f1:44c0:a921 with SMTP id o21-20020a056512051500b004f144c0a921mr6603459lfb.55.1685016735075;
        Thu, 25 May 2023 05:12:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f00189e1dcsm189563lfe.117.2023.05.25.05.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 05:12:14 -0700 (PDT)
Message-ID: <ed82970f-691a-b508-604a-17f78db9fdc1@linaro.org>
Date:   Thu, 25 May 2023 14:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/5] soc: qcom: smem: Switch to EXPORT_SYMBOL_GPL()
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230525120956.3095317-1-robimarko@gmail.com>
 <20230525120956.3095317-2-robimarko@gmail.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230525120956.3095317-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 25.05.2023 14:09, Robert Marko wrote:
> SMEM has been GPL licensed from the start, and there is no reason to use
> EXPORT_SYMBOL() so switch to the GPL version.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/smem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 6be7ea93c78c..bc98520c4969 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -500,7 +500,7 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(qcom_smem_alloc);
> +EXPORT_SYMBOL_GPL(qcom_smem_alloc);
>  
>  static void *qcom_smem_get_global(struct qcom_smem *smem,
>  				  unsigned item,
> @@ -674,7 +674,7 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
>  	return ptr;
>  
>  }
> -EXPORT_SYMBOL(qcom_smem_get);
> +EXPORT_SYMBOL_GPL(qcom_smem_get);
>  
>  /**
>   * qcom_smem_get_free_space() - retrieve amount of free space in a partition
> @@ -719,7 +719,7 @@ int qcom_smem_get_free_space(unsigned host)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(qcom_smem_get_free_space);
> +EXPORT_SYMBOL_GPL(qcom_smem_get_free_space);
>  
>  static bool addr_in_range(void __iomem *base, size_t size, void *addr)
>  {
> @@ -770,7 +770,7 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL(qcom_smem_virt_to_phys);
> +EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
>  
>  static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
>  {
