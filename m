Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4289F126ED5
	for <lists+linux-pm@lfdr.de>; Thu, 19 Dec 2019 21:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLSUYN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Dec 2019 15:24:13 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45727 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfLSUYN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Dec 2019 15:24:13 -0500
Received: by mail-ed1-f67.google.com with SMTP id v28so6131589edw.12;
        Thu, 19 Dec 2019 12:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kfPOftMgyHwmTl9WE1/kmaYqo1mCz0RjY/e682DeC3s=;
        b=h2qyv2C8YoEyCpsGqxXc5SgrKLHNHZGATRXyxkdoGgDr/v6t7hR/EoyS3XbDeYxcZp
         rllAPHs1W8024+ZKoVbUBKXXeSOPTTwq5dwWBqpPH7yv0ISqUvRtKKuSE4mOPuGkmNfw
         /+rQhwUr3wutkqRG7KnfPPQyGdBBnSQqTikj5xVwD4IC1oP2i0LQ+fDmaNHbR9wNSjbN
         EwAcwzMQM3GBEH+IhCqDbtS81TKwhfRTKNOgdb9AX/u/Xix+oESN++6XVupR201CWnFO
         8hIedFoSEGTPo9/PVdchsRoJRHBrLzwAaYk/BVwwOgNJp7ugXZgXZlNOUJtAt4wTzkfr
         6blg==
X-Gm-Message-State: APjAAAXGtlUJHWUBDfHETXa01Ihg5Y3RP9mgyA88Cu+kdEoMw7c3OqDt
        WDpQVOAeRDDhjlciUNccMX4LFHw0
X-Google-Smtp-Source: APXvYqxhei91nPSOagRw+yW1O53K+HsOw19umpw0wFdmEKPWZTgVHzJaJjee30WnP+VobmEWUSYBBQ==
X-Received: by 2002:a05:6402:12d2:: with SMTP id k18mr11351647edx.253.1576787050963;
        Thu, 19 Dec 2019 12:24:10 -0800 (PST)
Received: from kozik-lap ([194.230.155.234])
        by smtp.googlemail.com with ESMTPSA id r19sm698496ejr.33.2019.12.19.12.24.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Dec 2019 12:24:10 -0800 (PST)
Date:   Thu, 19 Dec 2019 21:24:08 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Kamil Konieczny <k.konieczny@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: exynos: Move bus related OPPs to the
 boards DTS
Message-ID: <20191219202408.GA22054@kozik-lap>
References: <20191219105130.29394-1-m.szyprowski@samsung.com>
 <CGME20191219105136eucas1p1edadfa2fba7f15ec03f0eec7570809ce@eucas1p1.samsung.com>
 <20191219105130.29394-2-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191219105130.29394-2-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Dec 19, 2019 at 11:51:29AM +0100, Marek Szyprowski wrote:
> Currently the only Exynos5422-based boards that support bus frequency
> scaling are Hardkernel's Odroid XU3/XU4/HC1. Move the bus related OPPs to
> the boards DTS, because those OPPs heavily depend on the clock topology
> and top PLL rates, which are being configured by the board's bootloader.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi             | 259 -----------------
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 261 +++++++++++++++++-

Thanks, applied.

Best regards,
Krzysztof

