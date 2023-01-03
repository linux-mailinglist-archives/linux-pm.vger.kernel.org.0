Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CA865C0E0
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jan 2023 14:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjACNcb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Jan 2023 08:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbjACNcZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Jan 2023 08:32:25 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917FBFCA
        for <linux-pm@vger.kernel.org>; Tue,  3 Jan 2023 05:32:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id p36so45653380lfa.12
        for <linux-pm@vger.kernel.org>; Tue, 03 Jan 2023 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CHktqD0tRvBmWgzk4xOKeEjAFRq5PrsOMamz25jfsgY=;
        b=N7RuODTj1sI3dE1EjwVZ/4AuDs6QFxzMXAtXGcwCl9/e+D2kCorcK/XcOASsfB0NOe
         R6+UEhavGqp8DN6mgtUpA7JamDUJe8zYv4kaIPSuc3McprfkU04CgFeo70E1hTqFowCK
         QID4cu9rUBCQTDRR4/JhN+M3nItB/u64AbipzdUb8JXdc7Oq+FH/xX0a+PqPSNLH/5OK
         7aJhkUgv+ZcRgKs5537HQgzeOHlJaK+hRH5NvEVvkfRsbvhGN4RtbLf71HZmNfzbh/FB
         14O3nlpkWmJWZNybpzSLv2AnqE7sM/fc+5XEvRdvkdq3wD59+T+7UNTGDICfWAtFgbqa
         JpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CHktqD0tRvBmWgzk4xOKeEjAFRq5PrsOMamz25jfsgY=;
        b=U3qFyKgm3RS4cx1jWUZqsA8t/j99rqkgktCmOdjc5YsXEJ6uV0UwI0mJPa1Es1FlQ4
         uWWoTmi9QTwXXo7vhs9qf+uJWNTPmegrqu19C6jqnUbEsRMs4AFMs2OlB+SNp6XfmOrt
         ryJQLvJS5w8cfyBOgX59i/49nGsub7+lQF0KDV1dwCSWk+JbilG7C7uZKkUpMH/JytnY
         OVd2Ao5+aoDIuAY0xa0WhGiMdz4QtZTZEBodcJNss8xQUb4teX+XQUzFNCHSIBjI96+s
         ZFVvZHGxU52E4gmg0R1uuIjsaNn7ZJkNSgIj/WjSPZIpx4KVnim/prhogrTvzBFQaXHD
         okbQ==
X-Gm-Message-State: AFqh2kraIHJo5dCvKt3+McwtKxmN8yLI7DkOwteFSUKWE1Y+lNsLH7XW
        qw8mHCGEbqNEWBna9dr0Ob7Xew==
X-Google-Smtp-Source: AMrXdXvYdkqTCly/TD7AambBMqQXBcvoYrZBkDJWMpovdq1QB2rLxTHcaFTXJQPfGe9nufQTuARCIg==
X-Received: by 2002:a19:f506:0:b0:4cb:40ba:4aea with SMTP id j6-20020a19f506000000b004cb40ba4aeamr493836lfb.5.1672752740999;
        Tue, 03 Jan 2023 05:32:20 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id m12-20020a19520c000000b004cb1d754413sm2150294lfb.205.2023.01.03.05.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:32:20 -0800 (PST)
Message-ID: <f699be56-01ef-0d43-f136-d07a306a9a04@linaro.org>
Date:   Tue, 3 Jan 2023 14:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] interconnect: qcom: osm-l3: drop unuserd header inclusion
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230103031159.1060075-1-dmitry.baryshkov@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230103031159.1060075-1-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Typo in the subject: unuserd/unused

On 3.01.2023 04:11, Dmitry Baryshkov wrote:
> The commit 4529992c9474 ("interconnect: qcom: osm-l3: Use
> platform-independent node ids") made osm-l3 driver use
> platform-independent IDs, removing the need to include platform headers.
> 
> Fixes: 4529992c9474 ("interconnect: qcom: osm-l3: Use platform-independent node ids")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/qcom/osm-l3.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/osm-l3.c b/drivers/interconnect/qcom/osm-l3.c
> index 5fa171087425..0c907765783e 100644
> --- a/drivers/interconnect/qcom/osm-l3.c
> +++ b/drivers/interconnect/qcom/osm-l3.c
> @@ -14,13 +14,6 @@
>  
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>  
> -#include "sc7180.h"
> -#include "sc7280.h"
> -#include "sc8180x.h"
> -#include "sdm845.h"
> -#include "sm8150.h"
> -#include "sm8250.h"
> -
>  #define LUT_MAX_ENTRIES			40U
>  #define LUT_SRC				GENMASK(31, 30)
>  #define LUT_L_VAL			GENMASK(7, 0)
