Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13FB7978A3
	for <lists+linux-pm@lfdr.de>; Thu,  7 Sep 2023 18:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243993AbjIGQu6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Sep 2023 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244043AbjIGQu5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Sep 2023 12:50:57 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5E010FC
        for <linux-pm@vger.kernel.org>; Thu,  7 Sep 2023 09:50:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1c8c44053e8so591135fac.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Sep 2023 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694105333; x=1694710133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9kunx9UxE5AO8Mpt3OIBGhm0UdSfJDTNTDmm1Ca6qzg=;
        b=wW9SZKu0c2965d2Hj0ne71bCYJAWi4DXDyGklyOEkJACnqofxGN+RRDJkHfaKHFnYE
         SXBurYqwDVacrWaurjgeK+KIW03EHdfM8NJyDO+jywm3F5oLu7l432D31t5s37h+egwU
         py5eCQwwG7yfuSc+6vJcEU2xnfNadV8usthH2fRL1AmbBxxZqLodJUWqaCY1AhN267aZ
         G5ocRo207KXu9rPpx4jAGWSuaDRHim5UWBTsxwc8nI2QxVuJo67lUK5ATJAw3IRgRBal
         N95S2rM/wb2kca5hab9RL6HbDb8Ho9XQmHYvb4gbU0uF3nSZ3TguJkvptGXxgUeDPgHw
         IrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105333; x=1694710133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9kunx9UxE5AO8Mpt3OIBGhm0UdSfJDTNTDmm1Ca6qzg=;
        b=FCcwRVIi54G98tL85tUm9mydARu7mFXVbnxS0t9vT9lGPDN2GtKfOAOzzFZbtc11Gs
         LamywSCceVIWq077E59JHfXZaCQ+KQRr6OKNjj9eBtuQzZajElLBqNYYAO9PzmBeD72B
         JFSs1wJWctIAH43e75ggBPrYjTabnGOAHushEYy7VwstZYgSFPnut7JFs/keJXkamhJ3
         0P0fKf5b8MeEjZ6ZRq8EArggg0mC01h4ty1kiU33qej2jLPJwKdEUC5UvTlKLChjzpo7
         tHuNkDRfdAxPAjTcjMJorv0vZMCMpOwgnBIBWpe8EJw5/pRiYbueA715aDG9MsuYvZww
         jg7g==
X-Gm-Message-State: AOJu0Yw3xGq2qJEMOgCtzWqkwciszPGKHPXX3XlHPVnme2SlYCcbmq6u
        4MUMAJAJTX84RL2Oy30+IUy4EflEdwCEC044PM5pL5OjgNeY/ZzY
X-Google-Smtp-Source: AGHT+IGWwMUs+woCpFuAAwk4rYJhGtyUArweMKLG0DdWWNZXHEqnr826vQ2pJOiYkeGxQTvNpSH7Tmuy50h8QS8fgX8=
X-Received: by 2002:a5b:f11:0:b0:d80:12f5:cd4d with SMTP id
 x17-20020a5b0f11000000b00d8012f5cd4dmr156584ybr.18.1694095179083; Thu, 07 Sep
 2023 06:59:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693996662.git.quic_varada@quicinc.com> <a6d12e3b253d6a55d85f66979ba8b7d9c9ff6072.1693996662.git.quic_varada@quicinc.com>
In-Reply-To: <a6d12e3b253d6a55d85f66979ba8b7d9c9ff6072.1693996662.git.quic_varada@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Sep 2023 16:59:28 +0300
Message-ID: <CAA8EJppNsgUNgwadq9oM0_KyORNR5PBZGVZukN6MzAm2KPzC9g@mail.gmail.com>
Subject: Re: [PATCH v1 07/10] arm64: dts: qcom: ipq5332: populate the opp
 table based on the eFuse
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 7 Sept 2023 at 08:23, Varadarajan Narayanan
<quic_varada@quicinc.com> wrote:
>
> IPQ53xx have different OPPs available for the CPU based on
> SoC variant. This can be determined through use of an eFuse
> register present in the silicon.
>
> Add support to read the eFuse and populate the OPPs based on it.
>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> index 82761ae..3ca3f34 100644
> --- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -91,11 +91,34 @@
>         };
>
>         cpu_opp_table: opp-table-cpu {
> -               compatible = "operating-points-v2";
> +               compatible = "operating-points-v2-kryo-cpu";
>                 opp-shared;
> +               nvmem-cells = <&cpu_speed_bin>;
> +               nvmem-cell-names = "speed_bin";
> +
> +               /*
> +                * Listed all supported CPU frequencies and opp-supported-hw
> +                * values to select CPU frequencies based on the limits fused.
> +                * ------------------------------------------------------------
> +                * Frequency     BIT3   BIT2   BIT1    BIT0    opp-supported-hw
> +                *              1.0GHz 1.2GHz 1.5GHz No Limit
> +                * ------------------------------------------------------------
> +                * 1100000000     1      1      1       1            0xF
> +                * 1500000000     0      0      1       1            0x3
> +                * -----------------------------------------------------------
> +                */

This can probably go to the commit message instead.

> +
> +               opp-1100000000 {
> +                       opp-hz = /bits/ 64 <1100000000>;

But your table shows 1.0 GHz and 1.2 GHz instead of 1.1 GHz

> +                       opp-microvolt = <850000>;
> +                       opp-supported-hw = <0xF>;
> +                       clock-latency-ns = <200000>;
> +               };
>
> -               opp-1488000000 {
> -                       opp-hz = /bits/ 64 <1488000000>;
> +               opp-1500000000 {
> +                       opp-hz = /bits/ 64 <1500000000>;

So, 1.488 GHz or 1.5 GHz?

> +                       opp-microvolt = <950000>;

Which regulator is controlled by this microvolt?

> +                       opp-supported-hw = <0x3>;
>                         clock-latency-ns = <200000>;
>                 };
>         };
> @@ -150,6 +173,11 @@
>                         reg = <0x000a4000 0x721>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
> +
> +                       cpu_speed_bin: cpu_speed_bin@1d {
> +                               reg = <0x1d 0x2>;
> +                               bits = <7 2>;
> +                       };
>                 };
>
>                 rng: rng@e3000 {
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
