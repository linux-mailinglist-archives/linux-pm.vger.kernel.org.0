Return-Path: <linux-pm+bounces-36341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D9CBE7D9F
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 11:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD76188D9DE
	for <lists+linux-pm@lfdr.de>; Fri, 17 Oct 2025 09:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6962D543A;
	Fri, 17 Oct 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkm5iFQJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78782C15A5
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 09:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693961; cv=none; b=RPKmnQ2W+/2DyQyKiP21k0KW0p/Pq4CT2hURqtlifhyaHaEVD4rO1RibvYMv+U+/io/v/DiKAA5Kfg7BeGaF+A3RA0vTX8R4WBnD+diXBqeBhq+BmONLq0dJ2vmB0DjoD7KYDoHM8DuLzhIlYRliYHP8T7DvLM06T9z9Gdv5sto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693961; c=relaxed/simple;
	bh=Qx1TE74bjoehaJnB38qm6cAa+/c4JLqzRjdOWDek/ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DDgSek968jNYXt1fr+9VT7NWR6MM6qQp8tZ3PndgWRD3RbtLYilADYQlfMLWmUmVWa5R3kODTJodA1RbcVAffUrvEWQfArUYyLKx+kDtl/JPFV5+1zfYCKopju/MZzGIhluiN4AI1CcQQEvzsgNZgVTKvp7PAv5X4lmno8IDifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkm5iFQJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53134C113D0
	for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 09:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760693961;
	bh=Qx1TE74bjoehaJnB38qm6cAa+/c4JLqzRjdOWDek/ks=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mkm5iFQJVb5xjTK1usWFPlxgoKljXiRJqTkwvEZq0IE8VEamijNvCFPHa3a/h4m9r
	 RJbLlf8bkDFGxOJEE9Rm3juJVzJRlfx5U7KGJeGMUT+VQYLlwXhzrHnNVpBnlmn+Vp
	 +MZt7/+AO2PYlHrWo+nKUqL87T1a7OPRv3XGAfGS4p3cypsE9qcctqwcBY+3OgTP2D
	 XcVNI38qYjCPnlBPDL5IAMuW9LYTcsJrZRw4ScBkatz+zgRrjuBqfDbPByoKksqZ1k
	 +HmlHXxoFvdhC7/x7wrjJ98PIeUThzrgsz6xsG5jS2dQO0hdvO823i8hrfRjCN5+QC
	 zqT8IZSrURRvQ==
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7b4f7a856acso544414a34.3
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2025 02:39:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK5K84EDXMmsC3O3KSj56m9k08NVBYElaG9J0/nBizcn1ZZAqk/R1L3Oey7icX7FRYQjNsUPsh5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyU588BhX0krI6oXGIxb6AlmPz+FfeM8+YUq/M1bC9W3psaO8VG
	DdOKRmGXg7qMIrgkh0fSSfAjfo7WC5A3kUx5oBloqHjQbIdYQAqUZ4j/CN3JdV7SLoo9jRk/dWp
	03LazRMXpq87JCY9clYKgtx+vD0ZFpg0=
X-Google-Smtp-Source: AGHT+IGttxufEgkOwOsutN3evluYKDZYajTfOKTB9QlgJ8PbCatlAdOeutL0B0BAsdWnnouVh/yMwTtxDPHcl4JHcH0=
X-Received: by 2002:a05:6808:2211:b0:43f:70a1:c6a3 with SMTP id
 5614622812f47-443a2f0be2cmr1386014b6e.26.1760693960641; Fri, 17 Oct 2025
 02:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4687373.LvFx2qVVIh@rafael.j.wysocki> <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
In-Reply-To: <5f0aa630-b30a-44c4-a52c-e08179cd3bf9@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 17 Oct 2025 11:39:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
X-Gm-Features: AS18NWBUyN7vl9Iz8L2yW8Lm6U0ynOZg4aGcHapB3TuhqCtgXEqHaSRKsWpI-eE
Message-ID: <CAJZ5v0gBtv0bpK2swkc6D0AmanpKAvqO53dgRp2e7p9cWAM3TA@mail.gmail.com>
Subject: Re: [PATCH v1] cpuidle: governors: menu: Predict longer idle time
 when in doubt
To: Christian Loehle <christian.loehle@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, LKML <linux-kernel@vger.kernel.org>, 
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Tomasz Figa <tfiga@chromium.org>, 
	Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 10:22=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 10/16/25 17:25, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > It is reported that commit 85975daeaa4d ("cpuidle: menu: Avoid discardi=
ng
> > useful information") led to a performance regression on Intel Jasper La=
ke
> > systems because it reduced the time spent by CPUs in idle state C7 whic=
h
> > is correlated to the maximum frequency the CPUs can get to because of a=
n
> > average running power limit [1].
> >
> > Before that commit, get_typical_interval() would have returned UINT_MAX
> > whenever it had been unable to make a high-confidence prediction which
> > had led to selecting the deepest available idle state too often and
> > both power and performance had been inadequate as a result of that in
> > some cases.  This was not a problem on systems with relatively
> > aggressive average running power limits, like the Jasper Lake systems
> > in question, because on those systems it was compensated by the ability
> > to run CPUs at relatively higher frequencies.
> >
> > Commit 85975daeaa4d addressed that by causing get_typical_interval() to
> > return a number based on the recent idle duration information available
> > to it in those cases, but that number is usually smaller than the
> > maximum idle duration observed recently which may be regarded as an
> > overly optimistic choice.
> >
> > Namely, it may be argued that when the samples considered by
> > get_typical_interval() are spread too much for a high-confidence
> > prediction to be made, the function should fall back to returning a
> > number that is likely to be an upper bound for the duration of the
> > upcoming idle interval and that number needs to be at least equal to
> > the maximum recently observed idle time.  Otherwise, the governor may
> > miss an oportunity to reduce power without hurting performance in a

Ah, a typo.

> > noticeable way.  Of course, it may also be argued the other way around,
> > but the available data indicate that get_typical_interval() should
> > rather tend to return larger numbers as that causes the governor to
> > behave more closely to its past behavior from before the problematic
> > commit.
> >
> > Accordingly, modify get_typical_interval() to return the maximum
> > recently observed idle time when it is unable to make a high-
> > confidence prediction.
> >
> > Fixes: 85975daeaa4d ("cpuidle: menu: Avoid discarding useful informatio=
n")
> > Closes: https://lore.kernel.org/linux-pm/36iykr223vmcfsoysexug6s274nq2o=
imcu55ybn6ww4il3g3cv@cohflgdbpnq7/ [1]
> > Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: All applicable <stable@vger.kernel.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  drivers/cpuidle/governors/menu.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -116,6 +116,7 @@ static void menu_update(struct cpuidle_d
> >  static unsigned int get_typical_interval(struct menu_device *data)
> >  {
> >       s64 value, min_thresh =3D -1, max_thresh =3D UINT_MAX;
> > +     unsigned int max_overall =3D 0;
>
> nit: for reverse xmas this should be one further down?

Actually, I can combine this with the min and max definition.

> Maybe s/max_overall/max_first_pass/?

I can call it grand_max.

> >       unsigned int max, min, divisor;
> >       u64 avg, variance, avg_sq;
> >       int i;
> > @@ -151,6 +152,9 @@ again:
> >       if (!max)
> >               return UINT_MAX;
> >
>
> Or alternatively a comment:
> /* Save the max before we discard any intervals */
> or something.
>
> > +     if (max_overall < max)
> > +             max_overall =3D max;
> > +>    if (divisor =3D=3D INTERVALS) {
> >               avg >>=3D INTERVAL_SHIFT;
> >               variance >>=3D INTERVAL_SHIFT;
> > @@ -198,7 +202,7 @@ again:
> >                * maximum, so return the latter in that case.
> >                */
> >               if (divisor >=3D INTERVALS / 2)
> > -                     return max;
> > +                     return max_overall;
> >
> >               return UINT_MAX;
> >       }
> >
>
> Anyway, the patch makes sense, let me run some tests and get back.

Thanks!

