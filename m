Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B93676D5B
	for <lists+linux-pm@lfdr.de>; Sun, 22 Jan 2023 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjAVOBU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 22 Jan 2023 09:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjAVOBT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 22 Jan 2023 09:01:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13C01E299
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 06:01:17 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso6761470wmq.5
        for <linux-pm@vger.kernel.org>; Sun, 22 Jan 2023 06:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+MdEj4R2+WEYxIlXsIfr4Eo7Q9gZDogpTKz227nG1/8=;
        b=zvgf5ozrUNYKT3ogWzdIS3NcRA9RDacuIEVoNItjYlS59X8vl31Qxm9aEyzlqrBUVZ
         6dy1DiNT1zKcOb1keUJP1zF5VoCpCerIjdH9BoTdwGKtKLgXSBxaTslssEb3ENDeTN9N
         z5JXLyJp5XvXOiHZHoLZNmwJFn/d+W3Of/yO+JP/iWqCObVUNRtV/i3mXNPTKa+AJV/q
         zjHTz5FKji1DlD9EQzB7LDVYH8uZWfk6rsqMW5Zp9KEL7SstPHifl1J7Q+P3LYhDgub0
         THfKmYSBAMY+b5bn1RfWtpMBT7d5ZjzNo5WL+moClfaXu2AnSNFzBhmlSfMgm1xruR5j
         WBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+MdEj4R2+WEYxIlXsIfr4Eo7Q9gZDogpTKz227nG1/8=;
        b=BMqI0WWrgBXTHsjJ1xQi4whuAhtYzX84dXx9taywtbzhfhSOnatBO8RkkWuqZ3Ba/M
         lJ97Kvqn/lg4X2EY9de7IL7FlRkTgCaTaOrrDYlQf5XxBO6lBjRc/PK0WJk7bPq7hzBx
         FcEICsQTI8YqfPUc1xmT3vyss9fXfZ2H70c6uhu7NCRx9B8KnASKo3rxs7c/WYrRkMdQ
         STiyj5TB4vXzC2RRQGhF5KGTdrUomrLPQ8U7KtJuGJKzhP4A2pmy2wwu+sCFc6YwVM3a
         NZclg5jLKcVwphtPRuHdQenvL0WMkExVpnQrcMaoR/+lt76OzgHFb2XZiG56e2S+DTuI
         7D/w==
X-Gm-Message-State: AFqh2kphZ7w2Ucz9DJpmO6zi6kaihirjcgDgFdkx/nAIJsC7dknUrMmT
        vJRfLeSXnclXSm4tctzyfTYKbw==
X-Google-Smtp-Source: AMrXdXub65L/v5Gp/lU5Ulf4dkZPAzKvizOOvwb0XyxK4MjGgfgQT2QKkAA8tsH4ux1tO/ymBST+sg==
X-Received: by 2002:a7b:c4d7:0:b0:3db:2fc6:e124 with SMTP id g23-20020a7bc4d7000000b003db2fc6e124mr9592660wmk.7.1674396076402;
        Sun, 22 Jan 2023 06:01:16 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az41-20020a05600c602900b003dab77aa911sm8200228wmb.23.2023.01.22.06.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:01:16 -0800 (PST)
Message-ID: <3fdfc4fd-5f77-90e6-5712-84d897ed37a3@linaro.org>
Date:   Sun, 22 Jan 2023 15:01:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 3/3] dt-bindings: opp: opp-v2-kryo-cpu: enlarge
 opp-supported-hw maximum
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
 <20230121000146.7809-3-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230121000146.7809-3-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 21/01/2023 01:01, Christian Marangi wrote:
> Enlarge opp-supported-hw maximum value. In recent SoC we started
> matching more bit and we currently match mask of 112. The old maximum of
> 7 was good for old SoC that didn't had complex id, but now this is
> limiting and we need to enlarge it to support more variants.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> index cea932339faf..b4ebaf68b43e 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
> @@ -55,7 +55,7 @@ patternProperties:
>            1:  MSM8996, speedbin 1
>            2:  MSM8996, speedbin 2

Document more bits.
Best regards,
Krzysztof

