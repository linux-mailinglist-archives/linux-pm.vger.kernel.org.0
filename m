Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32EB321B3A
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhBVPT1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 10:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbhBVPRh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 10:17:37 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22C1C061574;
        Mon, 22 Feb 2021 07:16:53 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id do6so30006928ejc.3;
        Mon, 22 Feb 2021 07:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PoQSYFANfOPFU5GodfZmEo7JPP2yrXBzt4aU3VXzdpU=;
        b=kIfu1UvIJqOudlyGF3iYICcjYDD4CmisDvu5l0F4CD/e8LE6z2AplcK+gJyInecLqy
         DMyL++GG2znBHVWRVik/GJ6YSe067MgbxLDYagblFVkfdutMvcXhsiApn91EZyL7MeLP
         s03AEfqInVC4uBjXWe/kX52G7ZnaF6JAvtE4PqPLzTD/ReYxpwXG+hwyeM08QhCuQfpd
         GWoRwc3catyXEhBuBT/Oa0Z21q4FnINJXQmU1E1cuYO8MqL/S36utJtTe37qz+dALRmV
         Og9mcscmFuGstvdLXzQqKWT4PYeQOMTmLiz0zzFs8pPyM98Or2txH6IQUQtMqDSBZVcO
         E2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PoQSYFANfOPFU5GodfZmEo7JPP2yrXBzt4aU3VXzdpU=;
        b=FwEcceD5F0XR0c1OPNGCpNhP/BMcgG7oHUqC3p4Aktj5NGRSt5/UJ2w23iaMbzFeSU
         j7NmVeoFzdBJKdixDBE102mlfI8rV8YXVCipTAuQNvyroiMeM5hrgcFVyYxRfEOo9+ag
         jtkiWm2VJlSjYVydrgm3Af3j8uhxmfPdeZs2TUTX3Ek1n634YA39D4FS3VLZ85DZZOQw
         Bvqtuejmzwt9/ZYNT/5kMwp05b5iBGUMhWpPpnfuOBwTpaXAhMtddiOyZcX7fxAYXWhV
         wETEJwi44N/AIkqZlZCNBin10CyE75blPEjS2MV2OfDP+zdHcLewptEVsA0VEoiLotny
         z7Rg==
X-Gm-Message-State: AOAM531GURjhMSy0bI3ULOH0/Mfc1bbP4aVmH2B0YzuI0wFl/7c7iKfD
        cTbo4x9FOPSUqSgIDt0YIQ8=
X-Google-Smtp-Source: ABdhPJxaJlBn63aBGyrd0pKcMfEsaSi7ofRo+YzJMDjM9YUNAonkSkM0ke9zbWYmmvClRXKP0zUggQ==
X-Received: by 2002:a17:906:98ca:: with SMTP id zd10mr9456720ejb.536.1614007012653;
        Mon, 22 Feb 2021 07:16:52 -0800 (PST)
Received: from BV030612LT ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id ke26sm8634981ejc.69.2021.02.22.07.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:16:51 -0800 (PST)
Date:   Mon, 22 Feb 2021 17:16:49 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/5] Add initial support for ATC260x PMICs
Message-ID: <20210222151649.GA467803@BV030612LT>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
 <20210221163602.GA297639@BV030612LT>
 <20210222090247.GA376568@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222090247.GA376568@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 22, 2021 at 09:02:47AM +0000, Lee Jones wrote:
> On Sun, 21 Feb 2021, Cristian Ciocaltea wrote:
> 
> > Hi Lee,
> > 
> > I have just noticed your mfd-next tag for 5.12 doesn't include the
> > support for the ATC260x PMICs.
> > 
> > I assumed the patchset is ready for merging.. Did I miss something?
> 
> The MFD driver needs another review.
> 
> For some reason, this didn't register on my TODO list.

You have already tagged v6 with 'Acked-for-MFD-by: Lee Jones
<lee.jones@linaro.org>':
https://lore.kernel.org/lkml/20210125142558.GA4903@dell/

I have submitted v7 to drop the patches that had been already picked up,
as previously agreed, but otherwise there are no other changes.

That is why I didn't expect another round of review..

> In general, if you don't receive a review within ~2 weeks of posting
> (and the merge window is not open), you should consider it lost and
> submit a [RESEND].

Thanks,
Cristi

[...]

> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
