Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654C32B5F60
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 13:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgKQMvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 07:51:16 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35723 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgKQMvQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 07:51:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id c80so22440697oib.2;
        Tue, 17 Nov 2020 04:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RzG7JgPEfJ1zdsuzJd2/nDlwOmQ1Nm5XN5Yd5K0U3k=;
        b=bq16nF3KNUW5//6lNkskrbdA6aXYI4UfgdDogY0d27GGLelSXh+Wi/W2J1reuXEYBq
         tp/UXo75wzavxH4jrN0CdaqGrKDL4g0I+LUa7S1Jb3/vGEDQ8Dr+xKto+6ahBBF5CG3v
         nBmOuujbCGnSwja+pb35b0RKu/biKDKZRa93svYELNBBJ2l0Ljs5sksmiCK7tXmDdV9h
         yI55WjhmXHwEArC6ts64RqKU2KcG7nX5aoPfhHpfG2zPYiIsfq300COpSt73OBNqs972
         ne1WlMaTghQ9vlLE3UDcf/t3nVz03vVcARkybJOjsamijonM9iBidYHei0Puvj+KIGf8
         FRvg==
X-Gm-Message-State: AOAM533pSDkmKMkg30D6zyVwjslquGXwTWWE4DujDo05RMYsxwerr9dd
        wyWdoe7Semy6Mb0qzQ4tYz09qb5WVdkjR2o3Ca8=
X-Google-Smtp-Source: ABdhPJycjJvWLLOzIkYryRsKNGU/QCsrjU86hRE0u6fiqEXxKWgSQxNT3XVT9m0cNOmOgy+nuS+fiZsgp0TduM6sUUg=
X-Received: by 2002:aca:c4c9:: with SMTP id u192mr2207887oif.69.1605617474068;
 Tue, 17 Nov 2020 04:51:14 -0800 (PST)
MIME-Version: 1.0
References: <20201109172452.6923-1-lukasz.luba@arm.com> <CAJZ5v0gQj8cNHgXkgwGeNcegAmP2xxqPQXz1kGNqFFDDCgfX_w@mail.gmail.com>
 <6d29b192-bad4-3abc-96fd-dfe12cc402e4@arm.com>
In-Reply-To: <6d29b192-bad4-3abc-96fd-dfe12cc402e4@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Nov 2020 13:51:02 +0100
Message-ID: <CAJZ5v0ihFzzmcN1c-Oo2ELkJZcLhfsrQTh+Yd5bgo3yrnjZPuA@mail.gmail.com>
Subject: Re: [PATCH] powercap: Adjust printing the constraint name with new line
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 17, 2020 at 10:22 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> On 11/10/20 7:19 PM, Rafael J. Wysocki wrote:
> > On Mon, Nov 9, 2020 at 6:25 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
> >>
> >> The constraint name has limit of size 30, which sometimes might be hit.
> >> When this happens the new line might be lost. Prevent this and set the
> >> new line when the name string is too long."
> >>
> >> Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> >> ---
> >>   drivers/powercap/powercap_sys.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> >> index f808c5fa9838..575f9fdb810e 100644
> >> --- a/drivers/powercap/powercap_sys.c
> >> +++ b/drivers/powercap/powercap_sys.c
> >> @@ -174,6 +174,10 @@ static ssize_t show_constraint_name(struct device *dev,
> >>                                                                  "%s\n", name);
> >>                          buf[POWERCAP_CONSTRAINT_NAME_LEN] = '\0';
> >>                          len = strlen(buf);
> >> +
> >> +                       /* When the 'name' is too long, don't lose new line */
> >> +                       if (strlen(name) >= POWERCAP_CONSTRAINT_NAME_LEN)
> >> +                               buf[POWERCAP_CONSTRAINT_NAME_LEN - 1] = '\n';
> >
> > Wouldn't it be better to pass POWERCAP_CONSTRAINT_NAME_LEN - 1 to
> > snprintf() above?
>
> My apologies for delay, I was on holidays.
>
> The snprintf() overwrites the '\n' in that case also.

The snprintf() doesn't do that AFAICS, but the next assignment
overwrites the newline with the zero character.

Anyway, it should have been POWERCAP_CONSTRAINT_NAME_LEN - 2, because
it needs to leave space for 2 characters, the newline and the
terminating zero.

> I've experimented with it a bit more and tried to come with a bit 'cleaner' solution.
>
> What we are looking is probably: "%.*s\n" semantic.
> Another solution would be:
> ------------------------------8<---------------------------
>                  if (name) {
> -                       snprintf(buf, POWERCAP_CONSTRAINT_NAME_LEN,
> -                                                               "%s\n",
> name);
> -                       buf[POWERCAP_CONSTRAINT_NAME_LEN] = '\0';
> +                       sprintf(buf, "%.*s\n",
> POWERCAP_CONSTRAINT_NAME_LEN -1,
> +                               name);
>                          len = strlen(buf);
>                  }
>
> ----------------------------->8----------------------------
>
> I've check this and it behaves very well.
>
> It looks cleaner and it is a used pattern in the kernel.
> What do you think? Is it good for v2?

This works for me too.

Thanks!
