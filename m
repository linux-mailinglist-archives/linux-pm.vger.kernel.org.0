Return-Path: <linux-pm+bounces-40992-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FD9D30051
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 12:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA22230D3BE8
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 10:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DB536166C;
	Fri, 16 Jan 2026 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1olQ8/h"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4469735FF54
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768561065; cv=none; b=i/CVe6JptVewiIDgtsA9ya6uF2yyUFHWMGTduXPz0nXbqe0C4FfUJ9JmGtzmsbc674z8eEj72d7fQOg65D03Qt1r9Zhi1SuqVLFhhtoUJchzn1BwjTlPgiKByDtPULXur+NLiB+unCgdQE/RWOuBgPO4pZSu78Fcq5UmHbr4cKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768561065; c=relaxed/simple;
	bh=chqBt1DErgWHAKraD9dL0AwQEhVOgew+10hoOyNQZeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar6SYNbvTZ1Bw8DKasX+zDNuI06ZNt0VKo+uto3AaP6wvc34UuRt+JQg1a5N10wpJxR5FoOftrPVoQ9uzhdsaJ+MTer+Sl93S0Eo+4eCteDo7JU5fEGJTYAT5SfULlY6tYaoVy9yilF0Mitz7d4qpzjv9OcRScQX8VYmtMoPqdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1olQ8/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE53CC2BCB3
	for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 10:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768561064;
	bh=chqBt1DErgWHAKraD9dL0AwQEhVOgew+10hoOyNQZeU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n1olQ8/hcXoA48JVCso5/h4Zd3NM8nAurSoLsjFrXB8ghKy5EyoWTDsLc5FiBchTE
	 GYYWNI6K2AQhFi6EGxPLycIYeYHOTNfAnGPEMpnBYg0PIddD8sqYtIpOWVoqBQ6FUf
	 paopBHme+/9sTzQmDCGHvgICoLrOskvbDO7kqtjujmDCm7OUZZAOPHj0gVgSNJohT8
	 kQ4vI+Cli/RmkqmnnReRvCh7sYD7yx7/nUGmVEikDLTvL700VgfXRLVKopveKlRlwf
	 Q8jNdAgdMP5dYTWe7IN77a9Oq0Os1rLWyCeipKcFKrgxTnC8YR92eqpzhjz+cXqyu/
	 S+7aNAHLIky6g==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7926d5dbdf7so15394907b3.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Jan 2026 02:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8P15T/JXlIdOaM7NlCpyTd5eInKD1Ib3Pilkt9PUNZK8kBSjP+hVZzmXWdayWmi/mTWwlVeXe+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyufcwEBnbc4NITj9v0FhX+IemEP8Ix1lEPzz21m3okYzZdmWQl
	n5Ricdkl+OPiFxea4X1cI4uLa9vWq0zoVl9JHpr7iW7DCIBXqRNsBjgtmV4TYhuYjTl057KGfBH
	sLs9j5OMb0Kxfc3ck9gKyljIu1Z2ZrHgBDUinngPyVA==
X-Received: by 2002:a05:690c:7288:b0:789:2be7:aec3 with SMTP id
 00721157ae682-793c5394166mr20601787b3.35.1768561064074; Fri, 16 Jan 2026
 02:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220-swap-table-p2-v5-0-8862a265a033@tencent.com>
 <20251220-swap-table-p2-v5-14-8862a265a033@tencent.com> <CAMgjq7AUz10uETVm8ozDWcB3XohkOqf0i33KGrAquvEVvfp5cg@mail.gmail.com>
 <20260114142921.1b47d27a3bb22b41ed0c5526@linux-foundation.org>
In-Reply-To: <20260114142921.1b47d27a3bb22b41ed0c5526@linux-foundation.org>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 16 Jan 2026 02:57:32 -0800
X-Gmail-Original-Message-ID: <CACePvbWTFmH2xyt+F62EfF0ASwrt7ojmfTktjkKov6TDmXDHcg@mail.gmail.com>
X-Gm-Features: AZwV_Qjp3HLup9eysx6hmj3CZ8ot9WjmM2Y5yq7MdmC5LjFWC_OH-ze-o9xpG1w
Message-ID: <CACePvbWTFmH2xyt+F62EfF0ASwrt7ojmfTktjkKov6TDmXDHcg@mail.gmail.com>
Subject: Re: [PATCH v5 14/19] mm, swap: cleanup swap entry management workflow
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, Baoquan He <bhe@redhat.com>, 
	Barry Song <baohua@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Youngjun Park <youngjun.park@lge.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Chris Mason <clm@meta.com>, 
	Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 2:29=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu, 15 Jan 2026 00:53:41 +0800 Kairui Song <ryncsn@gmail.com> wrote:
>
> > Is it convenient for you to squash this attached fix into this patch?
>
> Done, below
>
> > That's the two issues from Chris Mason and Lai Yi combined in a clean
> > to apply format, only 3 lines change.
>
> Let's cc them!
>
> > There might be minor conflict by removing the WARN_ON in two following
> > patches, but should be easy to resolve. I can send a v6 if that's
> > troublesome.
>
> All fixed up, thanks.
>
>
> From: Kairui Song <kasong@tencent.com>
> Subject: mm, swap: fix locking and leaking with hibernation snapshot rele=
asing
> Date: Thu, 15 Jan 2026 00:15:27 +0800
>
> fix leak, per Chris Mason.  Remove WARN_ON, per Lai Yi

That is a great catch. Thanks.

>
> Link: https://lkml.kernel.org/r/CAMgjq7AUz10uETVm8ozDWcB3XohkOqf0i33KGrAq=
uvEVvfp5cg@mail.gmail.com
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: Lai Yi <yi1.lai@linux.intel.com>
> Cc: Chris Mason <clm@fb.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

That small fix looks good to me.

Chris

