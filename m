Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0522D39D5F8
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 09:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGH2Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 03:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFGH2Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 03:28:24 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B4C061766;
        Mon,  7 Jun 2021 00:26:13 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id b9so23511337ybg.10;
        Mon, 07 Jun 2021 00:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtnNJSzY+wqJlsXGkdIUlXSH9MwewKVdh4spUDitCmk=;
        b=aEusFMGJcNWdM07Zh75rwjOJL6wkhZ7RwpJX/eB1p1u5ErRdWG3VlaDoO/B4vf0Fjj
         ff3r3hmDiintB1aF025M9rc8WkyxykeOqR1az+RPjQN2sMapnNJzJLagbBBPjYfPJ6Na
         fiNtFwqD/29Ts9MaiwsImL9EDzlvBF7cmrz5XHyNHuA6mRyOTRKA1P5iknCT1i05dl83
         ryWQHcW1dJ07pj0dU6oYksQtPbS5d7XTz9z3O2kr8rq/6hMhDyd34/0R9Q9OhmE/sI3r
         32qE5F/B1KDoSuvZEAyjXOkdR2XODDXkNCEX2aZaMynPAZ3HLVEd432OTdRH/TYLdom2
         uNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtnNJSzY+wqJlsXGkdIUlXSH9MwewKVdh4spUDitCmk=;
        b=TTtk/4Qh3LLWUaMMIEFVhzZsqaU+J3Hj9wiE335b/9fD2PD+FUkwQMJ4fR4f+pV8+u
         KGdddh00HXHdeHyJUv5I+nOiKcd9bKIe2euOo1rJd3OZJvMB8Ab+hR7gdftQznR3SLEY
         m34UN0fJ5ts30UR8XQruq9jeTxArpNrItUv3i4KN/RI9WJGdmYhAUh1c9DZXmexpgpvy
         /hECwmzKssdyZUTWy6VOrqHsZVC3OJPduDJN1dwFaGBrTKrFzP+OGDGvoDD5eOLFVw1P
         q6gr3LyJx9dE8lmvGWsJKBz5ScFZu5lWumhmR1Z07QBcG8wIxEnS1dMMXwbuXkKJPvhK
         vxHA==
X-Gm-Message-State: AOAM532P6Z89QbNi9pX3j6WbHYIZCBlaRXE30UB40MhWJDCLE1f8BywK
        IB1CQssTGHywF8n8vqgmA5JLMQxTqp8Bi7lS0BmT/KfOcxg=
X-Google-Smtp-Source: ABdhPJzacQKwVdIH8Y73h3Tb6mT0mXkPI9AA7BsfstY8LWHKA0asYRQVLTb2yQwhcPiAZxPfC1lhtCCH11N0RQ5GOXk=
X-Received: by 2002:a25:8093:: with SMTP id n19mr22738419ybk.414.1623050769285;
 Mon, 07 Jun 2021 00:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210521221906.199436-1-kyle.meyer@hpe.com> <CAJZ5v0iJUhUyucYEDHXKqXrsy6=3dGUz0uy1pDpx+kKOi_NB2w@mail.gmail.com>
In-Reply-To: <CAJZ5v0iJUhUyucYEDHXKqXrsy6=3dGUz0uy1pDpx+kKOi_NB2w@mail.gmail.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 7 Jun 2021 12:55:58 +0530
Message-ID: <CAOh2x==tXk2Lt_f14_azHNYG2mZzMb9-1b2YUVj=+i=-JLemdg@mail.gmail.com>
Subject: Re: [PATCH] acpi-cpufreq: Skip initialization if a cpufreq driver exists
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Kyle Meyer <kyle.meyer@hpe.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, linux-acpi@vegr.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Rafael,

On Mon, May 24, 2021 at 7:47 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sat, May 22, 2021 at 12:19 AM Kyle Meyer <kyle.meyer@hpe.com> wrote:

> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index 7e7450453714..e79a945369d1 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -1003,7 +1003,7 @@ static int __init acpi_cpufreq_init(void)
> >
> >         /* don't keep reloading if cpufreq_driver exists */
> >         if (cpufreq_get_current_driver())
> > -               return -EEXIST;
> > +               return 0;
> >
> >         pr_debug("%s\n", __func__);
> >
> > --
>
> Applied as 5.14 material with some edits in the subject and changelog, thanks!

I am not sure how this is supposed to work. If we return 0 from
acpi_cpufreq_init(),
then the driver will never be used, since it's acpi_cpufreq_init()
will never get
called again later.

cpufreq drivers don't follow the generic device/driver model where a driver gets
probed again if a device appears and so this is broken.

Please revert this patch.
