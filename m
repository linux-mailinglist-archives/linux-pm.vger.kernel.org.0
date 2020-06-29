Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C820E5DD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jun 2020 00:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403943AbgF2Vm3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jun 2020 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbgF2Sh4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jun 2020 14:37:56 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76484C033C34;
        Mon, 29 Jun 2020 11:28:55 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so13734657edy.7;
        Mon, 29 Jun 2020 11:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v4RywOSBW8Kuw1+zf6DDYYL42xVE9deqCEslZIfGs/U=;
        b=C6ibjhrwQKECnH+TWlZ+vHl6UQ0YlQVFQgDkTF5WAigqjwQuOHweYLobU7pgwv3ByH
         Um/eGwTACbKXMsqK5u17DTWcn1e0WWtycNFg++9NrPlgArnLyFkAssMylAF0yqzpD6RI
         yxa9hNZBnXHjYebm+i8Zi9uPkeHFNJak2SD3SLGg5LZE4Rfp1Fo5o3Qux1XiDnUthe76
         wvmrd0tgylNpU6wSbCsOqy1sKIWnNfCLm+jknb+b4GLyQaiLwEcrmDeuF0Q0mxMgOVKL
         Z5AK+5Gr1SpkGqeM+UXhHwqSk9HOLZvfDuO3RdHVY9Y54BbFotVi7nqDoWeZm6uiS5HB
         /1wg==
X-Gm-Message-State: AOAM5308usOISsLKdAaLGv3AyXNvPZ/SD5BRyNNQ4uDauEPzXLZwiAu6
        hDOfdd5/CBUcmS+URv4BGFs=
X-Google-Smtp-Source: ABdhPJyzSgCljqhMYA8qL9G+ulHz7u8sTpeqpwRRupJqxrfMHwsH2mmBxQkKBgGt9N38HlNRmuf3sQ==
X-Received: by 2002:a05:6402:1c07:: with SMTP id ck7mr7331907edb.297.1593455333941;
        Mon, 29 Jun 2020 11:28:53 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id d13sm257118ejj.95.2020.06.29.11.28.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 11:28:53 -0700 (PDT)
Date:   Mon, 29 Jun 2020 20:28:51 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/4] ARM: exynos: MCPM: Restore big.LITTLE cpuidle
 support
Message-ID: <20200629182851.GA3848@kozik-lap>
References: <20200629091343.GA16015@kozik-lap>
 <CGME20200629100230eucas1p1bf07ca4c84ba6be1fbdd80c45d077518@eucas1p1.samsung.com>
 <20200629100218.6267-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629100218.6267-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 29, 2020 at 12:02:18PM +0200, Marek Szyprowski wrote:
> Call exynos_cpu_power_up(cpunr) unconditionally. This is needed by the
> big.LITTLE cpuidle driver and has no side-effects on other code paths.
> 
> The additional soft-reset call during little core power up has been added
> to properly boot all cores on the Exynos5422-based boards with secure
> firmware (like Odroid XU3/XU4 family). This however broke big.LITTLE
> CPUidle driver, which worked only on boards without secure firmware (like
> Peach-Pit/Pi Chromebooks). Apply the workaround only when board is
> running under secure firmware.
> 
> Fixes: 833b5794e330 ("ARM: EXYNOS: reset Little cores when cpu is up")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - adjusted patch subject to better describe the change
> - added a comment about exynos_cpu_power_up(cpunr) call
> ---
>  arch/arm/mach-exynos/mcpm-exynos.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Thanks, applied (but somehow your patch did not make it to the
linux-samsung-soc list).

Best regards,
Krzysztof

