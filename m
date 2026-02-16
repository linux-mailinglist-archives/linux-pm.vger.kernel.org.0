Return-Path: <linux-pm+bounces-42685-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMZ3LB/NkmnxyAEAu9opvQ
	(envelope-from <linux-pm+bounces-42685-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 08:54:07 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 245AA141617
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 08:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A5AE30022DB
	for <lists+linux-pm@lfdr.de>; Mon, 16 Feb 2026 07:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E5261B8C;
	Mon, 16 Feb 2026 07:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEpbQrCq"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D108E571
	for <linux-pm@vger.kernel.org>; Mon, 16 Feb 2026 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771228443; cv=none; b=EMft51eYnekG1hqDY4a/3o6ed5WVJI4vNSHxfIy4oLQEL/kW6N+ABFHUc3shZkWW3CQoFl8Re0zm8zRiYwPB+BqgHZNcVzsCFQUGde5VZYC4PTGHdesHthg8tFPrrr82w/EOAk9/ENY1BLPeJzRG9DzIi2oiHRUuY/KIGlERazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771228443; c=relaxed/simple;
	bh=2eVmDcVj1nsV90zWk49FkYNaIDozDhsASTUVe5HHkg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCHkA/zpei+wQF6V7ajxVpUaKk0jPKIOWoPxtnhPmyYLEi9un2XXbOcTMa+xGsPU4nljWaFuQgnjbzxyBrVM1nV/JthGM5IO07MIrwuw9oz/Big7tW9VHDmUuPjyb9o9u+cSA6khJs3xfCxJEHMHHlUjmBNLkejihc6/8gM2laQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEpbQrCq; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a79ded11a2so18542925ad.3
        for <linux-pm@vger.kernel.org>; Sun, 15 Feb 2026 23:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771228442; x=1771833242; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I14tbVEH2syUi6Y61oy9PC2wsHETyhymJpQijnsyHLU=;
        b=lEpbQrCqStAEoabqIZs3cmpbcO9QjkRn4e/ISys0ML3FseyaVe7hQXv7uARRIroWSn
         GTO3BJC+N4Pb9KdibWMLvbilp9mO7pCuxffJbnIKfoMlJh0Xa/Doadl2y5ub7+BcKn0v
         bD2IiyoAFO8nsjMXxBy1R77isI0lBKILSsgDY4lDCGHqVl9lC1E0dE5fcAHyCuNqtXgS
         w3K4Pxm9qfY7uapSLET8C9vc1k6mRlx6h208hzFbSlYeXJF31xY7WWRPuZVOybDqMgsE
         ccpQT9+PhXtD2Z6fl3XOlpGcPmIvg/f2/Prr/JssngPjTInudNwCpbolwjzq2/pH0N5s
         +Cmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771228442; x=1771833242;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I14tbVEH2syUi6Y61oy9PC2wsHETyhymJpQijnsyHLU=;
        b=TW/dFpjl2EbcBoJ41GwY2qBMh+tf3dkX9qrmsKRWEUTp5n/TnTTYGxUHjERKs9QmNh
         pEpZnC9mHxBsvc3MHtYTASXC4dnprfAf56MM5W5MqjVx/mFQll4lZmsfUFLWNDAAp2YR
         5rW8vv1xbvLQGNPq8yNPR/PtsbVivLOe93Lmqo+6h4WeQ9JuY2A2nMjx08X4UrOHDYKV
         gjpM7QqU90RiG7NpOpCa1VWGghF6JhFkWUT0pLaOls9xum1yTLv0JO+ezDIngv/AKm+R
         xsgR0Eyvs5EhLyXO5Lx9037aJ8L5iFhh1sja/jX74/wZB+sRVe/7TcNVLnS6HzbCNg2X
         Uobw==
X-Forwarded-Encrypted: i=1; AJvYcCUiw7fQXrAZTnpGX7kCQuSO2F2NG6YOYafcW0fqHLMwYyS94HYBBCY1lxf1MutpRdCVLDbfDO+NTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf31SBKO/wFmm/iyJ2W5UrrcaN1dO29KF+doqrMoKPRk/mlQKb
	HdMoGsmiNoOUDAr3dzmZQSkloTUDETN33rAmtBbia7UF2Ht/d/d/R6j/H5Vty4zikgw=
X-Gm-Gg: AZuq6aKACPNApufs3tf0RiLWAMnrfVUsQgLEYYDyfzKyyI/U+8H8xI3eclJn8p2a4UV
	ktc8ioop/KHK9V8PpdN7tE8S2nE3r0pwapAlmA7TiE481jYvOzZT1GUqV/AAsEZOtyxIjGHiekk
	byl/uEC5QhZ9uXGm/Ufiticb0gbVUCgD9uMFlG52Vuy1dCr8JC6mdjGM5mgz+zzuYUI2e5HtnmJ
	WU6wWspL+sEq9fGDf6fLuyoSVE8ZmFGVHLY8/RHPDQXCToWuaCJPmYtNgPfhiKRIHtgtDV9gXVC
	HXsACNz9Ji0kW+dqCtjXNi2kNdmsIltt3AnfLD6/D2r9kofKiwmSNtQ5txvf1vwZTJMLOksI8Kx
	g8j2kkhR1lvmRc/gDyB4aw+Cg0o5FVaH2FQ7jz7s7rZ1JssRSuyV40K1wpzFv9A/4k3lFMCPndd
	ruMYZFB1UW6l8vau2fsmjGI1oKl3YidQnuif9Dh5RhYwdocwQ2e+hC7hdMfklJk6HKsXdarg==
X-Received: by 2002:a17:902:f788:b0:2a5:8c1c:744f with SMTP id d9443c01a7336-2ab505a3194mr114280125ad.40.1771228441729;
        Sun, 15 Feb 2026 23:54:01 -0800 (PST)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1aafb972sm58148685ad.88.2026.02.15.23.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 23:54:01 -0800 (PST)
Date: Mon, 16 Feb 2026 15:53:56 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Barry Song <21cnbao@gmail.com>
Cc: kasong@tencent.com, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, 
	Carsten Grohmann <mail@carstengrohmann.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
	Carsten Grohmann <carstengrohmann@gmx.de>
Subject: Re: [PATCH v3 3/3] mm, swap: merge common convention and simplify
 allocation helper
Message-ID: <aZLLaEXeVVB9277S@KASONG-MC4>
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
 <20260216-hibernate-perf-v3-3-74e025091145@tencent.com>
 <CAGsJ_4xpoC78KhYj_b18aVzjGcFGfXnpt7uLGvg7w1B4Y5cc2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4xpoC78KhYj_b18aVzjGcFGfXnpt7uLGvg7w1B4Y5cc2g@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42685-lists,linux-pm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 245AA141617
X-Rspamd-Action: no action

On Mon, Feb 16, 2026 at 03:34:54PM +0800, Barry Song wrote:
> On Mon, Feb 16, 2026 at 3:00 AM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > Almost all callers of the cluster scan helper require the: lock -> check
> > usefulness/emptiness check -> allocate -> unlock routine. So merge them
> > into the same helper to simplify the code.
> 
> Previously, when !cluster_is_usable(ci, order), we only called
> swap_cluster_unlock(). Now we do more work in this path:
> 
> 
> out:
>         relocate_cluster(si, ci);
>         swap_cluster_unlock(ci);
>         if (si->flags & SWP_SOLIDSTATE) {
>                 this_cpu_write(percpu_swap_cluster.offset[order], next);
>                 this_cpu_write(percpu_swap_cluster.si[order], si);
>         } else {
>                 si->global_cluster->next[order] = next;
>         }
>         return found;
> 
> I assume this is what you want to do as well, but can we add
> some explanation here?

Yes, that's fine. alloc_swap_scan_cluster is suppose to update the
percpu offset cache so if the cluster is not usable, writing
SWAP_ENTRY_INVALID to invalidate the cache might even be helpful
for future scan. At lease not harmful, I'll add some explanation,
comments.

> 
> Also, it would be better to add a comment that
> alloc_swap_scan_cluster() expects ci->lock to be held on
> entry and releases ci->lock before returning.

Thanks for the suggestion, I even thought about renaming the helper
to indicate it will try update the percpu offset and release the lock.
But didn't have a better idea to naming and we also have
alloc_swap_scan_list, leave the name untouched seems more consistent.

I'll just add some comment then.

