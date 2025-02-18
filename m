Return-Path: <linux-pm+bounces-22341-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1826A3A7CD
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 20:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 289A217386B
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931CB1E835B;
	Tue, 18 Feb 2025 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptGHWqc2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32E1E8354;
	Tue, 18 Feb 2025 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739907654; cv=none; b=Ozvl9L3pgvKxesUupoDftUt90hjU5QDSht/YkIx7actJN5oRemVoB2r/8KJvQ8EKoKSj58FsCngncJwsV8aOXaImgRkNkW8OZc3vAJ+7dIUqqq0ByQjw4nFaZhTSHb2Dh6DW1XzGgtyByrce/AT+Kc2uRvjcwMCzdGJ11IB4ZEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739907654; c=relaxed/simple;
	bh=Mix1Sb8TkSGjq4CJS+yWPtVsaPPVogiDkh/gh4RgsI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWExsJd1TyyJ++0f7IO24+/0aKZTPNkFQh/IrPa5cQZ/U2Kt4YfpSNNcfKBOv5pUdNBcbJU/IF3aXVyGXs+c1QQe2Nz6GVkR6TaKoYQ8uXo5vQkAtIg6WzJsZmC4hOzzWq0PT+A+BQaWb3omkcR0takjDY/hNG+KAob9OwHkZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptGHWqc2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDB8C4AF09;
	Tue, 18 Feb 2025 19:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739907654;
	bh=Mix1Sb8TkSGjq4CJS+yWPtVsaPPVogiDkh/gh4RgsI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ptGHWqc2URMoDbr7NhhoKEluhhMu6XUiu8gxa08V4vmJ+gm/PDi34OTyFwS8tC27x
	 sHWrh16+lfRW9A790ED4z91w2ZDetDQUdWO1w83kM0WhfR1It1EVoawFjGRWj6YHpq
	 uiPUxf0Lndfvtu87mhSQXZRb5TfE0oWi/F4zmvwsL+Uc2h1e4eGsfB8eHc3FGY73Ks
	 ITmgOag3CTVjiBz2FU9S6IPp1tBRrz3VGq0eMgWFsKDNd5Jg0C0wOJlaR7zML1bzE3
	 yGH8Ox5jKhOfKyi2zvspO0aqn9uRVnE/yMfs5MHRYfbXCVoTYHpwMokZ+hPBrAjYn+
	 HpsNRHl6xLOwA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5fcf21d7235so425490eaf.0;
        Tue, 18 Feb 2025 11:40:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4yuHOKON0EIvKqM41dYgUy0jkbq0bAFr1EIZD7QSriBWXZFSnzV7J+9TWyvXe1h6eU+lSID7c2s2Jge4=@vger.kernel.org, AJvYcCWi2wSGnwhmXMzpMpN3tvV1MrZtaPKbXoRdc9ngr1PlwvFyuubYlRFjqY/RMDS0FbeakKG/A3MF6+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdMA6wEWf7c76/7I0pCu0TjODEV9QMSJqavtMovmFbwBcKXPlJ
	Yk+sHPZcbqq/fM1py99i/22Rl6MIN3l0o4Kut8QAXAMHjmuLWsynorRj4NEifxN/AFUBAhbih22
	DnkPJZbjN+Xt68nm/Mp0g0DibAlM=
X-Google-Smtp-Source: AGHT+IHZhvbcJigbv/ZRYGDQArO++IqeVIYf7zGlOvKfKLhWYIFRBQ4St5ugJ4lQigl1B6S4eAXa/o7YikzxC8o0g8o=
X-Received: by 2002:a05:6808:384e:b0:3f3:e847:fdc1 with SMTP id
 5614622812f47-3f3eb12e348mr10285215b6e.39.1739907653255; Tue, 18 Feb 2025
 11:40:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112152658.20132-1-me@davidreaver.com>
In-Reply-To: <20250112152658.20132-1-me@davidreaver.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 20:40:41 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gaaOwkiYH8-HuoAd3BXkruvi00MFp=bkwAUe+X76yggQ@mail.gmail.com>
X-Gm-Features: AWEUYZlDSSaDs0SCD8FvmatlcvljabO7macvIPMnLTqwbeykayQGPiEbD6bq8tg
Message-ID: <CAJZ5v0gaaOwkiYH8-HuoAd3BXkruvi00MFp=bkwAUe+X76yggQ@mail.gmail.com>
Subject: Re: [PATCH v2] pm: Replace deprecated kmap_atomic() with kmap_local_page()
To: me@davidreaver.com
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 12, 2025 at 4:27=E2=80=AFPM David Reaver <me@davidreaver.com> w=
rote:
>
> kmap_atomic() is deprecated and should be replaced with kmap_local_page()
> [1][2]. kmap_local_page() is faster in kernels with HIGHMEM enabled, can
> take page faults, and allows preemption.
>
> According to [2], this replacement is safe as long as the code between
> kmap_atomic() and kunmap_atomic() does not implicitly depend on disabling
> page faults or preemption. In all of the call sites in this patch, the on=
ly
> thing happening between mapping and unmapping pages is copy_page() calls,
> and I don't suspect they depend on disabling page faults or preemption.
>
> [1] https://lwn.net/Articles/836144/
> [2] https://docs.kernel.org/mm/highmem.html#temporary-virtual-mappings
>
> Signed-off-by: David Reaver <me@davidreaver.com>
> ---
>
> Apologies, I tried testing a CONFIG_HIGHMEM kernel in QEMU and clearly ma=
de
> an error because there is an obvious typo. Any pointers to test setups fo=
r
> testing CONFIG_HIGHMEM in a VM would be appreciated! Here is v2 of the
> patch.
>
> V1 -> V2: Fix typo kmap_page_local() -> kmap_local_page()
>
>  kernel/power/snapshot.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index c9fb559a6399..87f4dde4a49d 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -2270,9 +2270,9 @@ int snapshot_read_next(struct snapshot_handle *hand=
le)
>                          */
>                         void *kaddr;
>
> -                       kaddr =3D kmap_atomic(page);
> +                       kaddr =3D kmap_local_page(page);
>                         copy_page(buffer, kaddr);
> -                       kunmap_atomic(kaddr);
> +                       kunmap_local(kaddr);
>                         handle->buffer =3D buffer;
>                 } else {
>                         handle->buffer =3D page_address(page);
> @@ -2561,9 +2561,9 @@ static void copy_last_highmem_page(void)
>         if (last_highmem_page) {
>                 void *dst;
>
> -               dst =3D kmap_atomic(last_highmem_page);
> +               dst =3D kmap_local_page(last_highmem_page);
>                 copy_page(dst, buffer);
> -               kunmap_atomic(dst);
> +               kunmap_local(dst);
>                 last_highmem_page =3D NULL;
>         }
>  }
> @@ -2881,13 +2881,13 @@ static inline void swap_two_pages_data(struct pag=
e *p1, struct page *p2,
>  {
>         void *kaddr1, *kaddr2;
>
> -       kaddr1 =3D kmap_atomic(p1);
> -       kaddr2 =3D kmap_atomic(p2);
> +       kaddr1 =3D kmap_local_page(p1);
> +       kaddr2 =3D kmap_local_page(p2);
>         copy_page(buf, kaddr1);
>         copy_page(kaddr1, kaddr2);
>         copy_page(kaddr2, buf);
> -       kunmap_atomic(kaddr2);
> -       kunmap_atomic(kaddr1);
> +       kunmap_local(kaddr2);
> +       kunmap_local(kaddr1);
>  }
>
>  /**

Applied as 6.15 material, thanks!

