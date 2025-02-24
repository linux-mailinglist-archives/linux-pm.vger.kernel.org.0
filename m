Return-Path: <linux-pm+bounces-22802-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E2A41F80
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 13:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EB803B05E6
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2025 12:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B137223370F;
	Mon, 24 Feb 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACYSwwiS"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85977221F26;
	Mon, 24 Feb 2025 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400770; cv=none; b=GWZquWe4hoJ7oCWDc1+z/84Nc0ln2MJFm/Sl8fLY7na0VlgUrt1wXIyZQbeVzpg2bTKUbB+tjvL6+YOT7IiAvvfh36FXrnF3Ln5CVnqOoD2elBOgipC7eMw1YX8FiP6zqQStnOH/zz1Om1/t2P5/6uizVqQ+8okAWC3K2yy4OLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400770; c=relaxed/simple;
	bh=S6ZfOA+HSoIxuZxmAVC9m4CnDBFj730TlTYYvZud6AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msgyVwfUxh6Df1KDLpomBcvPE3Cow5qWg2gCfakwn3EcPzfO8+Fftrk78Klc9fR5miFT75760eTXpFrR8wY8t/IdeedaPtF/IHyJE0QGfwiwve7tlgSBwj9LKd9BghraD0UbhhVezWxZqVkaE7ReiNEsE3wkPrIlwZuS3Czw9vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACYSwwiS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67594C4CEE6;
	Mon, 24 Feb 2025 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400770;
	bh=S6ZfOA+HSoIxuZxmAVC9m4CnDBFj730TlTYYvZud6AI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ACYSwwiSiadXb6UglhqGqNQ/VbzzEbQIAZds28mZoqO6ZB2x/uUwGFOZhTWF4iQtB
	 V+htWTqSNKDoxjFr9DJNUm/a1UyR7WCpz++50KVONsr/KPjTzkMaIY+Bi1YPDzkSNJ
	 xnlj+I2n0fLWZrGYFzk/4h6JRxVlZbIpLnFTMAAQbhretkjtcp4m8QMmTJSHIYcILO
	 KhHjqd4LEMqn09yiRc7QaPwen/5JioDFIFEY58O+z4YYVLLbYHOwfth8fHs0NtF0Lu
	 HmdWlBqhYjjNRX41Uxc94t3WdLvLFiPSYy7o7UDgpxLwLVwZ5JxF949cFAltP8EYPJ
	 JrX8kxJ2x/jJQ==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-724d1724657so2723203a34.0;
        Mon, 24 Feb 2025 04:39:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUX3Jyllh8LKDbrLJDCDL4MrpoQy5R7bO0cBPOKowbMLhKf/TJemZ4dX6oUJwKdl/UDsow1sCw3ERqLAGA=@vger.kernel.org, AJvYcCUYM1nVPKW9yFYKiai3gjlran6c+G/x0oFFSjuBl2OIZ+yWcmsKoIIiz83zhJ/l7PA88hn1HWgPCT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2oWC+jT5j//ycOl5wLAnI7q5vPNXPmCkJvynWSj86oL9YQoUw
	BZUZ4jTndBSNp/QJRC2pKY5H9UW9UPJrdkLn4LhgZjuFp9G8plMuKBADBSvQVoYe68XRmrzpTXJ
	r/fkj8ColpVNMHPg2d3luyFYbw6w=
X-Google-Smtp-Source: AGHT+IHggqicMJe4po68oFh3AV+MbbEgliSfKFxjCzT478bb4j8IJW6Xkp8IGccC+aW4rtOOm0njgxkUFQ9W+jhX3As=
X-Received: by 2002:a05:6808:abb:b0:3f3:d367:52fa with SMTP id
 5614622812f47-3f419f8937fmr9732251b6e.18.1740400769737; Mon, 24 Feb 2025
 04:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1922654.tdWV9SEqCh@rjwysocki.net> <Z7rPOt0x5hWncjhr@black.fi.intel.com>
 <CAJZ5v0jwn0e4HF1SsAG1OXr59tHzh=E2rcGkTdj1FOQdK2Uisw@mail.gmail.com> <Z7tB5wshbGtO6LGg@black.fi.intel.com>
In-Reply-To: <Z7tB5wshbGtO6LGg@black.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Feb 2025 13:39:14 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jmp4PFb6z+K9cGS83CmX=5Ms0F9HSgcpq-VXn=rTdXgg@mail.gmail.com>
X-Gm-Features: AWEUYZnrxMu49N4Mo5yLfVkT6yju4vb6gvnJgw62dhhnaeg90o5cilnqap9M89U
Message-ID: <CAJZ5v0jmp4PFb6z+K9cGS83CmX=5Ms0F9HSgcpq-VXn=rTdXgg@mail.gmail.com>
Subject: Re: [PATCH v1] PM: runtime: Unify error handling during suspend and resume
To: Raag Jadav <raag.jadav@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Oliver Neukum <oneukum@suse.com>, Ajay Agarwal <ajayagarwal@google.com>, 
	Brian Norris <briannorris@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 4:42=E2=80=AFPM Raag Jadav <raag.jadav@intel.com> w=
rote:
>
> On Sun, Feb 23, 2025 at 01:56:07PM +0100, Rafael J. Wysocki wrote:
> > On Sun, Feb 23, 2025 at 8:33=E2=80=AFAM Raag Jadav <raag.jadav@intel.co=
m> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 09:18:23PM +0100, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > There is a confusing difference in error handling between rpm_suspe=
nd()
> > > > and rpm_resume() related to the special way in which the -EAGAIN an=
d
> > > > -EBUSY error values are treated by the former.  Also, converting
> > > > -EACCES coming from the callback to an I/O error, which it quite li=
kely
> > > > is not, may confuse runtime PM users a bit.
> > > >
> > > > To address the above, modify rpm_callback() to convert -EACCES comi=
ng
> > > > from the driver to -EAGAIN and to set power.runtime_error only if t=
he
> > > > return value is not -EAGAIN or -EBUSY.
> > > >
> > > > This will cause the error handling in rpm_resume() and rpm_suspend(=
) to
> > > > work consistently, so drop the no longer needed -EAGAIN or -EBUSY
> > > > special case from the latter and make it retry autosuspend if
> > > > power.runtime_error is unset.
> > > >
> > > > Link: https://lore.kernel.org/linux-pm/20220620144231.GA23345@axis.=
com/
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/base/power/runtime.c |   34 ++++++++++++++++++------------=
----
> > > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > > >
> > > > --- a/drivers/base/power/runtime.c
> > > > +++ b/drivers/base/power/runtime.c
> > > > @@ -448,8 +448,13 @@
> > > >               retval =3D __rpm_callback(cb, dev);
> > > >       }
> > > >
> > > > -     dev->power.runtime_error =3D retval;
> > > > -     return retval !=3D -EACCES ? retval : -EIO;
> > > > +     if (retval =3D=3D -EACCES)
> > > > +             retval =3D -EAGAIN;
> > >
> > > While this is one way to address the problem, are we opening the door
> > > to changing error codes when convenient? This might lead to different
> > > kind of confusion from user standpoint.
> >
> > Are you saying that if a mistake was made sufficiently long ago, it
> > can't be fixed any more because someone may be confused?
>
> Nothing against the fix but "sufficiently long ago" is why we might
> have users that rely on it. As long as we don't break anything I don't
> see a problem.
>
> Messing with error codes is usually received with mixed feelings and
> coming across such a code raises more questions than answers. Perhaps a
> small explanation might do the trick?

Do you mean an explanation why -EACCES needs to be converted to something e=
lse?

That's because -EACCES has a special meaning in runtime PM: it means
that runtime PM is disabled for the given device.

Thanks!

