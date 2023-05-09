Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD5D6FCCF1
	for <lists+linux-pm@lfdr.de>; Tue,  9 May 2023 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234738AbjEIRnE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 May 2023 13:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234364AbjEIRnA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 May 2023 13:43:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB840F7
        for <linux-pm@vger.kernel.org>; Tue,  9 May 2023 10:42:56 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a342f7c4cso1087789366b.0
        for <linux-pm@vger.kernel.org>; Tue, 09 May 2023 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683654174; x=1686246174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+6CqfpUOuhBdIMyw09BZEvQUMlZ2hFOGBcV2c6lnR3A=;
        b=AjEyzOVffRUiFWnLDBmNtDe/ucBYt/5khszFHw6tm/dbF0kF3yzZgDjNA7WDufb08B
         uzBy9ZyTRlDCm7YRIi8rcQWsUH7AaZCYDQUon7B1p9b+WAg86sk5zRyPGwCWdNiBR9vG
         4J6STzl4OmM1bvOBmyOdfigRKfVsoa9lpD4eoMDeM0qU6Y4VRnkyvVpjM6TXtGNz2Lzd
         38dlZmByEUfHcyaZ9bG1lwe8TP4cp7Mi4jn4eXkR9fSIuUclx8PW+Wo+m5XfQg8qmn/I
         tsOBOl/zE6tghsvD+kr1FZgTsDjA+hbYVRXl0yAt7YcEP0sU4rkwuoq8GntYvtDRB0AS
         JjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683654174; x=1686246174;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6CqfpUOuhBdIMyw09BZEvQUMlZ2hFOGBcV2c6lnR3A=;
        b=ZVc+TSyxamRT/rCPO/x60JoaSKb7kkre64ygcy5ZspD50MdX19UVW+eeHUwc1+HEKF
         XZLIAgV2wBLQU6HXFYREmTnR0fr3BpMSUsnOOR1xybgnNPoGEeOqclLPWri+jF93sj2z
         gR98TC2q86Ql/SW7Ab4t2oGVEbSPgXhYVDCwNcqovhVmVWrQzmVlsR07RSVBcilpZFFM
         idFjBhXDeSDUWnePj5OmKj48l0P8uuSKm3ToqBhtvWkCtKc3yWqaghcDA+gx2eTRimOx
         ZV+PfY8aZdAS+DeSI4DBUHjLvUK/VoIE4L4AyCw667wiuiU8H6t8K/Nalynmqry6x0VI
         7Q9g==
X-Gm-Message-State: AC+VfDxFnZVFeSntYf/LBaj9GcLO5gLh17SOEchBTA8UxCltz2VXChz4
        2bONdidQ6ovFp1Xq50z6Wz8Ngg==
X-Google-Smtp-Source: ACHHUZ5BzzC72uJ14K+MspznYU/rIVE1+W55VLdtM401cMlKeEaJ5ckngVP1kmYaHsBg4uUNYt4FlA==
X-Received: by 2002:a17:907:72cc:b0:969:9118:a98f with SMTP id du12-20020a17090772cc00b009699118a98fmr4852570ejc.10.1683654174473;
        Tue, 09 May 2023 10:42:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906300d00b009659cdb2f98sm1574510ejz.23.2023.05.09.10.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 10:42:53 -0700 (PDT)
Message-ID: <193f3489-4937-6d4a-2466-a67d335ac37c@linaro.org>
Date:   Tue, 9 May 2023 19:42:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 08/13] Revert "phy: Remove SOC_EXYNOS4212 dep. from
 PHY_EXYNOS4X12_USB"
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        linux-phy@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230501195525.6268-1-aweber.kernel@gmail.com>
 <20230501195525.6268-9-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230501195525.6268-9-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/05/2023 21:55, Artur Weber wrote:
> Support for the Exynos4212 SoC was originally dropped as there were
> no boards using it. We will be adding a device that uses it, so add
> it back.
> 
> This reverts commit fee7e1d50c6e6da1d99035181ba5a5c88f5bb526.

Subject:
phy: Revert "phy: Remove SOC_EXYNOS4212 dep. from PHY_EXYNOS4X12_USB"

I assume this will go via phy tree. If not, let me know.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

