Return-Path: <linux-pm+bounces-35987-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAF5BD5A0F
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 20:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF9904E19D2
	for <lists+linux-pm@lfdr.de>; Mon, 13 Oct 2025 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDB62C327A;
	Mon, 13 Oct 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ja6NGDEG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD322C324E
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378569; cv=none; b=boyN94GA5NH18xIy/CnXetLi4WYFBI4arXf0W5CeJwTlpmh5abwtlG4AGURl3sqyGafnR7iimU4Q9pK68iMH0Ppq4isPXAfNDLo9LRJmZwMfepRcEMv6wkg3EUgKbizgUGCCjl0RDzed7lBDkqbpWnpuhWuQzGZ/QPYBmFOoVlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378569; c=relaxed/simple;
	bh=TZrmejsd8Qc3fDJmCwXu4pgxbU5JHhsZUr9HCGGMhZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx6WhtcPgkpm65wZVCxl5vL0evlHAAC53hw0AKXgnEBEQmv6lPCZDN77V+GI2+KOYRWxePFggO0kL9TUA+0ZXC4QVcr3s8IZ6BzGAq9kzPyHRQCCuDAkLrpBmyP3xDdQJNjA0YAxhIK1qtl2idoCA644bx/zAmZLeTrygf+Vkbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ja6NGDEG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4755DC4AF09
	for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 18:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760378569;
	bh=TZrmejsd8Qc3fDJmCwXu4pgxbU5JHhsZUr9HCGGMhZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ja6NGDEGw2bWivUD7A9S9+U/F5zzOuXqlNWFUirYeXeM2+kl9+GoGsojkNb8rFWj0
	 XO8id3Y4Pyf66NcgtxSmuUqPGLlyd57Ubf5n2/y3F77mnOAwKSy4OzBvSyW3YS4BUp
	 vov3w1+Q781uAhuk+OI/h9o4C268KlhXm0zlEAkQw7eiZwZWY1pelHyw+jW2Pg4BQg
	 fzxrZcWQ7T9vmFH7T2gS6c9IxXORFrBxYlWcVVpAvQPrthhcpLguojSpKNH5hTzRH2
	 efQ+ySKcZCDaAyOjVh6SK0NVova2cG85tdcq5DHRDUdh7kP0t3PiZZo/uxDmdmyLGy
	 Jhm5lTJIioZEg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-64d696840b6so2216705eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Oct 2025 11:02:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4c751VzffMTg4QATSX5VknuyaY2k2rHM2a1cykd48lA1w0YiDZLZcUqliEpPm4FW6xNjXApM6+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMa2x5y2bLkVwFOYHfbquko5sr2aQn41+r+EoCKRfrzrDxJNiL
	x/2KCSM8ohXgUy+uYWBckAmaRpHobFyQ1gXsb3YF4yDRpLeRIGJlC+qmw5ej1G1rDYWnA+OEUy+
	/Y4/T+8LaDVDV6MRv8l8a1A/gIqaNtlI=
X-Google-Smtp-Source: AGHT+IFIK2zIiCmWj+z9A7dT3po9xDzK8OpX2XnJhvOZyCE36wFbIZ5uE3AgirVRJCaMN5e9hRcn4AweDoTwpAwd9/M=
X-Received: by 2002:a05:6808:4489:b0:438:2852:73e4 with SMTP id
 5614622812f47-4417b417242mr9921285b6e.25.1760378568627; Mon, 13 Oct 2025
 11:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911185314.2377124-1-wusamuel@google.com> <CAG2Kctqf=Q+nuuDqzkrOpjp+tOttf079DS_R8Q0pHU-k8DmFvA@mail.gmail.com>
 <CAJZ5v0gtKmtiLQwi-2qaw2G4O4PF_iqz6UbUZuaknepcJ1ToZQ@mail.gmail.com>
 <CAG2KctrK0JrP7JNUyzF72JeDgR4-GSRmJDe+yEnav=gQCAf64Q@mail.gmail.com>
 <CAJZ5v0g_HXQjWfp=L0KetRCHMTD=QsP3wJKNZnadJic2yccCUQ@mail.gmail.com> <CAGETcx_Fn3AzZo7gNvJnPxy=CNHpqAviGdUrww++SGySuBcaZw@mail.gmail.com>
In-Reply-To: <CAGETcx_Fn3AzZo7gNvJnPxy=CNHpqAviGdUrww++SGySuBcaZw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Oct 2025 20:02:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hbtHxFo_z2fp9DMRDi75k6QL-kcDHD+o8zabub1YdCKg@mail.gmail.com>
X-Gm-Features: AS18NWBnExUTFz8drgQvQPDh4MrAL1rvfeQrbwyUnfskwOYDOQM_KjoZDN--p8A
Message-ID: <CAJZ5v0hbtHxFo_z2fp9DMRDi75k6QL-kcDHD+o8zabub1YdCKg@mail.gmail.com>
Subject: Re: [PATCH v4] PM: Support aborting sleep during filesystem sync
To: Saravana Kannan <saravanak@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Samuel Wu <wusamuel@google.com>, Len Brown <lenb@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 12:13=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
>
> On Wed, Oct 1, 2025 at 11:22=E2=80=AFAM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
> >
> > On Wed, Oct 1, 2025 at 12:37=E2=80=AFAM Samuel Wu <wusamuel@google.com>=
 wrote:
> > >
> > > On Tue, Sep 30, 2025 at 11:51=E2=80=AFAM Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Tue, Sep 30, 2025 at 8:30=E2=80=AFPM Samuel Wu <wusamuel@google.=
com> wrote:
> > > > >
> > > > > Hi Rafael,
> > > > >
> > > > > Just a friendly ping on this patch. Please let me know if there's=
 any
> > > > > feedback or if you'd like me to make any changes.
> > > >
> > > > Have you seen https://lore.kernel.org/all/20250909065836.32534-1-tu=
haowen@uniontech.com/
> > > > ?
> > > >
> > > > If so, what do you think about it?
> > >
> > > I was following this chain
> > > (https://lore.kernel.org/all/20250908024655.14636-1-tuhaowen@uniontec=
h.com/),
> > > where there is some ongoing discussion on converging the solution.
> > >
> > > Our changes aren't mutually exclusive, and tuhaowen can build changes
> > > on top of ours, even indicating:
> > > > I'm happy to work on this as a follow-up patch series after your ch=
anges land, or we could explore a unified solution that handles both scenar=
ios.
> >
> > That's fair.
> >
> > > These patchsets don't negate each other, so could we decouple these
> > > two patchsets since they address different issues?
> >
> > Well, I'm not sure if they are really different.  After all, this is
> > all about avoiding having to wait on an excessively long filesystem
> > sync during suspend.
>
> No, it's different. We don't mind a long filesystem sync if we don't
> have a need to abort a suspend. If it takes 25 seconds to sync the
> filesystem but there's no need to abort it, that's totally fine. So,
> this patch is just about allowing abort to happen without waiting for
> file system sync to finish.

OK, thanks for clarification.

> The other patch's requirement is to always abort if suspend takes 25
> seconds (or whatever the timeout is). IIRC, in his case, it's because
> of a bad disk or say a USB disk getting unplugged. I'm not convinced a
> suspend timeout is the right thing to do, but I'm not going to nack
> it. But to implement his requirement, he can put a patch on top of
> ours where he sets a timer and then aborts suspends if it fires.
>
> > I'm also not sure why it is being pursued to be honest.  Is setting
> > /sys/power/sync_on_suspend to 0 not regarded as a viable option?
>
> We do want to sync on every suspend. So, we don't want to turn it off
> completely.

I wonder why though.

If suspend/resume works reliably, syncing filesystems on every attempt
to suspend the system isn't particularly useful AFAICS.

