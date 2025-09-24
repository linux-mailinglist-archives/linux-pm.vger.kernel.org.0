Return-Path: <linux-pm+bounces-35271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9F6B9975C
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 12:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D043BE0BF
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 10:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D5D2E03F0;
	Wed, 24 Sep 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZTBlqbi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722512E03E6
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710464; cv=none; b=jYTE2r+l80IoflwlrdpGsvP6WaLISnmAYh0ltvV8JL+cIHu+OCsmT1y26CeK9xvLFZJ6J6f5ZvHb48KBTIYkwfo6gqv8kKG/Rb6WRjvAAyi84kUIgIjrEhWRRtzQyNqdzCfT+cJApJX+WipKZBAO4ujKkD0PKxKSorRW+v0dBpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710464; c=relaxed/simple;
	bh=Ucao5t0JQECmx9Y+N8QPEyIHjvoUFKufvWDR6s3vYX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHPJNFUUeBO/S6mLjkzAc43f8+t1e8NSc2/397TUAYd4Sgz4CJL7XHuMwA4clTBhds2poV9bZL5eoEwUuDBkkQj1O6K3pozEyx1xuaxH9GEfGT0QDx5p1RehNOgFRCt+FcLmnihMvI85fkVZI/H3ln8W6hwvDLtc4v4Z1eq4xvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZTBlqbi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F130BC19423
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 10:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758710464;
	bh=Ucao5t0JQECmx9Y+N8QPEyIHjvoUFKufvWDR6s3vYX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mZTBlqbi+SiLTI33ukDiqVgwl+L1UOZ5w+2PgXBDw0/hNR30F2IOyRGE0difcVVa6
	 Aiz/3NJR1Bs6HovUa5u+MOPB9HfFAFn912KGghb1m93tnOIdYG7QMt3PBESYdG9tdW
	 FQfg1uEsOaAHmRVHRmNyy6j4pEJ+gfDMhDzYR/R+WrkspEKm6Qdl2PoxSLlVKlX3Bb
	 4GRqv1hZx1uTSCxyRsjd0AAqHIOmDt4Lbr4U4NGWDScCoLLAcgkd5R+mzVRirdOiNb
	 EPp8Yr+2x1VfWT7q33QWcj8zeshIRkytd2bJGE/vfYBsQYDF9wN+fnr/a2OtkQKIub
	 yJAtEwnxU+8hg==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-753a9c8dabeso2422547a34.3
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 03:41:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUYYGY94cUFyzg2ukMQvZIEgGI1caxE1fVq398Oxkrpq1sgYT6hK4uE1o+0W7cSG3JO8XPK0/GbSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YymXMhhQGt1QkFmTDg0gF5d1GAALbtAta4Yzd+YsGrUq6cG+X7D
	faXwKoLZedURd3pYcuLxz8wT2gqzfp04CFIjqTXqqKMxuIhdkJ7hPRmQDe3sWueGh3+c/laWwFO
	81ICgbTPnlggwW2M+s80OIjG7NulwFOg=
X-Google-Smtp-Source: AGHT+IEp272GIAcEmKsgJ+Bv4gWEuTprs7dhqQc5snm6COMYtCGtllIRQS2RWJbG9RshYXYqju0dXAHcoU1FWhTelUk=
X-Received: by 2002:a05:6808:320b:b0:43f:2bb2:91d4 with SMTP id
 5614622812f47-43f2d31569cmr2902968b6e.3.1758710463239; Wed, 24 Sep 2025
 03:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921042537.3118333-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0joEhp9rt1WfN6eHfnuw_d2zrWFvd=Mn4NXRqO41xhsEQ@mail.gmail.com>
 <LV3PR11MB87682A511B8C0ED226C3BBDEF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
 <CAJZ5v0iMrq3uWBWZLkT0jf7ja9jzk1AdvUCM-tGgx+8zQQWPvQ@mail.gmail.com> <LV3PR11MB87683634AEFDF44A845A9282F51CA@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB87683634AEFDF44A845A9282F51CA@LV3PR11MB8768.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 12:40:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-WkN8PdzFGVVNjVKyYK+QOubr9fog6iSO5frv9ZhGVA@mail.gmail.com>
X-Gm-Features: AS18NWBEWtELfKR63XTkPa33WIslLpP6Necd_qZF4HnDrDWDoMf5LFZxCwOh4fU
Message-ID: <CAJZ5v0g-WkN8PdzFGVVNjVKyYK+QOubr9fog6iSO5frv9ZhGVA@mail.gmail.com>
Subject: Re: [PATCH] PM: Delete timer before removing wakeup source from list
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "pavel@kernel.org" <pavel@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 6:15=E2=80=AFAM Kumar, Kaushlendra
<kaushlendra.kumar@intel.com> wrote:
>
> On Tue, Sep 23, 2025 at 6:52 AM, Rafael J. Wysocki wrote:
> > On Tue, Sep 23, 2025 at 6:52 AM Kumar, Kaushlendra <kaushlendra.kumar@i=
ntel.com> wrote:
> > >
> > > On Sun, Sep 21, 2025 at 6:27 AM, Rafael J. Wysocki wrote:
> > > > On Sun, Sep 21, 2025 at 6:27 AM Kaushlendra Kumar <kaushlendra.kuma=
r@intel.com> wrote:
> > > > >
> > > > > Move timer_delete_sync() before list_del_rcu() in
> > > > > wakeup_source_remove() to ensure proper cleanup ordering. This
> > > > > prevents the timer callback from executing after the wakeup sourc=
e has been removed from the events list.
> > > > >
> > > > > The previous order could allow the timer callback to access the
> > > > > wakeup source entry after removal but before timer deletion,
> > > > > potentially causing use-after-free issues or list corruption.
> > > >
> > > > How so?  You need to specify the scenario in which that can happen.
> > >
> > > Hi Rafael,
> > >
> > > Thank you for asking for clarification. Here's the specific scenario
> > > where the it can occur:
> > >
> > > **Issue Condition Timeline:**
> > >
> > > 1. **Thread A** calls wakeup_source_remove():
> > >
> > > raw_spin_lock_irqsave(&events_lock, flags); list_del_rcu(&ws->entry);=
 // Remove from events list raw_spin_unlock_irqrestore(&events_lock, flags)=
; synchronize_srcu(&wakeup_srcu); // Wait for RCU readers // *** ISSUE WIND=
OW HERE *** timer_delete_sync(&ws->timer); // Timer still active!
> > >
> > > 2. **Thread B** (timer callback) fires during the issue window:
> > >
> > > static void pm_wakeup_timer_fn(struct timer_list *t) { struct
> > > wakeup_source *ws =3D from_timer(ws, t, timer); // Problem: ws->entry=
 was already removed from events list
> > >    // but timer callback still executes
> >
> > Why is this a problem?  ws is still there and the timer callback doesn'=
t do anything with ws->entry AFAICS.
> >
> > > **Specific Issues:**
> > >
> > > **Timer accesses removed wakeup_source**: The timer callback
> > > (pm_wakeup_timer_fn) can execute after list_del_rcu() but before
> > > timer_delete_sync(), accessing a wakeup_source that's no longer in th=
e
> > > events list.
> >
> > Again, why is this a problem?
> >
> > > **Why moving timer_delete_sync() first fixes this:**
> > >
> > > - Ensures timer cannot fire during list removal
> > > - Guarantees no timer callbacks execute after we start cleanup
> > >
> > > The fix ensures that once we start wakeup_source_remove(), no timer
> > > callbacks can execute
> >
> > You may argue that the new code will be cleaner (fair enough), but unle=
ss there is a specific correctness matter here, you can't call it a fix.
>
> Hi Rafael,
>
> You're absolutely correct, I don't have any evidence in real use cases fo=
r this. Given your feedback, I should
> Reframe it as a cleanup/improvement patch rather than a "fix"
>
> If it is fine with you then I can create v2 patch with your suggestions.

Yes, please!

