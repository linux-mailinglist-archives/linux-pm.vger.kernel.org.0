Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56D22D31C8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 19:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgLHSLr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 13:11:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34804 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbgLHSLq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 13:11:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id a109so1047034otc.1;
        Tue, 08 Dec 2020 10:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBNTyUWhSAqkBnW8hBY2mAf7KmbIaIYVcQeU3Ce+eq4=;
        b=NhFkkEMNIpWL8Z0MBvAjsknS507ICs50jF/qLdZ4olT0hwJbBr/p5BaEugIpzxVN7z
         XD3nxOKshz5FbtdTW2yRV0Nk9TrI8nTjf5i6fkXvyyENQNU6k7Xt6NhOFvK8ubEBKotI
         3f3xcUPQopt69zMv5cZuq73b2lA+CPZSUKszeiB1R/cB1mbMosSa1YhvhB1O0+hFxPM+
         /8/WGvG56EmgwGRcT9VtcjMCvNQayQNt1AWvFG3GxsEpalQ3LAzJEfTXsb1rQpnHrejD
         Nlqk3sFM+91CfOpUA7h975Ml96ewTAfFQ87G/XWtMAB0GhHY6xOn3ERpro8iXwtnz37B
         UVww==
X-Gm-Message-State: AOAM530s4odEveaUw0KpY9sAfpdH20hzp/GwPCPoIiF3H/2FgLtNUFvW
        qUjrDRrHqZOjb8MwVEvHWA==
X-Google-Smtp-Source: ABdhPJy+BHGNYI3+qlqJeH91NS1xoptQd/XHGygt8zXvnsSo0KUnlavQziPe5xK2II+//WW4zBIrIA==
X-Received: by 2002:a9d:6d83:: with SMTP id x3mr17523152otp.285.1607451065760;
        Tue, 08 Dec 2020 10:11:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i4sm3498940oos.31.2020.12.08.10.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:11:04 -0800 (PST)
Received: (nullmailer pid 2810507 invoked by uid 1000);
        Tue, 08 Dec 2020 18:11:03 -0000
Date:   Tue, 8 Dec 2020 12:11:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        ulf.hansson@linaro.org, jorge.ramirez-ortiz@linaro.org,
        broonie@kernel.org, lgirdwood@gmail.com, daniel.lezcano@linaro.org,
        nks@flawful.org, bjorn.andersson@linaro.org, agross@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 13/13] dt-bindings: cpufreq: qcom-hw: Add bindings for
 8998
Message-ID: <20201208181103.GA2795715@robh.at.kernel.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
 <20201126184559.3052375-14-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126184559.3052375-14-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Nov 26, 2020 at 07:45:59PM +0100, AngeloGioacchino Del Regno wrote:
> The OSM programming addition has been done under the
> qcom,cpufreq-hw-8998 compatible name: specify the requirement
> of two additional register spaces for this functionality.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../bindings/cpufreq/qcom,cpufreq-hw.yaml     | 31 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml b/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
> index 94a56317b14b..f64cea73037e 100644
> --- a/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
> +++ b/Documentation/devicetree/bindings/cpufreq/qcom,cpufreq-hw.yaml
> @@ -23,17 +23,21 @@ properties:
>            - qcom,cpufreq-epss
>  
>    reg:
> +    description: Base address and size of the RBCPR register region

That doesn't make sense given you have 2 regions.

>      minItems: 2
>      maxItems: 2

maxItems: 4

>  
>    reg-names:
>      description:
> -      Frequency domain register region for each domain.
> -    items:
> -      - const: "freq-domain0"
> -      - const: "freq-domain1"
> +      Frequency domain register region for each domain. If OSM programming
> +      does not happen in the bootloader and has to be done in this driver,
> +      then also the OSM domain region osm-domain[0-1] has to be provided.

Don't write free form text for what can be expressed as schema.

> +    minItems: 2
> +    maxItems: 2

You obviously haven't tried this change with 8998. It will fail with 
more than 2. What you need here is:

minItems: 2
maxItems: 4

items:
  - const: "freq-domain0"
  - const: "freq-domain1"
  - const: "osm-domain0"
  - const: "osm-domain1"

And then...

>  
>    clock-names:
> +    minItems: 2
> +    maxItems: 2
>      - const: xo
>      - const: ref
>  
> @@ -53,9 +57,28 @@ properties:
>        property with phandle to a cpufreq_hw followed by the Domain ID(0/1)
>        in the CPU DT node.
>  
> +allOf:
> + - if:
> +     properties:
> +       reg-names:
> +         contains:
> +           const: qcom,cpufreq-hw-8998
> +   then:
> +     properties:
> +       reg:
> +         minItems: 4
> +         maxItems: 4
> +       reg-names:

...here just:

minItems: 4

And you'll need an 'else' clause with 'maxItems: 2' for reg and 
reg-names.

> +         items:
> +           - const: "freq-domain0"
> +           - const: "freq-domain1"
> +           - const: "osm-domain0"
> +           - const: "osm-domain1"
> +
>  required:
>    - compatible
>    - reg
> +  - reg-names

You can't make something that was optional now required. (Unless it was 
a mistake and all existing users always had 'reg-names'.)

>    - clock-names
>    - clocks
>    - "#freq-domain-cells"
> -- 
> 2.29.2
> 
