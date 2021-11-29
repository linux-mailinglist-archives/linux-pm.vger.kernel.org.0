Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFA460BE5
	for <lists+linux-pm@lfdr.de>; Mon, 29 Nov 2021 01:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376696AbhK2A72 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Nov 2021 19:59:28 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37627 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376620AbhK2A52 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Nov 2021 19:57:28 -0500
Received: by mail-oi1-f180.google.com with SMTP id bj13so31434916oib.4;
        Sun, 28 Nov 2021 16:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6S/nc46VwIkR2+UhJoNELUkOKxAArGr2LqJXQQQ/Fk4=;
        b=Gqey1AyfXFVnWADfowouTH3OfzdQtFd2YgXPH0QwIfqXptWLbx4kMJNsyqWFjSA+xp
         Hr3oanCCWFVLShItGZCnulSibmdAPZBDietCoYqX2RF2AgdV7eeR2iuI+CwAPeKtnCQK
         5YFOtxEu/mk2Egr5HEdoTmLdwvwaoXS2FZm83fPIP2sKuVGKOEGkCobX8ZNVmEO1xWxp
         OxzUiCIBu+nTp6ogNyxIlvocCmIT3oNdD63GuFNA7GcOw0UunBQ8exQu1G6CuZ/QxoFp
         RtD3UoQlAv7bfoym61aA2CESqgWOk6FgyLOEns72FxB5GwRUQ1RHc8RhQA1EAgqUI0/m
         +agw==
X-Gm-Message-State: AOAM5338r+9WLFIdZXXrDQ5uq8R3uPpX/Rl2Y2V+qya1U6OqEJSO98a/
        z1VZTUxvy6HqByhGkfKWp4MkTkY02w==
X-Google-Smtp-Source: ABdhPJwzNA6pO7oyd9s3I3YUI8XH+z8/KykRSMx7AAMTbFZ34s3AftlSK4/JmuiOCcLORTnAL5sH4w==
X-Received: by 2002:a05:6808:1485:: with SMTP id e5mr38785436oiw.156.1638147250942;
        Sun, 28 Nov 2021 16:54:10 -0800 (PST)
Received: from robh.at.kernel.org ([172.58.99.229])
        by smtp.gmail.com with ESMTPSA id a3sm2383071oti.29.2021.11.28.16.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 16:54:10 -0800 (PST)
Received: (nullmailer pid 2924572 invoked by uid 1000);
        Mon, 29 Nov 2021 00:54:07 -0000
Date:   Sun, 28 Nov 2021 18:54:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Johan Hovold <johan@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-serial@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 02/11] dt-bindings: i2c: apple,i2c: Add power-domains
 property
Message-ID: <YaQkr62kOyb6JNfp@robh.at.kernel.org>
References: <20211124073419.181799-1-marcan@marcan.st>
 <20211124073419.181799-3-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124073419.181799-3-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 24 Nov 2021 16:34:12 +0900, Hector Martin wrote:
> This will bind to the PMGR pwrstate nodes that control power/clock
> gating to SoC blocks. The i2c driver doesn't do runtime-pm yet, so
> initially this will just keep the domain on permanently.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/i2c/apple,i2c.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
