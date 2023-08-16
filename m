Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FCE77D9CF
	for <lists+linux-pm@lfdr.de>; Wed, 16 Aug 2023 07:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbjHPFg7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Aug 2023 01:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241934AbjHPFgo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Aug 2023 01:36:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB23326AD
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2023 22:36:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso9646846e87.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Aug 2023 22:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692164200; x=1692769000;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Ik7oB2lk1wIqJS13yqGm2Jzcg954+ej63dLWafujLc=;
        b=Jm6G45hlR9D4az3ti0gcPLs4wGjFIUBqIFwbcKTT3jMnFeIazCVB+qCferkNs9C6JC
         LuRsPJjdBwO2uzLRbNl+S17gdQrKWedPjJYRcKsgYVKFRfAkf8lIAYQzjyWcne8C72yj
         Cm9C7S1HNnh+mLFk07mZiH4rh8yiJhTe/AOEDLoz8kb2RCj8A1LzasCKZVN32qOXt/qw
         MA+1il5inA5DhGyht9qIGQJgzt7x6t1LvPOdo+FaqAsyyLs4Vg8hkjRs7R6hqQGNtkjT
         P8LbHQkpC2kQS5n3fZSGpdBHNEJkVw17Zlb2WR5yj8rSQ3Bz9WcUEQj898bFGkAzSXiU
         YN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692164200; x=1692769000;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ik7oB2lk1wIqJS13yqGm2Jzcg954+ej63dLWafujLc=;
        b=KShn1/3/KGfxsZ5pDil4Oe+s+KxfJf4unHMkhpzsa0vlTJ+Jnjl1tlxgYwBBgHKZnD
         ZUOvjdy3uBKXtfCHOgS3vYJcYPRZMxPhsWhl15VP8DYBgop1D7Q0brq74gfsr1fBH8Bb
         Fhf53LmpY2PzVDn4vmcj6GkdhLmk5uvgMaaIZ2KCGDX6hFlGE8zKVL/0IqAmB4y/BBEA
         SJ1S/oJT4EraQn0i20X6GG43QAHHDUFltjmbQ7CWfNXhN+fdislIYoYBDdpkXeExWE7R
         IA9oXwOzx55oqgDpsrn9B/aKzKwXNHdft4FKefgg48njc1OFzyWpfGh2dzcdVdHKTnKW
         JmDg==
X-Gm-Message-State: AOJu0YzxdvkaoQ52NwvSirzAEFBqdjcNGVTqtfDNRG+I2L4HidtfS2P4
        I9XdQBAL+PkqP33jaHaS5NLy2g==
X-Google-Smtp-Source: AGHT+IFAs62wSEs2OIDQDCPJhNq9ervbfVQQNZaVRMpFSL1Wxj0WM+O93QtbpxtBP9I9KfbxKfhHKA==
X-Received: by 2002:a05:6512:3410:b0:4fe:6fc:1fc7 with SMTP id i16-20020a056512341000b004fe06fc1fc7mr654460lfr.27.1692164200175;
        Tue, 15 Aug 2023 22:36:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6102000000b003141e629cb6sm19799961wrt.101.2023.08.15.22.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 22:36:39 -0700 (PDT)
Message-ID: <02ade1e1-e319-2f95-4645-95e9f9f00843@linaro.org>
Date:   Wed, 16 Aug 2023 07:36:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] dt-bindings: cpufreq: cpufreq-qcom-hw: add SDM670
 compatible
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230815223108.306018-5-mailingradian@gmail.com>
 <20230815223108.306018-7-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815223108.306018-7-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/08/2023 00:31, Richard Acayan wrote:
> The bindings for Qualcomm CPU frequency have a compatible for each SoC.

Drop this sentence, it is not relevant.

> Add the compatible for SDM670.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
>  1 file changed, 1 insertion(+)

You missed to update rest of the file.

Best regards,
Krzysztof

