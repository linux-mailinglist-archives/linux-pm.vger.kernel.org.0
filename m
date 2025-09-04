Return-Path: <linux-pm+bounces-33880-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A435B445A9
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 20:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A8DA3A8EE3
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 18:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4C30E84D;
	Thu,  4 Sep 2025 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lvaLXpYq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE0F1EE7B9
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011334; cv=none; b=dB6wEuPgvR2nvkGpKaTZ992QuNEH+aMAgyCpdChj4aiK2bwFbn2n5wtlg5AEfFFlJ1KWTwDwqmRgod87YP0ttkTW1Tu55MMtzZOEPLbeCUp4Hkg4nYmwVcP9rHf/KdVs+EawpEOFgr2jBkdsvdXM2HfQL4Yw2AvgHMqehnbQJf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011334; c=relaxed/simple;
	bh=29pqaIXtRHaxEyoLmaAGobsYIq9Zve5ARanIQ2BCvdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+NpakK49ppGN4UGI2yZFT0Aues0frdOSq9TJxZRDUNaJy61LpB4BsO7TzQZyV6wiOkHU+EH53JoR5BB9YPEDVihLOnjnfoo8qTpYcrHeQwSTjM6i+q6vS/2e+wuceMGYhXLBzP7U4pvfWadkqilVVbXg6LJRod4z6YxTHknTZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lvaLXpYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA340C4CEF7
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 18:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757011333;
	bh=29pqaIXtRHaxEyoLmaAGobsYIq9Zve5ARanIQ2BCvdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lvaLXpYqkoDmiMgpsYJk3VKivvt5nBDQ3qi73LXJsGzhY+S/Jq1Qbjcvu0gDjXmF0
	 lWvgBde88TlBiL/8YmjnV81a596uQ3V2eC9dFzRdpx1k0Fxfa7GFZMZhwg59cY+Hpn
	 cY9H0rwnkRy6uR9ThpDWiU4+NsDgf7BuseXN3UKeQwgi3DcSCs/RJzmymbFkel7Ju3
	 JwkpFK63QnbgIKsSeZl6hVxtZ+QvqbIaneqzPwqiukyE8yvIFiG7nQqn3ac3DUz+kL
	 GxrcWXMx+IuKd4Pn1yHvdjRjREQh/Yk9/0KjqL07Glcp8sO5wVjmPzPFdqmtqPodmU
	 BUeEShIEOT/Bw==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-746dae5ff93so63837a34.0
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2025 11:42:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKoYNteNrZ3b1QivfBT4YVni+/tTEckoAWUv9Q2bp0HW8s+U6z4lGUnEKix7IPkIm6Bxt87LCYEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdMMykMCeyF+Lyh1Iw+joBgVEjNaVrWzp989JTHWExsLLKf7p
	vDgS64lm32CHjYW9tiPf1srfdFbBJHDWlFkRdRya8toduuMc5a/38yHyuAu09udvXhuDHjPTVGd
	hXPCvKNQZIDdidUxZuRd0sX+Lh0rqz7s=
X-Google-Smtp-Source: AGHT+IHIZH1tzf9Dh9//zjRA8q+6K5k+socp30GUuhuBlEitZwj6oHH9n8iLPStjDtK2AkQ21OEmwlkqQffaGyPbb6M=
X-Received: by 2002:a05:6830:6083:b0:745:9a33:baf1 with SMTP id
 46e09a7af769-7459a33beddmr3981338a34.24.1757011333036; Thu, 04 Sep 2025
 11:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904062139.kt5ajtvocp5c3ihl@vireshk-i7>
In-Reply-To: <20250904062139.kt5ajtvocp5c3ihl@vireshk-i7>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 20:42:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i16TU9y9A00A5pX7s_tRJkX5SE6oZg4O7Q0_dBpnG_tw@mail.gmail.com>
X-Gm-Features: Ac12FXxhM9KCnhUtRVQ9qzn76ZlKPhbtiTOkafZllQboiQ31StZDOoop9Vm5t_4
Message-ID: <CAJZ5v0i16TU9y9A00A5pX7s_tRJkX5SE6oZg4O7Q0_dBpnG_tw@mail.gmail.com>
Subject: Re: [GIT PULL] OPP updates for 6.18
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viresh,

On Thu, Sep 4, 2025 at 8:21=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.or=
g> wrote:
>
> Hi Rafael,
>
> I will out of office until end of September and so the early pull
> request.
>
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>
>   Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-u=
pdates-6.18
>
> for you to fetch changes up to 05db35963eef7a55f1782190185cb8ddb9d923b7:
>
>   OPP: Add support to find OPP for a set of keys (2025-08-26 10:40:58 +05=
30)
>
> ----------------------------------------------------------------
> OPP updates for 6.18
>
> - Add support to find OPP for a set of keys (Krishna Chaitanya Chundru).
>
> - Minor optimization to OPP Rust implementation (Onur =C3=96zkan).
>
> ----------------------------------------------------------------
> Krishna Chaitanya Chundru (1):
>       OPP: Add support to find OPP for a set of keys
>
> Onur =C3=96zkan (1):
>       rust: opp: use to_result for error handling
>
>  drivers/opp/core.c     | 99 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 30 ++++++++++++++++++++++++++++++
>  rust/kernel/opp.rs     | 16 +++++-----------
>  3 files changed, 134 insertions(+), 11 deletions(-)
>
> --

Pulled and added to linux-pm.git/linux-next, thanks!

