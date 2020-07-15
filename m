Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF60220638
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgGOHb5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 03:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgGOHb4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 03:31:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC80FC061755
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:31:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j4so1268835wrp.10
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=07I/S8ewhyB0gez/czwEXo+nNeITutjOWFFjAQJcuNA=;
        b=ilKbh84sIQXFNzAGRoY7pmq+/Ys3cMNDHi8iktz1qc8NhXvwAJCsI5UrY/1w6+yzPo
         0hkoHlRSgoC0BRbR9/FKYxjdyxPJ+ZSm3C6RvR8/N09iLis38dCLQ63BK0LtsaPANPuA
         Jopes3d2OG7VTW7DVi2DZUsPIbR4pPv05XA80YnOTirUXaEjLaFUkPYvo93nsT1X8TMP
         zfpWa0q+oZyM0U/uh4Hl9i/R34YEU0fnCams/vH26ZGq8qWCLJbPZqoTDdD4+CdTMynW
         L4eT7p1EEJ7fhiiH46nGgcpjveELUlGwE4FsrxqVjuyV+mimSTtka08BJ5Cy58JIKn4E
         rFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=07I/S8ewhyB0gez/czwEXo+nNeITutjOWFFjAQJcuNA=;
        b=W0hjVroj+aAJoF4ta1wtzpU8/+9Yy49aJOUQWIj1tD64oj632LV99x7Hncy93JDbPH
         DsKZCSCCOPUqf9sQM8jY4uCbctiYP236Al0rC3ZrL7yU9Ir9GgTzxR64MLnA40bUGEuR
         arPw7lzGx/ruzViBzvsWru5kqkdkuLLGbjLHEo+/bK1w9xqhfQ59Nj1f3Wth8qu+j2fc
         Jjknm6NTOytbAWIZFlHOQa3kjm6GoKAviYrxg3vi6XHjF/XWl5452XryU+L6uQBWJVib
         4DvS8iVsPaG6Befhm81GCbFIP6Kx6kJvFlMVDD+MsKT9XdWfTItR5BjOyG0a9++DvEfa
         LpUA==
X-Gm-Message-State: AOAM531SPE+3G6bbCpus3JxacShn9taUa2i86vRD2amM/nQ8QYkWxEYZ
        nMvEDpBqG/x4PDT+HM/AwMKbvQ==
X-Google-Smtp-Source: ABdhPJxS3oJRkHhG2F62a81eE4UlM3maxq/ryzQ1R68ZuwDmyQUVKo6vYdt46PoRJZzpK56mm/HWMg==
X-Received: by 2002:a5d:6088:: with SMTP id w8mr9594304wrt.49.1594798313511;
        Wed, 15 Jul 2020 00:31:53 -0700 (PDT)
Received: from dell ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id j24sm2272832wrd.43.2020.07.15.00.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:31:52 -0700 (PDT)
Date:   Wed, 15 Jul 2020 08:31:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 03/13] cpufreq: cpufreq_governor: Demote
 store_sampling_rate() header to standard comment block
Message-ID: <20200715073150.GX1398296@dell>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-4-lee.jones@linaro.org>
 <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
 <20200715064539.GS1398296@dell>
 <20200715070836.l24lzkb6pgvqj26i@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200715070836.l24lzkb6pgvqj26i@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, 15 Jul 2020, Viresh Kumar wrote:

> On 15-07-20, 07:45, Lee Jones wrote:
> > On Wed, 15 Jul 2020, Viresh Kumar wrote:
> > > On 14-07-20, 15:50, Lee Jones wrote:
> > > > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > > > index f99ae45efaea7..63f7c219062b9 100644
> > > > --- a/drivers/cpufreq/cpufreq_governor.c
> > > > +++ b/drivers/cpufreq/cpufreq_governor.c
> > > > @@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
> > > >  static DEFINE_MUTEX(gov_dbs_data_mutex);
> > > >  
> > > >  /* Common sysfs tunables */
> > > > -/**
> > > > +/*
> > > 
> > > This is an important routine with good documentation details already
> > > there, though internal to governors and so I would rather keep it.
> > 
> > It maybe documented, but it isn't kerneldoc, for 2 reasons; a) it
> > doesn't meet the standards required qualify as kerneldoc i.e. it's
> > missing descriptions for each of the function parameters, which is why
> > the kerneldoc checker is complaining about it
> 
> Right, so this is a mistake and not intentional probably.
> 
> > and b) it is not
> > referenced by any *.rst file:
> > 
> >  git grep kernel-doc::.*cpufreq_governor.c
> >  /* no results */
> 
> I believed (and it may be wrong) that there are two categories of
> routines/structures which can be put in kernel documentation, the
> exported ones and the internal ones which are important and are very
> useful in understanding the algorithms/logic in the drivers.
> 
> I did try to go and look into Documentation/doc-guide/ but couldn't
> find any details on this.
> 
> You said that it needs to be referenced from some *.rst file, but why
> is that necessary ? What if people don't add any documentation in
> Documentation/ for their framework or driver but still want stuff to
> appear in kernel-doc as they can keep the documentation in comments
> more up to date.

I'm not sure what you mean.  Kerneldoc headers are designed to be
extracted and converted into mediums which are easy to read/browse.
For example, see the online documentation for 'debug_object_init':

 https://www.kernel.org/doc/html/latest/core-api/debug-objects.html?highlight=debug_object_init#c.debug_object_init

They are generally meant to be referenced/consumed.  There is even a
script provided inside the kernel to find offending instances where
kerneldoc headers are provided, but not *yet* referenced:

 `scripts/find-unused-docs.sh`

HINT: There are many.

There *could* be and argument to use kerneldoc *just* so you can use
the kerneldoc checker `scripts/kernel-doc` (which is invoked by W=1
builds), in order to ensure the parameter descriptions are kept in
check.

However, in this case, there are no descriptions provided.  So, in
reference to my previous question, what are your reasons for wanting
to keep kerneldoc here?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
