Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF44D32DB5B
	for <lists+linux-pm@lfdr.de>; Thu,  4 Mar 2021 21:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbhCDUsY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 4 Mar 2021 15:48:24 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:46910 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhCDUsQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Mar 2021 15:48:16 -0500
Received: by mail-oi1-f172.google.com with SMTP id f3so31597296oiw.13;
        Thu, 04 Mar 2021 12:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=j59lrECNHtsXK3Jv/0RDoNdHyOlST6wKF1WbuOeLKLw=;
        b=NmSKRjXFYqsVLohDY7yb2PJf6yzsdXHFSuNGtbHbz4yEIy+9PyH4V36ScoHoHFpqQC
         lR5rtqsGRgINtX0HD9mVTD8kKKWo9VNoJ+AJWdsXrznbzPth0C9yDTJm9VpsaSDUAqds
         gX5aNR4605ADBrA06NX9Out2Zjurg3qpttT+ULIp5xNnsGe1Cz6i6zM/uF3bKLpPOyhE
         stgW7T6XpLphvsGIdu1hQpWuzMqStLLM5NLSYeqtFVu2mCCWo0lqoU3F4//T8Qsdrola
         tzLi1nB5w/reh/tr04PXPNX2JY3+AwJ6qhhgaYLKqlNaCHh5OjTwe97o2bLXsZWmtuIH
         0X3w==
X-Gm-Message-State: AOAM530Ld3FGx+CpfjEi3s+AVbyOvT+FE+xARJuF7Ap+0BCgRC71dimm
        SJHIFTYmdEDB9NxDKLN5pA==
X-Google-Smtp-Source: ABdhPJxVrJZmjmDwwM3YBLqurE7wCydKeXXk9i+FmXubo9RYFtM19CZ3hcPy/yRYG4y9xWY3s+1OfA==
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr4231691oiw.123.1614890855566;
        Thu, 04 Mar 2021 12:47:35 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s33sm88866ooi.39.2021.03.04.12.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:47:33 -0800 (PST)
Received: (nullmailer pid 2778957 invoked by uid 1000);
        Thu, 04 Mar 2021 20:47:29 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, sanjayc@nvidia.com,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, ksitaraman@nvidia.com
In-Reply-To: <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
References: <1614838092-30398-1-git-send-email-skomatineni@nvidia.com> <1614838092-30398-4-git-send-email-skomatineni@nvidia.com>
Subject: Re: [PATCH v1 3/5] dt-bindings: arm: Add cpu-idle-states to Tegra194 CPU nodes
Date:   Thu, 04 Mar 2021 14:47:29 -0600
Message-Id: <1614890849.101909.2778956.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 03 Mar 2021 22:08:10 -0800, Sowjanya Komatineni wrote:
> This patch adds cpu-idle-states and corresponding state nodes to
> Tegra194 CPU in dt-binding document
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/arm/nvidia,tegra194-ccplex.yaml       | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.example.dt.yaml: cpus: compatible: ['nvidia,tegra194-ccplex'] is not of type 'object'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml

See https://patchwork.ozlabs.org/patch/1447108

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

