Return-Path: <linux-pm+bounces-18380-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C84E9E0D4D
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 21:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18EA2824CF
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 20:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0B21DEFE8;
	Mon,  2 Dec 2024 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZsg9OEK"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9411DEFD7
	for <linux-pm@vger.kernel.org>; Mon,  2 Dec 2024 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172405; cv=none; b=tCpl6B/A2IWqYxLmhZN4bRLcbINeT9o275x5Z0DwhN296u5Pg7NmPxbBnrwVuSJWsY+vf1J6rX9+T7j365g9D8ltKz4fgHlWnV2pzjLzYzr8l+QJ1bqWEhe4lLScP+FMdy0nZgbbJ2DKMRnxC2fgMD+AJxP5abaqLiKdBivJ4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172405; c=relaxed/simple;
	bh=gpQDTaUDXioVSQoXwf8rUE58NyhdI6ghxZVzLikcv3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRkdLDcg2hNYHIK7vErnUIEX8D868QiaWRNCf6VakISWArRPjEwxDMhTJScqJnmMZyc9rijZt37Gs5QlV0uXbjiVeClLL/odRCmUefuGixvgNu5hRF8NBuoj0/7lXeCYh4djfeiowdEiwVxJKEgrpWwTz8AHkls5zw5M9bdzizU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZsg9OEK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de101525eso5589986e87.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Dec 2024 12:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733172401; x=1733777201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQDsuIpso/UbLGWdQzuPlRVvn4WD82/6XUl5my8MyLU=;
        b=MZsg9OEKovg75zX0vDGf5IkgVJwVq0Y2CpIzl2b5iR3TiVgWmtb8Ls/JoOIjhQ+bjy
         7kyGpkCsavb2ddgGXpSuLXs5FMSrb2X9p7T/LP4r3urC6us3LoT/47xFOzbTz+LViwOE
         Z1LOzPRr06gTAmSCyS3PwPykurrputyeezjlvPbU88Aem4vv+fp67/1+PdxT1E4wxQrE
         klsP4qDjPCHyYc36aR0YTg/U/hmisXgDRWE2xiDpO6dbUND07eUe9yEa7y89FMOQxLgN
         hb7aYY6sqLHqd0K/8ppk19CIhqbKUk6nRjlK6TbPLN3PuVuw9d6JR9MPTHEmQCMhyGMO
         A/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172401; x=1733777201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQDsuIpso/UbLGWdQzuPlRVvn4WD82/6XUl5my8MyLU=;
        b=UCkLEsEDlfGQl+xHcFUTXlAzDX/rbPkoYkLCmccsuYjJIPb3/3OESiPk1mCHZS75y6
         wd6a/yEJRqGWROc7bERCcQG2vK6LSTVOMvW9qx7puwt64ikZidfaTZ8s1v6nshS8Q40d
         gbm0uNw0i0G7lYScn95D+wQaZjarBoSLNrVLXzShqb7LTkWkh1k47oX9WQZtLmwUmtYG
         ipx9F1heQQEIY5pKZJsVtsEyw15qOLRQQ2QQb4oVIA+rFtu9wkus7Um1a9oh6d9FqO5/
         2edClqe5yZ78Q5VpHjVQ7dPejwMa+YH1ZcUneGnsZ3iYZVhgjuEfTBeZ7Clg59hwOoHb
         Dp1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKMSen4mlesvNoMs7M+fPZYfDRFuu4kKIeE+APKmSxvCoIgUMn1ieoubcf6xeCa97gI5g4jeB6MA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyzIoR2bH3ua2OgYUIrJGUij4c46OU8mWCQPgVy9EEaIkfVxfz
	TkKia1ts1tDZSXI0fNmWLG/0ZpHYDu9TO8lhtCssNMs94rbERgnysAeuXH4JMBNM+/8I0+8IvL1
	quMpG88ALXP/Jrirbz7W0ajxHNaru+0zQnVc2
X-Gm-Gg: ASbGncvTj5M+iARZE2lNxAPT5775ai+5j15RKWrU0qTr7wSiw2a+o7lwaXwkrsPK4fe
	GCvoN5I6vuqxaYA9FlTUy7YljTKV/Ng==
X-Google-Smtp-Source: AGHT+IFsTFrXH9qXIvbbF1A86M8pqhuoPiSNGuznrXJ3e3Vlur9/11zUAXvb70+he32ybMv+AbNz17Ewc1dbGT/b1SE=
X-Received: by 2002:a05:6512:3b8e:b0:53d:f379:2b64 with SMTP id
 2adb3069b0e04-53df5065d9amr7829547e87.11.1733172400486; Mon, 02 Dec 2024
 12:46:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-3-saravanak@google.com> <CAJZ5v0jPO24JR5um0gv5U5AwiR_RHx37x6DisG-nUxaZt9gfGA@mail.gmail.com>
 <CAJZ5v0iLq9L5nMp13BrBmbWavFs1ZEAtJ-WeyRzv3D2GXPNuag@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLq9L5nMp13BrBmbWavFs1ZEAtJ-WeyRzv3D2GXPNuag@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 2 Dec 2024 12:46:06 -0800
Message-ID: <CAGETcx-9XSdXcuGQFSoS-mMPwp=UJ3_FfTJ1Cx+9jddyjYTKEg@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] PM: sleep: Remove unnecessary mutex lock when
 waiting on parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 12:16=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Mon, Dec 2, 2024 at 9:11=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
> >
> > Sorry for the delay.
> >
> > On Thu, Nov 14, 2024 at 11:09=E2=80=AFPM Saravana Kannan <saravanak@goo=
gle.com> wrote:
> > >
> > > Locking is not needed to do get_device(dev->parent). We either get a =
NULL
> > > (if the parent was cleared) or the actual parent. Also, when a device=
 is
> > > deleted (device_del()) and removed from the dpm_list, its completion
> > > variable is also complete_all()-ed. So, we don't have to worry about
> > > waiting indefinitely on a deleted parent device.
> >
> > The device_pm_initialized(dev) check before get_device(dev->parent)
> > doesn't make sense without the locking and that's the whole point of
> > it.
>
> Hmm, not really.
>
> How is the parent prevented from going away in get_device() right
> after the initial dev check without the locking?

Not sure what you mean by "go away"? But get_device() is going to keep
a non-zero refcount on the parent so that struct doesn't get freed.
The parent itself can still "go away" in terms of unbinding or
removing the children from the dpm_list(). But that's what the
device_pm_initialized() check is for. When a device_del() is called,
it's removed from the dpm_list. The actual freeing comes later. But we
aren't/weren't checking for that anyway.

>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/power/main.c | 13 ++-----------
> > >  1 file changed, 2 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > > index 86e51b9fefab..9b9b6088e56a 100644
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -284,18 +284,9 @@ static bool dpm_wait_for_superior(struct device =
*dev, bool async)
> > >          * counting the parent once more unless the device has been d=
eleted
> > >          * already (in which case return right away).
> > >          */
> > > -       mutex_lock(&dpm_list_mtx);
> > > -
> > > -       if (!device_pm_initialized(dev)) {
> > > -               mutex_unlock(&dpm_list_mtx);
> > > -               return false;
> > > -       }
> > > -
> > >         parent =3D get_device(dev->parent);
> > > -
> > > -       mutex_unlock(&dpm_list_mtx);
> > > -
> > > -       dpm_wait(parent, async);
> > > +       if (device_pm_initialized(dev))
> > > +               dpm_wait(parent, async);
> >
> > This is racy, so what's the point?
> >
> > You can just do
> >
> > parent =3D get_device(dev->parent);
> > dpm_wait(parent, async);

Parent struct device being there isn't the same as whether this device
is in the dpm_list? So, shouldn't we still check this?

Also, is it really racy anymore with the new algorithm? We don't kick
off the subordinates until after the parent is done.

> >
> > and please update the comment above this.

Will do.

Thanks,
Saravana
> >
> > >         put_device(parent);
> > >
> > >         dpm_wait_for_suppliers(dev, async);
> > > --

