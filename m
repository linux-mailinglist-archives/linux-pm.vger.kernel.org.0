Return-Path: <linux-pm+bounces-24006-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC8A60471
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 23:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B2C3A5E01
	for <lists+linux-pm@lfdr.de>; Thu, 13 Mar 2025 22:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C796B1F872D;
	Thu, 13 Mar 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF3SgeJ1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5651F8721;
	Thu, 13 Mar 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905376; cv=none; b=i1C3TQMAe9AW2Pue6WRT5jQfJHEAkXI66G5HoQidSZt7ngU94xFuf8O4r3rmZ4PzzJzvPGj9ncm5kF3sbb9yTa3XblHHIXt04OGCpJHReL2+Of/VtUIsWhp5XyVbJE4KSlbNa3XxTJLCMRjwJ3Lo2ee0Z43oQ7PpbmMkANSOhw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905376; c=relaxed/simple;
	bh=TWaPls6LeWf6dTny1hQOf8nsOaK1A9CxcB8A/zdVsrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1qC05qT8M54lcoNCYnbOYBKRUznzjDmwx9NWDnnhiaShWL3x3yZnLWEV+0H1rx3YqJghlBV9H6CIQC40ogzdbtD5NK9WwJLrWtlwTGHMRmqnUeohxJQwGmoL+lyYN7fkxbFOQ3D9BT0gtAd73YxJGHX7wVBa3xzRr+M6MRuM+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF3SgeJ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBDFC4CEF0;
	Thu, 13 Mar 2025 22:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741905376;
	bh=TWaPls6LeWf6dTny1hQOf8nsOaK1A9CxcB8A/zdVsrU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bF3SgeJ13m0n3jXgo8FHGE4dSGdPf7G4FfvO4E4U1e8+VsSh+gl7RxL/9DulOFo/M
	 RIpbqFTi6CQNl/7aVnnAZubG3eUh+5Tia7ZZojG7VqBxJtcq7DNmmbKCqKp1tP1qZS
	 5tKKsw1BVKiOMC9ScijwPBVxkSQ9uUQYBofR4UsBP2nixOd4pEjcrdUuWdhSoKpvNm
	 /qhbKQXVhyKXwPBfRTOKmwQyd6GJ9wHcXj7JPOO0nzPrwbm1MmlhmBSQsvfdwaX/QX
	 ugH+sOD2WET1ytAzBjXBpGVkbO+f+BDeqPvQqbbDNa/fODgp9XTovzD25/CMsAi7Wy
	 /Pe6SQ1wsrgYQ==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c2504fa876so487166fac.0;
        Thu, 13 Mar 2025 15:36:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHVNh/nj6iJcVKjPOOVI7XbAmlRjRBlmAi4lyPhHlcFo4uVPiHU1we+yeVjBqTVC/yDuIHQrYwg7isbi0=@vger.kernel.org, AJvYcCVMlKZyTt8wJoI5+rvWq1QVI7XBD4LYHTHKjAUEKblX8j7FYBZTWUQLeg1+7/sXJfrxgGulbc1lDLI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8T/8Ea9iJ0WRAxw+KI4Lpjl+n6hCuCPJ8M2gRVP9cqKQ2gEbN
	Bg3ciiMR/RPTV+zvtfxmJFq7Awb1OdLTA4EQN8Dd554ZgHbo3AJni4dSO2SmPwAJFnyCJY8bZkf
	WNK5GxJjAcRweb+15eCT6dLNrblc=
X-Google-Smtp-Source: AGHT+IGqdyI0yv7lmMd4g8gy1gwTrHv2GtFFQC2VWDk8SLMoUWVy+abKQXhnQtDZXihqEhPV6VFCLVYVHKw2ltFYIIQ=
X-Received: by 2002:a05:6870:4943:b0:29e:671b:6003 with SMTP id
 586e51a60fabf-2c6912275b1mr179213fac.32.1741905375273; Thu, 13 Mar 2025
 15:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1915694.tdWV9SEqCh@rjwysocki.net> <3271724.5fSG56mABF@rjwysocki.net>
 <CAGETcx8WwG96FEOyKR-qFA=S6GhpH-EKpVtghNtxt-CQ-3UB_g@mail.gmail.com>
In-Reply-To: <CAGETcx8WwG96FEOyKR-qFA=S6GhpH-EKpVtghNtxt-CQ-3UB_g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 13 Mar 2025 23:36:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j0kD_HjbVzHb7=5nEYx_5fzwoBupPBQs2Fpfzho_amfg@mail.gmail.com>
X-Gm-Features: AQ5f1JqGO9urv6h6LSsL5_fBZW8vlWhPh6b43YVtEZRQvEkAFjVW4Sr1oS6dPK4
Message-ID: <CAJZ5v0j0kD_HjbVzHb7=5nEYx_5fzwoBupPBQs2Fpfzho_amfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PM: sleep: Suspend parents and suppliers after
 suspending subordinates
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:17=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Thu, Mar 13, 2025 at 1:35=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.=
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
> > Suggested-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > v1 -> v2:
> >    * Adjust for the changes in patch [1/3].
> >    * Fix walking suppliers in dpm_async_suspend_superior().
> >    * Use device links read locking in dpm_async_suspend_superior() (Sar=
avana).
> >    * Move all devices to the target list even if there are errors in
> >      dpm_suspend() so they are properly resumed during rollback (Sarava=
na).
> >
> > ---
> >  drivers/base/power/main.c |   78 +++++++++++++++++++++++++++++++++++++=
+++++----
> >  1 file changed, 72 insertions(+), 6 deletions(-)
> >
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -1231,6 +1231,50 @@
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
>
> We need the equivalent of this for resume.

Maybe.

> > +
> > +static void dpm_async_suspend_superior(struct device *dev, async_func_=
t func)
> > +{
> > +       struct device_link *link;
> > +       int idx;
> > +
> > +       mutex_lock(&dpm_list_mtx);
> > +
> > +       /* Start processing the device's parent if it is "async". */
> > +       if (dev->parent)
> > +               dpm_async_with_cleanup(dev->parent, func);
> > +
> > +       mutex_unlock(&dpm_list_mtx);
> > +
> > +       idx =3D device_links_read_lock();
> > +
> > +       /* Start processing the device's "async" suppliers. */
> > +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > +                       dpm_async_with_cleanup(link->supplier, func);
>
> We should check that the rest of the consumers of the supplier are
> "done" before we queue the supplier. With 386 device links (and the
> number only increases as we add support for more properties), there's
> no doubt that we'll hit this often.

And I'm not doing this until I see any data confirming that it makes a
difference in the order of 10% or more.

> > +
> > +       device_links_read_unlock(idx);
>
> Is passing idx to unlock a new (within the past 6 months) thing? I
> don't remember having to do this in the past.

It's SRCU and it's been there forever.

> > +}
> > +
> >  /**
> >   * resume_event - Return a "resume" message for given "suspend" sleep =
state.
> >   * @sleep_state: PM message representing a sleep state.
> > @@ -1656,6 +1700,8 @@
> >         device_links_read_unlock(idx);
> >  }
> >
> > +static void async_suspend(void *data, async_cookie_t cookie);
> > +
> >  /**
> >   * device_suspend - Execute "suspend" callbacks for given device.
> >   * @dev: Device to handle.
> > @@ -1785,7 +1831,13 @@
> >
> >         complete_all(&dev->power.completion);
> >         TRACE_SUSPEND(error);
> > -       return error;
> > +
> > +       if (error || async_error)
> > +               return error;
> > +
> > +       dpm_async_suspend_superior(dev, async_suspend);
> > +
> > +       return 0;
> >  }
> >
> >  static void async_suspend(void *data, async_cookie_t cookie)
> > @@ -1803,6 +1855,7 @@
> >  int dpm_suspend(pm_message_t state)
> >  {
> >         ktime_t starttime =3D ktime_get();
> > +       struct device *dev;
> >         int error =3D 0;
> >
> >         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
> > @@ -1816,12 +1869,28 @@
> >
> >         mutex_lock(&dpm_list_mtx);
> >
> > +       /*
> > +        * Start processing "async" leaf devices upfront because they d=
on't need
> > +        * to wait.
> > +        */
> > +       list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entr=
y) {
> > +               dpm_clear_async_state(dev);
> > +               if (dpm_leaf_device(dev))
> > +                       dpm_async_with_cleanup(dev, async_suspend);
> > +       }
> > +
> >         while (!list_empty(&dpm_prepared_list)) {
> > -               struct device *dev =3D to_device(dpm_prepared_list.prev=
);
> > +               dev =3D to_device(dpm_prepared_list.prev);
> >
> >                 list_move(&dev->power.entry, &dpm_suspended_list);
> >
> > -               dpm_clear_async_state(dev);
> > +               /*
> > +                * Move all devices to the target list to resume them p=
roperly
> > +                * on errors.
> > +                */
>
> I did this initially on my end, but we have so many devices that
> looping through them had a measurable impact.

Which I guess is super-important for error handling.  Come on.

> It's better to just splice the lists on error.

On top of this change, yes.

