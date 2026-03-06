Return-Path: <linux-pm+bounces-43738-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MSjARREqmlxOQEAu9opvQ
	(envelope-from <linux-pm+bounces-43738-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 04:03:48 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FB21AD4F
	for <lists+linux-pm@lfdr.de>; Fri, 06 Mar 2026 04:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 305FD302001A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Mar 2026 03:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD26A34FF50;
	Fri,  6 Mar 2026 03:03:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1B533C1B2
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772766223; cv=none; b=aRzGmpwoCVjDDUKRV9ZUGQJhCj2Rav+sgsm9tXbzq3amTSFnkWTBRNI8vE05NUKIQyFr5oTxgZJAK57cnDOxWgH11hx2eZTDR9Ms1JSLE+kI1HkguMa2RZd1lxiC8m4k6sG3zQd8ET9p52qdjiyArgA7F8oVqjVPRoCnmxzpb90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772766223; c=relaxed/simple;
	bh=weiEebIoW2u5SNe+2IQSVY36zRj6EyNqq/UynimqmOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnT0Efh54IjjkrtCY6PQEdZpyOvUcpqMhfqeYuKz+tFVGSwptCeEaeepYUd4uhED3Cd4cfBAjmxF5WUMa10jVMRnlG5yJzIC7/IdQedeBi1bpnrZ8L9dkL9XI8F8WY9onn3kahHZ3Ter0UZinABbOO1jiImXrbwKAvfsC4LbG4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 6 Mar 2026 11:48:11 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 6 Mar 2026 11:48:11 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-pm@vger.kernel.org, linux-mm@kvack.org, rafael@kernel.org,
	lenb@kernel.org, pavel@kernel.org, akpm@linux-foundation.org,
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org
Subject: Re: [RFC PATCH 0/2] kernel/power: fix swap device reference handling
 in hibernation swap path
Message-ID: <aapAa/A57D7pkASc@yjaykim-PowerEdge-T330>
References: <20260302165334.1278479-1-youngjun.park@lge.com>
 <20260305202413.1888499-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305202413.1888499-1-usama.arif@linux.dev>
X-Rspamd-Queue-Id: F38FB21AD4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43738-lists,linux-pm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,redhat.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.941];
	TAGGED_RCPT(0.00)[linux-pm];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lge.com:email]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 12:24:12PM -0800, Usama Arif wrote:
> On Tue,  3 Mar 2026 01:53:32 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> 
> > This series addresses two issues in the hibernation swap path.
> > 
> > First, grabbing and releasing the swap device reference on every slot
> > allocation is inefficient across the entire hibernation swap path.
> > 
> > Second, in the uswsusp path, only the swap type value is retrieved at
> > lookup time without holding a reference. If swapoff races after the
> > type is acquired, subsequent slot allocations operate on a stale swap
> > device.
> > 
> > The fix is to hold the swap device reference from the point the swap
> > device is looked up, and release it once at each exit path.
> > 
> >   Patch 1: Release the reference immediately after each slot allocation
> >             as a preparatory step.
> >   Patch 2: Lift the reference acquisition to the lookup site and place
> >             put_swap_device_by_type() at all relevant cleanup paths in
> >             swap.c and user.c.
> 
> Hello!
> 
> I cant comment on the feasibility of the approach, but for proper series,
> you would need to squash the 2 commits, otherwise it would break git
> bisectability.
> 
> Thanks

Thanks for the feedback. :D
I have squashed the commits as suggested and sent the v2 patch.

Best regards,
Youngjun Park

