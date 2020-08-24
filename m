Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE8F24F31E
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 09:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgHXHdh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 03:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgHXHdf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 03:33:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F7C061573
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 00:33:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h15so863317wrt.12
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2020 00:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9b6JStI+Pc7Gan44H9Zai7qTn63i//epl6t/+SyCbvI=;
        b=QtU30oREihjyaqVpYIPlh7uBHK/+lhu3kH4oL78qeud837ZI7zpawFKbrvXu6gEeF7
         lirP1Q5eX5PgM10QHCj806++kYW29bWS1XHPniLoLJmno35vPnyrxiKHV7p3aodMTbfn
         Y04755PuaOjBiEiyjPx6oxKlWUTs8W/nrEsTE3D3EiVIAnqck+zGCO2Kq8GPGxqS88WV
         f4gu+gKuQuMYYK3aNi2V+GEfSaNUiYjGZVV3Uw2wOTjSE1MiKI50ALupBV4fO60Qx61C
         dqwaeZn9bWLrQ8yqRwpZvWKQJqdQJBPxLU4x9pO0dXGyofFd0dRNrP7PqtDNr3k7hB5u
         E43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9b6JStI+Pc7Gan44H9Zai7qTn63i//epl6t/+SyCbvI=;
        b=ddzR1wxF4jnEufD4NZZXFrVMk9YmE9vR1SUzhscxl+e2VfUEcqnahkdob7laoY6dgI
         agGRb+jSLs+gjuUPsbZRJoyfzuRR0EXANJd9dVPZ+7Zzz3KCskss553wGjDyC5bgr0ho
         nnBBPbTQxwNeAcME1samdABHsV1b9kj+bqXFGVVKQr9db2DxVHIQLY3LKcTfnzNBZEVm
         Ww4/eY0K+RDO1990qFHr4EIoHalVOfcO5omXtpR13nJPwi+qtNwMKB3WQTXJFv+hKE73
         +dy0TtDfRxe3uUPiuioq92JaNX/M/mCf5yAZVS3mUettpoE/vj6q8KKTUWBuT6Z3uM7B
         RDqA==
X-Gm-Message-State: AOAM531E4Pqt/ilo8OCgh8zfG3WE3dsfm4Heqnl6tX0bjYD46Km2cLhE
        Zl7camDpSlZVTAMexIsOh4qmyw==
X-Google-Smtp-Source: ABdhPJyrXOh+fiqV7Y/t9Tokf2adkKintBDcUuhkhcJ9lId4930V3lXNU3Dgrt+bFOeg/VRmD57z0w==
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr4456180wrf.171.1598254413967;
        Mon, 24 Aug 2020 00:33:33 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id t14sm21197697wrv.14.2020.08.24.00.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 00:33:33 -0700 (PDT)
Date:   Mon, 24 Aug 2020 08:33:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] mfd: Add driver for Embedded Controller found on
 Acer Iconia Tab A500
Message-ID: <20200824073331.GG3248864@dell>
References: <20200823140846.19299-1-digetx@gmail.com>
 <20200823140846.19299-2-digetx@gmail.com>
 <20200823181653.GC209852@demiurge.local>
 <82abab10-9af6-a9c4-b241-d5a3af5b588d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82abab10-9af6-a9c4-b241-d5a3af5b588d@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 23 Aug 2020, Dmitry Osipenko wrote:

> 23.08.2020 21:16, Lubomir Rintel пишет:
> > Hello,
> ...
> >> +config MFD_ACER_A500_EC
> >> +	tristate "Embedded Controller driver for Acer Iconia Tab A500"
> >> +	depends on (I2C_TEGRA && ARCH_TEGRA_2x_SOC) || COMPILE_TEST
> > 
> > This seems to also depend on I2C and OF. Perhaps I2C_TEGRA and
> > ARCH_TEGRA_2x_SOC imply that, but it could lead to build failures with
> > COMPILE_TEST=y. 
> 
> Hello, Lubomir! You're right about the I2C because it could be compiled
> as a loadable module, good catch! The OF seems should fine as-is.
> 
> ...
> >> +static struct a500_ec *a500_ec_scratch;
> > 
> > If this is only used for power_off, please rename it. I've been told to
> > do so in my driver: https://lore.kernel.org/lkml/20200519104933.GX271301@dell/
> 
> I don't mind to rename the variable, but not sure whether it will be a
> worthwhile change since _scratch is also a common naming scheme among
> MFD drivers. Please see max77620_scratch for example, which I added
> about a year ago.

If something is used once, it does not make it 'common'.

Not sure how this slipped my notice before, but I don't like it.

Ensure any global struct used for power_off only includes items
required for this purpose.  It's unfortunate this API requires a
global variable at all.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
