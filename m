Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD10173415
	for <lists+linux-pm@lfdr.de>; Fri, 28 Feb 2020 10:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgB1Jdk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Feb 2020 04:33:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33777 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgB1Jdj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Feb 2020 04:33:39 -0500
Received: by mail-ot1-f68.google.com with SMTP id w6so2010676otk.0;
        Fri, 28 Feb 2020 01:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g259Bdr0TOEOfk7RCUcEIkZFnNW91J8vmXznwDQd4G4=;
        b=MgTHTNGdP10qgz/S+MbxUMpDSs1OOJtiYRwwuuLp0NlLQAb9+fcadzd5KpFNnnisg5
         dYdM3dkXP+qD4LsOCmhCKfr4H9E8icIzjMutU9fhcpJgm/K7ftap2oRi958GET8t6bUX
         UFQ2HL+Pkx23dFzhITs3dPt/7HB/wcfchGLyXtNr5oYW3GfEXViXVfxiFKB8kRiLKX39
         JX80ObCkLOyHxLMzgSgRdGeuPRZ0/tD4znuMtImF/d+AKubJ1HiRWXRC4+0+QiQByNa4
         B+dZDAslD1ixoLB09k2rTC57x0zbLKeXtl1OVu6Mhp1J2bxpwNvuY7URn2SngrWYBzNS
         uCSQ==
X-Gm-Message-State: APjAAAXyhkMaHlcxw0V9pp2V4d5GPjZ5FJfBMruKsHS1+yJHv9G8toAA
        uozymEIENmZpsW7Di6M8w7P+DT2x4+BCsfD4wM0=
X-Google-Smtp-Source: APXvYqynVqWYt5/5hazKWORDl6+ffgJGUzCcqyS8DLF3PkOrqdXvLrH2VVv7bD3AXVirwTR2MrY1vx2Bw4YjY/a3llM=
X-Received: by 2002:a05:6830:1651:: with SMTP id h17mr2382643otr.167.1582882417497;
 Fri, 28 Feb 2020 01:33:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581956285.git.mchehab+huawei@kernel.org>
 <7a89b0c82520d340d3c7f45bfd52ee9e6e23dbdf.1581956285.git.mchehab+huawei@kernel.org>
 <CAJZ5v0jsQ51cp3LQ8qjmMj6tZJPC=t9Y_5SN78fLWe0mpJX08g@mail.gmail.com> <20200228101412.5b57c427@onda.lan>
In-Reply-To: <20200228101412.5b57c427@onda.lan>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Feb 2020 10:33:26 +0100
Message-ID: <CAJZ5v0h0sEf=fuC28W3ULQcLGFkuu58WYRURUBPeYyw6rpifFA@mail.gmail.com>
Subject: Re: [PATCH v2 14/24] docs: cpu-freq: convert index.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Feb 28, 2020 at 10:14 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Hi Rafael,
>
> Em Mon, 17 Feb 2020 21:06:20 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> escreveu:
>
> > On Mon, Feb 17, 2020 at 5:20 PM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > most of the stuff there can be re-used with ReST format,
> > > but we need to add an empty TOC and remove the existing
> > > entries, as the following conversion patches will be re-adding
> > > them, as they're converted.
> >
> > I see a very little value in converting the files in the cpu-freq
> > directory from .txt to .rst, which I have told you at least twice.
> >
> > They are just old-style driver API documents for cpufreq, but moving
> > them under driver-api/ as they are would not be a good idea IMO,
> > because at least some of them are outdated (note that the admin-guide
> > part of the cpufreq documentation, in the .rst format, is located
> > under admin-guide/).
> >
> > I haven't had the time to write a proper replacement for them yet and
> > honestly I find it quite obnoxious to see these reoccurring attempts
> > to blindly convert them to .rst without taking care of their contents
> > and location.
> >
> > I will take care of these files at one point as promised, but that's
> > not going to happen today or tomorrow and please just leave them alone
> > if that is not a big deal.
>
> Sorry, I completely forgot that you asked to skip the old cpufreq docs.
> My bad!
>
> The thing is that I have now fully converted all docs to ReST (with a
> handful exceptions for things that may not make sense to convert, like
> configuration files that ends with .txt).

And I have this patch:

https://patchwork.kernel.org/patch/11411035/

so at least please drop the commits converting the three files affected by it.

> As a matter of helping those (like me) that are trying to finish this
> huge conversion/reorganize task, I would very much prefer to keep those
> files converted somewhere (or trashed, if their contents is now completely
> garbage).
>
> One of the things we discussed at linux-doc ML is to create a "staging"
> area where we can place:
>
> - things that aren't ready to be at the main documentation body yet;
> - too obsolete docs that may require major work;
> - things that we didn't find a good place to put yet.
>
> From the last discussions, it seems we reach a consensus about creating that.

So the other files in Documentation/cpu-freq/ can be converted to .rst
as far as I'm concerned (even though I still don't see much value in
doing that, just for the record).

They will be going away anyway in the future, regardless of the format
in which they are at that time. :-)

Cheers!
