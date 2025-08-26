Return-Path: <linux-pm+bounces-33109-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E3B35D35
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 13:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034553B95FC
	for <lists+linux-pm@lfdr.de>; Tue, 26 Aug 2025 11:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3AF285CA9;
	Tue, 26 Aug 2025 11:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE+M895s"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD01A256B;
	Tue, 26 Aug 2025 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208526; cv=none; b=tlQbl7v+W5rXErSniTthshhheFXHlb4wEOlPoFJINtkSgieAbd7PzhVkDl14c50erGXEeOQmNNApf9uDplzvLGQH/5nOzB/d18G57S/wxMqdZHc++tb4rjdJm2DAfiUSVBIL+z82ayh3/CoYpQgrwmdynuLaMJGQvafHDL16xYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208526; c=relaxed/simple;
	bh=ddq8PtAcnbhRU79j5ZF0yjwZpeApRBwN/QBnxQXmLuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZCY8ZmzhOWftdG0mGD4FgtyIqwq/FPSesQrfef/xQRdCHOlkZVCmYX4qXQuvqIdef8TMqmhKPJVm50qy6p8SzsNdm8wOPfL+mASPRx5+bH1gBQwKiSlq5dQJCBi/8vktEiR+o8oShQsusLXHK7DomYUVk7eouzU4Ebm7UW6BTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE+M895s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22D5C4AF09;
	Tue, 26 Aug 2025 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756208524;
	bh=ddq8PtAcnbhRU79j5ZF0yjwZpeApRBwN/QBnxQXmLuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OE+M895sfE2wvK9df/swqIDcfzZmNXvlJ3qDXgvVn9s3HWvbSw2yDMKhy6vjJBtfr
	 Wv9EhOPQvilH6uJ4G/qFQmy4Mdr5Tmy+p3VH815uL6XrCuad1PV13fDR2kAZrkEpDc
	 xlws92mhVfferekXCzBFe0Mz47AGXh+6pv229RAnDlIVjEGhpzzYrHnEvVbSpVLyfX
	 qfjtZ+56u9man0PR6jrV3beO+/KGpP9vPmr6AHBIDkJlYCVJRaIAufgEPM9MjuIU/N
	 qzCwlBQXq7QbGzbGaN3QBqa4gZdc7yELKsKqzuVOP2p+98esuGVHyrgPzr0AC8P6en
	 9PXsHGtKJdvSA==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-743814bcca2so4336387a34.0;
        Tue, 26 Aug 2025 04:42:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVDQeu32F14fD0/yFQ+eQtnqbYIWLqW2QRMla2jXzz65FaknR6AcS9ADE15jWDIVwebgJRRmE7D9LI=@vger.kernel.org, AJvYcCXdHyg7X7BSQrM9SZ6OeUez6f5V/lRNTKzgN8imiTE85XLod1/kGWntOx48J0rhndNPvYnAUSyV5nP2AkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNNFGUTgMPC5MyHaHMJC+Td7o4hP4Ghh50CsD2UI+T1jEI2Dop
	7RN9pZ97Ini/7Yt4zb3ErLSMJQaAG9etC1jLkDyxRQ9iuCLeSgDj70bAS2bUW1LXsZVbWwbc9pf
	0gFgxIMKQmm8Na1g0Toxn0el/nIEnMXA=
X-Google-Smtp-Source: AGHT+IFQ2XeumGF9W4JXGKm5jlcVfvminsoQJd8mMVcdNxrIEkM2QVx63XLyxrWLY3oxXQgLXzx/nSt4pbY5VI3bhQk=
X-Received: by 2002:a05:6830:280d:b0:741:c2aa:5536 with SMTP id
 46e09a7af769-74535b18f44mr432709a34.2.1756208523886; Tue, 26 Aug 2025
 04:42:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826125541.7143e172c124.I9ecf55da46ccf33778f2c018a82e1819d815b348@changeid>
In-Reply-To: <20250826125541.7143e172c124.I9ecf55da46ccf33778f2c018a82e1819d815b348@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 Aug 2025 13:41:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_V259T07peaZWUEULzWjWhqsP2RQxL3bB=q-GtYfX1A@mail.gmail.com>
X-Gm-Features: Ac12FXwvstLJ5Z1EJnKgxOqFaTkUGkYS2f3wQi53VH9dCkYbqHcGmxgRHlu4150
Message-ID: <CAJZ5v0i_V259T07peaZWUEULzWjWhqsP2RQxL3bB=q-GtYfX1A@mail.gmail.com>
Subject: Re: [PATCH] PM: sleep: annotate RCU list iterations
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:55=E2=80=AFPM Johannes Berg
<johannes@sipsolutions.net> wrote:
>
> From: Johannes Berg <johannes.berg@intel.com>
>
> These iterations require the read lock, otherwise RCU
> lockdep will splat:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: suspicious RCU usage
> 6.17.0-rc3-00014-g31419c045d64 #6 Tainted: G           O
> -----------------------------
> drivers/base/power/main.c:1333 RCU-list traversed in non-reader section!!
>
> other info that might help us debug this:
>
> rcu_scheduler_active =3D 2, debug_locks =3D 1
> 5 locks held by rtcwake/547:
>  #0: 00000000643ab418 (sb_writers#6){.+.+}-{0:0}, at: file_start_write+0x=
2b/0x3a
>  #1: 0000000067a0ca88 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_it=
er+0x181/0x24b
>  #2: 00000000631eac40 (kn->active#3){.+.+}-{0:0}, at: kernfs_fop_write_it=
er+0x191/0x24b
>  #3: 00000000609a1308 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspe=
nd+0xaf/0x30b
>  #4: 0000000060c0fdb0 (device_links_srcu){.+.+}-{0:0}, at: device_links_r=
ead_lock+0x75/0x98
>
> stack backtrace:
> CPU: 0 UID: 0 PID: 547 Comm: rtcwake Tainted: G           O        6.17.0=
-rc3-00014-g31419c045d64 #6 VOLUNTARY
> Tainted: [O]=3DOOT_MODULE
> Stack:
>  223721b3a80 6089eac6 00000001 00000001
>  ffffff00 6089eac6 00000535 6086e528
>  721b3ac0 6003c294 00000000 60031fc0
> Call Trace:
>  [<600407ed>] show_stack+0x10e/0x127
>  [<6003c294>] dump_stack_lvl+0x77/0xc6
>  [<6003c2fd>] dump_stack+0x1a/0x20
>  [<600bc2f8>] lockdep_rcu_suspicious+0x116/0x13e
>  [<603d8ea1>] dpm_async_suspend_superior+0x117/0x17e
>  [<603d980f>] device_suspend+0x528/0x541
>  [<603da24b>] dpm_suspend+0x1a2/0x267
>  [<603da837>] dpm_suspend_start+0x5d/0x72
>  [<600ca0c9>] suspend_devices_and_enter+0xab/0x736
>  [...]
>
> Add the fourth argument to the iteration to annotate
> this and avoid the splat.

Yeah, good catch!

> Fixes: 06799631d522 ("PM: sleep: Make async suspend handle suppliers like=
 parents")
> Fixes: ed18738fff02 ("PM: sleep: Make async resume handle consumers like =
children")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> Honestly, not sure, maybe this should just be without _rcu?
> ---
>  drivers/base/power/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index dbf5456cd891..e80175486be7 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -675,7 +675,8 @@ static void dpm_async_resume_subordinate(struct devic=
e *dev, async_func_t func)
>         idx =3D device_links_read_lock();
>
>         /* Start processing the device's "async" consumers. */
> -       list_for_each_entry_rcu(link, &dev->links.consumers, s_node)
> +       list_for_each_entry_rcu(link, &dev->links.consumers, s_node,
> +                               device_links_read_lock_held())

There is a macro for this already in main.c, it is called
list_for_each_entry_rcu_locked().

>                 if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->consumer, func);
>
> @@ -1330,7 +1331,8 @@ static void dpm_async_suspend_superior(struct devic=
e *dev, async_func_t func)
>         idx =3D device_links_read_lock();
>
>         /* Start processing the device's "async" suppliers. */
> -       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node)
> +       list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> +                               device_links_read_lock_held())
>                 if (READ_ONCE(link->status) !=3D DL_STATE_DORMANT)
>                         dpm_async_with_cleanup(link->supplier, func);
>
> --

