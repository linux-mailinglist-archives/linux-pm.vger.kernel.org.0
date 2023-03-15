Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4C56BA90D
	for <lists+linux-pm@lfdr.de>; Wed, 15 Mar 2023 08:28:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjCOH2Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Mar 2023 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjCOH2H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2023 03:28:07 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09286C1A4
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 00:27:45 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so20109994edd.5
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2023 00:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678865263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z/SkUyeN7JdTEy0Qj/mCWvQVY1KWwS71k9YnqXB1log=;
        b=S2I/Bovwk6MD9GJQjboOjwMp7wQw/1opGFz7T3V3hJIPFx9NUNtD4TN3EWbvhJmPqk
         xcNxmbKfp+LJa9POA1MYrim3pOtAnkflGv2Ux9gmb4nrcWb4ZIVt2fO1BDmmBNnVxDwO
         XsxSbKVXE2WVnDXM6pYeN5cfyZ3VVavHYIOkCxjiWG46pFZSd04YUCl3i6EoiQVPVsBB
         LafRosFum2Z1jwxbGgpbnVYdB3w2TfjoJ0WHqt1At7bQQae8XMH6eyeChYydGO/GCqdr
         PIiXy5/FebWwy82UY9XeYB1aHhYjb6crarvTuqHhZV5moKnPRrZZ9PscFV+MHZTKijfb
         6Szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678865263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/SkUyeN7JdTEy0Qj/mCWvQVY1KWwS71k9YnqXB1log=;
        b=F0rTd7SRhBXI5hU8fdRL0PvatvWP7AMSrTNq8cFTTr0Ta2XRPthtM9eqEWveJJGbFz
         +FrDGx3t9W5XcMPqrtQf0LIbRNajegUTz+vOnCH54qFvPpDFtHk00WMJ0oJO9/UJZ7xR
         aB/sLOvGmq2oVqKYzTK/YbmwZYgHtjcxIIeSFg4+wD+3e3vOMkcD4ysaBdKtFusU3L7A
         w9ZfWTAoi3SUdP8gf9HoCHAEOXyZj30iWe4+/YWYHb29N/44FFv/qSrUNNItN3uQ68+u
         B1FQDnM15s1FsbysaOZHtpOVxmZG/YGG5shLvoknrKSLkoklbufLNQnYeW6hu65wCiW0
         Tyvw==
X-Gm-Message-State: AO0yUKVwt50JVmkklYU/TFf6eBJE1jtnnTAhQZ/qjDyDz3EMWasUEzPL
        Eq1AywZup81H0Q9UTGg2AswgLw==
X-Google-Smtp-Source: AK7set95mU87LP7BJtlTCh8X9w/xZKiLz6SptUVXxrzORn0KiScE3DK4zBfeDCVnvE1elmkagwoosA==
X-Received: by 2002:a17:906:dc91:b0:8de:acd1:90f0 with SMTP id cs17-20020a170906dc9100b008deacd190f0mr6639628ejc.3.1678865263555;
        Wed, 15 Mar 2023 00:27:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id ja19-20020a170907989300b008cf8c6f5c43sm2087815ejc.83.2023.03.15.00.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:27:43 -0700 (PDT)
Message-ID: <71d2e391-9949-db3e-e206-7cabd4aad406@linaro.org>
Date:   Wed, 15 Mar 2023 08:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/7] soc: qcom: icc-bwmon: Remove unused struct member
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230304-topic-ddr_bwmon-v2-0-04db989db059@linaro.org>
 <20230304-topic-ddr_bwmon-v2-3-04db989db059@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230304-topic-ddr_bwmon-v2-3-04db989db059@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/03/2023 12:41, Konrad Dybcio wrote:
> bwmon->regmap was never used, as the regmap for bwmon is registered
> through devres and accessed through bwmon's regmap_field members.
> Remove it
> 
> Fixes: ec63dcd3c863 ("soc: qcom: icc-bwmon: use regmap and prepare for BWMON v5")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/soc/qcom/icc-bwmon.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Put it as second patch in the patchset - after bindings.

Best regards,
Krzysztof

