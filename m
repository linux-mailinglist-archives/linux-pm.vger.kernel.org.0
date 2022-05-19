Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D5252DF84
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiESVnv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 17:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiESVnv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 17:43:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4411759BBF
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 14:43:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9FF8B828A7
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 21:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3B5C34113
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 21:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652996627;
        bh=5aMdAvTCHVLlyDNppzS55+XVjRG2HfXHSwjwsdpbSDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BMt93s2vM6p1ZI2XQ3Q86EEKTlBzjLxQUlSqkcYfmBCuijxIW8eKhLsfShbku5Bni
         zw3xcNBXu42bakrmqkgx7Sx+HK5LomkerwtRcOxJeW1buvwdgeRM3TLSNrtSA4hH4B
         V4Jy0L99TanxomZmIYpNPRTY6mLx9bYu+528EZYuUCawqZyRFdPuXmWVos1Cky8MWH
         TCDCb1g3fGDCRq1Xl91+jgBd6hgumhWAS43BzNHksnwPasQJ3Q4toKemfk9DIMKf69
         soVGYAnTKx2/uY/p7F/d3wPqEPE9QHq8nQ5SR6QoHZeEatCuVanGM+i+jdrfX1eM/o
         1FaPIttreRubQ==
Received: by mail-ej1-f52.google.com with SMTP id tk15so12312508ejc.6
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 14:43:47 -0700 (PDT)
X-Gm-Message-State: AOAM531a1edxuiOXTofyHSC2JqDQLn5sNFQSQZ+njYZdBSqvOD9ZwT68
        4n/nz9V/4ZePjTvXobQ1+rtBEtC6CjtJJFaadQ==
X-Google-Smtp-Source: ABdhPJy/FmQBVx6CrhZAtN/k6CFbQ9CkVxk9EXYwaAWWsAYZzAOadTHWIasmQ9mr78AgZlMNI2cC8j+VFKqwl5z/bJ8=
X-Received: by 2002:a17:907:9602:b0:6df:e82c:f84 with SMTP id
 gb2-20020a170907960200b006dfe82c0f84mr6180859ejc.590.1652996625948; Thu, 19
 May 2022 14:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220519164533.1961-1-macroalpha82@gmail.com> <20220519164533.1961-2-macroalpha82@gmail.com>
In-Reply-To: <20220519164533.1961-2-macroalpha82@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 May 2022 16:43:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLOknvm2E8hU9Hd_5S0ZCnPxzbgq4BQL4m6UqC9+tC1tw@mail.gmail.com>
Message-ID: <CAL_JsqLOknvm2E8hU9Hd_5S0ZCnPxzbgq4BQL4m6UqC9+tC1tw@mail.gmail.com>
Subject: Re: [PATCH 1/4 v7] dt-bindings: Add Rockchip rk817 battery charger support
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Sebastian Reichel <sre@kernel.org>,
        Jon Lin <jon.lin@rock-chips.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, May 19, 2022 at 11:45 AM Chris Morgan <macroalpha82@gmail.com> wrote:
>
> From: Chris Morgan <macromorgan@hotmail.com>
>
> Create dt-binding documentation to document rk817 battery and charger
> usage. New device-tree properties have been added.
>
> - rockchip,resistor-sense-micro-ohms: The value in microohms of the
>                                       sample resistor.
> - rockchip,sleep-enter-current-microamp: The value in microamps of the
>                                          sleep enter current.
> - rockchip,sleep-filter-current: The value in microamps of the sleep
>                                  filter current.
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>
> Note that this patch requires the following commit (still pending):
> https://lore.kernel.org/linux-rockchip/20220519161731.1168-1-macroalpha82@gmail.com/
>
>  .../bindings/mfd/rockchip,rk817.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)

Please resend to the DT list so that automated checks run.

Rob
