Return-Path: <linux-pm+bounces-35990-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6DEBD5B21
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 570204EB1F1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22752D3EC0;
	Mon, 13 Oct 2025 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3Knjc/+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A92D3A6F
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760379940; cv=none; b=CFTe1I89aPiUH7GUl5i7olEUYUghVaDDaZpI03jgBCNOG0pgE0hYxc3GLT9gBNnSxJ2z/0ORYo/ARtumIvhoaE15VPyHOmHm7QJD6C+x0Qwy3wAee0+0vwF0mpqClbO5nDUIHdgAtiak6obd+f5rDpKJzhYmPLSa6f4jZiZAdZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760379940; c=relaxed/simple;
	bh=VV/21DPWmzE2JQhMY1y17kZphOs5loZocaHFfgHsgMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtTRNBhn45FrVEQEPvFW7tl6Wk+LONHQKKJIoC/pIaK/ygItmuuOFupThNAMVStcWpm2TF9ZdAWxQl9cEIoY9uJv3S2TWwuOgPSq2l+QkrDw2UmWGidCPxm/yLtdS3dKczwS9X+UGFYprKUy4vkBtcBo+yeDD8zHsNkB/Xp2qAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3Knjc/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28534C4CEFE
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760379940;
	bh=VV/21DPWmzE2JQhMY1y17kZphOs5loZocaHFfgHsgMo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b3Knjc/+ep/hPZDq//nuDuB8kvREi/2QsXfIHXN8+MZ/rSyBaoRO3kPK+OV92CVmQ
	 V/YI39FPKJb0zi1c5yOTerHLm7gXslpILzLs5EmgS9WfczjuvpnZk2z48eDE9tm40/
	 3RO4z2gwWIHThdHCOAIeDtizzqMxpN8P/47U45S0+do6UEujfw9EsE7yvD4vwCONnU
	 wQM53ujioFkH7s0dor5qcStkDS3tEmarOgVKgu1QJF+XaC8ReliVMV/yXFl5E0h8RU
	 bFkp3zCeLoOgntlrV/EYMONg0bjX+ZAt5dgeT2x2N8UmexvwJTixGPhZ92qLW1eW0l
	 h8bgSIlVhqBLA==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7afbcf24c83so1351282a34.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:25:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW8XlALH7xgs5nRw5h/a/rwvBAHq36AFC1J1OTloSKHIZ+ZkwGp/EUYmFrAdE7ORpVP3dxcNwDKSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQhe59x3WKDKY4/Y4o5kcHER8Fc+aa2KmWyY6mIOmL8iEMIcY/
	kqnuvQktXGY5gN1BJJv0yrZQ4XIGiG9H/wF7M5jUinaJFaGfmHycrKC76/sT0YE3H8tO8qhLLiU
	kyLUhBXqKlKRiu95etojzvqMQK9tszy0=
X-Google-Smtp-Source: AGHT+IFBkWddC08oGilHU6T5O6yA7yHRvW6pPKbfEiNe3azKZTA/wGjAeGdMf01atVgj6PF4S0fxbX/czTUUrOAUE4Y=
X-Received: by 2002:a05:6808:4fe7:b0:43d:270f:4b87 with SMTP id
 5614622812f47-4417b2bbca4mr10279983b6e.1.1760379939453; Mon, 13 Oct 2025
 11:25:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
 <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
 <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com>
 <CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com>
 <CAGETcx_Fn3AzZo7gNvJnPxy=CNHpqAviGdUrww++SGySuBcaZw@mail.gmail.com>
 <CAJZ5v0hbtHxFo_z2fp9DMRDi75k6QL-kcDHD+o8zabub1YdCKg@mail.gmail.com> <CAGETcx_XFUg7V5KEGF+eqDtmhbUoufs8xARhaB0KJeh7Lzaj0w@mail.gmail.com>
In-Reply-To: <CAGETcx_XFUg7V5KEGF+eqDtmhbUoufs8xARhaB0KJeh7Lzaj0w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:25:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h31=e8QfodNioB77Wc3xwRipea3mW9LeEibJSw6L-WuA@mail.gmail.com>
X-Gm-Features: AS18NWAatZMrq1gMlxm6GLA_VSpFuok-iOQPwKXoQ_kD_z9xJdn6wuJ6pjEK-qA
Message-ID: <CAJZ5v0h31=e8QfodNioB77Wc3xwRipea3mW9LeEibJSw6L-WuA@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 8:13=E2=80=AFPM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Mon, Oct 13, 2025 at 11:02=E2=80=AFAM Rafael J. Wysocki <rafael@kernel=
.org> wrote:
> >
> > On Thu, Oct 2, 2025 at 12:13=E2=80=AFAM Saravana Kannan <saravanak@goog=
le.com> wrote:
> > >
> > > On Wed, Oct 1, 2025 at 11:22=E2=80=AFAM Rafael J. Wysocki <rafael@ker=
nel.org> wrote:
> > > >
> > > > On Wed, Oct 1, 2025 at 12:37=E2=80=AFAM Samuel Wu <wusamuel@google.=
com> wrote:
> > > > >
> > > > > On Tue, Sep 30, 2025 at 11:51=E2=80=AFAM Rafael J. Wysocki <rafae=
l@kernel.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@goo=
gle.com> wrote:
> > > > > > >
> > > > > > > Hi Rafael,
> > > > > > >
> > > > > > > Just a friendly ping on this patch. Please let me know if the=
re's any
> > > > > > > feedback or if you'd like me to make any changes.
> > > > > >
> > > > > > Have you seen https://lore.kernel.org/all/20250909065836.32534-=
1-tuhaowen@uniontech.com/
> > > > > > ?
> > > > > >
> > > > > > If so, what do you think about it?
> > > > >
> > > > > I was following this chain
> > > > > (https://lore.kernel.org/all/20250908024655.14636-1-tuhaowen@unio=
ntech.com/),
> > > > > where there is some ongoing discussion on converging the solution=
.
> > > > >
> > > > > Our changes aren't mutually exclusive, and tuhaowen can build cha=
nges
> > > > > on top of ours, even indicating:
> > > > > > I'm happy to work on this as a follow-up patch series after you=
r changes land, or we could explore a unified solution that handles both sc=
enarios.
> > > >
> > > > That's fair.
> > > >
> > > > > These patchsets don't negate each other, so could we decouple the=
se
> > > > > two patchsets since they address different issues?
> > > >
> > > > Well, I'm not sure if they are really different.  After all, this i=
s
> > > > all about avoiding having to wait on an excessively long filesystem
> > > > sync during suspend.
> > >
> > > No, it's different. We don't mind a long filesystem sync if we don't
> > > have a need to abort a suspend. If it takes 25 seconds to sync the
> > > filesystem but there's no need to abort it, that's totally fine. So,
> > > this patch is just about allowing abort to happen without waiting for
> > > file system sync to finish.
> >
> > OK, thanks for clarification.
> >
> > > The other patch's requirement is to always abort if suspend takes 25
> > > seconds (or whatever the timeout is). IIRC, in his case, it's because
> > > of a bad disk or say a USB disk getting unplugged. I'm not convinced =
a
> > > suspend timeout is the right thing to do, but I'm not going to nack
> > > it. But to implement his requirement, he can put a patch on top of
> > > ours where he sets a timer and then aborts suspends if it fires.
> > >
> > > > I'm also not sure why it is being pursued to be honest.  Is setting
> > > > /sys/power/sync_on_suspend to 0 not regarded as a viable option?
> > >
> > > We do want to sync on every suspend. So, we don't want to turn it off
> > > completely.
> >
> > I wonder why though.
> >
> > If suspend/resume works reliably, syncing filesystems on every attempt
> > to suspend the system isn't particularly useful AFAICS.
>
> A lot of people's entire digital life is on their phone. Even if
> there's just 1% crash, when you look at that across billions of users
> it adds up to serious impact.
>
> Also, there are classes of devices where we do disable sync on suspend
> (I can't share specifics). So, this is not an arbitrary stance. For
> phones, we want to sync on suspend.
>
> Also, your question could be posed equally to laptops too. If suspend
> is reliable, then the laptop can always wake up at 3% battery, sync,
> and then shutdown. But that's a leap of faith none of us want to make.
> So, as long as we support sync on suspend, I think it makes sense to
> allow suspend aborts to happen more gracefully.

The sync on suspend may not prevent damage from happening when suspend
or resume crashes though.

On laptops it is mostly a mitigation for letting the battery run dry
while suspended due to the lack of safety there on the majority of
systems, but on phones that shouldn't be a problem AFAICS.

