Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1422DFF47
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgLUSGc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 13:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgLUSGc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 13:06:32 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C8DC061257;
        Mon, 21 Dec 2020 10:05:51 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cw27so10466750edb.5;
        Mon, 21 Dec 2020 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSZkKhzHB5oPtFD1NoCpx7ZpbuV2rtwGLaArd+W21OE=;
        b=KgWFZbOA5nKSEpIRubD6StP/F8CNCij5ocd00gmgwW+G9bAJ1qs+p2/dxPVqm4sATg
         pPiOLUwwuJstWn83a5BC868iedfKFcwa/wWRjtBwVWM1Gmr2Fp4Hm4LxhTj8FjNWCaaG
         Hqa+ZSyYumIJSai/arw1XTPrn0DZH3zh2yI9Tp+EL9ay3pd7AYxbsJvNlDl72nJ2GZ9T
         KaZBq8i17fBChj9HjwUt9Ub4y68+MzA/Xzex4833u+mpiv7eic5w5+dFf5Rxkg1lMbM1
         V+7AaAq2sReymtp6f/xUYhIPnlj9JeTmTv+WTOivWwRNANplNaKZl91Gyci7dP/2XIFu
         2iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSZkKhzHB5oPtFD1NoCpx7ZpbuV2rtwGLaArd+W21OE=;
        b=CJgsZFv2ElSg/LvY9oz/OLzAIrVrUg3NHZDc6TZZpNEKMC5HtQyd/dzHcJKXtVMPed
         n6J8X4dSZvNldb5aRQLmdhYRPPJAPkuY69gNqBi6k7AHH+LsVgjXgirTYZPzS6UOa5SE
         9KbQy7tMbj3YYltPG4ybIEyJzICyKpb6865JbPbuv8X8900VWFfcS+9asHESQV7NVulz
         p0IZ69G3NvB0jmh2p9jGAYKxxHKYf2z6GbE+8R7QBFAzkyw07y009qzNCgyl6VPhR7Rz
         buowCDd3PezhgZ8ejq5GzW2yWsBNKLsqW/QKWuYRW5OIYeoE+NNkOqSvbnFb2fP/KJiv
         mMjg==
X-Gm-Message-State: AOAM530uQc88G80zGoqXpEF7UWu6QuqKw/bJ8tcETuT6bIQAFn/O4E+G
        16jIDU4P/4blSTpKD8hkk/pAG4sMdpawbA==
X-Google-Smtp-Source: ABdhPJxf5vVBTWWi7cEcw7L3Kc2Hb4EKU2dkSDia/lfY40NMg+a4f90T47QjR7OSO5yeL2odwgRidg==
X-Received: by 2002:aa7:d354:: with SMTP id m20mr15737547edr.195.1608558248769;
        Mon, 21 Dec 2020 05:44:08 -0800 (PST)
Received: from ubuntu2004 ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id f11sm29405290edy.59.2020.12.21.05.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 05:44:07 -0800 (PST)
Date:   Mon, 21 Dec 2020 15:44:13 +0200
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 3/7] mfd: Add MFD driver for ATC260x PMICs
Message-ID: <20201221134413.GA678185@ubuntu2004>
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <f538c21de556c66390614bad778f7dc095222e8c.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201216101000.GD207743@dell>
 <20201217231731.GA104305@BV030612LT>
 <20201218132139.GR207743@dell>
 <20201218160710.GA134686@BV030612LT>
 <20201221081015.GA4825@dell>
 <20201221115713.GA155203@BV030612LT>
 <CACRpkdau=KfOeP5gM2bfLaAEa4U_GrCA=kNR0P6H5_Eov6B25g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdau=KfOeP5gM2bfLaAEa4U_GrCA=kNR0P6H5_Eov6B25g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 01:18:01PM +0100, Linus Walleij wrote:
> On Mon, Dec 21, 2020 at 12:59 PM Cristian Ciocaltea
> <cristian.ciocaltea@gmail.com> wrote:
> 
> > enum atc260x_ver {
> >         ATC260X_A = 0,
> >         ATC260X_B,
> >         ATC260X_C,
> >         ATC260X_D,
> >         ATC260X_E,
> >         ATC260X_F,
> >         ATC260X_G,
> >         ATC260X_H,
> > };
> 
> This makes it look like the driver is actually so generic that it makes space
> for all revisions back to ATC2603A which is in the Ainol Hero 10 tablet.

For ATC2603A we need an SPI driver, currently only the I2C interface is
supported.

> This is nice because there are millions of these devices (especially in
> China) that people want to get to run the latest Linux.
> 
> I even wonder how much different the ATM7029 is from S500, I suspect
> not super much apart from the ARM cores.

Cannot tell, for the moment I can only "play" with the S500..

> Good work overall! I'll be happy to deal with the GPIO
> driver when you get there.

Great, thanks!

> Yours,
> Linus Walleij
