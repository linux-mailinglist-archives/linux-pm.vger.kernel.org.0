Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3922205DA
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jul 2020 09:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgGOHIj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jul 2020 03:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbgGOHIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jul 2020 03:08:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD49C08C5C1
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:08:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so2534139pjg.3
        for <linux-pm@vger.kernel.org>; Wed, 15 Jul 2020 00:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xq3Gp8UkhZF8kQ4zb+jyVIPFdehHjSPGd5hT6HgXh/w=;
        b=Xzy8PIF4K2ItoKXFk/foUR6I5BXk/eNa2ZxaWNFczBa7c8F6UGeqaJcQmF3pThQlvV
         7zA+6l249GsUfcUnlu2PFXF60hFBrFMUHVTHcpb9XrfItqXkg9tGQIAxe4q0zMsWmSPt
         1S+61Pr03KU1zDjmhy0/9GZezWZBTGjU1IrMIhczVD0gB8yHiLsZjPNNiY3FVnmI8LCF
         xpFRUDYOkdKnxe082gdWCthy4LmggAU51aopDp/ijQFJYWORWOBucaPJwxryIoICk0zg
         cy2bxnyVxgniG1TkcHYPV27ShnqwYAitfBDXz7zpmWcS9tnDSkYmNyF2lqwj944l+q4k
         cCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xq3Gp8UkhZF8kQ4zb+jyVIPFdehHjSPGd5hT6HgXh/w=;
        b=MVE3C90wZJiBQ0QbKF7SZqoVRNqJVy9Xhp0KaLVcSLvlL1hrbd5qAIxp5LxEA3u0OJ
         pNoDm+UakKIszVRfuV/tnzUXdVShrP0s87vBqzkGb81ilGXR7q5APgYisO19hEbECRUw
         nQz9cf7XW3+Vli2qkXiSLRXplOf3dGGveIbjuS4N1Qonuj9fIAjiCXd1jvV7ONdJnvXK
         MxiAVIpmx+aPp8mFVd1FXWfkoRY0ppto9DFjajoeGCu4Nq212ZTn7whbOcP2Jtq2flwK
         Se2Lv+f5wmI3XYA9CV0P0vAahsgXOIlN6wXXVDwdDhVY5/6N/SHEuiIYS0B+21sNzWSN
         JaQw==
X-Gm-Message-State: AOAM531lG7dRtZfWozJ/VbsBPKsiY49SE5LPOwIYeURtiI9JU3Wj04V6
        ZBiU+yvw2rzzgySGIDB6wvvpaQ==
X-Google-Smtp-Source: ABdhPJy8CU1+Q+J3Wmu7L7IHUN6Y8XnrZPCTrx2DlZ8ooaZyYSZMSLvuFcl3XIALyLJK39oEnP3dlQ==
X-Received: by 2002:a17:90a:e57:: with SMTP id p23mr8515503pja.164.1594796918658;
        Wed, 15 Jul 2020 00:08:38 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id c27sm1109468pfj.163.2020.07.15.00.08.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 00:08:37 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:38:36 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 03/13] cpufreq: cpufreq_governor: Demote
 store_sampling_rate() header to standard comment block
Message-ID: <20200715070836.l24lzkb6pgvqj26i@vireshk-i7>
References: <20200714145049.2496163-1-lee.jones@linaro.org>
 <20200714145049.2496163-4-lee.jones@linaro.org>
 <20200715025249.ukoqup4piqiz5lim@vireshk-i7>
 <20200715064539.GS1398296@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715064539.GS1398296@dell>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 15-07-20, 07:45, Lee Jones wrote:
> On Wed, 15 Jul 2020, Viresh Kumar wrote:
> > On 14-07-20, 15:50, Lee Jones wrote:
> > > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
> > > index f99ae45efaea7..63f7c219062b9 100644
> > > --- a/drivers/cpufreq/cpufreq_governor.c
> > > +++ b/drivers/cpufreq/cpufreq_governor.c
> > > @@ -26,7 +26,7 @@ static DEFINE_PER_CPU(struct cpu_dbs_info, cpu_dbs);
> > >  static DEFINE_MUTEX(gov_dbs_data_mutex);
> > >  
> > >  /* Common sysfs tunables */
> > > -/**
> > > +/*
> > 
> > This is an important routine with good documentation details already
> > there, though internal to governors and so I would rather keep it.
> 
> It maybe documented, but it isn't kerneldoc, for 2 reasons; a) it
> doesn't meet the standards required qualify as kerneldoc i.e. it's
> missing descriptions for each of the function parameters, which is why
> the kerneldoc checker is complaining about it

Right, so this is a mistake and not intentional probably.

> and b) it is not
> referenced by any *.rst file:
> 
>  git grep kernel-doc::.*cpufreq_governor.c
>  /* no results */

I believed (and it may be wrong) that there are two categories of
routines/structures which can be put in kernel documentation, the
exported ones and the internal ones which are important and are very
useful in understanding the algorithms/logic in the drivers.

I did try to go and look into Documentation/doc-guide/ but couldn't
find any details on this.

You said that it needs to be referenced from some *.rst file, but why
is that necessary ? What if people don't add any documentation in
Documentation/ for their framework or driver but still want stuff to
appear in kernel-doc as they can keep the documentation in comments
more up to date.

-- 
viresh
