Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC4C752A29
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGMSHk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 14:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGMSHj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 14:07:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC1E2724
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 11:07:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso8449535e9.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689271655; x=1691863655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CLkIfBJthLEH2ccjZlkkGVeGCtWdOkNdkmUQsqDJMeI=;
        b=rSozWLDr9KZxz25t+9LmW0w3a5QauJcRdaAuzHjJk0JNUg0UhVfn8YOR8E2IpfghAg
         W2sg1rGv9jsVgWB7OVR0/uQZU/j0OBZH9ui0iEBOiGjdAZ0yQRFWs86iTubRZHmjbMHF
         tgXQ8r98C5oN1hJANY2clAwfhsOyGpfC1+y7EvowFA0oMiN9tbfgH8uTP6NpWR+MoE+d
         2B9bBrIsqCW5zyzZdjeAXGj+e7l2mCwvt7/LU/oxzM0bzJddGt3RTArlRUaGyjNDEow3
         9xd07Dzxr4pwU9n8M+2gP1YgLs1s8w7cD3zL8M9ZCMElvsrlfBrRfjNNQPIXTpq2dGft
         2Juw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689271655; x=1691863655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CLkIfBJthLEH2ccjZlkkGVeGCtWdOkNdkmUQsqDJMeI=;
        b=agWo6JyZB8RiFF3+BXMry+VpZuRQTjY+gdyFbB+aoDK9ifV2SR41v9z4Be3MI2AQpQ
         sH7bfE1sS86Hv7nFOYszSxATZa2SjrmCGUAIYF+LPS1aRoW2bSHlDWyuAF0KqttX1NfW
         5FE9VM5j9loT23IzoYs48jt8dnHwWBIEFMqxiET+6VBFZy97Bu6MPA2Gh41jhHkTnDry
         0Fnxdo3/eMF/q6NhlbMr8ySEsApGMtkrCLtn8Hmi0aIlFz6UsovmmE9aRw4wE50FgvR+
         DWLCF/fUmpXDqjIHQuFED9PTq7PWXYfS2I4EO2rj3JtQmYHQBY7Hng34g2C0hHrkyIc5
         4+Sw==
X-Gm-Message-State: ABy/qLb9TBfuEStEN5hJFF0LmPBe2uD0EZTLUlT01O51/nmK1qgaYAlq
        NTPKTk71LmOIKHCXAv5Nvi4c+g==
X-Google-Smtp-Source: APBJJlFOlyG41+n+2iJOGB1cYv+oZzqeKv3CFHYA+MueCLFGy8D+v2cUTRR+I9Wmegt+nPSbXQNMyg==
X-Received: by 2002:a1c:4b18:0:b0:3fa:9e61:19ed with SMTP id y24-20020a1c4b18000000b003fa9e6119edmr2481086wma.23.1689271654801;
        Thu, 13 Jul 2023 11:07:34 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id gy24-20020a05600c881800b003fbb1ce274fsm866782wmb.0.2023.07.13.11.07.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 11:07:34 -0700 (PDT)
Message-ID: <78cd6fcb-17e7-450b-759e-bd306ac6c3d0@linaro.org>
Date:   Thu, 13 Jul 2023 20:07:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] thermal/drivers/tsens: make tsens_xxxx_nvmem static
Content-Language: en-US
To:     Min-Hua Chen <minhuadotchen@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230713160415.149381-1-minhuadotchen@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230713160415.149381-1-minhuadotchen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/07/2023 18:04, Min-Hua Chen wrote:
> This patch fixes the following sparse warnings:
> 
> drivers/thermal/qcom/tsens-v1.c:24:40: sparse: warning: symbol 'tsens_qcs404_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:26:40: sparse: warning: symbol 'tsens_8916_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:42:40: sparse: warning: symbol 'tsens_8974_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:64:40: sparse: warning: symbol 'tsens_8974_backup_nvmem' was not declared. Should it be static?
> 
> No functional change intended.
> 
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

