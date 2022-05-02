Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E910517670
	for <lists+linux-pm@lfdr.de>; Mon,  2 May 2022 20:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244706AbiEBSYd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 May 2022 14:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiEBSYc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2022 14:24:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CFF659A
        for <linux-pm@vger.kernel.org>; Mon,  2 May 2022 11:21:00 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so29222325eja.11
        for <linux-pm@vger.kernel.org>; Mon, 02 May 2022 11:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=iItLeslMywWC75aXdXtU8Z+zXUhrV2MK1NBIxn2y2rs=;
        b=ememrw3mrzB87tbxst36sFZrP2L0uucEvly20Ws+EZFhF/pddU8fYcS7JEFCJUP+CL
         j+lGzY0fHbbQlSfH/ikTqPNafPooCBizg2Lq9AZYjeVZogIOGaFAnJ3yMaO2I572f1ch
         BtyoIhO+5B1oarNj/H8Of44qF1QB2Fofx3dByrN7GaTI3ePDmN7+tFLZvrpg0GfxKYO/
         Mn+Iv+6XPWcVY0artXR54yqQe0UEBo/Glqd773ezVvZaOxm3dOP1zOCExI2ZvwQfQy0s
         IClGWaKHCqD2zLbNOmB55lYjCMsm4C6vMLQl59E+qbMAufvlFzNaLZTja1LW/8VSq9Ap
         H3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iItLeslMywWC75aXdXtU8Z+zXUhrV2MK1NBIxn2y2rs=;
        b=Dh9jo9FCxYNDH89cUJXBIblXaP+Zwh01nfwbLY/lY00+0Eq71vBbz0JnzEHXr/BheW
         /WlZw1ltNsFwJaW9hqZafgIRIlYUxIDwkin/XMOsSxAG4U1A87yFPc4y28Gu/shpZpse
         ecCJdFoXV+SxE1xaVCMNwthgMF6pF8E0Zr5xa1K4zEu8o4ANvIU5zYqyadjomeesE6+M
         kz5XfrK88CX7yg4v1zPwiaVSpeN75hxo8pVZMiuEL9UJek8RRTM+CQEGsrjRq5Or9h+c
         CuBd6fF5FgmPS3R5pJ96rCDNXkeyDkadf0Xmn+I1PAZd3jHICjW/2UCcOUVqbPWbxE6w
         nv1Q==
X-Gm-Message-State: AOAM5329dmCCzwDURYvwWZ1Lmx575nzotmQZ9+EFF2uXWdJ9YIbCbs9Y
        Rup4VsUjTBRy5xFGbRaZAdw4cg==
X-Google-Smtp-Source: ABdhPJxQs/h1jEPNSvWXNsY4p7A5yQi5Z4mXw2JDkI9IDc2ziVO/mSYH8FV79HltN8p7CElqnuj0Zg==
X-Received: by 2002:a17:906:c110:b0:6e0:dc2a:3393 with SMTP id do16-20020a170906c11000b006e0dc2a3393mr12215880ejc.512.1651515659085;
        Mon, 02 May 2022 11:20:59 -0700 (PDT)
Received: from [192.168.0.196] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id y20-20020aa7ce94000000b0042617ba63a3sm7009742edv.45.2022.05.02.11.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 11:20:58 -0700 (PDT)
Message-ID: <717f54e9-9ca9-9ab1-2f03-2edfd7e684d1@linaro.org>
Date:   Mon, 2 May 2022 20:20:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/4] soc: qcom: icc-bwmon: Add bandwidth monitoring driver
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thara Gopinath <thara.gopinath@linaro.org>
References: <20220502174046.139234-1-krzysztof.kozlowski@linaro.org>
 <20220502174046.139234-4-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220502174046.139234-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/05/2022 19:40, Krzysztof Kozlowski wrote:
> Bandwidth monitoring h/w sits between various subsytems like cpu, gpu
> etc and ddr subsystem. This h/w can be configured to monitor the data
> traffic between ddr and other subsytems. The bandwidth values obtained
> from this monitoring is used to bump up or down the corresponding
> interconnect speeds.


(...)

> +
> +MODULE_AUTHOR("Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>")

I should have checked last minute changes if they compile...


> +MODULE_DESCRIPTION("QCOM BWMON driver");
> +MODULE_LICENSE("GPL");


Best regards,
Krzysztof
