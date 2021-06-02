Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7F73993B1
	for <lists+linux-pm@lfdr.de>; Wed,  2 Jun 2021 21:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFBTk1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 15:40:27 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42845 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBTkZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 15:40:25 -0400
Received: by mail-oi1-f180.google.com with SMTP id v142so3366995oie.9;
        Wed, 02 Jun 2021 12:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fsB+ST/iazXJkQ9lE/pAHAOafyvDLSMdQ8YyC9gyU5Q=;
        b=mG61549mGPZSwNRFw26sX7BHV2ubMcQAZzWjtmM2Y3TYe59QXuONZQH0+qREzrUiNf
         48KSj50TSa/PaICXPEJsjjRFepURlpCg2KbIXaiT6PzdWhv3CYmGvPDWUOrOmkaEloNL
         +HpuFE/Ga2ssC2autmm5SUM8hDqMl7RHE7uwi7IKuePic2Oh86t3H8WsLryz4G8wSKj5
         8PhukFj9kGCIz2XpwPCytWzSCT9s6hHh8zgrPhECVtiXMpqqNEUDfFsuZoUrLKWcnSVN
         pSOQ7u+e4JVC767x+9UCHYlZ/AusSJfM9c6kuAyfsmIC9rUQ25OqRPDkwdzFeHqUQ41R
         uk+Q==
X-Gm-Message-State: AOAM530SlxYqaeczdM3wtzeZA5mKc2DgGNVJL14np/VrHuWX7M6N1wIf
        3GFy+DKnzv4odnjjtisIhA==
X-Google-Smtp-Source: ABdhPJxRxVf88PEQSy92kFJ8Cj0asYkkLIWfeFcqxMjcnpGu6ebwcLWdTsIVx6A51WKmuc630b+ZHw==
X-Received: by 2002:a05:6808:d47:: with SMTP id w7mr22953199oik.104.1622662706270;
        Wed, 02 Jun 2021 12:38:26 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l19sm192385otk.65.2021.06.02.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:38:25 -0700 (PDT)
Received: (nullmailer pid 3850628 invoked by uid 1000);
        Wed, 02 Jun 2021 19:38:24 -0000
Date:   Wed, 2 Jun 2021 14:38:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Odelu Kukatla <okukatla@codeaurora.org>
Cc:     georgi.djakov@linaro.org, bjorn.andersson@linaro.org,
        evgreen@google.com, Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [V3 1/3] dt-bindings: interconnect: Add EPSS L3 DT binding on
 SC7280
Message-ID: <20210602193824.GA3848885@robh.at.kernel.org>
References: <1622646894-7833-1-git-send-email-okukatla@codeaurora.org>
 <1622646894-7833-2-git-send-email-okukatla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622646894-7833-2-git-send-email-okukatla@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Jun 02, 2021 at 08:44:51PM +0530, Odelu Kukatla wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on SC7280
> SoCs.
> 
> Signed-off-by: Odelu Kukatla <okukatla@codeaurora.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml          |  4 +++-
>  include/dt-bindings/interconnect/qcom,osm-l3.h                 | 10 +++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index d6a95c3..61e9a35 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -18,12 +18,14 @@ properties:
>    compatible:
>      enum:
>        - qcom,sc7180-osm-l3
> +      - qcom,sc7280-epss-l3
>        - qcom,sdm845-osm-l3
>        - qcom,sm8150-osm-l3
>        - qcom,sm8250-epss-l3
>  
>    reg:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 4

If there is more than 1 entry, you have to define what each entry is.

>  
>    clocks:
>      items:
> diff --git a/include/dt-bindings/interconnect/qcom,osm-l3.h b/include/dt-bindings/interconnect/qcom,osm-l3.h
> index 61ef649..99534a5 100644
> --- a/include/dt-bindings/interconnect/qcom,osm-l3.h
> +++ b/include/dt-bindings/interconnect/qcom,osm-l3.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * Copyright (C) 2019 The Linux Foundation. All rights reserved.
> + * Copyright (C) 2019, 2021 The Linux Foundation. All rights reserved.
>   */
>  
>  #ifndef __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
> @@ -11,5 +11,13 @@
>  
>  #define MASTER_EPSS_L3_APPS	0
>  #define SLAVE_EPSS_L3_SHARED	1
> +#define SLAVE_EPSS_L3_CPU0	2
> +#define SLAVE_EPSS_L3_CPU1	3
> +#define SLAVE_EPSS_L3_CPU2	4
> +#define SLAVE_EPSS_L3_CPU3	5
> +#define SLAVE_EPSS_L3_CPU4	6
> +#define SLAVE_EPSS_L3_CPU5	7
> +#define SLAVE_EPSS_L3_CPU6	8
> +#define SLAVE_EPSS_L3_CPU7	9
>  
>  #endif
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
