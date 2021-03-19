Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C933421DD
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 17:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCSQ2R (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 12:28:17 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:40721 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCSQ2A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 12:28:00 -0400
Received: by mail-ot1-f42.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so8787112otb.7;
        Fri, 19 Mar 2021 09:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fe9T/9T1yaTbtskKSKGC++4srcmBZ9L9xm28oaCiUwE=;
        b=Yyg9dzu2vOSGEhr/WpivbM0CUel0ys9Ajoq4JWOSGdcJUn5Gi6DVn42PZ3PmXwlosm
         qxHOMp6pSqOPsLft6QK8RQbd2Njwg/M8Bh4Or22ZQQ+ZpTZ+oiJp+WD2WVP5Z5a1Nxfb
         3v7ui6AJJhCkumA4P0fIW0Tc64QjcT8JpYZSIPeudNMvUeIPJsUnl1uY+5ul4blblVz4
         HrM01V9QviYTnr6o9bjxkt65ReFBZdFVVNd1yOxDr5jT/SIVGE+5hZf5LtBco3lEpk3g
         yLa0wpgL3j3q3sdoICKcRnc6Io3w2zpOdbX3W1lq7hDHm2rdFf5QKqYm7k3ButIAn14h
         Dyvw==
X-Gm-Message-State: AOAM530OxGOtHkC95a6CGrnMEHOBp6FLLW8eIp2HE8Tt7/l1VgcZ2KZm
        jKEJbRIL5dSfHmjn8Py2VMH3p38/Y+QA8ib9SaSJDMJM
X-Google-Smtp-Source: ABdhPJx2dV5TQWqkiNncIeOLpFwD6tY5lh33XPAnU0wRpd3lm6foyFIjNBkn3rlDbvk0K+u740kTjV1u0g4JOj8Yu0Q=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr1794535otr.321.1616171279743;
 Fri, 19 Mar 2021 09:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210313104214.1548076-1-slyfox@gentoo.org> <20210315031913.icgekcdrbw4clikm@vireshk-i7>
In-Reply-To: <20210315031913.icgekcdrbw4clikm@vireshk-i7>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 19 Mar 2021 17:27:48 +0100
Message-ID: <CAJZ5v0iWVyTvE6BZveaXBR03OYCHWUx8JiWiPtahMt-8gRgfpw@mail.gmail.com>
Subject: Re: [PATCH] ia64: fix format string for ia64-acpi-cpu-freq
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Sergei Trofimovich <slyfox@gentoo.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 15, 2021 at 4:19 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 13-03-21, 10:42, Sergei Trofimovich wrote:
> > Fix warning with %lx / s64 mismatch:
> >
> >   CC [M]  drivers/cpufreq/ia64-acpi-cpufreq.o
> >     drivers/cpufreq/ia64-acpi-cpufreq.c: In function 'processor_get_pstate':
> >       warning: format '%lx' expects argument of type 'long unsigned int',
> >       but argument 3 has type 's64' {aka 'long long int'} [-Wformat=]
> >
> > CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > CC: Viresh Kumar <viresh.kumar@linaro.org>
> > CC: linux-pm@vger.kernel.org
> > Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> > ---
> >  drivers/cpufreq/ia64-acpi-cpufreq.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
> > index 2efe7189ccc4..c6bdc455517f 100644
> > --- a/drivers/cpufreq/ia64-acpi-cpufreq.c
> > +++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
> > @@ -54,7 +54,7 @@ processor_set_pstate (
> >       retval = ia64_pal_set_pstate((u64)value);
> >
> >       if (retval) {
> > -             pr_debug("Failed to set freq to 0x%x, with error 0x%lx\n",
> > +             pr_debug("Failed to set freq to 0x%x, with error 0x%llx\n",
> >                       value, retval);
> >               return -ENODEV;
> >       }
> > @@ -77,7 +77,7 @@ processor_get_pstate (
> >
> >       if (retval)
> >               pr_debug("Failed to get current freq with "
> > -                     "error 0x%lx, idx 0x%x\n", retval, *value);
> > +                     "error 0x%llx, idx 0x%x\n", retval, *value);
> >
> >       return (int)retval;
> >  }
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied as 5.13 material, thanks!
