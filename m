Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5335E2E0051
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 19:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgLUSq5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 13:46:57 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34173 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbgLUSq4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 13:46:56 -0500
Received: by mail-ot1-f47.google.com with SMTP id a109so9724965otc.1;
        Mon, 21 Dec 2020 10:46:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LaO8M0BQW8Ol84jvAC5SvqGxfW76On/n2SEzgRenXkA=;
        b=NtHBaz36gQTgjB5ckv7p2b0m+kTLuAayi9IDWSdalAV6t5ov13IFivIxOwzFgsKD6G
         6Drc/rrETG+bBxuVxK7XYZSOOXFyJOJvA5N0O/QJpgN4AU8eFo4kwLghQxok2JIi+c6A
         8CcrWvFsLpi7SnopnH5KYfRLsonZ0H/wNDDQCjVetHNy1LtA5Yz4RQBPnq3HZ1GIqt4G
         cAap2SHFsuf0QZFjq0tF08X3dddriKy8bHjuF5FSp6eCeeVNejJdy8m7ib4Ao25NJ8zk
         qn1sNGe2+CcenTYprJ5qgcImmWTfc2WQJ/OY8ARj1YGkSn5CvAQNWwryGsxLUr9GIEhP
         pDLg==
X-Gm-Message-State: AOAM530k3BgEwh2Va1knl5jstKUTx86Xuk9DEopUWUTOqx+lDelkTitG
        C6YfPhwvj4aFrxlb7Yb2Dw==
X-Google-Smtp-Source: ABdhPJwBJoFXtzbcelVumUza445XagA6T8nK1JW5vIV8hPvpK/hSG3/068uI21rsv342ZPIwm7xnSw==
X-Received: by 2002:a9d:7411:: with SMTP id n17mr12863728otk.262.1608576375645;
        Mon, 21 Dec 2020 10:46:15 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id z9sm3954201ote.13.2020.12.21.10.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:46:14 -0800 (PST)
Received: (nullmailer pid 342965 invoked by uid 1000);
        Mon, 21 Dec 2020 18:46:12 -0000
Date:   Mon, 21 Dec 2020 11:46:12 -0700
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Angus Ainslie <angus@akkea.ca>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-rtc@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        linux-clk@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pm@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        linux-arm-kernel@lists.infradead.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [RFC 15/18] mfd: max77693: Do not enforce (incorrect) interrupt
 trigger type
Message-ID: <20201221184612.GA342913@robh.at.kernel.org>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-15-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210212534.216197-15-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Dec 2020 22:25:31 +0100, Krzysztof Kozlowski wrote:
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
> 
> The Maxim 77693 datasheet describes the interrupt line as active low
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
>  Documentation/devicetree/bindings/mfd/max77693.txt |  2 +-
>  drivers/mfd/max77693.c                             | 12 ++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
