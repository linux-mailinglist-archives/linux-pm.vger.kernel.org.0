Return-Path: <linux-pm+bounces-19428-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB39F67CA
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 14:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAA6316A209
	for <lists+linux-pm@lfdr.de>; Wed, 18 Dec 2024 13:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22CF1B0428;
	Wed, 18 Dec 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPDY5xdV"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7128158853;
	Wed, 18 Dec 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734530289; cv=none; b=cimp+/bRuxsNlB9XmXUAnoVcBG1N1BT0iWC4uDFwpusUPn31qnTp4eD8qKfjKj0ot5E0Cu7MfQpWN1vrBz5QSIIkxwdlHXkdPWizYZOQ38qob+qYGmg7FCTr5PJJTmLKj2ChIxbGIEeUw4lLFr/p4f+8TVGZcCsid6cHQQvqO38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734530289; c=relaxed/simple;
	bh=hfmd+pBZz117SqPK3wfS80IwmiZ33Hr14fCBwDmxNmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Di/OBOJr0X9FkVZyeAJRuQzNiNS5wivvAQYL2/SowIaZS4+4GNPOYvG/TJ4PMucyD7pbeMfDLBHj5PWLpT7Zce7Nb+xB9BUJpbpGTIYGMhc6u+NemmWm98WuCq2kmFykjAzQ/iD+AkWEy4ZZiYIsvQMISffO8dU/cqedJQ/L9AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPDY5xdV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6BAC4AF09;
	Wed, 18 Dec 2024 13:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734530289;
	bh=hfmd+pBZz117SqPK3wfS80IwmiZ33Hr14fCBwDmxNmI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rPDY5xdV8UnmX8uxRN+mKM/jpf/gAwypbyekhW4nilSEaoINWah9RqTeBghJUKgfc
	 CJ3exKAbABBuF10uI+MgDCzC8NISqIPNe0jyHoRMC9hnJXDr6c+QsCEEOxgSo8fq/A
	 8oKu66HzqtRi0DYqDSRP73oExlvsBo6RsIOyLeLlTipadBj9z3gboH54TT4z9uCVdl
	 7MT+1sBPfgteI10mXnphA/qBY5L+f8MwDjggawBYhL1F3A57ACUQgM3/f02l5M7B66
	 zE2qbgySJLQg+7NA0ucQO3gIapkjVsBbbMf01XEjW+jz9dC/qbjlaoVVgkEcq+1eps
	 NK9OkNYc5zH9w==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3eb790888c6so1981173b6e.2;
        Wed, 18 Dec 2024 05:58:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFNCF68RyqvQzL20s2L/pulCDKxh/31I45I5iuELVjzk6uiSS8w+GwwEjKth6bNte4xC0OsglpLmQlF78=@vger.kernel.org, AJvYcCUoNr0jGLu473e/ajje4hCZCJcDExeWVVULAt3a8YsXDRnu7IgfyTENut/8aP44OnQsQhBycVCMNa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82uv3nVTJMnm713Q1iuoSJblgO3HWsSfZxDeYnKiCS9RaKq6o
	ovWxx+g4ZcrQIlMhOvpfnchVVU1Pa8BS8E/K2/GMvR241KpDe7K2tFxA5ittPqubu1rCUnmZljz
	TodoaSM9gj48F3TsepWjaiFYbx+4=
X-Google-Smtp-Source: AGHT+IEqVRKfu8b1msrQlS2a24Jkm2JA/sZq75OFMofj5UVGSonqfwU2SWDCx4vucCuJGtR068KlCdFQM3UbHXhqXds=
X-Received: by 2002:a05:6808:1922:b0:3e6:5f1d:411a with SMTP id
 5614622812f47-3eccc098323mr1807279b6e.31.1734530288633; Wed, 18 Dec 2024
 05:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212161608.24730-1-pvkumar5749404@gmail.com>
In-Reply-To: <20241212161608.24730-1-pvkumar5749404@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 14:57:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hQfGdsjy-VQmw4HV5Bqcv7mvR_bLnabGKb7E-obJb2Zw@mail.gmail.com>
Message-ID: <CAJZ5v0hQfGdsjy-VQmw4HV5Bqcv7mvR_bLnabGKb7E-obJb2Zw@mail.gmail.com>
Subject: Re: [PATCH] doc: power: Add missing parameter description for memory_bm_create
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:16=E2=80=AFPM Prabhav Kumar Vaish
<pvkumar5749404@gmail.com> wrote:
>
> Added the parameter description for bm, gfp_mask and safe_needed
> for the function memory_bm_create
>
> Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
> ---
>  kernel/power/snapshot.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 30894d8f0a78..690dd1f467b9 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -680,6 +680,9 @@ static int create_mem_extents(struct list_head *list,=
 gfp_t gfp_mask)
>
>  /**
>   * memory_bm_create - Allocate memory for a memory bitmap.
> + * @bm: Memory bitmap.
> + * @gfp_mask: GFP mask for the allocation.
> + * @safe_needed: Get pages not used before hibernation (restore only)

This isn't exactly accurate and I'd rather drop the comment entirely.

>   */
>  static int memory_bm_create(struct memory_bitmap *bm, gfp_t gfp_mask,
>                             int safe_needed)
> --
> 2.34.1
>

