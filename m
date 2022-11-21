Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7A631DDD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Nov 2022 11:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiKUKMO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Nov 2022 05:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKUKMI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2022 05:12:08 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF12FD2
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 02:12:07 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id j4so18144298lfk.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2022 02:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xaQItgrdYIVN8y4IiL78CH906u8RuKnqveTnqxQydIU=;
        b=DfjM+nmHNytVt0a46Z44pTEojQejIbRtaA2L+SmupFELG59tLVOjOYl2AzpvW0h8eJ
         y0UFn50LZOqUqp40AuNIhqRJS0siNvxiR9DhjCAJynrR1ptytTRm1yX4W8kidQz1DMav
         738I4fmthWfJ4VpXFkkjo5k6MsLbZIeL6jU7KLvQNRwElZjL22fkTPYxYhqx7mBYYrqY
         mhDCveEzdktm4MRuMnueHeeBJj5hOG3I2LjgZOmXNsdi4F9VIL6L/KGPPUVk4IISdAVE
         FZPbE8g12n5N/G7qkpNppfVViNpJ/uL2O15dnzl0MmKh/vH9+pFyc9befqe1mZxyixYX
         DK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xaQItgrdYIVN8y4IiL78CH906u8RuKnqveTnqxQydIU=;
        b=HkP0O6iwDxw/bMa0TALo1r9HLKFYr8gMURaaQvIC/+rrTjmDr7uoHbNUoSvFtjB0uv
         AqutECm72hmYdrgrIKcSiYtezj5soSWGqAwa7foxmoMuJM3ZEVqz1ggWVXn6JkRmuGZV
         GVmCRwXX068EohyyUD0hpxn4rT+FW83qTzFF9eNOfejjLTbbGWSQkkrJSnQPgLb52Iv9
         xNTp05BFwSavX4D5k5vTY+oOgyqKrQq0NAYlFIysbpffOk2qX0zPk4oPB+Ae44/HypiO
         59V6XJldzjrA3GyQycCnSJFagbKMBv9uIeBTD2z44/TUaN5XoBvewyjjq1piHUCVGbgC
         oRLQ==
X-Gm-Message-State: ANoB5pmJC/H/jvyVnSEmsSUZbXWXFf5ihvzekXRdvN9QaXeIBYxigBed
        cWpyoywSePNjVM+6rjrB7MPAgg==
X-Google-Smtp-Source: AA0mqf4fGmgMbMZYKx244ev1c3tbLEvPukstzdeWn86r/06SB7n8qvYGFvW3uaoVcEH+KHuEG8NCJQ==
X-Received: by 2002:a05:6512:3a7:b0:4a4:77a8:5ba1 with SMTP id v7-20020a05651203a700b004a477a85ba1mr5241105lfp.569.1669025526220;
        Mon, 21 Nov 2022 02:12:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z19-20020a056512309300b004a1e104b269sm1960165lfd.34.2022.11.21.02.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:12:05 -0800 (PST)
Message-ID: <bc853d76-5b65-676a-040a-edf53034c9ad@linaro.org>
Date:   Mon, 21 Nov 2022 11:12:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/4] dt-bindings: power: Add StarFive JH7110 power
 domain definitions
Content-Language: en-US
To:     Walker Chen <walker.chen@starfivetech.com>,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20221118133216.17037-1-walker.chen@starfivetech.com>
 <20221118133216.17037-2-walker.chen@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118133216.17037-2-walker.chen@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 18/11/2022 14:32, Walker Chen wrote:
> Add power domain definitions for the StarFive JH7110 SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> ---
>  include/dt-bindings/power/jh7110-power.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/power/jh7110-power.h
> 
> diff --git a/include/dt-bindings/power/jh7110-power.h b/include/dt-bindings/power/jh7110-power.h
> new file mode 100644
> index 000000000000..24160c46fbaf
> --- /dev/null
> +++ b/include/dt-bindings/power/jh7110-power.h

Filename matching compatible or bindings file.

> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: (GPL-2.0) */

Dual license for bindings.

> +/*
> + * Copyright (C) 2022 StarFive Technology Co., Ltd.
> + * Author: Walker Chen <walker.chen@starfivetech.com>
> + */
> +#ifndef __DT_BINDINGS_POWER_JH7110_POWER_H__
> +#define __DT_BINDINGS_POWER_JH7110_POWER_H__

Best regards,
Krzysztof

