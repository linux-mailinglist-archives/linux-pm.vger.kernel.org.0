Return-Path: <linux-pm+bounces-20688-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36969A16BEA
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 13:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500873A026A
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jan 2025 12:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8C41DF984;
	Mon, 20 Jan 2025 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS3CvpUw"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139FE1C5F25
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 12:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374478; cv=none; b=Yxe/CnC33udMe7j4R1+UVx4WOF1lUPbaPs57CBmR70zoA3TFzPAZ2/ep5H83ubyw8cI58sepcvTaiBN9sxa7v8xlT00EejnLUFk1/TeFO2BLzuzneIKcDM25IUt7pIfldv6aH03AnLYNOu5JesYqmYP00IwuOv6gDA6io84rhHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374478; c=relaxed/simple;
	bh=jNl3GinGKuxILQIczuTBTEBUx7VsVvSD0A6ssNx1ois=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XuyTBGsLYVLBQLgEDht1A//C+sCBkX7upThp+klsFQOhkzbAlNR6leeoOakuEgSO0lJ4X+RLM4ruh8KXLPLI8XtpFOcGYwdp94/mdfeIS3V4rylOsOMHrZBKvYgmOrts0pMo6O19Rf4xkWO+BlIXJdwM6C7pc9tMPqhNoYEJ3/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS3CvpUw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8026CC4CEDD
	for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 12:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737374477;
	bh=jNl3GinGKuxILQIczuTBTEBUx7VsVvSD0A6ssNx1ois=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VS3CvpUwz8oga10bJcBSMuW/ae9f0k5LLy32l1+AEMCROyAGebeFWkQqnKMLdFFX5
	 DltN4T8jc7twdXO6RKec3LgDd1rb4pHd2U/epKjmLKsFu43cGafP3kfNYvoN+eVT+L
	 hOMtjjAk/+qV9Jza2PUDnsY5X9i/qaYm9tU1RYXO7dJZnISj5TJymVLge66flET10J
	 hPbCFiZoOfkLXAIe4KLCToYBbF5DumeGFSydd7SVn+5VPAZYy8Xfglz0UB+at9/OaJ
	 5GpHdDFjGdxszpcdEGqGzH0Mc+RwvC2u2GvLHV+MLl0btp8w+pPDtDCtgzgqZLkI/9
	 sfRHfJmTBGZRA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5f4d935084aso1368617eaf.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jan 2025 04:01:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJhC0za+9uobQlYyFXtdrvzfKjH6+etjXqamfTOrEbb4dvMUJKN/72KeUVntXOhxFaks6ohJvtZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAViaZlk4UVdHYFuODpL48yRUarpf9zQP3eyxj/od2Qt0LYdZ
	8HK+yI9qPd9yVVBLsRWWfixiJaeGN0sBRK5n/PDr519DJkhjoNSv5Uvd0xj2U2Udvv06/nT/d/3
	KAApKU71rujBRy8yWnbyA+PHDCzE=
X-Google-Smtp-Source: AGHT+IHyEay8T0h7BduENRaTdkGHaXKoWkhxN335roe8swf95ccaQ0VVsjyCsYwFCi9ykxVHjlOk4A22udt7+O/1/Dg=
X-Received: by 2002:a05:6820:8187:b0:5fa:5c7d:da1f with SMTP id
 006d021491bc7-5fa5c7dde33mr2076092eaf.1.1737374476829; Mon, 20 Jan 2025
 04:01:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120034018.ay5j3xsb3747zezc@vireshk-i7>
In-Reply-To: <20250120034018.ay5j3xsb3747zezc@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Jan 2025 13:01:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gTtFpdeXQjZ+dJHR243ibM0ekPFfx8ZFdNnfzs_EEw1g@mail.gmail.com>
X-Gm-Features: AbW1kvZVYi2IrGOayyxgUYsPiVy9V3xaBfj-YYVejLlTfouPY7RK-lyNthUI0EM
Message-ID: <CAJZ5v0gTtFpdeXQjZ+dJHR243ibM0ekPFfx8ZFdNnfzs_EEw1g@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.14
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Mon, Jan 20, 2025 at 4:40=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> Hi Rafael,
>
> The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b=
37:
>
>   Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.14
>
> for you to fetch changes up to b489e7946656ed67fea1a30f5103eb62a8686e04:
>
>   PM / OPP: Add reference counting helpers for Rust implementation (2025-=
01-20 09:05:51 +0530)
>
> ----------------------------------------------------------------
> OPP Updates for 6.14
>
> - Minor cleanups / fixes (Dan Carpenter, Neil Armstrong, and Joe
>   Hattori).
>
> - Implement dev_pm_opp_get_bw (Neil Armstrong).
>
> - Expose reference counting helpers  (Viresh Kumar).
>
> ----------------------------------------------------------------
> Dan Carpenter (1):
>       opp: core: Fix off by one in dev_pm_opp_get_bw()
>
> Joe Hattori (1):
>       OPP: OF: Fix an OF node leak in _opp_add_static_v2()
>
> Neil Armstrong (3):
>       opp: core: implement dev_pm_opp_get_bw
>       OPP: add index check to assert to avoid buffer overflow in _read_fr=
eq()
>       OPP: fix dev_pm_opp_find_bw_*() when bandwidth table not initialize=
d
>
> Viresh Kumar (1):
>       PM / OPP: Add reference counting helpers for Rust implementation
>
>  drivers/opp/core.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++----------------------
>  drivers/opp/of.c       |  4 +++-
>  drivers/opp/opp.h      |  1 -
>  include/linux/pm_opp.h | 13 +++++++++++++
>  4 files changed, 93 insertions(+), 24 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

