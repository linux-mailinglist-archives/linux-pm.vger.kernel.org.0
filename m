Return-Path: <linux-pm+bounces-33047-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD49AB34AAD
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 20:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A6A7AB0CF
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E227BF95;
	Mon, 25 Aug 2025 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTmsxtd6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376F4272E61
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148131; cv=none; b=UOHHmfUNRqM0iu/Onf5Gd4/kZUUl+GV10eg6pi08DHzqdHO8JFtQzHBmDW98uN3SelJbmq2c8tCZ9vMpJFKJ3y0oFqQdu89ayDeZkaFt1Q/+OtmXtXwjwK9es+AXKD0fxAvYVABo3M9jekclopy5ly95aqLjOKr8wk37tOelX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148131; c=relaxed/simple;
	bh=rtHtL1ZEVmIiVb1R+apGOiF//0zre6GhHLElTc3lvro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSv8jTB6WtWGitbQqvdFyZZSb3yAf0G+oWrbPWW5cJ1gbPeNaIE9msjEKUI4r6jjqYXEiWNaP7EziGV2TJX/5UUOqu+yzOzvFwJBCtEzw1GfBmJB1FxMgblg0nt1UfKKhHsUlq9pL/rYttxpsTt6j+DWVjXzYGp2bIIlzGlVCLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTmsxtd6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F95C4CEED
	for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756148130;
	bh=rtHtL1ZEVmIiVb1R+apGOiF//0zre6GhHLElTc3lvro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GTmsxtd68N7eiYUbceMKCHZicxY4fUNUuXCg9pUeP02l4zg6pqvWfKxPcxHm/0ReH
	 SI0mNeafJfj46mhWJqbkWqgSk4YvBti4S5Ci8CKvIJZNQzXZcznYYHMM4K1C6Tp/6m
	 LACBM8pc00ZGcQDQjfkqcCggyauVchGKLdFrd7RHRxC1oYP9EE4F0sTQ+3kRbZiQ22
	 aaIJ94t3muY7ZNwoo65K2GIGBIFhSi9AO3ZjOyGe0CLKuNgQen+r6O21d083bLIfV8
	 6E2vAtcBJo9Ej+YXA3FwEgUQYBmqyZYHknU1+TmJJeODR5aADDcsNB0tzIfS5RLtS3
	 8dWL7TCaUbLVQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-30cce534a91so2061758fac.0
        for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2025 11:55:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXl9P6o+UhjqVxsvEA19wyBmVRvcsJOAxeU+8aUnalzHahoF5n/ho142EymOdf9nUGyBpBqFOU6kg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx/GxywUNFwFIKS5Pw0Eepu2Fr9XO5Y/U5pMHqBUGY/IratEZo
	PMBPEmQkZIXcZO5LM6ZasSO2yvKutvenKS4W3lHJps6QNipxUkehpm/0gE6+a/j9M+npVwsZAK6
	zhJtDg0cMBqNSWbR0Z40ANu26LhN6zi0=
X-Google-Smtp-Source: AGHT+IGpJhxZlVuUld/dRzP6V9TWOiILqUH8tQgfDEZ2wB8Fs3d6BfR3H39GLSdDXMoW9Lql4CGSMcwbrYWj4RnRVds=
X-Received: by 2002:a05:6871:81c7:20b0:315:2d27:4472 with SMTP id
 586e51a60fabf-3152d274b39mr1488892fac.44.1756148130032; Mon, 25 Aug 2025
 11:55:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819104038.1596952-1-lijun01@kylinos.cn>
In-Reply-To: <20250819104038.1596952-1-lijun01@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 20:55:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iFQ9+U6BQCgHwXRaN_MV3D0v0eTFky+D2MhX17hdd0gQ@mail.gmail.com>
X-Gm-Features: Ac12FXxSH5omukHGt0OFE_IrESvboXODi7ckj9zD0bGqiIa76mwKS9MPQ72mqfw
Message-ID: <CAJZ5v0iFQ9+U6BQCgHwXRaN_MV3D0v0eTFky+D2MhX17hdd0gQ@mail.gmail.com>
Subject: Re: [PATCH] power: snapshot: fix: correct 'leave' to 'leaf' in memory
 bitmap docs
To: Li Jun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 12:40=E2=80=AFPM Li Jun <lijun01@kylinos.cn> wrote:
>
> These changes just fix spell error, no functional
> improve.
>
> -The term "leaf nodes" is the correct spelling.
>
> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index 9b11c74592e9..6a216f3f7d8e 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -374,7 +374,7 @@ static void *chain_alloc(struct chain_allocator *ca, =
unsigned int size)
>   *
>   * One radix tree is represented by one struct mem_zone_bm_rtree. There =
are
>   * two linked lists for the nodes of the tree, one for the inner nodes a=
nd
> - * one for the leave nodes. The linked leave nodes are used for fast lin=
ear
> + * one for the leaf nodes. The linked leaf nodes are used for fast linea=
r
>   * access of the memory bitmap.
>   *
>   * The struct rtree_node represents one node of the radix tree.
> --

Applied as 6.18 material with edited subject and changelog, thanks!

