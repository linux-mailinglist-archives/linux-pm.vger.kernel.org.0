Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6467F460BF6
	for <lists+linux-pm@lfdr.de>; Mon, 29 Nov 2021 02:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376721AbhK2BEA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Nov 2021 20:04:00 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:34490 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376621AbhK2BCA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Nov 2021 20:02:00 -0500
Received: by mail-oi1-f171.google.com with SMTP id t19so31478356oij.1;
        Sun, 28 Nov 2021 16:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y/a5SrGnb/XTLo71HExkMxJ2aSc5igObTMGYH6iJqxw=;
        b=MaxgrEJ9kVXY5XXDOdy+s9uzR4eVG+3gcFhOeO+yJlNEMnvTLk4q9UBxVuVYT/1akW
         /folIEtQiJMbuRVRkCF6DP2t7SFWeu1zB6mvd0D+C4+j5ZsVlrZQ9qDpr6U2bW/O/gIw
         V1GBESEOuATPStDxSLKS6aoiS3XurdSS5erjAw5vLMN2I2dUhN3JrzDGTjIvQ1yJdova
         Kh76EEmPMvA2oCSG/mwYfCjWLOvPEGBQEP3i0CKujZXzotlB75OR2lC+V9zx5WrqRlcZ
         SQa2eL2lt6sVk2b0dL9UQC6opk54LHeXYZ8p3uKJzKwMlep9fke01gjgwAB7wCsi5qWM
         0CFQ==
X-Gm-Message-State: AOAM532w21deBJt8YPOHGaqjpxMSC4wEMnmHtHBHCqroOfuex4kTwZdT
        wV/oqqTnOvUByIkUJRiL+g==
X-Google-Smtp-Source: ABdhPJypRIoiUvevacnf9rYH5eAOux+cJILxVBt+msqxtvl/I+4yRYtPnywHby5kj39GYE4ENE/MNQ==
X-Received: by 2002:a05:6808:1308:: with SMTP id y8mr38686417oiv.49.1638147523460;
        Sun, 28 Nov 2021 16:58:43 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id 69sm2382500otf.33.2021.11.28.16.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:58:42 -0800 (PST)
Received: (nullmailer pid 2931465 invoked by uid 1000);
        Mon, 29 Nov 2021 00:58:40 -0000
Date:   Sun, 28 Nov 2021 18:58:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Arnd Bergmann <arnd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v3 05/11] dt-bindings: interrupt-controller: apple,aic:
 Add power-domains property
Message-ID: <YaQlwK4IxxC2bX3I@robh.at.kernel.org>
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124073419.181799-6-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124073419.181799-6-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Nov 2021 16:34:15 +0900, Hector Martin wrote:
> This will bind to the PMGR pwrstate nodes that control power/clock
> gating to SoC blocks. The AIC driver doesn't do runtime-pm and likely
> never will (since it is system-critical), but it makes sense to describe
> the power domain relationship the devicetree properly.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../devicetree/bindings/interrupt-controller/apple,aic.yaml    | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
