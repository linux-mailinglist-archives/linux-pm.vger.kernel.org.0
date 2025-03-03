Return-Path: <linux-pm+bounces-23303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF7FA4BFDD
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 13:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD6181888330
	for <lists+linux-pm@lfdr.de>; Mon,  3 Mar 2025 12:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018F420E313;
	Mon,  3 Mar 2025 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOgzba7r"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC031FFC5D;
	Mon,  3 Mar 2025 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003725; cv=none; b=i88IRjupga3xLFUMQZrrN6bL3P8maxJ73hwC5dP8uVQzr4rfcZkdLvg//wHprkBWicg02SSSivbftAK1tZMC1bp+Wd4F5CqsBCosKD21T/GS2vZPnhv9jndOlPUUNc0LPQ51w4gRZyk8oMNzM3kRsWZ4S7FRFDGsUNPkEhciwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003725; c=relaxed/simple;
	bh=LGkSTeMJSL/cH0aAMd2yE3RYQtg8Y3v4p03/JAj8MYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtQqAUozqEZcyDm0hLoeRkht4ipFtGUFOHchKwXVNReYgTuWdkYXkpcNbYGyT0mAsxfCY59FyiSrVCMdEyEWaeEEFnftTS5u85hY1ufRV28NTO3MyzWppCC8Uii+slOwW/CvOW6TmWkpyo32GkLXeT3+womADNsjthLb+SJfRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOgzba7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C457C4CEE6;
	Mon,  3 Mar 2025 12:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741003725;
	bh=LGkSTeMJSL/cH0aAMd2yE3RYQtg8Y3v4p03/JAj8MYo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JOgzba7rumPUUt+3gteK8x9ZNSeO4vmIPUtBm/4n5NiPfAEtAv3KsduFjHVnRBvYP
	 nOKDVlscMErtbUIi+bBI0VzMzpkAQHIPXoOECKx8/WIUGqxZYjHwUaXGqwyRABKmtM
	 eAS3WHS5zm87hWMSDLJy8pBIbTsRIxCyZc4mNW/9375L8GqRPDA7O6X632u3avW3WR
	 mKY8t5FIvStnQXapBFA2toErN72CMdMS0VLnkzij/l/n6irK+NXPlezBgLOXVgxuZt
	 Uz0ZrSE9IHPnwUOuCiXFzgPgYABFL8qXwEG1xoNx3xytUjlp6eRzhIMVSUufLiP0Wz
	 /4VIdlGyXpwzA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f66bf7602eso261605b6e.3;
        Mon, 03 Mar 2025 04:08:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQ1/NjUNCSenugMWx7zURmhseK6c1pnsQUTNwlAm7REI0/qRhz6Fyciz5IrDn0irjWkLfeq0dobDE=@vger.kernel.org, AJvYcCWSGvc2TSWxYA01ocw0xcXIvWbuwU++B7/7L2S+Cti9ZBiQhhLZidQZo+uqJzbDYxOgI/4Ymf5t/RnD6/s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnf84Yp9MBfH1VShA0ttlt+MHSwH5VmWAsgyi6U6ugoVjljUPI
	A1vixVv52XlILr/GDnjutGayFnkW0meusftwDj5OTsyJn8EiNj1GvJK1sR1PyadjUKBY1fHtfSJ
	LnQGien/BhjmoY/uMk1KCPymaqdQ=
X-Google-Smtp-Source: AGHT+IHUr2H06n1lRN0NwMlgKxCbIFdOobcyUUosrvn5yqSQUt8nL0vKq4fIngd8cXxKK3Bb4uOrL2lghJ9judeG3LM=
X-Received: by 2002:a05:6808:1dd9:b0:3f6:6cbc:9326 with SMTP id
 5614622812f47-3f66cbc9559mr1342832b6e.29.1741003724512; Mon, 03 Mar 2025
 04:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13709135.uLZWGnKmhe@rjwysocki.net> <CAPDyKFoWeZNqODb5VdXfTEhxRJ0azSQPWhM3WCJ+iUeJ3rYQHw@mail.gmail.com>
In-Reply-To: <CAPDyKFoWeZNqODb5VdXfTEhxRJ0azSQPWhM3WCJ+iUeJ3rYQHw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Mar 2025 13:08:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0htK3V2uPvqczirL9WW2Pgip00VP6xd8pqbOKvCUPhSbQ@mail.gmail.com>
X-Gm-Features: AQ5f1JoHfqGi4iiLMoX4pE-Ttl2wrDwMHPv6jml-d3qFwq9ON_ye9RzblquNiDo
Message-ID: <CAJZ5v0htK3V2uPvqczirL9WW2Pgip00VP6xd8pqbOKvCUPhSbQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Johan Hovold <johan@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 1:07=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
>
> On Tue, 25 Feb 2025 at 17:46, Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
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
> >
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
>
> Thanks for the detailed description! Overall, the approach makes
> perfect sense to me too!
>
> I am certainly interested to hear Saravana's thoughts around this too.
>
> >
> > The first two patches in the series are preparatory.
>
> For these two, feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
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
>
> I will try to have a closer look at patch 3->5 later in the week.

Thank you and thanks for all of the other reviews!

