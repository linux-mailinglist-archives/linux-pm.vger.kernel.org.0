Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70391349E52
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 02:01:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhCZBBO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Mar 2021 21:01:14 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:34699 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhCZBBK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Mar 2021 21:01:10 -0400
Received: by mail-io1-f54.google.com with SMTP id x16so3814027iob.1;
        Thu, 25 Mar 2021 18:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wi3cdmfz/h5xhXrcAv5eDkvRcmW484cG6XaUkEX+uj8=;
        b=SVYxizsKLHLF/Um812LZP78nLf4Ni6mxDJKuVt3VpHJ7uiijzL5J3WpTUzbiG+3GhD
         7s5n2DFc/IxDUevsbTulwk8hNw6VaUAK/fGtTkMILujsfQIlEEzbB2hn2LMyrTHkx3kD
         Rw497EWmvmip49GUekIn259LGahXBI0e1yMVlABK+5BZjCu+Wtqv/fmKW2TA3MmQcrRC
         cihGuNvG3qLWjZO+K39uBOj1TFc4a9l4K1bQcXdUGFz5zhhRivemCnA8nqLuEweTEiap
         WTwHsU2G/7VimJr58kCudmgRaxIPbt4/F4Vcoe84nvG1obDJNplKkE2ryqAIxLRF6UuR
         UGYw==
X-Gm-Message-State: AOAM533Z/xDVVhosU/a4w2gdOnEN5qhu11xiraD45DojzPgUC9DA5A5S
        3iRstJu6vSg9AhlOaM4xnA==
X-Google-Smtp-Source: ABdhPJxHGgVfg99uoMDNH3k51OEkmQcJ2G8En7C57Uv6OKPcDb/m3feGvZuvfCcpQ0kIo5ldZTB+hQ==
X-Received: by 2002:a02:cc1a:: with SMTP id n26mr9850175jap.21.1616720470209;
        Thu, 25 Mar 2021 18:01:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f13sm3428079ila.51.2021.03.25.18.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 18:01:09 -0700 (PDT)
Received: (nullmailer pid 2083325 invoked by uid 1000);
        Fri, 26 Mar 2021 01:01:06 -0000
Date:   Thu, 25 Mar 2021 19:01:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <okukatla@codeaurora.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: Add Qualcomm SM8350 DT
 bindings
Message-ID: <20210326010106.GA2083273@robh.at.kernel.org>
References: <20210318094617.951212-1-vkoul@kernel.org>
 <20210318094617.951212-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318094617.951212-2-vkoul@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 18 Mar 2021 15:16:16 +0530, Vinod Koul wrote:
> The Qualcomm SM8350 platform has several bus fabrics that could be
> controlled and tuned dynamically according to the bandwidth demand.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  10 +
>  .../dt-bindings/interconnect/qcom,sm8350.h    | 172 ++++++++++++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sm8350.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
