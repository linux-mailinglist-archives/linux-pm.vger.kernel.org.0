Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53555500062
	for <lists+linux-pm@lfdr.de>; Wed, 13 Apr 2022 22:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiDMU6f (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Apr 2022 16:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbiDMU6e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Apr 2022 16:58:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAC672467
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 13:56:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bh17so6372570ejb.8
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 13:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGJeViK+7nvO370X+XWsM6u8Nu1Bs+YHak1Y1XG2ND4=;
        b=Nmnntj/LVIwy3oeOLpeN9QoktVn4Gy5cYRHXFCyvkB7XueSKlPJszbhcdG9U78y2ad
         u8YKGSNTvuIK1Qs6RbcqVntnhyfwD1HecmNzit4QEsVJrFYQOt1JO7DP2DBYKh7p/2KM
         tIkfENteINhIIpwXj6yI7S3FGN7rNsZJLO5rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGJeViK+7nvO370X+XWsM6u8Nu1Bs+YHak1Y1XG2ND4=;
        b=h7WRF1SPuTsDTE8wX+d3t0IIZzABoCs0MOV8rt7z7dJOW2g2gO/7R/z/j77mXMC+MK
         rMhzLG1XeFXBWuB4uSbMdAKFjL7XTy1JEKMw1tGZFHRGCAvWNYDKUdMh6rXCE5K8SRfk
         LvgdQqu8zI/IipM7ox+oxKF9Uef682hFKS4Ghw/UOiawCeDZRc/GSywwX0km17SNk6m/
         bli0DvNe3Tjb9/yQ/9OknQAhBv7i9nI9SaiQtMmWxMNO01YBv1FqYxLmKyGDgOqsSBWt
         gRBb1ko+wtuTea7fB/Wc16F95cHsR/s3iEbSmeZA23EAbZntNW5Ui0iv7hohLFNJx5GC
         GOew==
X-Gm-Message-State: AOAM530SM1xpsmLZU925O84k6yBW0XJ4IGBB7/buZ4CgWJ35rEAKYrGx
        gHsQICAisPb2NgBMXRNXxwCnYMyv87KfSAOB
X-Google-Smtp-Source: ABdhPJywtmSPIPqGWOvAaX9t7yLhFJ35hWZkQwc2YU3x0gQYIg7M+RZiQ4OfRoYpmIb2WTOnQCL7Lg==
X-Received: by 2002:a17:907:2d27:b0:6e8:3ea6:7645 with SMTP id gs39-20020a1709072d2700b006e83ea67645mr30114357ejc.727.1649883371005;
        Wed, 13 Apr 2022 13:56:11 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709060f4700b006e8d0746969sm2133ejj.222.2022.04.13.13.56.09
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 13:56:09 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id g18so4308797wrb.10
        for <linux-pm@vger.kernel.org>; Wed, 13 Apr 2022 13:56:09 -0700 (PDT)
X-Received: by 2002:a5d:64ce:0:b0:208:fff6:22cb with SMTP id
 f14-20020a5d64ce000000b00208fff622cbmr89950wri.301.1649883368489; Wed, 13 Apr
 2022 13:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220412220033.1273607-1-swboyd@chromium.org> <20220412220033.1273607-2-swboyd@chromium.org>
In-Reply-To: <20220412220033.1273607-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Apr 2022 13:55:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFbOhs0ggxDbVwKM_8x=ELT85zFd-Wk6dJ_M+Awz+Pxw@mail.gmail.com>
Message-ID: <CAD=FV=UFbOhs0ggxDbVwKM_8x=ELT85zFd-Wk6dJ_M+Awz+Pxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] interconnect: qcom: sc7180: Drop IP0 interconnects
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Mike Tipton <quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

On Tue, Apr 12, 2022 at 4:20 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> @@ -519,8 +500,6 @@ static const struct of_device_id qnoc_of_match[] = {
>           .data = &sc7180_dc_noc},
>         { .compatible = "qcom,sc7180-gem-noc",
>           .data = &sc7180_gem_noc},
> -       { .compatible = "qcom,sc7180-ipa-virt",
> -         .data = &sc7180_ipa_virt},
>         { .compatible = "qcom,sc7180-mc-virt",
>           .data = &sc7180_mc_virt},
>         { .compatible = "qcom,sc7180-mmss-noc",

I have no objection to ${SUBJECT} change landing and based on all your
research and Alex's review/testing I think it's good to go.

However, now that you're removed the driver that cared about
"qcom,sc7180-ipa-virt", should we also be removing it from the
`bindings/interconnect/qcom,rpmh.yaml` file and the `sc7180.dtsi`
file? I think that removing it from _either_ the driver (like your
patch here does) _or_ the sc7180.dtsi file would fix the bug, right?
...and then removing it from the yaml would just be cleanup...

-Doug
