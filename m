Return-Path: <linux-pm+bounces-24070-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CA0A61D24
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 21:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11A37A6878
	for <lists+linux-pm@lfdr.de>; Fri, 14 Mar 2025 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5BF193436;
	Fri, 14 Mar 2025 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C4/B6PUD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5C11547E2
	for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985412; cv=none; b=cUbLwePw04qLiSVf7WSx2rwOFcgBx+mPbKWOPa9pMVRdJ9hhT/QaGdWQu2jDFASh/jOkxi9TYwYdcjRNiNzmOB7BFkLuRNLzvfDDtsnxQ8Q+goCkFUT93OloCP8Q8hKSoHiDugwi0jTyFPnRFZzIdQoubRPDun6na6lQHDpofr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985412; c=relaxed/simple;
	bh=vIru7H1hP1FQA8IKmmhv+bwpncxCOSretzkl7D+50uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MOqIdQyKHZgcY1gpohurzJZpqPuOvgujMuB0lBW+3z5dNaYQu4NK2jZxbouP6huc0rzx3Z7S0xcYznaFkb4RMnTPMKt13WP1hRbbNjOOLaOmnFnKE97oSPsjFj/+KjbVtXc6eN0A6+RhO1Tj/GkHoC72hTegz7wfMJuaGg4Ujeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C4/B6PUD; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so37125221fa.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Mar 2025 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741985409; x=1742590209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA6XtNdlySX5JQDvW/SznpZemPYfjOfhDA5u/GSi5jY=;
        b=C4/B6PUDjPzhBBCogcVx0jtQ8iPdyGXnmLq44Pzl1zCqSPRhQ7dmYBg44bemdbU1Cz
         wRVsZDVFCKUwy6URuKsdNiAu4ngRCkqfWNXdMZiNLfTvex0Hqx4XcBN+P9o2+b4AyjiP
         W+HIUuVHI27+OH4+IsovgYtzXQO48Lu/ry3h+R/YvThOK3QF/OJOSZwMsgO+SnC0JqmY
         qKcGQvTlKqH1KKgDAojn3ouEfHUBBE5A61HmScafs1L10iTshQwNWJwab80RmsAqsz/w
         9yjMvjpF4xbuiL5jZPW+outOXnyoGgmo52dK5q5X76jK22KqyW5KQSre7hoQA/nPvAj1
         IRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985409; x=1742590209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA6XtNdlySX5JQDvW/SznpZemPYfjOfhDA5u/GSi5jY=;
        b=agGrwpBvu5/1o4CbYJjxJXDSIP+lKNdIS21ACIhemctdJ8cvsUfaoL0649TAI1rZm7
         kAjSquSP6vJP/TtqtzUqPl/padCNXBZ8C/F+MwbjtTljjx8HIpF4MNapSuoLzTmqg51w
         FW902YGaGskaSOO3ZGupoEIMgmF0tGyY1Pn/aq5Uo7QpLRWzq8zpmHcpw+WT1R5aqeVL
         HZMrEekof4x0hkDHX/K+bA2jwrFSHC+l2B/WMOuxJN3QGfXS5iL9YJ97Qf17ut2wUvBU
         vivXpyDsGTKvWQcFTBgLTbvKdatQB4vouRmNEhehVfh38YAnqQefOcuR/teiceuCcOBw
         iObA==
X-Forwarded-Encrypted: i=1; AJvYcCVC4krRKhZfdobIWHeRcGVldBbTxzOcjrZe+7yVRiydDZ823LZF7zwgV5rm198f7Cbmrlfbrm376w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLelNhtNeuIzE/NOfHHNYonZCBt8lz1WM+xA0xiqu2luiqsMOC
	bGBXLHPec2DyMSq78iIRcxrbwvitGs1+uFJu1XKKApBCy9Hsg0zVXReWm7HlX3HxIQleu7dX8i1
	uxkgd6fDkk0TRjhgYP8FKHp39QPC7BZC4rUEa
X-Gm-Gg: ASbGncspnZ9JNmEgUrSbNw6EPRvT4jQ5DUXb0xLJBN4eEQEySgll7kxoFCvyWyQYYCm
	5A76i2bgGzWL0FkLINbJEHYxyVduZ7BfXqXkvXhHysyvkDBJkSmBhE5gzHPhXyzx8isaD3v5Fo4
	WE4O/aIn70cS54mlMGUb+CEldG
X-Google-Smtp-Source: AGHT+IFAg45SjFKHBOIoXpo4chfZtm9U2OeL3IcUvUP+6gtmvyLqt5LeuQNKcwZ0eOIH9ytw8Uq6cwDf5anxg4ISE7I=
X-Received: by 2002:a05:6512:2811:b0:549:9643:68d0 with SMTP id
 2adb3069b0e04-549ba44006cmr2970552e87.17.1741985408470; Fri, 14 Mar 2025
 13:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
 <20241114220921.2529905-2-saravanak@google.com> <Z9SV5UymVcuUkSE1@duo.ucw.cz>
In-Reply-To: <Z9SV5UymVcuUkSE1@duo.ucw.cz>
From: Saravana Kannan <saravanak@google.com>
Date: Fri, 14 Mar 2025 13:49:31 -0700
X-Gm-Features: AQ5f1JpkxQoNFJkeqXxhobd44dP2b6V9Y2pHPuZ1QzilqhDClN1TfxI2FZLcsLQ
Message-ID: <CAGETcx_bSOAYwvc=M4nTJF-OAb-nNCQ5bCfQcrHMhyLmv3rd3w@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] PM: sleep: Fix runtime PM issue in dpm_resume()
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Marek Vasut <marex@denx.de>, 
	Bird@google.com, Tim <Tim.Bird@sony.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:47=E2=80=AFPM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > Some devices might have their is_suspended flag set to false. In these
> > cases, dpm_resume() should skip doing anything for those devices.
> > However, runtime PM enable and a few others steps are done before
> > checking for this flag. Fix it so that we do things in the right order.
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/power/main.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > index 4a67e83300e1..86e51b9fefab 100644
> > --- a/drivers/base/power/main.c
> > +++ b/drivers/base/power/main.c
> > @@ -913,6 +913,9 @@ static void device_resume(struct device *dev, pm_me=
ssage_t state, bool async)
> >       if (dev->power.syscore)
> >               goto Complete;
> >
> > +     if (!dev->power.is_suspended)
> > +             goto Unlock;
> > +
>
> This needs to be goto Complete, right?

Yeah, it's a bug even I pointed out in another email. But Rafael send
a new proper fixed up patch that I Reviewed-by.

-Saravana

>                                                                 Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.

