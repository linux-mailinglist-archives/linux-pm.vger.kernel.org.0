Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4445A153
	for <lists+linux-pm@lfdr.de>; Tue, 23 Nov 2021 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbhKWLZo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Nov 2021 06:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbhKWLZo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Nov 2021 06:25:44 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394EBC061574
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 03:22:36 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l8so19491829qtk.6
        for <linux-pm@vger.kernel.org>; Tue, 23 Nov 2021 03:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdtQzL6rjCgCH1iP88/p5vBAhOOx4hxVqdE9kys4mlc=;
        b=vbZHP10xMotYf2Tcx/cwMBWg4jVCJcqF65vVyKyJYc16Ry45icdAFrITWTk2zz5LHC
         r7kkGE2K71GRwnUgeIQaP8lrttCe66qPXAUcPTyq+77AN+mPDuDgExIlt1poEOV/jYUI
         ceL109T42WH3KcCRGzSiuRtpkpMPwEGuMk1qZGtnc1k2Q4Uft/jNBu9t1bxDS/nn0Mne
         md2Z3YIeDPGiPGCpkksw9vsqpDf/gWvLLdHW5pg36hDSlNFbi3jqkKK3s6oe6ctw8sfO
         oqFipltDFpqlF0xuK7xj0NTNvs6E+eeKeLbgEgWMdux7CtbhFG8UA9fsbBckRe4S2Uuj
         hOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdtQzL6rjCgCH1iP88/p5vBAhOOx4hxVqdE9kys4mlc=;
        b=0YEsLwM5aYlLlW1scEyscxNId/iq4xvZcWJmziOWASJratO8jh36fq9GoC+8cBr8gt
         FiSr+Xfc/KLgp/dbWEb/GZ9Wbi9vz1KA6h5hXXUMHF3epv0DTSu0i1PMKbyp0TGiUT6S
         Hf5+61WxoOA0bKHXItZ2ekSSbTuDXaC4lZiBcI/iBQvyEZRpvnSfx4f41megmtl93k29
         THCOoR+sucYbHzfEArbfg5jbh4S6S4W8e+TJqnFGx3px3DEgm7qvlrcz8ccs63bt8dTT
         HS9nXW74fJ81+6ykeFZRg4KsLd5KcuxCFkmHVUTgY83OGz/a9BgOzM4PcathFE8BAUKU
         FMkQ==
X-Gm-Message-State: AOAM531i98wKhXjxG/0rOb7mwpCtMySPezllBMnhws2kXhQVaz4ofXmR
        SNp7Aqenx7OjV5hMzBo3hdRY/UmRjaVLN0WTc2rUOViba5kQqA==
X-Google-Smtp-Source: ABdhPJxq1ORY5Dt0LAHjQ8F/HeE7Lk+AvwFw2fRHZBemRcygSK0Rr7m3CyWfpb2YAe3GEEsS3T/64odZ8dAIf60PVEQ=
X-Received: by 2002:a05:622a:588:: with SMTP id c8mr5210526qtb.108.1637666555311;
 Tue, 23 Nov 2021 03:22:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHbf0-FnmdCAwuML4cxM3UAaOWqZ0sxJSF3iRw_aAmZEq6RfSQ@mail.gmail.com>
 <CAHbf0-E5Zrs9-bWYMm8A-RQ7xd0DOCZopzZ2GjtH8xcFf4wVtA@mail.gmail.com> <YZzN4Nc2tcclbVIO@hr-amd>
In-Reply-To: <YZzN4Nc2tcclbVIO@hr-amd>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 23 Nov 2021 11:22:24 +0000
Message-ID: <CAHbf0-GPqod-W5exGt4c63YYVG27M4qdSi25wwqmFfC_ypTFyw@mail.gmail.com>
Subject: Re: AMD Pstate
To:     Huang Rui <ray.huang@amd.com>
Cc:     Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, 23 Nov 2021 at 11:18, Huang Rui <ray.huang@amd.com> wrote:
>
> On Tue, Nov 23, 2021 at 06:47:34PM +0800, Mike Lothian wrote:
> > Hi again
> >
> > Do I need to enable something else for shedutil to work, I've tried
> > with and without shared_mem? Compiling a kernel with -j16 has the freq
> > stuck at 1GHz on all cores - ondemand works fine
> >
>
> If you set the CONFIG_CPU_FREQ_GOV_SCHEDUTIL, then no more configurations.
>
> Did you use the V4 version?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/log/?h=amd-pstate-dev-v4
>
> > That's on a AMD Ryzen 9 5900HX
> >
> > Also compiling with Clang-13 gives the following warnings:
> >
> > drivers/cpufreq/amd-pstate.c:257:6: warning: variable 'amd_des_perf'
> > is used uninitialized whenever 'if' condition is false
> > [-Wsometimes-uninitialized]
> >
> >         if (target_perf < capacity)
> >
> >             ^~~~~~~~~~~~~~~~~~~~~~
> >
> > drivers/cpufreq/amd-pstate.c:272:40: note: uninitialized use occurs here
> >
> >         amd_des_perf = clamp_t(unsigned long, amd_des_perf,
> >
> >                                               ^~~~~~~~~~~~
>
> Ah, miss one line. Thanks for the info. I will correct it.
>
> Thanks,
> Ray
>

Hi

Yes I used v4 and CONFIG_CPU_FREQ_GOV_SCHEDUTIL was set as the
default, is there any other info that would be useful, I can switch
back to schedutil from ondemand and collect for you

Cheers

Mike
