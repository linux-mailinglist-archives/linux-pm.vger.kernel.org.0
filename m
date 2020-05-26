Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774021E1D4D
	for <lists+linux-pm@lfdr.de>; Tue, 26 May 2020 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgEZI1u (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 May 2020 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgEZI1t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2020 04:27:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC21C03E97E
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 01:27:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j198so4508725wmj.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2020 01:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cfMx3QPegcW07ui0zEuFM9OMjXtnMXJjCz03Y4QBbMI=;
        b=xgwwlZ/1mJxBPIFU8h/wk6la1tlt+HGj/xGHn7d9tdu6b3kNjT32rubdBqAyNjbJPT
         3X3wPGbpgVBB7qgdheTHXP+kyfKdRaIgpcV9IIFK1BH+GHyilXXzlZDguSzzhvobiP+a
         Vn8hjcqu3uW+1n3i2vh6BhuGj3PXl7xQjcUn6pqRS0qdeBbf17HoWN456lW769ZDJ/ql
         TKMCLcEf4pwBi3FvKpn+n7e7iNsWUSAw5Wj40WYIbmoOyF5xvzwfcrzXY8C7PSKBSH+P
         XdKVYYZ9HigzzyRDUuRVm9CZxKxDsoUcPpQvoxfBCWegSEFdUSwRasTloTWtRGFXxjaC
         nRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cfMx3QPegcW07ui0zEuFM9OMjXtnMXJjCz03Y4QBbMI=;
        b=LLH3xhVqbJZ3lVrn5T9xSk9USlhqvw3I76fL8dJ6Ixli1dmZT4pA7eWsHIJ1yvLplg
         56CerIYFOBwSn4QgIcCLMt2rXb7pL7HWecAuOIcrMvRGph/SKqmhIEZ8r/PpcFjYHowm
         tII+8DDV6xzT30dA1DSH9TqfE8I6AdERYYAERzxihcTc6q97V4WAeuPco6WPSp0SuQWd
         SMVRInufVaopsgOa7fYD5JBoRP6u5l3Ck2P7Mo4ePCemz1R/QBQN8Coh314x3Qld60Du
         +VRP215HsLQyeWdShVoPIbNZxeBht3mWqwfEYCp2ImZQYObfBBk5+JBYqritvIS78inl
         ab3w==
X-Gm-Message-State: AOAM531bGyb2+qdRSwBHv9XmPoTg5uZLrLYtGoHjrqNJHrJ9Ag6RXkRc
        5slSZoHCnUbV6vY63paIMqGa5w==
X-Google-Smtp-Source: ABdhPJwivVEa7Wbrfc8XZwwaPB5guQr4hvCUswwOuC6U80Y/wBCxFVwaG5kew77mdKPQT0wWtp3qiA==
X-Received: by 2002:a1c:5a82:: with SMTP id o124mr288626wmb.188.1590481666849;
        Tue, 26 May 2020 01:27:46 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id p65sm20347925wmp.36.2020.05.26.01.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 01:27:46 -0700 (PDT)
Date:   Tue, 26 May 2020 09:27:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     saravanan sekar <sravanhome@gmail.com>
Cc:     andy.shevchenko@gmail.com, robh+dt@kernel.org, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v11 2/6] mfd: mp2629: Add support for mps battery charger
Message-ID: <20200526082744.GJ3628@dell>
References: <20200430155810.21383-1-sravanhome@gmail.com>
 <20200430155810.21383-3-sravanhome@gmail.com>
 <20200519103741.GW271301@dell>
 <75b6a2ee-2d90-17c2-4b2b-0ef6238e903e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75b6a2ee-2d90-17c2-4b2b-0ef6238e903e@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, 23 May 2020, saravanan sekar wrote:

> Hi Lee,
> 
> On 19/05/20 12:37 pm, Lee Jones wrote:
> > On Thu, 30 Apr 2020, Saravanan Sekar wrote:
> > 
> > > mp2629 is a highly-integrated switching-mode battery charge management
> > > device for single-cell Li-ion or Li-polymer battery.
> > > 
> > > Add MFD core enables chip access for ADC driver for battery readings,
> > > and a power supply battery-charger driver
> > > 
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >   drivers/mfd/Kconfig        |  9 +++++
> > >   drivers/mfd/Makefile       |  2 +
> > >   drivers/mfd/mp2629.c       | 79 ++++++++++++++++++++++++++++++++++++++
> > >   include/linux/mfd/mp2629.h | 17 ++++++++
> > >   4 files changed, 107 insertions(+)
> > >   create mode 100644 drivers/mfd/mp2629.c
> > >   create mode 100644 include/linux/mfd/mp2629.h
> > For my own reference (apply this as-is to your sign-off block):
> > 
> >    Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > 
> Do I have to resend with above sign-off in all the patch?

That would make things simpler, yes.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
