Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE98376B13
	for <lists+linux-pm@lfdr.de>; Fri,  7 May 2021 22:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhEGUPP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 May 2021 16:15:15 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:41809 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhEGUPO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 May 2021 16:15:14 -0400
Received: by mail-oi1-f177.google.com with SMTP id c3so9744230oic.8;
        Fri, 07 May 2021 13:14:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RuKRz5YipTA+qaXZzryIVd/iPD3bqqhQhrBcu/BKRWU=;
        b=Gt3NTRX+NWPITxUHCTju9RDx7xUuVa2eY2clmKmglqyIobhWtf0OWnBTsT3VJj/liz
         pxkz5i7cLgclwBOkMiqyiYB/a/iP817it95ZABV3A6pTySH3y2HSz5mvQ3srQBLnoR1k
         sd5ZNAYsxn1t5JKIaI/BRccHU+z92aMTC3B2J1avD/bhJt+wGuyR42nenaMJOYjyN5sd
         IH8X7EPb9oekUTK5BgfoGJWeSSSlhkgiGntDVOe3mwZNN3MdSzpRoBC71NnAh/qTOYvF
         zO/Dr/MJVO/5zEIVudzHK7h74ORaxKSW+Mu5zU00+wFKg2SlvfMerLAnJPTvy7EfRgdi
         FdCg==
X-Gm-Message-State: AOAM532ftdldsSrhoy5ag8vyOmhlaZ3RrYe2dY6twddBi/WMoSAZESfF
        UTpjfgpwFLv38hShrD9DMQ==
X-Google-Smtp-Source: ABdhPJxo7he1CKGZ6WzCSrlIAfGi8UIaFNh7zQASI1eJA/uVgN+OBMcKm8UJW1RXjhpn41z6Hes/ww==
X-Received: by 2002:aca:cf82:: with SMTP id f124mr8538417oig.4.1620418452523;
        Fri, 07 May 2021 13:14:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z6sm229513oiz.39.2021.05.07.13.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 13:14:11 -0700 (PDT)
Received: (nullmailer pid 2803881 invoked by uid 1000);
        Fri, 07 May 2021 20:14:10 -0000
Date:   Fri, 7 May 2021 15:14:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, sanm@codeaurora.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        amitk@kernel.org, devicetree@vger.kernel.org,
        manafm@codeaurora.org, thara.gopinath@linaro.org,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
Subject: Re: [PATCH V4 1/3] dt-bindings: thermal: tsens: Add compatible
 string to TSENS binding for SC7280
Message-ID: <20210507201410.GA2803830@robh.at.kernel.org>
References: <1620367641-23383-1-git-send-email-rkambl@codeaurora.org>
 <1620367641-23383-2-git-send-email-rkambl@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620367641-23383-2-git-send-email-rkambl@codeaurora.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 07 May 2021 11:37:19 +0530, Rajeshwari Ravindra Kamble wrote:
> Adding compatible string in TSENS dt-bindings for SC7280.
> 
> Signed-off-by: Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
