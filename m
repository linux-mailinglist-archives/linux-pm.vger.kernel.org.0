Return-Path: <linux-pm+bounces-43930-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPZoE+R5rmm2FAIAu9opvQ
	(envelope-from <linux-pm+bounces-43930-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 08:42:28 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F086234EB3
	for <lists+linux-pm@lfdr.de>; Mon, 09 Mar 2026 08:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B75733004600
	for <lists+linux-pm@lfdr.de>; Mon,  9 Mar 2026 07:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472FC368966;
	Mon,  9 Mar 2026 07:42:24 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C39368954
	for <linux-pm@vger.kernel.org>; Mon,  9 Mar 2026 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042144; cv=none; b=Gm5A9OefKlMwNjStDc/5VtqoChBKaEoBNNIunTbyB5BxwI3nJL4AbRLTKOfkQyTcfTiwajNb1Vpv3Aeoh0aj+fFNIOsgX7/ig5mjJWplllHXLDJhV8TgDNxodYI1eMgeERMG41W6wAta67YH3LwkT85tejns3/1vLNT+0qXYSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042144; c=relaxed/simple;
	bh=fs59aU4OalyXt+No0G2D8PynjL7MyccA1AVhyRkLYqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kh8N75/3aAkvqmEoToFUaOZbdi2duA6LRLUdcxqKlqkDn+cxbsZv1iBohDWFGFDLVX2PkMMS4c3jqKfS58JeG2zUhdo+SYv9oMi7LVhMlaYE7T4By0tyAX1mLs2KVroNRJ4SSmJcn/YfVP3G24P2EaOXhF1ipU8BgvE/KWMTwDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 9 Mar 2026 16:42:13 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Mon, 9 Mar 2026 16:42:13 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Chris Li <chrisl@kernel.org>
Cc: rafael@kernel.org, akpm@linux-foundation.org, kasong@tencent.com,
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
	linux-pm@vger.kernel.org, linux-mm@kvack.org, hyungjun.cho@lge.com,
	youngjun.park@lge.com
Subject: Re: [RFC PATCH v2] mm/swap, PM: hibernate: hold swap device
 reference across swap operation
Message-ID: <aa551UFgiq+gUl/T@yjaykim-PowerEdge-T330>
References: <20260306024608.1720991-1-youngjun.park@lge.com>
 <CACePvbXVvPp_a89UFztZo5nGawpFea9t=NRisf468VcxHgkX7A@mail.gmail.com>
 <aaqKJQeO8wLQL7Zn@yjaykim-PowerEdge-T330>
 <CACePvbVp=9PM=LUdL=aq8G2Svy+v04pBnf3ygRY+xW3WEHNm9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACePvbVp=9PM=LUdL=aq8G2Svy+v04pBnf3ygRY+xW3WEHNm9A@mail.gmail.com>
X-Rspamd-Queue-Id: 9F086234EB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43930-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,linux.dev,vger.kernel.org,kvack.org,lge.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.118];
	TAGGED_RCPT(0.00)[linux-pm];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 11:43:20PM -0700, Chris Li wrote:

> Agree. That place needs fixing. We will make two patches.
> 
> Patch 1. Fix the swap off  racing between lookup and first allocation
> on suspend.
> swap_type_of() is very tricky for the device swap because of the
> conditional lookup of the si->start_block matching the offset or not.
> That make this patch very complex.
> 
> One idea to brainstorm:
> 
> So we can get the reference count on during snapshot_open(), after
> checking "root_swap" still points to valid swsusp_resume_device.
> Then we release the reference count on "root_swap" during snapshot_release().
> 
> That might side step the complexity of  swap_type_of() doing the
> si->start_block checking.
> 
> It should fix the bug you described here more simply.

While that approach would be great as a minimal fix, I think we still
cannot avoid the following situation.

Until the first swap offset is allocated, we cannot guarantee that swapoff
won't happen. To be safe, I think it is difficult to prevent swapoff
without holding the swap_lock.

So, to stick to the minimal fix principle and only address the currently
possible bug in uswsusp, we could consider:

1) Creating a separate function to grab the reference for uswsusp, and
   put it in snapshot_close().
2) Adding a parameter to swap_type_of() to decide whether to acquire the
   reference or not, and put it in swsusp_close() 

On all strategies, we do not grab the
reference when taking an in-kernel snapshot, and do not add alloc/free
get/put.

> > My proposal is to grab the reference at the lookup point to close this
> > initial race.
> 
> That is my suggested patch 1.
> 
> > If we do that, I believe we can remove the per-slot
> > get/put calls entirely, as the initial reference is sufficient to keep the
> 
> I suggest that as the patch 2. It is an optimization to eliminate the
> get/put pairs. It is optional. without it is fine in terms of
> correctness. Might not worth the trouble for patch 2.

Yes, I agree. I will split the patch into two as you suggested and think
about it further.

> > device alive until the operation completes.
> >
> > Regarding the reference release strategy in this patch:
> >
> > 1. uswsusp: The reference is released when the snapshot device file
> >    is closed(snapshot_release) and error paths.
> > 2. not uswsusp`: I only added reference release in the error paths.
> 
> That part makes this patch complex and harder to review. Need to
> carefully check whether we take the reference count or not.
> 
> >
> > About 2.. I conclude that on a successful resume, the system state reverts to

> > the snapshot point, making an explicit release unnecessary. However,
> > I am not 100% certain if this holds true for the swap reference
> > context.
> 
> That is the part I try to avoid: the very fragmented error condition
> for reference counting.
> Hopefully, with patch 1 idea we don't need that complexity.

I agree with you.
But, I believe it can be a safe modification that can be sufficiently
verified through review.

I would love to hear the thoughts of the hibernation maintainers and other
reviewers on this. Although there are some complex parts, I think this
modification has clear benefits.

Thanks

Best regards,
Youngjun Park

