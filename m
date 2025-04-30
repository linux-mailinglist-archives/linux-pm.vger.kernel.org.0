Return-Path: <linux-pm+bounces-26462-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A298AA4E47
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 16:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4DD1C209C5
	for <lists+linux-pm@lfdr.de>; Wed, 30 Apr 2025 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E71A145A03;
	Wed, 30 Apr 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYGn3nTy"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C038FA3;
	Wed, 30 Apr 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022615; cv=none; b=MZyDOyzNNUUXQxqtLFbqHGW+gZznWhl/zmxcMrcNxDvxsnFOvVJAB3xrlST4xlpufPFDNMbrh1+x2f8gSmCeTJHTGRoJjWVavskHh8MYDXTFUJyZ6i6VClsd3q8IqCEw22GT4CmCnjgJpTFSi3NbgYKk7UzSLyQeyQo9RGq7Dc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022615; c=relaxed/simple;
	bh=97lQQrzb+1FlMyPNgUCrZH1MVNYJNiWBl07bdx0MxCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZZT/VUeAaj8YtGJcaMHJ7fSbk5MoDbAhvi5m1Fr6lWDCVBkm0TdF4a1brkzbK5P7QDkrxu2l05bqbtYElK5DxBbGNYf0PGHCUcCwfga8iFGArjdwML/7B67N+J+AVXfu6TsijjhfZKfeg1LXlulpZ4mIflBP3NqmrbzwckqQoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYGn3nTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9705C4CEEC;
	Wed, 30 Apr 2025 14:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746022614;
	bh=97lQQrzb+1FlMyPNgUCrZH1MVNYJNiWBl07bdx0MxCA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DYGn3nTyzVV9tk8d9ESHeikgENDFOWsK9a4TY7JRq9rnM476HDCK+RwMUlTeT3x1m
	 3nybFMrLZ7XTaa33Cwhj4CIVl16VOwZPt/bbcFZLlRRccJDn2YuM8a39gzz8X6Bpbq
	 4+GkLDyIMsE+clCuCWthpPTeSLTJvMl4C981Ncmq5FyAhlh+/qYxT6+DGY+wSfcYpJ
	 gMbCZUXpiytjMeb4bvh9enbRdJBHN6k55gg+zuQ4x0RT/gaKdShBVvUC0YmLn0JrRo
	 3bhoTzvTyGVO+KZIFNC/9SjS4fOtKoUzcOGnTRIgMieo2gt0UEYcOGLq1W6HOmZOcK
	 3UzsqIy7P4yKA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2da73155e91so163503fac.0;
        Wed, 30 Apr 2025 07:16:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7sAc+jrM6QdzvUyTWXXB9Ba2sORkGnbyEuS5zH41CHNQ9fLjlR0Kct0Z535W4//U38nf5jjuKcOY=@vger.kernel.org, AJvYcCWGWcBlipuRzzFhSnF3kDVBB/PaT8iulPfkC7FL1poz1JBFGk+ySUhfZKQnBDBkOm9eKJa4FaipCUNPUwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHE/n9JVnRZQaqkn1tKo2xsvV8QUAAiDRvMEyizX2ebUwJaq2I
	VdQNe/CT4uai0Tjh9iaMDquxm76VYnCx/8kFjAZ+sLj93D3P+GLVzR8BFxOwFuFxpO2GOCGkknX
	j0XhUJwSyw+ja6o/vHNVlZ2maf3s=
X-Google-Smtp-Source: AGHT+IHpHf/dJZEl4/SvOUSiyHiPjRE5r41xWEePPEe+sPgqcr8qt3/+fgqihPr+yUxrxt1jy8d0v89dV5EFvsl5Xcc=
X-Received: by 2002:a05:6870:a48b:b0:2c1:650b:fc86 with SMTP id
 586e51a60fabf-2da6cd1187emr1369654fac.1.1746022614116; Wed, 30 Apr 2025
 07:16:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250430113001.546066-1-shivankg@amd.com> <20250430113001.546066-2-shivankg@amd.com>
In-Reply-To: <20250430113001.546066-2-shivankg@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 30 Apr 2025 16:16:43 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gm2WvcxeAHf5_Ct2RyK+fjoDz1Ck+T7DjpnBefJcPqFQ@mail.gmail.com>
X-Gm-Features: ATxdqUEzTWNkN95QICGXeGv-BRyt_edtEJiU1t35G7tZ5c12Y4chzN5oDHR9d0Y
Message-ID: <CAJZ5v0gm2WvcxeAHf5_Ct2RyK+fjoDz1Ck+T7DjpnBefJcPqFQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] x86/power: hibernate: Fix W=1 build kernel-doc warnings
To: Shivank Garg <shivankg@amd.com>
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, hpa@zytor.com, luto@kernel.org, peterz@infradead.org, 
	rafael@kernel.org, pavel@kernel.org, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 1:31=E2=80=AFPM Shivank Garg <shivankg@amd.com> wro=
te:
>
> Sample warnings generated with 'make W=3D1':
> arch/x86/power/hibernate.c:47: warning: Function parameter or struct memb=
er 'pfn' not described in 'pfn_is_nosave'
> arch/x86/power/hibernate.c:92: warning: Function parameter or struct memb=
er 'max_size' not described in 'arch_hibernation_header_save'
>
> Add missing parameter documentation in hibernate functions to
> fix kernel-doc warnings.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/power/hibernate.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
> index 5b81d19cd114..a7c23f2a58c9 100644
> --- a/arch/x86/power/hibernate.c
> +++ b/arch/x86/power/hibernate.c
> @@ -42,6 +42,7 @@ unsigned long relocated_restore_code __visible;
>
>  /**
>   *     pfn_is_nosave - check if given pfn is in the 'nosave' section
> + *     @pfn: the page frame number to check.
>   */
>  int pfn_is_nosave(unsigned long pfn)
>  {
> @@ -86,7 +87,10 @@ static inline u32 compute_e820_crc32(struct e820_table=
 *table)
>  /**
>   *     arch_hibernation_header_save - populate the architecture specific=
 part
>   *             of a hibernation image header
> - *     @addr: address to save the data at
> + *     @addr: address where architecture specific header data will be sa=
ved.
> + *     @max_size: maximum size of architecture specific data in hibernat=
ion header.
> + *
> + *     Return: 0 on success, -EOVERFLOW if max_size is insufficient.
>   */
>  int arch_hibernation_header_save(void *addr, unsigned int max_size)
>  {
> --
> 2.34.1
>

