Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B985F730484
	for <lists+linux-pm@lfdr.de>; Wed, 14 Jun 2023 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjFNQDq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Jun 2023 12:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjFNQDp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Jun 2023 12:03:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6701FD8
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 09:03:42 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-977cf86aae5so127281266b.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Jun 2023 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686758621; x=1689350621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG7GTQgO4U8Gfa8/JEgViBYrjpOcl0FQHUgJrFGTTXc=;
        b=k1+0L5TUKQU53uQEuEzjlsvSqT/pg54zgEsqYv7HuXf2ZldT4Gl15LDTFJx2yL1PAz
         5PPt9zUiFaZo4QBBakwNfM30pbhOK6VVfMacmC7ofwWf4m6yeUFCvuaD19pxYmXFhEdw
         biR7FVRhDdOjFwYjUATs5bBAzlJZNq0SkzXPIOq7wC9aaHrcdv6amlm8ZmPneOtY1C6b
         C4USijDjnsHKJzoNY2sXkYxgDXR8Pw4s9EbKd8fBgNBx6wLGi4mKHmY9zeeoGJf7YnN0
         4DtsGnX8iaXF8v5nh0YLQ7ExggPmAxCjUMjyZ/eBMUrAYJAtqUcKH7Fz0piVia2L7a+r
         AQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686758621; x=1689350621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xG7GTQgO4U8Gfa8/JEgViBYrjpOcl0FQHUgJrFGTTXc=;
        b=AFu7DDPnuFb77rEcWJUrC38EdkiE5D3YLQCrowuEWc0MMSMh20vzRP37xAu4QLkQf5
         4fOH0x8vhiC+yB+bvXjO6Uzc5IIbggCQi8HsVRaWCB0N96AK87ywzks2w6XiBMHhrQdi
         toOLkOYwE9QAcbcVqxdg2znXl0igzY2h4/wvWwdCzB9pVPpC2wKp8C/BHjyq+Ze8qekE
         /4y2NEXPpTzvzD+hGikskfk0qxtG5ILNUeM5yDNLz3EymdVlpCNh8GoscX/pLBriuNnD
         /2C+wOA75cMJRXi31f/dXB+bet9oRXMzbAe6579RZgbtuK4LqfOnvHWJnvpOrfHbw9jX
         6yVQ==
X-Gm-Message-State: AC+VfDzUoBorIUK5zzg+ZjUhazzFE1LDSojX+nzx02Got9+gSBnxGWa5
        MxXwUAxDFQT9UEo4sZe0Lq9Iew==
X-Google-Smtp-Source: ACHHUZ6lxHKaF2zktAGigxotv/T9i4Hf5It3hZSehrbftZ/cM4r3pQftAr3Gt0dpXOA5dcbB9EELAw==
X-Received: by 2002:a17:907:d8f:b0:965:ff38:2fb3 with SMTP id go15-20020a1709070d8f00b00965ff382fb3mr14970141ejc.74.1686758621213;
        Wed, 14 Jun 2023 09:03:41 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id gj15-20020a170906e10f00b0096f4c9ce526sm8244536ejb.225.2023.06.14.09.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:03:40 -0700 (PDT)
Message-ID: <b30575b8-2e34-2757-9cae-ee5599ac13b5@linaro.org>
Date:   Wed, 14 Jun 2023 18:03:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/18] dt-bindings: soc: qcom: merge qcom,saw2.txt into
 qcom,spm.yaml
Content-Language: en-US
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
 <20230612053922.3284394-3-dmitry.baryshkov@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230612053922.3284394-3-dmitry.baryshkov@linaro.org>
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

On 12/06/2023 07:39, Dmitry Baryshkov wrote:
> The Qualcomm SPM / SAW2 device is described in two bindigns files:
> arm/msm/qcom,saw2.txt and soc/qcom/qcom,spm.yaml. Merge the former into
> the latter, adding detailed device node description. While we are at it,
> also rename qcom,spm.yaml to qcom,saw2.yaml to follow the actual
> compatible used for these devices.
> 

You also dropped "regulator" property. Please mention in the commit msg why.

Best regards,
Krzysztof

