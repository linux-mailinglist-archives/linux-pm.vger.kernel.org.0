Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D31F2AE77D
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 05:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgKKEhY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 23:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgKKEhY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 23:37:24 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE4BC0613D1
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 20:37:23 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m13so749125oih.8
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2020 20:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vq44ljmw99Z+vxoyleZFvg1Copias7KXRy4H8KP+HQo=;
        b=wGulWlnIEq3o/KCgEakKDsvH2cDYMyyuMj4NyUFTuJX5yAdqX1dxg4TAfo3xTFL38u
         hLo3rFmCMjdKyGo4RwoDhvRAfNHM9lF7QD02F0zB/vWGsZNnF+k+6qjn05bIjVsU70Ba
         uNWpQXshZrEDjiYtQmx+wRW3Yiq3pWHcmXgQ8HBH9bKp6SFLy42rwY8FzFfZXm1/BPew
         1L9M5RUXE/J+22pHmyumFxm4glxdWsv9xPWwduZGzqPkyqyiKXky3+XSs0VKSve0Ssz+
         4QGk8YAhwVX3JoX7MXohNiHsEgW494GvRqgeORierDnsPyOd32vL2QiU0NQVs58JiEga
         vLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vq44ljmw99Z+vxoyleZFvg1Copias7KXRy4H8KP+HQo=;
        b=MYmloyNFDmWRiHOw5QaRneESRAZhlL1scKLys5hnjc+SoyxXf741puSTP99g4jmmRJ
         yJ6FC858D9544p7T9wA2QK2szgQHXuFYt2gDQX8mUDIozH0hwVIAmfAkwozJt4ehYoLL
         NkulDB+GGCaLkG3MaYn5n4Txm8a3zCQQKXLSV8/aj7+OyLcXiJc6kzyC3Va2wlJkRmpN
         FeknwOVeWjPZO1FoRXyyvw5RARqU0BQEEAjThecH2jIRYMeEs72ZnO3iM+meviM28rAS
         vLOY8z2FWG2jyyzrDoU0AEmVVqXVcxC9DSsCn1YWq74NPQUI4ieIE9bx68zyQ091JQ6N
         y6bQ==
X-Gm-Message-State: AOAM530k7CvU2M6xX27B4Tad09XNBQDeVQnyMAVAx6U3sURMUJIUC7pJ
        /v/Ed1OstnxD9wg/LT+Cu30vyw==
X-Google-Smtp-Source: ABdhPJwRoQIUMNBMcS3WdGKPiJDma/tyFlDsORvKcE5FdiWffs1+Ga925ZSK9oIUe8IkBqqLoKX2Bw==
X-Received: by 2002:aca:f407:: with SMTP id s7mr1039694oih.23.1605069443315;
        Tue, 10 Nov 2020 20:37:23 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 66sm277848otp.33.2020.11.10.20.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 20:37:22 -0800 (PST)
Date:   Tue, 10 Nov 2020 22:37:20 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, mdtipton@codeaurora.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        akashast@codeaurora.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: sdm845: Add IDs for the
 QUP ports
Message-ID: <20201111043720.GB173948@builder.lan>
References: <20201105135211.7160-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105135211.7160-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 05 Nov 07:52 CST 2020, Georgi Djakov wrote:

> The QUP ports exist in the topology, but are not exposed as an
> endpoints in DT. Fix this by creating IDs and attach them to their
> NoCs, so that the various QUP drivers (i2c/spi/uart etc.) are able
> to request their interconnect paths and scale their bandwidth.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  include/dt-bindings/interconnect/qcom,sdm845.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/dt-bindings/interconnect/qcom,sdm845.h b/include/dt-bindings/interconnect/qcom,sdm845.h
> index 290be38f40e6..67b500e24915 100644
> --- a/include/dt-bindings/interconnect/qcom,sdm845.h
> +++ b/include/dt-bindings/interconnect/qcom,sdm845.h
> @@ -19,6 +19,7 @@
>  #define SLAVE_A1NOC_SNOC		7
>  #define SLAVE_SERVICE_A1NOC		8
>  #define SLAVE_ANOC_PCIE_A1NOC_SNOC	9
> +#define MASTER_QUP_1			10
>  
>  #define MASTER_A2NOC_CFG		0
>  #define MASTER_QDSS_BAM			1
> @@ -32,6 +33,7 @@
>  #define SLAVE_A2NOC_SNOC		9
>  #define SLAVE_ANOC_PCIE_SNOC		10
>  #define SLAVE_SERVICE_A2NOC		11
> +#define MASTER_QUP_2			12
>  
>  #define MASTER_SPDM			0
>  #define MASTER_TIC			1
