Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214B97198A4
	for <lists+linux-pm@lfdr.de>; Thu,  1 Jun 2023 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbjFAKM2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Jun 2023 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjFAKL2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jun 2023 06:11:28 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D751D1B3
        for <linux-pm@vger.kernel.org>; Thu,  1 Jun 2023 03:10:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4b384c09fso739615e87.3
        for <linux-pm@vger.kernel.org>; Thu, 01 Jun 2023 03:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614226; x=1688206226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Q2TK9IV5e/SKE5sW2ar1ad6dD9hRThXQ/HjCmzBBEI=;
        b=VHVXIP8IBwmIk6uy5Y/4ljlX3saRkSiOFAZd8PjKEHLQ3L8Rrxdp58OLytu9u8/2O3
         C04GaHMjjsGLQqGz4NzycFlOj8YK8vT2NKPbDIyBRZKjMbPzGe0aLeeQzWwKRVCrSu7a
         L9JJrT0Pyfl3OAGrB7zZeiSYDAQHnxK97PemzIGrqFodD5WdaRVVWna79iIn6RHA+X6m
         g27rrMx2/RdNVQKPDufbrIm0UoN10lXB7CjFveAeop9+eR0afe9uKvK4meBOxaZ1AM24
         kMF3YdPAEd836T8c9b44Irhmjxz0piVTgTyxqSzuSYehUJArdo4Kenr9V8lobVwsVaYC
         eK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614226; x=1688206226;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q2TK9IV5e/SKE5sW2ar1ad6dD9hRThXQ/HjCmzBBEI=;
        b=MjtNPLFbtb/dJ1EbAopQdZh8XgtNIKbpfbttqrQRwVVfdDsYHtPWcmRbs6h5SwNOu0
         h3aIeXdt8kTq1dNTRnYWqyTQiXQjnnU1ELv7eGcfSDF7jpJS7EiF2vrLy4SyT8uv4Ze6
         yRShSp/u+Q/OuXuWRI+s+RBfJVgyy6hhkvzh2HkbAFzLwNj/shiqIx/A/iJLUlJPcVBl
         bNEYM9OM+sR5LC6MIWw1K69YMHH6zMHBh7O7orqMr68klK6wmcliEpXRNDF8a2+fPaLG
         8NJJ0/mUKiqOOhY7vuHuvEWKaDdwyax1ff5oQsNh4MXvy8/86zvpyZDUrcLKZMSCWQMf
         1wLA==
X-Gm-Message-State: AC+VfDwh9rVOwO8U08FIWLzKT5wxSbqjcmt6hQro7bcFmdP61S8juNmh
        smnC+Bh4srgbFSrSn9IRTpV4eA==
X-Google-Smtp-Source: ACHHUZ7KO4sSsaaSRtb/8O5xFncu5dOG9lEB0j3cTtYvD7LjYvNauzObHlRLGCgg29Gqmivyg1tAzQ==
X-Received: by 2002:a2e:9f02:0:b0:2ac:e66c:e91 with SMTP id u2-20020a2e9f02000000b002ace66c0e91mr4289559ljk.19.1685614226137;
        Thu, 01 Jun 2023 03:10:26 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id e11-20020a2e984b000000b002a9ebff8431sm3719950ljj.94.2023.06.01.03.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:10:25 -0700 (PDT)
Message-ID: <932a4a57-792c-6d29-8c1a-3659652fa708@linaro.org>
Date:   Thu, 1 Jun 2023 13:10:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 15/20] interconnect: qcom: msm8916: Hook up RPM bus clk
 definitions
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
 <20230526-topic-smd_icc-v1-15-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-15-1bf8e6663c4e@linaro.org>
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
> Assign the necessary definitions to migrate to the new bus clock
> handling mechanism.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/msm8916.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

