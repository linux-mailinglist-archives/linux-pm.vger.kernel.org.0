Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF284FA999
	for <lists+linux-pm@lfdr.de>; Sat,  9 Apr 2022 18:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbiDIQiP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Apr 2022 12:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242744AbiDIQiP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Apr 2022 12:38:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314F82405A2
        for <linux-pm@vger.kernel.org>; Sat,  9 Apr 2022 09:36:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b24so13303555edu.10
        for <linux-pm@vger.kernel.org>; Sat, 09 Apr 2022 09:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Goyr3MIqUBSL5zn0QICfxcP964F10vA3U9TdZQjhf50=;
        b=fHNdpsiSmmHw/Gavtt1UnFMLMlLTpigE6fpIRBvMJRhmlkWvaKFywHexM4McHkPmkw
         wEoC4BGHKU9NhiyylxbQ9eu/FSzeIhqDlP4qcKk7qDF3tE24bG2tv1FaPZMW0XBSsk3b
         8vIGtYba+nkWjCK6nYFuMbY31SSFzSaxQe6fFi8amzdB7doUc4J/IK9MHfgjid7iDEuS
         s+n6dnJJxfDRIc6lEFmeToDgXKX688hYfD7/fOZYxFsFcjuHahzf8wMkHuIPSLet9/3M
         DGIQuRGwtt1EzFnlBCL6WO1G0AcvyHMF7ByY0fQGnG/Zl+pjWNNc4PGIF54Sha2vl6Rk
         Z2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Goyr3MIqUBSL5zn0QICfxcP964F10vA3U9TdZQjhf50=;
        b=e9zCIe/vkSnopD3uCffhbRepmjFFfSEBjDbpJVxecwtfjCAY4SQIY17ahfLUYnrbyF
         xhFTPZnhfXDWZUGZF+UjftnkO/McTCpnbjAyOJPGr7CEraC+HNgsl39N96ez4froQpze
         Dl9jIty9QqSXiZMY6p+9Zqs3m66/4KaSOcwUPe2JJ+iVeU0mI6GZVS9jPue7j7EhJhRs
         Hl+zHl+iGRD3QrD/vw7W3V+1srRGxiPG/xES41Trq1bl0F+19MgcYejqLNGnFlsC+SqL
         JvtzmxieQwTLRLAKn5u7HqgFMalvEKOdNchrVAxiCNIGYq53Aw3INBN5zhPU56VTbiqo
         GzTQ==
X-Gm-Message-State: AOAM531pwKziGL8IJJ0znmgm+KzoIDqXruZ1RRwMhDw8iN6ZV35mIoS5
        XH1ZcfhLtXz/8wwayJJLwc4jQg==
X-Google-Smtp-Source: ABdhPJxScwLOnOtgUSqFiIhaikpZq47qxQHyf0SdCiHrfh1hVzJAXLcB6iCmHz+0sMq0hnQUJZVmJA==
X-Received: by 2002:a50:ed0b:0:b0:41c:cf60:a882 with SMTP id j11-20020a50ed0b000000b0041ccf60a882mr25260459eds.12.1649522165615;
        Sat, 09 Apr 2022 09:36:05 -0700 (PDT)
Received: from [192.168.0.188] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m14-20020a056402510e00b0041d0c0942adsm3329790edd.52.2022.04.09.09.36.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 09:36:05 -0700 (PDT)
Message-ID: <c568d98b-4b4a-c444-3934-086f80e8cbcb@linaro.org>
Date:   Sat, 9 Apr 2022 18:36:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: thermal: tsens: Add sc8280xp compatible
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220408225037.627432-1-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220408225037.627432-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 09/04/2022 00:50, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform has three instances of the tsens block, add a
> compatible for these instances.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
