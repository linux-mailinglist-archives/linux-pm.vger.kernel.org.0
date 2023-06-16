Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0B73298E
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jun 2023 10:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244582AbjFPILG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jun 2023 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbjFPILF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2023 04:11:05 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF3295C
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 01:11:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso51891966b.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Jun 2023 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686903062; x=1689495062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+nb5C/fzCmkNH4tFkgENtFMDkmGCOR2QUSuKVrANoM=;
        b=a2Mlb03zrr9JJo0Q+0A43GCTfWHuVRjCiS/gF7JyjDz88V4vbA0ia7lc9aFr+zYAHP
         mjZnYFtMIAX7sTsI8nHAhX3q4+3tc8qfOgLpnZ5uKhQN9Jkq1eEQioOZ1VTLmszIuQAC
         5hyXUj7UplGMDJtzrRggEETAHM3bbWJ6ppB3SbWH13IHZxy9I71Sc3EWKKwH2eUxukg4
         0Qe1Xp900MGM5mJ573ZkonCWD9YDBkcLMkkDq8ezH38qSJAHTrJtPNP78nKBiPYRyySw
         vSxPwvarRlNopMoccbz9uYqn4ihPdbAiqcaMvIPPjlCa0d3eBD0qcyFU1QVrRPoGYrt9
         a89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686903062; x=1689495062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+nb5C/fzCmkNH4tFkgENtFMDkmGCOR2QUSuKVrANoM=;
        b=MUNcMOPQ/tw1aXky7n+llNsnBlRN7SG0BbiP7w3wF0iMKY+i/SiuAYJEI25E95mUia
         Z7a1b2ITAZ9ONI5bbopQZljkon1+tnL8weF2+oA+t+IPNYXBNHX8BJovuyk3VRAxtxHh
         j1TGzCvhUSIYkOOSsCFo1UpkqQL4oXNS9VcGqJittrWGCs33WEnek8Mq7c6YM7j6wXG7
         bY/kHMTlBhknDVV3F9ZqjxZ/8/MR/vPL9Wj7F12SQI2VDf/8GBPIFM8O2ZTgoaRVVSMg
         xKL9hhNUIqQdTiY2IkLnTNvuohaYuaAaYG/nM5FsOJe5IHxzBdNsi4J+H5e7n5M3r58q
         DfTA==
X-Gm-Message-State: AC+VfDzAZ4i3+IZtIlltS/5HOvAvaG4hACEnuOAShJeGXpIkYm9yA92J
        TfizZ5F0j5+UG5ZcToGm2YLhZg==
X-Google-Smtp-Source: ACHHUZ6DK25zXtnnsSAW02R2ilsBGImwvgHJkzYxnvXxZVHh9u1UxrheNHyrTDscWNmMYQ0v4zqmVw==
X-Received: by 2002:a17:907:928b:b0:973:cc48:f19c with SMTP id bw11-20020a170907928b00b00973cc48f19cmr1002834ejc.56.1686903062144;
        Fri, 16 Jun 2023 01:11:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id s24-20020a1709060c1800b00969f25b96basm10347260ejf.204.2023.06.16.01.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 01:11:01 -0700 (PDT)
Message-ID: <de774e98-0ae1-28b4-c0e1-6dc79905498f@linaro.org>
Date:   Fri, 16 Jun 2023 10:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: qcom,bwmon: Document
 SC7180 BWMONs
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230616-topic-sc7180_bwmons-v1-0-4ddb96f9a6cd@linaro.org>
 <20230616-topic-sc7180_bwmons-v1-1-4ddb96f9a6cd@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230616-topic-sc7180_bwmons-v1-1-4ddb96f9a6cd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/06/2023 01:46, Konrad Dybcio wrote:
> SC7180 - just like SC7280 - has a BWMONv4 for CPU-LLCC and a BWMONv5
> for DDR-LLCC paths. Document them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

