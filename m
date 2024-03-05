Return-Path: <linux-pm+bounces-4695-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C77872AE0
	for <lists+linux-pm@lfdr.de>; Wed,  6 Mar 2024 00:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D141E1F27EB2
	for <lists+linux-pm@lfdr.de>; Tue,  5 Mar 2024 23:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB9C12D743;
	Tue,  5 Mar 2024 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NAfDVBqM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145312D215
	for <linux-pm@vger.kernel.org>; Tue,  5 Mar 2024 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709680439; cv=none; b=jFK1SOcT1xG5PD2k/E2AgEbp7Da2w5/6tdLcHy5Tik2cyuyQ9hNeveYlBxUctB3ZI3w7UjfGimnPIzBjBEfdzoeMkvqUXXZIGBnPQDjC+UEYTrHqzUxBZighxbTdhyYlz1KJR4puIgVXIbv2mlu2RI0xT9U1i96JbCxUcTFeFv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709680439; c=relaxed/simple;
	bh=ZSE908MrL3W9EF4A9/FeE48VeA9QUapWInD9HpQG3I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGQeZVxedNKnwltrCfWPRsAPiGm6CC3QiMfTCfmY2zoZJjkFSYR0BbJADp2JTEXHewiZdYeMKNEDEi3Gt/NHbS5cuqtO6gyjvmgMAFRuMMcFOuy5Zo7ves3i8X9AjXDOrDIJf4NhEA8dM7QlCaJTgvwbPZrR7rPjmQMnJjazWhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NAfDVBqM; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-365c773ae6cso23277765ab.2
        for <linux-pm@vger.kernel.org>; Tue, 05 Mar 2024 15:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709680437; x=1710285237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZKWR0J2srML+eyhC61XR43/wjQEkRkTGp8CW9dDv+M=;
        b=NAfDVBqM+p5SRXWtSIgOYxV9sxY/2zgZfqzQCPpIYxRFqFXeQ5isK3k7txHHdhTuAo
         NDu6m7gpRJRyJBDq5OJg7LNq5YEq7sHrhfWl/2mzVB26dNdsIPuFXVgZFv60c4cQ9AlY
         T+ri09c0i6+A8oFm1NTtbz4pWQpPQtftBxI8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709680437; x=1710285237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZKWR0J2srML+eyhC61XR43/wjQEkRkTGp8CW9dDv+M=;
        b=hKcyNjZxrLSLrukyZH+CvlCswlXqNBj21hVsARsDyx9zfThNL+ofE6JWSVWCyJ1mJU
         5rdSxOzDZ42VlM9oatejRZLmsIaHK/Lhk4xCOmjczM/E8Uzlyua7bcabk5TCQPo44k6G
         LEayYqEy6cCDcuGijI/J8ezvFIjDJsVuafDF1+Hx25dalOMWsVqD9BJXTIinPDReLnR5
         UpUxknb+JG+kZCzIZU/QA9pr0fX+ihhVW1y9RpooBi9Bx5ADPrG7o3Hxc5xsjBsbqkQi
         HYkxwU4lrtAFeH98m96Z6Dl/WgOfFKp9QT8v18K3eDyjWj4EtSzT6ZrGaVFfCrn5IjwW
         qA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVu4uiPUDBIadwa6HyUXsCmL+85Oeiw6Xo3N2G8UIgSnYZ19G9nL16Cr2sD9zNx4pcGkrzqB803piiZVORkpJsHpdTVC0g9Qbw=
X-Gm-Message-State: AOJu0YyW45vO5POkBzXcUGhadNtP5pvMDjEZgSjXAC8JflQbX6DcyOA7
	ZwpWXdAsdtI3O54mPBP1X3mHkxzlADxPSNOYl5N6NWEMEGbL2hNevgTZCdcp/ouey0LjzCSv5pG
	wRDzk+Avuv9SKsS2D1SQ879E7KVNJnQ3EtRoA
X-Google-Smtp-Source: AGHT+IFDvVCNWLD5UqLerMM90o3fXxlm8K2ifoYGV8gIMJPQStPoeWDTtvtRilg2YO2qtDVgyzI7zQsgcgd4+aqlVDw=
X-Received: by 2002:a05:6e02:1a68:b0:365:7607:3f5d with SMTP id
 w8-20020a056e021a6800b0036576073f5dmr17242881ilv.3.1709680436858; Tue, 05 Mar
 2024 15:13:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305225652.22872-1-quic_mdtipton@quicinc.com>
In-Reply-To: <20240305225652.22872-1-quic_mdtipton@quicinc.com>
From: Rob Clark <robdclark@chromium.org>
Date: Tue, 5 Mar 2024 15:13:46 -0800
Message-ID: <CAJs_Fx4DKiBjzh0-F6aBFdsqGDiE9uppXAE84yrO3hxMSzwgjA@mail.gmail.com>
Subject: Re: [PATCH] interconnect: Don't access req_list while it's being manipulated
To: Mike Tipton <quic_mdtipton@quicinc.com>
Cc: djakov@kernel.org, quic_rlaggysh@quicinc.com, quic_okukatla@quicinc.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 2:57=E2=80=AFPM Mike Tipton <quic_mdtipton@quicinc.c=
om> wrote:
>
> The icc_lock mutex was split into separate icc_lock and icc_bw_lock
> mutexes in [1] to avoid lockdep splats. However, this didn't adequately
> protect access to icc_node::req_list.
>
> The icc_set_bw() function will eventually iterate over req_list while
> only holding icc_bw_lock, but req_list can be modified while only
> holding icc_lock. This causes races between icc_set_bw(), of_icc_get(),
> and icc_put().
>
> Example A:
>
>   CPU0                               CPU1
>   ----                               ----
>   icc_set_bw(path_a)
>     mutex_lock(&icc_bw_lock);
>                                      icc_put(path_b)
>                                        mutex_lock(&icc_lock);
>     aggregate_requests()
>       hlist_for_each_entry(r, ...
>                                        hlist_del(...
>         <r =3D invalid pointer>
>
> Example B:
>
>   CPU0                               CPU1
>   ----                               ----
>   icc_set_bw(path_a)
>     mutex_lock(&icc_bw_lock);
>                                      path_b =3D of_icc_get()
>                                        of_icc_get_by_index()
>                                          mutex_lock(&icc_lock);
>                                          path_find()
>                                            path_init()
>     aggregate_requests()
>       hlist_for_each_entry(r, ...
>                                              hlist_add_head(...
>         <r =3D invalid pointer>
>
> Fix this by ensuring icc_bw_lock is always held before manipulating
> icc_node::req_list. The additional places icc_bw_lock is held don't
> perform any memory allocations, so we should still be safe from the
> original lockdep splats that motivated the separate locks.
>
> [1] commit af42269c3523 ("interconnect: Fix locking for runpm vs reclaim"=
)
>
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> Fixes: af42269c3523 ("interconnect: Fix locking for runpm vs reclaim")

Looks good from a memory/lockdep standpoint,

Reviewed-by: Rob Clark <robdclark@chromium.org>

> ---
>  drivers/interconnect/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 5d1010cafed8..7e9b996b47c8 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -176,6 +176,8 @@ static struct icc_path *path_init(struct device *dev,=
 struct icc_node *dst,
>
>         path->num_nodes =3D num_nodes;
>
> +       mutex_lock(&icc_bw_lock);
> +
>         for (i =3D num_nodes - 1; i >=3D 0; i--) {
>                 node->provider->users++;
>                 hlist_add_head(&path->reqs[i].req_node, &node->req_list);
> @@ -186,6 +188,8 @@ static struct icc_path *path_init(struct device *dev,=
 struct icc_node *dst,
>                 node =3D node->reverse;
>         }
>
> +       mutex_unlock(&icc_bw_lock);
> +
>         return path;
>  }
>
> @@ -792,12 +796,16 @@ void icc_put(struct icc_path *path)
>                 pr_err("%s: error (%d)\n", __func__, ret);
>
>         mutex_lock(&icc_lock);
> +       mutex_lock(&icc_bw_lock);
> +
>         for (i =3D 0; i < path->num_nodes; i++) {
>                 node =3D path->reqs[i].node;
>                 hlist_del(&path->reqs[i].req_node);
>                 if (!WARN_ON(!node->provider->users))
>                         node->provider->users--;
>         }
> +
> +       mutex_unlock(&icc_bw_lock);
>         mutex_unlock(&icc_lock);
>
>         kfree_const(path->name);
> --
> 2.17.1
>

