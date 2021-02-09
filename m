Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB0315363
	for <lists+linux-pm@lfdr.de>; Tue,  9 Feb 2021 17:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhBIQFd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Feb 2021 11:05:33 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42096 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbhBIQFa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2021 11:05:30 -0500
Received: by mail-ot1-f43.google.com with SMTP id q4so8275758otm.9;
        Tue, 09 Feb 2021 08:05:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fD3aHOia6VMKvtA4FJpmi4ue3kWyV5zwITjrZbGoBwk=;
        b=imtiMPco4hlsphBV+bfkgNJ6nvn2oqRSjbLcUwQxA5RhSCdu0QPIGiot2kTdF8BkIm
         cjD9STJwtOld81QGbWx8LQCwcFVYkW4MlIv13jfIR0I6wTL7gbYJmOLalTPc42SfHqCr
         hfG5Hun5fqr4cGS8a8Ogdbd3Cwgupj668TpuRiT4S97VspSXtqTGzok9t7rZuxJzXzTJ
         4Vby53/Wx9mJxTVlCITMqr1y4RCyaXssjZpZw8UvPHzOwLJ+BNc0GopLxvQV1+DkVeRS
         etaGt0Q4OxAq6pfR3E4HQXCVnLao3Nrp93/VE+nRkrvsoBlMgRmOMhbsk7S0Jj0RCwqx
         7MMQ==
X-Gm-Message-State: AOAM533XaOhfXbr0MV8OgGtlYKVCCN7IMBbNF6Aj7mLZnLiXPnPYJYs7
        FVSKgecG6+jL3i5O4MIJ6w==
X-Google-Smtp-Source: ABdhPJxS4L/7laL6dGAH9IeNxEekyyPMEbpCGQ9A+2JD5hPg451yz7uEanIMcQCqNR6r6pQgHbvolA==
X-Received: by 2002:a9d:74d7:: with SMTP id a23mr8293838otl.331.1612886689091;
        Tue, 09 Feb 2021 08:04:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z30sm866705otj.61.2021.02.09.08.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:04:48 -0800 (PST)
Received: (nullmailer pid 3848913 invoked by uid 1000);
        Tue, 09 Feb 2021 16:04:47 -0000
Date:   Tue, 9 Feb 2021 10:04:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        okukatla@codeaurora.org, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: interconnect: Fix the expected number of
 cells
Message-ID: <20210209160447.GA3848842@robh.at.kernel.org>
References: <20210121145320.2383-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121145320.2383-1-georgi.djakov@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 21 Jan 2021 16:53:20 +0200, Georgi Djakov wrote:
> "make dtbs_check" complains that the number of interconnect-cells
> for some RPMh platforms is not "const: 1" (as defined in the schema).
> 
> That's because the interconnect-cells now can be 1 or 2, depending
> on what is supported by the specific interconnect provider. Let's
> reflect this in the schema.
> 
> Fixes: 9a34e7ad2e12 ("dt-bindings: interconnect: Document the support of optional path tag")
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>  Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
