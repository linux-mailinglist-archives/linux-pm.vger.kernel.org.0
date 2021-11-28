Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACD2460776
	for <lists+linux-pm@lfdr.de>; Sun, 28 Nov 2021 17:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358340AbhK1Q31 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Nov 2021 11:29:27 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41910 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238588AbhK1Q11 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Nov 2021 11:27:27 -0500
Received: by mail-ot1-f46.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so21987014otl.8;
        Sun, 28 Nov 2021 08:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cG1qxa/rrWWVkdtvrfpLEg36+/zmkNfWQBfrO1J/AJ0=;
        b=Y4R8HUxR4nPF66pwl+Rso9ofnZW8T8ipbwELKDPcJoHJYVsm6UrMgEviUEhBjEEbaE
         yAirSGnTyVwDncf63FK+HV9o2kgdvTbwvNUu9xzYw+6To27ZTTYZE8Yo4QTPjDbZ4EdZ
         rO3zwzjRYfXz4BjCsAigO9l42O4RzfkzGeNwVYC/CPGIYJotOGiTB8Lt8Hj6CCdI2UA5
         vCYwH7jvcbfPWXHinC1FwRPhE9Zc6wAJs+h7ij8/AI/rQarSA+rFCuRdL29a8vz4/ICi
         FfoKabVxr3uvmvRr9KqxHQurF3cTCk1uqzKX3CoWPsdQQe58ILn+CyWlmZ3YNSpI366z
         PoIQ==
X-Gm-Message-State: AOAM530L4teBbE53bhcSYmaxXKKIOnnbYVHIyU89xXKqPuc/gMpGjg2g
        IKtXS/7dul5newc5mY8qQA==
X-Google-Smtp-Source: ABdhPJyWZF1O9whdWrlsXv2WYoE8bZeLc/P4hZdeAVDksjHc648kjfISaZc4QX6fv/dSf1HH3LVmTQ==
X-Received: by 2002:a05:6830:22d8:: with SMTP id q24mr38568389otc.170.1638116650419;
        Sun, 28 Nov 2021 08:24:10 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d6:afc8:f6e9:d57a:3e26:ee41])
        by smtp.gmail.com with ESMTPSA id h3sm1933422ooe.13.2021.11.28.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:24:09 -0800 (PST)
Received: (nullmailer pid 2660694 invoked by uid 1000);
        Sun, 28 Nov 2021 16:24:04 -0000
Date:   Sun, 28 Nov 2021 10:24:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Kettenis <kettenis@openbsd.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 07/11] dt-bindings: arm: apple: Add apple,pmgr binding
Message-ID: <YaOtJPF+3ie2WyPB@robh.at.kernel.org>
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124073419.181799-8-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124073419.181799-8-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Nov 2021 16:34:17 +0900, Hector Martin wrote:
> The PMGR block in Apple Silicon SoCs is responsible for SoC power
> management. There are two PMGRs in T8103, with different register
> layouts but compatible registers. In order to support this as well
> as future SoC generations with backwards-compatible registers, we
> declare these blocks as syscons and bind to individual registers
> in child nodes. Each register controls one SoC device.
> 
> The respective apple compatibles are defined in case device-specific
> quirks are necessary in the future, but currently these nodes are
> expected to be bound by the generic syscon driver.
> 
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  .../bindings/arm/apple/apple,pmgr.yaml        | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
