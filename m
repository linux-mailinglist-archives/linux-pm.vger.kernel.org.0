Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808E9126ED6
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbfLSUYX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:24:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40941 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfLSUYX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 15:24:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id b8so6143512edx.7;
        Thu, 19 Dec 2019 12:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I2+p8NlKry3xnqQ7h3e1FsCdXuJneE8ptKtuMElAYWk=;
        b=nMXMu1TGK0qXBcv/PnXfsxJUCvsvf38JRy20k3u6k7oGH1MgF78IBpe/qGao9srwGX
         vM1DMFPpmLWWa7J81mRopHWtQ7UwY6MxVNd+md/VpgXN35IX/LBKQvBJX+veWH5FDQL4
         5d4tfGHPXzWWtw5pqIdzIIpIgv9/o88t7ABgiJFKR68MASCb9xqKLrGyyp1TcGi0DpYa
         DEawLULNekK/07sW2NlnDnLTPKFlac3pzXs167GipcO0wZjvqNMfItmS1pqqCeq4dTAr
         3T3NEDq8kc/P4zUOlc1LPuJ1eDxsnKKgw8QUil+h3pTq/vq6e0cR9OjgM8QixgGcwMWX
         soBw==
X-Gm-Message-State: APjAAAXuKSzDVi319jT1oW6YjhfKB09UWAzMqd6vOZnBLSUze0VGiJcS
        UdAaYo5gXIwR20e/F/kfp9yQbro+
X-Google-Smtp-Source: APXvYqy4wHEYCmq60laSfl3Ysp1g1eN7aV16Sr1zaPlCXaAZmYXLUO9xup1nfJuWHZOjf/BRvn2+nw==
X-Received: by 2002:a17:906:ce2e:: with SMTP id sd14mr11879029ejb.190.1576787060915;
        Thu, 19 Dec 2019 12:24:20 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id v2sm731841ejj.44.2019.12.19.12.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 12:24:19 -0800 (PST)
Date:   Thu, 19 Dec 2019 21:24:17 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: Adjust bus related OPPs to the
 values correct for Odroids
Message-ID: <20191219202417.GB22054@kozik-lap>
References: <20191219105130.29394-1-m.szyprowski@samsung.com>
 <CGME20191219105136eucas1p1d57974e96a166308b4a692d1783936f8@eucas1p1.samsung.com>
 <20191219105130.29394-3-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219105130.29394-3-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 19, 2019 at 11:51:30AM +0100, Marek Szyprowski wrote:
> Hardkernel's Odroid XU3/XU4/HC1 boards use bootloader, which configures top
> PLLs to the following values: MPLL: 532MHz, CPLL: 666MHz and DPLL: 600MHz.
> 
> Adjust all bus related OPPs to the values that are possible to derive from
> the top PLL configured by the bootloader. Also add a comment for each bus
> describing which PLL is used for it.
> 
> The most significant change is the highest rate for wcore bus. It has been
> increased to 532MHz as this is the value configured initially by the
> bootloader. Also the voltage for this OPP is changed to match the value
> set by the bootloader.
> 
> This patch finally allows the buses to operate on the rates matching the
> values set for each OPP and fixes the following warnings observed on boot:
> 
> exynos-bus: new bus device registered: soc:bus_wcore ( 84000 KHz ~ 400000 KHz)
> exynos-bus: new bus device registered: soc:bus_noc ( 67000 KHz ~ 100000 KHz)
> exynos-bus: new bus device registered: soc:bus_fsys_apb (100000 KHz ~ 200000 KHz)
> ...
> exynos-bus soc:bus_wcore: dev_pm_opp_set_rate: failed to find current OPP for freq 532000000 (-34)
> exynos-bus soc:bus_noc: dev_pm_opp_set_rate: failed to find current OPP for freq 111000000 (-34)
> exynos-bus soc:bus_fsys_apb: dev_pm_opp_set_rate: failed to find current OPP for freq 222000000 (-34)
> 
> The problem with setting incorrect (in some cases much lower) clock rate
> for the defined OPP were there from the beginning, but went unnoticed
> because the only way to observe it was to manually check the rate of the
> respective clocks. The commit 4294a779bd8d ("PM / devfreq: exynos-bus:
> Convert to use dev_pm_opp_set_rate()") finally revealed it, because it
> enabled use of the generic code from the OPP framework, which issues the
> above mentioned warnings.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 76 +++++++++++--------

Thanks, applied.

Best regards,
Krzysztof

