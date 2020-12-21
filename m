Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0184A2E0063
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 19:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgLUSrw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 13:47:52 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:38575 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgLUSrv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 13:47:51 -0500
Received: by mail-oo1-f53.google.com with SMTP id i18so2441935ooh.5;
        Mon, 21 Dec 2020 10:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9c4Z1cR0okEDOva6ZJZicR2jBIUZ+5XrWMqkg7M3kpw=;
        b=hz3KlOPy99wyUWikmU8eY5avjkr6YqZ/MHNscLb8qTxnR5ow5mZQfkEp1BQhK9yvDD
         QkvcBmjUMi1/Yd+yP+tGSDbHIGoAnTFW27ANdXx3mMbDS9ZYatSOFtQGKbnrsmvjW+K2
         /dT870LPVAWhfhuDQEsiobUPs5+cuxn+1DViJZMhGjbBolk5+UJmlN2bkikgU22OTGhZ
         4K9O8X7+l0yzF5d0s+mv1Xmy5d8gKGrooib30gPj42QqB2s3Vqb8ObvT9oPrLazGUg+x
         aZCAnyWBnwY7KWt/vbq6CexJOUSZeN0646BBLp5MDT+2HuZH9qiP+eqjr3MdTaMxJMLE
         rNcw==
X-Gm-Message-State: AOAM5319kvPhdn1bD84KFShpOD53RplkYw4wKjIF+sSAW9e6/6kPqGCf
        fLMjmbf1FU3L+7hCdBfblQ==
X-Google-Smtp-Source: ABdhPJxHtxtQavMpTMYOeQXfbwlNAzcd18hUq1nv29288DdMCrjnzy/vnMDlD21MGqurHNxrq5tuvg==
X-Received: by 2002:a4a:8353:: with SMTP id q19mr7538448oog.40.1608576430556;
        Mon, 21 Dec 2020 10:47:10 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t72sm3697688oie.47.2020.12.21.10.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:47:09 -0800 (PST)
Received: (nullmailer pid 344465 invoked by uid 1000);
        Mon, 21 Dec 2020 18:47:07 -0000
Date:   Mon, 21 Dec 2020 11:47:07 -0700
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        Matheus Castello <matheus@castello.eng.br>,
        Stephen Boyd <sboyd@kernel.org>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Angus Ainslie <angus@akkea.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 17/18] mfd: max14577: Do not enforce (incorrect) interrupt
 trigger type
Message-ID: <20201221184707.GA344409@robh.at.kernel.org>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-17-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210212534.216197-17-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 10 Dec 2020 22:25:33 +0100, Krzysztof Kozlowski wrote:
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
> 
> The Maxim 14577/77836 datasheets describe the interrupt line as active
> low with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
> 
> The interrupt line is shared between PMIC and charger driver, so using
> level sensitive interrupt is here especially important to avoid races.
> With an edge configuration in case if first PMIC signals interrupt
> followed shortly after by the RTC, the interrupt might not be yet
> cleared/acked thus the second one would not be noticed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> This patch should wait till DTS changes are merged, as it relies on
> proper Devicetree.
> ---
>  Documentation/devicetree/bindings/mfd/max14577.txt | 4 ++--
>  drivers/mfd/max14577.c                             | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
