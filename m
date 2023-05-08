Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6006FB839
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 22:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjEHUWf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 16:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHUWe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 16:22:34 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44153C1B
        for <linux-pm@vger.kernel.org>; Mon,  8 May 2023 13:22:33 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965e4be7541so731487566b.1
        for <linux-pm@vger.kernel.org>; Mon, 08 May 2023 13:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683577352; x=1686169352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o9p8sbbgU2nilbnlP81YasUbZB4uSHNla9W07vOiVuk=;
        b=gOTqOEm+mZGsJLVKVNSPiI+wK/x1/Xtnq83AHMG2oQTtLK1OpNmDfXqZvguOX5q9YV
         eeA70G67Q42cbv5efp3n8yR9/4ugw9poDZsYRggTA06kf9klBB+J5BzLapDEr87tEE5C
         QomCbi57zXd0CGCPdUESP3jmTQLXJK9SnWCWmsQ4D42pJrTjatnPLuR3g1uMxxgt8Qsw
         n4duUUfE6yYpDZm2/bCVI5fPai42+6HqtXBAgDJD0MvNOAX0XRls9aEGV83T7nk+ipnP
         aFhIT8F0Tra5O9xXGIJtWLVVOVl+//5XTqe18/e3FR/ronYuYdQYqQoB6HovUge7LeF+
         FJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683577352; x=1686169352;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o9p8sbbgU2nilbnlP81YasUbZB4uSHNla9W07vOiVuk=;
        b=IemmnB524V76Xtygb6jq5Kpz20eY/T4OzD6UMaWfmHVCooKFL5nAzbsp4+g3SUpFSY
         yGm/l86+RoHCI37R/zFIFR5tRRyOYA3tEPQ7kEtsAAuXOz1qUUfrt1/Upj1bYfyv3vCE
         X0+AlCYVThzizPvwlguPJYjOLJPOxdKSnyXwH7OJKJt55NaQHrzUDZDPbsB+3119K2GO
         owa94Zj84yEFqB+q4dIWBI06N6gEyalDH2+umCYF1ZkPT9Yuru1qPf6NErlCQxkS2eTW
         U1lvomE/7Nkwx7YzeLSUQQwWh9zHLKS/AIpOzstlLtVvQD7PON9D7U40p96PqKsODzhl
         uN2w==
X-Gm-Message-State: AC+VfDxYsvLygPnke1L89ZxghNuBt3GrAfkk/cmZ3E+eLTYTAKlxhbDJ
        wTNrsiq02HTM/YSm344J9+kH4A==
X-Google-Smtp-Source: ACHHUZ4YYd7EtlDPU+uVGzoZq9nt0hMyB7x08rbvKeuLpekdrE9lOzpUyueQY8dazhg3/T001VXj8Q==
X-Received: by 2002:a17:907:a41e:b0:965:e556:8f6d with SMTP id sg30-20020a170907a41e00b00965e5568f6dmr10793430ejc.63.1683577352113;
        Mon, 08 May 2023 13:22:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac? ([2a02:810d:15c0:828:d19b:4e0f:cfe4:a1ac])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906300d00b009659cdb2f98sm402301ejz.23.2023.05.08.13.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 13:22:31 -0700 (PDT)
Message-ID: <f0915bf5-992e-c6eb-e9f5-21980aa3cec0@linaro.org>
Date:   Mon, 8 May 2023 22:22:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/7] power: supply: max77658: Add ADI MAX77654/58/59
 Charger Support
Content-Language: en-US
To:     Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sre@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Nurettin Bolucu <Nurettin.Bolucu@analog.com>
References: <20230508131045.9399-1-Zeynep.Arslanbenzer@analog.com>
 <20230508131045.9399-4-Zeynep.Arslanbenzer@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508131045.9399-4-Zeynep.Arslanbenzer@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/05/2023 15:10, Zeynep Arslanbenzer wrote:
> Charger driver for ADI MAX77654/58/59.
> 
> The MAX77654/58/59 charger is Smart Power Selector Li+/Li-Poly Charger.
> 
> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---
>  drivers/power/supply/Kconfig            |   7 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77658-charger.c | 844 ++++++++++++++++++++++++
>  3 files changed, 852 insertions(+)
>  create mode 100644 drivers/power/supply/max77658-charger.c
> 

Actually, with small differences (register map differs by few offsets)
this is max77650 charger. Several fields are exactly the same.

Please merge it with existing drivers.

Best regards,
Krzysztof

