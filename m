Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F42623B51D
	for <lists+linux-pm@lfdr.de>; Tue,  4 Aug 2020 08:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgHDGmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Aug 2020 02:42:19 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:34402 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgHDGmT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2020 02:42:19 -0400
Received: by mail-ej1-f67.google.com with SMTP id o23so13728708ejr.1;
        Mon, 03 Aug 2020 23:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=To/tKZ673YdcmGe7ISEnqDnAKsZbt6QyqhCKeqY+VQQ=;
        b=E9Xwa0hCd9OmeS3kH3s6UDNOXQOuo3zXI0u6grAGhGMZaKxKyPYQJKRjJD+i0JYYfy
         YWtPTMd0fsAnsAqhYZUrkY14S0/SWc3+e4FO+Nia5IjC3SWQmJt5HF1WLjcfwADIX5it
         lv7cLoYvL7p/ZQ5PndvoK0AH+SZaKWa3QMBEbHNsD/c+Yldjs3sPp3JCxiKC2DCzIaSp
         moQ+/o4FA4iuI1uIkf2Ezx4eYkhueKJZ8C1Ckyti3nMMH7MFLd5lKkWyBj3aT/wEcLpd
         2pELQW7YGUUNUQhusVJmtodNoGnxznf/GsUwNyoJUmQKgmvCnRITeC0atuHrU34erYcX
         ubxw==
X-Gm-Message-State: AOAM531j4Iee+mNndaoaVA0A3IA4kO8V7TfopcVOXOIP4gwMUT3f2JjT
        iHwegnxUQbjIc3eUyhMdCKss2V7nqi0=
X-Google-Smtp-Source: ABdhPJy//7W0MX3eI3cZyIQWn6WwzEAzB6TVyn8uEL/oeZHDKkza/pBJBDyVOfFfy1hJVbO5q0GLZw==
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr19954755ejh.59.1596523337256;
        Mon, 03 Aug 2020 23:42:17 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id sb3sm18150471ejb.113.2020.08.03.23.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 23:42:16 -0700 (PDT)
Date:   Tue, 4 Aug 2020 08:42:13 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: propagate error from
 exynos5_counters_get()
Message-ID: <20200804064213.GA10089@kozik-lap>
References: <CGME20200804061225eucas1p283c1e0dc404bc420a2184480fdfd2b0d@eucas1p2.samsung.com>
 <20200804061210.5415-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804061210.5415-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Aug 04, 2020 at 08:12:10AM +0200, Marek Szyprowski wrote:
> exynos5_counters_get() might fail with -EPROBE_DEFER if the driver for
> devfreq event counter is not yet probed. Propagate that error value to
> the caller to ensure that the exynos5422-dmc driver will be probed again
> when devfreq event contuner is available.
> 
> This fixes boot hang if both exynos5422-dmc and exynos-ppmu drivers are
> compiled as modules.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/memory/samsung/exynos5422-dmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, looks good. I'll apply it to fixes after merge window.

Best regards,
Krzysztof
