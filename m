Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2D72D7112
	for <lists+linux-pm@lfdr.de>; Fri, 11 Dec 2020 08:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436818AbgLKHsn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Dec 2020 02:48:43 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39435 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388543AbgLKHsl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2020 02:48:41 -0500
Received: by mail-ed1-f67.google.com with SMTP id c7so8343856edv.6;
        Thu, 10 Dec 2020 23:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P0wPTNnTMMvMYQoXIJsxDc+GGcUdhHlmPr5EHW78xzw=;
        b=mezpfFhm+fgbJylmhl7dWQ9OmYRZESoDJ6ZeK8aBYf9ayecJqbKvJ3KzeAY1eoHDN9
         3wokP5Gb+LqU/vOAlClr861ILhKDcptK9Rg9mdZ9Cfmj1gWf5ZfluFILH7KDXCu76unI
         12PN3urktFUhOTcFcEh9y2m/6TSbg/TwNH/NHjjt0WayzJt1ypXHQ/K0vCGg2MS2bVmU
         u1SQh9Tn58bNzsT7f+MNG7oeQcxgnBKa4mdQqdNvIIm2Vw632yiQjX3tMgwjwbCrc8Xl
         FOCM5fiRJGUogkcv+l7fz51Y0nTKultUqOipAjchhntwKrSw1jBJlpyORy6WzEAzulSg
         UUlw==
X-Gm-Message-State: AOAM532wnUX8gR25rqGgdkAUPJEw8hP6MXLoF/ho9VfVqcwXuTQlcBpW
        SlL4BI/4yGxTinAPfDuWI9cj9OTMbDXxGg==
X-Google-Smtp-Source: ABdhPJx/k/HGToQvr22UR3Xq7vPsj2TvNmpm8kE7Hr4dtKfaS9AYncLFODFCgjOBi92luTKLln+RDw==
X-Received: by 2002:a50:e688:: with SMTP id z8mr10777681edm.129.1607672878059;
        Thu, 10 Dec 2020 23:47:58 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id qn4sm6333309ejb.50.2020.12.10.23.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 23:47:57 -0800 (PST)
Date:   Fri, 11 Dec 2020 08:47:55 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Cc:     Iskren Chernev <iskren.chernev@gmail.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Angus Ainslie <angus@akkea.ca>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [RFC 18/18] power: supply: max17040: Do not enforce (incorrect)
 interrupt trigger type
Message-ID: <20201211074755.GA4346@kozik-lap>
References: <20201210212534.216197-1-krzk@kernel.org>
 <20201210212534.216197-18-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201210212534.216197-18-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 10, 2020 at 10:25:34PM +0100, Krzysztof Kozlowski wrote:
> Interrupt line can be configured on different hardware in different way,
> even inverted.  Therefore driver should not enforce specific trigger
> type - edge falling - but instead rely on Devicetree to configure it.
> 
> The Maxim 14577/77836 datasheets describe the interrupt line as active
> low with a requirement of acknowledge from the CPU therefore the edge
> falling is not correct.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> This patch should wait till DTS changes are merged, as it relies on
> proper Devicetree.
> ---
>  .../devicetree/bindings/power/supply/max17040_battery.txt       | 2 +-
>  drivers/power/supply/max17040_battery.c                         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> index c802f664b508..194eb9fe574d 100644
> --- a/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/max17040_battery.txt
> @@ -39,7 +39,7 @@ Example:
>  		reg = <0x36>;
>  		maxim,alert-low-soc-level = <10>;
>  		interrupt-parent = <&gpio7>;
> -		interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> +		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
>  		wakeup-source;
>  	};
>  
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
> index d956c67d5155..f737de0470de 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -367,7 +367,7 @@ static int max17040_enable_alert_irq(struct max17040_chip *chip)
>  
>  	flags = IRQF_TRIGGER_FALLING | IRQF_ONESHOT;

This has to be removed. I will fix it in v2.

Best regards,
Krzysztof


>  	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -					max17040_thread_handler, flags,
> +					max17040_thread_handler, IRQF_ONESHOT,
>  					chip->battery->desc->name, chip);
>  
>  	return ret;
> -- 
> 2.25.1
> 
