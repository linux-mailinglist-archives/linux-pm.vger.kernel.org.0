Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB7B752936
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 18:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbjGMQ41 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 12:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbjGMQ41 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 12:56:27 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9FB2706
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 09:56:25 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5701e8f2b79so8815167b3.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 09:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689267384; x=1689872184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lwu1I3VpHiRFp8zypeMBICpm5L6K6gQ6kqfkIVHdvMc=;
        b=zFWNwpn2GNJcLzXXrGrWS9AKcJ0DImSUU6+KRjzpFMbDaeYobKGiU7x9m8EJalI2tp
         zsjvwBdbBi20McV5zc4GtM4zHzLEEH4x3AQaoj1rXZYA0lNRIT/0vu0EJIrgUZQe6DEM
         umfVTs0yWF3sKmpfy0F949JSI3lHq9olo2SaHYWxzOV6hTLIrlKT9w31wlVqJ93dH4aL
         5dQCsQFdDfcyzUh4oTIir9yZcG9y1wmgeD95vkLqz5WMOgsuF95L7rpnITMIiyTwDbyR
         ibh/4EY5usxLdaH6e5qFF0qnBNl8epNwGqFcI+9hqSrs26OZ4tXumjJnlBql/F3Fb588
         4jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267384; x=1689872184;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lwu1I3VpHiRFp8zypeMBICpm5L6K6gQ6kqfkIVHdvMc=;
        b=Qm8Vadw/vHdQlRFuUKPLMqiuuK2d8+Tev+8Z96rt6yuTPbMxZPtPnycGs2Ny/xkA9G
         +oFh9kXl4h805pt5Is5C9FNuur9iY5eTvOah3obL/fTt1V19k1h+f/r6bOksCk+vyQvv
         lKUgisUTs0owfeYGKWsV3fZNIylUD3xVsNQEKpvSP88Ji5Zgg1U5wbkZ+Qv2/Vs3SIMq
         7wixyNptrhNi223vaNDWQhiqtgP+WSwlqKlPu/mpoqfv8jeZvI2buC4YEd1j4W1hFPSu
         /JYko1vLAAvBcMu/YEyE2HcJN6/cA1Kt44ivrBQDAg6fU7LZNfQNxqIoxS8HM/GZqmd8
         pnxg==
X-Gm-Message-State: ABy/qLaaZY3Qih5uUw1fNnStIirSLPQxE0BXL0duJvB//IgsDMTRTdD5
        aJufWoHBRxc4972ndsjxCie13CKaAMC7GqB39EsVFw==
X-Google-Smtp-Source: APBJJlHFuWHcG2GjrDr+7bUaz9zLs92AKucVrz6y9P6Pk+I/TSja5Xolg1JP919CvK1l2ynUnRyEqopef1QS+eiVU1I=
X-Received: by 2002:a25:32d8:0:b0:ba7:7664:916b with SMTP id
 y207-20020a2532d8000000b00ba77664916bmr1776961yby.20.1689267384460; Thu, 13
 Jul 2023 09:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230713160415.149381-1-minhuadotchen@gmail.com>
In-Reply-To: <20230713160415.149381-1-minhuadotchen@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 13 Jul 2023 19:56:13 +0300
Message-ID: <CAA8EJporcTpZVvX-Ox2cHCnsZ3JEH_9SF_U2o85z-88jZ+rG-Q@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/tsens: make tsens_xxxx_nvmem static
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 13 Jul 2023 at 19:04, Min-Hua Chen <minhuadotchen@gmail.com> wrote:
>
> This patch fixes the following sparse warnings:
>
> drivers/thermal/qcom/tsens-v1.c:24:40: sparse: warning: symbol 'tsens_qcs404_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:26:40: sparse: warning: symbol 'tsens_8916_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:42:40: sparse: warning: symbol 'tsens_8974_nvmem' was not declared. Should it be static?
> drivers/thermal/qcom/tsens-v0_1.c:64:40: sparse: warning: symbol 'tsens_8974_backup_nvmem' was not declared. Should it be static?
>
> No functional change intended.
>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/thermal/qcom/tsens-v0_1.c | 6 +++---
>  drivers/thermal/qcom/tsens-v1.c   | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)



-- 
With best wishes
Dmitry
