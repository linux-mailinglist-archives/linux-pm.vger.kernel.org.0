Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3D621DDB6
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jul 2020 18:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgGMQmR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jul 2020 12:42:17 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:43471 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgGMQmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2020 12:42:17 -0400
Received: by mail-io1-f65.google.com with SMTP id k23so14145762iom.10;
        Mon, 13 Jul 2020 09:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=95u4XQbiBNEbmUiVqX+fo8bOSxhI7i+gaxCn3lXTzqc=;
        b=Ki0uiu2WF5elAO9m6oh5urkF4YdhJXVhuAs6vnZIEkE/bjpVpw/MvddAHdv0GfZbho
         9OUc6KJUuV5hji8Z66oYdcrgWzaWx1x4g3txsCfqU0tVr1fRc5gRRv3Dy+y3qQ9InpNB
         uX4tD6CLOgvFFHeBM1Q5Y10ZZV5y7H1XJEmM96mWie9+hTYq57ExRoEr/huMXMLAMqf9
         JyYrzTD//2sxBrZXI5aSz/qDDFG8zrajvHkGTWSgEX29OGN6dQrtHuFUbLrosPNwZDlw
         hIk4ybwk99nSh9mafPqHPS7Yk5yIV6ZzuTM8kzs0yrpn7zYX6FsT050Fr7/b3l5dfaTj
         1dFw==
X-Gm-Message-State: AOAM533pn5he9VOvmcE/t30BLR2HFmk8vzHgNTV/zCwHWv63MhU4cAEg
        KzN3BCdp2urAmHTUSsOW3A==
X-Google-Smtp-Source: ABdhPJw6zyKQhU2fGmPHQI3+yP7QiHYYcgQrgUA4qyagqHgLVfTS4YB+9LdplG/eDrMeToQieLohgw==
X-Received: by 2002:a02:6c07:: with SMTP id w7mr1034168jab.33.1594658536188;
        Mon, 13 Jul 2020 09:42:16 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b13sm7889364iof.21.2020.07.13.09.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:42:15 -0700 (PDT)
Received: (nullmailer pid 359058 invoked by uid 1000);
        Mon, 13 Jul 2020 16:42:14 -0000
Date:   Mon, 13 Jul 2020 10:42:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        mirq-linux@rere.qmqm.pl, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, talho@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v5 1/4] dt-bindings: arm: Add t194
 ccplex compatible and bpmp property
Message-ID: <20200713164214.GA341271@bogus>
References: <1594649209-29394-1-git-send-email-sumitg@nvidia.com>
 <1594649209-29394-2-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594649209-29394-2-git-send-email-sumitg@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 13, 2020 at 07:36:46PM +0530, Sumit Gupta wrote:
> To do frequency scaling on all CPUs within T194 CPU Complex, we need
> to query BPMP for data on valid operating points. Document a compatible
> string under 'cpus' node to represent the CPU Complex for binding drivers
> like cpufreq which don't have their node or CPU Complex node to bind to.
> Also, document a property to point to the BPMP device that can be queried
> for all CPUs.

The cpus.yaml binding documents what's in 'cpu' nodes, not 'cpus' 
node. AIUI, the latter is what you want. You should do your own schema 
file here.

> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index a018147..9b328e3 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -162,6 +162,7 @@ properties:
>        - nvidia,tegra132-denver
>        - nvidia,tegra186-denver
>        - nvidia,tegra194-carmel
> +      - nvidia,tegra194-ccplex

Tegra194 has 2 different CPUs?

>        - qcom,krait
>        - qcom,kryo
>        - qcom,kryo260
> @@ -255,6 +256,15 @@ properties:
>  
>        where voltage is in V, frequency is in MHz.
>  
> +  nvidia,bpmp:
> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> +    description: |
> +      Specifies the bpmp node that needs to be queried to get
> +      operating point data for all CPUs.
> +
> +      Optional for systems that have a "compatible"
> +      property value of "nvidia,tegra194-ccplex".
> +
>    power-domains:
>      $ref: '/schemas/types.yaml#/definitions/phandle-array'
>      description:
> @@ -340,6 +350,7 @@ required:
>  
>  dependencies:
>    rockchip,pmu: [enable-method]
> +  nvidia,bpmp: [compatible]
>  
>  examples:
>    - |
> -- 
> 2.7.4
> 
