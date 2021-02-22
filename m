Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B938B3212D0
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 10:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBVJKu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 04:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbhBVJJp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 04:09:45 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE739C06178B
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 01:02:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t15so18128576wrx.13
        for <linux-pm@vger.kernel.org>; Mon, 22 Feb 2021 01:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jhgPHu6XXx4pz5/SSjHGKFmkDKfHLvhV3padIpoDdfM=;
        b=qxNPJcFvg4PQYwmX+2pVg3h8wMc6/86JQPaKUL4oVcekZH3GwbXNwxgLVgm7V/bBdv
         JYgi+e2YYKOObufhKEEV2xMxDd+opnLLegrC8kBw49XIQRXgwHWPDKjf7O9pj/OEjXE5
         FllPGCqQKkdJgU2yO3ePX9AKLSnm3SrywEwWtESO+1JSga3CkO9UrmOScpXaMZE8n5wc
         iSZLYR1rv/pAVz/BktMfMPKfOSTqdjT6KwL0DBQDSlCw7MAUENHOROL9Lq9Cv11lwaNF
         br8PNFQcBEadCzkkzj59HmRUUEypnaX1wyUMpKD/NFPY76Ra6Dfga8xhlPXTJEKIPcLg
         biDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jhgPHu6XXx4pz5/SSjHGKFmkDKfHLvhV3padIpoDdfM=;
        b=aHz0PUQL2Le78jWMSrL3EtZdoilCYhVlc0OLIqlLqyIVtbK/WZFluYJ0XLrA/r1X6y
         NvqritliAN4QML10/BDSilXWYSV07bN0k9M5oFTOYZANn80AVfrcy5xiFsKgzvvPwOld
         jYakz4qYQoszWHZa0kKWUzDzGmG7aYdtyhp5+pe9eOPdqi3CkbxkFevTQ/DJaV15I3Hl
         G7deBQjqdOCTcKSJEXsoaA9MdpqOGJPRN5B9VSOgi+lJNGYAOAC5qDzwiKEhi//RIEyz
         F1mr0+eGhMiGT1xTy83/wpSVpAiN6H8PP8NDDYMp9skMU2UUy8SLkaRKKMmItlL4HavN
         UyKw==
X-Gm-Message-State: AOAM533Dbu6J1+uZrxAeQS7aZeLl3VkmDUcmYzili/FHZef400IRFhoX
        Db1foDrxnfHa5G5XqfXRFJ2rVA==
X-Google-Smtp-Source: ABdhPJxcHVtrDO2B9l9pMLHeQey3LKL4O91gSbrRAVPpGKjkSlIN1ls8XZxVOfmnx7rSZmrajszbRA==
X-Received: by 2002:a05:6000:1819:: with SMTP id m25mr20698392wrh.342.1613984569427;
        Mon, 22 Feb 2021 01:02:49 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id j14sm16040896wrw.34.2021.02.22.01.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 01:02:48 -0800 (PST)
Date:   Mon, 22 Feb 2021 09:02:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
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
Message-ID: <20210222090247.GA376568@dell>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
 <20210221163602.GA297639@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210221163602.GA297639@BV030612LT>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, 21 Feb 2021, Cristian Ciocaltea wrote:

> Hi Lee,
> 
> I have just noticed your mfd-next tag for 5.12 doesn't include the
> support for the ATC260x PMICs.
> 
> I assumed the patchset is ready for merging.. Did I miss something?

The MFD driver needs another review.

For some reason, this didn't register on my TODO list.

In general, if you don't receive a review within ~2 weeks of posting
(and the merge window is not open), you should consider it lost and
submit a [RESEND].

> On Tue, Jan 26, 2021 at 11:55:56AM +0200, Cristian Ciocaltea wrote:
> > The ATC260x family of PMICs integrates Audio Codec, Power management,
> > Clock generation and GPIO controller blocks. There are currently 3
> > variants: ATC2603A, ATC2603C and ATC2609A.
> > 
> > This is re-spin of the v1 patch series submitted some time ago by
> > Mani, who provided the MFD and regulator drivers for ATC2609A:
> > https://lore.kernel.org/lkml/20190617155011.15376-1-manivannan.sadhasivam@linaro.org/
> > 
> > Since v2, I added support for ATC2603C, together with some new
> > functionalities for both chips: power controller and onkey input.
> > The ATC2603A chip type remains unsupported for the moment.
> > 
> > This has been tested on RoseapplePi, a SBC based on the Actions Semi S500
> > SoC, which integrates the ATC2603C variant of the PMIC.
> > 
> > Note that enabling the ATC260x PMICs on compatible Actions Semi Owl SoC
> > based boards depends on:
> > 
> > * the Actions Semi SIRQ driver (for PMIC DTS setup), merged in v5.10:
> >   https://lore.kernel.org/lkml/cover.1600114378.git.cristian.ciocaltea@gmail.com/
> > 
> > * the atomic transfers in Owl I2C driver (for power controller), merged in v5.11:
> >   https://lore.kernel.org/lkml/cover.1602190168.git.cristian.ciocaltea@gmail.com/

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
