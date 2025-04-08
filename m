Return-Path: <linux-pm+bounces-24937-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A05AA80CC3
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 15:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6E34C67A8
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C06816F858;
	Tue,  8 Apr 2025 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IfI593Ev"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62333D3B8;
	Tue,  8 Apr 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744119579; cv=none; b=TWs+2xfszxuUUxexb8/owcHMYjqp3aM1ndJmFySpEtg3U3o1P7E54C38A5OPrJCX4cNQWLnPuvMtxXMDcvWZ1Z54As2koalbLUGDTIrNg5CrDXpSm/LIwK/GCH5ops24D0LuefysKbC8X5cWyxkXCvbHlP4L7HKUlFCwqBrn6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744119579; c=relaxed/simple;
	bh=HttToARP7j6467LB5MDXYTxwhjrXTouE3rjDEn7PmNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds/FHpi2tr/kQHaY9j7SHk4kmskU1IEXWbP6qJiu2L31mIhE+98NqR74ADBiHyTlZw/pFZw9Ao7sxRMVTVkGIGbcd2LQRhZFt1hS//kqsSvAB1JuZIbFEupd5+rBJ6eRZDB5R/xZBnsxZXYm9zr2ae+D1JOu3ncDov0JjxcTfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IfI593Ev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8A6C4AF09;
	Tue,  8 Apr 2025 13:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744119579;
	bh=HttToARP7j6467LB5MDXYTxwhjrXTouE3rjDEn7PmNI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IfI593Ev556PqcAOcBlYIMxIodzPGOcauhvXFwdZds83yJZM/MpiR68rkYGH5NwqF
	 KfC+CTk0C7gkx7NxbVHitXtLhjanjh7c5UWPH6jVqSC6ONSrSFs/OMAr2fGLVHxY+X
	 Istzjhtd2Xvw60CRBmwCCDnPh6tDMrZANn+WYwHfCZR1HwwJaAq6VjQ409HNJeXT05
	 PGStInBdZUitZZ+ohhS3M7DH2eM3GaZ5cp44fLXPvFPkz1bBL/tfwVmJXE0b5UOT2Z
	 9GgNw5iGDZH868gJBZYryf4VBL6tVMJzyGXjS/c+J5RLe3zr3mRcubHJn0Qk0pwOVO
	 4KpG/X5wYdWrw==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6044db3b45bso565210eaf.1;
        Tue, 08 Apr 2025 06:39:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWL3JhrRkq6l6kvil2BXQBmzKP9h83FTd1gTuMHdeAdD+k1ZRvHap9MT0KTe68H9GeMEKEB9cxdw9Sk9Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Q2Atz9QKp7Zcs9fuoqCEuEPY7obJxEViP1doFLbn1ELtR4lZ
	xnPR/L7iHs6fYoAhK10O/QjlAye+vLDx5mHeZkbRM5nmyufqQFmfW62I/xjdsBP5vznzjkid9gC
	y7Cynsum2r1vik3ytLUVqDJ77ZHw=
X-Google-Smtp-Source: AGHT+IF7W0dt3yf29QKqB8ReLcSNegaHOTEJOzTvi8sf7wJNBeDKtBghKOKuH1KaNtdVEZQ2PjXfXYavd+hVe7L5mUs=
X-Received: by 2002:a05:6808:1644:b0:3f8:91d1:d950 with SMTP id
 5614622812f47-4004564e62dmr11075441b6e.38.1744119578533; Tue, 08 Apr 2025
 06:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <CAGETcx8VmzU9xy39=_QAQ0pf5fZY=EbGOKrdy0_wLEW1pQ2oKw@mail.gmail.com>
 <CAJZ5v0gXG+0CgBZTcxzenxHO-ah3YwFaQm6GHCeuyZT9CR=-zg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gXG+0CgBZTcxzenxHO-ah3YwFaQm6GHCeuyZT9CR=-zg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 8 Apr 2025 15:39:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gPb835UWcYSP5c3nkSi6J2H-HefQK2+Y-a5DasniPfNw@mail.gmail.com>
X-Gm-Features: ATxdqUF5wz7Byi3XDBrQBlvpDvVVSlyAJsgwUn6bnUPSLACOcY9_dSUpV5XboGI
Message-ID: <CAJZ5v0gPb835UWcYSP5c3nkSi6J2H-HefQK2+Y-a5DasniPfNw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 3:57=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Fri, Mar 14, 2025 at 10:06=E2=80=AFPM Saravana Kannan <saravanak@googl=
e.com> wrote:
> >
> > On Fri, Mar 14, 2025 at 6:24=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysock=
i.net> wrote:
> > >
> > > Hi Everyone,
> > >
> > > This is a new iteration of the async suspend/resume improvements work=
:
> > >
> > > https://lore.kernel.org/linux-pm/1915694.tdWV9SEqCh@rjwysocki.net/
> > >
> > > which includes some rework and fixes of the patches in the series lin=
ked
> > > above.  The most significant differences are splitting the second pat=
ch
> > > into two patches and adding a change to treat consumers like children
> > > during resume.
> > >
> > > This new iteration is based on linux-pm.git/linux-next and on the rec=
ent
> > > fix related to direct-complete:
> > >
> > > https://lore.kernel.org/linux-pm/12627587.O9o76ZdvQC@rjwysocki.net/
> > >
> > > The overall idea is still to start async processing for devices that =
have
> > > at least some dependencies met, but not necessarily all of them, to a=
void
> > > overhead related to queuing too many async work items that will have =
to
> > > wait for the processing of other devices before they can make progres=
s.
> > >
> > > Patch [1/5] does this in all resume phases, but it just takes childre=
n
> > > into account (that is, async processing is started upfront for device=
s
> > > without parents and then, after resuming each device, it is started f=
or
> > > the device's children).
> > >
> > > Patches [2/5] does this in the suspend phase of system suspend and on=
ly
> > > takes parents into account (that is, async processing is started upfr=
ont
> > > for devices without any children and then, after suspending each devi=
ce,
> > > it is started for the device's parent).
> > >
> > > Patch [3/5] extends it to the "late" and "noirq" suspend phases.
> > >
> > > Patch [4/5] adds changes to treat suppliers like parents during suspe=
nd.
> > > That is, async processing is started upfront for devices without any
> > > children or consumers and then, after suspending each device, it is
> > > started for the device's parent and suppliers.
> > >
> > > Patch [5/5] adds changes to treat consumers like children during resu=
me.
> > > That is, async processing is started upfront for devices without a pa=
rent
> > > or any suppliers and then, after resuming each device, it is started =
for
> > > the device's children and consumers.
> > >
> > > Preliminary test results from one sample system are below.
> > >
> > > "Baseline" is the linux-pm.git/testing branch, "Parent/child"
> > > is that branch with patches [1-3/5] applied and "Device links"
> > > is that branch with patches [1-5/5] applied.
> > >
> > > "s/r" means "regular" suspend/resume, noRPM is "late" suspend
> > > and "early" resume, and noIRQ means the "noirq" phases of
> > > suspend and resume, respectively.  The numbers are suspend
> > > and resume times for each phase, in milliseconds.
> > >
> > >          Baseline       Parent/child    Device links
> > >
> > >        Suspend Resume  Suspend Resume  Suspend Resume
> > >
> > > s/r    427     449     298     450     294     442
> > > noRPM  13      1       13      1       13      1
> > > noIRQ  31      25      28      24      28      26
> > >
> > > s/r    408     442     298     443     301     447
> > > noRPM  13      1       13      1       13      1
> > > noIRQ  32      25      30      25      28      25
> > >
> > > s/r    408     444     310     450     298     439
> > > noRPM  13      1       13      1       13      1
> > > noIRQ  31      24      31      26      31      24
> > >
> > > It clearly shows an improvement in the suspend path after
> > > applying patches [1-3/5], easily attributable to patch [2/5],
> > > and clear difference after updating the async processing of
> > > suppliers and consumers.
>
> A "no" is missing above, it should be "and no clear difference after
> updating ...".
>
> Also, please find attached a text file with sample results from 3
> different systems (including the one above), not for drawing any
> conclusions (the number of samples is too low), but to illustrate what
> can happen.
>
> While both Dell XPS13 systems show a consistent improvement after
> applying the first three patches, everything else is essentially a
> wash (particularly on the desktop machine that seems to suspend and
> resume as fast as it gets already).
>
> > >
> > > Note that there are systems where resume times are shorter after
> > > patches [1-3/5] too, but more testing is necessary.
> > >
> > > I do realize that this code can be optimized further, but it is not
> > > particularly clear to me that any further optimizations would make
> > > a significant difference and the changes in this series are deep
> > > enough to do in one go.
> >
> > Thanks for adding patches 4 and 5!
>
> No problem.
>
> > Let me try to test them early next week and compare your patches 1-3,
> > 1-5 and my series (which does additional checks to make sure
> > suppliers/consumers are done). I do about 100 suspend/resume runs for
> > each kernel, so please bear with me while I get it.
>
> Thanks and no worries, please take as much time as needed.  I will be
> traveling next week, so I'll be a bit slow to respond anyway.
>
> Since I've got a confirmation from internal testing (carried out on a
> much wider range of machines and much more extensively that I can do
> it myself) that patches [1-3/5] are overall improvement, I'm planning
> to queue them up during the 6.16 cycle and other improvements can be
> done on top of them, including patches [4-5/5].  I also think that
> adding explicit status tracking (if it turns out to make things faster
> measurably with respect to this series) on top of patches [4-5/5]
> would be rather straightforward.

As planned, I'm now going to add patches [1-3/5] to my linux-next branch.

