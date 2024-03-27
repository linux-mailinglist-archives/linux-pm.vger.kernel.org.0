Return-Path: <linux-pm+bounces-5517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B598188E760
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68FBB30203B
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD161411C3;
	Wed, 27 Mar 2024 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjnIYa2c"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3312D1FF;
	Wed, 27 Mar 2024 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547631; cv=none; b=PyStmjcjmxv1uoAR3iaIz9Y+i8Gmx/yE4kUmCP8E1ORWkbAn4Lv551oOUvPFKyxgu7OWNBSy0d69CPCyzJHyI/Ks0Qf2dq7+MdncU4WOOCI4dZaxJLM8DdCqJazQyW95ipWlwvs+0rhnfjK3RRrhjezVplFpvljvFZ1BJM5axhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547631; c=relaxed/simple;
	bh=qNeisbi6Dz2zeTtPdSJvVa+JO4E4G1uHjb8NUCE2dA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIlmjhELfJhHEf4aNCE+nzjsRGtNifmD3UY8Mnt2E8xBOTd3uPSfM591IEnfStiZX9krMIeg60HISl1kmtaG83NPJCsdSKAbHglWVbCKJx42Zd4SlgbHcz4VP3+m/I89jniMXjFIySDEKc9jUMTGYsXcGyZYvKJbSmZVtFqUoB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjnIYa2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F87C43390;
	Wed, 27 Mar 2024 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711547630;
	bh=qNeisbi6Dz2zeTtPdSJvVa+JO4E4G1uHjb8NUCE2dA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JjnIYa2cX9JJ1F6vqW0yJp8u+g/wIg4xEq8A63g305VnjP8N/K9/0RYv2UYMBJo+H
	 GWeGMLl+GTvdXR6taTCq2PJXGcCsH2JwQuMyGbWpKTUQAzkanCtVGW1WYSyGKqJtw3
	 UEH/meKM6fzIyVfOd5m7mMm7XdArvCGykhDcwVdC7TAyOmv3xUwtS3UxFfdvWUor6I
	 uzEB/fTLTc6xcAHk/SwjgBKygt6NdPejlj4wjqNs3MYz1CXfsa9eT8VBu6hdS7H4Hm
	 pZzH20g3Zv6Ov9PdjhZyEhN1vsTg6ERrGpowyM6UfPuUiC/FLPFeAsFGmjx9v+xPgH
	 2fbRqy1Udlr5A==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2228861376aso929130fac.0;
        Wed, 27 Mar 2024 06:53:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLrz9w4Z7RHqhR54GtwIqlPyabRqdiS2YQEwy9n5Rrgi/tcne6vSZB6/LV3RNUjZj3IrefcnaVpWAxcDofDQ7LIIpxIFbN
X-Gm-Message-State: AOJu0YxZRV9OZkSCacKMqdd9ejJRSPM0UAVoPCH6h2UfRVZ/bh10wRI/
	D1iCveDGy53v9mOxFjmg0rugFZJQBlCI3xdFKFodOWrLUvaPv8fY6yLvAzpRYgbAmA6U0bIJ2mY
	FfOxCVWr9STy8oFLnLNTQaOd5J1U=
X-Google-Smtp-Source: AGHT+IF5115FiPjKQ4NEyv6iptmNK2rn3eYHtI7CwXKpmgo74RVWcZLebtayVj7qY+/8JQntZQHoXyQaX9lBZP1Mics=
X-Received: by 2002:a05:6870:1591:b0:22a:5629:ac8 with SMTP id
 j17-20020a056870159100b0022a56290ac8mr7330099oab.4.1711547629764; Wed, 27 Mar
 2024 06:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212161615.161935-1-stanislaw.gruszka@linux.intel.com>
 <CAJZ5v0gw52e9zx36YgVLDO9jJw+80BP0e_C92kYyq-ys=f8pBw@mail.gmail.com>
 <ZeCtEUGQknfHegpR@linux.intel.com> <CAJZ5v0jGpzn8kO8P8w_QUvo7MaaVMpURDZjzcdB2DjPkRnSmBg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jGpzn8kO8P8w_QUvo7MaaVMpURDZjzcdB2DjPkRnSmBg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 27 Mar 2024 14:53:37 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i6TWwS8ARP5h+=v3UjXEs+oBzcdnFmc4nfQcYj8bn8=A@mail.gmail.com>
Message-ID: <CAJZ5v0i6TWwS8ARP5h+=v3UjXEs+oBzcdnFmc4nfQcYj8bn8=A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] thermal/netlink/intel_hfi: Enable HFI feature only
 when required
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Johannes Berg <johannes@sipsolutions.net>, 
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:24=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Feb 29, 2024 at 5:13=E2=80=AFPM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
> >
> > On Thu, Feb 29, 2024 at 04:18:50PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Feb 12, 2024 at 5:16=E2=80=AFPM Stanislaw Gruszka
> > > <stanislaw.gruszka@linux.intel.com> wrote:
> > > >
> > > > The patchset introduces a new genetlink family bind/unbind callback=
s
> > > > and thermal/netlink notifications, which allow drivers to send netl=
ink
> > > > multicast events based on the presence of actual user-space consume=
rs.
> > > > This functionality optimizes resource usage by allowing disabling
> > > > of features when not needed.
> > > >
> > > > Then implement the notification mechanism in the intel_hif driver,
> > > > it is utilized to disable the Hardware Feedback Interface (HFI)
> > > > dynamically. By implementing a thermal genl notify callback, the dr=
iver
> > > > can now enable or disable the HFI based on actual demand, particula=
rly
> > > > when user-space applications like intel-speed-select or Intel Low P=
ower
> > > > daemon utilize events related to performance and energy efficiency
> > > > capabilities.
> > > >
> > > > On machines where Intel HFI is present, but there are no user-space
> > > > components installed, we can save tons of CPU cycles.
> > > >
> > > > Changes v3 -> v4:
> > > >
> > > > - Add 'static inline' in patch2
> > > >
> > > > Changes v2 -> v3:
> > > >
> > > > - Fix unused variable compilation warning
> > > > - Add missed Suggested by tag to patch2
> > > >
> > > > Changes v1 -> v2:
> > > >
> > > > - Rewrite using netlink_bind/netlink_unbind callbacks.
> > > >
> > > > - Minor changelog tweaks.
> > > >
> > > > - Add missing check in intel hfi syscore resume (had it on my testi=
ng,
> > > > but somehow missed in post).
> > > >
> > > > - Do not use netlink_has_listeners() any longer, use custom counter=
 instead.
> > > > To keep using netlink_has_listners() would be required to rearrange
> > > > netlink_setsockopt() and possibly netlink_bind() functions, to call
> > > > nlk->netlink_bind() after listeners are updated. So I decided to cu=
stom
> > > > counter. This have potential issue as thermal netlink registers bef=
ore
> > > > intel_hif, so theoretically intel_hif can miss events. But since bo=
th
> > > > are required to be kernel build-in (if CONFIG_INTEL_HFI_THERMAL is
> > > > configured), they start before any user-space.
> > > >
> > > > v1: https://lore.kernel.org/linux-pm/20240131120535.933424-1-stanis=
law.gruszka@linux.intel.com//
> > > > v2: https://lore.kernel.org/linux-pm/20240206133605.1518373-1-stani=
slaw.gruszka@linux.intel.com/
> > > > v3: https://lore.kernel.org/linux-pm/20240209120625.1775017-1-stani=
slaw.gruszka@linux.intel.com/
> > > >
> > > > Stanislaw Gruszka (3):
> > > >   genetlink: Add per family bind/unbind callbacks
> > > >   thermal: netlink: Add genetlink bind/unbind notifications
> > > >   thermal: intel: hfi: Enable interface only when required
> > > >
> > > >  drivers/thermal/intel/intel_hfi.c | 95 +++++++++++++++++++++++++++=
----
> > > >  drivers/thermal/thermal_netlink.c | 40 +++++++++++--
> > > >  drivers/thermal/thermal_netlink.h | 26 +++++++++
> > > >  include/net/genetlink.h           |  4 ++
> > > >  net/netlink/genetlink.c           | 30 ++++++++++
> > > >  5 files changed, 180 insertions(+), 15 deletions(-)
> > > >
> > > > --
> > >
> > > What tree is this based on?
> >
> > v5: https://patchwork.kernel.org/project/linux-pm/list/?series=3D829159
> > it's on top of linux-pm master, but require additional net dependency,
> > which can be added by:
> >
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.gi=
t for-thermal-genetlink-family-bind-unbind-callbacks
> > git merge FETCH_HEAD
> >
> > and will be merged mainline in the next merge window.
> > So at this point would be probably better just wait for 6.9-rc1
> > when the dependency will be in the mainline, before applying this set.
>
> And that's what's going to happen, unless I have any additional
> comments on the patches.

Now applied as 6.10 material (with a minor change in the subject of
the last patch) and I'm assuming that Srinivas likes this.

