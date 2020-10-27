Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2843229A74C
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 10:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408582AbgJ0JF5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 05:05:57 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:39612 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408402AbgJ0JF5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 05:05:57 -0400
Received: by mail-ej1-f68.google.com with SMTP id bn26so1117382ejb.6;
        Tue, 27 Oct 2020 02:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSlOTo+zGWamBX2WAxzQkPjeyrJMzym+nDUb6jRYhTI=;
        b=ReGQNk7KoODhfmu8y7uzrwlYNO2tUuavVfYHiAiFcSJAE1erX40yYg+ogZeWNOWkzt
         mzNMu0ELXDnP4nR/8t/b7BZxDRaa6SNLtqW2TwRZOBrxTgCi3SsRamZildSqg4GW3R0u
         FJugDTWRRgQ/Xne8q/exhJ+iBT6X5gNPIGGRq45su+VKPXg5BxAHHLjV5pRWMpNBDO1z
         OJx2x6F+sjLb0ksJ6dDGOcBVnDG+7CnAzxnHDFKFPQ1OtXbsY31c+I2opClwL/GUW9Cg
         6ca7FP4z+NCfT7j/e7Qg8Ru8sZ9Eby4r1Ces01dbseXfY2kCq8Gfy7kcV5obRpPonLeN
         jfzg==
X-Gm-Message-State: AOAM532ng5cJAnu0CqT960jT4cbWE8WlzHFHfJa++iwPDlHabbJSeEMU
        fidyzpTrh20M8osdOPnrumA=
X-Google-Smtp-Source: ABdhPJwpB7zlslYYqry/Tn76sD9QhQfOP3c+c7xncdpzGfAK9wt/B+FS8uKYdnkUGHJeI6sHYSxQSg==
X-Received: by 2002:a17:906:aed9:: with SMTP id me25mr1447133ejb.52.1603789555092;
        Tue, 27 Oct 2020 02:05:55 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id o11sm608711ejd.60.2020.10.27.02.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 02:05:53 -0700 (PDT)
Date:   Tue, 27 Oct 2020 10:05:50 +0100
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
Subject: Re: [PATCH v6 09/52] dt-bindings: memory: tegra30: mc: Document new
 interconnect property
Message-ID: <20201027090550.GI4244@kozik-lap>
References: <20201025221735.3062-1-digetx@gmail.com>
 <20201025221735.3062-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201025221735.3062-10-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Oct 26, 2020 at 01:16:52AM +0300, Dmitry Osipenko wrote:
> Memory controller is interconnected with memory clients and with the
> External Memory Controller. Document new interconnect property which
> turns memory controller into interconnect provider.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
> index 84fd57bcf0dc..5436e6d420bc 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
> @@ -57,6 +57,9 @@ properties:
>    "#iommu-cells":
>      const: 1
>  
> +  "#interconnect-cells":
> +    const: 1
> +
>  patternProperties:
>    "^emc-timings-[0-9]+$":
>      type: object
> @@ -120,6 +123,7 @@ required:
>    - clock-names
>    - "#reset-cells"
>    - "#iommu-cells"
> +  - "#interconnect-cells"

Rob,

You were fine with adding a new required property which breaks all
existing DTBs?

Were these bindings marked as unstable? The patchset does not even
say/scream that it breaks the ABI, so this might be quite a surprise for
someone...

Best regards,
Krzysztof
