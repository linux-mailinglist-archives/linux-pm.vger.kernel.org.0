Return-Path: <linux-pm+bounces-35223-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E072B95D8A
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 14:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBC07AC06F
	for <lists+linux-pm@lfdr.de>; Tue, 23 Sep 2025 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F41213AF2;
	Tue, 23 Sep 2025 12:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1i9sSqI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C32946A
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758630680; cv=none; b=l5TvsIAwK6UJ1wJ+Rsm5z7hhr54BKYzf7Q8YHTlIi8RkSKelfBQ+qrTpIucHoLyfxNktOYMim2xeZ/AjcmGB0TmC+0YH1lnEdOgZaK4HtsJtYXezp4I+73cFSV5/DbCNkd+SE6wdAJ3foSUVUMoST708Hc96Iztka1j7iMmWXQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758630680; c=relaxed/simple;
	bh=A1sGntKjQQUjcIMXboWRC36ljRGJLv/tCDy73snFdh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1NxnBGEW1/AyXHSLjw0i8UaWoBQU4j2O//mVb/CsHrlUSHFnv8Jl3b2xcDBofSN7vdWsp5yvFIdIXzDQunti0Nhd40qnKy+surq9LUMxBFiPJ2KybdwBNykbRn1YixoarMy1pSvyZJZENo4DLMb0ymKJWYgL5w8MZTXuAIfK7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1i9sSqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABD9C113D0
	for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758630677;
	bh=A1sGntKjQQUjcIMXboWRC36ljRGJLv/tCDy73snFdh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u1i9sSqISO+aUwRpTrEtnWgnO9UfzBwZ/+Ij/ciW+e59yuHq87DSz2N0S4f7P0Kg6
	 WmqGOBUuaD3Vu1/C4QwGbJ5zwlZqA78tHFPWo7wksxiBclheVTQi3eWRKDLEIdWkcg
	 bUtR3Lb6LWFGeeQXTNN1TIe37mFo3m7Lqp1zgijDSunFntuO7NLKFEmWsMktJNqYzt
	 Ln55KmBba6wP5CA6M2yYZSwzbLhKaw59GkHPDx62mU9gaj7cjeZBGT9/QyM2IHr0mt
	 4T46CjC/mS9DQzlBlWSkWb1kgl9g+ot7p+0mmU9gdEYA2b5uwt6ropj+3jNweKDiz8
	 pSRuMEvQHAbJg==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74be52f5447so2376985a34.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Sep 2025 05:31:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRxs2UaxH/Dla+Hbrbah3vVyLJxb0GmgKDWK/QR3Mx6POdbRHlD/OI+C2zGg/IgS+Mi3YYBwvLxw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv45Qqp9t20gBn8ZCsAnUWlnvbm61IUvNpvdptgsvDoudOBss3
	yghd5O/DlKF/+pSrXsY7xVTQx41iHXEuP9qWfz6rZ5wsrl3U+9HISh5mtRDcMRLcJVozP6PdySS
	Irxaor1nNBWBorbOXLI/Zo4pdmRWmYWg=
X-Google-Smtp-Source: AGHT+IHGSA2H3fPDuzHI8csEjGIVJ1fHbqxoRdOyblFh28jlZlvh1msgeO1km17e+YcDegQDB7cJYTeHWIp4b4cYKq0=
X-Received: by 2002:a05:6808:10c1:b0:437:d7b0:878d with SMTP id
 5614622812f47-43f2d45935amr1009868b6e.50.1758630676756; Tue, 23 Sep 2025
 05:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250921042537.3118333-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0joEhp9rt1WfN6eHfnuw_d2zrWFvd=Mn4NXRqO41xhsEQ@mail.gmail.com> <LV3PR11MB87682A511B8C0ED226C3BBDEF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
In-Reply-To: <LV3PR11MB87682A511B8C0ED226C3BBDEF51DA@LV3PR11MB8768.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Sep 2025 14:31:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMrq3uWBWZLkT0jf7ja9jzk1AdvUCM-tGgx+8zQQWPvQ@mail.gmail.com>
X-Gm-Features: AS18NWAJkPb_FYP8yRciKQT_O3_a2akFy4HNrHiJHwksG0txFYzNxT50RMUy9n8
Message-ID: <CAJZ5v0iMrq3uWBWZLkT0jf7ja9jzk1AdvUCM-tGgx+8zQQWPvQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Delete timer before removing wakeup source from list
To: "Kumar, Kaushlendra" <kaushlendra.kumar@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "pavel@kernel.org" <pavel@kernel.org>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "dakr@kernel.org" <dakr@kernel.org>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 6:52=E2=80=AFAM Kumar, Kaushlendra
<kaushlendra.kumar@intel.com> wrote:
>
> On Sun, Sep 21, 2025 at 6:27 AM, Rafael J. Wysocki wrote:
> > On Sun, Sep 21, 2025 at 6:27 AM Kaushlendra Kumar <kaushlendra.kumar@in=
tel.com> wrote:
> > >
> > > Move timer_delete_sync() before list_del_rcu() in
> > > wakeup_source_remove() to ensure proper cleanup ordering. This
> > > prevents the timer callback from executing after the wakeup source ha=
s been removed from the events list.
> > >
> > > The previous order could allow the timer callback to access the wakeu=
p
> > > source entry after removal but before timer deletion, potentially
> > > causing use-after-free issues or list corruption.
> >
> > How so?  You need to specify the scenario in which that can happen.
>
> Hi Rafael,
>
> Thank you for asking for clarification. Here's the specific scenario wher=
e the
> it can occur:
>
> **Issue Condition Timeline:**
>
> 1. **Thread A** calls wakeup_source_remove():
>
> raw_spin_lock_irqsave(&events_lock, flags); list_del_rcu(&ws->entry); // =
Remove from events list raw_spin_unlock_irqrestore(&events_lock, flags); sy=
nchronize_srcu(&wakeup_srcu); // Wait for RCU readers // *** ISSUE WINDOW H=
ERE *** timer_delete_sync(&ws->timer); // Timer still active!
>
> 2. **Thread B** (timer callback) fires during the issue window:
>
> static void pm_wakeup_timer_fn(struct timer_list *t) { struct wakeup_sour=
ce *ws =3D from_timer(ws, t, timer);
> // Problem: ws->entry was already removed from events list
>    // but timer callback still executes

Why is this a problem?  ws is still there and the timer callback
doesn't do anything with ws->entry AFAICS.

> **Specific Issues:**
>
> **Timer accesses removed wakeup_source**: The timer callback
> (pm_wakeup_timer_fn) can execute after list_del_rcu() but before
> timer_delete_sync(), accessing a wakeup_source that's no longer in
> the events list.

Again, why is this a problem?

> **Why moving timer_delete_sync() first fixes this:**
>
> - Ensures timer cannot fire during list removal
> - Guarantees no timer callbacks execute after we start cleanup
>
> The fix ensures that once we start wakeup_source_remove(), no timer
> callbacks can execute

You may argue that the new code will be cleaner (fair enough), but
unless there is a specific correctness matter here, you can't call it
a fix.

