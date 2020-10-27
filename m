Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AFD29A984
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 11:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898003AbgJ0KZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 06:25:13 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36791 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437932AbgJ0KZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 06:25:12 -0400
Received: by mail-ej1-f66.google.com with SMTP id w27so1456087ejb.3;
        Tue, 27 Oct 2020 03:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ylNf2aSrBKpAGk/XmG8j77J1836YfOHwLDEKrBDhhto=;
        b=NuKxOtcoZKhMi/J7Bot2LzRHZtsIY2tGA0BrI6LMNM65U4R1IqMebM9shwg8F5t9EO
         9Ir1sOXB1QXLHxyPQlKLRBnKtyG9nawGJR+PadH6RE0AniM2hakKmfDW5N5jMY3kcviF
         mfOVQccNZaOdkw3rzqy7mFLXjCh0wLnb9LyVpnpjl7CaIgEcbJB2FjR3d1bgZuSUU17v
         rg+gknmK0bjcGc6gIuzW4Hkhc1Z0/KywBeMvzUmoyiWIGOPb+Tq221SehO3oXm/9opbL
         r/MLwO1418C2YTiM+JOkUcovvnDUmpWD41z1hXjtK0Mnmldwjk+I+3hbIgkJIVOO762w
         xO7Q==
X-Gm-Message-State: AOAM530bW5sa6rcrzlz1oOICU00c9s/tYrX2p5utioi/S5B4XN/F3QcU
        dT+SFvplZSClrvm1RpX/yFs=
X-Google-Smtp-Source: ABdhPJyTiWvQkB0SHAsJaXsSdNHED7COpFBG6lf+CNCt8imIyB1mFelDwWrl3AGCqa/XD9EaDgO3wg==
X-Received: by 2002:a17:906:3bc7:: with SMTP id v7mr1586575ejf.245.1603794310498;
        Tue, 27 Oct 2020 03:25:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id yw17sm747674ejb.97.2020.10.27.03.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 03:25:09 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:25:06 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 13/52] dt-bindings: memory: tegra124: emc: Document
 new interconnect property
Message-ID: <20201027102506.GB17089@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-14-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:56AM +0300, Dmitry Osipenko wrote:
> External memory controller is interconnected with memory controller and
> with external memory. Document new interconnect property which turns
> External Memory Controller into interconnect provider.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra124-emc.yaml   | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> index 278549f9e051..ac00832ceac1 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
> @@ -29,6 +29,9 @@ properties:
>      items:
>        - const: emc
>  
> +  "#interconnect-cells":
> +    const: 0
> +
>    nvidia,memory-controller:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
> @@ -327,6 +330,7 @@ required:
>    - clocks
>    - clock-names
>    - nvidia,memory-controller
> +  - "#interconnect-cells"

Another required property, what about all existing users of this binding?

>  
>  additionalProperties: false
>  
> @@ -345,6 +349,7 @@ examples:
>  
>          #iommu-cells = <1>;
>          #reset-cells = <1>;
> +        #interconnect-cells = <1>;

You meant '0'?

Best regards,
Krzysztof
