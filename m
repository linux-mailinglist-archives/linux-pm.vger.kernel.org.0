Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63C5B7AA8
	for <lists+linux-pm@lfdr.de>; Tue, 13 Sep 2022 21:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIMTTE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Sep 2022 15:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIMTTD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2022 15:19:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AAB6AA1F
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2022 12:19:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5076C61554
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2022 19:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF6DC433D7
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2022 19:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663096741;
        bh=dFfU93QgX3/XwwgLgngjJJh72IVzy8E8amu7kIfjONw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nQT/Edy+2WDgu+WENhwPzLPeumgFDURAThknFq1kvotQXnSYDeiZ2dE+oWTs8eBUD
         CeO7eKrkpCfvfpEcGWTnoWheu7p79cL63qCgyTMdic9juN1bbpecxlA8s3vKr5ugWL
         xJp1okHW+xD9dmZQe5eDPcX3UcWHfyZJGRXyF+XYRyaogX+N0I3nV6573aqSfYhkwk
         iPXwNlBFePlJd7xyV5h0a9OAsVkNEzQYaSqWAyHaEjjV4lgP3UU1RqOOABULLoFLix
         lhy+sIpZEbkACm/CynYfawh3Ckofy11VS+wscrgRl1J75YWn290mA+3G6gI18FGYfZ
         1ayBQPR/1PppQ==
Received: by mail-lf1-f45.google.com with SMTP id s6so10484871lfo.7
        for <linux-pm@vger.kernel.org>; Tue, 13 Sep 2022 12:19:01 -0700 (PDT)
X-Gm-Message-State: ACgBeo3N8qtRUxNu4ZkFloAVLQfsYrg3kxhY3d0tTr+BKpYnTHT5Ejqx
        JCqdTnjtSuQ2Ps/hLP5f6tnNamy25BZO1KT2u1x3yQ==
X-Google-Smtp-Source: AA6agR7ozGuytVn26t25xLvK0AxyvmgDxU5pQqGtKIKvsRDItnaRX6lbuoNCheQrcINvsVwIuRJNm8BDLRS+qhKObKU=
X-Received: by 2002:a05:6512:2207:b0:496:db23:c2a3 with SMTP id
 h7-20020a056512220700b00496db23c2a3mr10240081lfu.447.1663096739648; Tue, 13
 Sep 2022 12:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220910124701.4060321-1-dmitry.baryshkov@linaro.org> <20220910124701.4060321-3-dmitry.baryshkov@linaro.org>
In-Reply-To: <20220910124701.4060321-3-dmitry.baryshkov@linaro.org>
From:   Amit Kucheria <amitk@kernel.org>
Date:   Wed, 14 Sep 2022 00:48:48 +0530
X-Gmail-Original-Message-ID: <CAHLCerPhxGEUfpabu6dpnrkSL0Aab7qrthaffWn69Wz_z8aFDQ@mail.gmail.com>
Message-ID: <CAHLCerPhxGEUfpabu6dpnrkSL0Aab7qrthaffWn69Wz_z8aFDQ@mail.gmail.com>
Subject: Re: [RFC PATCH 02/10] thermal/drivers/tsens: Support using nvmem
 cells for calibration data
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

I like this clean up.

On Sat, Sep 10, 2022 at 6:17 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> Add a unified function using nvmem cells for parsing the calibration
> data rather than parsing the calibration blob manually.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 15 ++++++++
>  drivers/thermal/qcom/tsens-v1.c   |  6 ++-
>  drivers/thermal/qcom/tsens.c      | 62 +++++++++++++++++++++++++++++++
>  drivers/thermal/qcom/tsens.h      |  4 ++
>  4 files changed, 86 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
> index f136cb350238..2974eea578f4 100644
> --- a/drivers/thermal/qcom/tsens-v0_1.c
> +++ b/drivers/thermal/qcom/tsens-v0_1.c
> @@ -229,6 +229,11 @@ static int calibrate_8916(struct tsens_priv *priv)
>         u32 p1[5], p2[5];
>         int mode = 0;
>         u32 *qfprom_cdata, *qfprom_csel;
> +       int ret;
> +
> +       ret = tsens_calibrate_nvmem(priv, 3);
> +       if (!ret)
> +               return 0;
>
>         qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>         if (IS_ERR(qfprom_cdata))
> @@ -286,6 +291,11 @@ static int calibrate_8939(struct tsens_priv *priv)
>         int mode = 0;
>         u32 *qfprom_cdata;
>         u32 cdata[6];
> +       int ret;
> +
> +       ret = tsens_calibrate_nvmem(priv, 2);
> +       if (!ret)
> +               return 0;
>
>         qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>         if (IS_ERR(qfprom_cdata))
> @@ -491,6 +501,11 @@ static int calibrate_9607(struct tsens_priv *priv)
>         u32 p1[5], p2[5];
>         int mode = 0;
>         u32 *qfprom_cdata;
> +       int ret;
> +
> +       ret = tsens_calibrate_nvmem(priv, 2);
> +       if (!ret)
> +               return 0;
>
>         qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>         if (IS_ERR(qfprom_cdata))
> diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
> index 573e261ccca7..868d7b4c9e36 100644
> --- a/drivers/thermal/qcom/tsens-v1.c
> +++ b/drivers/thermal/qcom/tsens-v1.c
> @@ -172,7 +172,11 @@ static int calibrate_v1(struct tsens_priv *priv)
>         u32 p1[10], p2[10];
>         u32 mode = 0, lsb = 0, msb = 0;
>         u32 *qfprom_cdata;
> -       int i;
> +       int i, ret;
> +
> +       ret = tsens_calibrate_nvmem(priv, 2);
> +       if (!ret)
> +               return 0;
>
>         qfprom_cdata = (u32 *)qfprom_read(priv->dev, "calib");
>         if (IS_ERR(qfprom_cdata))
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index e49f58e83513..8331b924325a 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -70,6 +70,68 @@ char *qfprom_read(struct device *dev, const char *cname)
>         return ret;
>  }
>
> +int tsens_calibrate_nvmem(struct tsens_priv *priv, int shift)
> +{
> +       u32 mode;
> +       u32 base1, base2;
> +       u32 p1[MAX_SENSORS], p2[MAX_SENSORS];
> +       char name[] = "sX_pY";
> +       int i, ret;
> +
> +       if (priv->num_sensors > MAX_SENSORS)
> +               return -EINVAL;
> +
> +       ret = nvmem_cell_read_variable_le_u32(priv->dev, "mode", &mode);
> +       if (ret == -ENOENT)
> +               dev_warn(priv->dev, "Please migrate to sepate nvmem cells for calibration data\n");

typo: separate

> +       if (ret < 0)
> +               return ret;
> +
> +       dev_dbg(priv->dev, "calibration mode is %d\n", mode);
> +
> +       ret = nvmem_cell_read_variable_le_u32(priv->dev, "base1", &base1);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret = nvmem_cell_read_variable_le_u32(priv->dev, "base2", &base2);
> +       if (ret < 0)
> +               return ret;
> +
> +       for (i = 0; i < priv->num_sensors; i++) {
> +               ret = snprintf(name, sizeof(name), "s%d_p1", i);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p1[i]);
> +               if (ret)
> +                       return ret;
> +
> +               p1[i] = (base1 + p1[i]) << shift;
> +
> +               ret = snprintf(name, sizeof(name), "s%d_p2", i);
> +               if (ret < 0)
> +                       return ret;
> +
> +               ret = nvmem_cell_read_variable_le_u32(priv->dev, name, &p2[i]);
> +               if (ret)
> +                       return ret;
> +
> +               p2[i] = (base2 + p2[i]) << shift;

Have you verified that the p1 and p2 arrays end up with identical
values before and after this conversion?


> +       }
> +
> +       if (mode == NO_PT_CALIB) {
> +               dev_dbg(priv->dev, "calibrationless mode\n");
> +               for (i = 0; i < priv->num_sensors; i++) {
> +                       p1[i] = 500;
> +                       p2[i] = 780;
> +               }
> +       }
> +
> +       compute_intercept_slope(priv, p1, p2, mode);
> +
> +       return 0;
> +}
> +
>  /*
