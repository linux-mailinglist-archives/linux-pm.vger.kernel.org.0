Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C49177CC7
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 18:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730503AbgCCRGv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 12:06:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36273 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbgCCRGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 12:06:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id t24so3780514oij.3;
        Tue, 03 Mar 2020 09:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DsM/9fpFyAO2iYRTuSlT0pMCuni5v+nLkViTKnIpANc=;
        b=hnc/nZN0fmOf6BTON898RdGb44m8ze7SokXyakqAVZ0YhsufiBrctXX3rZdn5qjXp4
         0bvT6Trkm2FMdBcrKwgQvONIv2kZ7SHCLjVNux4ANW9brv2o4U4miawzYYcX0eOyOV28
         iDo241g5LW94sja6MgJEmwelXLqyusbTeIdUbjHXlAABA70Aj/bJkgegiwAgRqrr3y81
         STL19MoyP+X9snZO+HlBJuH8Aott1q+dnSgLkZ9mc7eZ0SgEB5gtTnuLGGwEfuAOe8mL
         wvuAnefmw6wx9LB5QU2utsjyOx42dtM6Gr19b64sNM/sgdq6EFwunkj9TW34V1+x8Cmd
         eVOw==
X-Gm-Message-State: ANhLgQ1tWdRqxJY13SpT7pnnSpvD65scQM7b9hHoAHNIpnCRCbKw7lqk
        f07O/f4PKJQAMFiUMcj0Vw==
X-Google-Smtp-Source: ADFU+vtXzfjSUoQIMPTzsJQN6DazR7wiN8f6rigrCtFfxy3/pt1bNjvY6jtYyUv1/ycbuFFIr3wH4A==
X-Received: by 2002:aca:4b47:: with SMTP id y68mr1756760oia.38.1583255210172;
        Tue, 03 Mar 2020 09:06:50 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l8sm8049274otn.31.2020.03.03.09.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:06:43 -0800 (PST)
Received: (nullmailer pid 11907 invoked by uid 1000);
        Tue, 03 Mar 2020 17:06:41 -0000
Date:   Tue, 3 Mar 2020 11:06:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        devicetree@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: arm: Fixup the DT bindings for
 hierarchical PSCI states
Message-ID: <20200303170641.GC26191@bogus>
References: <20200303150749.30566-1-ulf.hansson@linaro.org>
 <20200303150749.30566-6-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303150749.30566-6-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Mar 03, 2020 at 04:07:47PM +0100, Ulf Hansson wrote:
> The hierarchical topology with power-domain should be described through
> child nodes, rather than as currently described in the PSCI root node. Fix
> this by adding a patternProperties with a corresponding reference to the
> power-domain DT binding.
> 
> Additionally, update the example to conform to the new pattern, but also to
> the adjusted domain-idle-state DT binding.
> 
> Fixes: a3f048b5424e ("dt: psci: Update DT bindings to support hierarchical PSCI states")
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  .../devicetree/bindings/arm/psci.yaml         | 33 +++++++++----------
>  1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
> index 0bc3c43a525a..cae668b61265 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -102,11 +102,15 @@ properties:
>        [1] Kernel documentation - ARM idle states bindings
>          Documentation/devicetree/bindings/arm/idle-states.yaml
>  
> -  "#power-domain-cells":
> -    description:
> -      The number of cells in a PM domain specifier as per binding in [3].
> -      Must be 0 as to represent a single PM domain.
> +required:
> +  - compatible
> +  - method

No need to move this.

>  
> +patternProperties:
> +  "^(power-controller|power-domain)([@-].*)?$":
> +    $ref: "../power/power-domain.yaml#"

This has to be under an 'allOf' or the rest of the properties are 
ignored.

> +    type: object
> +    description: |
>        ARM systems can have multiple cores, sometimes in an hierarchical
>        arrangement. This often, but not always, maps directly to the processor
>        power topology of the system. Individual nodes in a topology have their
> @@ -122,19 +126,9 @@ properties:
>        helps to implement support for OSI mode and OS implementations may choose
>        to mandate it.
>  
> -      [3] Documentation/devicetree/bindings/power/power_domain.txt
> +      [3] Documentation/devicetree/bindings/power/power-domain.yaml
>        [4] Documentation/devicetree/bindings/power/domain-idle-state.yaml
>  
> -  power-domains:
> -    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> -    description:
> -      List of phandles and PM domain specifiers, as defined by bindings of the
> -      PM domain provider.
> -
> -required:
> -  - compatible
> -  - method
> -
>  allOf:
>    - if:
>        properties:
> @@ -224,6 +218,9 @@ examples:
>            exit-latency-us = <10>;
>            min-residency-us = <100>;
>          };
> +      };
> +
> +      domain-idle-states {
>  
>          CLUSTER_RET: cluster-retention {
>            compatible = "domain-idle-state";
> @@ -247,19 +244,19 @@ examples:
>        compatible = "arm,psci-1.0";
>        method = "smc";
>  
> -      CPU_PD0: cpu-pd0 {
> +      CPU_PD0: power-domain-cpu0 {
>          #power-domain-cells = <0>;
>          domain-idle-states = <&CPU_PWRDN>;
>          power-domains = <&CLUSTER_PD>;
>        };
>  
> -      CPU_PD1: cpu-pd1 {
> +      CPU_PD1: power-domain-cpu1 {
>          #power-domain-cells = <0>;
>          domain-idle-states =  <&CPU_PWRDN>;
>          power-domains = <&CLUSTER_PD>;
>        };
>  
> -      CLUSTER_PD: cluster-pd {
> +      CLUSTER_PD: power-domain-cluster {
>          #power-domain-cells = <0>;
>          domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
>        };
> -- 
> 2.20.1
> 
