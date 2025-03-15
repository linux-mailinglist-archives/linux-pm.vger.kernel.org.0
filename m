Return-Path: <linux-pm+bounces-24117-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33752A62E8D
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 15:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8BF87A678B
	for <lists+linux-pm@lfdr.de>; Sat, 15 Mar 2025 14:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193A31FFC4B;
	Sat, 15 Mar 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/s6USe4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BD91B4234;
	Sat, 15 Mar 2025 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050674; cv=none; b=GRB6WmcbF5ox1DJVtVmmlL+2DRUJNcSD+7f+KoX1ULeydmSPF4TcDAb63CRgMs/dNiqtmtd7U+0Ci++p5112dvvfZ+PWWxBqo0Vs1hPx1yImKrH2n746wfHZ4/IMN1dAwHnB7FtDAxdFyztLHKDY1/MhljKnnHJfm94dhGzHyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050674; c=relaxed/simple;
	bh=VAGcEkTA21upuXvwr1kQ3PnByIORGCDbW++j3x8AWAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtnJ8BCDcm3AEAAW5RqaPvvqL1vktOHOG3aDkd5bK9uJEMRxsH2QwVbzhtXJJeIG8GnStMurkFVNIlcFMsKuMs9+mj9S74pp+zO0CEBja9fvbhi2m4L3QIuVhLiQNuw0J0nPadXP7JkYgHLtnf42Z7dVT45kpGZ3gJHEc1DPVUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/s6USe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AED6C4AF09;
	Sat, 15 Mar 2025 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742050673;
	bh=VAGcEkTA21upuXvwr1kQ3PnByIORGCDbW++j3x8AWAs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b/s6USe4OK1g6LB5sM8h4Q9/0T0IB568pRk6PYnh1BksfPxI7Gup0YMkIqpL1zr0f
	 3NFxJx89KTKhl2MkV/tTxDIvHovLc0hKByDQrQRU4AjAI92FvSsBUUkPNZ7xfodOiA
	 79hZr5h4sz2DXBXy9WKDUDvud0fvGDylDdqBq36zxF0CNeYJ8UMExUqsLxQhNHfAdz
	 Hnzn2LBxR0f9kj7UPtYpwfIs7T6pDd0ILy2tSp9QlufUO2pGM7AL9vFxnpKyU4QgLK
	 lT3j8BzxALSOeRT2dQ7n4pEtgWRPcJ2ZzdOi8LtexqwOQbp0cQuuNp0V2igjL+L0mM
	 M0AXemjOgdOrg==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3f4890596so1707963b6e.2;
        Sat, 15 Mar 2025 07:57:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLfWcN6Dx7V+jwGcvxKVmFRgb70EhIMDRMvImnRqE6H5GvnKlANXxemDdAYFJP0KISJs8/hxe8fX5gnCk=@vger.kernel.org, AJvYcCXfjRIbOKnZ2ZuqLP47spoDjhIK+NDuJAmKKfs69u/5nu7i0UL9ezWyCEYr+VfQuvyjPAf+8YQ/ETs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5IS/s+5xzixnyARxJQSYOZdrVjVEhWV5vB1AjipTWtGZv8MY
	WiI6oceJ6QpU7Hho1YYq4doPRUSGTiLU7ydRvAxU1RhezCiswdj2FAe2yjud+puNfvF7kfQzp+g
	jd1W5HahrMZcnPIvxt3vK6+ggyvo=
X-Google-Smtp-Source: AGHT+IFtXlaQXRcbAUeBvfSA61J2gCJBOg1KbzrYBRTUvUPkIHmIZSDLtXFewyEXlGxqdUuAtBKd4BcGlUCIQ8LflRc=
X-Received: by 2002:a05:6808:1828:b0:3fa:53b5:6f87 with SMTP id
 5614622812f47-3fdf04592c0mr3568765b6e.34.1742050672591; Sat, 15 Mar 2025
 07:57:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10629535.nUPlyArG6x@rjwysocki.net> <CAGETcx8VmzU9xy39=_QAQ0pf5fZY=EbGOKrdy0_wLEW1pQ2oKw@mail.gmail.com>
In-Reply-To: <CAGETcx8VmzU9xy39=_QAQ0pf5fZY=EbGOKrdy0_wLEW1pQ2oKw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 15 Mar 2025 15:57:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gXG+0CgBZTcxzenxHO-ah3YwFaQm6GHCeuyZT9CR=-zg@mail.gmail.com>
X-Gm-Features: AQ5f1Jp0w9Tt0hvqJR7f0AX3YESUHYoYmItiba8gNUcvlIrCClt9FmqhkoQwQM0
Message-ID: <CAJZ5v0gXG+0CgBZTcxzenxHO-ah3YwFaQm6GHCeuyZT9CR=-zg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] PM: sleep: Improvements of async suspend and
 resume of devices
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jon Hunter <jonathanh@nvidia.com>
Content-Type: multipart/mixed; boundary="000000000000857917063062c7f4"

--000000000000857917063062c7f4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 10:06=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
>
> On Fri, Mar 14, 2025 at 6:24=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.=
net> wrote:
> >
> > Hi Everyone,
> >
> > This is a new iteration of the async suspend/resume improvements work:
> >
> > https://lore.kernel.org/linux-pm/1915694.tdWV9SEqCh@rjwysocki.net/
> >
> > which includes some rework and fixes of the patches in the series linke=
d
> > above.  The most significant differences are splitting the second patch
> > into two patches and adding a change to treat consumers like children
> > during resume.
> >
> > This new iteration is based on linux-pm.git/linux-next and on the recen=
t
> > fix related to direct-complete:
> >
> > https://lore.kernel.org/linux-pm/12627587.O9o76ZdvQC@rjwysocki.net/
> >
> > The overall idea is still to start async processing for devices that ha=
ve
> > at least some dependencies met, but not necessarily all of them, to avo=
id
> > overhead related to queuing too many async work items that will have to
> > wait for the processing of other devices before they can make progress.
> >
> > Patch [1/5] does this in all resume phases, but it just takes children
> > into account (that is, async processing is started upfront for devices
> > without parents and then, after resuming each device, it is started for
> > the device's children).
> >
> > Patches [2/5] does this in the suspend phase of system suspend and only
> > takes parents into account (that is, async processing is started upfron=
t
> > for devices without any children and then, after suspending each device=
,
> > it is started for the device's parent).
> >
> > Patch [3/5] extends it to the "late" and "noirq" suspend phases.
> >
> > Patch [4/5] adds changes to treat suppliers like parents during suspend=
.
> > That is, async processing is started upfront for devices without any
> > children or consumers and then, after suspending each device, it is
> > started for the device's parent and suppliers.
> >
> > Patch [5/5] adds changes to treat consumers like children during resume=
.
> > That is, async processing is started upfront for devices without a pare=
nt
> > or any suppliers and then, after resuming each device, it is started fo=
r
> > the device's children and consumers.
> >
> > Preliminary test results from one sample system are below.
> >
> > "Baseline" is the linux-pm.git/testing branch, "Parent/child"
> > is that branch with patches [1-3/5] applied and "Device links"
> > is that branch with patches [1-5/5] applied.
> >
> > "s/r" means "regular" suspend/resume, noRPM is "late" suspend
> > and "early" resume, and noIRQ means the "noirq" phases of
> > suspend and resume, respectively.  The numbers are suspend
> > and resume times for each phase, in milliseconds.
> >
> >          Baseline       Parent/child    Device links
> >
> >        Suspend Resume  Suspend Resume  Suspend Resume
> >
> > s/r    427     449     298     450     294     442
> > noRPM  13      1       13      1       13      1
> > noIRQ  31      25      28      24      28      26
> >
> > s/r    408     442     298     443     301     447
> > noRPM  13      1       13      1       13      1
> > noIRQ  32      25      30      25      28      25
> >
> > s/r    408     444     310     450     298     439
> > noRPM  13      1       13      1       13      1
> > noIRQ  31      24      31      26      31      24
> >
> > It clearly shows an improvement in the suspend path after
> > applying patches [1-3/5], easily attributable to patch [2/5],
> > and clear difference after updating the async processing of
> > suppliers and consumers.

A "no" is missing above, it should be "and no clear difference after
updating ...".

Also, please find attached a text file with sample results from 3
different systems (including the one above), not for drawing any
conclusions (the number of samples is too low), but to illustrate what
can happen.

While both Dell XPS13 systems show a consistent improvement after
applying the first three patches, everything else is essentially a
wash (particularly on the desktop machine that seems to suspend and
resume as fast as it gets already).

> >
> > Note that there are systems where resume times are shorter after
> > patches [1-3/5] too, but more testing is necessary.
> >
> > I do realize that this code can be optimized further, but it is not
> > particularly clear to me that any further optimizations would make
> > a significant difference and the changes in this series are deep
> > enough to do in one go.
>
> Thanks for adding patches 4 and 5!

No problem.

> Let me try to test them early next week and compare your patches 1-3,
> 1-5 and my series (which does additional checks to make sure
> suppliers/consumers are done). I do about 100 suspend/resume runs for
> each kernel, so please bear with me while I get it.

Thanks and no worries, please take as much time as needed.  I will be
traveling next week, so I'll be a bit slow to respond anyway.

Since I've got a confirmation from internal testing (carried out on a
much wider range of machines and much more extensively that I can do
it myself) that patches [1-3/5] are overall improvement, I'm planning
to queue them up during the 6.16 cycle and other improvements can be
done on top of them, including patches [4-5/5].  I also think that
adding explicit status tracking (if it turns out to make things faster
measurably with respect to this series) on top of patches [4-5/5]
would be rather straightforward.

--000000000000857917063062c7f4
Content-Type: text/plain; charset="US-ASCII"; name="async-suspend-resume.txt"
Content-Disposition: attachment; filename="async-suspend-resume.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m8abl42g0>
X-Attachment-Id: f_m8abl42g0

CUJhc2VsaW5lCQlQYXJlbnRzL2NoaWxkcmVuCURldmljZSBsaW5rcwoKCVN1c3BlbmQJUmVzdW1l
CQlTdXNwZW5kCVJlc3VtZQkJU3VzcGVuZAlSZXN1bWUKCkRlbGwgWFBTMTMgOTM2MAoKcy9yCTQy
Nwk0NDkJCTI5OAk0NTAJCTI5NAk0NDIKbm9SUE0JMTMJMQkJMTMJMQkJMTMJMQpub0lSUQkzMQky
NQkJMjgJMjQJCTI4CTI2CgpzL3IJNDA4CTQ0MgkJMjk4CTQ0MwkJMzAxCTQ0Nwpub1JQTQkxMwkx
CQkxMwkxCQkxMwkxCm5vSVJRCTMyCTI1CQkzMAkyNQkJMjgJMjUKCnMvcgk0MDgJNDQ0CQkzMTAJ
NDUwCQkyOTgJNDM5Cm5vUlBNCTEzCTEJCTEzCTEJCTEzCTEKbm9JUlEJMzEJMjQJCTMxCTI2CQkz
MQkyNAoKRGVsbCBYUFMxMyA5MzgwCgpzL3IJNDM5CTI4MwkJMzE4CTI5MAkJMzE5CTI5MApub1JQ
TQkxNQkyCQkxNQkxCQkxNQkyCm5vSVJRCTE5OAkxNzY2CQkyMDIJMTc0MwkJMjA0CTE3NjYKCnMv
cgk0MzkJMjgxCQkzMTgJMjgwCQkzMjAJMjgwCm5vUlBNCTE1CTIJCTE1CTEJCTE1CTEKbm9JUlEJ
MTk5CTE3ODEJCTIwMwkxNzgzCQkyMDUJMTc3MAoKcy9yCTQ0MAkyNzkJCTMxOQkyODEJCTMyMAky
ODMKbm9SUE0JMTQJMgkJMTUJMQkJMTUJMQpub0lSUQkxOTcJMTc3NwkJMjAyCTE3NjUJCTIwMwkx
NzI0CgpDb2ZmZWUgTGFrZSBEZXNrdG9wCgpzL3IJMTM4CTM0NwkJMTMwCTM0NQkJMTMyCTM0NApu
b1JQTQkxNQkyCQkyMAkyCQkxNQkyCm5vSVJRCTE1CTI1CQkyMwkyNQkJMTYJMjYKCnMvcgkxMzMJ
MzQ1CQkxMjQJMzQzCQkxMzEJMzQ2Cm5vUlBNCTE0CTEJCTEzCTEJCTEzCTEKbm9JUlEJMTUJMjUJ
CTE0CTI1CQkxNAkyNQoKcy9yCTEyNAkzNDMJCTEyNgkzNDUJCTEyOAkzNDUKbm9SUE0JMTMJMQkJ
MTMJMQkJMTMJMQpub0lSUQkxNAkyNQkJMTQJMjUJCTE0CTI2Cg==
--000000000000857917063062c7f4--

