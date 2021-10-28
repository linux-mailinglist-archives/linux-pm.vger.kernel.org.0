Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C5243E75B
	for <lists+linux-pm@lfdr.de>; Thu, 28 Oct 2021 19:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbhJ1Rbv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Oct 2021 13:31:51 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39793 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ1Rbv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Oct 2021 13:31:51 -0400
Received: by mail-oi1-f173.google.com with SMTP id n11so1195905oig.6;
        Thu, 28 Oct 2021 10:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cJt3G+GdNt+Ox5hsmaGyEcU5SKbxURazSkdwkNcOPCk=;
        b=HFjj2NUoVkShwbVfNSc2jaOm6kOrUv9++zfewmUpYKWzSsEJChxr/DgmdRGKwnpDU9
         kqMoJEc/3K8wUQpeu5F8draRjfL4X+miEzFaDi3DDGuhS8j5Vi/sUL+wNA3cWbTolt1X
         FaN8IcSulRc90vsijSuBjeVrhai9mHj2DcVk0Flzkg0OmEoeWp14L03aKRR+Opi4CUTs
         hK/2XvyXKMJvKCex6TXf+Qbpg4GxID2N2MMyBxgrAKqZHS0z5VI+aE051SOEodSpMM9J
         T1M4HWaLqneK0/l2tzgCC4LbOpBJlIHr18g5nULyQm+ErmNzNsr2HmOOMdnFPakggZoZ
         yWEw==
X-Gm-Message-State: AOAM531aBpeGDXJ2p8hddeTtm671FETLqod1MyXn7e10XA9W3KUmlYnm
        uDqWyUzPPcZX/SDq3k2DGGyBz0Cr60VhXy865xg=
X-Google-Smtp-Source: ABdhPJwoUfEUI7tKuvxHbmK/1KdZTjAcC1nJ8fehr91sNap54RlSZcnRFdlJsWYTDrssp3oH2H1BfFRFmcQ7Uo5d//w=
X-Received: by 2002:a05:6808:e90:: with SMTP id k16mr3985669oil.166.1635442163793;
 Thu, 28 Oct 2021 10:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.22.394.2110241452460.2997@hadrien>
 <CAAYoRsXeQravNXKsWAZvacMmE_iBzaQ+mQxNbB5jcD_vkny+Sg@mail.gmail.com>
 <alpine.DEB.2.22.394.2110261658440.3825@hadrien> <CAAYoRsWXew+9Pch_9ux+UK0LFwy+211d2LmNLGKF_UTr3eS2Fw@mail.gmail.com>
 <alpine.DEB.2.22.394.2110281908150.9518@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2110281908150.9518@hadrien>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Oct 2021 19:29:12 +0200
Message-ID: <CAJZ5v0ihVdrZ1ogEc34+QgZUJW5-=RzP34-U1_91VTcLhbc4Nw@mail.gmail.com>
Subject: Re: problem in changing from active to passive mode
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Doug Smythies <dsmythies@telus.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 28, 2021 at 7:10 PM Julia Lawall <julia.lawall@inria.fr> wrote:
>
> > Now, for your graph 3, are you saying this pseudo
> > code of the process is repeatable?:
> >
> > Power up the system, booting kernel 5.9
> > switch to passive/schedutil.
> > wait X minutes for system to settle
> > do benchmark, result ~13 seconds
> > re-boot to kernel 5.15-RC
> > switch to passive/schedutil.
> > wait X minutes for system to settle
> > do benchmark, result ~40 seconds
> > re-boot to kernel 5.9
> > switch to passive/schedutil.
> > wait X minutes for system to settle
> > do benchmark, result ~28 seconds
>
> In the first boot of 5.9, the des (desired?) field of the HWP_REQUEST
> register is 0 and in the second boot (after booting 5.15 and entering
> passive mode) it is 10.  I don't know though if this is a bug or a
> feature...

It looks like a bug.

I think that the desired value is not cleared on driver exit which
should happen.  Let me see if I can do a quick patch for that.
