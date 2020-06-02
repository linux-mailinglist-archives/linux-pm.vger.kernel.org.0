Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1431EB777
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 10:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgFBIdP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 04:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBIdP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 04:33:15 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FE9C05BD43
        for <linux-pm@vger.kernel.org>; Tue,  2 Jun 2020 01:33:14 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so2454767wrt.5
        for <linux-pm@vger.kernel.org>; Tue, 02 Jun 2020 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7H1jGmdpunK0UnpTr7PELYFOau+0SDjGmyZeNU7l2WE=;
        b=XQyBLPtBdqQOAVQxORH0WMvK8c7jAnhw7HnsfvKWm85fSsgd/SsCqwiw9n6xZK+tx7
         o4DSQYLwZ8YCxHV59VL9JjH6M+O3AxueEkFGjlwYAFqJBp94Ku6Xi5hzbK3h4Kvg3KPr
         MmCxgREKkngV8Cbbpe9+M72opU6j6OfcflSXcUpmqvZ8xID5/B0ZJhS6IEQ9WjCnssXp
         uu64wX9kvwJNZZZQRSfvB8CLAcHOLvZp2Wt8kl3O5jRh/XVkRlALE52jOU+9PWRmChZN
         +VO3kn5jOnZj+mPkhBYJdJS9o2NKd95hosuB3A12H2sKIwDr4qua1Hy+LFxlDu68FxU2
         Tv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7H1jGmdpunK0UnpTr7PELYFOau+0SDjGmyZeNU7l2WE=;
        b=T4Jk5/YQQE8jLv6niLNg/rVmfTM4oHZicydixTbNL+f7HVBYfg9046SLo53KTorCur
         i2qRHoTdk6/qROEeiAckGZHuvUOCsxJeRue9KIfroewfyU+k30eVZP5NkWH7Of7PGfBT
         theysyqivzREle4zb7bUXHbyWKhIXihGVQPww4a6pX0J8jX3wE4QJGn9Aqqy+E6GxZhf
         Tw6h8NHyZ+4r3Nc9ISP26zidnSbzKsyUUmWkQ52SSX1pkanqAWdQGjpVWgpMdMFXo46a
         hyIO7DAx7/Y332zi+ioCXmY26Aw2uj4vSAqqsQG2AZfi5xvzSGBtsMqQn/+0jvWncLZP
         dMtQ==
X-Gm-Message-State: AOAM532sjBb/opVfiySrgUNekwmwTuqOzNQqaVZmNTR9Sehw1byL0BJQ
        GCxfgNM70mFlSf4qLV5c7IGr7w==
X-Google-Smtp-Source: ABdhPJwTWstLJV8DOsVmKsrBfUkOLHr+Ifb0u8UVqxHHLBh22pbnHCSAkqvAWuYTZbyxJQ25mTIjDQ==
X-Received: by 2002:adf:a4dd:: with SMTP id h29mr27110163wrb.372.1591086793255;
        Tue, 02 Jun 2020 01:33:13 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id h7sm2489681wml.24.2020.06.02.01.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 01:33:12 -0700 (PDT)
Date:   Tue, 2 Jun 2020 09:33:11 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] mfd: add support for the Khadas System control
 Microcontroller
Message-ID: <20200602083311.GD3714@dell>
References: <20200512132613.31507-1-narmstrong@baylibre.com>
 <20200512132613.31507-3-narmstrong@baylibre.com>
 <20200520090101.GE271301@dell>
 <8837fa43-bf46-fdd1-472e-e5f0159dab2c@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8837fa43-bf46-fdd1-472e-e5f0159dab2c@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 02 Jun 2020, Neil Armstrong wrote:

> On 20/05/2020 11:01, Lee Jones wrote:
> > On Tue, 12 May 2020, Neil Armstrong wrote:
> > 
> >> This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
> >> boards.
> >>
> >> It has multiple boot control features like password check, power-on
> >> options, power-off control and system FAN control on recent boards.
> >>
> >> This implements a very basic MFD driver with the fan control and User
> >> NVMEM cells.
> >>
> >> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> >> ---
> >>  drivers/mfd/Kconfig            |  14 ++++
> >>  drivers/mfd/Makefile           |   1 +
> >>  drivers/mfd/khadas-mcu.c       | 143 +++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/khadas-mcu.h |  91 +++++++++++++++++++++
> >>  4 files changed, 249 insertions(+)
> >>  create mode 100644 drivers/mfd/khadas-mcu.c
> >>  create mode 100644 include/linux/mfd/khadas-mcu.h
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> >> index 0a59249198d3..b95091397052 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -2003,6 +2003,20 @@ config MFD_WCD934X
> >>  	  This driver provides common support WCD934x audio codec and its
> >>  	  associated Pin Controller, Soundwire Controller and Audio codec.
> >>  
> >> +config MFD_KHADAS_MCU
> >> +	tristate "Support for Khadas System control Microcontroller"
> >> +	depends on I2C
> >> +	depends on OF || COMPILE_TEST
> >> +	select MFD_CORE
> >> +	select REGMAP_I2C
> >> +	help
> >> +	  Support for the Khadas System control Microcontroller interface present
> >> +	  on their VIM and Edge boards.
> >> +
> >> +	  This driver provides common support for accessing the device,
> >> +	  additional drivers must be enabled in order to use the functionality
> >> +	  of the device.
> > 
> > It would be good to describe the device here.
> 
> Ok

If you agree with all review comments, there really is no need to
reply.  It's a waste of your time and anyone else who cares enough to
search through looking for replies (as I just did).

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
