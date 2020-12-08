Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B352D30C5
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 18:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730695AbgLHROx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 12:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgLHROx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 12:14:53 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335EAC061793
        for <linux-pm@vger.kernel.org>; Tue,  8 Dec 2020 09:14:13 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id v85so9564709oia.6
        for <linux-pm@vger.kernel.org>; Tue, 08 Dec 2020 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OrTk1JTf0Tk8H0Dkw70rR48Y70ZzNOZd9pRYyN3l7qc=;
        b=tIQ2524GlK0nHCX0ZYY0xdFCCrAMuJvFo2H0VIs9BGVY4NsN35gc+MsKDaPkEq1dN6
         lYhMbk+hQ0saLb8M6/C5CMmksatLa1RBH1jo471y79kwSJ4rLffV4IS8Pagtp06Cbunu
         H8NRsJxFvr0mRaGl1iXvuBE+5dlYOVyU0EbNbdeBI9LJ5MzVCozNUqoTCm4o4rQkoDjo
         bLonRVugPYPsPdq1yb0HnL3MXaTy47jnb71Q/OuiX78f9Ab0ReLpPtDp8JUn9BngD7Qs
         ZEsfkjH37qA+CftGSdOllMWOlKBDqe9i8QsKzeg5kR2eQq0R8ciOQkp0xGWgTCoYlA/B
         NFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OrTk1JTf0Tk8H0Dkw70rR48Y70ZzNOZd9pRYyN3l7qc=;
        b=ZR0HRxE4ZJ8hjj8KxIwD7k/YV6Ih5h3R2Lt9vZ05wGxQpMlq+AOYKJ39VxTJ3mWruA
         0juHbtxcRCqHqGBZIwn+lS5P2+qzijDefVNaIChCbqdhYr8WVlZ8bKoKSRxJANpgFIzm
         YnRgerTvmRJGVpbAqlsk/qEvIQbJ9Qvscu4dUyAtFjeDyWtgdY6AK99lZAGUxbofqAb9
         YXobv+jDsjobkjnyIPa9QiGnM/hyeuls6VDX9DXDmqVP5eOIAoTtWBWUNON70ACN4+yP
         wVXSZzC163j5Sy8ek4LSNuyn555G2E/LrHC5eSmEUNJRYJf8bK85FHGumFiUgooctXbE
         pxOA==
X-Gm-Message-State: AOAM5313zmsKM7iDQnlQ/YWTk2S/OoHHUF9ZkQC/OKkG/1Mzrphl53JM
        5AgxY/c8sv3baG0cPpEjLkDC/H1GgfdJSK3BduGgRA==
X-Google-Smtp-Source: ABdhPJyTkuAAJ9aQVeM1oHOof95mLBcg/6CIM2sK7D91vZhxK+467RxQ2PT2rU6DtPBiIt1uiUZ+osvJh/KOHqtISAo=
X-Received: by 2002:aca:b605:: with SMTP id g5mr3525309oif.177.1607447652630;
 Tue, 08 Dec 2020 09:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20201204025509.1075506-1-dmitry.baryshkov@linaro.org>
 <20201205170830.4d56ecb7@archlinux> <4de94396-54c7-e741-b288-3a3868515f7b@linaro.org>
 <20201208103951.00003b3a@Huawei.com>
In-Reply-To: <20201208103951.00003b3a@Huawei.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 8 Dec 2020 20:14:01 +0300
Message-ID: <CAA8EJprS_Oa08xsGepeowqmrpmRH8pOYRd9yX2KEqZRsnetkzw@mail.gmail.com>
Subject: Re: [PATCH v10 00/15] qcom: pm8150: add support for thermal monitoring
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 8 Dec 2020 at 13:40, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 6 Dec 2020 00:05:29 +0300
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
>
> > On 05/12/2020 20:08, Jonathan Cameron wrote:
> > > On Fri,  4 Dec 2020 05:54:54 +0300
> > > Dmitry Baryshkov <dmitry.baryshkov@linaro.org> wrote:
> > >
> > >> This patch serie adds support for thermal monitoring block on Qualcomm's
> > >> PMIC5 chips. PM8150{,b,l} and sm8250-mtp board device trees are extended
> > >> to support thermal zones provided by this thermal monitoring block.
> > >> Unlike the rest of PMIC thermal senses, these thermal zones describe
> > >> particular thermistors, which differ between from board to board.
> > >
> > > I've just taken another look through the various IIO parts in here and
> > > I think they are fine.
> > >
> > > My assumption is that given the timing this isn't going to make the merge
> > > window now.  Hence I'll be looking to do an immutable branch based on rc1
> > > once it's available (assuming everyone else is fine with this version).
> >
> > Thank you! Another option might be to merge all iio changes this cycle
> > (if it's fine with you) and have all the rest go via respective trees in
> > the next merge window. I'm fine with either of the options.
>
> Too late unfortunately. IIO routes through staging for historical reasons
> (plus we still have about 15 drivers to move out of there - it's only been
> about 10 years :)  Staging closes a week before merge window so IIO closes a few
> days before staging.
>
> So lets stick to the immutable branch method.  Tends to make more sense in
> the git history anyway as brings relevant code together (even if it travels
> via multiple routes :)

Thank you for the explanation, the immutable branch approach works for me.

-- 
With best wishes
Dmitry
