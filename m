Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C04F34B7F1
	for <lists+linux-pm@lfdr.de>; Sat, 27 Mar 2021 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC0PUM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 27 Mar 2021 11:20:12 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:44669 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhC0PTz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 27 Mar 2021 11:19:55 -0400
Received: by mail-oi1-f179.google.com with SMTP id a8so8795176oic.11;
        Sat, 27 Mar 2021 08:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nfnKdAHB/EP3TU6RFTKDpMwYBzJ5rtNzgJbhutbUIg8=;
        b=E6WcUymPekSIX5gEMq7wlmhV4bjgKNsWT+eTbI8n5gWvxYb+oKLNRlCABoqvg9lFW8
         ur43YfIxEieQ13qndypJMVM/vP+FjRsT/Js+laccEtw2oua6vOJBoz1hteiPU0zSZQK1
         HQPwulxz+OBUJsuY359IEYuvNt9u1p+/Y5Cm2OZMTUAS2upv0uWfIKvoytucBGnw0KKY
         N3D55spPvzgvLHbVYGbpdiHKYck7naM3mg8zGBtE8jp1/c63ecRODo2lPBnpZtgPmPBb
         jCN9DNo4KZi3E0yJ/xq/ht2z+TX1L0YvSEcv65hSTmtKgyeYQIX6gRgIXkpGpoDE/kZ8
         vGKg==
X-Gm-Message-State: AOAM531Cz8dnaDlMQ/XOO7PsYD6vmToNoldgRSqx+a4yu+h2NmDhwfO0
        mXG9bzsI0/o6kDm/k1VB9w==
X-Google-Smtp-Source: ABdhPJyFWMuW/TG7+Dj6H0NNbsspoDX4rQ+wr4XeeEwSHO2tuRHj5bzEAsG0U1r5f8L8fafXCJeLKw==
X-Received: by 2002:aca:f597:: with SMTP id t145mr13882340oih.121.1616858395171;
        Sat, 27 Mar 2021 08:19:55 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.102.185])
        by smtp.gmail.com with ESMTPSA id t2sm2560759ool.18.2021.03.27.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 08:19:54 -0700 (PDT)
Received: (nullmailer pid 139006 invoked by uid 1000);
        Sat, 27 Mar 2021 15:19:48 -0000
Date:   Sat, 27 Mar 2021 09:19:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, amitk@kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        rui.zhang@intel.com, Vinod Koul <vinod.koul@linaro.org>,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        agross@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: thermal: qcom-tsens: Add compatible
 for sm8350
Message-ID: <20210327151948.GA138949@robh.at.kernel.org>
References: <20210324124308.1265626-1-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324124308.1265626-1-robert.foss@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Mar 2021 13:43:08 +0100, Robert Foss wrote:
> Add tsens bindings for sm8350.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Changes since v1:
>  - Vinod: Remove comment
> 
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
