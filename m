Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39BE3EF24E
	for <lists+linux-pm@lfdr.de>; Tue, 17 Aug 2021 20:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhHQS4g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Aug 2021 14:56:36 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:35627 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhHQS4g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Aug 2021 14:56:36 -0400
Received: by mail-ot1-f50.google.com with SMTP id f16-20020a056830205000b00519b99d3dcbso5114459otp.2;
        Tue, 17 Aug 2021 11:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7mKYKjiMf8dpl43oyObweK1f4wE9KHcQrULWUKHnVeA=;
        b=hLM8U2dTCb+SRDGevxKVjrsA4m931N58HY6cJ+TTscu4cZxixkZaxCirmhpPXHUjz6
         CojAMIPUxPz9qptE/7uzCSaVteuOm+IoadYf87vJ7B1fQjVyhyu/vITYiR32uAr/D5cj
         POv58LHmu9CL1swQUNrONCry8SKPn9zx2kTKhswmv/otYCc7uhSaE4ky3H+5Xi/xQKKS
         Nx7bGj37ehxbuiN3Mf5QS5Vdu67H1GXl1Ohduv5w1UeL6Sfvz4EA+Nb4pevf4o5AGNJD
         pBf+v73zya26z+el74QbGCVzQFrWecWiRbzAET34LDVnbzOzWVEE1kHLakKOEMJD+oqg
         JZjA==
X-Gm-Message-State: AOAM530Z+tv6gvaZJkX4aCfHx4K50m2pc2FXyqfqwPz8kSpJwg34xfxi
        KJh8QRdVXdGrHS1dj0z1JQ==
X-Google-Smtp-Source: ABdhPJyQNJxThPdp7vu06wPqqH1HYkNYsHwow2EYSlzyZhhiv4Cs65rxOPBFu2tNIBLSJeZ/MOFNjA==
X-Received: by 2002:a9d:2623:: with SMTP id a32mr3566338otb.230.1629226562620;
        Tue, 17 Aug 2021 11:56:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x3sm579736ooe.32.2021.08.17.11.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 11:56:02 -0700 (PDT)
Received: (nullmailer pid 656992 invoked by uid 1000);
        Tue, 17 Aug 2021 18:56:00 -0000
Date:   Tue, 17 Aug 2021 13:56:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, tdas@codeaurora.org,
        linux-kernel@vger.kernel.org, rjw@rjwysocki.net, steev@kali.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        rui.zhang@intel.com, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
        mka@chromium.org
Subject: Re: [Patch v5 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
Message-ID: <YRwGQNSqXiwR9pfl@robh.at.kernel.org>
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-8-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809191605.3742979-8-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, 09 Aug 2021 15:16:05 -0400, Thara Gopinath wrote:
> Add dt binding documentation to describe Qualcomm
> Limits Management Hardware node.
> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
> 
> v4->v5:
> 	- Renam
> v3->v4:
> 	- Changed dt property qcom,lmh-cpu-id to qcom,lmh-cpu and made it
> 	  a phandle pointing to the cpu node instead of a number as per
> 	  Rob Herring's review comments.
> 	- Added suffix -millicelsius to all temperature properties as per
> 	  Rob Herring's review comments.
> 	- Dropped unnecessary #includes in the example as pointed out by Bjorn.
> 	- Other minor fixes.
> 
>  .../devicetree/bindings/thermal/qcom-lmh.yaml | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
