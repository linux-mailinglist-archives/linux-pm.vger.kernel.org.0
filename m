Return-Path: <linux-pm+bounces-23121-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F85BA484C8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 17:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985347A16D7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Feb 2025 16:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F7C1B041C;
	Thu, 27 Feb 2025 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooyREol4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4227D197A76;
	Thu, 27 Feb 2025 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673434; cv=none; b=q7QPgJ5SHCKNHnZKQhkEuOM9NP0nDGua2DR+UZmFXFGH1lmyDCrmZiEjGgfqx2B8dPJHl6xUliM5m8c7mBHcdUMTAuqw6pX4Wh839V7A4DabOhhu99V3vmQaxMYBPRtDqQs5NEv71r6d3t1mk59ibgMk2mxI53u3ZqPq3BmTdhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673434; c=relaxed/simple;
	bh=ljBeMFyMCPp2tgDw/rm8zyRJPmoHwGLm7BWWwGGi2cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OVc+b/pdmW4eNP0bojTb3yoYi0uWHE1Lbxd7c/lLICwE1dsxdhrvf9XGAJ8Rf0gT9YN45K6cA1pIO6gHx5Kula4I0r1FS8HtU7KPmeJVPJIC3p03d4ZHbDek0ZuABOe6wnOFC+dYfK0BTe1kYo2t4Sq/Z8BqLCjU0+AW3QMB+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooyREol4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CD5C4CEEA;
	Thu, 27 Feb 2025 16:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740673433;
	bh=ljBeMFyMCPp2tgDw/rm8zyRJPmoHwGLm7BWWwGGi2cs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ooyREol4Qm9MpAnZvC0rSg2vLu8mpT23sR48HGqzQ69hK+66r0gnFq+BeGaTAypKA
	 qnvv+kWZb2C83k16k9u3ahaspwjtDJei6FaxXHb4jywYYq69t9NcPN64HOZ584b584
	 4gQPl8Kh8tLCTdgS1KpYj5n9PRtPgzAWBG95uaxWt2//54XC1jvDhdF9KnYaju5dII
	 FgDxUkomnyR3mtmgX19YGgPI2wOmXSdrXBO/QLACSHctniWpsoK3UsVYm2nvET+L1u
	 62o+TITCfzrCr8V8uz8n839WV4rkrnHWb8eLIwgFq1R4L+e5BmUtEeGiORsxDgJr23
	 F3VTU/l+Ee5wg==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2bcceee7a5eso720991fac.0;
        Thu, 27 Feb 2025 08:23:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV80rgg8BJADNh83EPZufhFKm0xDM3KOXd7O0x6ToFwU3ZhuWXb3Rwvgv+aNcdrMlTdsXfwbrKJ0qVQt2M=@vger.kernel.org, AJvYcCXYp/Q6IQiPcgD79n0viVXNCoUgXiMuY+iEJ2c4J9nh9Y4FHch0pYPXRPkuY3OZR9hEFYwZfKFFKIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc8jkeMUiTsWbFAo/a6UMBvt4YIoAOEHT2Wo/dLamPN/Az57pb
	4TmG5BlQyRqm7fxe8EorYbhm694djjXAJBVPpqzhpnvjJroEQJNGzxgcSknJ/In5v8ZjHGiN4sj
	Lsl1JtIZGgr8+GqAg/SintF8yjFo=
X-Google-Smtp-Source: AGHT+IGG/hcyxa8S8kKpi22K2YfWARIiFkABqUSIB7oiuS84r0+705VX+sigsDNdT22dVcZEKacVJvLF2Xnj4RB9jsI=
X-Received: by 2002:a05:6871:a910:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2bd51572451mr16597022fac.12.1740673433017; Thu, 27 Feb 2025
 08:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <CAGETcx-ow3T_R_Lj1s3sjp6nQz6Wv7T3dQdP3HJHd+E8nkh6rw@mail.gmail.com>
In-Reply-To: <CAGETcx-ow3T_R_Lj1s3sjp6nQz6Wv7T3dQdP3HJHd+E8nkh6rw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Feb 2025 17:23:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g3qOvESqvqiCnwVz2BYGHzrG8=nRQ8j36Qd_LC0io_Tw@mail.gmail.com>
X-Gm-Features: AQ5f1JqSr_h3d_TxKsJqP5cWEiNZ9THfcg74f0QT47d8kIaL35zTbpSQxLDGg_8
Message-ID: <CAJZ5v0g3qOvESqvqiCnwVz2BYGHzrG8=nRQ8j36Qd_LC0io_Tw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 4:45=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Tue, Feb 25, 2025 at 8:46=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > Hi Everyone,
> >
> > Initially, this was an attempt to address the problems described by
> > Saravana related to spawning async work for any async device upfront
> > in the resume path:
> >
> > https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@goo=
gle.com/
> >
> > but then I realized that it could be extended to the suspend path and
> > used for speeding it up, which it really does.
>
> Btw, maybe I didn't  word it correctly, but my patch series was meant
> to speed up the non-async case too.

If "the non-async case" means the case with "async" suspend/resume
disabled entirely, I don't think that the ordering in which devices
are processed can be changed just because there are no known
dependencies.

> I was going to get around sending a v2 of my series, but was caught up
> with some other work. But I'm okay if you want to finish up my effort
> -- less work for me and I can focus on the other aspects of suspend :)
>
> Maybe add a Suggested-by: to the patches?

Yeah, I can do that.

> I definitely want to review the series, but very busy this week with
> some other work. I'll get to this next week for sure.

That should be fine.

> > Overall, the idea is that instead of starting an async work item for ev=
ery
> > async device upfront, which is not very efficient because the majority =
of
> > those devices will not be able to make progress due to dependencies any=
way,
> > the async handling is only started upfront for the devices that are lik=
ely
> > to be able to make progress.  That is, devices without parents in the r=
esume
> > path and leaf devices (ie. devices without children or consumers) in th=
e
> > suspend path (the underlying observation here is that devices without p=
arents
> > are likely to have no suppliers too whereas devices without children th=
at
> > have consumers are not unheard of).  This allows to reduce the amount o=
f
> > processing that needs to be done to start with.
> >
> > Then, after processing every device ("async" or "sync"), "async" proces=
sing
> > is started for some devices that have been "unblocked" by it, which are=
 its
> > children in the resume path or its parent and its suppliers in the susp=
end
> > path.  This allows asynchronous handling to start as soon as it makes s=
ense
> > without delaying the "async" devices unnecessarily.
> >
> > Fortunately, the additional plumbing needed to implement this is not
> > particularly complicated.
> >
> > The first two patches in the series are preparatory.
> >
> > Patch [3/5] deals with the resume path for all device resume phases.
> >
> > Patch [4/5] optimizes the "suspend" phase which has the most visible ef=
fect (on
> > the systems in my office the speedup is in the 100 ms range which is ar=
ound 20%
> > of the total device resume time).
> >
> > Patch [5/5] extend this to the "suspend late" and "suspend noirq" phase=
s.
> >
> > Thanks!

