Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3AB3DAE62
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jul 2021 23:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhG2VeK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 29 Jul 2021 17:34:10 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:46634 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhG2VeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 29 Jul 2021 17:34:09 -0400
Received: by mail-il1-f180.google.com with SMTP id r5so7311235ilc.13;
        Thu, 29 Jul 2021 14:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+US/sCT1dhxOJ4U91k6ZMMJ60qAI+1w/R3MOkEoiC8U=;
        b=N2mu7X/uGwO9E86DQfdrTaZrtfwE3m7nGq9oT+vEfU7/Vpnc/mtR9MiapSBHhiFSiI
         jDP+gp4f5meF6BQ+yO/xWiAzDCxUpq/sEDaEv9PgiU9IPMbiQgNowXYMoUiFwLB6ddVm
         ZgBRunv+MT+w1mo/K8PG1xCShQLvJ+maDBjyXLEQ2NO2hNjM/hHYkHXun2AjL4u0lx2d
         l/Q8Q7d2+9WQSFeny4+KzfxW3s3d8uiX1i1gE0+HC6w8xPgGjZ3qqa4XsbWeXiVEsaQ6
         BvEB4Y7z18kucMDT/47JXFcrUg7/NY3i8abtED2S//MY9vf9fOoPsnm+6L+NatCbqIk7
         64+g==
X-Gm-Message-State: AOAM531mNPnhVkuK6+drUMZNu+Fnuoz7FbdoUngf7wYVZnFGduTVVBw/
        02TCGI6LsZzlLJQMCHMiWw==
X-Google-Smtp-Source: ABdhPJyapp7U+fLii2gEVm9kIg7KKSiwOiZDZmljwYAOtMmG5lXlR7cdkQlYnOXAoduHlLOzfLJaRQ==
X-Received: by 2002:a92:d3d1:: with SMTP id c17mr5000523ilh.86.1627594444720;
        Thu, 29 Jul 2021 14:34:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j20sm2944416ile.17.2021.07.29.14.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 14:34:03 -0700 (PDT)
Received: (nullmailer pid 932724 invoked by uid 1000);
        Thu, 29 Jul 2021 21:34:02 -0000
Date:   Thu, 29 Jul 2021 15:34:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Odelu Kukatla <okukatla@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Georgi Djakov <djakov@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SC8180x DT
 bindings
Message-ID: <YQMeyu9bPLC2d7+S@robh.at.kernel.org>
References: <20210723194243.3675795-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723194243.3675795-1-bjorn.andersson@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 23 Jul 2021 12:42:42 -0700, Bjorn Andersson wrote:
> From: Georgi Djakov <georgi.djakov@linaro.org>
> 
> Add compatibles and port definitions for the SC8180x RPMH interconnect
> providers.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> [bjorn: Split defines from driver patch and added binding update]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  11 ++
>  .../dt-bindings/interconnect/qcom,sc8180x.h   | 185 ++++++++++++++++++
>  2 files changed, 196 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,sc8180x.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
