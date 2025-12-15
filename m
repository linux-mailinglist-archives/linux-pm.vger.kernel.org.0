Return-Path: <linux-pm+bounces-39548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 466BECBD836
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 12:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDF183009C1B
	for <lists+linux-pm@lfdr.de>; Mon, 15 Dec 2025 11:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0D3314D0D;
	Mon, 15 Dec 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+w7LOL+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7328270ED7
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765798510; cv=none; b=mjkCA+qSKpZFGrNsHSm11tucbEPhhMpPNxka6MrvwcHkg8/kHynC+nlVFCeZDU+eFJShsapdUx8REecEBrht4PvfjXO3OU+etm/2A/d6bx4KDe41C0VndHn/txyrk67UFpqCTOaItrDez09ozRewefP+RV8OgUymPRIKRpvfR4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765798510; c=relaxed/simple;
	bh=kLeJfBwH8DHB8JwyM1MWCIP0EssP2q6JynXQ9k8wneo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=luygzlQkC4M0XH3YfRlBJaRjZApilqgSaaZ1rUGfu+vbK9iE8+6J7Wqurhwia9//7eLQ+fTaetgGNrXUhEK+E98P2rpbqaito9y2XbTQoSH27lWnV+RqY17nTBUiPLzBVz+qGFy31QnZAFo4HjpwM9FosWfpYrMN3Qy0Xr4rCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+w7LOL+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65547C4CEFB
	for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 11:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765798510;
	bh=kLeJfBwH8DHB8JwyM1MWCIP0EssP2q6JynXQ9k8wneo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=S+w7LOL+M3LzfA97ZvD+3+zX/KiPjqcnqELdgxt9Z5HSFA3fkEJsZPUIpJqczXs/v
	 hn/GRrDSmY1HgO0/CTkOSXXpa96xMIIfm5IYGT6477O+1DKnGqs9yO6somIyGQh8Hr
	 jFnScu6dvPxyuGgak8qgtCesqjL4R8Uk+PHDvJRJkKNjHyUd+KazZ6a+/48vIP4lvI
	 UYQJ4CPmEHWZk+uoqH9PKN58hcLbi5OjlReDheZ4miJyrR7RiakkiW+X7Ob9sGYrvE
	 HyZwcJzsdptZvLbfBJ8wQaMCfdFVVb6l14OwQCUCVQa9Tn0Umbv5P1L9UGwpMV4Hku
	 gY73P6ccpZi6w==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-65b3843853bso2140491eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Dec 2025 03:35:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPVdxvqsq7c6D4NR8EA3j809q8Ri1sv5tv8DmsjjXVxRR3zagX2vuCI+h0iW1py9facmjVXDKFNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycrKTuKPgh5A8BjjVk1BqxUeXCYbBg7J8CocVcr8mHpUmLxZYq
	bkAeDlxptYPe/t1XtGMybqyGVPPMyVbNpOvs2Uw2ZeEDGn7ioLn21RbDrmDDxZO3oh5s3/60wck
	0Gwj+Pi9/DG9mklTPf257gwGJmZvhaGw=
X-Google-Smtp-Source: AGHT+IGJQev1UGcTkTBAZa81wG8r1swB0Ko3bVKuefcOK7/k6N2bOzcAIl3YQCZgLl4ILtq/mO0t1oMVQEyZZaLy3HE=
X-Received: by 2002:a05:6820:5041:b0:65b:4540:30be with SMTP id
 006d021491bc7-65b454034dfmr4708074eaf.7.1765798509733; Mon, 15 Dec 2025
 03:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207151549.202452-1-sumeet4linux@gmail.com>
In-Reply-To: <20251207151549.202452-1-sumeet4linux@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 15 Dec 2025 12:34:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i6EA4QZUOrT28HfhuoYG_BPsC2g6aGTHdMRrzuzcTs6g@mail.gmail.com>
X-Gm-Features: AQt7F2pMClmB5M-wxgcgbDDEtcw8JRZZW1FwK2NARXHlMD45HFUOYMlOutneoIs
Message-ID: <CAJZ5v0i6EA4QZUOrT28HfhuoYG_BPsC2g6aGTHdMRrzuzcTs6g@mail.gmail.com>
Subject: Re: [PATCH] powercap: sscanf return value error handling
To: Sumeet Pawnikar <sumeet4linux@gmail.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 4:16=E2=80=AFPM Sumeet Pawnikar <sumeet4linux@gmail.=
com> wrote:
>
> Inconsistent error handling for sscanf() return value check.
> It uses implicit boolean conversion instead of explicit return
> value check. The code checks if (!sscanf(...)) which is incorrect
> because:
>  1. sscanf returns the number of successfully parsed items
>  2. On success, it returns 1 (one item passed)
>  3. On failure, it returns 0 or EOF
>  4. The check 'if (!sscanf(...))' is wrong because it treats
>     success (1) as failure
>
> All occurrences of sscanf() now uses explicit return value check.
> With this behavior it returns '-EINVAL' when parsing fails (returns
> 0 or EOF), and continues when parsing succeeds (returns 1).
>
> Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
> ---
>  drivers/powercap/powercap_sys.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_=
sys.c
> index bdc65e040d17..e998454e4bf6 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -68,7 +68,7 @@ static ssize_t show_constraint_##_attr(struct device *d=
ev, \
>         int id; \
>         struct powercap_zone_constraint *pconst;\
>         \
> -       if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
> +       if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) !=3D 1) \
>                 return -EINVAL; \
>         if (id >=3D power_zone->const_id_cnt)     \
>                 return -EINVAL; \
> @@ -93,7 +93,7 @@ static ssize_t store_constraint_##_attr(struct device *=
dev,\
>         int id; \
>         struct powercap_zone_constraint *pconst;\
>         \
> -       if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id)) \
> +       if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) !=3D 1) \
>                 return -EINVAL; \
>         if (id >=3D power_zone->const_id_cnt)     \
>                 return -EINVAL; \
> @@ -162,7 +162,7 @@ static ssize_t show_constraint_name(struct device *de=
v,
>         ssize_t len =3D -ENODATA;
>         struct powercap_zone_constraint *pconst;
>
> -       if (!sscanf(dev_attr->attr.name, "constraint_%d_", &id))
> +       if (sscanf(dev_attr->attr.name, "constraint_%d_", &id) !=3D 1)
>                 return -EINVAL;
>         if (id >=3D power_zone->const_id_cnt)
>                 return -EINVAL;
> --

Applied as 6.19-rc material, thanks!

