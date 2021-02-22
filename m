Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD2B321C6E
	for <lists+linux-pm@lfdr.de>; Mon, 22 Feb 2021 17:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhBVQJd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Feb 2021 11:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhBVQJH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Feb 2021 11:09:07 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A57C061786;
        Mon, 22 Feb 2021 08:08:26 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id k13so28424367ejs.10;
        Mon, 22 Feb 2021 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0z5cjnVMmZpnS0NGUFOXf9bMFTwoQWI9l7ipg+bgkgo=;
        b=NMOvhhBuOhD9Q8b92ppeUwTc1/xb80CfMGlpP4xgYlYyveKH/ArONfN4r2QUXyAn6a
         q4eNq/EE5ZarY1JwMBcOSN8cxc1ywkOIryPO+Gv5C4lP3Wj04NUqQkIJG/9kZRzFMZUb
         31F7eRWSVg/GQzfa1oRDAckMIknVTqgOoFLZVfnQzCr2ZRmbhMtdAD0QN0B7/vTVisZG
         VGPCtDO0cY0+lpaEopNmWQgdsnbsMAH1r6taPxlh+HoWlhDkMlnSlWXXHwVhvqHTVFvi
         KrIwKQdNa7rVsKmCkfY10HvJDGqOExuo67HGLv829J1F9FdUEXfyyWny1bsfkYg61VK2
         LxSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0z5cjnVMmZpnS0NGUFOXf9bMFTwoQWI9l7ipg+bgkgo=;
        b=hX+GLwn5/B/qvPkODlGfWnGTPS++rXJPsJJuqzvXtlTbexAstJAmGiEWCidUhi7/ko
         gHRErneHq3UsYX9zO0N32VyL2uGklct1gFYeSMATHFNan3RdP0mjqYBtnVb9zcZrd8zU
         ILMBOafsul0A7RRnc3nUe7XemWo4MPlMkbM5kKd41M5UDB2yL3RurhCxRhUnh5xMFYAZ
         FArrcExf1qnrskNV4D2iD5zkc9CQsgj/cV9RpooBO5wRAslZq5KLBHs93VzS0668PqTS
         hFVr0zIKAxxgwH5/LmSHF18FMDku9fzCZFCH1oPciGCcozMxAtK9iI0ITkiPA3Oo+dQp
         NAAA==
X-Gm-Message-State: AOAM532P2mU7yH54MzZmC2Cd7Xy0XyMsS10iU29nomHzkIQ8n8UtQlya
        2M9jIRT90cWcBJMFo8EfuHo=
X-Google-Smtp-Source: ABdhPJygeIG28OHrqsgk/2CEHm8NN8YwBB4sHoOPTswcEo4aLKsjBz4rkKm77Ow6NK+uebVWeUCaeA==
X-Received: by 2002:a17:906:33db:: with SMTP id w27mr20992248eja.195.1614010104744;
        Mon, 22 Feb 2021 08:08:24 -0800 (PST)
Received: from BV030612LT ([81.18.95.223])
        by smtp.gmail.com with ESMTPSA id ck9sm11689974edb.36.2021.02.22.08.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:08:23 -0800 (PST)
Date:   Mon, 22 Feb 2021 18:08:21 +0200
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
Message-ID: <20210222160821.GA468766@BV030612LT>
References: <cover.1611653995.git.cristian.ciocaltea@gmail.com>
 <20210221163602.GA297639@BV030612LT>
 <20210222090247.GA376568@dell>
 <20210222151649.GA467803@BV030612LT>
 <20210222153016.GG376568@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222153016.GG376568@dell>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Feb 22, 2021 at 03:30:16PM +0000, Lee Jones wrote:
> On Mon, 22 Feb 2021, Cristian Ciocaltea wrote:
> 
> > On Mon, Feb 22, 2021 at 09:02:47AM +0000, Lee Jones wrote:
> > > On Sun, 21 Feb 2021, Cristian Ciocaltea wrote:
> > > 
> > > > Hi Lee,
> > > > 
> > > > I have just noticed your mfd-next tag for 5.12 doesn't include the
> > > > support for the ATC260x PMICs.
> > > > 
> > > > I assumed the patchset is ready for merging.. Did I miss something?
> > > 
> > > The MFD driver needs another review.
> > > 
> > > For some reason, this didn't register on my TODO list.
> > 
> > You have already tagged v6 with 'Acked-for-MFD-by: Lee Jones
> > <lee.jones@linaro.org>':
> > https://lore.kernel.org/lkml/20210125142558.GA4903@dell/
> > 
> > I have submitted v7 to drop the patches that had been already picked up,
> > as previously agreed, but otherwise there are no other changes.
> > 
> > That is why I didn't expect another round of review..
> 
> I see what's happened.  You forgot to:
> 
>   "apply this as-is to your sign-off block"
> 
> ... as requested, which made me think it needs a subsequent review.

Sorry, I somehow missed that.  Should I resend the patch series?

If yes, I assume I should also increment the revision number, even
though there are no other changes except the addition of the
indicated tag.

> > > In general, if you don't receive a review within ~2 weeks of posting
> > > (and the merge window is not open), you should consider it lost and
> > > submit a [RESEND].
> 
> Due to the fragility of email reviews, this is still very important.

Right, thanks for the hint!

> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
