Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BA11CF83E
	for <lists+linux-pm@lfdr.de>; Tue, 12 May 2020 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgELPA7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 May 2020 11:00:59 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34420 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgELPAs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2020 11:00:48 -0400
Received: by mail-oi1-f193.google.com with SMTP id c12so17474741oic.1;
        Tue, 12 May 2020 08:00:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K2qEAhn3BL894xmtaV/upHqpgOLZLhF17B7mhH3SLdw=;
        b=EQPd2xqybJGXrUnMdAohRdQypB0fQEtUJgvegjsikb1Y7OVePu+xywjtTgJ4v+0y9X
         1WTBrYJXXPn2SK/1Ea+a8GVC9Wx5NipwZA3ZLIyCU+v3eCpwJMCQdj0vqYiWC8bv4f0O
         hiFalfZgnFOqFd7sQUzyQzIzlDC2doPZG7iP1OgYlFSlQqT8qzRnb0+xTOsvuoOmYDoo
         JFiWw3f4zB1r7oIeQk1LBM72GyxLOdBciSADDz4h3CCg5DkprfVcrRPOWqYyvqCBwWIQ
         xfCDYsRz2OuUGAxpfmrKGxOAwf7MsiEiISz77Z3Tq/Oz9x8ec/bPAgdeH5KG9XhB9yam
         bJPA==
X-Gm-Message-State: AGi0PuZcljvu3vCrbrMtHlOwuYcrwU1inmCHTpXKcagTrkvYnR6S3gHG
        yK58rTViK3rwq2rUoX9HHQ==
X-Google-Smtp-Source: APiQypKZIkofztkq59hpBx1iHRg0VN9CZze8uMwIbm08YX4fu5XJHMAkcofCOlv4ErOSk8Lh5NqzAg==
X-Received: by 2002:a05:6808:8ed:: with SMTP id d13mr22974291oic.149.1589295647581;
        Tue, 12 May 2020 08:00:47 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c25sm3476892otp.50.2020.05.12.08.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:00:46 -0700 (PDT)
Received: (nullmailer pid 8751 invoked by uid 1000);
        Tue, 12 May 2020 15:00:46 -0000
Date:   Tue, 12 May 2020 10:00:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     devicetree@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2] dt-bindings: thermal: Convert UniPhier thermal
 monitor to json-schema
Message-ID: <20200512150046.GA8622@bogus>
References: <1588215934-13252-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588215934-13252-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 30 Apr 2020 12:05:34 +0900, Kunihiko Hayashi wrote:
> Convert the UniPhier thermal monitor binding to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
> 
> Changes since v1:
> - Add maxItems to "socionext,tmod-calibration" property
> - Fix indents in examples
> 
> .../thermal/socionext,uniphier-thermal.yaml        | 59 ++++++++++++++++++++
>  .../bindings/thermal/uniphier-thermal.txt          | 65 ----------------------
>  2 files changed, 59 insertions(+), 65 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/thermal/socionext,uniphier-thermal.yaml
>  delete mode 100644 Documentation/devicetree/bindings/thermal/uniphier-thermal.txt
> 

Applied, thanks!
