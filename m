Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009C92E004E
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 19:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgLUSq1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 13:46:27 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34844 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgLUSq0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 13:46:26 -0500
Received: by mail-oi1-f181.google.com with SMTP id s2so12277914oij.2;
        Mon, 21 Dec 2020 10:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C9YKK11A4vCGj5j/fzBjsXO3fgizirMdIUh+8Fg05fI=;
        b=clOMcac/mpAzXCPLZrjNtRmjc0yV/KtdfkIwUq0GEYQdt/A+dgKwN34diFx858EjIg
         5IZOrzlYJGjnpfSohVcrw3Ra3OnyAcr/S9PaPAcxqt4w4RkddjNM92jAdFInBGRiqifT
         0kKiBNB5YaNyFovt1QEiopNNtNnSPqFzrdZPMdNFdTnpoMc/8L7KsKgtbkLodKDLzoUr
         jGNRMgyhCHYkBQMznCru2EaJMl7BPS9ToMKLW0fWRTTSbJ17/7JRHI4cfwS2/K8vrDjs
         951IebVDfMjymLGdV7CUS8KuoOMtFZmbp3fFy9mVUobRvAgMWg95SVnQkspZu9EbNr5b
         o71Q==
X-Gm-Message-State: AOAM533akQcgwOuHO5YBkuj4sL5ZIxuCzj7Uw+0I2KvnOlRrcZGLBxMz
        ehzyJp/dOsdx74ec2UPPfQ==
X-Google-Smtp-Source: ABdhPJwrQo7oPkw60HM1iX43AnG0rd1ZwQBteBiGRAjzgAnn+m2o5dKSjOcluwF2SZZoZnF1ypSzkA==
X-Received: by 2002:aca:ea42:: with SMTP id i63mr7148216oih.163.1608576345226;
        Mon, 21 Dec 2020 10:45:45 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id x31sm3946058otb.4.2020.12.21.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:45:44 -0800 (PST)
Received: (nullmailer pid 342072 invoked by uid 1000);
        Mon, 21 Dec 2020 18:45:42 -0000
Date:   Mon, 21 Dec 2020 11:45:42 -0700
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Angus Ainslie <angus@akkea.ca>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-rtc@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC 13/18] mfd: max77686: Do not enforce (incorrect) interrupt
 trigger type
Message-ID: <20201221184542.GA342038@robh.at.kernel.org>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-13-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210212534.216197-13-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Dec 2020 22:25:29 +0100, Krzysztof Kozlowski wrote:
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
> 
> The Maxim 77686 datasheet describes the interrupt line as active low
> with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
> 
> The interrupt line is shared between PMIC and RTC driver, so using level
> sensitive interrupt is here especially important to avoid races.  With
> an edge configuration in case if first PMIC signals interrupt followed
> shortly after by the RTC, the interrupt might not be yet cleared/acked
> thus the second one would not be noticed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> This patch should wait till DTS changes are merged, as it relies on
> proper Devicetree.
> ---
>  Documentation/devicetree/bindings/clock/maxim,max77686.txt | 4 ++--
>  Documentation/devicetree/bindings/mfd/max77686.txt         | 2 +-
>  Documentation/devicetree/bindings/regulator/max77686.txt   | 2 +-
>  drivers/mfd/max77686.c                                     | 3 +--
>  4 files changed, 5 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
