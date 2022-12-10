Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADBC6490B3
	for <lists+linux-pm@lfdr.de>; Sat, 10 Dec 2022 21:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiLJUxn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Dec 2022 15:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLJUxm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 10 Dec 2022 15:53:42 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B75140DA
        for <linux-pm@vger.kernel.org>; Sat, 10 Dec 2022 12:53:41 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-3b5d9050e48so96191877b3.2
        for <linux-pm@vger.kernel.org>; Sat, 10 Dec 2022 12:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a21vG+wPlzPxqZ+Oa5IoCuijwrOLduv3F7rsjZNsHis=;
        b=FudWoTYk6AALLuiwnDG+LiJiY9jA/rWWK3cGHOwv6D7eVIW09bqLd16OwKQnsfeIBZ
         sR4/QX6IDgcEo8L9sT0wGN0TWe+CEvh0UkhsDAkeoLhakc4vJYdBTUFNlNRsksGR0MwM
         BwnHKJQjXlPhL77VWCXpYePtzqNc7XlABzJddnzNi6/YOYwqOvlwhdK5LGc1WdgW8zig
         h59fBH6UbM7IjDP8wwPA6AcD1XSFE2LV92HAnIOnQ8iuw3amo3bGLfxYvU9PL+cHSsyN
         NaBUxPVWogUP30/VCD6Tg+Z5i8rOSeSO9JdVos/+YLBSfwEYlRHY2IbXPfAFiqc7I/Hg
         eNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a21vG+wPlzPxqZ+Oa5IoCuijwrOLduv3F7rsjZNsHis=;
        b=7I7/uqxLQIsFBiP2939OWVAQyp2zOFtwZzBSoEoOFuM6BjmkR8uVohK0o3pX43ZkP7
         0Q50vX2nGwaYEyohN3MLC4fw/YmmnkA9qDIHMtr7DfJsxSLMQvEWVmsBRNauXVANud07
         pzPDPrpGJd+gp1ptwRQ7V58/voFR9DVnO/WXlrhP7W2vpfw4lMwU5sWaHtg/MGf2ZFYd
         gidt/1WTKn5ME7/NrCyZvrp/vVOarS/PHZic1Sdgwz/ThETN/1m/yyWCJmlpslI8KtqN
         u5eqIOZNaJuUE2Z4E8zY+FoKQOwTsXIsA4yLKdhZwqHLjEmBhCC9euoK7VtIsCEPEdNI
         ZBjQ==
X-Gm-Message-State: ANoB5pnj4OectgJBhl+zVbxAQus10NSNwLuV/G9qBc9lCa9KyABmRbbO
        NhbqxivInoOmlfHkh4UJf7XLlpt/mSd6cL0CAK77ng==
X-Google-Smtp-Source: AA0mqf5IqOvmfRiYI8fvELbDxeRX/KysHofdM4YVTwzqpjg7I9BXfm6VQ9PClh4KiuGKIpTjkqHAC8UCNt7rwC9xhaE=
X-Received: by 2002:a81:4d6:0:b0:402:7be6:f265 with SMTP id
 205-20020a8104d6000000b004027be6f265mr3317452ywe.188.1670705620690; Sat, 10
 Dec 2022 12:53:40 -0800 (PST)
MIME-Version: 1.0
References: <20221210200353.418391-1-konrad.dybcio@linaro.org> <20221210200353.418391-4-konrad.dybcio@linaro.org>
In-Reply-To: <20221210200353.418391-4-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 10 Dec 2022 23:53:30 +0300
Message-ID: <CAA8EJpo0MJ_-S5ZZXq3mrwod3bUdnnMHNwSOzpwK=gXSjDO6vg@mail.gmail.com>
Subject: Re: [PATCH 3/5] interconnect: qcom: msm8996: Fix regmap max_register values
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 10 Dec 2022 at 23:04, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> The device tree reg starts at BUS_BASE + QoS_OFFSET, but the regmap
> configs in the ICC driver had values suggesting the reg started at
> BUS_BASE. Shrink them down (where they haven't been already, so for
> providers where QoS_OFFSET = 0) to make sure they stay within their
> window.
>
> Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/msm8996.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index 7ddb1f23fb2a..25a1a32bc611 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -1813,7 +1813,7 @@ static const struct regmap_config msm8996_a0noc_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
>         .val_bits       = 32,
> -       .max_register   = 0x9000,
> +       .max_register   = 0x6000,
>         .fast_io        = true
>  };
>
> @@ -1837,7 +1837,7 @@ static const struct regmap_config msm8996_a1noc_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
>         .val_bits       = 32,
> -       .max_register   = 0x7000,
> +       .max_register   = 0x5000,
>         .fast_io        = true
>  };
>
> @@ -1858,7 +1858,7 @@ static const struct regmap_config msm8996_a2noc_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
>         .val_bits       = 32,
> -       .max_register   = 0xa000,
> +       .max_register   = 0x7000,
>         .fast_io        = true
>  };
>
> @@ -1886,7 +1886,7 @@ static const struct regmap_config msm8996_bimc_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
>         .val_bits       = 32,
> -       .max_register   = 0x62000,
> +       .max_register   = 0x5a000,
>         .fast_io        = true
>  };
>
> @@ -1997,7 +1997,7 @@ static const struct regmap_config msm8996_mnoc_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
>         .val_bits       = 32,
> -       .max_register   = 0x20000,
> +       .max_register   = 0x1c000,
>         .fast_io        = true
>  };
>
> --
> 2.38.1
>


-- 
With best wishes
Dmitry
