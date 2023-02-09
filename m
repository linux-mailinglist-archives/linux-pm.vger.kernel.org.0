Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF56A6913A5
	for <lists+linux-pm@lfdr.de>; Thu,  9 Feb 2023 23:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjBIWpF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Feb 2023 17:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjBIWpD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Feb 2023 17:45:03 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262E94B1AF
        for <linux-pm@vger.kernel.org>; Thu,  9 Feb 2023 14:45:01 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lu11so11070802ejb.3
        for <linux-pm@vger.kernel.org>; Thu, 09 Feb 2023 14:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VyDWUrztbgFwlIvsJFzPjp39A/vmSkMB6yGFg9/7R7g=;
        b=a7VbZDZ9LlplVn6DkvWI53f+eYSvwVYLIfYa4y8Fh+DZ1yqnlI23OJtJAc+I1I3g7s
         PwnAgMpi713Gf6tsnb3HFPoWKrziGfAqe3ogF/1+OedCTBC5fU7jmSLe6YYsnBZI46ri
         2FRNuY0PNC++3/bBZZpU3w1JEWkhO1dj1fJ8kIqHrogQmwiDN9+b+AUWuEXOptovE+IE
         c9WvotEGOs/NQdvQmuyA00SAOuPUcngCcomR5wwxZ82E3fNHE8DTO87tYVgbykz2rf1W
         PYQaHa3nMc4rPm0to6zrmv7u35lJOpynnKNkC+1QZTITmsPxpxpx/eiFUF64Zj6vpLAN
         aQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VyDWUrztbgFwlIvsJFzPjp39A/vmSkMB6yGFg9/7R7g=;
        b=ogKBP9ymgaiRxzfV+3BZa4pHdC1Z5OZXMegAIEkDlT/6ifCBOas85xWq4PcddXoVXv
         pYO6qqfKpsk3ollzsrsy2uPN9iOOsp/yOH1l4V/93PH6WqsG2kDGAtvxjr4te7k4AhXX
         QYwjyEjR0ELLdYMbkobR0ieCznxqYzM+UriW4pAx7FTcSUq3wrn3zr3QPuarIIye21iH
         H9/KY7QXQbyZ1UZeKVld3OryOxv40Ocml/Wxl9/FSdlnPRN4fIMZMmTkxqI7I5OcLSP+
         h1U56NU9bzgF0NAJROsue30+LixN3Olt3meBny1Js8tgawml3PRqhTrBSpOgcsVJjWSR
         kpBw==
X-Gm-Message-State: AO0yUKWeC307EOQR/hJP9sUacturhf0tEQ9l/qbLCoP4qQ/RcZdUV02u
        G8X6RVxf9Fs/szOo4uANMzScMQ==
X-Google-Smtp-Source: AK7set8lrfQop3nJu4PGRzMJfEQOX1MuZ0erjBkaR+He1Cj8SwMKepaGOem3o7BlOHOhSpE7Bb3uDA==
X-Received: by 2002:a17:906:1286:b0:88f:9c29:d232 with SMTP id k6-20020a170906128600b0088f9c29d232mr13576848ejb.57.1675982699769;
        Thu, 09 Feb 2023 14:44:59 -0800 (PST)
Received: from localhost (h-46-59-89-207.A463.priv.bahnhof.se. [46.59.89.207])
        by smtp.gmail.com with ESMTPSA id n1-20020a17090625c100b0088c224bf5adsm1466525ejb.147.2023.02.09.14.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 14:44:59 -0800 (PST)
Date:   Thu, 9 Feb 2023 23:44:58 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: thermal: rcar-gen3-thermal: Add
 r8a779g0 support
Message-ID: <Y+V3arOqT4eW/g5k@oden.dyn.berto.se>
References: <cover.1675958665.git.geert+renesas@glider.be>
 <11f740522ec479011cc8eef6bb450603be394def.1675958665.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11f740522ec479011cc8eef6bb450603be394def.1675958665.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2023-02-09 17:11:53 +0100, Geert Uytterhoeven wrote:
> Document support for the Thermal Sensor/Chip Internal Voltage
> Monitor/Core Voltage Monitor (THS/CIVM/CVM) on the Renesas R-Car V4H
> (R8A779G0) SoC.
> 
> Unlike most other R-Car Gen3 and Gen4 SoCs, it has 4 instead of 3
> sensors, so increase the maximum number of reg tuples.
> Just like other R-Car Gen4 SoCs, interrupts are not routed to the
> INTC-AP but to the ECM.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  .../devicetree/bindings/thermal/rcar-gen3-thermal.yaml         | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> index 0f05f5c886c5fe1d..ecf276fd155cfb27 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.yaml
> @@ -28,6 +28,7 @@ properties:
>        - renesas,r8a77980-thermal # R-Car V3H
>        - renesas,r8a779a0-thermal # R-Car V3U
>        - renesas,r8a779f0-thermal # R-Car S4-8
> +      - renesas,r8a779g0-thermal # R-Car V4H
>  
>    reg: true
>  
> @@ -80,6 +81,7 @@ else:
>          - description: TSC1 registers
>          - description: TSC2 registers
>          - description: TSC3 registers
> +        - description: TSC4 registers
>    if:
>      not:
>        properties:
> @@ -87,6 +89,7 @@ else:
>            contains:
>              enum:
>                - renesas,r8a779f0-thermal
> +              - renesas,r8a779g0-thermal
>    then:
>      required:
>        - interrupts
> -- 
> 2.34.1
> 

-- 
Kind Regards,
Niklas Söderlund
