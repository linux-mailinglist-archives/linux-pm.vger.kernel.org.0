Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082DC5B50E9
	for <lists+linux-pm@lfdr.de>; Sun, 11 Sep 2022 21:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiIKTiQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Sep 2022 15:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIKTiO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Sep 2022 15:38:14 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817262559B
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 12:38:13 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id e187so3682798ybh.10
        for <linux-pm@vger.kernel.org>; Sun, 11 Sep 2022 12:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1dxPFuoZb5aH59CH/RNQPIdQnA2zkRqb/UOcN8z0+n0=;
        b=YbdV+6YL696X+zL86zU4hebnQHIWAFEQAnhXY9bm3N1gfxUbdTufDngXzAPHERyMdW
         y5S5PSdkkCue9qZ8piXqwFLO8j5+l5E9xglmbWWCTQehTBdvTrijq2Dw81C9CgrdFusJ
         7Lem/zEdy31n3KpgLXFmNgYtlguphFK7tMwtrta5uEUIBIYyX/Nv2gN+hawuLHXGOZ6E
         jndZTbDGLp5TV7arJ1lwdq3NHqP44qWLUIj2zL+YTMns6RIMCdVrYLRyGkofcnhfmUiT
         ZwFWmuhOxLlax6QM4trZ4VQhEpfxoVNU/UXFFUAZ9jy4fT6ImpLCFoEeMuXzdgtp3gJ4
         rfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1dxPFuoZb5aH59CH/RNQPIdQnA2zkRqb/UOcN8z0+n0=;
        b=2Vj3bKoAtbe0XKpldYRwGwKID8CS7QKmMg4jc1X2Sx0EoWjFo95YMWGKKJ/cHtLfNd
         QiO0urE7GNEa/pgNjc287Q5bunlLU/fLpeEQm3SSFqusCu4ndo9zjQXWDFwPO/oJInfl
         Misk5o9lzecBxy/72yfUZ5JcuxjZJ9kQfAQ/q5uyS3Jo+Hum0KBUsb8utZha5jOcrFIB
         Tm/Jzkb9r5LVELbexHCrQW+J26ZsK1IqWx6r3n5AdL9TdguMQr9ynXYXvO/jsSOml2lf
         UbwOx3U9WILdCwmmSt0tm1OSqJJmLk8GXCDv/FGACXi2eS0zvBnQXThgq6rvXCPWaz0N
         hM2A==
X-Gm-Message-State: ACgBeo1ar+1zv/j8zcP5sx6JIdyQQ9thlEULSrB6YoSDQ0zL5wJ+Vvv6
        793QYIn7FGjVnQ5FRUfSqRygR4MBJGMmP8xG825qRzuRyac=
X-Google-Smtp-Source: AA6agR6rIf0HzkxEI7Fln+9qNDaMEovEYzP+royp5piUZViNF8B5COjdlju11BLfDljd/D/QCdBIHO9ANrpIzwNyGjU=
X-Received: by 2002:a25:81cf:0:b0:6a9:4d0d:5ee6 with SMTP id
 n15-20020a2581cf000000b006a94d0d5ee6mr19858891ybm.153.1662925092714; Sun, 11
 Sep 2022 12:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220911184232.3198957-1-bhupesh.sharma@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 11 Sep 2022 22:38:01 +0300
Message-ID: <CAA8EJpoM5nW=pVJB4zy4Jh9Q3gE4KOju2QVy_WtmUokKMyXtuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] thermal: Introduce CONFIG_QCOM_THERMAL in Makefile
 and qcom/Kconfig
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, andersson@kernel.org,
        linux-arm-msm@vger.kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 11 Sept 2022 at 21:42, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> Introduce CONFIG_QCOM_THERMAL to allow better control
> over selection of various Qualcomm Thermal drivers
> available inside qcom/ directory.
>
> This is a preparatory change to allow new drivers to
> be added inside qcom/ directory in a more structured
> fashion.
>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Amit Kucheria <amitk@kernel.org>
> Cc: Thara Gopinath <thara.gopinath@gmail.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/thermal/Makefile     |  2 +-
>  drivers/thermal/qcom/Kconfig | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index def8e1a0399c..a12b647be0d1 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -52,7 +52,7 @@ obj-$(CONFIG_DA9062_THERMAL)  += da9062-thermal.o
>  obj-y                          += intel/
>  obj-$(CONFIG_TI_SOC_THERMAL)   += ti-soc-thermal/
>  obj-y                          += st/
> -obj-$(CONFIG_QCOM_TSENS)       += qcom/
> +obj-$(CONFIG_QCOM_THERMAL)     += qcom/

Following other platforms around qcom, I think just `obj-y += qcom/`
would work well enough.

>  obj-y                          += tegra/
>  obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)      += mtk_thermal.o

-- 
With best wishes
Dmitry
