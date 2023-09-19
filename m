Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E907A63DF
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 14:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjISMyY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Sep 2023 08:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjISMyX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2023 08:54:23 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BC4F5
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:54:17 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so9455479e87.1
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695128056; x=1695732856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHlp12OY4VfcS9NhAFte/8IKlKxJfA2Yi8z5qG+1sGA=;
        b=EXWvmuM+n7IHJE6yb+Ch5qRCUa29ybwUpztM2xzKCEdp9Se5QGHlEKdemtGYjovJmm
         QR7ErQPLQAEzwyx3ZlW6GmCketmdduKY8I1D548jSnWtfM/WT3+ZnEXaSLBI2V404Xd3
         1ZgsO9UBlQpOzl9PfriCWGi6Dwu26oNOPOr6qEZcsYpU3cG8AIis7YLBGJ1guYAM1VJB
         QRiGtPMS2WzWPhxupHeUbn2wPGLokI/TVa43VLw+lqvPaOdF26oG9VNgf/N6myUnbH48
         H5uw2OmUbVFydx7F7TNlI5YPAkU9m7sg2eArIaB+MGv5rJF93PedILrIVsJVDgqC7rSn
         JrBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128056; x=1695732856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHlp12OY4VfcS9NhAFte/8IKlKxJfA2Yi8z5qG+1sGA=;
        b=gV+lGYpW4z2OJ/A1xmUg/l/3mBkCgZ4IKKwuH076VIKK2do23ma/VVVVOIr0WJTzWP
         Wmv2raerVB2SpHR09aaYtL2XzKmKjA+SoTLgNAXbwVzUblItvDUZECx2oDYYKFaWrheN
         TOd1KmaCfgnF8K5RgftlR9LSbNQJm6GKjXjUyxHCrBc94jtQVco84QT+mA5p9fs7XRXX
         7Mug7UkL595ol6pcpSwYe0eWWrZ457joxHOsyKPl6zKPYAhzosscUgtvRxrYH1onGMIS
         3L0Cp3WtSkM2IY2OJ+8FknTm5jq1WNGq6P/7IKcAKEcbUbG7KuIu76OZPIysngfeZwhD
         pbZw==
X-Gm-Message-State: AOJu0YzDVNaYcsIo3VZ/bTKkyiwwVWS1aZm+nVt2MKes3hVg2I1wQftC
        nZAbuhCgrHfXAOg/moWP0PIgtA==
X-Google-Smtp-Source: AGHT+IE07MxzjeU1AH9VdOClb1OZimmcWJQneDG1cdeL+1+Wql/8taDQ6u/b3Q8QAZ24oOOIV4gHkQ==
X-Received: by 2002:a05:6512:3b1:b0:500:bfcb:1bf9 with SMTP id v17-20020a05651203b100b00500bfcb1bf9mr8705050lfp.67.1695128055787;
        Tue, 19 Sep 2023 05:54:15 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id eh16-20020a0564020f9000b005256aaa6e7asm2804329edb.78.2023.09.19.05.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:54:15 -0700 (PDT)
Message-ID: <ff09c56e-6311-5873-da92-80a9fcb1cfa9@linaro.org>
Date:   Tue, 19 Sep 2023 14:54:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: qcm6490: Add device-tree for
 Fairphone 5
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230919-fp5-initial-v2-0-14bb7cedadf5@fairphone.com>
 <20230919-fp5-initial-v2-7-14bb7cedadf5@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230919-fp5-initial-v2-7-14bb7cedadf5@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/09/2023 14:46, Luca Weiss wrote:
> Add device tree for the Fairphone 5 smartphone which is based on
> the QCM6490 SoC.
> 
> Supported features are, as of now:
> * Bluetooth
> * Debug UART
> * Display via simplefb
> * Flash/torch LED
> * Flip cover sensor
> * Power & volume buttons
> * RTC
> * SD card
> * USB
> * Various plumbing like regulators, i2c, spi, etc


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

