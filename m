Return-Path: <linux-pm+bounces-43750-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CDmOTGLqml0TQEAu9opvQ
	(envelope-from <linux-pm+bounces-43750-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:07:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0231B21CD77
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 09:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57E3B3007E0D
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 08:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0481FC7FB;
	Fri,  6 Mar 2026 08:02:52 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE631AA94
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772784172; cv=none; b=f1I/oZyf/pkCpe/oCy4TFz4H1QIxhm8S7p6Sagxi87Rwibxxi/Bryud8er19nyxHuh2NioGRpxjEh+1+Ey9OUzbr5Wyl/2OvF1ClGNiIR+zbacmgUiNF/ftStsdNM+ANlYKjsJRspEi0MDWsdVA9Vjt+5dJDnxJEfMwncZbP/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772784172; c=relaxed/simple;
	bh=0j105S5AlXMqI3YyPRVJcY4f1L6wxq7Jkqet4Hhax0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnkS552pdBINStXiDH2lKuBhVPCAuQOzdOnNOQoUKBW3BCUnZIWefdSI2tKO+L9tyaUYpluxNiXwbfRvTIGo97vmBdHlSlB856BahuGF0Wv1Tyc08rgi5WrzXw4uaYvQyLgZL/KqLZ7HoTu+xD1derB//BLDxs2RYFz90fCIv+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 6 Mar 2026 17:02:45 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 6 Mar 2026 17:02:45 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Li <chrisl@kernel.org>
Cc: rafael@kernel.org, akpm@linux-foundation.org, kasong@tencent.com,
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2] mm/swap, PM: hibernate: hold swap device
 reference across swap operation
Message-ID: <aaqKJQeO8wLQL7Zn@yjaykim-PowerEdge-T330>
References: <20260306024608.1720991-1-youngjun.park@lge.com>
 <CACePvbXVvPp_a89UFztZo5nGawpFea9t=NRisf468VcxHgkX7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACePvbXVvPp_a89UFztZo5nGawpFea9t=NRisf468VcxHgkX7A@mail.gmail.com>
X-Rspamd-Queue-Id: 0231B21CD77
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43750-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,linux.dev,vger.kernel.org,kvack.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.955];
	TAGGED_RCPT(0.00)[linux-pm];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 10:55:15PM -0800, Chris Li wrote:
> On Thu, Mar 5, 2026 at 6:46 PM Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > Currently, in the uswsusp path, only the swap type value is retrieved at
> > lookup time without holding a reference. If swapoff races after the type
> > is acquired, subsequent slot allocations operate on a stale swap device.
> 
> Just from you above description, I am not sure how the bug is actually
> triggered yet. That sounds possible. I want more detail.

To be honest, I am not deeply familiar with the snapshot code, which is why
I submitted this as an RFC. However, I believe the race is theoretically
possible and I was able to trigger it with a simple PoC user program.

(not in-kernel swsusp as I think, cuz every user thread freezed
before creating snapshot, only on uswsusp)

The race occurs in `power/user.c`

1. snapshot_open() calls swap_type_of() to find the swap device.
2. We get the swap type, but hold no reference at this point.
3. [Race Window]: Another thread triggers swapoff() and swapon()
4. snapshot_ioctl(SNAPSHOT_ALLOC_SWAP_PAGE) is called.
   -> The swap device is gone or the type ID is reused by another device or 
      swap device is missing.

> Can you show me which code path triggered this bug?
> e.g. Thread A wants to suspend, with this back trace call graph.
> Then in this function foo() A grabs the swap device without holding a reference.
> Meanwhile, thread B is performing a swap off while A is at function foo().
> 
> > Additionally, grabbing and releasing the swap device reference on every
> > slot allocation is inefficient across the entire hibernation swap path.
> 
> If the swap entry is already allocated by the suspend code on that
> swap device, the follow up allocation does not need to grab the
> reference again because the swap device's swapped count will not drop
> to zero until resume.

You are right. Since the swap device is pinned once a swap entry is
allocated, we could indeed rely on that pinning mechanism to ensure safety
for subsequent allocations (instead of doing get/put every time).

However, relying on that pinning alone does not protect the window between
the initial lookup (step 1) and the *first* allocation.

My proposal is to grab the reference at the lookup point to close this
initial race. If we do that, I believe we can remove the per-slot
get/put calls entirely, as the initial reference is sufficient to keep the
device alive until the operation completes.

Regarding the reference release strategy in this patch:

1. uswsusp: The reference is released when the snapshot device file
   is closed(snapshot_release) and error paths.
2. not uswsusp`: I only added reference release in the error paths.

About 2.. I conclude that on a successful resume, the system state reverts to
the snapshot point, making an explicit release unnecessary. However,
I am not 100% certain if this holds true for the swap reference
context.

This part is the primary reason I submitted this as an RFC. I
would appreciate it if you could review this part specifically to
confirm whether my understanding is correct.

> > Address these issues by holding the swap device reference from the point
> > the swap device is looked up, and releasing it once at each exit path.
> > This ensures the device remains valid throughout the operation and
> > removes the overhead of per-slot reference counting.
> 
> I want to understand how to trigger the buggy code path first. It
> might be obvious to you. It is not obvious to me yet.

I hope the explanation above clarifies the trace. Please let me know if
there are still parts that are not obvious, and I will explain further or
investigate more.

Thank you for the review
Youngjun Park

