Return-Path: <linux-pm+bounces-23980-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62A4A5F602
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 14:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DAE0188B459
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463C2265610;
	Thu, 13 Mar 2025 13:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4LJjbsC"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC78DDDC;
	Thu, 13 Mar 2025 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872786; cv=none; b=RJiXRLgxQpfcIKozt5HmKdXxQvPnAx+/Cjd8nFVcFGJvpXhndwylDi007lvJc5lPj8ge1utFJGwwlsfUUqXf/MDGbczhb8KcOULvQNBsxTgWiel2sccBXw/4YN5Qyj42nqbEjZ6s7PIS5iPoUncdg53vkXQBbtkIQALy3tI/ljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872786; c=relaxed/simple;
	bh=XuNfwVZH74W5UU9BfBiDYpp8IqrD1Na93CcN16Z/tIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yq7VwXgIm+p/fCilYleDSFgOBwE4h+voyXFSY2e3hy97vJ4BvONKt48IecdKx6lMjDbp7t2+ZDUu3745UPJ5WhwMxJyzQElV9R7dbQK/MBjLTK4DrAXEemDHr9XwVnqBY6yLQi26KsWtU+0Xdr5pc3QitrzaGZnKvYZvVDL9/aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4LJjbsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91333C4CEEF;
	Thu, 13 Mar 2025 13:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741872785;
	bh=XuNfwVZH74W5UU9BfBiDYpp8IqrD1Na93CcN16Z/tIM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I4LJjbsCY9PGv7Jvw7YhXMc1fvi5lZ+b5uYPmwu1smKYPlPLICoO+nSwJ//+/Y10/
	 5U1IeG1X2q+OhMpWOmfl2/+YpP583aHZqxduHUP/z+80UpFsBckB76iXxiVAbrFBVM
	 8aA/L0uKKUe04NBIM+gbeAcEogjWf9CH99qqld6W+gCDGScuCfg8gXUeNOdhxwMBIV
	 mYrqV82etsAubzhkxLxBt8yIe1CE1KEYCZv3F+M8g5CM5YdE4EbJb2KcY0qSbydgJD
	 WtASrHvxzXB6566M98W7UyFl0lZgj4MUvm0tRXAyTXaWT3X+K/A8QDKvhHO4gjWYmJ
	 xg99R2cnA6m9Q==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2bcc0c6c149so973768fac.1;
        Thu, 13 Mar 2025 06:33:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkoHlLKpR1zABNy6w+RC4fBYAWCZtrbtk6JiWpkZow/YYGrd3PuxP1kaFlrNMNry2Z4ZUAf7IzyVgdyr0=@vger.kernel.org, AJvYcCXyTaVdfOwlKwZqSoa9F5ObxsfZpil/dW6mmhKVaSuSBrgR5pbj0DPbkZDsmTgg3zI5GYXzG30VhO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7V5Mf/bc6Xc99GLQAYNyjTLt4hWTWSGnkSNr9wCS275HgUdUe
	EGf37I0oqQeoy9B8A23S3JVrSo8BPbhbErpuMShEYupXK5ztim/gQqdrDSvfMIqoKaA/+7YjfcM
	wtIu6QZRywMzl7KHN8bW6zhAZplk=
X-Google-Smtp-Source: AGHT+IGkPwuAC9RvVaAjV7Vla8jW9hy4OPGMSPR+shxk7LKgl53PqLOuTMaknbmPrrhzKzhepZMWcCWlXloQ9uFPw+8=
X-Received: by 2002:a05:6871:109:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2c261304b27mr15019905fac.30.1741872784779; Thu, 13 Mar 2025
 06:33:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <2016539.usQuhbGJ8B@rjwysocki.net>
 <CAGETcx8WOezY5-MePZ8X8f7_deys1eB-VvQLQwUPtd5MO8ApSA@mail.gmail.com>
In-Reply-To: <CAGETcx8WOezY5-MePZ8X8f7_deys1eB-VvQLQwUPtd5MO8ApSA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 14:32:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hghyWwd_kZXS1+9pD+DkWiP_4MYORryvkhmFoqayQVaw@mail.gmail.com>
X-Gm-Features: AQ5f1JpYFF509PP0Fu3AHxgL1jmkJIzqwRhd-FBPM-1QI89Z0k3rbdYuPNlRmY4
Message-ID: <CAJZ5v0hghyWwd_kZXS1+9pD+DkWiP_4MYORryvkhmFoqayQVaw@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] PM: sleep: Make late and noirq suspend of devices
 more asynchronous
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:47=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In analogy with previous changes, make device_suspend_late() and
> > device_suspend_noirq() start the async suspend of the device's parent
> > and suppliers after the device itself has been processed and make
> > dpm_suspend_late() and dpm_noirq_suspend_devices() start processing
> > "async" leaf devices (that is, devices without children or consumers)
> > upfront because they don't need to wait for any other devices.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c |   60 +++++++++++++++++++++++++++++++++++++=
++-------
> >  1 file changed, 52 insertions(+), 8 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1317,6 +1317,8 @@
> >         device_links_read_unlock(idx);
> >  }
> >
> > +static void async_suspend_noirq(void *data, async_cookie_t cookie);
> > +
> >  /**
> >   * device_suspend_noirq - Execute a "noirq suspend" callback for given=
 device.
> >   * @dev: Device to handle.
> > @@ -1396,7 +1398,13 @@
> >  Complete:
> >         complete_all(&dev->power.completion);
> >         TRACE_SUSPEND(error);
> > -       return error;
> > +
> > +       if (error || async_error)
> > +               return error;
> > +
> > +       dpm_async_suspend_superior(dev, async_suspend_noirq);
> > +
> > +       return 0;
> >  }
> >
> >  static void async_suspend_noirq(void *data, async_cookie_t cookie)
> > @@ -1410,6 +1418,7 @@
> >  static int dpm_noirq_suspend_devices(pm_message_t state)
> >  {
> >         ktime_t starttime =3D ktime_get();
> > +       struct device *dev;
> >         int error =3D 0;
> >
> >         trace_suspend_resume(TPS("dpm_suspend_noirq"), state.event, tru=
e);
> > @@ -1419,15 +1428,28 @@
> >
> >         mutex_lock(&dpm_list_mtx);
> >
> > +       /*
> > +        * Start processing "async" leaf devices upfront because they d=
on't need
> > +        * to wait.
> > +        */
> > +       list_for_each_entry_reverse(dev, &dpm_late_early_list, power.en=
try) {
> > +               dpm_clear_async_state(dev);
> > +               if (dpm_leaf_device(dev))
> > +                       dpm_async_fn(dev, async_suspend_noirq);
> > +       }
> > +
> >         while (!list_empty(&dpm_late_early_list)) {
> > -               struct device *dev =3D to_device(dpm_late_early_list.pr=
ev);
> > +               dev =3D to_device(dpm_late_early_list.prev);
> >
> >                 list_move(&dev->power.entry, &dpm_noirq_list);
>
> This issue is present in the previous patch too, but it's easier for
> me to point it out here. Suspend abort will break now.
>
> For example, say the devices are suspended in the order A -> B -> C ->
> D -> E if everything was sync.
>
> Case 1: Fully sync devices
> If C aborts, only A and B will be in the dpm_noirq_list. When we try
> to undo the suspend, we just resume devices in dpm_noirq_list and that
> just resumes A and B.
>
> Case 2: Only C is sync.
> When C aborts, A, B, D and E could have finished suspending. But only
> A and B will be in the dpm_noirq_list. When we try to undo the
> suspend, we just resume devices in dpm_noirq_list and that just
> resumes A and B. D and E never get resumed.
>
> My fix for this is to move all devices to dpm_noirq_list if a suspend
> aborts and then using the existing
> is_suspended/is_noirq_suspended/is_late_suspended flags to skip over
> devices that haven't been suspended. That works nicely except in
> is_suspended and I tried to fix it in [2]. But you had an issue with
> [2] that I didn't fully understand and I meant to dig deeper and fix.
> But I didn't get around to it as I got swamped with other work.
>
> [2] - https://lore.kernel.org/linux-pm/20241114220921.2529905-2-saravanak=
@google.com/

I hope that my last message in this thread clarifies this a bit.

Anyway, yes, this is a bug and yes, it can be addressed by just
continuing to move devices to the target list on errors until all of
them get moved and then look at
is_suspended/is_noirq_suspended/is_late_suspended.

I'll post a fix for the direct-complete handling in device_suspend()
and an update of the last three patches in this series with this issue
addressed.

