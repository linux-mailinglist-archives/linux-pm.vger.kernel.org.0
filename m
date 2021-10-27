Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6643643C08B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Oct 2021 05:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbhJ0DL5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Oct 2021 23:11:57 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:45641 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbhJ0DL4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Oct 2021 23:11:56 -0400
Received: by mail-oo1-f47.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so441926oop.12;
        Tue, 26 Oct 2021 20:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fF9QXgLzosjL4TM7VadwMeUj8EchUoSjjtX4csjl1rU=;
        b=Ik4rpeqiEtMMizzsZXSF1Z9SbF2klQ9IQIHtnidOqDUpjUDIb6EoG3H9QQerqDf8cY
         QrVZ2dsnpIoKkVWFrWrEbowWNXMNyFpcZMLUoUIVZmY9cd0A9vr8x6in2N4EMjNX1wF9
         GlObdZqpPqbLwnHI9ak3foKf/2M5ATUyWkZv28eyLee7b9dofxObokiZHh6Mq9HxbcEd
         q5l7O+9Lvcmi/M5h9OfHNS43b/MkRKKL2sUz69OZjxM/OX2HxUNh1iXrauPDy/QO9Nor
         g2vjdpY3zmNBZ2Bk+MolpQrwN7uil0itPXpiFv4P5Ho3LzHmBvPC3m9eB9JL6WAwzJ5s
         XMYA==
X-Gm-Message-State: AOAM531Rj2zg1MejIhuuNCAkHfCGuA+KwNgjcMJseSKXuMnxSjsYTHzj
        9xhh+cz8dAggM8z+fTLglQ==
X-Google-Smtp-Source: ABdhPJzP41q/WyN+8LLe8tlwuSoBpsMFovkHFy5Yho2Qv71qtpA7ktzQadUc9hIiXylOeSIXG44skQ==
X-Received: by 2002:a4a:b307:: with SMTP id m7mr4884736ooo.83.1635304171532;
        Tue, 26 Oct 2021 20:09:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j6sm4395944oot.18.2021.10.26.20.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 20:09:30 -0700 (PDT)
Received: (nullmailer pid 3941875 invoked by uid 1000);
        Wed, 27 Oct 2021 03:09:29 -0000
Date:   Tue, 26 Oct 2021 22:09:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        khilman@baylibre.com, linux-mediatek@lists.infradead.org,
        fparent@baylibre.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: thermal: mediatek: Add mt8365
Message-ID: <YXjC6VkMSrOECEEu@robh.at.kernel.org>
References: <20211019093404.1913357-1-msp@baylibre.com>
 <20211019093404.1913357-2-msp@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019093404.1913357-2-msp@baylibre.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 19 Oct 2021 11:34:01 +0200, Markus Schneider-Pargmann wrote:
> This unit is present on the mt8365 SoC as well. But there is a
> difference in the usage of an apmixed register.
> 
> This patch adds a distinct mt8365 to the list of compatibles.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
