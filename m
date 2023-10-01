Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537EF7B48A7
	for <lists+linux-pm@lfdr.de>; Sun,  1 Oct 2023 18:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235194AbjJAQsP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Oct 2023 12:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQsO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Oct 2023 12:48:14 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86BED9
        for <linux-pm@vger.kernel.org>; Sun,  1 Oct 2023 09:48:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9b2a3fd5764so1215403866b.3
        for <linux-pm@vger.kernel.org>; Sun, 01 Oct 2023 09:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696178890; x=1696783690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zomMtbkoNs/DKHx2Dap7ItwtUcBSlDhdfQANZJTKOMg=;
        b=L6ubMCxmR1LT+b+FhSmR5DkUXJtXi+iY8FQBLtan0duWnC3f7HltPDcqi2shSjJhbx
         hl8k2myPcLpGcVPupafNSoJL/iwfCe3PqOES16+rt/roZd0HArkF+iXckENh9GxgjEdM
         ktlUXJDCG6g8RiqfQhB96DwCgqUNE2Hw9VVfmy+NrdrjazvCUgrUfhk+jzKKtzvNtYpr
         UR04TEdwEiD587KpLQhp0y9ahdl1Q9qL5xkn5p7p8BkQsC0EaDXlxByCIuKW21aTuVDZ
         DCVVv8EpovE2wS+KYQwVb3+ZcBF+xsN/g0bKPoryrOXcJR9HaY3Rg3LiQ+hFPd5Rkiap
         ELbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696178890; x=1696783690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zomMtbkoNs/DKHx2Dap7ItwtUcBSlDhdfQANZJTKOMg=;
        b=uZ8d8uCodcbf5jX11mzSBYb+2qZNwaNzYcbA3MCklr9VQLLmoRBc74Pd6jCRLq1bbS
         jnF7xNJ03QG/utBL6p9Lmi4XKyUqjAd8VpMNJNSti+BnCnuojfivMFFps3mKNgbyObPc
         cDrFwDhx2ZNFEQS9NOt2uL88zjxeYBJ3tkNlGsMozMjYSLc0yJTyAoC+zta9XV+cJbnk
         ++Omgqlfsja9K1v/VuZIN1+/Sb3FMrrzeoIu8D5856R0ArW/bKSt6lRkdMdC6GOIZhsW
         3hsswXHTmeYborl7ai2AIKR/TPEB0rRmUMAb746XzNPpmu6NzE9VOle1q0W4lYLvYhSM
         ckQQ==
X-Gm-Message-State: AOJu0YzZ8xSwKgCtvrAOgtvTKmwhmdI9oN8KwBa6IFScVaB0W5LoM7+R
        XoWiOV6IV0WRXn0ThjtGiRU+bg==
X-Google-Smtp-Source: AGHT+IE0aNyZI1rgE9NWbvRTli9mAmGIdHbRYMeWiBQrd9BwR4LsxfYgllYXMVPcGg2F6WzaM5hecg==
X-Received: by 2002:a17:907:2cf8:b0:9ad:ae3a:ed01 with SMTP id hz24-20020a1709072cf800b009adae3aed01mr7639475ejc.2.1696178890046;
        Sun, 01 Oct 2023 09:48:10 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05600c204c00b00403bbe69629sm5621117wmg.31.2023.10.01.09.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 09:48:09 -0700 (PDT)
Message-ID: <43ac7981-49d1-b1a3-c63e-5d304af9350b@linaro.org>
Date:   Sun, 1 Oct 2023 18:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/3] dt-bindings: thermal-zones: Document
 critical-action
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231001030014.1244633-1-festevam@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20231001030014.1244633-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/10/2023 05:00, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Document the critical-action property to describe the thermal action
> the OS should perform after the critical temperature is reached.
> 
> The possible values are "shutdown" and "reboot".
> 
> The motivation for introducing the critical-action property is that
> different systems may need different thermal actions when the critical
> temperature is reached.
> 
> For example, a desktop PC may want the OS to trigger a shutdown
> when the critical temperature is reached.

 From my POV, 'critical' means kernel handles the action. We can not 
trust the userspace at this point.

The 'hot' trip point will result on a notification to the OS which can 
then take an last resort action before 'critical' kicks in (suspend, 
kill process, cpu hotplug, whatever)

> However, in some embedded cases, such behavior does not suit well,
> as the board may be unattended in the field and rebooting may be a
> better approach.
> 
> The bootloader may also benefit from this new property as it can check
> the SoC temperature and in case the temperature is above the critical
> point, it can trigger a shutdown or reboot accordingly.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes since v8:
> - Go back to putting critical-action as a thermal-zone property. (Daniel)
> 
>   .../devicetree/bindings/thermal/thermal-zones.yaml       | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> index 4f3acdc4dec0..c2e4d28f885b 100644
> --- a/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> +++ b/Documentation/devicetree/bindings/thermal/thermal-zones.yaml
> @@ -75,6 +75,15 @@ patternProperties:
>             framework and assumes that the thermal sensors in this zone
>             support interrupts.
>   
> +      critical-action:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        description:
> +          The action the OS should perform after the critical temperature is reached.
> +
> +        enum:
> +          - shutdown
> +          - reboot
> +
>         thermal-sensors:
>           $ref: /schemas/types.yaml#/definitions/phandle-array
>           maxItems: 1

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

