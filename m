Return-Path: <linux-pm+bounces-38920-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB0C9466B
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 19:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7127F4E127A
	for <lists+linux-pm@lfdr.de>; Sat, 29 Nov 2025 18:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527AA221D9E;
	Sat, 29 Nov 2025 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BfVGAg9T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CC31A073F;
	Sat, 29 Nov 2025 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764440302; cv=none; b=hxLamyw1LINmktrNfNSi6DPkLaQdHYLZ2TUJZHSfWjYrEVivMoUlytR/MkJcuyvtWDcMpACwJoKLNb2tiasjydCG54J29fBH1ac3zHGbLDhcM9JQI+a21lXlxLz5U1hhVcJhbosbdh7cbNIkM9EoVMK8jovdfHXUIOlBdKclw3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764440302; c=relaxed/simple;
	bh=doTCiKgP3PeVk+fPUI2qFLmZO7TFN62HeeD54C5uMRg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n9u+v/7tMLvSMFq77tY+m9SLh8yoj+A5knxunJFD/2M7zjJcvqQhndWBEfMPhYj87pwU+jE0JP30+J01NilbPAzxu/0cdLl1wdSWdhcYV+GfMqs3ZjUpY+Sk9st4kcvzvZdoVaQOzGThlUk4DnmtxTMBaArU54R63WRvcc9BodU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BfVGAg9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15885C4CEF7;
	Sat, 29 Nov 2025 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764440301;
	bh=doTCiKgP3PeVk+fPUI2qFLmZO7TFN62HeeD54C5uMRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BfVGAg9T3vxHdcYOHMIN10Ajirn3UQT7XqxUxw/Ch0rkHbZC08VcQ5ueVWt60i2q4
	 aeecBO4UKbdITgqkjp2/inS3PMAU+N+LaI7azBnID6frTUlVj7/c+EbkA0lmSCz7KP
	 m4Y6+0Ddm6qGLofPeTWHPXPqLsth+4SSxdhfJ5fQ=
Date: Sat, 29 Nov 2025 10:18:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Chris Li <chrisl@kernel.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, Baoquan He
 <bhe@redhat.com>, Barry Song <baohua@kernel.org>, Nhat Pham
 <nphamcs@gmail.com>, Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand
 <david@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park
 <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, linux-kernel@vger.kernel.org, Kairui Song
 <kasong@tencent.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 00/19] mm, swap: swap table phase II: unify swapin
 use swap cache and cleanup flags
Message-Id: <20251129101820.3dd08b93b92fb2fd58159400@linux-foundation.org>
In-Reply-To: <CACePvbUK6uSDtz0QkBq-eqzQ_Hi9+t1gthGGt+ok7xdZtO1V8Q@mail.gmail.com>
References: <20251125-swap-table-p2-v3-0-33f54f707a5c@tencent.com>
	<CACePvbUK6uSDtz0QkBq-eqzQ_Hi9+t1gthGGt+ok7xdZtO1V8Q@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Nov 2025 21:07:40 +0400 Chris Li <chrisl@kernel.org> wrote:

> Can you add this swap table phase II series to mm-unstable for more
> exposure? The patch series has gone through V3, overall looks OK, but
> I have not finished reviewing them all yet. I will keep you posted
> when the series is fully reviewed.

Not on the eve of the merge window!

Please refresh, retest and resend shortly before -rc1 is released.

