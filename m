Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B56505C3C
	for <lists+linux-pm@lfdr.de>; Mon, 18 Apr 2022 18:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346004AbiDRQIQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Apr 2022 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244734AbiDRQIO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Apr 2022 12:08:14 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAABB245B1
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:05:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b15so17948536edn.4
        for <linux-pm@vger.kernel.org>; Mon, 18 Apr 2022 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=1FG8zlskaU8QYmLyVbhp7MqtkM5KAnbzSoulYp/uDAI=;
        b=D7ElZGuH4qa3SHqcE8yhrlNUiAZUx+HYHSgT2PqtD1Jf4tkHFzdt4v0xByd2uOY6HJ
         Ugv/s4LeRYfxW85cfzTA/PbvaZofgM5xjua5Y0QzaZyeTKQweEQnDQWAKvT4x1iDHb9/
         ZadzisgCPFWnCKT4sMAEXE+GbO0q6b3f9eYCKbDRIRfqTQ5NId/6qapY/+WOjAtxHK5p
         NxwSjiOWIqkfS10Q8nI+bn8jZsF+3mQOWfHPOoEm81i6ijiFTxM7qHFIoA5GyDEukVHj
         Q0B0alO8j6/VnGea+pNcYmEWFV17suIA6vAqAU3Qhu/aCXE3EJfDNyP1HzHyg1M7Okrp
         qNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1FG8zlskaU8QYmLyVbhp7MqtkM5KAnbzSoulYp/uDAI=;
        b=Me4klujILub1lL2X1c6MCU5pdQmvc6CvUvY8ihcfE1exe4RlGHZU630U+7LnWS9ASJ
         Amy717ME4Cb5YUqmuLQaRJpoDdfBNkKKBovcvurqoRc1BZ6+/PCxLTX22FsAcZNKC9Xd
         4J0GApQe+WAvV4opS8rguMqdnaDxnQOwpNO4IPb1CA+E4jSeTgAqjTQS4FMUhvq05L5e
         9241iXWUWNTuZ+2euiHvHGo1qq7tMnalbNOXXGkp0DV+wDy8tYj5HzlDUHIf98onYGgy
         TnZWTLTrXQFX2tk5cj3t6/BMcl7YooRc60Mzo867tzH3xHZomYplubUeyH0UX0P2sTMl
         iCuQ==
X-Gm-Message-State: AOAM530iEsL/lpBBBkao/YF32Mal+RSngGogW5geyVWjTwQw8Cbd+e/Y
        NedGjmm7z7GZ5cTcgtsXRyLISQ==
X-Google-Smtp-Source: ABdhPJwZpQsmRe0WGE8LAjpl88Y/1F8QI48G+N5BdmGy/oMpO0rgt0xfhA+2zk+uAXbgJZbH7We17g==
X-Received: by 2002:a05:6402:5191:b0:423:fa7f:f4c2 with SMTP id q17-20020a056402519100b00423fa7ff4c2mr286026edd.9.1650297933569;
        Mon, 18 Apr 2022 09:05:33 -0700 (PDT)
Received: from [192.168.0.217] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906059100b006cee1bceddasm4703342ejn.130.2022.04.18.09.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 09:05:33 -0700 (PDT)
Message-ID: <1a34bf7f-88ef-03bc-3902-c12b1400ff7a@linaro.org>
Date:   Mon, 18 Apr 2022 18:05:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RESEND v2 7/9] dt-bindings: arm: qcom: Add MSM8996 Pro
 compatible
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>
References: <20220416025637.83484-1-y.oudjana@protonmail.com>
 <20220416025637.83484-8-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220416025637.83484-8-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/04/2022 04:56, Yassine Oudjana wrote:
> Add a qcom,msm8996pro compatible and move xiaomi,scorpio to the
> same items list as it.
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
