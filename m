Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B02745266
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 22:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjGBUqK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 16:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjGBUqJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 16:46:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A57DE50
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 13:46:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977e0fbd742so439981066b.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 13:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688330766; x=1690922766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jlYeSLn8Tq3IBahu6vVz/5FkROpZZXnVhcVPs+VklU=;
        b=mlsQ/ikds9ypzeEzm4Pj87+T6CQka+qT4uNstCN6g7PIfoFr0POw9oJDxA9gV0n/I8
         fWAfPiRSq2SGQmHhvlfge9J2rEwNZTQwTK8Zb5ldSngKtdL+hoT2hOUxfr7FuJtx7ChL
         /0fty1jDDCkVKRyxA9wgDqV70TKO/hiBYENiWv+Y3AyGJXgzWtb/OEyde2xUI5YMoA3+
         hrljN06m26pxCbc7M+ICFXdfwmXuKrX/6zn/nvIgw73TA5nBpTgLTkF9aqAOhK63T4lH
         rPN/9qw6I4PCpm6oCGNKd1mgbZuZRAiQv8UfQ4kP7V04f67I+0zo86yHF439Et0zXDgd
         RP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688330766; x=1690922766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jlYeSLn8Tq3IBahu6vVz/5FkROpZZXnVhcVPs+VklU=;
        b=Aa9v3xvFULT7QqDhVQOwgVddYNxgMWPAZXf/tmIUBzwMb83TiD+5CWRaSopY0dC3MO
         9Z6lrkZuSJVe5QgKKPoog/8eRjfGomPgHkTou5tubelksvWFSr0WycPGuC+bOd0hX+ic
         sZ3xccCXdLRn+S5WrQ246ftx7ruXNWJbGBKnX2P7bu8cZGnbOF9PqnrfcvpxykqjXtXE
         x92e72XMr2B+88ZABOBBU02RzzwyDRF3A2GitzJ6xa7XziTiPAcW4bZKqauZEd80O4I3
         4NqXNHNgrkTx0VSDt6WfS5GHsu8cXV4FYJ9NBzVGf8D4ZbAVwWESvXg0Dx+O+a0AvP9e
         CZQg==
X-Gm-Message-State: ABy/qLZeguTIkjRvZM9UIG5o92PuIfnCnUOXPzS3S749VT2D3NWMlhe6
        U0Pj6MD7blWuUdAz7nCVv2VoLw==
X-Google-Smtp-Source: APBJJlGZeCyGGolpS1rAfUIUpoBPWfZmmU7hCNm2ZfnL2GZ++SL/vljxXEnMAe7eHBu6cn/5YNtbdA==
X-Received: by 2002:a17:906:b293:b0:992:3762:3dde with SMTP id q19-20020a170906b29300b0099237623ddemr5608122ejz.6.1688330765847;
        Sun, 02 Jul 2023 13:46:05 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id gx23-20020a170906f1d700b00992dcae806bsm3838517ejb.5.2023.07.02.13.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 13:46:05 -0700 (PDT)
Message-ID: <cb057149-2051-0120-df79-4606d9cd7cea@linaro.org>
Date:   Sun, 2 Jul 2023 22:46:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 05/28] dt-bindings: cache: describe L2 cache on
 Qualcomm Krait platforms
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
 <20230702174246.121656-6-dmitry.baryshkov@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230702174246.121656-6-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 02/07/2023 19:42, Dmitry Baryshkov wrote:
> +description:
> +  L2 cache on Qualcomm Krait platforms is shared between all CPU cores. L2
> +  cache frequency and voltages should be scaled according to the needs of the
> +  cores.
> +
> +allOf:
> +  - $ref: ../cache-controller.yaml#
> +

One more thing - it seems you miss here select: field. Take a look at
other bindings using cache compatible.

Best regards,
Krzysztof

