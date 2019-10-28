Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED961E7568
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 16:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfJ1Prh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 11:47:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42906 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfJ1Prh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 11:47:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id s20so8230032edq.9;
        Mon, 28 Oct 2019 08:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xeouFKeqxI+jBZsGSFG26F9cl2bzWdfbTz7OAnsdkHs=;
        b=ly8VR/WjJnSt5FKIMjmSxgeiEyfHjaZBJIPr3KXRDNZP+Rk9KncOG6HNq1ZIQgKPBO
         t9Vf8p/2kQvKoBFZeqYyLhwFSfUgHaeVUdh7Uhs++CuvpGNrvmmjXWUkiW+etlxTbQ2z
         wAozUNltofNAjeeEAwJq5Ktncklgu4fokspK6Yek/PtIjzuTA1AcmiseDSSy1RgI3Kqg
         n9XA6kUh2f/8JAFTif+Oz+wMjKUeo/Hwzhl4DZx13IvFcMz4DGhmw5cKt3P1E8FycJXo
         i3mfuH3lBtdcDxzQY9CuHsZCa3kti4rt1RksqncnzHhKZB1vdlFOIEB5+CRn3pXj5EbI
         V9qA==
X-Gm-Message-State: APjAAAV9FZCl50uHXqOYLEagfMzH/pm14bVpZ1MXTrPqZWcRN8ZshT8B
        EmSAzw7BtQGY8KfCRMFObrM=
X-Google-Smtp-Source: APXvYqzb5eJY5x6+xEfLs30NbzaiquwQRVOIdigZyIXD5gUp8DH2McCek9vsaaleRlSYLLP4jx4E1Q==
X-Received: by 2002:aa7:d0c9:: with SMTP id u9mr19737617edo.217.1572277655066;
        Mon, 28 Oct 2019 08:47:35 -0700 (PDT)
Received: from pi3 ([194.230.155.180])
        by smtp.googlemail.com with ESMTPSA id g43sm567693edb.14.2019.10.28.08.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 08:47:34 -0700 (PDT)
Date:   Mon, 28 Oct 2019 16:47:32 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, vireshk@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, b.zolnierkie@samsung.com,
        m.szyprowski@samsung.com
Subject: Re: [PATCH 3/3] dt-bindings: arm: samsung: Drop syscon compatible
 from CHIPID binding
Message-ID: <20191028154732.GA3746@pi3>
References: <20191028152050.10220-1-s.nawrocki@samsung.com>
 <CGME20191028152100eucas1p2ed6bd2d53670c85f6bf550af0631a55a@eucas1p2.samsung.com>
 <20191028152050.10220-3-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191028152050.10220-3-s.nawrocki@samsung.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 28, 2019 at 04:20:50PM +0100, Sylwester Nawrocki wrote:
> The "syscon" compatible string was introduced mainly to allow sharing
> of the CHIPID IO region between multiple drivers. However, such sharing
> can be also done without an additional compatible so remove "syscon".

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

> 
> Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung/exynos-chipid.yaml         | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> index 53c29d567789..afcd70803c12 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-chipid.yaml
> @@ -13,7 +13,6 @@ properties:
>    compatible:
>      items:
>        - const: samsung,exynos4210-chipid
> -      - const: syscon
>  
>    reg:
>      maxItems: 1
> @@ -34,7 +33,7 @@ required:
>  examples:
>    - |
>      chipid@10000000 {
> -        compatible = "samsung,exynos4210-chipid", "syscon";
> +        compatible = "samsung,exynos4210-chipid";
>          reg = <0x10000000 0x100>;
>          samsung,asv-bin = <2>;
>      };
> -- 
> 2.17.1
> 
