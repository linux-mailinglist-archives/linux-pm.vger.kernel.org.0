Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D2298F5E
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 15:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781439AbgJZOcY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 10:32:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38622 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781286AbgJZOcG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 10:32:06 -0400
Received: by mail-ot1-f68.google.com with SMTP id b2so7589887ots.5;
        Mon, 26 Oct 2020 07:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JBvgDt7emBztIGO8StCH4tfzHv+hqLMzjAEA52hgcqM=;
        b=Bg+LMomwUIHq9QK6BP9P6VW4m/VwhkaGHiLyOGnIMMkgGq7Wvni0rZkl5cUQZz0jmZ
         GWEqKOeoc4xLFgLhLbnryjagXlIQO13dsDJ4o4XVmAzSmyc/5r5IuxakxbJR1uwfKgWU
         ZRC0lTTQ0nJvFw+zSgO8mfMdL8fzGB/bVjsOoOrCVYHJzswLIaL6TUtpgoTmvWC3WXjO
         cOZ0PzqmNSTrhZfKtd5n9lx3gIA8StfmNTIc7mDeWengOum78uMg9JjTRtG4LumxpCs8
         T+WII5MTyMUiOZyUOr4sDW4bQUHYbUlBArMO8F/P3lES5pNzPuYqbiFZh2Bg37h3/PXJ
         JcRg==
X-Gm-Message-State: AOAM530gn5SFnK5wCTMwKgF022iqA6+WMHNNKfnAHCEG3JcbDkVhqjG8
        +mgcBGevljaEtnGlrtkMOE5qpi2cag==
X-Google-Smtp-Source: ABdhPJz3h/R6/JxK/xTIyb4YBd7u1ygBvi4k+eafrmmQJBWLoUwvrZ+WynbrruqpPyAs4xMZOP+DWA==
X-Received: by 2002:a05:6830:1d8:: with SMTP id r24mr14271488ota.283.1603722725156;
        Mon, 26 Oct 2020 07:32:05 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s189sm4040211oig.46.2020.10.26.07.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:32:04 -0700 (PDT)
Received: (nullmailer pid 114717 invoked by uid 1000);
        Mon, 26 Oct 2020 14:32:03 -0000
Date:   Mon, 26 Oct 2020 09:32:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: cpus: Document
 'qcom,freq-domain' property
Message-ID: <20201026143203.GA112606@bogus>
References: <20201020153944.18047-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020153944.18047-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 20, 2020 at 09:09:43PM +0530, Manivannan Sadhasivam wrote:
> Add devicetree documentation for 'qcom,freq-domain' property specific
> to Qualcomm CPUs. This property is used to reference the CPUFREQ node
> along with Domain ID (0/1).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 1222bf1831fa..f40564bf004f 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -290,6 +290,12 @@ properties:
>  
>        * arm/msm/qcom,kpss-acc.txt
>  
> +  qcom,freq-domain:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    description: |
> +      CPUs supporting freq-domain must set their "qcom,freq-domain" property
> +      with phandle to a cpufreq_hw node followed by the Domain ID(0/1).

There's no 3 patches doing the same thing. Mediatek and SCMI are the 
others. This will need to be common. 

> +
>    rockchip,pmu:
>      $ref: '/schemas/types.yaml#/definitions/phandle'
>      description: |
> -- 
> 2.17.1
> 
