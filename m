Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB1D6C60A3
	for <lists+linux-pm@lfdr.de>; Thu, 23 Mar 2023 08:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjCWHZE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 23 Mar 2023 03:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbjCWHZB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2023 03:25:01 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07219F945
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2023 00:24:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id eh3so82550264edb.11
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2023 00:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679556292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aipvafjjLK97hQq1M1+aKFzj870eMIthafBNa1UlW8=;
        b=vk1y0qQErHF68pGQeFp0zAZpHLDTx1HEIumAlovxGxapd/P6cSY2mCSFWB2ywwocLA
         b65AkCuIalo8x56dK5U19TpcWMokTC89gIBj4XNPtDzI5CUnwg25aKDTjBxjdhm73u/o
         ESe8pwhgbFt+kBLTCbRJfvyBe83G70vR8yMwCRGkChYCDgdqQrcEh1eSZstIDVtuRGzR
         1nR4/hyUNoj1kk/UVG4YZZZwZi22MxcH+MQLYT+2h3to8JWPdm9qHnEqtStFJBn4HvpO
         rvm/ZeHcKcphBmqDDKYUzFmKv/IAjQE7BoKvW9Bsxbd+hDpjuYQQ3Y80xenV3zzmItST
         sNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679556292;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aipvafjjLK97hQq1M1+aKFzj870eMIthafBNa1UlW8=;
        b=Q3IFc0TQnGZ4R46dqOuWI6eKXtfcS5CYQQJcE7nQD6VeJ1RDUbo+KWfaPGcr0apJBZ
         iIGBsthWce3G6itzAaTQ2jkzerdWA3xkMY+hYZt3D2HKCJ8hyMK7CVIDqbZDpfco/pqr
         DBMzXZRhg8GPPH6ywd8gNj5DwI9bl9UPb6eJ8cAKB1hfL8HY1dhwMAbEj97ijA2XGnBk
         4CBQcn+jASHnXse1UYk5Bw+gCODZBHrzMholM1cj+to75O9Hqo98QUSoHJsqIxCTL+uH
         0sChG3eGz2ws4UNCW56UvKcYWn8qPwlx4TIdcsfano91SaBXsdfZqeUvHtjCBYanGd7O
         4XTA==
X-Gm-Message-State: AO0yUKUYGfhFODPAxh8RNIM9cLBnuM+i6OOO9vWxC8aL4B7YA+Tjm1SW
        djpDfjPk42j6thkfW5+2akuRyw==
X-Google-Smtp-Source: AK7set+NHWIImjZM/jhw7kzYeLDU9oIoj0+1vEz6iQvj2UjTwMEq7W3rX4D6U12tbtEWu4QfT22UIg==
X-Received: by 2002:a17:906:7cc8:b0:8b1:78bc:7508 with SMTP id h8-20020a1709067cc800b008b178bc7508mr8885663ejp.20.1679556292531;
        Thu, 23 Mar 2023 00:24:52 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id n15-20020a170906118f00b0092421bf4927sm8381102eja.95.2023.03.23.00.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:24:52 -0700 (PDT)
Message-ID: <dfa8d83d-9254-4793-92b2-f247fb08b698@linaro.org>
Date:   Thu, 23 Mar 2023 08:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/2] dt-bindings: power: supply: bq256xx: Add
 ti,no-thermistor property
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Davis <afd@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel@axis.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org
References: <20230323072347.438932-1-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323072347.438932-1-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 23/03/2023 08:23, Hermes Zhang wrote:
> Add a new property ti,no-thermistor to indicate that no thermistor is
> connected to the TS pin of the chip.
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
> 
> Notes:
>     v2: change property name to ti,no-thermistor

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

