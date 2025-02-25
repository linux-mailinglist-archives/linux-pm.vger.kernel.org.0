Return-Path: <linux-pm+bounces-22939-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC56A44DEF
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 21:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05BC3162390
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 20:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E9519F41B;
	Tue, 25 Feb 2025 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F11lASdP"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9F190051;
	Tue, 25 Feb 2025 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740516076; cv=none; b=lvwYgO5HIatfsJvP2nIqsMNnmSb1e10S/Mef73YX4pq1PpK9UYH08SDSzjcuNuey9M3EVaVMdkbeFYIf4trQNVvATstC/4r85gVHdSKXtwvHTutpdWJsBESM+ddTmCN7TSm+8Mq3yhq1b1wJKgQ4D1nIk+pjzfqDQm8YDK19tO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740516076; c=relaxed/simple;
	bh=LiVhDem361FjqfGK+J/ahXdQ9J+E267lgyazNH2yhi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa5VSYogXQTzGfAcj5M5ARa9N6mW9iTfLXc5kovToga2HQV8758KUfsSILTnBkgLBiRKm1L/yipHGR/DrZrKmY6VY++5V655Or0rCcUd0X7hd7/3AdejDr/qybe2ZlKFPdll+d7kM1ECfK9HXftEUx/mHx51CqrOrtWSwKMpvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F11lASdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFDB4C4CEDD;
	Tue, 25 Feb 2025 20:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740516075;
	bh=LiVhDem361FjqfGK+J/ahXdQ9J+E267lgyazNH2yhi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F11lASdPbzXg7mANBVQlRFzgR/91x+1f1GT6nM7vqP3tiaT1nLvEG+0H/6bay/D3C
	 2soIDbmbAaMuP3MwJM1iEgNqSl2/9hxJRp3yU7vcobgtmGhUCeVe4BjgU0CCvZvDRX
	 XbyqqGNx3v6BjI+P/X0lbLNbDuCnIwpNFCNqfA9oo5mRHWeidzibV+RIVZdMW1S5P8
	 IvglkGpvI0stH2tuWkAz2Cxkyy8C2G3OV8lCC4PHk+FgAoop3MkQvWvQF3u8IlKKub
	 DTnucELvNjcipckaCJFqPRe6GvqL9PpICzd1ZIm4Ts/D7BfBc0Fg+QCESEd6U47QJB
	 QEOZySg+TtdWg==
Date: Tue, 25 Feb 2025 12:41:12 -0800
From: Kees Cook <kees@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"Harry (Hyeonggon) Yoo" <42.hyeyoo@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>, stable@vger.kernel.org,
	Yuli Wang <wangyuli@uniontech.com>,
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Pekka Enberg <penberg@kernel.org>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	GONG Ruiqi <gongruiqi1@huawei.com>
Subject: Re: How does swsusp work with randomization features? (was: mm/slab:
 Initialise random_kmalloc_seed after initcalls)
Message-ID: <202502251240.49E8674AD@keescook>
References: <20250212141648.599661-1-chenhuacai@loongson.cn>
 <CAB=+i9QoegJsP2KTQqrUM75=T4-EgGDU6Ow5jmFDJ+p6srFfEw@mail.gmail.com>
 <CAAhV-H7i=WJmdFCCtY5DgE2eN657ddJwJwHGK1jgLKRte+VnEg@mail.gmail.com>
 <Z68N4lTIIwudzcLY@MacBook-Air-5.local>
 <CAAhV-H5sFkdcLbvqYBGV2PM1+MOF5NMxwt+pCF9K6MhUu+R63Q@mail.gmail.com>
 <Z686y7g9OZ0DhT7Q@MacBook-Air-5.local>
 <202502190921.6E26F49@keescook>
 <CAJZ5v0hZZdRPwp=OgPw4w8r9X=VbL6Hn6R4ZX6ZujNhBmMV3_A@mail.gmail.com>
 <CAAhV-H5UaEbA0DrAUfROJoiatwrjsge4DNcVTJi=8vtk2Zn+tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5UaEbA0DrAUfROJoiatwrjsge4DNcVTJi=8vtk2Zn+tQ@mail.gmail.com>

On Tue, Feb 25, 2025 at 07:35:13PM +0800, Huacai Chen wrote:
> I have investigated deeper, and then found it is an arch-specific
> problem (at least for LoongArch), and the correct solution is here:
> https://lore.kernel.org/loongarch/20250225111812.3065545-1-chenhuacai@loongson.cn/T/#u

Ah-ha, so it seems like some system start was being incorrectly shared
between restoration image and hibernated image? Yeah, that's important
to fix.

> But I don't know how to fix arm64.

Is arm64 broken in this same way?

-- 
Kees Cook

