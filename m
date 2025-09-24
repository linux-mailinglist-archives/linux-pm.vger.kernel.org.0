Return-Path: <linux-pm+bounces-35299-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6470BB9BC92
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 21:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0DD54E0473
	for <lists+linux-pm@lfdr.de>; Wed, 24 Sep 2025 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED04270EA3;
	Wed, 24 Sep 2025 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZpAtOw4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875F26FD9B
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758743796; cv=none; b=GvVYzeimQlXnscqyE4XwzxZhw9NJBUqFeglbkmQqAx4wZ25e0cuCmFifM1pRI++7ik9sklvZBErr7eFUlGzjkTYy+xaPhkC8ommFSogrpZpbW3G9SlezFiVn/mnebFeNaSAzZVKElcneJdYABojoStNyZEk8Q/1P9x2Q/r9guTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758743796; c=relaxed/simple;
	bh=qV6r16V7ZIHUOHaLQwF8RoMY46bkW95ys1zmoPYJabs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSiJVryMfs2b0CeE2u9Aj/ic5Tix/n51qv/5Ncd0+b2kbTb7i4I3mvoSv3TvBrc8pCP+fDSETiYEbQ9TKfNh+sMtvJba3gYuPDZ05nrDliU5DeFlcTcozc/YRvOxfg3SJC7/vs/uur4XOhiEaqibIGJ+9+uzRZCkRDJvUaMZqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZpAtOw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396A6C4CEE7
	for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758743796;
	bh=qV6r16V7ZIHUOHaLQwF8RoMY46bkW95ys1zmoPYJabs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gZpAtOw4PYJ66mTjuH1c++WNFGky77bsF8obXujCVqR1fBbcEeXdq8dPfw6o+cat6
	 ejQdGI6qTNWQsUDRj93VB2F7hCqZMZQxLLIDMVa0ETt/mFcaJU5LlmvbGYWo/nI/ka
	 YWj99RwKqTeqTJtrK6/MmiFOUmULSLQ9Irat5WOWCg7VLKmlB9ehL172tUSG7XIvxT
	 bi5Rf4gYylVLtOY8ErQMyG1YR5d7b5vlH1YtlWSaGTFlIyzHpTXCFNf2VeH1ABtp8+
	 lVGs1wRTJWlPlyJaIBCC0PoWsgcy4TIP3RqHbPKXtTVT98snrag2umN1t7BG0sM065
	 A7mlg36Wu46pA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-621a79a580bso58748eaf.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Sep 2025 12:56:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZBEhlhmOJpDz+CQRyqI1GT/K2GdQh3GWjgDZLrxXwmpLD4baN5z7YjW7keQlTl89SDuk+xdOFnw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwG8ulIgvwewhDe2tEsGsTvtLsHyku17xJ/tqZwOp3Zxl7SYGIw
	aIOqhBE8wSXh3ZdrkSRc9q4RYEdPzsDczUyOfs8JTfq2E7ZpHyNE8bc1uJE2OQTOptFccVTgE8k
	HzHYC4Rp95wk4c0fA2/DWc8bIGfHkpVQ=
X-Google-Smtp-Source: AGHT+IHtAGlSWmr1FNw1tWaSqyNV+OVy01/2Z3np8gb0dxUTywYcpqUT6dfzCAl3Q0PtbLmtksVq2DJg5qYsrdS5cHE=
X-Received: by 2002:a05:6808:1312:b0:438:bdb0:89ba with SMTP id
 5614622812f47-43f4cbdf31amr589859b6e.3.1758743795567; Wed, 24 Sep 2025
 12:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e483800a-53d6-4d48-9a6b-04ad7636b662@kernel.org>
In-Reply-To: <e483800a-53d6-4d48-9a6b-04ad7636b662@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Sep 2025 21:56:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0irBwOc+chfLkwbC0M3-cvfRJdjKsh+6y8N6HW8VJt8SA@mail.gmail.com>
X-Gm-Features: AS18NWDC8ExpGlrsDA-xBcIgws4Z3Le0QFIPNmh_l2yALREROcvFfROni5XN-Es
Message-ID: <CAJZ5v0irBwOc+chfLkwbC0M3-cvfRJdjKsh+6y8N6HW8VJt8SA@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.18
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:19=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> The following changes since commit 07e27ad16399afcd693be20211b0dfae63e061=
5f:
>
>    Linux 6.17-rc7 (2025-09-21 15:08:52 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.18-2025-09-24
>
> for you to fetch changes up to e3f761be5a178bdd5cd80351c5ca0a0cf675ef7e:
>
>    tools/power/x86/amd_pstate_tracer: Fix python gnuplot package names
> (2025-09-23 13:42:20 -0500)
>
> ----------------------------------------------------------------
> amd-pstate content for 6.18
>
> * Fix for amd_pstate_trace package references
>
> ----------------------------------------------------------------
> Kuan-Wei Chiu (1):
>        tools/power/x86/amd_pstate_tracer: Fix python gnuplot package name=
s
>
>   tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Pulled and added to linux-pm.git/linux-next, thanks!

