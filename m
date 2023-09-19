Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8551A7A63DA
	for <lists+linux-pm@lfdr.de>; Tue, 19 Sep 2023 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjISMxi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 19 Sep 2023 08:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjISMxh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Sep 2023 08:53:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8908CF9
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:53:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ae22bf33a0so250175266b.0
        for <linux-pm@vger.kernel.org>; Tue, 19 Sep 2023 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695128010; x=1695732810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=INMiqvUlAaZCTtMIDQyk+1WY/3AkEXIA5CE7CWai5GY=;
        b=eB16tIJ+fvP327Sx/4tHcAGR3hUEbzNPpQSN1nc1TgSq8lhBI+2hzGtq2iUNTMscYR
         8bCirKD+EuY6ZEIHmGsJRgXRaMnCDR+EgKJine3PUox/jyGppgrSLq5aD5zoW4ok367E
         FHIKMyNvrpiqxN8X4BzWn6UmY58GEj+PomQycdfuYuh3ZDZjgQtZBC8I51Hp2yiNMSiu
         IK/kx2cNKwAAy5n/a2oX1SF95oWEWB3Q4XgC3YzJZiyfYZLNpE4g8+xG1qL4mn5wVoaX
         lEMdN8IWgPUXtjQfd3sB0Ki7Oq07N5fPCWs52Wq4YpzWew8fJaBoIdzSbGQPESmcnbg1
         0BvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695128010; x=1695732810;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INMiqvUlAaZCTtMIDQyk+1WY/3AkEXIA5CE7CWai5GY=;
        b=CzaoRnhF39oqM+Ty6/RAqNtO58B3nQx3LQxaLbbsi++NaG/s9bEJV67PThcs0a2HtX
         QVxPSqKv8uDnZfT0n6qAbnrPFE2COPYtBPqloV8qtR7xBq8iWQVF2untI0fYkEJ5mUHt
         9IbqtvBpQiyxvQdLZ/gRk3FegXGhhEw1089UoC5rQKO/ePEpWVRF9fZUuaI/RAiR6OyG
         ydqHVMyAce5kgKy9/YdO1Z+0PSoiZK5GcYYxLvo+vu0xcM7+RFcl+7DmRAoTNcQHZ2DF
         Ldxg2YgsqDFvPU8qppLarc5NOIJMGLavfbzi8o/b8ASaGbOr3whCIrCftn+2U3WeoGVe
         EZXA==
X-Gm-Message-State: AOJu0YyPbhPdO2ETso1votQ90jzrtEQhIOhMlDbWMSkncj0pzYiMQz2y
        rovmWXmDeVLJ+2BVXZ6fwxLEFg==
X-Google-Smtp-Source: AGHT+IEINsXjXfjtGzWqPWa+cEhOBEeN7XWe+mgsvs5pSD3THfNwQV0yJfhtEdE7wg3yI8rjnjm9FA==
X-Received: by 2002:a17:906:30cf:b0:993:eee4:e704 with SMTP id b15-20020a17090630cf00b00993eee4e704mr3329317ejb.38.1695128009898;
        Tue, 19 Sep 2023 05:53:29 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090694c800b0099ce188be7fsm7779902ejy.3.2023.09.19.05.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:53:29 -0700 (PDT)
Message-ID: <d66480b2-818d-a993-021d-1cc0f9c7d9ab@linaro.org>
Date:   Tue, 19 Sep 2023 14:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 6/7] dt-bindings: arm: qcom: Add QCM6490 Fairphone 5
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
 <20230919-fp5-initial-v2-6-14bb7cedadf5@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230919-fp5-initial-v2-6-14bb7cedadf5@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/09/2023 14:46, Luca Weiss wrote:
> Fairphone 5 is a smartphone based on the QCM6490 SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

