Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F6851F96D
	for <lists+linux-pm@lfdr.de>; Mon,  9 May 2022 12:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiEIKNf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 9 May 2022 06:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiEIKN2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2022 06:13:28 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792E236765
        for <linux-pm@vger.kernel.org>; Mon,  9 May 2022 03:09:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k2so18674151wrd.5
        for <linux-pm@vger.kernel.org>; Mon, 09 May 2022 03:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8mW1LB/3xk/JFr5DRDA+1iyfluKPG+C8OWci7XLHlOI=;
        b=xhgL6RYHPSjOvHktvcvis+SsBd4qfCzbxNj2mGWp4Imaj/miEK6wEwpxRErSBp7QgY
         LRJPtqEp/zPAnZ4oqysJNHwAsSqBTCGaw2+qiUqFyN0UMe3VORKOToHRxp3VglZ+GQc1
         VZZgI/1PVjvWNTFYtVKSTrYuGWbHVpEj7a8Jk6KTIngIBDw56oreVnpV9LQtjKSQs8cn
         1bJVnZBlinMPamM9Rdwzv26iqqrdnJuC6U89oY4bvhkt552ZmmK6Khe/YIJl2QnSe1xz
         0j+IoExELihv7+IXx6DwTRDMnyjavidRFhV1ayJS0wz6cb/o5cphekdrFl8oxIokrCbN
         wi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8mW1LB/3xk/JFr5DRDA+1iyfluKPG+C8OWci7XLHlOI=;
        b=TNyW8SlMhV3Z4EUkwWlrGQ9x6XyP3rGHa6VXr2ovZeKP1/6ZwQ3h0uuRza2F0y9uyL
         fRdoAA81Sd+6ZvtiA7Cm2HYqwyASYVjlzFLbEmjRQJODLFhf9UF8nT5NAeOr6sB37Ld3
         MS0ugovb5Ukr7vUIcwxQrODUthisIJqd1j5zaizocYgLbCBnOJQ2+N6RNO8fzIPkLpe7
         IyRn0v1NQYwyTuVDu1T+aKLmhUqrh1gsxzK4PLRGZz6rVk4mEl/5T+NODESFzPw35jO1
         xy0gVQzQ+qwAoLMvSbUDuICnxdVdpaQqWOwREfKyTUyYoJvsMnzWHM0dzLI8QY37ZN4M
         YRig==
X-Gm-Message-State: AOAM533YYrtQtUFCnMJODj4edUCAIYOs4ESEWtd1i1508ObMSGdBe1ka
        /CgT6KxLVvB5VOZylx3zmmNX7Q==
X-Google-Smtp-Source: ABdhPJwxF0svyy4gCUu4jIp+gkqJ//alRcrgGzNmiSDwD0S1Uo4GaJvRo2JaI+B3ChfLEecBLzlrng==
X-Received: by 2002:adf:f3cb:0:b0:20c:8afd:9572 with SMTP id g11-20020adff3cb000000b0020c8afd9572mr12775063wrp.179.1652090822719;
        Mon, 09 May 2022 03:07:02 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id b12-20020adfc74c000000b0020c5253d8e8sm11114014wrh.52.2022.05.09.03.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 03:07:02 -0700 (PDT)
Message-ID: <49f1e84f-3769-ae8f-b8de-4a5315110f5d@linaro.org>
Date:   Mon, 9 May 2022 12:07:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dt-bindings: thermal: tsens: Add sc8280xp compatible
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20220503153436.960184-1-bjorn.andersson@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220503153436.960184-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/05/2022 17:34, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform has three instances of the tsens block,
> add a compatible for these instances.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
