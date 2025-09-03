Return-Path: <linux-pm+bounces-33757-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0A6B42926
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 20:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E3A1BC3D22
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 18:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E61369963;
	Wed,  3 Sep 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEeSlw+1"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E943680AF
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 18:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925629; cv=none; b=hkdRUuJxPdo9qnkME/Jf4Wpb4ivc7xxgA5GQcvVVMG1RX74qG40s7pD99g0kcoO1t3kWNmEiSgHjH0gghY627Embo5WXtfZI+W1RvpnD+q2pQIBbOG9no4PPjOXqOgakqRV/zeVS7PWnsUCIPhoab0piIJ7S4GO9Cc4JFhA8YVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925629; c=relaxed/simple;
	bh=AyTP3kBXo8P0JXmkTH1DLFbM7+iYUa83Fu/JNx/gPG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIQPmBs8jUGrUbpzCYXKxX5IOywKF85Imjk8pUDopBGr4GQiK1+UFN33TtcflNAgPjpoNf/tqf97vBttf5QaqXtMdiNjcwVVhFgQgt9f0LewRvOyYGZIw9gP6Z0Cb+XFcKyQEWZiE5P6uH57W1FVVOB9l1XrZtxmLPncSD3DykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEeSlw+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D4AC4CEF4
	for <linux-pm@vger.kernel.org>; Wed,  3 Sep 2025 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756925629;
	bh=AyTP3kBXo8P0JXmkTH1DLFbM7+iYUa83Fu/JNx/gPG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vEeSlw+1qAhakGQJgDpOG9tcB2tZMp09JXg7DGklf0OEqguYl7Vy7AA2Z0XJHwU7a
	 newVqKtrRKDBjy5jE1T30LGAOLxAhGkjSPUqkcb1IFMhp+JV3JmWcLwoHrU6mbYOhr
	 3fgJ1oWlN0Re6Ba/NtDGDYG+VUIQz9U8rHTktRHkRHV6brYgGzzwOimGiTpuakLn4d
	 0vCizdPLEmP43Xnu345ii1U3rETkxc6GyzwvR8bxaYQMTAUZwi6GiGAku/yw2OaeK3
	 9xbySt+9sEujqkzDAScNoyCEyNAl2WidrAD05c0tuN/4zm9ZBoOQNvG4EbVC1baVpQ
	 12Ybfx+hezgVg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-61da7b78978so148569eaf.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Sep 2025 11:53:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkDrFLE58iPEt6q0jxECUBeO7mS/Vl782LQl/63jsCSZkLqC4wBO9AbWXuhqSbtlWykeTWLWvrDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe0gHSirYmSo26qlHU9DmGGWOM2CoqQlDgICSIyTenDU2beZZ6
	O7NlKCLgsybaNdl76Xy0xOgM0r79ee3Z/mYjOeR1V3T4+FpUppqcYi5vd5c/XgWjvLwYGp+FWk7
	0VYw43vuaI3RmfijQsiaAnycpuPGrBzI=
X-Google-Smtp-Source: AGHT+IHgk6zUYN4scxDDKLBZvSjzRQjWH3NZNuubQtWDIYJC9pTS17fsfAm/Y112y+Bpo8t5T+n5bw2CtC9q7RAeHmo=
X-Received: by 2002:a05:6820:1691:b0:61c:a11:ce92 with SMTP id
 006d021491bc7-61e33772f87mr7822408eaf.7.1756925628336; Wed, 03 Sep 2025
 11:53:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <40212796-734c-4140-8a85-854f72b8144d@panix.com>
 <27809ad9-2a35-475d-bef8-47a06e81d647@arm.com> <3d87a8c3-ecb9-4ee5-917c-f944915ee684@panix.com>
 <d23e3fe9-a8b8-49fd-8198-8868b41ee57f@arm.com> <03d67820-1e21-4361-b539-10b3ad346155@panix.com>
 <fbf349ec-f200-4eff-9a5b-6674a1eef52a@arm.com> <d9e8f92f-08d1-4006-accd-7a2b65b0bc6c@panix.com>
 <CAJZ5v0jmMbWjFZUZe56ZYzjsHYE1=fSb+5MWNLMN_K4ZCJPu+Q@mail.gmail.com> <e08a1424-6873-4c61-b97b-94c4e9a9077c@panix.com>
In-Reply-To: <e08a1424-6873-4c61-b97b-94c4e9a9077c@panix.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 3 Sep 2025 20:53:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iw0SZAZd9HvwZdT=kqPq0AUJp_8LjWA6byOX3K4BVjrg@mail.gmail.com>
X-Gm-Features: Ac12FXyeyjgMccLgUZ91VxR1W0LK7iCSkpha1t_K8IRoytCOG7pwS9cD1Mm5T8o
Message-ID: <CAJZ5v0iw0SZAZd9HvwZdT=kqPq0AUJp_8LjWA6byOX3K4BVjrg@mail.gmail.com>
Subject: Re: I think there's an issue with e3f1164fc9e ("PM: EM: Support late
 CPUs booting and capacity adjustment") if there's "holes" in your CPU topology
To: Kenneth Crudup <kenny@panix.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christian Loehle <christian.loehle@arm.com>, lukasz.luba@arm.com, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:43=E2=80=AFPM Kenneth Crudup <kenny@panix.com> wro=
te:
>
>
> Is there a way to distinguish between "offline cores" and
> "'non-'existent" cores?
>
> This way we could just skip the ones that "aren't" there, right?

I'm not quite sure about the underlying use case TBH.

The em_check_capacity_update() call may not be necessary on x86 at
all, but I need to double check.

> On 9/3/25 11:40, Rafael J. Wysocki wrote:
> > On Wed, Sep 3, 2025 at 8:39=E2=80=AFPM Kenneth Crudup <kenny@panix.com>=
 wrote:
> >>
> >>
> >> On 9/3/25 10:26, Christian Loehle wrote:
> >>
> >>> Yeah looks like we're dropping that debug message.
> >>
> >> Huh. Then I guess the whole thing's a non-issue after all- but that
> >> being said, the whole point of the reschedule is in case cores come up
> >> later, right? So in a case like mine, won't it just keep constantly
> >> rescheduling?
> >
> > It will, but that's a separate issue.
> >
> > I think that it needs to back off exponentially or something like that.
> >
>
> --

