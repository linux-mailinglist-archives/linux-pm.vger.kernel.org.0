Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A6B4A0393
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jan 2022 23:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241715AbiA1WYT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Jan 2022 17:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346551AbiA1WYP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Jan 2022 17:24:15 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4EBC061751
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 14:24:14 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id e16so6450293qtq.6
        for <linux-pm@vger.kernel.org>; Fri, 28 Jan 2022 14:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vf877r/66ZQ/GNJScldomlsixS79+DCD1DtadcpCLxU=;
        b=dKpq4srguyxEDrXqfxlAdpj/afmWItoVpfbCxNtNH0MJuCDw7Z624vlS+CvJSftmUN
         vMlaH7Qv1EnOqTYD9kfFlTSUGM/konNCLMDqxfXPqkpYyfdpa9ubZVveCu/t5LhsAlpj
         WX19wIeuN90wn+q4k4Cjf849Tnvke6PWKAozN4gMHr7Zdt1GVl2aXfHCQ0LmRmCeVhOf
         hkcUTlh4DbVXPm/cPXMoRf+yOePJf2c59IgUKVT/HsaaMIkvFKicpkO3Dkh3Z8QlZyp/
         iP8p2qRlr2ojqipTIgUUw4uWZ2l8e7+DtVLUnXR4MAXC312UcHWCgd38SuuLoM/E5Gya
         risg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vf877r/66ZQ/GNJScldomlsixS79+DCD1DtadcpCLxU=;
        b=LmBs79Xk80qAgEEdPo9r6ESYCKmzeblGmQW7GaogMm/jnFzHuUCBXwTaWcfPOelqj1
         s0VMTskzcjf6MkPILAlbftQCytuS96mPZBywTvrHCfq+tef4ajkr/4I4X+kgZNVcsIR1
         WDxQrMxp90YUgXHKGcWumMfMkKpZ9PVJ3CzrI0uP5futuD8R5QWbPu9jHSfkRNIO7USM
         5pfiHXX357L8IuS1axmJUONsCc06oycYtE9TGlDP/TVWjauFcSTouRVfIV03pjXRZrnT
         BmOXBx579nSZfwW+58bvJ+FWldz0fjr3E+FlfJ2oDrltOM3OydOniq19xxVWdrdwqmpM
         Gqvw==
X-Gm-Message-State: AOAM530TPn7igyBm7C90YjMr91BFvi5R4ZoFsgr7nqmTEry6RzDNsh76
        qDNMlYkwgIsc0zUMK68Q1XXbONJVa6a0R40Mb4UA5w==
X-Google-Smtp-Source: ABdhPJysrYwC7ZB4aKNk/f/30Jh+oKG90RogI9mBmSHTs4BO5R0iUJP91CXBvpfgvqC19obbEOXOj3PTQuLJl4jVzkM=
X-Received: by 2002:a05:622a:164a:: with SMTP id y10mr7777176qtj.629.1643408653707;
 Fri, 28 Jan 2022 14:24:13 -0800 (PST)
MIME-Version: 1.0
References: <20220128161002.2308563-1-bryan.odonoghue@linaro.org> <20220128161002.2308563-3-bryan.odonoghue@linaro.org>
In-Reply-To: <20220128161002.2308563-3-bryan.odonoghue@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 29 Jan 2022 01:24:02 +0300
Message-ID: <CAA8EJpqvDqTH3+ATsdC2pwtfT-OWpLNSUgOPmeU_Tpu8Uqa1+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] interconnect: qcom: msm8939: Merge snoc and snoc_mm
 into one
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     djakov@kernel.org, bjorn.andersson@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        jun.nie@linaro.org, shawn.guo@linaro.org, benl@squareup.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 28 Jan 2022 at 19:10, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> The current msm8939 snoc and snoc_mm definitions are represented as
> separate entities based on downstream definition which declares two
> identical and therefore overlapping mmio regions.
>
> Downstream:
> reg = <0x580000 0x14080>,
>       <0x580000 0x14080>;
> reg-names = "snoc-base", "snoc-mm-base";
>
> Upstream:
> snoc: interconnect@580000 {
>         compatible = "qcom,msm8939-snoc";
>         #interconnect-cells = <1>;
>         reg = <0x580000 0x14080>;
>         clock-names = "bus", "bus_a";
>         clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
>                  <&rpmcc RPM_SMD_SNOC_A_CLK>;
>         status = "okay";
> };
>
> snoc: interconnect@580000 {
>         compatible = "qcom,msm8939-snoc_mm";
>         #interconnect-cells = <1>;
>         reg = <0x580000 0x14080>;
>         clock-names = "bus", "bus_a",
>         clocks = <&rpmcc RPM_SMD_SYSMMNOC_CLK>,
>                  <&rpmcc RPM_SMD_SYSMMNOC_A_CLK>;
>         status = "okay";
> };
>
> This overlapping declaration leads to the following failure on boot.
>
> [    1.212340] qnoc-msm8939 580000.interconnect_mm: can't request region for resource [mem 0x00580000-0x0059407f]
> [    1.212391] qnoc-msm8939 580000.interconnect_mm: Cannot ioremap interconnect bus resource
> [    1.221524] qnoc-msm8939: probe of 580000.interconnect_mm failed with error -16
>
> snoc_mm is a complete misnomer though, as there is no distinct register
> space, simply an additional clock to drive higher frequences on snoc for
> new multi-media 'mm' devices tacked on to the old msm8916 snoc.
>
> The difference can be captured with
>
> - A new clock
> - Performance points/clock settings in the relevant multi-media devices.
>
> Fix the above bug by representing snoc_mm as two new clocks to the existing
> snoc, not a separate interconnect bus.

This would lead to higher frequencies being set on both 'normal' and
mm snoc clocks, thus (possibly) increasing power consumption.

The proper fix should be implemented following patches 4 and 5 from
https://lore.kernel.org/all/20211215002324.1727-1-shawn.guo@linaro.org/

>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/interconnect/qcom/msm8939.c | 30 +++++------------------------
>  1 file changed, 5 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/msm8939.c b/drivers/interconnect/qcom/msm8939.c
> index d188f3636e4c3..7030911e25adc 100644
> --- a/drivers/interconnect/qcom/msm8939.c
> +++ b/drivers/interconnect/qcom/msm8939.c
> @@ -1271,25 +1271,6 @@ static struct qcom_icc_node *msm8939_snoc_nodes[] = {
>         [SNOC_INT_BIMC] = &snoc_int_bimc,
>         [SNOC_PCNOC_MAS] = &snoc_pcnoc_mas,
>         [SNOC_QDSS_INT] = &qdss_int,
> -};
> -
> -static const struct regmap_config msm8939_snoc_regmap_config = {
> -       .reg_bits       = 32,
> -       .reg_stride     = 4,
> -       .val_bits       = 32,
> -       .max_register   = 0x14080,
> -       .fast_io        = true,
> -};
> -
> -static struct qcom_icc_desc msm8939_snoc = {
> -       .type = QCOM_ICC_NOC,
> -       .nodes = msm8939_snoc_nodes,
> -       .num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
> -       .regmap_cfg = &msm8939_snoc_regmap_config,
> -       .qos_offset = 0x7000,
> -};
> -
> -static struct qcom_icc_node *msm8939_snoc_mm_nodes[] = {
>         [MASTER_VIDEO_P0] = &mas_video,
>         [MASTER_JPEG] = &mas_jpeg,
>         [MASTER_VFE] = &mas_vfe,
> @@ -1301,7 +1282,7 @@ static struct qcom_icc_node *msm8939_snoc_mm_nodes[] = {
>         [SNOC_MM_INT_2] = &mm_int_2,
>  };
>
> -static const struct regmap_config msm8939_snoc_mm_regmap_config = {
> +static const struct regmap_config msm8939_snoc_regmap_config = {
>         .reg_bits       = 32,
>         .reg_stride     = 4,
>         .val_bits       = 32,
> @@ -1309,11 +1290,11 @@ static const struct regmap_config msm8939_snoc_mm_regmap_config = {
>         .fast_io        = true,
>  };
>
> -static struct qcom_icc_desc msm8939_snoc_mm = {
> +static struct qcom_icc_desc msm8939_snoc = {
>         .type = QCOM_ICC_NOC,
> -       .nodes = msm8939_snoc_mm_nodes,
> -       .num_nodes = ARRAY_SIZE(msm8939_snoc_mm_nodes),
> -       .regmap_cfg = &msm8939_snoc_mm_regmap_config,
> +       .nodes = msm8939_snoc_nodes,
> +       .num_nodes = ARRAY_SIZE(msm8939_snoc_nodes),
> +       .regmap_cfg = &msm8939_snoc_regmap_config,
>         .qos_offset = 0x7000,
>  };
>
> @@ -1420,7 +1401,6 @@ static const struct of_device_id msm8939_noc_of_match[] = {
>         { .compatible = "qcom,msm8939-bimc", .data = &msm8939_bimc },
>         { .compatible = "qcom,msm8939-pcnoc", .data = &msm8939_pcnoc },
>         { .compatible = "qcom,msm8939-snoc", .data = &msm8939_snoc },
> -       { .compatible = "qcom,msm8939-snoc-mm", .data = &msm8939_snoc_mm },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, msm8939_noc_of_match);
> --
> 2.33.0
>


-- 
With best wishes
Dmitry
