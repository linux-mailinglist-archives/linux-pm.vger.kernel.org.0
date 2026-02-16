Return-Path: <linux-pm+bounces-42682-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NwdEmO3kmlDwwEAu9opvQ
	(envelope-from <linux-pm+bounces-42682-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 07:21:23 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE501411C2
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 07:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21611300A8D8
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 06:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380C62D5C76;
	Mon, 16 Feb 2026 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcdkee6G"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5F19E97B
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 06:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771222880; cv=none; b=JjRK3jC9BNOKNlSZj/0ErEw8ASlaSTlF6LmqZ/2AyC+RecMqnI2BGEpQnPUD4PEZcXnIh1pJL4NqCo0RFYaApDBP7LxthliGepAwPjwHdAs4AjXIpxI3F+AlwLUYmxJ9cZRR5H6GcOrRz+uXET+VQpnFA7ZfN9r4GcXJFbkxpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771222880; c=relaxed/simple;
	bh=HRlJ5n1R99XLcAS+BQ9ghV0hCDdA4JHEulnwQB5H2wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tkstjg51afCECNcffWWtRZ1i/gYO9EvfiiqizC98WLhSuYNZcwq2PWhPDq1rYzYui2OIRNfZ2A3PLjZKqPaHrdFRNrbEJ67JcaPKTCXfj6LGB+LcYm+kSasNksZv/mUC5v053Fgkjavl1HpyaKvteO69lX2IwOABLUJgv3uutF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcdkee6G; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad22a5e245so6882165ad.2
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 22:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771222878; x=1771827678; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+B3VYFqqOtn4OFDnrRnwc7y2rxPOL/UksRHhaZ3LZ4U=;
        b=jcdkee6Gw95GOSgcrOnPgrM1wWQo4ZVKU3n/ay986yl9NeLKNNCMCbcscatcuYA1S3
         PG8sKLW2DnlRQByyx+t7X2f/twCmJXY9qmHxfG84rCJmE8n3Ip9mT/e02qVYkGhVU3t3
         GTZJILdrGWVf0US5zH5kaYLsJchTn2LxhMYgpx00AY+kZ+oN3tYD3bur+u2e02R8qf7S
         tjC3Tz7dXDE6GVhZGqABMm8QBmmyimEphHy8nX+YIbqGQ1Am27ZtWpdux2nahOJbdtbb
         KTamr1AUirTh/7Xt686sHxA45/wFDcTls29bBzBxkMt7GH3R3Ypp8C2Qq263Q9BMaFgB
         VvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771222878; x=1771827678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+B3VYFqqOtn4OFDnrRnwc7y2rxPOL/UksRHhaZ3LZ4U=;
        b=eh90+PPc6TfC/hkTTXPmLnM1utLFt/WhkdSHKJA96MQ8KFBshPCcmD549R4BswvS1Y
         A6dlM6YtVbbvQWhdrkp4qRWAZlz56hkC87jZRnPFB1j+0xobLROIRR9uPp3Gz4QiakuP
         zTaVbILrgjAr02PedtLOS6YMIxZ39MUqCbDPltLV+o2x14tUb+PDpwNvxVSeJ+wW1HPf
         i1sK3vsOb+X5sIYeq9pCh1HfmhnWcd4vIwIBcUOTKMs41TZ8pgRe1NEYGFSLH0NxNVud
         a/Idlvhf27A/MSN02HE3hLMStbNea1wh0g0cygrh5sHdbuiMI8/y82nIo+oo1WtB+ABG
         Od4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9zwjJ1xNdP+oGL7T06bYJ8N7dDVIws3hIIz5gH9GTH5yYC4MVs+KAm3iD5S4JSmEaWnz4EAcLhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzowxFprhtnuoxkZ4CcsneD5JP8aB1kjnuTKee7ODVnh4SRsiqT
	xdxVYT8KusJXlsvgFxvMyMwzw/WDHlWMYlqHTweiRuTJz0knYGafHZx8fj6qOIlVazM=
X-Gm-Gg: AZuq6aK4efXjWP2151agppD3Pu9GXXN9XhJwjq3p61Y0WtCTsR65S3hBpXAHhJfyyNb
	cweds/6zLjgz17y5uqKDHIQgJaV3zI+nfQAvjW/FsuvMGcqUc29ok73DgsVz7gEIzg3MnAwudrX
	r77sFjinlBzoDAiCqmmvEg2MsRFxMEhuQmp/B+EMDeYy+QcxuPkFKl+fKk8djtfW1AwlQFt/tk5
	LsKukB26+HTngc8XXBeWbPW5W0zjUmOdRC5OOe2OHa17ny14iagFabQgFa3bkIdF50AXTaFN3zl
	JAC1MmZYVdAGjGSWnQZbc3RiY6u7AtgEUccGd2e9x54CeTqPbGLxB6vlFJzjdjxi2/yen/yf+hX
	tHRD2qQj0X+jtcmbJA632cWhoK1dwU+RT7Hr7tXcOgAggOXsTXHIEqsu1rGjiFJHBaCc9dsBMIU
	8J8uAStsLg+YM48GNmlQ89gliyVLcLZBzIxkI13FBXdHFFXPQIaqbrvsol/So=
X-Received: by 2002:a17:903:298d:b0:296:2aed:4fab with SMTP id d9443c01a7336-2ab50519c2dmr97137435ad.23.1771222878384;
        Sun, 15 Feb 2026 22:21:18 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5bbcsm60375565ad.56.2026.02.15.22.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 22:21:17 -0800 (PST)
Date: Mon, 16 Feb 2026 14:21:12 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Barry Song <21cnbao@gmail.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: [PATCH v3 2/3] mm, swap: reduce indention for hibernate
 allocation helper
Message-ID: <aZK0B841VeaDQ5w4@KASONG-MC4>
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
 <20260216-hibernate-perf-v3-2-74e025091145@tencent.com>
 <CAGsJ_4ynCA_w4Xcwu1k=2Hw3bMnURBxC2FeZEzN+uzBp+9YJcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4ynCA_w4Xcwu1k=2Hw3bMnURBxC2FeZEzN+uzBp+9YJcw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42682-lists,linux-pm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[tencent.com,kvack.org,linux-foundation.org,kernel.org,huaweicloud.com,gmail.com,redhat.com,carstengrohmann.de,vger.kernel.org,gmx.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,linux-pm@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-pm];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DE501411C2
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 07:20:49AM +0800, Barry Song wrote:
> On Mon, Feb 16, 2026 at 3:00 AM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > It doesn't have to check the device flag, as the allocator will also
> > check the device flag and refuse to allocate if the device is not
> > writable. This might cause a trivial waste of CPU cycles of hibernate
> > allocation raced with swapoff, but that is very unlikely to happen.
> > Removing the check on the common path should be more helpful.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  mm/swapfile.c | 38 ++++++++++++++++++--------------------
> >  1 file changed, 18 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index 32e0e7545ab8..0d1b17c99221 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1936,27 +1936,25 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
> >
> >         /* This is called for allocating swap entry, not cache */
> >         if (get_swap_device_info(si)) {
> 
> 
> I guess we could further reduce indentation by doing:
> if (!get_swap_device_info(si))
>     goto fail;
> 

Agree, I think we can make it even simpler by having:

/* Return empty entry if device is not usable (swapoff or full) */
if (!si || !get_swap_device_info(si))
	return entry;

Then the `fail` label is also gone.

I'll post a v4 later today combined with your another suggestion. Thanks!

