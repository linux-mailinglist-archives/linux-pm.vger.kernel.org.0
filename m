Return-Path: <linux-pm+bounces-9621-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDF190F6D0
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 21:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98ED1C2428C
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 19:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE040158D7B;
	Wed, 19 Jun 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gq5epQCN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D09158D61;
	Wed, 19 Jun 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824614; cv=none; b=YPL9Q7tAWUDpatP/Ekhc8ZXx5+mSzITfwKxefLYGDJwuB501HGBCVYey2PDrJ2ZZYTEJlxDtQh3U42Tb31PWVreNe4a4REt7touejO+Bz3k9S72c7EeMGKLCa+23q2BBPcp887oxNCTus3lZnJeH3OVyRnvW2ZtQPJUtXA6J8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824614; c=relaxed/simple;
	bh=/cs5OYCa2lpAA+z+y9xQeJ0jRLhe5YHXS68JWqgYx/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/i3oyiqk7NJg0zxD33r6rrSPEqk1aw+lMr8VHuCi5BcFb9CbBBKKeXvHhfMR4Hfnw0xB0/Rk+rIjlkND72bwIKqc1Vca+T+N4hIVSHYbl5vQWhNZLtHv98K8MCmz3zzFQtN7kddtsP22GDWYAxd6dczi/eF+VWj3CbRKPvOJU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gq5epQCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D92C4AF09;
	Wed, 19 Jun 2024 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718824614;
	bh=/cs5OYCa2lpAA+z+y9xQeJ0jRLhe5YHXS68JWqgYx/0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gq5epQCN46wle97nJq0CkCwCtJ4lJyHWfYXNEDMvZhDkoZhRjDQUoI1775JovzcKT
	 cy5es/W2HSi4PzEt/LHPnzIXDtO68NgsswFlUHhvICwjOn+3PDKXqjT9/BQVyX0Fk4
	 oKU4NP8dT1nBjQRt2TxV9x/oHwAFDwbjiFluiayyFteiB4Uv2fETTw1VIPO6U1hn8f
	 qzu3y+0hI0j/HI3Y2ztMbc++ku9bQxuznOcf9nUOq+3xJmFS/jIQo8mmGGcIvxM3L0
	 cXn6JQ1uOsNtIZqoEWxW+pu2yQZLMTexemArNQPFrsuPGidwUm76AkOueLvvC7aD9L
	 jxhWsGf1wsQQg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d1b8bacf67so2154b6e.2;
        Wed, 19 Jun 2024 12:16:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrKqNx5M5wScLVNK5byKHUV/OxwHH2CrEI/PqEIclgXtdW2Mj0X4ytARMemQNZL39Ygm4QGX55JnA8+7oSvZwBY4407hGEPDfvZ9uAEX5bQDIKhjuPzGqCxEJ52zrMpyBMXIATCDI=
X-Gm-Message-State: AOJu0YxtHER6N87scgr25vN2WF/l4d0cux8H2mLi4ZZHdvx8VQ0vo324
	eMH2YFQbUzJp3V/RjLCKiayRJzAgrPZwS1j+oMIwTLGY+GFNERuXs2JVnjxoXk6CJ2PBZBZp3U9
	otFiAPP3gwPXL/sg9Ze5Jdvayu74=
X-Google-Smtp-Source: AGHT+IEfml7ZblzBlVlSN+ywWZBraHzOqqfJ0BgNoe5hJYTnwnxJeTLHnkP/zv5sY8p388n6ccfEn2lMgH4BRGW+x3o=
X-Received: by 2002:a05:6870:5586:b0:254:d163:c3a9 with SMTP id
 586e51a60fabf-25c9443c7b6mr3920450fac.0.1718824613209; Wed, 19 Jun 2024
 12:16:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618055221.446108-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240618055221.446108-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 21:16:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jyf4A58z5mLa0xLdjQ=3uVAsopuH1CMx8yhMi8jFSVNA@mail.gmail.com>
Message-ID: <CAJZ5v0jyf4A58z5mLa0xLdjQ=3uVAsopuH1CMx8yhMi8jFSVNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cpufreq: intel_pstate: Update Arrow Lake hybrid
 scaling factor
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 7:52=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Arrow Lake uses the same scaling factor as Meteor Lake, so reuse the
> same scaling factor.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstat=
e.c
> index 3dc9b82c43af..72d9e60369e0 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3401,6 +3401,7 @@ static const struct x86_cpu_id intel_epp_default[] =
=3D {
>
>  static const struct x86_cpu_id intel_hybrid_scaling_factor[] =3D {
>         X86_MATCH_VFM(INTEL_METEORLAKE_L, HYBRID_SCALING_FACTOR_MTL),
> +       X86_MATCH_VFM(INTEL_ARROWLAKE, HYBRID_SCALING_FACTOR_MTL),
>         {}
>  };
>
> --

Applied as 6.11 material along with the [2/2], thanks!

