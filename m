Return-Path: <linux-pm+bounces-23982-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9EA5F6EE
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 14:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2000C19C1798
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A824267F48;
	Thu, 13 Mar 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaHSDJaT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AC9267B9E;
	Thu, 13 Mar 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741874014; cv=none; b=IXdGgsUEJ25I5duNbLDUPF8Q2EELEOtQK7gCE2ZS5n6Ez+E9U6IiSAbXnF8MBpXOoPWryoVXHDDMKwgQXUjMnDBlXg9BXU4Ros6bOy55P7Ivx1OhSWKjglfCJ5cjqg28h31c3U6hL74tvfFV0PY/VwdZQT/RdRqVL4fjCscHyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741874014; c=relaxed/simple;
	bh=afG8ErUTyzCckDQ7YlC8icu58WBVaxRaft+LAGp85eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENBsCZTFxxxJgxIzkutR4iwhSUUAsvQZywdN09iuMnXlgTX0mQakL6uBJ+w4Z/p9rCdUpiVL3UlH6aeK3h6UCzFikk5X8bhzwmqEAPeixUIS81ExkUBzJARaKH/Gt05em0COBbsMMJmbUC8eXcRZtHl0NDKOYwhtHMmdDoQbDNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaHSDJaT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A73C4CEEE;
	Thu, 13 Mar 2025 13:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741874014;
	bh=afG8ErUTyzCckDQ7YlC8icu58WBVaxRaft+LAGp85eI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GaHSDJaTrTOjoD6gFed/cXh28c759EkgLnD1xusnG4qijOMghCHhhrTGQjXUfIVmP
	 TSIIlJJC5nUe95oXRWc95JbQqdiyw0ohZSjeIQnw8H049r/dj8Jme3hmc6otdb7LZI
	 wrwPwtnTIhhdxD3Dr2EY4KRFFca5LCV6WYSsp6+dexeeH4rBEOhdqp1NnSnDvS/y58
	 JuJAZWVtnXQp9S/K0O5Ato9LeIECIXXiUooGYgmHtdlaS2RWIv1NQZmO4FpxmP97vM
	 QqSlXtnRpQ6//SAD7ase0A+M08sxHaR50K6Jq8V3VeRi9KEM8rnJuS602Nl950eo7s
	 aLu6Z5T0jCffw==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-72b82c8230aso277545a34.2;
        Thu, 13 Mar 2025 06:53:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVo8Jk7avgu0oOSmt84Jnl4DlxqVXO3szKuDOg38QLejfQgg+hIzOpDpBKLYJ2Ub/QCA5o5ZIKvpDL5ClU=@vger.kernel.org, AJvYcCVvtyqLuGEaqSiHnDXANxO4ORc3H5MHZlztvUcqm3/awldNd7qOqghq0QuskgPeekRvXWD+IJpEGq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ5b1nSJYRJbqIdBbdaG9tI1DZlbEa4WwJNTactEz17FV16Sep
	qXJhniToGnq++9RhDLqo/YlaKoKlunhMD1XKDNEBwCK4dwLTw5eh/h2wWy8+Z2vW/otKUwo0slt
	iQrPq4Tua1Q0bvn2JZlCGBy8iV7c=
X-Google-Smtp-Source: AGHT+IGWUoBoPeKia4EF2SLlkdg5X+uVchvj236I0mAyiYuErdeP68j9qBAieXuHV9MMDaWnQk0Jw9L5V/0WRu0lvAE=
X-Received: by 2002:a05:6870:498a:b0:29e:3bea:7e67 with SMTP id
 586e51a60fabf-2c2e89c8b02mr6375207fac.38.1741874013334; Thu, 13 Mar 2025
 06:53:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <8536271.NyiUUSuA9g@rjwysocki.net>
 <CAGETcx8htyu635DhuE_+2X7RzwBwcvT7Wdkh9RL7Zswf1B079A@mail.gmail.com>
In-Reply-To: <CAGETcx8htyu635DhuE_+2X7RzwBwcvT7Wdkh9RL7Zswf1B079A@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 14:53:21 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iDW0kkaGprMO84oR8rdvjWGeXAupcQ6iAnqqajYDdOAg@mail.gmail.com>
X-Gm-Features: AQ5f1JoGY24Vk4K8hNB62SwhxbieztK6kubBSXGGyqZhGgm-DPs5BkfKXiitBGk
Message-ID: <CAJZ5v0iDW0kkaGprMO84oR8rdvjWGeXAupcQ6iAnqqajYDdOAg@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] PM: sleep: Start suspending parents and suppliers
 after subordinate suspend
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
> > In analogy with the previous change affecting the resume path,
> > make device_suspend() start the async suspend of the device's parent
> > and suppliers after the device itself has been processed and make
> > dpm_suspend() start processing "async" leaf devices (that is, devices
> > without children or consumers) upfront because they don't need to wait
> > for any other devices.
> >
> > On the Dell XPS13 9360 in my office, this change reduces the total
> > duration of device suspend by approximately 100 ms (over 20%).
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/base/power/main.c |   73 +++++++++++++++++++++++++++++++++++++=
++++++---
> >  1 file changed, 69 insertions(+), 4 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1237,6 +1237,49 @@
> >
> >  /*------------------------- Suspend routines -------------------------=
*/
> >
> > +static bool dpm_leaf_device(struct device *dev)
> > +{
> > +       struct device *child;
> > +
> > +       lockdep_assert_held(&dpm_list_mtx);
> > +
> > +       child =3D device_find_any_child(dev);
> > +       if (child) {
> > +               put_device(child);
> > +
> > +               return false;
> > +       }
> > +
> > +       /*
> > +        * Since this function is required to run under dpm_list_mtx, t=
he
> > +        * list_empty() below will only return true if the device's lis=
t of
> > +        * consumers is actually empty before calling it.
> > +        */
> > +       return list_empty(&dev->links.consumers);
> > +}
> > +
> > +static void dpm_async_suspend_superior(struct device *dev, async_func_=
t func)
> > +{
> > +       struct device_link *link;
> > +
> > +       mutex_lock(&dpm_list_mtx);
> > +
> > +       /* Start processing the device's parent if it is "async". */
> > +       if (dev->parent)
> > +               dpm_async_unless_in_progress(dev->parent, func);
> > +
> > +       /*
> > +        * Start processing the device's "async" suppliers.
> > +        *
> > +        * The dpm_list_mtx locking is sufficient for this.
> > +        */
>
> Why is dpm_list_mtx sufficient? Is it because you are assuming no
> driver is trying to change the device links during suspend/resume? Or
> is there some other reason?

dpm_list_mtx is acquired in device_link_add(), so no new links can be
added while this code is running, and list_del_rcu() is safe with
respect to list_for_each_entry_rcu() according to its kerneldoc
comment.

Worst case it will start async processing for a device that is going
away which should be handled cleanly.

> That sounds a bit risky. Is it because if
> you do, you'll hit a AB-BA deadlock or at least a lockdep warning?
> Also, if we can use the device links read locks, we won't block the
> other readers -- so, less contention.

Readers are not blocked regardless, writers are.

> > +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
> > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > +                       dpm_async_unless_in_progress(link->consumer, fu=
nc);

Oh, the above is actually broken.  It should be

list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
        if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
                dpm_async_unless_in_progress(link->supplier, func);

shouldn't it?

I need to fix this.

> This will still queue a lot of devices that can't suspend yet.

I'm not sure what you mean by "a lot"?  This is only going to queue
the suppliers of this particular device.  How many of those could be
there?

> Curious, how many devices do you have in the system where you are testing=
 this?

Around 1500 device objects, and the majority of them have parents and
children, but there are only a few device links.

Thanks!

