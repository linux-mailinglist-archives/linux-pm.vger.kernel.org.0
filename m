Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80E67198DF
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 12:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjFAKQO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 06:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjFAKPi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 06:15:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F9173D
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 03:13:12 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f5021faa16so703608e87.2
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2023 03:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614387; x=1688206387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXouGOXkpoQ3tdmDcT3qz0S4YzawGIkT1hXliFzcQPw=;
        b=P11YRFapqhQ6yAR93ejqCZFsdjz15vcOsO2jcUkeGYUTHsMVapscWwLormxHbvTf4e
         MAoPrF2UnO+F3Tm6/dCaSuU4VyEra4PAtPGa1uqXeT3xjCcBWN6o8/rP1a0zIkRw7cYt
         fiENQ2KkHt2PlpSaDxNHX5nkf6FE56USHGJT8eZ1pTaFYFOmgZGhHt7okKE8LMa4x9EN
         fscwWatmRgLjLnSxg9MiCHd4k5RqN2/GprFAVWo0fe8cCaMgvhnBf0TtDLQscq7aBs+S
         T5BCiFiU1W9vsclUwUBuQl30Xezc2db3M/4iOppbX1qVzwcgqUM2d/sK3eMpLfm/B4+A
         lHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614387; x=1688206387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXouGOXkpoQ3tdmDcT3qz0S4YzawGIkT1hXliFzcQPw=;
        b=eo3wdM70ft8y0PWjnNvpEdZxxuMwBSR+Iom5loyiS/EG4p8A+9VcH5sSPeIrQ5zxzp
         eb2z+1jWj+ZZR8O93SvOr91Lcc7okrvSJpO++aTm7sij87u/pqozG+YG6CeqmMdrjB7Z
         86jNIUSr/cevzMAXpfkrJdiTZAXdwdRZT49mL9fsPRe5XWnpMYacgx8yZ91Ta2xE4+rR
         Y8ylHyQdbJnO2b9oKW/2g8Y74ol+JX3I5u2irBjM2SwO0fCfASFOf4VxZJhzEWrGmy37
         1MUMZldoXs6Fo9Muz+r/cnrF4nvHAzCE5XS9y1S1yX3Te15YzTsRCtgOTbBwuF8Sre+y
         Tytw==
X-Gm-Message-State: AC+VfDwTmw3Ozgh/Kmow8WXjJTdWLo3xxOeLOMyA18drAGxhUprBidoq
        vdRrhbywxrUKNrttyqLp6JUOJA==
X-Google-Smtp-Source: ACHHUZ4m9ck0bizOwU91YmOZb84i7iGLIr5Hf82qDYtxipuuCkGEX83LQV/Cng1E87Whj3s2lw53Vw==
X-Received: by 2002:a05:6512:21a7:b0:4e8:4a21:9c92 with SMTP id c7-20020a05651221a700b004e84a219c92mr1102114lft.4.1685614386683;
        Thu, 01 Jun 2023 03:13:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id y24-20020a197518000000b004f271790d6csm1033816lfe.136.2023.06.01.03.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:13:06 -0700 (PDT)
Message-ID: <f2403ae6-aa8c-b53a-2e24-4f158fcc85c7@linaro.org>
Date:   Thu, 1 Jun 2023 13:13:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 18/20] interconnect: qcom: icc-rpm: Fix bucket number
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-18-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-18-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/05/2023 13:20, Konrad Dybcio wrote:
> SMD RPM only provides two buckets, one each for the active-only and
> active-sleep RPM contexts. Use the correct constant to allocate and
> operate on them.
> 
> Fixes: dcbce7b0a79c ("interconnect: qcom: icc-rpm: Support multiple buckets")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

