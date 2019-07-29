Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0D679C22
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2019 00:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbfG2WD7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 29 Jul 2019 18:03:59 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35187 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfG2WD7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jul 2019 18:03:59 -0400
Received: by mail-oi1-f195.google.com with SMTP id a127so46403368oii.2;
        Mon, 29 Jul 2019 15:03:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y260FQuMp7oPWM+HPu4498GOZAdUH2RolhKd2463kTQ=;
        b=qqjEDoejrqI/NPnKzOvjaY0KKkDJpR4oF/Lsu0gUpyUvacK99U670zYqEcTJ5JD/ad
         P0uJlaTk+J0TqEVPFHnUTjebwwKK+LNacoWXa+4ZKT9pR2B7k7f9yk0KVfApP4hNEWbn
         5Be3HWgZpcVgj1+o9QGDOFF02qRtkFM/Ksfn3J4lUwbVAIAr497/bMahnsH7LSnOG6/+
         gYfJjcQfOeTvsZ2qE2Fh5U6h9+k2/c82JLhaFEgLfnW8jyai9N1Bd3x5kYQhnCkvjnGD
         XkYOl7mfsxm8pwgXg4tEzYqYsMtIFJGrsOQ4PVqajfHOanAQx+DeMIgYzu6U9axqR/Dj
         rJgQ==
X-Gm-Message-State: APjAAAXnVWOqmwzSWvMvfGQFwYnQwsmFm/oLqaA9Rt3Q9WT5eyeDluxO
        68+mMpK/YRCgYAVC0kMr6HShYWibrI4xykwAjhc=
X-Google-Smtp-Source: APXvYqxiW0IGhW5Z4fCni0JP6nmkmePUZVFtMXAB6tjiAnbweRvsn3zPj+QmfO3RbrNsKcOU/mT9Q+PAlP8p4UqcngA=
X-Received: by 2002:aca:4e89:: with SMTP id c131mr54969535oib.57.1564437838483;
 Mon, 29 Jul 2019 15:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <2305283.AStDPdUUnE@kreacher> <c8960d91-4446-9acf-5575-e442a652bd05@gmail.com>
 <CAGETcx_+i6_0Q2rf-UdzZ3bCPUos9Tu4JmvvO0zUoy5gB8_ESQ@mail.gmail.com>
 <CAJZ5v0h5U60yCyaHeHVbWmwWDa4NBnuhgsV022nZm5HuGgV7ow@mail.gmail.com> <CAGETcx9oqAJ-VoJnD0Y8k+W8cCGPDz--=amktSgW_sB4MEngDA@mail.gmail.com>
In-Reply-To: <CAGETcx9oqAJ-VoJnD0Y8k+W8cCGPDz--=amktSgW_sB4MEngDA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Jul 2019 00:03:47 +0200
Message-ID: <CAJZ5v0gSyPn8sZ2jJ+nZ_nu1Y=8+7Pg+pPvKGSijUm_sKitk4Q@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Remove device link creation limitation
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jul 29, 2019 at 11:43 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Jul 29, 2019 at 2:25 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jul 29, 2019 at 10:47 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Rafael,
> > >
> > > This is the fix you need. Or something link this.
> > >
> > > I had asked you to reject DL_FLAG_MANAGED as an input flag if you are
> > > marking it as internal (in the comments). But looks like you were also
> > > trying to check for "undefined" bit positions. However, the check
> > > isn't correct because DL_MANAGED_FLAGS doesn't include (rightfully so)
> > > DL_FLAG_PM_RUNTIME and DL_FLAG_RPM_ACTIVE .
> > >
> > > I tried to write a DL_FLAG_EXTERNAL to include all the external flags,
> > > but that felt like a maintenance headache that's not worth carrying. I
> > > think it's simpler to just error out when internal flags being passed
> > > in and ignore any undefined bit positions.
> >
> > Well, IMO it is better to prevent people from passing unrecognized
> > flags to device_link_add() at all, even if that means some extra
> > effort when adding new flags.
>
> It isn't so much the extra effort that's a concern, but people might
> miss updating whatever grouping macro we use.
>
> >
> > I'll post an alternative fix shortly.
>
> You might want to move the MANAGED_FLAGs and other grouping macros
> into the header file then? So that if someone is adding new flags,
> it'll be less likely they'll forget to update the grouping macro?

They would need to update device_link_add() itself, so updating a
thing next to it does't seem to be so much of an issue.

Moreover, the "grouping macro" is not relevant for any users of the
API, just for device_link_add() itself, so I'm not sure how much
better it is to have it in the header.

And, of course, if anyone forgets to update the "grouping macro", they
will find that the new flags are rejected immediately.
