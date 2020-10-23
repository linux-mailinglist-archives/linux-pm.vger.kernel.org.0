Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDE929736B
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbgJWQUH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 12:20:07 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34495 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750290AbgJWQUH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 12:20:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id k3so1300793otp.1;
        Fri, 23 Oct 2020 09:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eV+szdSSexm2eZbasYH32iY3/QUzNUO+3O5Yc7X4Akc=;
        b=AKoWu5e+LZKIEJ9VSb4mvqENcD+oUq664/yz3KtUtwD+MQYgsA1vZsML3mNKquEDoy
         7NWws8zd4C7oAHY0zTZn5FlZqhhB7OGK67aO8DulUhhaFxexM3XMHC0V/sqjyhqlUZfX
         LmA3t7NmIPa+FZ6uIuHLZ3X/ZIuqfjPK88XxDn3FCdPgOed8hkfqA6dH3w+ckdh27Dsy
         B/5YWjKQ91RRFOPtw1Iu4jUHuA1upYVT8jq3J+A0XWkfQIwGEoBAJW6+9lT6SOWrOP1Z
         MPpl+qm801GqESZO1hKn8D86JdPcLA7Otv8/bNbIcwCOs7ZMpFHDaBSdO8tZRCoSkUoC
         KYGQ==
X-Gm-Message-State: AOAM533pV5Osf7bioGpl841WVt5Vw9v2K0/JWCRfnA0uT/wRofLiicsU
        8+eTp6mjEsT8glG5lVcNXA==
X-Google-Smtp-Source: ABdhPJy1uBpGC0Bl+8Rf9Nn2fxYXV5qIOleK+DNCPRip+n9QSQym8g8RThYOf3GIUtvEalTx/FJTXg==
X-Received: by 2002:a9d:2487:: with SMTP id z7mr2086163ota.133.1603470004848;
        Fri, 23 Oct 2020 09:20:04 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f18sm489648otp.10.2020.10.23.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 09:20:04 -0700 (PDT)
Received: (nullmailer pid 2807869 invoked by uid 1000);
        Fri, 23 Oct 2020 16:20:03 -0000
Date:   Fri, 23 Oct 2020 11:20:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v1 2/6] dt-bindings: arm: cpus: Document
 'mtk,freq-domain' property
Message-ID: <20201023162003.GB2800310@bogus>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
 <1603441493-18554-3-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603441493-18554-3-git-send-email-hector.yuan@mediatek.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Sudeep

On Fri, Oct 23, 2020 at 04:24:49PM +0800, Hector Yuan wrote:
> From: "Hector.Yuan" <hector.yuan@mediatek.com>
> 
> Add devicetree documentation for 'mtk,freq-domain' property specific
> to Mediatek CPUs. This property is used to reference the CPUFREQ node
> along with the domain id.

Okay, now we've got the same thing being done for Mediatek, QCom, and 
SCMI. This needs to be a common binding.

> Signed-off-by: Hector.Yuan <hector.yuan@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 1222bf1..06a6f5b 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -255,6 +255,12 @@ properties:
>  
>        where voltage is in V, frequency is in MHz.
>  
> +  mtk-freq-domain:

I expect this to change, but still not right form: <vendor>,<prop name>

mtk is not the registered vendor.

> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description:
> +      CPUs supporting freq-domain must set their "mtk-freq-domain" property
> +      with phandle to a cpufreq_hw node followed by the domain id.
> +
>    power-domains:
>      $ref: '/schemas/types.yaml#/definitions/phandle-array'
>      description:
> -- 
> 1.7.9.5
