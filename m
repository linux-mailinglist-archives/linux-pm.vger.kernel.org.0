Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163647A4970
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 14:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbjIRMT0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbjIRMTF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 08:19:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A7A8
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 05:18:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso586816266b.2
        for <linux-pm@vger.kernel.org>; Mon, 18 Sep 2023 05:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695039538; x=1695644338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y9rNikTX4JSjtk+QKNWAhJm6If3F+GFPL9rgnm3nUG8=;
        b=ekTmcE8KOaXblvuT8PoHygGN2Uf3V05zTHIdq3AuJnUmZ6vhyUIDHv35UArTF+uYiy
         UTYW91mkFcM2fupipOatMCmv35gIxolbsvlSxYi7/cws99jvLoI7G2G418aAk2H8X16D
         lzUW8JC3s/tzwnSfBL0Vh2aKLYZZMn+k5ImNi+iay3tAIlIIWwqynkfkqr1UIwSrVPgQ
         5XYJjFIAixOTp6gc6xEOgFUhlbNBFTwnWzmyn+b0NpwqEVYW+pUZp5/5qpWBmzF0k38X
         seXA48r4SRLT+n0UnsQD2RR5F2rFX2DvcNi1Fq273IPby2UTdBR3/l9yoCvdwgb1bn9x
         PVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039538; x=1695644338;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y9rNikTX4JSjtk+QKNWAhJm6If3F+GFPL9rgnm3nUG8=;
        b=fAbeStDExkzQdi9rQB/tXZjnGrFakmrVLO6pyW6lh1LYvHOZ1otzF/Pd2Y2+lz4/tx
         94QXz2eVoO6X7MuUbI8Wvh04VyTifTPmjg36c9KPb3kVQhqbnuiBv4xMEJfZqHuw3qu8
         LsGY3Lzw6okZX7IAgh9F+Esshli9FELjh14gCRfxefC9S6+JcyX7ImFp/im32qDEadbK
         mlCMVHKE6VXHAj1Ba57oPp/MCRA2aK+wraYjke7mYulGd6rHlnWnrYQTmcVnu1NvMCDm
         frqzGXa6bSR7R0aOD0gu52lJh7xjbcULgBjvDp4X7gdCo4HwE+roMoLArLUQZbFNadnt
         iVnA==
X-Gm-Message-State: AOJu0YyU8HF1DOvZWfao38vlKOq6vW91SbqmX6S3KdP4Luw5nlZNywbr
        NQis57whuWDOSoIJ0U3mRq8tA4/20kMmg8P8L4ONp5ZD
X-Google-Smtp-Source: AGHT+IGgMcUlrxzNfqqHe78YYSvX3aV3pVOIM49svcB/97itt7dCfRegpnWl2b3r6JsMSitWyjekwg==
X-Received: by 2002:a17:906:32d6:b0:9a1:ec3d:8ffe with SMTP id k22-20020a17090632d600b009a1ec3d8ffemr7807813ejk.18.1695039537709;
        Mon, 18 Sep 2023 05:18:57 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id a18-20020a170906191200b0098e42bef736sm6399192eje.176.2023.09.18.05.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:18:57 -0700 (PDT)
Message-ID: <289ebd53-ed20-c5df-5b99-754de5a0ccf2@linaro.org>
Date:   Mon, 18 Sep 2023 14:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dt-bindings: power: supply: Drop deprecated
 ab8500-battery
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230917190124.1012316-1-sebastian.reichel@collabora.com>
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

On 17/09/2023 21:01, Sebastian Reichel wrote:
> Linus Walleij modified AB8500 to use the generic simple-battery
> and samsung,battery bindings. This is an unused leftover that
> can be removed.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

