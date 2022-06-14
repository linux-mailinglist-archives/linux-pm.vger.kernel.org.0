Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B925754BC1F
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jun 2022 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358391AbiFNUtW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jun 2022 16:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358472AbiFNUs3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jun 2022 16:48:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6DA4D252
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 13:48:17 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e24so9513529pjt.0
        for <linux-pm@vger.kernel.org>; Tue, 14 Jun 2022 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FKttehnRyWHLRCbEVc8BEN7Nq8NEnIEZrjC6GBkel28=;
        b=um790NINW6SPz/mn/uCi4IfD5Ys9JPSY1K1aZrlnkbmUzqLYmwHi3LhqMrH1CMne2Z
         KC1GQbI50hWzHdQGINwuocWoXQUznEf697nu/aC+ApZ3J4X1VedJ0djtz/LhhowKnLOs
         C298Np/0bxtkPr8F3A7e11bNdcDOHhNbzSOAFTw3XCv0UbrmoHwScsx0zG1zRlIHWgmk
         qyw2RN91dcC22l91sRTVUW3IfsUPvqqpl2i6d2vhiQlOdljYQrhAfQHTzlveycqdQGFU
         Mgux9dPpSS+r01oenXwo8Z4f4ICtbPLhZvNkmi7rQz1RbjarT1pkM0EKFs/rTA8oQep6
         ZTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FKttehnRyWHLRCbEVc8BEN7Nq8NEnIEZrjC6GBkel28=;
        b=Vz5e3q5El5QfWuZ5r0OgHZN0y/3Eayfh/t+pEb6E6ZWcLBkwik3tHkWEWa1lTm28Kp
         tntun0kTxn7VI8/hDiWMrm3kY23qnBQwOVSM4sYqRY0b/S0K7fdM6dAGpMuVZk56Xzpf
         N3lJlSRbJuZjuJGRCvs4sU7VS+QrarMS7Qi0PLb9zi8qjE6CGag8/XpXuHfoGYRV6Itn
         ExtBoAvIm3DyX/fq2P1lWBS5ua/rVaubsuFD/SEfidI6uQCVXfODE3JL6bMne59Sp728
         VcfFi2W6Oeuyt59IPHjzSwCG36hZirpkIJ+tF7QcU6KjBn+/UqkuGAQrpUh1UAUI9GRS
         ttpQ==
X-Gm-Message-State: AJIora+cb6dQYnR0cru50oeIHhMgJHIXlMgs/SP8V3DnemCHGCczMknq
        iDdVlHSf0Adxe8A6ACnY3eK+mg==
X-Google-Smtp-Source: AGRyM1uKnwL63QW7PW0eVtBoAjWN/m9SVuVEQ0O8Xlh8MD9grvwUrzxnRs6wLGish3Lq35jg0oPYfA==
X-Received: by 2002:a17:90b:3591:b0:1e3:25d3:e78e with SMTP id mm17-20020a17090b359100b001e325d3e78emr6345411pjb.29.1655239686545;
        Tue, 14 Jun 2022 13:48:06 -0700 (PDT)
Received: from [172.22.33.138] ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001641670d1adsm7684389plb.131.2022.06.14.13.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 13:48:06 -0700 (PDT)
Message-ID: <425477c2-7515-1402-f2db-66f15f09cbf4@linaro.org>
Date:   Tue, 14 Jun 2022 13:48:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/6] dt-bindings: mfd: Add mp2733 compatible
Content-Language: en-US
To:     Saravanan Sekar <sravanhome@gmail.com>, sre@kernel.org,
        lee.jones@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, andy.shevchenko@gmail.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20220614194225.2226447-1-sravanhome@gmail.com>
 <20220614194225.2226447-2-sravanhome@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220614194225.2226447-2-sravanhome@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 14/06/2022 12:42, Saravanan Sekar wrote:
> Add new compatible for mp2733 mfd driver.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/mps,mp2629.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> index f91acc42d652..fe13869e2c58 100644
> --- a/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mps,mp2629.yaml
> @@ -19,6 +19,7 @@ description: |
>  properties:
>    compatible:
>      const: mps,mp2629
> +    const: mps,mp2733

This does not look like proper syntax. Please run `make
dt_binding_check` (see instructions in bindings directory) to validate it.


Best regards,
Krzysztof
