Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A404F9069
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 10:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiDHIMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 04:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiDHIMH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 04:12:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04114377D9
        for <linux-pm@vger.kernel.org>; Fri,  8 Apr 2022 01:10:05 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r13so15758004ejd.5
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2022 01:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=16qq4T8W7Wb3W3I0GFoxZjqEJT94+MYc2RlGkdbX2ac=;
        b=DHUn3OoULpXK+mm9ySoqW5WNBlp+pqhHBqMvxhOBi/v95ukvoDz09bDR+K4ILGQPxW
         KZra/kNcINrwhQ2t+V3PgKTeZqSs5Z+BXx7BSUsqw/p5/p7AhIhRdWUDjLk44f5JRiy1
         roa+7FL5knMpJNMxTxNhVK3kovdvgEmQ115DQjQmmrKoARK3kWCTzUmEQ/2+NByzAtg5
         XD6m7Wgp99VyLQoorf8GoYIo6DNYMwdAZCJAGMcBGWeXpd9kiKLu2WPIt5yN85m+JlAf
         l/D0BXr604LNNDLQcUA4EcfuSImnq0/txS+smMOdRfajZN0K3EnUgVCQ9MJOgWAuZpAH
         ri6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=16qq4T8W7Wb3W3I0GFoxZjqEJT94+MYc2RlGkdbX2ac=;
        b=GOBhwvPYqkfNzwAtMoO44olGEbypb2Fq344DkjcL5WbK5ycB+4SPzXxhr9+L8z8iiz
         oybyCam54qwU4oRmOJJ6EQ6JltkWD035Sfrb6e4Zi39622SrTmg2zpiV5tyvkIkeYJpm
         d8Fn6ewWV8+y6qD+8HmiiXI+lTEIbp1BvT4UVQUoiegaXGdG3RhUFzdR3kopD8TqVDG6
         lyPOHs4EBAzYRneGR8YksJHEI3QZdZ3S/EFotPfdHICgPKYRzd92VJnhUCi/+32PmhcD
         yZNxIkbmgrHj9Zm/GQkLeaDInZ2DgKVrVBZ5WvsLqzQfWwVAPJvfW1fjvJrHPs3L2vgN
         IeVw==
X-Gm-Message-State: AOAM533ncJyW80fPC4SAmAGovQCXlpMQnEEX69r9mLOd0ii2vqwP+yw8
        8P6IAnIB49vm8vpw/+1nbdgU2g==
X-Google-Smtp-Source: ABdhPJyd+7LeacyRv4S4s8A5mEZaNzMiHeOn8GceZ6A7SUV88bQI8PoI45QiWp3fyzkIiAh8+Qduvg==
X-Received: by 2002:a17:906:acf:b0:6e7:681e:b4b6 with SMTP id z15-20020a1709060acf00b006e7681eb4b6mr17535515ejf.61.1649405403553;
        Fri, 08 Apr 2022 01:10:03 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090626c600b006e74ef7f092sm6549148ejc.176.2022.04.08.01.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:10:03 -0700 (PDT)
Message-ID: <a171f33c-cda1-8602-ac67-93076b676578@linaro.org>
Date:   Fri, 8 Apr 2022 10:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V2 01/15] dt-bindings: cpufreq: mediatek: Add MediaTek CCI
 property
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-2-rex-bc.chen@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220408045908.21671-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/04/2022 06:58, Rex-BC Chen wrote:
> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> 
> MediaTek Cache Coherent Interconnect (CCI) uses software devfreq module
> for scaling clock frequency and adjust voltage.
> The phandle could be linked between CPU and MediaTek CCI for some
> MediaTek SoCs, like MT8183 and MT8186.
> Therefore, we add this property in cpufreq-mediatek.txt.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/cpufreq/cpufreq-mediatek.txt          | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> index b8233ec91d3d..d1b3d430c25c 100644
> --- a/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> +++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
> @@ -20,6 +20,10 @@ Optional properties:
>  	       Vsram to fit SoC specific needs. When absent, the voltage scaling
>  	       flow is handled by hardware, hence no software "voltage tracking" is
>  	       needed.
> +- cci: MediaTek Cache Coherent Interconnect uses software devfreq module for scaling
> +       clock frequency and adjust voltage.

You need to describe the type. I am a bit confused whether this is a cci
(so cci-control-port property?) or an interconnect (so interconnect
property)... It does not look like a generic property, so you need
vendor prefix.

> +       For details, please refer to
> +       Documentation/devicetree/bindings/devfreq/mtk-cci.yaml

Such file does not exist.


Best regards,
Krzysztof
