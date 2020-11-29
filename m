Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 303DD2C79FD
	for <lists+linux-pm@lfdr.de>; Sun, 29 Nov 2020 17:30:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgK2Q3b (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 29 Nov 2020 11:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2Q3a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 29 Nov 2020 11:29:30 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFC3C0613CF;
        Sun, 29 Nov 2020 08:28:50 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v14so7724579wml.1;
        Sun, 29 Nov 2020 08:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TltC2PWtsn2vLklBGm2EarhUufc2HeBfxICO+b5w0hE=;
        b=syxCMDtpjFxQe9C8gESgHY+NEuimyGDPhqsEJ9BtEpQL6venr72AQDbb8egNFH22O1
         1aMSX7iZNBR67pMrgaKcePMhJ421U9pbRLIHJ6snTZTdhiKiXgDVFm/FZbivb+6Vg2+9
         aGfgs+zU5VLmX7vINq1Pb9nwrN8lA4tSo6Xt2NBE4HVbp+okpN7s0Xn/BvEOEk5FR+nq
         E6VVyOorMZ4oTFyRobY+tqsNLvwakjYTmDIXnqrbxrqRn2W3D2CF/uROA12hWiQlpZzv
         ORj+XDD5ptSRbYR3L5uAJB1f+/aIgfTvi8Kry4C1tDV0Zs3hUsu/NN+71SxQEO23Ff2Z
         0uGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TltC2PWtsn2vLklBGm2EarhUufc2HeBfxICO+b5w0hE=;
        b=Qi22JqX40ngFC0zouB5HwNouApi8RsBQqNQiaImz1MfOzDIGz8s1KwH6Bb7uZwSsQz
         EmWJroTYJLdzVtdVpIMsUrkDsFrTUyqzlGiFe4mVHEsq2P6MwYb3CC7BtbjXEITtC+bV
         xZYpbMRIa27Ohru3Dtqj9i0JFpX1YflTcioqBBsJHHfpMC8VgcCO6If+9tXieTQeavs5
         JWGVgQ6xH3MNib4rZ2J7xJsFa9hNcV/1U33zg/LMUCOOcnxPb/WgqgBklIgp5UpLaB5x
         qWdkUQmTikq84dc6anUGRGunfd/ecxwNMym8ToQpiHmlZeliMbUbG9Thae+L87GJRJjJ
         MGsA==
X-Gm-Message-State: AOAM531qLy8RB9o8xcKtulkF9F+A86H6vhD51VJ0RRCL33Tj3jREOjBz
        5rLxME+4UVHlnUjJqNaCx/M=
X-Google-Smtp-Source: ABdhPJyzGEHUzHmTeg3bViEWVcWLy5cWDNOx94VFuf6TUL03gPSEK4YitJDZgwj5/l9OPlU/WU0kBw==
X-Received: by 2002:a05:600c:286:: with SMTP id 6mr18874664wmk.125.1606667328742;
        Sun, 29 Nov 2020 08:28:48 -0800 (PST)
Received: from ansuel-xps20.localdomain (host-82-53-191-46.retail.telecomitalia.it. [82.53.191.46])
        by smtp.gmail.com with ESMTPSA id f17sm20197686wmh.10.2020.11.29.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 08:28:47 -0800 (PST)
Date:   Sun, 29 Nov 2020 17:28:46 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Amit Kucheria <amitk@kernel.org>
Cc:     Amit Kucheria <amit.kucheria@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v6 2/8] drivers: thermal: tsens: Add VER_0 tsens
 version
Message-ID: <X8PMPnx+RmjyZyrJ@ansuel-xps20.localdomain>
References: <20200814134123.14566-1-ansuelsmth@gmail.com>
 <20200814134123.14566-3-ansuelsmth@gmail.com>
 <CAHLCerMArOceCFQ1XFbsZCAnUdKVX3TVnAb502w+kxmO97bdJg@mail.gmail.com>
 <20201125122228.GB23592@ansuel-xps20.localdomain>
 <CAHLCerNTNpEGiGT6Veroeh1b8pOCiYYFhpnj5YqZcFZxAXGB-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHLCerNTNpEGiGT6Veroeh1b8pOCiYYFhpnj5YqZcFZxAXGB-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Nov 29, 2020 at 06:28:01PM +0530, Amit Kucheria wrote:
> On Thu, Nov 26, 2020 at 2:16 AM Ansuel Smith <ansuelsmth@gmail.com> wrote:
> 
> > > >  };
> > > > @@ -441,6 +442,10 @@ enum regfield_ids {
> > > >         CRIT_THRESH_14,
> > > >         CRIT_THRESH_15,
> > > >
> > > > +       /* VER_0 MIN MAX THRESH */
> > > > +       MIN_THRESH_0,
> > > > +       MAX_THRESH_0,
> > > > +
> > >
> > > Consider reusing LOW_THRESH_0 and UP_THRESH_0 for these?
> > >
> >
> > As we already have defined LOW_THRESH and UP how can we reuse that
> > regfield to define MIN and MAX?
> >
> 
> We are using MIN and MAX THRESH on the apq8064 to mean LOW and UP
> THRESOLD, isn't it? IIUC, It was just named differently earlier.
> 
> When the driver is loaded on the apq8064, only that one field will be
> use since v0 has a single threshold for all sensors. When the driver
> is loaded on new IPs, all fields will be used.

Let's sum up things and take a decision about this. On V_0 the original
driver have a special implementation that has a 4 trips point, one
critical high (that should be MAX_THRESH), one critical low (that should
be MIN_THRESH), one configurabile hi and one configurable low.

This is the regfiled
[LOW_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR,  0,  7),
[UP_THRESH_0]    = REG_FIELD(THRESHOLD_ADDR,  8, 15),
[MIN_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR, 16, 23),
[MAX_THRESH_0]   = REG_FIELD(THRESHOLD_ADDR, 24, 31),
and we have the regfiled to check if the threshold is violated.

Looking at the set trips code, since V_0 doesn't have critical
interrupt, we only set the uplow interrupt. Now the current code only
check the LOW and UP regfield and V_0. The original code also check MIN
and MAX (that are set to 125 C and 0 C, that should be the critical trip
point). Should we:
1. drop the MIN and MAX THRESH and keep them unconfigured (and make the
interrupt set only to the UP/LOW trips) or
2. add the missing code to set_trips

Honestrly I'm more with the first approach. I also sent v7 that should
address all the other request. As always thanks for the attention.

