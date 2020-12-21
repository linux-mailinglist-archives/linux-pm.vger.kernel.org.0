Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618652DFBC5
	for <lists+linux-pm@lfdr.de>; Mon, 21 Dec 2020 13:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgLUMSz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Dec 2020 07:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgLUMSy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2020 07:18:54 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F0FC0613D6
        for <linux-pm@vger.kernel.org>; Mon, 21 Dec 2020 04:18:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o17so23185482lfg.4
        for <linux-pm@vger.kernel.org>; Mon, 21 Dec 2020 04:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M8GIUvdJake4G0GbpUdw/v3KT65N1Elydx4DG8uLLNg=;
        b=V3ZMo0kMWdDIcf3Iv2YamlGAnGCuRo3sVmr7FZHRBuGjiktTMjkUwo7zFejIH7snuV
         QpnD9Sl4gm533GK7LJT6Lb3mrbkZokjzFxZ9py3RPoYyYSeR7Eqe+KUATwtkznF2dj/U
         qL87l2ukiiYLc1G5dXbDn7egjWw4QLUK1FYTPZys8Rm1XGEaNV46BUI/eY1P29S1KPsr
         LSL5MGZw1fsIPkiM3ge6vFElLb7pDaa7tYAg9KPV+qM0mFRgacyM6z2YpYv4lPRBcwdX
         om7NELMGAXed+sT2CpRKRXrUmI0m6uXQsdgdg/RLLRSyJ/L2gYVfkgnfV69S/doZL73z
         dWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M8GIUvdJake4G0GbpUdw/v3KT65N1Elydx4DG8uLLNg=;
        b=lHKUVY7vP8aoL9FFYnaWu3FuElYzUtish4QjICSPO0swMS0lWRPmppxvOdc4vlwCMe
         /TiNtb0OySkW1Tk/YLHI69Nfj+HnYC2pFWRNm/w48cY3NGeJgiIbNCWfbA9VgP3rTf3v
         jpakP9BcQM9/AkkvBTVpMuWkLAg6houlYAwM2+Msu0oMd51BhtfwPEI4bgxCurrz+NyU
         0HN2jtVzZ5/2VKRwkFntnTa56nOuR9ljvX/2SW9fjlh5J1XMssLDX+GWWZcxYR0mh0Ma
         36fhJ5Oc9ssecgtrCMDAUBNg7kxDaasD2cJtSi2mMAEv3Dd0XxtCbtP7K/VNNfZAFrkH
         6bOg==
X-Gm-Message-State: AOAM533grtmKGdjttg5YM6HsrZHMWS6mxhULrstIS189ZyiFWjoviBkY
        lyUAY3NMbURzV0mhACMTMCawc866fcDJZ/cw3wfAGQ==
X-Google-Smtp-Source: ABdhPJwXr8Ac1/MblhevY4EuqX5/WUbMyfBZcQPEfvIJ4Y7jJa8HNHbpGR5pVhHUzmNVnt6LztIOkFhlusozSAe2Dg8=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr6964671ljl.467.1608553092185;
 Mon, 21 Dec 2020 04:18:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1607216141.git.cristian.ciocaltea@gmail.com>
 <f538c21de556c66390614bad778f7dc095222e8c.1607216141.git.cristian.ciocaltea@gmail.com>
 <20201216101000.GD207743@dell> <20201217231731.GA104305@BV030612LT>
 <20201218132139.GR207743@dell> <20201218160710.GA134686@BV030612LT>
 <20201221081015.GA4825@dell> <20201221115713.GA155203@BV030612LT>
In-Reply-To: <20201221115713.GA155203@BV030612LT>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Dec 2020 13:18:01 +0100
Message-ID: <CACRpkdau=KfOeP5gM2bfLaAEa4U_GrCA=kNR0P6H5_Eov6B25g@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mfd: Add MFD driver for ATC260x PMICs
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-actions@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 21, 2020 at 12:59 PM Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:

> enum atc260x_ver {
>         ATC260X_A = 0,
>         ATC260X_B,
>         ATC260X_C,
>         ATC260X_D,
>         ATC260X_E,
>         ATC260X_F,
>         ATC260X_G,
>         ATC260X_H,
> };

This makes it look like the driver is actually so generic that it makes space
for all revisions back to ATC2603A which is in the Ainol Hero 10 tablet.

This is nice because there are millions of these devices (especially in
China) that people want to get to run the latest Linux.

I even wonder how much different the ATM7029 is from S500, I suspect
not super much apart from the ARM cores.

Good work overall! I'll be happy to deal with the GPIO
driver when you get there.

Yours,
Linus Walleij
