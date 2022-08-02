Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3905877AF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Aug 2022 09:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiHBHRX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Aug 2022 03:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235784AbiHBHRV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Aug 2022 03:17:21 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC2449B5E
        for <linux-pm@vger.kernel.org>; Tue,  2 Aug 2022 00:17:20 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y9so9719259qtv.5
        for <linux-pm@vger.kernel.org>; Tue, 02 Aug 2022 00:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=bL6fGScq+yhoKFMlnh6d0gxqoohgKkceu0Z+UVQzyQI=;
        b=RcIOpJJ0Ov5o4fHdrPK1zfrXJX6gdPFzu7fjwuuUjXM6UHBZyGruAo4zx7iEo477RD
         Fp4PVSRuVwiRll7m1oVNQrgPxvrYz3awbWW7JV8FAoP6ENu1uux5Q5wq/CSFU9COSbdY
         yd6A0uqiEvPxRvSttO9SFeT73/nDoFT0jIVbJXgwqetOUrapXbl8kWmYRLLjXaCVKKvT
         PXNdJ7RGAsU6C5mOPZ076oZabnIasPRsJts5TmEhMIHgfutaqLl1x3vF0LHCdEXA72EA
         5WcDgdW0Rj7KiTODrCDuU6Zh+yUKhdkUUXTNHeNT6SDa9Er0lLYq63Ruiq+b6AGe1jGS
         93Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=bL6fGScq+yhoKFMlnh6d0gxqoohgKkceu0Z+UVQzyQI=;
        b=DhH+MzeIQqwc9nx5ou4UGDxnekQptSDe1M1KP68Tg1D75e3RGj5hogAUZzR4S08Ggy
         YVxnB+ls5grrZvjjna0XIBagbnZ5FmGTx9w/iGOFPwF0hSapjtjzO6w/6h5xBEm1yMO1
         E598iylb4TR1WU8RDRv8Npplyx6NntMCvpiVFPoioc4ojbkROsxjGZrudeIMXWFh7um2
         ahn98mgZ6oIXJ4JhKBiI7K9323vWDC00jghMb0+G1CnlZNqOVG4LaurOJnn8vu61fYOm
         hcpMhF1Em9bkogJOj+6Unix6LERhG8Ky1F2TZ2O4ToqlG4MiXM75GkdyFnzzWcKzn99s
         LlsQ==
X-Gm-Message-State: AJIora8FMzWKiSf2ezA9PvGIeFqoDHFaGA5A1pE1aL9VBsWO448wJM4D
        9wf6TurvcxcB19f4hCKtqo0GOZCSB7fZDTg/DqjlgA==
X-Google-Smtp-Source: AGRyM1ujC1egqaRzzJh0wgVInw8CjeH7Adwmb22QYBOfvTBE0sjoUrTqJEXPccOS4SayDbm/OEgA5ksInidWTbnis8w=
X-Received: by 2002:ac8:5942:0:b0:31f:39f6:aba7 with SMTP id
 2-20020ac85942000000b0031f39f6aba7mr16851230qtz.295.1659424639554; Tue, 02
 Aug 2022 00:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220801212244.1124867-1-daniel.lezcano@linexp.org> <20220801212244.1124867-12-daniel.lezcano@linexp.org>
In-Reply-To: <20220801212244.1124867-12-daniel.lezcano@linexp.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 2 Aug 2022 10:17:08 +0300
Message-ID: <CAA8EJpqS9_VUfX23j2BdUUxT=5=ig1k5ycKhiHy0xW+2zO05=Q@mail.gmail.com>
Subject: Re: [PATCH v4 11/32] thermal/drivers/qcom: Switch to new of API
To:     Daniel Lezcano <daniel.lezcano@linexp.org>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, abailon@baylibre.com, lukasz.luba@arm.com,
        broonie@kernel.org, damien.lemoal@opensource.wdc.com,
        heiko@sntech.de, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org, talel@amazon.com, thierry.reding@gmail.com,
        digetx@gmail.com, jonathanh@nvidia.com, anarsoul@gmail.com,
        tiny.windzz@gmail.com, baolin.wang7@gmail.com,
        f.fainelli@gmail.com, bjorn.andersson@linaro.org,
        mcoquelin.stm32@gmail.com, glaroque@baylibre.com,
        miquel.raynal@bootlin.com, shawnguo@kernel.org,
        niklas.soderlund@ragnatech.se, matthias.bgg@gmail.com,
        j-keerthy@ti.com, Andy Gross <agross@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 2 Aug 2022 at 00:24, Daniel Lezcano <daniel.lezcano@linexp.org> wrote:
>
> The thermal OF code has a new API allowing to migrate the OF
> initialization to a simpler approach. The ops are no longer device
> tree specific and are the generic ones provided by the core code.
>
> Convert the ops to the thermal_zone_device_ops format and use the new
> API to register the thermal zone with these generic ops.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linexp.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 19 +++++++++----------
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 12 ++++++------
>  drivers/thermal/qcom/tsens.c                | 16 ++++++++--------
>  3 files changed, 23 insertions(+), 24 deletions(-)

-- 
With best wishes
Dmitry
