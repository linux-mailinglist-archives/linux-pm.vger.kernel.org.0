Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2307B96A7
	for <lists+linux-pm@lfdr.de>; Wed,  4 Oct 2023 23:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244135AbjJDVrH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 4 Oct 2023 17:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244129AbjJDVrC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Oct 2023 17:47:02 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB996D7
        for <linux-pm@vger.kernel.org>; Wed,  4 Oct 2023 14:46:58 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59f7f2b1036so2959227b3.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Oct 2023 14:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696456018; x=1697060818; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tpTnpDJ8m5u92YyzRJIrb4UFVgAGSfyLUUGh9QrCbEs=;
        b=cxH1nUU6x2vefMLkWSdvBIHTVHCwhRcorKMT7bToAafoDfONZ1TQcx1h/Hk/4IqR0V
         D9aSi0+aTp1z/LgiZAPab01nNv0v7YCyMJxH5VN7HYeV2QirqyOI5MpkNTLnorxkbigJ
         eV2q8CfaQbut00/10H5G4wdRh5bcL0zWp+oRAW/mzJhX7Scnh5lByoJgJx7q2VWdptTd
         0WaqwQRqa5FggbzDakARe99KG2zY+pXkbtfueU7DJAEbkuUH6gHqae7hfsMVnKmXF4Hi
         a5mxZ/AW49dC8PqxofQ/hxAPkZks3i+EXbfLFcxYXUSbiPpiWoSjnpf3z/7/kri+lIjT
         0Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696456018; x=1697060818;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tpTnpDJ8m5u92YyzRJIrb4UFVgAGSfyLUUGh9QrCbEs=;
        b=n35+vwMLejUuvlB3tt50s/uYG9D3MMjSSNQv+yoSlUiBGrNZsGLo4Tp3SDU+kHCo9D
         qw+Z7vHrI4rfRDAgalXY+lLPKnDuth1VjdoxSKoF5I/FJVPVA3NeTU2rhfFBY6isISXf
         hnSgfyQhBrzURR4EximgpglmNfcLX2LFrHX/FoRMR1YJL+kdEG+OToNibJxbD77ZA5vp
         I41KrmeftmUNfWozwwrDp7qk8cUANNTPC3pZyoXh5Hsq2H77M3FXQ3VuxNwslwmzPojA
         0jHMk81O3+Qv9hUm+dRofmHTS0WBygAmg+rIre/S4SCG8DTCTHcYeZYc9UdEjiYjM+Ow
         LwxQ==
X-Gm-Message-State: AOJu0YxNCyp27abCFCQ5vWxP1E90Y7BR0PWxALnM6z/mz4Yq/AuawQ74
        m4xGt1NFoSPnIPRjEAfQ6LIi2wZHwTl/SITKJWddqg==
X-Google-Smtp-Source: AGHT+IGRAT6txNT8z5BHKJlzrsBs/tEhnvh+ByZd2oleUCBulCvOS6ym+tk5iY2/WHH1JuKvU7PVGteknDPUUHfWA/w=
X-Received: by 2002:a25:9cc2:0:b0:d85:abce:3f43 with SMTP id
 z2-20020a259cc2000000b00d85abce3f43mr3251502ybo.38.1696456018079; Wed, 04 Oct
 2023 14:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230927130734.9921-1-changhuang.liang@starfivetech.com> <20230927130734.9921-3-changhuang.liang@starfivetech.com>
In-Reply-To: <20230927130734.9921-3-changhuang.liang@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Oct 2023 23:46:22 +0200
Message-ID: <CAPDyKFpQr87+SxGpX=KBYF6sCJJqcE84ugttQ9Zkuqf3iZDLmw@mail.gmail.com>
Subject: Re: [-next v1 2/2] pmdomain: starfive: Update prefixes for AON power domain
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 27 Sept 2023 at 15:07, Changhuang Liang
<changhuang.liang@starfivetech.com> wrote:
>
> Use "JH7110_AON_PD_" prefix for AON power doamin for JH7110 SoC.
>
> Reviewed-by: Walker Chen <walker.chen@starfivetech.com>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/starfive/jh71xx-pmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pmdomain/starfive/jh71xx-pmu.c b/drivers/pmdomain/starfive/jh71xx-pmu.c
> index 2724bee7e85f..74720c09a6e3 100644
> --- a/drivers/pmdomain/starfive/jh71xx-pmu.c
> +++ b/drivers/pmdomain/starfive/jh71xx-pmu.c
> @@ -419,11 +419,11 @@ static const struct jh71xx_pmu_match_data jh7110_pmu = {
>  };
>
>  static const struct jh71xx_domain_info jh7110_aon_power_domains[] = {
> -       [JH7110_PD_DPHY_TX] = {
> +       [JH7110_AON_PD_DPHY_TX] = {
>                 .name = "DPHY-TX",
>                 .bit = 30,
>         },
> -       [JH7110_PD_DPHY_RX] = {
> +       [JH7110_AON_PD_DPHY_RX] = {
>                 .name = "DPHY-RX",
>                 .bit = 31,
>         },
> --
> 2.25.1
>
