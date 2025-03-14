Return-Path: <linux-pm+bounces-24016-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF7CA60EB7
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 11:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FCA168612
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7921F3FE8;
	Fri, 14 Mar 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqjRN4/G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50962225D6;
	Fri, 14 Mar 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947819; cv=none; b=X0i4pZR8TqlixPKshpErC2GQILdYFEzUgJjiklWd9gJrpcTSy+ycigNlqYGnTD7+3lBEigMhOWdrg+ixAVHBSU6UvZWmIPBtWz93sw+SoP/YlIwVnuNk+B2V8h6L8oCQdf4DNq44jfG5cbAXa8p9BVDV3ZcT0DafoFg7x7VLcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947819; c=relaxed/simple;
	bh=lj5uJnptNVaoOdSx44pcvrOUneRJmwrkp+iKA/Y9Lk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIa7wy5+FbmNcIVL9GCTUiHBtkWAT4BnNeSLhqiFR+UZVqheAQvkirImJ0AIGjBID0yBzEUl+sO/XR1vqv9+1WrYZzYSxCRWLl7jWYb6Sg+WxjAAsakM4LpxTqQttYPYHd5DIXivc1MvloPkO8MCh2MZzCXo3SMquB3btqZXA0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqjRN4/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C9EC4CEE9;
	Fri, 14 Mar 2025 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741947818;
	bh=lj5uJnptNVaoOdSx44pcvrOUneRJmwrkp+iKA/Y9Lk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eqjRN4/GK+Wlh9IEvadADt57LU0s5R0HVRDYxSxH5Eip/CC7GkIC1W9KUzIWyzHzQ
	 VcCwYMPfb6JvfN/eV9ZXiDWGNPTxKeOcKkCY5bOEQhgWXpjDAMTKuNaJ7L8mqPUEQO
	 4ZLJfMeLE/s/4Xni5MfnSnJN6R6q304xjB318KUOx212zglzdfdWruyWCqCH0INVSU
	 oHfnx5wZ9Tqx0PoWa/DHRwONKqWzupliQGW/IAXgD/m7Czt36ayV2XQT6l0LWO6HE4
	 v8PBM+i1WyOKroAJibFOb1p0syD7a8OWgdpWq5i9fT/B1l+jRB5cg368SOr2SLVA6a
	 b5l3V6wKVH4Ng==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-601a891ab8fso1331155eaf.1;
        Fri, 14 Mar 2025 03:23:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVv5T40LRtJu1jDB8z8ejxFKiqNC4pcl0Bo7zW0odphTjqzkQ50IYYPYqssSaC5YFibkFQ86iwkIsE=@vger.kernel.org, AJvYcCX4l7LqcnTPgpbHPBF4SXEfj5iDotqH5e/9ZkM1PWGbVc4a2/3pSYpAscAF2FO+mOt0E4rpmyv+kOAZjaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YweU5RNdVKgzKYpD7+uGoyKvilFG+AQUl+hNgyS7pC5+3t2Zxhk
	sM/LfJko/nhFAzw9rkPm2XID/zBPdwNVGyHNaRJXLUxfr1FSSdStquDpLRMfkuMuyWqHe6bVes7
	P+c54Lh92+21M+vz2UJsaYQC4Aao=
X-Google-Smtp-Source: AGHT+IEAREi8exi+WYGANeosKheiCMnk1rDBy233rwktSEWTur2fvYn6axffvUFyGi7383Vl9Kf7saoYvPXhHHzr6QE=
X-Received: by 2002:a4a:ea8e:0:b0:5fc:fa1b:a5c9 with SMTP id
 006d021491bc7-601dab9392dmr3483048eaf.1.1741947817977; Fri, 14 Mar 2025
 03:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1915694.tdWV9SEqCh@rjwysocki.net> <3271724.5fSG56mABF@rjwysocki.net>
 <CAGETcx8WwG96FEOyKR-qFA=S6GhpH-EKpVtghNtxt-CQ-3UB_g@mail.gmail.com> <CAJZ5v0j0kD_HjbVzHb7=5nEYx_5fzwoBupPBQs2Fpfzho_amfg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j0kD_HjbVzHb7=5nEYx_5fzwoBupPBQs2Fpfzho_amfg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Mar 2025 11:23:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0htBwvcTFYcLVYYQ0EfunHc3yebJFw2yCSS7Ch4R5XdjQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jo6FIgHgnjDaNpk7N6GX1GUsj4EgP27Z85S5-tOpB0CHS8g_4q3Fk80o50
Message-ID: <CAJZ5v0htBwvcTFYcLVYYQ0EfunHc3yebJFw2yCSS7Ch4R5XdjQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] PM: sleep: Suspend parents and suppliers after
 suspending subordinates
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 11:36=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.o=
rg> wrote:
>
> On Thu, Mar 13, 2025 at 10:17=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> >
> > On Thu, Mar 13, 2025 at 1:35=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > In analogy with the previous change affecting the resume path,
> > > make device_suspend() start the async suspend of the device's parent
> > > and suppliers after the device itself has been processed and make
> > > dpm_suspend() start processing "async" leaf devices (that is, devices
> > > without children or consumers) upfront because they don't need to wai=
t
> > > for any other devices.
> > >
> > > On the Dell XPS13 9360 in my office, this change reduces the total
> > > duration of device suspend by approximately 100 ms (over 20%).
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Suggested-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >
> > > v1 -> v2:
> > >    * Adjust for the changes in patch [1/3].
> > >    * Fix walking suppliers in dpm_async_suspend_superior().
> > >    * Use device links read locking in dpm_async_suspend_superior() (S=
aravana).
> > >    * Move all devices to the target list even if there are errors in
> > >      dpm_suspend() so they are properly resumed during rollback (Sara=
vana).
> > >
> > > ---
> > >  drivers/base/power/main.c |   78 +++++++++++++++++++++++++++++++++++=
+++++++----
> > >  1 file changed, 72 insertions(+), 6 deletions(-)
> > >
> > > --- a/drivers/base/power/main.c
> > > +++ b/drivers/base/power/main.c
> > > @@ -1231,6 +1231,50 @@
> > >
> > >  /*------------------------- Suspend routines -----------------------=
--*/
> > >
> > > +static bool dpm_leaf_device(struct device *dev)
> > > +{
> > > +       struct device *child;
> > > +
> > > +       lockdep_assert_held(&dpm_list_mtx);
> > > +
> > > +       child =3D device_find_any_child(dev);
> > > +       if (child) {
> > > +               put_device(child);
> > > +
> > > +               return false;
> > > +       }
> > > +
> > > +       /*
> > > +        * Since this function is required to run under dpm_list_mtx,=
 the
> > > +        * list_empty() below will only return true if the device's l=
ist of
> > > +        * consumers is actually empty before calling it.
> > > +        */
> > > +       return list_empty(&dev->links.consumers);
> > > +}
> >
> > We need the equivalent of this for resume.
>
> Maybe.
>
> > > +
> > > +static void dpm_async_suspend_superior(struct device *dev, async_fun=
c_t func)
> > > +{
> > > +       struct device_link *link;
> > > +       int idx;
> > > +
> > > +       mutex_lock(&dpm_list_mtx);
> > > +
> > > +       /* Start processing the device's parent if it is "async". */
> > > +       if (dev->parent)
> > > +               dpm_async_with_cleanup(dev->parent, func);
> > > +
> > > +       mutex_unlock(&dpm_list_mtx);
> > > +
> > > +       idx =3D device_links_read_lock();
> > > +
> > > +       /* Start processing the device's "async" suppliers. */
> > > +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> > > +               if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
> > > +                       dpm_async_with_cleanup(link->supplier, func);
> >
> > We should check that the rest of the consumers of the supplier are
> > "done" before we queue the supplier. With 386 device links (and the
> > number only increases as we add support for more properties), there's
> > no doubt that we'll hit this often.
>
> And I'm not doing this until I see any data confirming that it makes a
> difference in the order of 10% or more.
>
> > > +
> > > +       device_links_read_unlock(idx);
> >
> > Is passing idx to unlock a new (within the past 6 months) thing? I
> > don't remember having to do this in the past.
>
> It's SRCU and it's been there forever.
>
> > > +}
> > > +
> > >  /**
> > >   * resume_event - Return a "resume" message for given "suspend" slee=
p state.
> > >   * @sleep_state: PM message representing a sleep state.
> > > @@ -1656,6 +1700,8 @@
> > >         device_links_read_unlock(idx);
> > >  }
> > >
> > > +static void async_suspend(void *data, async_cookie_t cookie);
> > > +
> > >  /**
> > >   * device_suspend - Execute "suspend" callbacks for given device.
> > >   * @dev: Device to handle.
> > > @@ -1785,7 +1831,13 @@
> > >
> > >         complete_all(&dev->power.completion);
> > >         TRACE_SUSPEND(error);
> > > -       return error;
> > > +
> > > +       if (error || async_error)
> > > +               return error;
> > > +
> > > +       dpm_async_suspend_superior(dev, async_suspend);
> > > +
> > > +       return 0;
> > >  }
> > >
> > >  static void async_suspend(void *data, async_cookie_t cookie)
> > > @@ -1803,6 +1855,7 @@
> > >  int dpm_suspend(pm_message_t state)
> > >  {
> > >         ktime_t starttime =3D ktime_get();
> > > +       struct device *dev;
> > >         int error =3D 0;
> > >
> > >         trace_suspend_resume(TPS("dpm_suspend"), state.event, true);
> > > @@ -1816,12 +1869,28 @@
> > >
> > >         mutex_lock(&dpm_list_mtx);
> > >
> > > +       /*
> > > +        * Start processing "async" leaf devices upfront because they=
 don't need
> > > +        * to wait.
> > > +        */
> > > +       list_for_each_entry_reverse(dev, &dpm_prepared_list, power.en=
try) {
> > > +               dpm_clear_async_state(dev);
> > > +               if (dpm_leaf_device(dev))
> > > +                       dpm_async_with_cleanup(dev, async_suspend);
> > > +       }
> > > +
> > >         while (!list_empty(&dpm_prepared_list)) {
> > > -               struct device *dev =3D to_device(dpm_prepared_list.pr=
ev);
> > > +               dev =3D to_device(dpm_prepared_list.prev);
> > >
> > >                 list_move(&dev->power.entry, &dpm_suspended_list);
> > >
> > > -               dpm_clear_async_state(dev);
> > > +               /*
> > > +                * Move all devices to the target list to resume them=
 properly
> > > +                * on errors.
> > > +                */
> >
> > I did this initially on my end, but we have so many devices that
> > looping through them had a measurable impact.
>
> Which I guess is super-important for error handling.  Come on.
>
> > It's better to just splice the lists on error.
>
> On top of this change, yes.

Actually, adding a list_splice() after the error check would be a
simpler change than moving the check, so I'm doing this in v3.

