Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31951F9EDA
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 19:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgFORug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 13:50:36 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:39175 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgFORug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2020 13:50:36 -0400
Received: by mail-il1-f195.google.com with SMTP id p5so16149186ile.6;
        Mon, 15 Jun 2020 10:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QqFXAIP35kaKyGPJGm7boR5Cw7I5I86IlWfC5gy7jdY=;
        b=kiIpc7AIL8Dk1fC0dggM5w81CZwU2lyBNIv0tFHeEQ9QzoHqcXPW455jjrSgyjTIwr
         b9c6fHRM1AFlHMI0/ziww7CDIvlcPL77po3V+/Cax7rp51kVdaEUOlNl134THIOL5zYO
         8Cq2nYBvkW2IcWwtaVo8Ywl9HOgFnPe8huvJEiMSMrOcOTZAExhFIyzwzBNkFL6TFs/M
         ZYAj8Pd3pjOjHYqYsJC6b4fJbM2WDyzda7zfJHmuJrEnrqkwLHdPtV4oQIhJ5po6QU4u
         8fNbYWQtjY6xEg2SJdPxB7Gggh8clzN1XYk5rGWJ3plBcXwAHiTc1QVdEM7+L4bBmwSx
         mOiQ==
X-Gm-Message-State: AOAM531AeRH2ukfl9fkBECMnt+Z1sWiokhdZfPTKP5zEu/4I/0OA7EQK
        UaVQqfG5YSlBgVAJfU7EZQ==
X-Google-Smtp-Source: ABdhPJxCEkYl2U35hyzTpC6rWtsSN7STUGL7WtCf6JOtFuiSQmZkx9jnmtarBm3jhTOq8YQocc2Szw==
X-Received: by 2002:a92:aa13:: with SMTP id j19mr27556195ili.193.1592243434058;
        Mon, 15 Jun 2020 10:50:34 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b65sm8511986ilg.82.2020.06.15.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 10:50:33 -0700 (PDT)
Received: (nullmailer pid 2031787 invoked by uid 1000);
        Mon, 15 Jun 2020 17:50:32 -0000
Date:   Mon, 15 Jun 2020 11:50:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        kernel@collabora.com, Emil Velikov <emil.velikov@collabora.com>,
        linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Sebastian Reichel <sre@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCHv2 2/6] power: supply: gpio-charger: Make gpios optional
Message-ID: <20200615175032.GA2031757@bogus>
References: <20200605224403.181015-1-sebastian.reichel@collabora.com>
 <20200605224403.181015-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605224403.181015-3-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 06 Jun 2020 00:43:59 +0200, Sebastian Reichel wrote:
> While strongly recommended, not all devices have a gpio to
> detect if the charger is connected. This moves the 'gpios'
> from required to optional section.
> 
> This also modifies error handling for the GPIO a bit: We
> no longer fallback to pdata, if a GPIO is specified using
> GPIO descriptor tables. This is a bit cleaner and does
> not have any real impact: There are only two mainline pdata
> users (arm/mach-sa1100/collie.c, arm/mach-pxa/tosa.c) and
> none of them specify the GPIO via gpiod descriptor tables.
> Once both have been converted the driver's support for
> specifying GPIOs numbers in pdata will be dropped.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/power/supply/gpio-charger.yaml   |  7 +++-
>  drivers/power/supply/gpio-charger.c           | 38 ++++++++++++-------
>  2 files changed, 31 insertions(+), 14 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
