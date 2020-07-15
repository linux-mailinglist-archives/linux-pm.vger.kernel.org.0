Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882F9220558
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgGOGpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 02:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOGpn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 02:45:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E8EC061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:45:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so1223921wrw.1
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XztsKGJEU+CUFjtwacm0V9J4sEA12XWIOSpOScerZmI=;
        b=WaqaqRjzn3caUdJrBbRSfKtjgrOj0a5Kd+508p39G78KExPJMqlz0bYhMTxE4sIzw9
         3R+TnXkPJ4US8nRWEGdmYHEqRqB9ZgnWmKPGBQTcjPbWtxipQ5OVaZi2B9zTVIwdBGg0
         Zjbp++8q9e0kR28MklfVSmNIFXfUgl0aqVal5l9TExy8vhYYHA5nNQntaNdU5LYUDVDp
         9UF6Jqz9RcNV1/lZqoYiPFyqakM8fec25kSbwyHlDvJzNJQQnMbIRW4BEhlz3Wijn731
         DJt0zwZJ+B9/CZ2f7KtaqQjTDNLVxVOABGDAgg7O3YmHKPKdQghAyUtvyA2inv4LfBO6
         z/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XztsKGJEU+CUFjtwacm0V9J4sEA12XWIOSpOScerZmI=;
        b=jjrDnPZgKZUhFY4nfn4W+gv95++RyHSDWrWf5NnAU8EMLgzF4eVny8dPhVgctdB7g/
         vNtNLgOe61tNcm1g7cXnmGA/05orBx/40OR5C8GJZkFlMaN4IoR9RoXwMwexxBQSCSRP
         d32UzRnUJaP5dCm4UwxgixDdxTReSpTEZboyGF8enyWYYeGxyMwYDgxAGMWuNkaA//fG
         qre4WCmt2jFKpYHucN30m4n3pTqKWfPU/HWBnBh9hwgOeouevAs6nlocKeD0ludO3M6l
         fbb2udhqNjdkSsOuDpNORuFTkhzs3M1qu1UjY8SZmdglmeSaJ1S/N5W73CmSsNCHFNyo
         6h5A==
X-Gm-Message-State: AOAM533SfJytTVUY7Fdby0Lfd6a+adL3fHqvtkGQGUlKKUntbHEH9079
        JcpK/iP+s5u1xKnUD35AA8FPiQ==
X-Google-Smtp-Source: ABdhPJwQKjhVASdmaI/2VIgjKjTfPbIF9AnGWg0tSX5DecvbWwiJTEFWyH++GnO/A8tnpeliNhjhdg==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr9478353wrt.174.1594795541941;
        Tue, 14 Jul 2020 23:45:41 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id 5sm1911491wmk.9.2020.07.14.23.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 23:45:41 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:45:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 03/13] cpufreq: cpufreq_governor: Demote
 store_sampling_rate() header to standard comment block
Message-ID: <20200715064539.GS1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-4-lee.jones@linaro.org>
 <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 14-07-20, 15:50, Lee Jones wrote:
> > There is no need for this to be denoted as kerneldoc.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'attr_set' not described in 'store_sampling_rate'
> >  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'buf' not described in 'store_sampling_rate'
> >  drivers/cpufreq/cpufreq_governor.c:46: warning: Function parameter or member 'count' not described in 'store_sampling_rate'
> > 
> > Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > Cc: Jun Nakajima <jun.nakajima@intel.com>
> > Cc: Alexander Clouter <alex@digriz.org.uk>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/cpufreq/cpufreq_governor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > index f99ae45efaea7..63f7c219062b9 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
> >  static DEFINE_MUTEX(gov_dbs_data_mutex);
> >  
> >  /* Common sysfs tunables */
> > -/**
> > +/*
> 
> This is an important routine with good documentation details already
> there, though internal to governors and so I would rather keep it.

It maybe documented, but it isn't kerneldoc, for 2 reasons; a) it
doesn't meet the standards required qualify as kerneldoc i.e. it's
missing descriptions for each of the function parameters, which is why
the kerneldoc checker is complaining about it and b) it is not
referenced by any *.rst file:

 git grep kernel-doc::.*cpufreq_governor.c
 /* no results */

So what is the justification for keeping it as kerneldoc?

> >   * store_sampling_rate - update sampling rate effective immediately if needed.
> >   *
> >   * If new rate is smaller than the old, simply updating
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
