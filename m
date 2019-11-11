Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 567E3F716D
	for <lists+linux-pm@lfdr.de>; Mon, 11 Nov 2019 11:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfKKKJn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 11 Nov 2019 05:09:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36213 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKKJn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Nov 2019 05:09:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so13944376wrx.3
        for <linux-pm@vger.kernel.org>; Mon, 11 Nov 2019 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=q1gcdAuprbatyWKkiOOKDI/wj2JLtRiEXlBcqAh4zX4=;
        b=rEWMCqggEUDE7cVXtoWuQexxvnbKSDQV6c6U/fkxvFGJm7L4aF1SeWXpAjgAZ7x+Yk
         WfKOWLDkFrYWNFG0RPV/2Osii2ceVDIJ526aWPkKLacohkDqw/yQEtPLwVWB4PmoZR+n
         mkVXScsTN6ntyA0myz0WBHaA9xbC/1qVDON0Psf+bj6BcBd6FzL1vLu7qH/fs2ubu56G
         9sj5EMGDTlfyOUH/z0yBZfVsBS3cLqRIquMy3Ej/bIXSQ6sa26zmWMw58TxwXIBdGt+R
         40ibglcoJK/qarkFYtWh69f3ScLmDdycMHyCDKZF6pCw9vAhBJ1NSPUQFh6X7CoQt3Oy
         4XvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=q1gcdAuprbatyWKkiOOKDI/wj2JLtRiEXlBcqAh4zX4=;
        b=qG6lm8Km4to5RCcOaOHNPgYB+Oa9NRrB9crWc9ZMrP4QQpVgQLuSneTuVYA2rJ7ACD
         hsJn9DAYehKgxhkbF6QohCJpVeSEi0Jcd5SM68tBWs+0CIEOxq9YfMoZ1pgTEDz9vkL7
         ZKnNaYhrLcJRouortgCVq8WEJbVMepEiGEWxejTOxvu/oUGQTC33sELlFiGssgthaqmA
         pDXoq/3o3cfanmukkQDfAwoemIGIJRz4lDr7Gx5zUMK1cgSI3VV3XHxJmoqa6e4AK5Av
         bEFrqefUeA9c+gyW1Km3Y9RzCeAIs7mtl7Z4tBomcG1qlfenGmeczvdtqYOcQVLeOyy9
         Xjvw==
X-Gm-Message-State: APjAAAVMmx+fu/rgIL19t5wwisoz5PcUcXbI8tQrkEx3/2fZU6pgBELg
        OHsSwP2yfRVLphG+zhlG6YkCgg==
X-Google-Smtp-Source: APXvYqzED02dA+VSYRlFFbMfPRcHWDXKauK0WK6Gg2MePenGPqevIQ+u8VGs6q8usm8QJOEUhROmDg==
X-Received: by 2002:a5d:4584:: with SMTP id p4mr20886825wrq.345.1573466981232;
        Mon, 11 Nov 2019 02:09:41 -0800 (PST)
Received: from dell ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id 11sm19310682wmb.34.2019.11.11.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 02:09:40 -0800 (PST)
Date:   Mon, 11 Nov 2019 10:09:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     sre@kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] devicetree: mfd: max14577: Add reference to
 max14040_battery.txt descriptions
Message-ID: <20191111100933.GE3218@dell>
References: <20191105095905.GA31721@pi3>
 <20191107031710.5672-1-matheus@castello.eng.br>
 <20191107031710.5672-4-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191107031710.5672-4-matheus@castello.eng.br>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 07 Nov 2019, Matheus Castello wrote:

> max77836 MFD has a fuel gauge that has a low SOC alert feature that is
> described in Documentation/devicetree/bindings/power/supply/max17040_battery.txt.
> Adding the reference to de documentation here.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  Documentation/devicetree/bindings/mfd/max14577.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
> index fc6f0f4e8beb..04d790b1513c 100644
> --- a/Documentation/devicetree/bindings/mfd/max14577.txt
> +++ b/Documentation/devicetree/bindings/mfd/max14577.txt
> @@ -5,6 +5,8 @@ Battery Charger and SFOUT LDO output for powering USB devices. It is
>  interfaced to host controller using I2C.
> 
>  MAX77836 additionally contains PMIC (with two LDO regulators) and Fuel Gauge.
> +For the description of Fuel Gauge low SOC alert interrupt see:
> +Documentation/devicetree/bindings/power/supply/max17040_battery.txt

I would prefer the use of relative paths in documentation.

Once fixed, please apply my:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
