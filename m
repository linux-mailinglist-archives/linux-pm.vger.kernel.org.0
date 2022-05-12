Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6B3524FFD
	for <lists+linux-pm@lfdr.de>; Thu, 12 May 2022 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355008AbiELObK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 May 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354841AbiELOaw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 10:30:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB0167D6
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 07:30:50 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h16so6845902wrb.2
        for <linux-pm@vger.kernel.org>; Thu, 12 May 2022 07:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZsOFLBYov1FAxmhwWBTHoBgyIz4ukWcPbqsafVCZ7/E=;
        b=KoHgrenB1Q5hv8m4uB2is8OkE97bPWIJ5+4qc0Uk387iuUKVoTeCeb9j+9cpo24w8g
         ksnpmHMc0WIOYwRKCT1AaLMh+vX15rUxmYsBWX+2MVFQ4ThfuhJpk7FL1aNEoKDIuW9D
         fMJI5X1mrBiq26rDHHhwl/MZInL9QO3RPeuA8W15DYIURR295tw/fFalfVoM9DBbagBH
         SYidH2mDuNcy/L8QGNzw1L8ZW1b902kvnGir47zmT1XxGEbOQSeK+22wd8BkcHrc9vvE
         phNif1j6kuJ4a1LSkqYVY1majxK4haZZyNur2OQOg5zDBS6Ui9mYB+1UQCRjBmCqGmzV
         MW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZsOFLBYov1FAxmhwWBTHoBgyIz4ukWcPbqsafVCZ7/E=;
        b=xGxnMnKhVg4uKi1NiUyG3bzgq2LOIcOlBiJoZ5DKYrFIyMwmG6K2wGre6OnXp1I9Rp
         3b2wRRSruRFOdTCmUL8mUAYEOSsTWBOYcDMmoPrlHWm/YQILGKEvcOKbc9PI1JYLYw+4
         tRw7c7+q5+j8z7Dlqw7UgL0GTUgBbF7yOgSCk61gYBHQA7S9PnrQT460uGD+FsSu4+0q
         fX4HGMGzo5Av75b4bgTELv1RGHXjN2COkwDhm7CHRyF8XpWWOUqv9SK/dY9iGmj2FdAD
         zMmyohw3WRam1zDazl0ctKLSPLsoCJKm73QXlrB0vztOu5O90le2Bysei/5AKUF0DLv/
         VWyQ==
X-Gm-Message-State: AOAM532wcHsCsk13Ov0fqNybKi13TvnNYgCmOYjSbc9gD3mw2z1x6qFQ
        7C6f59gYSGPehjAsLJrDEBxGgQ==
X-Google-Smtp-Source: ABdhPJxMwtrDsp3r3H3xP3VNWAcgbQy/ElkWYh4FISYFSUGbcavB87DrDWT7A7XEBKFVhztrPvhiLg==
X-Received: by 2002:a5d:64ea:0:b0:20c:5ca3:a0de with SMTP id g10-20020a5d64ea000000b0020c5ca3a0demr28487175wri.308.1652365848701;
        Thu, 12 May 2022 07:30:48 -0700 (PDT)
Received: from [192.168.0.161] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id r5-20020adfdc85000000b0020c5253d8d2sm4198917wrj.30.2022.05.12.07.30.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 07:30:47 -0700 (PDT)
Message-ID: <01d30e6c-5d0a-a5c0-851a-817277a8712d@linaro.org>
Date:   Thu, 12 May 2022 16:30:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 4/7] dt-bindings: thermal: Add binding document for
 mt8195 thermal controller
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, michael.kao@mediatek.com,
        ben.tseng@mediatek.com, ethan.chang@mediatek.com,
        frank-w@public-files.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, khilman@baylibre.com
References: <20220512122433.1399802-1-abailon@baylibre.com>
 <20220512122433.1399802-5-abailon@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512122433.1399802-5-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/05/2022 14:24, Alexandre Bailon wrote:
> This patch adds binding document for mt8195 thermal controller.

You just added this binding, no need to change it. Squash it with first
patch.

> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../devicetree/bindings/thermal/mediatek-thermal-lvts.yaml  | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> index 69ffe7b14c21..2e1ae00d4fd1 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> +++ b/Documentation/devicetree/bindings/thermal/mediatek-thermal-lvts.yaml
> @@ -12,7 +12,11 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt6873-lvts
> +    oneOf:

Why oneOf? There is just one item below?

> +      - items:

No items, you have only one item.

> +          - enum:
> +              - mediatek,mt6873-lvts
> +              - mediatek,mt8195-lvts



Best regards,
Krzysztof
