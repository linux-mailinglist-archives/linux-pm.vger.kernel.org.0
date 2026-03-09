Return-Path: <linux-pm+bounces-43926-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oF6DIxlsrmkvEAIAu9opvQ
	(envelope-from <linux-pm+bounces-43926-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 07:43:37 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D61E234508
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 07:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6689A300C247
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 06:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588AF3603F9;
	Mon,  9 Mar 2026 06:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sMPHdWE5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355D031077A
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773038613; cv=none; b=J0uMqBWI30PmMdEiaO+3Bn+F/tAX/T5WEZJ721VAr6DEK+YqjUrkh71PvNuBRhFzf0OLo03bdGT6Gt2h3zsr130rWXpSGD2adqNQT0/TxWY9DU+rKCtcivLbOX/yO5Yi8EQ84nLzXmb/bBaEpqnolSobX70Q4kkv7CmEPx0bDpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773038613; c=relaxed/simple;
	bh=Kd0fqfFX4RvUyiMDACbVyLY3TBDW007B4tQ5jKf2j4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZ6N/7B8j2q1lp+Qn37ZWiovEJkbeLRVxmGQzC4eiv3JFneu/U5ADTeojZ22HBJxZ6P9ByaCWyb84QKSDYTCTG+nMn6+7U3oCkVAVEQzU8MweUlu/oTVreesasJ7AljQrRsYM/CyESw+BY5hkmNmcboaK+7qpJgVM0GdVMVhpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sMPHdWE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EA4C19423
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 06:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773038612;
	bh=Kd0fqfFX4RvUyiMDACbVyLY3TBDW007B4tQ5jKf2j4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sMPHdWE5WkZSFYjJxVN7GaTjQP88iWcJQSSlFzuadDPUQQxKhkvW/RPoA9gjtubpc
	 FGS0F5KubKV4M0xZy10pq82vt7TZW6M87A+6ORc0lwiZfcIyomwpDaSDrncNLsVWb3
	 EipSgxlx36Mq1z0UwN4zcwmk6+WC+lMM2dZJVW+9jJ60TcliAf53kdc0Cpy9SUGq4R
	 8eovoXkOPM4VLOBsxwmqb1mJtId30jqk39Jj5Bw/H/SS25nJNRozgjQ5kt3VEmNKZD
	 BlPvhNqL8W/dvwknCdQ7OVVXbSkPJ1XwDbNkAv2aw1lhnEgV+uDSEIb0qOkwpWs8Xh
	 iQxxIlhX15r/w==
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ca423ad53so9926837d50.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Mar 2026 23:43:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgm/+6sPS6lx2Pj+dF7mpQmLd+G2MTgCJpa5FzIhZwTw81rVVwRadcD8RtLkqGFsJYFxXnvj4Z0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAh9gDgcyObnFbbV41M/+Tz+L42JPn2neIJlefIUqHYkysHdk5
	glt6rrXDIOfMpgn4YcAt/EutlRgzu+4Y9xunR2YZF2c6oHo75psiviowjSq//epxoDO+BuPgE0K
	ucjcuVNcqJvH4XdlqfC8oOb308Q+RPgltfDmAoCsXYQ==
X-Received: by 2002:a05:690e:b4e:b0:64c:ed9e:2e05 with SMTP id
 956f58d0204a3-64d141016e0mr9704019d50.25.1773038612056; Sun, 08 Mar 2026
 23:43:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306024608.1720991-1-youngjun.park@lge.com>
 <CACePvbXVvPp_a89UFztZo5nGawpFea9t=NRisf468VcxHgkX7A@mail.gmail.com> <aaqKJQeO8wLQL7Zn@yjaykim-PowerEdge-T330>
In-Reply-To: <aaqKJQeO8wLQL7Zn@yjaykim-PowerEdge-T330>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 8 Mar 2026 23:43:20 -0700
X-Gmail-Original-Message-ID: <CACePvbVp=9PM=LUdL=aq8G2Svy+v04pBnf3ygRY+xW3WEHNm9A@mail.gmail.com>
X-Gm-Features: AaiRm50l4FuBu88S4IZCYVq3PtusOGwnkdn1PQubplGv80j2zPfgBT3cIAgBGW8
Message-ID: <CACePvbVp=9PM=LUdL=aq8G2Svy+v04pBnf3ygRY+xW3WEHNm9A@mail.gmail.com>
Subject: Re: [RFC PATCH v2] mm/swap, PM: hibernate: hold swap device reference
 across swap operation
To: YoungJun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, kasong@tencent.com, 
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0D61E234508
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43926-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,linux.dev,vger.kernel.org,kvack.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 12:02=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Thu, Mar 05, 2026 at 10:55:15PM -0800, Chris Li wrote:
> > On Thu, Mar 5, 2026 at 6:46=E2=80=AFPM Youngjun Park <youngjun.park@lge=
.com> wrote:
> > >
> > > Currently, in the uswsusp path, only the swap type value is retrieved=
 at
> > > lookup time without holding a reference. If swapoff races after the t=
ype
> > > is acquired, subsequent slot allocations operate on a stale swap devi=
ce.
> >
> > Just from you above description, I am not sure how the bug is actually
> > triggered yet. That sounds possible. I want more detail.
>
> To be honest, I am not deeply familiar with the snapshot code, which is w=
hy
> I submitted this as an RFC. However, I believe the race is theoretically
> possible and I was able to trigger it with a simple PoC user program.
>
> (not in-kernel swsusp as I think, cuz every user thread freezed
> before creating snapshot, only on uswsusp)
>
> The race occurs in `power/user.c`
>
> 1. snapshot_open() calls swap_type_of() to find the swap device.
> 2. We get the swap type, but hold no reference at this point.
> 3. [Race Window]: Another thread triggers swapoff() and swapon()
> 4. snapshot_ioctl(SNAPSHOT_ALLOC_SWAP_PAGE) is called.
>    -> The swap device is gone or the type ID is reused by another device =
or
>       swap device is missing.

Ah, I see. Thanks for the explanation.

> > Can you show me which code path triggered this bug?
> > e.g. Thread A wants to suspend, with this back trace call graph.
> > Then in this function foo() A grabs the swap device without holding a r=
eference.
> > Meanwhile, thread B is performing a swap off while A is at function foo=
().
> >
> > > Additionally, grabbing and releasing the swap device reference on eve=
ry
> > > slot allocation is inefficient across the entire hibernation swap pat=
h.
> >
> > If the swap entry is already allocated by the suspend code on that
> > swap device, the follow up allocation does not need to grab the
> > reference again because the swap device's swapped count will not drop
> > to zero until resume.
>
> You are right. Since the swap device is pinned once a swap entry is
> allocated, we could indeed rely on that pinning mechanism to ensure safet=
y
> for subsequent allocations (instead of doing get/put every time).
>
> However, relying on that pinning alone does not protect the window betwee=
n
> the initial lookup (step 1) and the *first* allocation.

Agree. That place needs fixing. We will make two patches.

Patch 1. Fix the swap off  racing between lookup and first allocation
on suspend.
swap_type_of() is very tricky for the device swap because of the
conditional lookup of the si->start_block matching the offset or not.
That make this patch very complex.

One idea to brainstorm:

So we can get the reference count on during snapshot_open(), after
checking "root_swap" still points to valid swsusp_resume_device.
Then we release the reference count on "root_swap" during snapshot_release(=
).

That might side step the complexity of  swap_type_of() doing the
si->start_block checking.

It should fix the bug you described here more simply.

> My proposal is to grab the reference at the lookup point to close this
> initial race.

That is my suggested patch 1.

> If we do that, I believe we can remove the per-slot
> get/put calls entirely, as the initial reference is sufficient to keep th=
e

I suggest that as the patch 2. It is an optimization to eliminate the
get/put pairs. It is optional. without it is fine in terms of
correctness. Might not worth the trouble for patch 2.

> device alive until the operation completes.
>
> Regarding the reference release strategy in this patch:
>
> 1. uswsusp: The reference is released when the snapshot device file
>    is closed(snapshot_release) and error paths.
> 2. not uswsusp`: I only added reference release in the error paths.

That part makes this patch complex and harder to review. Need to
carefully check whether we take the reference count or not.

>
> About 2.. I conclude that on a successful resume, the system state revert=
s to
> the snapshot point, making an explicit release unnecessary. However,
> I am not 100% certain if this holds true for the swap reference
> context.

That is the part I try to avoid: the very fragmented error condition
for reference counting.
Hopefully, with patch 1 idea we don't need that complexity.

>
> This part is the primary reason I submitted this as an RFC. I
> would appreciate it if you could review this part specifically to
> confirm whether my understanding is correct.

BTW, I can review the swap part,  we also need to get the
suspend/resume maintainer (Rafael?) to review the suspend aspect of
this change as well.

>
> > > Address these issues by holding the swap device reference from the po=
int
> > > the swap device is looked up, and releasing it once at each exit path=
.
> > > This ensures the device remains valid throughout the operation and
> > > removes the overhead of per-slot reference counting.
> >
> > I want to understand how to trigger the buggy code path first. It
> > might be obvious to you. It is not obvious to me yet.
>
> I hope the explanation above clarifies the trace. Please let me know if
> there are still parts that are not obvious, and I will explain further or
> investigate more.

Yes you did. Thank you.

Chris

