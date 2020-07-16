Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBAE222EAC
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jul 2020 01:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGPXJg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Jul 2020 19:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgGPXJW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jul 2020 19:09:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB68EC08C5FD;
        Thu, 16 Jul 2020 16:04:54 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k23so8069059iom.10;
        Thu, 16 Jul 2020 16:04:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eDT8ZBhNeJbznzfPJdQt1GGooj/iP+F7BcxCoXIsS98=;
        b=ZO/ZUOOKENY4J7SKNW83pfoweXvjpCYUuMVcEOOM8350v42vBjpuim6/Z5Grl3HWrl
         LQ/0XYZ9uSE8b8c1HOjVYq/AaFSu0bd5J28AfyLx/sEs2AygquWIXma6os8cTsLUsYHN
         iEP6IfnxgTouvXt3p8JcIaQEFpXmdj00qamIY2IYAmcf3aoDh2EPWjMG+aJDy4VkQjUl
         i4hAtJVulCm9a2vW++ZItkCB1T+El/LMxpgbX5rv3fQulQQFP5Ha79+Ubamb1hWACczk
         /1T4YfE8r6gcfpWEcC43LNk/+siPwOrtZGoEb1wIjEAGtKI5WBKDO1eTzEgI1VyZ4fx/
         OjYg==
X-Gm-Message-State: AOAM530ClT62bp3RYyXQZGgW/EFfChGQDRjhvabAr2O5Dd+IDIxeXK20
        po6Le+9qMXA681wW6IzjNw==
X-Google-Smtp-Source: ABdhPJxtvwZsJGPyF4/aHmjE6iE0550P7hSG08wHNUdd2IYc9L30ABvSfVU3gTVaBW7qJaETeEmXVA==
X-Received: by 2002:a05:6638:223:: with SMTP id f3mr7706474jaq.144.1594940693894;
        Thu, 16 Jul 2020 16:04:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q2sm3358270ilp.82.2020.07.16.16.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 16:04:53 -0700 (PDT)
Received: (nullmailer pid 3053333 invoked by uid 1000);
        Thu, 16 Jul 2020 23:04:51 -0000
Date:   Thu, 16 Jul 2020 17:04:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: uniphier-thermal: add minItems to
 socionext,tmod-calibration
Message-ID: <20200716230451.GA3041278@bogus>
References: <20200707102338.989660-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707102338.989660-1-yamada.masahiro@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 07, 2020 at 07:23:38PM +0900, Masahiro Yamada wrote:
> As the description says, this property contains a pair of calibration
> values. The number of items must be exactly 2.
> 
> Add minItems to check a too short property.
> 
> While I was here, I also added this property to the example because
> this is the case in the real DT file,
> arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> 
> Also, fix the interrupt type (edge -> level) to align with the
> real DT.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  .../bindings/thermal/socionext,uniphier-thermal.yaml          | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> index 553c9dcdaeeb..57ffd0c4c474 100644
> --- a/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
> @@ -29,6 +29,7 @@ properties:
>  
>    socionext,tmod-calibration:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 2

The intent was if minItems is not defined, then the default is the same 
as maxItems. This is not the default for json-schema, so the tooling is 
supposed to add it. But looking at processed-schema.yaml, it doesn't 
seem to be happening for one case here. I'm working on a fix in the 
tools.

Rob
