Return-Path: <linux-pm+bounces-34008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87800B46135
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FDCD5C7AEF
	for <lists+linux-pm@lfdr.de>; Fri,  5 Sep 2025 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D4430B534;
	Fri,  5 Sep 2025 17:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuXHWQHE"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9CE2D6E70;
	Fri,  5 Sep 2025 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757094874; cv=none; b=tup4vyGOtziGAs2jtIyZ4X+fRPk3Vq23tTwqRD3TEgUfVSKvFwGl3fxHOAVRXnuziRKtsBFQIVprMbv16AQmJRyiMosk3VZaq45qngwpjPRoRB9x8Zh7KpTP3QEGStVuu9IhKlqVL4w84uVdR4w1h6GdGHhHhWuY+XiOWCGBCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757094874; c=relaxed/simple;
	bh=1eE2jhr0Y52YKKYcUuQR/z3MTq31ALXL7VwO5dyTfD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xf4jEHoi0icpxlLC/FtQXL51OJk1+G/p7pmKEGk17XWt8wx1Re4zvk7mv9hg+Hz5LoZG8UN8wT8gXt0XciWQxS1vuPjmvneOMz7WtFLpVmVrRqpUAv9Ap/ThbO0ZWaQ6XHHxS9Brp9GRjOtQHTXMtlwPASE6AIhPk9Vb/h7vCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuXHWQHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46318C4CEF1;
	Fri,  5 Sep 2025 17:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757094874;
	bh=1eE2jhr0Y52YKKYcUuQR/z3MTq31ALXL7VwO5dyTfD4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NuXHWQHE9Mfky4cwNGYJ1EbvEj+KFcMBdK0lO7arG6FcAKeGzW0LFe5YLY5smRwXX
	 ZJQ5dpAxiTVyckQ/gf3HUFzsYQ/AKl64G9y88ljg7DJ6PMCnugpLPiHn4Geak/yRGw
	 HXn/Jluoej4D5kZ/wkS7RiHXfaTPx1FyHJkwpjmhoCsw9lWQpV8TFafZWh/qC0lSB0
	 KdBDYGWsPx1BmeXzkLETlyFSmXg/sXnwCjoWX/Y2yI+eipj/j+jMQ2Eh3wgHqz8jqN
	 BVFFLNV9aReoF1/jyvq8NKUKPLPFyO6Zb+AjM/90QxvwV7UvViQPefnhD4NZdPptTk
	 Tj8kD0puBUqcQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7456d2b49f5so1460819a34.0;
        Fri, 05 Sep 2025 10:54:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1lXxSyCzHBrE+bNxyN0NgGhEX0z2Sd0Wa2sJg13xr1CqXXiKXBVrDnvzMuin5k5YmK1m5tVA9UJI=@vger.kernel.org, AJvYcCXTZg8gWC7kvklQtGofvedfLjR5U4Pwcm1o/B021wj2ZJwY5NjruO1mV0Vhxi47USLEZSJnBU8bgta0GWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw77qRJaNqEkF/q4a0eGUh7A5HAOJPzIvNVmhkaTIrJetJBpNA/
	xu6Q0nCedKHslcL5MNZJKzivAojzUd4yMb4o2a/LB4OUWQzCxSBYRi+SZlUNeyW2za7vYrfZoh/
	kpqmvUYII8+p8jz5vtYAABG7WVufZYj0=
X-Google-Smtp-Source: AGHT+IHk1wY2jk7XGpkqUQtiw2DFn3VzJDaRDS9BrPYjqArmPtF6luBZ8Ju/nOPsQXcjWq2KSGSTNWDsWx2bkV7yft8=
X-Received: by 2002:a05:6830:60d0:20b0:746:d4cf:b499 with SMTP id
 46e09a7af769-746d4cfb5a8mr2607665a34.26.1757094873514; Fri, 05 Sep 2025
 10:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829003319.2785282-1-briannorris@chromium.org>
 <20250829003319.2785282-3-briannorris@chromium.org> <aLaaLc0TPhtm-H5j@kekkonen.localdomain>
In-Reply-To: <aLaaLc0TPhtm-H5j@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 19:54:21 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJaXog5uWfaL1qf97ts_i42PbjK4F28M+UvDBO97wX0w@mail.gmail.com>
X-Gm-Features: Ac12FXxg9o3QOEYXKKKQov78TEE_juEFNRfDYt723nUdHoEO8U6PReNlAnuMeng
Message-ID: <CAJZ5v0iJaXog5uWfaL1qf97ts_i42PbjK4F28M+UvDBO97wX0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] PM: runtime: Update kerneldoc return codes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Brian Norris <briannorris@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, 
	kunit-dev@googlegroups.com, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 9:18=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Brian,
>
> Thanks for posting this. A few comments below.
>
> On Thu, Aug 28, 2025 at 05:28:28PM -0700, Brian Norris wrote:
> > APIs based on __pm_runtime_idle() (pm_runtime_idle(), pm_request_idle()=
)
> > do not return 1 when already suspended. They return -EAGAIN. This is
> > already covered in the docs, so the entry for "1" is redundant and
> > conflicting.
> >
> > (pm_runtime_put() and pm_runtime_put_sync() were previously incorrect,
> > but that's fixed in "PM: runtime: pm_runtime_put{,_sync}() returns 1
> > when already suspended", to ensure consistency with APIs like
> > pm_runtime_put_autosuspend().)
> >
> > RPM_GET_PUT APIs based on __pm_runtime_suspend() do return 1 when
> > already suspended, but the language is a little unclear -- it's not
> > really an "error", so it seems better to list as a clarification before
> > the 0/success case. Additionally, they only actually return 1 when the
> > refcount makes it to 0; if the usage_count is still non-zero, we return
> > 0.
> >
> > pm_runtime_put(), etc., also don't appear at first like they can ever
> > see "-EAGAIN: Runtime PM usage_count non-zero", because in non-racy
> > conditions, pm_runtime_put() would drop its reference count, see it's
> > non-zero, and return early (in __pm_runtime_idle()). However, it's
> > possible to race with another actor that increments the usage_count
> > afterward, since rpm_idle() is protected by a separate lock; in such a
> > case, we may see -EAGAIN.
> >
> > Because this case is only seen in the presence of concurrent actors, it
> > makes sense to clarify that this is when "usage_count **became**
> > non-zero", by way of some racing actor.
> >
> > Lastly, pm_runtime_put_sync_suspend() duplicated some -EAGAIN language.
> > Fix that.
> >
> > Fixes: 271ff96d6066 ("PM: runtime: Document return values of suspend-re=
lated API functions")
> > Link: https://lore.kernel.org/linux-pm/aJ5pkEJuixTaybV4@google.com/
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
> >  include/linux/pm_runtime.h | 33 ++++++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> > index d88d6b6ccf5b..fd17ffe1bc79 100644
> > --- a/include/linux/pm_runtime.h
> > +++ b/include/linux/pm_runtime.h
> > @@ -356,7 +356,6 @@ static inline int pm_runtime_force_resume(struct de=
vice *dev) { return -ENXIO; }
> >   * * -EPERM: Device PM QoS resume latency 0.
> >   * * -EINPROGRESS: Suspend already in progress.
> >   * * -ENOSYS: CONFIG_PM not enabled.
> > - * * 1: Device already suspended.
> >   * Other values and conditions for the above values are possible as re=
turned by
> >   * Runtime PM idle and suspend callbacks.
> >   */
> > @@ -439,7 +438,6 @@ static inline int pm_runtime_resume(struct device *=
dev)
> >   * * -EPERM: Device PM QoS resume latency 0.
> >   * * -EINPROGRESS: Suspend already in progress.
> >   * * -ENOSYS: CONFIG_PM not enabled.
> > - * * 1: Device already suspended.
> >   */
> >  static inline int pm_request_idle(struct device *dev)
> >  {
> > @@ -540,15 +538,16 @@ static inline int pm_runtime_resume_and_get(struc=
t device *dev)
> >   * equal to 0, queue up a work item for @dev like in pm_request_idle()=
.
> >   *
> >   * Return:
> > + * * 1: Usage counts dropped to zero, but device was already suspended=
.
>
> Does this actually happen? pm_runtime_put() calls __pm_runtime_idle() tha=
t
> doesn't appear to return 1 in any case.

Except when it calls rpm_suspend() that may return 1.

> >   * * 0: Success.
> >   * * -EINVAL: Runtime PM error.
> >   * * -EACCES: Runtime PM disabled.
> > - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status cha=
nge ongoing.
> > + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM sta=
tus
> > + *            change ongoing.
> >   * * -EBUSY: Runtime PM child_count non-zero.
> >   * * -EPERM: Device PM QoS resume latency 0.
> >   * * -EINPROGRESS: Suspend already in progress.
> >   * * -ENOSYS: CONFIG_PM not enabled.
> > - * * 1: Device already suspended.
> >   */
> >  static inline int pm_runtime_put(struct device *dev)
> >  {
> > @@ -565,15 +564,16 @@ DEFINE_FREE(pm_runtime_put, struct device *, if (=
_T) pm_runtime_put(_T))
> >   * equal to 0, queue up a work item for @dev like in pm_request_autosu=
spend().
> >   *
> >   * Return:
> > + * * 1: Usage counts dropped to zero, but device was already suspended=
.
> >   * * 0: Success.
>
> "usage_count" and "usage counter" is being used in kernel-doc already, I'=
d
> use either of the two. "usage_count" refers directly to the field in stru=
ct
> dev_pm_info (and is used a few lines below). Same elsewhere.

"Usage counter", please!

> >   * * -EINVAL: Runtime PM error.
> >   * * -EACCES: Runtime PM disabled.
> > - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status cha=
nge ongoing.
> > + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM sta=
tus
> > + *            change ongoing.
> >   * * -EBUSY: Runtime PM child_count non-zero.
> >   * * -EPERM: Device PM QoS resume latency 0.
> >   * * -EINPROGRESS: Suspend already in progress.
> >   * * -ENOSYS: CONFIG_PM not enabled.
> > - * * 1: Device already suspended.
> >   */
> >  static inline int __pm_runtime_put_autosuspend(struct device *dev)
> >  {
> > @@ -590,15 +590,16 @@ static inline int __pm_runtime_put_autosuspend(st=
ruct device *dev)
> >   * in pm_request_autosuspend().
> >   *
> >   * Return:
> > + * * 1: Usage counts dropped to zero, but device was already suspended=
.
> >   * * 0: Success.
> >   * * -EINVAL: Runtime PM error.
> >   * * -EACCES: Runtime PM disabled.
> > - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status cha=
nge ongoing.
> > + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM sta=
tus
> > + *            change ongoing.
> >   * * -EBUSY: Runtime PM child_count non-zero.
> >   * * -EPERM: Device PM QoS resume latency 0.
> >   * * -EINPROGRESS: Suspend already in progress.
> >   * * -ENOSYS: CONFIG_PM not enabled.
> > - * * 1: Device already suspended.
> >   */
> >  static inline int pm_runtime_put_autosuspend(struct device *dev)
> >  {
> > @@ -619,14 +620,15 @@ static inline int pm_runtime_put_autosuspend(stru=
ct device *dev)
> >   * if it returns an error code.
> >   *
> >   * Return:
> > + * * 1: Usage counts dropped to zero, but device was already suspended=
.
> >   * * 0: Success.
>
> Does this happen (pm_runtime_put_sync() calls __pm_runtime_idle())?

It does (see above).

> >   * * -EINVAL: Runtime PM error.
> >   * * -EACCES: Runtime PM disabled.
> > - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status cha=
nge ongoing.
> > + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM sta=
tus
> > + *            change ongoing.
> >   * * -EBUSY: Runtime PM child_count non-zero.
> >   * * -EPERM: Device PM QoS resume latency 0.
> >   * * -ENOSYS: CONFIG_PM not enabled.
> > - * * 1: Device already suspended.
> >   * Other values and conditions for the above values are possible as re=
turned by
> >   * Runtime PM suspend callbacks.
> >   */
> > @@ -646,15 +648,15 @@ static inline int pm_runtime_put_sync(struct devi=
ce *dev)
> >   * if it returns an error code.
> >   *
> >   * Return:
> > + * * 1: Usage counts dropped to zero, but device was already suspended=
.
> >   * * 0: Success.
> >   * * -EINVAL: Runtime PM error.
> >   * * -EACCES: Runtime PM disabled.
> > - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status cha=
nge ongoing.
> > - * * -EAGAIN: usage_count non-zero or Runtime PM status change ongoing=
.
> > + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM sta=
tus
> > + *            change ongoing.
> >   * * -EBUSY: Runtime PM child_count non-zero.
> >   * * -EPERM: Device PM QoS resume latency 0.
> >   * * -ENOSYS: CONFIG_PM not enabled.
> > - * * 1: Device already suspended.
> >   * Other values and conditions for the above values are possible as re=
turned by
> >   * Runtime PM suspend callbacks.
> >   */
> > @@ -677,15 +679,16 @@ static inline int pm_runtime_put_sync_suspend(str=
uct device *dev)
> >   * if it returns an error code.
> >   *
> >   * Return:
> > + * * 1: Usage counts dropped to zero, but device was already suspended=
.
> >   * * 0: Success.
> >   * * -EINVAL: Runtime PM error.
> >   * * -EACCES: Runtime PM disabled.
> > - * * -EAGAIN: Runtime PM usage_count non-zero or Runtime PM status cha=
nge ongoing.
> > + * * -EAGAIN: Runtime PM usage_count became non-zero or Runtime PM sta=
tus
> > + *            change ongoing.
> >   * * -EBUSY: Runtime PM child_count non-zero.
> >   * * -EPERM: Device PM QoS resume latency 0.
> >   * * -EINPROGRESS: Suspend already in progress.
> >   * * -ENOSYS: CONFIG_PM not enabled.
> > - * * 1: Device already suspended.
> >   * Other values and conditions for the above values are possible as re=
turned by
> >   * Runtime PM suspend callbacks.
> >   */
>
> --

