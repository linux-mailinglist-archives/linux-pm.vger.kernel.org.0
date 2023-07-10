Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A824974D97C
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 17:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjGJPEK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 11:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbjGJPEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 11:04:04 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88577129
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 08:04:02 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-56fff21c2ebso56191727b3.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689001441; x=1691593441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r0GBXtQWMUWeqQq+M5AIorJEQ/4p4IESUvPrQzMKy+M=;
        b=iEBN/N+QcxljrJHYIWuE+HoYXXfM68wAdM8Wm0+9I2lG+AypKCQomrHX7m9EfWNUUE
         268XP2Q8qkFniawu7y5JeR+wKZ3LCnYSwbLJfUO/vJR1vcOVJWMvMENqzhPflvUpcNwR
         C6mfiP9EJbVcKMkGhvHXE/WWgADzufmHmTdmMaVkOfDkFqpR71rbGEJ6GbnM74w9JTnj
         yr5PMM4avI4kR2QmQXwxm9hmq/mRQXzd7kE/WGhSG3qzKd+Zb6ajvrXEF86d2RInsE8O
         cCV3rmRQNoZXrmfQ5E9imjuRN7OuMC0qW9/9fbjuMnBRcyomXrAPyn1QxrRt8crYgVAm
         2O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001441; x=1691593441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r0GBXtQWMUWeqQq+M5AIorJEQ/4p4IESUvPrQzMKy+M=;
        b=heZFkNRUzlttkV1iz2Fr9BQDVVFQh3dbbuLwhvYkr0Cb2g6FVYQf7kguxkMOGEFql0
         j0yeVQV6DPWOK30yx3rJIhQcbhOd7StTqLq3SD8GXgwD6RL75yhsUzxpd6sNZn8CkAYS
         7dFA66FHcmykk2/Ignmy2LzpoQq/PplUziWCGF7Hc4j6fx06bXr7cDzeizb5R5BXPi76
         bz6mr/4Oh8+vVgj8gAub9yE76r71eIAyijlZe6xakKXpU0d3vanx1s/MedhQDJ/fJ8d8
         xbeliHHyvV34BuyhHjN3DXbuz/oj+JGjFf6JM+eV+Ig2cJMP2eFjHp0ElnQxUT+9SWvy
         kuqA==
X-Gm-Message-State: ABy/qLZuT/wLGkDw/RO+SM4dktEAT/0GwVWMaic179DEDsRItwELPXGx
        kTfQ/3pKr8VYNc3KrLgwvNQHEm1Mz7uUTRZnsSHKsA==
X-Google-Smtp-Source: APBJJlEJ+v7IyZNE4+O1DY+AP+nWBc1ijQcdBtFYtRjvRTYfVZL2z4RX3IQkK7LQvB90yqbgAv2UGG3DiZz3q0QuY0o=
X-Received: by 2002:a25:fe06:0:b0:c85:cab:30ad with SMTP id
 k6-20020a25fe06000000b00c850cab30admr2675569ybe.35.1689001441594; Mon, 10 Jul
 2023 08:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-7-quic_ipkumar@quicinc.com> <96e52c65-6216-91ba-8d2b-197f86433d98@linaro.org>
 <8661411f-ea47-2a7a-ceb4-6c37978c3a75@quicinc.com>
In-Reply-To: <8661411f-ea47-2a7a-ceb4-6c37978c3a75@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 10 Jul 2023 18:03:50 +0300
Message-ID: <CAA8EJpoTy5sxFpK8=KqmR5zjj_Kt18hX_CJqvQbxHDmBqmduGw@mail.gmail.com>
Subject: Re: [PATCH 6/6] thermal/drivers/tsens: Add IPQ5332 support
To:     Praveenkumar I <quic_ipkumar@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 10 Jul 2023 at 16:47, Praveenkumar I <quic_ipkumar@quicinc.com> wrote:
>
>
> On 7/10/2023 4:54 PM, Dmitry Baryshkov wrote:
> > On 10/07/2023 13:37, Praveenkumar I wrote:
> >> IPQ5332 uses tsens v2.3.3 IP and it is having combined interrupt as
> >> like IPQ8074. But as the SoCs does not have RPM, kernel needs to
> >> take care of sensor enablement and calibration. Hence introduced
> >> new ops and data for IPQ5332 and reused the feature_config from
> >> IPQ8074.
> >>
> >> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> >> ---
> >>   drivers/thermal/qcom/tsens-v2.c | 13 +++++++++++++
> >>   drivers/thermal/qcom/tsens.c    |  3 +++
> >>   drivers/thermal/qcom/tsens.h    |  2 +-
> >>   3 files changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/thermal/qcom/tsens-v2.c
> >> b/drivers/thermal/qcom/tsens-v2.c
> >> index db48b1d95348..8b6e3876fd2c 100644
> >> --- a/drivers/thermal/qcom/tsens-v2.c
> >> +++ b/drivers/thermal/qcom/tsens-v2.c
> >> @@ -237,6 +237,19 @@ struct tsens_plat_data data_ipq8074 = {
> >>       .fields    = tsens_v2_regfields,
> >>   };
> >>   +static const struct tsens_ops ops_ipq5332_v2 = {
> >
> > Please drop v2. It is unclear if it refers to tsens being v2 or being
> > specific to ipq5332 v2.
> Sure, will drop v2.
> >
> >> +    .init        = init_common,
> >> +    .get_temp    = get_temp_tsens_valid,
> >> +    .calibrate    = tsens_v2_calibration,
> >> +};
> >> +
> >> +struct tsens_plat_data data_ipq5332 = {
> >> +    .sensors_to_en    = 0xF800,
> >
> > This doesn't seem to match the offsets that you have enabled in the DTSI.
> In order to overcome the DT binding check failure, added all the
> available QFPROM offsets in the DTSI. Else DT binding check failing on
> "nvmem-cell-names".

This is not a way to overcome issues in DT bindings. Please fix DT
bindings instead by using alternatives, enums, etc.

> >
> >> +    .ops        = &ops_ipq5332_v2,
> >> +    .feat        = &ipq8074_feat,
> >> +    .fields        = tsens_v2_regfields,
> >> +};
> >> +
> >>   /* Kept around for backward compatibility with old msm8996.dtsi */
> >>   struct tsens_plat_data data_8996 = {
> >>       .num_sensors    = 13,
> >> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> >> index 169690355dad..e8ba2901cda8 100644
> >> --- a/drivers/thermal/qcom/tsens.c
> >> +++ b/drivers/thermal/qcom/tsens.c
> >> @@ -1140,6 +1140,9 @@ static const struct of_device_id tsens_table[] = {
> >>       }, {
> >>           .compatible = "qcom,ipq8074-tsens",
> >>           .data = &data_ipq8074,
> >> +    }, {
> >> +        .compatible = "qcom,ipq5332-tsens",
> >> +        .data = &data_ipq5332,
> >>       }, {
> >>           .compatible = "qcom,mdm9607-tsens",
> >>           .data = &data_9607,
> >> diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
> >> index f8897bc8944e..36040f9beebc 100644
> >> --- a/drivers/thermal/qcom/tsens.h
> >> +++ b/drivers/thermal/qcom/tsens.h
> >> @@ -701,6 +701,6 @@ extern struct tsens_plat_data data_8226,
> >> data_8909, data_8916, data_8939, data_8
> >>   extern struct tsens_plat_data data_tsens_v1, data_8976, data_8956;
> >>     /* TSENS v2 targets */
> >> -extern struct tsens_plat_data data_8996, data_ipq8074, data_tsens_v2;
> >> +extern struct tsens_plat_data data_8996, data_ipq8074, data_ipq5332,
> >> data_tsens_v2;
> >>     #endif /* __QCOM_TSENS_H__ */
> >
> --
> Thanks,
> Praveenkumar



-- 
With best wishes
Dmitry
