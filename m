Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A812E21FF83
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 23:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgGNVBj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 17:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgGNVBj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 17:01:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5C6C061794
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:01:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so184337wrp.7
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gVD9qdPMyUmjbT/wQ1whJd58NB9dc+MTfoFQHtY+660=;
        b=bQ9D3OLg1v4uiE7MNPeSsCZ9RjCLsAXGwENkmXzkCqye+xMBX1iTLaiqTh+6Kh8GXe
         m2n12+8KlPUJLT7DCFMhcHtE8JlYLW50hkC4IBjo67KedA4qpEHW/PWyMxcNTNTS5sEf
         F82bVfSUPDu0MY27IrQxz7IPFxQyw9tdK3Ly+qhjEFOH7+PtdswO7JGZThpVEGuJu/+v
         R8eSIi8vHfHyiDtWbCmC1yVwTwKsE4ZfhbBi/LAml1bmYFSvRgSQ470zxz1iAtsHlN7a
         DkV8jQvJKsGeADwO1t4/+0HWkfNxU84YSp0/vkHna8N4y1131VWlnivaL/yMr6aZ4T/S
         mnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gVD9qdPMyUmjbT/wQ1whJd58NB9dc+MTfoFQHtY+660=;
        b=ETNNmooAxgOFgxh2z6/y1exfBCi0jXVNB9O/R8ruTdcPS67SvpXMwaraBdZt57AbPJ
         qSOcISrTb4sLZFVlFBRP+oiJQbGNJAbTjLkL1aZcctJosYn25ySek5kq4dWd1BAm7XsO
         zJnFoxWLtc43TxlZfjj7JBp7QWvu01iWfydAMWjhsUOTOKJN+4dAEECe7QTvGDvB3V8m
         g31SvbqAk/wNhubQL/3gprs2pnjgJnurjNk5uvzj94Q6ez5KUVAIGN4OROda5n5PjndF
         UsPUJ1GLUDmS+ee4+e+A7WQ0ED8IP+ONY/yilU/0sLqFZWqPifSKGrYo9OnZepPH2QqE
         Lu1Q==
X-Gm-Message-State: AOAM531YdSREWD91VpdPPYpXjWijeDR8ks9lgv2NeCpvsN2bw/Xp7k0j
        mjBe5sZLpUGFNvA7GXpvu+uY2A==
X-Google-Smtp-Source: ABdhPJx/Uqe4FxAG4ZMmGcrr32Cx8sRFTkUO3Zy3oUr3YF1k+Daypk5262+gqjeWsMOgCWIUSQWJ9A==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr7815941wrm.401.1594760497577;
        Tue, 14 Jul 2020 14:01:37 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id e17sm29502178wrr.88.2020.07.14.14.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:01:36 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:01:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Andreas Herrmann <herrmann.der.user@googlemail.com>,
        Dominik Brodowski <linux@brodo.de>,
        Pavel Machek <pavel@ucw.cz>,
        Paul Devriendt <paul.devriendt@amd.com>,
        Mark Langsdorf <mark.langsdorf@amd.com>
Subject: Re: [PATCH 10/13] cpufreq: powernow-k8: Make use of known set but
 not used variables
Message-ID: <20200714210135.GG1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-11-lee.jones@linaro.org>
 <CAJZ5v0jXjtZ0=ZnOZm2LNR32TwWSrq4C4bwhNh5tOOChfpWZxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jXjtZ0=ZnOZm2LNR32TwWSrq4C4bwhNh5tOOChfpWZxw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 14 Jul 2020, Rafael J. Wysocki wrote:

> On Tue, Jul 14, 2020 at 4:51 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > If we fail to use a variable, even a 'dummy' one, then the compiler
> > complains that it is set but not used.  We know this is fine, so we
> > set it to its own value here.
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/cpufreq/powernow-k8.c: In function ‘pending_bit_stuck’:
> >  drivers/cpufreq/powernow-k8.c:89:10: warning: variable ‘hi’ set but not used [-Wunused-but-set-variable]
> >  89 | u32 lo, hi;
> >  | ^~
> >  drivers/cpufreq/powernow-k8.c: In function ‘core_voltage_pre_transition’:
> >  drivers/cpufreq/powernow-k8.c:285:14: warning: variable ‘lo’ set but not used [-Wunused-but-set-variable]
> >  285 | u32 maxvid, lo, rvomult = 1;
> >  | ^~
> >
> > Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> > Cc: Dominik Brodowski <linux@brodo.de>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: Paul Devriendt <paul.devriendt@amd.com>
> > Cc: Mark Langsdorf <mark.langsdorf@amd.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/cpufreq/powernow-k8.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> > index 3984959eed1d5..b76df81044c4f 100644
> > --- a/drivers/cpufreq/powernow-k8.c
> > +++ b/drivers/cpufreq/powernow-k8.c
> > @@ -89,6 +89,7 @@ static int pending_bit_stuck(void)
> >         u32 lo, hi;
> >
> >         rdmsr(MSR_FIDVID_STATUS, lo, hi);
> > +       hi &= hi; /* Silence set but not used warning */
> 
> Hmm.
> 
> What about using __always_unused for this?

I didn't know you could use that for standard variables.

Will fix.

> >         return lo & MSR_S_LO_CHANGE_PENDING ? 1 : 0;
> >  }
> >
> > @@ -292,6 +293,7 @@ static int core_voltage_pre_transition(struct powernow_k8_data *data,
> >                 rvomult = 2;
> >         rvosteps *= rvomult;
> >         rdmsr(MSR_FIDVID_STATUS, lo, maxvid);
> > +       lo &= lo; /* Silence set but not used warning */
> >         maxvid = 0x1f & (maxvid >> 16);
> >         pr_debug("ph1 maxvid=0x%x\n", maxvid);
> >         if (reqvid < maxvid) /* lower numbers are higher voltages */
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
