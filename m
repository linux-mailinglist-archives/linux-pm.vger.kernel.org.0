Return-Path: <linux-pm+bounces-38933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8859C954C2
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 21:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DCF93A21D3
	for <lists+linux-pm@lfdr.de>; Sun, 30 Nov 2025 20:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0C2C08AC;
	Sun, 30 Nov 2025 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWa1ff2m"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368117B50A
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764535471; cv=none; b=uR4gKAQXKavVIhs4SKNHYf+sJYPvlVQhBkTHw2rK288ryIWpJOfjONnHuljlrRbWGxf6emD8kyQSeZrQ5QcGgtbF6PCsm3o3Ga1CmsSRKQBiFyaSbueD6kQ/rQN1IItgmUZfi0kXl1ISK9iEVx4VF+R+3geRT25buEkQhqnTuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764535471; c=relaxed/simple;
	bh=10Cdt34RCx935w4umu4sSDL1avAInz+1CdF2bZgGu6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWDPaZFkuaxZNuw3DonIdvEim9cdEossTso4lN1YPtfe1mAm4VQOrZipxbPlxWZ6WNE6MauRtFtP9FSZUg/PLuPgjB7SfYIRkjR0RchCnpkr8++bpWSR0+27F3mREOeBiLHoYQeeHkG44XfBOWOol1FL1Y3Rg7FwhUnjaoBlgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWa1ff2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C756C4CEF8
	for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764535471;
	bh=10Cdt34RCx935w4umu4sSDL1avAInz+1CdF2bZgGu6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BWa1ff2mBVJ4ElH2wgUU2QUq945AWnZV+fGZG5QnlY4YwB6P5+w+phxzeWeo0G1aL
	 JirWC5Jz/gkgTlnLGcMTpJEWMMoo/wpqtEaCTH9v+IXLxQUhqBGBa14Bzqn8WT60BX
	 ZitfFqnC9Wp4MTo2KWxirlXNPR9HyJWmAi+F3rDQpxxLH7d2gkNpEpbyBk9ad7zTxr
	 97fqj05gk/qtPM3/fFDSfN7jdXAWpsABg2VDfFyOYNq1b6qybViR+RxEhFmplGnmyB
	 b6CMKn5g0A+KXcq7flTuZS+D9zBxpHM915FQUGBYnkuUkYVjK2hUFy3r+yPGqCJXyk
	 tTXrEivdU/i4Q==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7895017c722so31760037b3.2
        for <linux-pm@vger.kernel.org>; Sun, 30 Nov 2025 12:44:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV++8mipM3g+aJqUrEJp05Vo4bL0Y9KxyqHJLrG0Vg5r3twdd6V2F7/CPMb1b+oGULUzA+KwFM6BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YymtCcUIzT3xZ1IdU/RM8G8RmNOtEP5X9s9h3jJRGo1wMfg+EY5
	izjfMwfpYtUMYPo+5FyWt88JmUHcX/0x7Gzra/ASp3A8C7WLQpQbxLr94JiunMpL1Y1uTh9dJPi
	koFh29ASZdy4sePHRbgp+qjkkTeZzv/dZoieQ1BnADQ==
X-Google-Smtp-Source: AGHT+IExQ1AJAY7f4dN+Xk02ncFxir6zbdLyjYYpQBva9zYNDSKSUibUyNy4if+53Ez2svcwcs5wB7kEQOEjSzjM/I4=
X-Received: by 2002:a05:690c:81:b0:788:c21:b05c with SMTP id
 00721157ae682-78ab6fc6e40mr180821677b3.63.1764535470463; Sun, 30 Nov 2025
 12:44:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-swap-table-p2-v3-0-33f54f707a5c@tencent.com>
 <CACePvbUK6uSDtz0QkBq-eqzQ_Hi9+t1gthGGt+ok7xdZtO1V8Q@mail.gmail.com> <20251129101820.3dd08b93b92fb2fd58159400@linux-foundation.org>
In-Reply-To: <20251129101820.3dd08b93b92fb2fd58159400@linux-foundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Mon, 1 Dec 2025 00:44:19 +0400
X-Gmail-Original-Message-ID: <CACePvbUfCFEqeh_Xa1D2Eh9US69_ENjCGYCKq4yGzZsyUnx00g@mail.gmail.com>
X-Gm-Features: AWmQ_bllixhFCPl1U1P18L2vmi0WIH3n7TKKxSGRCV4IyaaHJQUy9dLvNW4goLU
Message-ID: <CACePvbUfCFEqeh_Xa1D2Eh9US69_ENjCGYCKq4yGzZsyUnx00g@mail.gmail.com>
Subject: Re: [PATCH v3 00/19] mm, swap: swap table phase II: unify swapin use
 swap cache and cleanup flags
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 10:18=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sat, 29 Nov 2025 21:07:40 +0400 Chris Li <chrisl@kernel.org> wrote:
>
> > Can you add this swap table phase II series to mm-unstable for more
> > exposure? The patch series has gone through V3, overall looks OK, but
> > I have not finished reviewing them all yet. I will keep you posted
> > when the series is fully reviewed.
>
> Not on the eve of the merge window!

Sorry I didn't realize we are at the eve of the merge window already.
Time flies.

> Please refresh, retest and resend shortly before -rc1 is released.

Will do.

Chris

