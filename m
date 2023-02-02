Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2E687F1A
	for <lists+linux-pm@lfdr.de>; Thu,  2 Feb 2023 14:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbjBBNs6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Feb 2023 08:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjBBNsx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Feb 2023 08:48:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6E86B37E
        for <linux-pm@vger.kernel.org>; Thu,  2 Feb 2023 05:48:47 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso1431754wms.4
        for <linux-pm@vger.kernel.org>; Thu, 02 Feb 2023 05:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXWkxe4SGYrdicnMh5rkVUAJtMp3X+h/Oh/J72q42w0=;
        b=sL1zkrAXk1PUP45V9lsSyfUIb9FI/G82o0YOI8DfymdoiDWWlZI39mZj1E7vnnFJlJ
         lWt16Ad6v8uDpp/A0fr/JwOPI0HuXwYxXi1TzvyWVpsGNN2ao6z5ocXJOM6OfGwZOwOU
         LDR8GDczMOk3xzd2XY6W/IUjEQFs/w2U9yXUYeEqWx5npX4NDt+SoFdeJgvxVH1h03F1
         vWSqiuTFc5dX9DQORX/rKBrLdjkxNac8gjhEYJbeJGKnvoQXGj3PpKc9gEca3yRJ6ZFt
         sPG8XJZzjrrvVeo/1y8rUnmSU/hjk8eaGmUtRfn/d3bKFalU8FMhNzyIvYNxP0L5PNOi
         v1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXWkxe4SGYrdicnMh5rkVUAJtMp3X+h/Oh/J72q42w0=;
        b=g9DTdEhHr3EMV+V+kYqKyur3GF9R7f5IExzdOfBfWW8zX0/tEV3CENUwau6NhxON1Z
         HNbdawm1YBoA4pT9zAES8baoNEnmXODWDeIk24CaP80u2+U7aBhqHNoqzgv/I9+ZLJ8s
         g6tzLlsfrqYrx4vYFl2LXEMz932L95pOTVx8ndOTBIfqfGr1Cbxd2Tx0/2gMnLWdhvRF
         kTj/NKdo0w8WpVh4gwhMpYMeCQNt1OJ0T4u3DDWuMjCNbe/xkhQpWUNZfrUSdWbjjbr4
         tueUPwq4qOq6yfm2xLyv7bQOXTc+PQvfsl9rsnewYU8kqsgnSRVNQe69R64ZgveHv2xx
         Jeog==
X-Gm-Message-State: AO0yUKUNJ7MjEO5TkqOvnbbJvIwdzbh/+llK+8byK44MGUISVrPdm3O1
        wT1PwjZiclwARrYCJ0PIRYM6qw==
X-Google-Smtp-Source: AK7set+Zr97degZEX4dpQhdLC+wc8OxR5OxdmJYt+sL3wkIkp9CvXbAznlZpl1Lvqi1NhPwG6EYcXA==
X-Received: by 2002:a05:600c:3ba5:b0:3d3:4007:9c88 with SMTP id n37-20020a05600c3ba500b003d340079c88mr6646078wms.18.1675345726237;
        Thu, 02 Feb 2023 05:48:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c0b5800b003cfa622a18asm4867041wmr.3.2023.02.02.05.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 05:48:45 -0800 (PST)
Message-ID: <963e3b8c-16a5-76d6-7810-d56ed548ebfa@linaro.org>
Date:   Thu, 2 Feb 2023 14:48:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: watchdog: qcom-wdt: add the interrupts
 property
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230130134328.178591-1-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230130134328.178591-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 30/01/2023 14:43, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The interrupts property is used in all nodes using this binding but not
> defined in the document itself - hence dtbs_check fails for them. Add
> the property and update the example.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/qcom-wdt.yaml        | 11 +++++++++++
>  1 file changed, 11 insertions(+)

dfn in lore would save you some effort (or my pending branch which I
shared on IRC):

https://lore.kernel.org/all/20230113103346.29381-6-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof

