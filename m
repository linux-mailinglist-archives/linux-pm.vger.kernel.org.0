Return-Path: <linux-pm+bounces-43706-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJtJHH/mqWnuHQEAu9opvQ
	(envelope-from <linux-pm+bounces-43706-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 21:24:31 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E7C2181E3
	for <lists+linux-pm@lfdr.de>; Thu, 05 Mar 2026 21:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 279E0300BCAC
	for <lists+linux-pm@lfdr.de>; Thu,  5 Mar 2026 20:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72D3334C27;
	Thu,  5 Mar 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="psK4wZaX"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02881FF7B3
	for <linux-pm@vger.kernel.org>; Thu,  5 Mar 2026 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742264; cv=none; b=OwDvlpg8PLQzYsXdc9IShzhkGD6oPk6/3ChwNFa+5Emr62vAduLOONjeGvz8IM2E2KcskwNjMkgdCyHZ19Q/Xu/55y/woVEm4sbFD34KWjORLNprnW0x2i/FawcgFK4VoXleXGoRl54mc3F7nH1CEGF7pKiJxn7Mx9JOYs4u3/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742264; c=relaxed/simple;
	bh=xdY8MLKtL7iezdtBmG7p3ZtPy9zVMN4MvTKHbayVyf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYqI8iEGvCIhswi31Qxdxpx4ShBbDJkP6MC6QAXwftFexGiJa5IUL37R0w8iM9vAR+1GSBdHCHtfDjnMR1xsdJbe6m2N1R5eg5uQgKwYjL9cp6b1rOew855vo6aXiGDCB1HrPb5RrLCS5ASAEAqQff6MH+GRzZaZI0eItzkhfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=psK4wZaX; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772742261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BH82XF0wTs4O8E0ts/qJuVTlWmsqTS6pY4Qf35UCzxM=;
	b=psK4wZaX0AmqORIgObeuNszbt4Pdwr0bMkPwaWwRwIBjVysaU8pBe4d787ivtWp7tUxiqY
	OkkErAEvNgWYky73318wD6+bPwz88xYnByfkrTyDzCRbV8TVgnWf7qT1gn5T9QEjpp/vYD
	n8hkJKvQnTrW5/s639LPUxPugJvPLns=
From: Usama Arif <usama.arif@linux.dev>
To: Youngjun Park <youngjun.park@lge.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org
Subject: Re: [RFC PATCH 0/2] kernel/power: fix swap device reference handling in hibernation swap path
Date: Thu,  5 Mar 2026 12:24:12 -0800
Message-ID: <20260305202413.1888499-1-usama.arif@linux.dev>
In-Reply-To: <20260302165334.1278479-1-youngjun.park@lge.com>
References: 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 64E7C2181E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-43706-lists,linux-pm=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,tencent.com,huaweicloud.com,gmail.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[usama.arif@linux.dev,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On Tue,  3 Mar 2026 01:53:32 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> This series addresses two issues in the hibernation swap path.
> 
> First, grabbing and releasing the swap device reference on every slot
> allocation is inefficient across the entire hibernation swap path.
> 
> Second, in the uswsusp path, only the swap type value is retrieved at
> lookup time without holding a reference. If swapoff races after the
> type is acquired, subsequent slot allocations operate on a stale swap
> device.
> 
> The fix is to hold the swap device reference from the point the swap
> device is looked up, and release it once at each exit path.
> 
>   Patch 1: Release the reference immediately after each slot allocation
>             as a preparatory step.
>   Patch 2: Lift the reference acquisition to the lookup site and place
>             put_swap_device_by_type() at all relevant cleanup paths in
>             swap.c and user.c.

Hello!

I cant comment on the feasibility of the approach, but for proper series,
you would need to squash the 2 commits, otherwise it would break git
bisectability.

Thanks

