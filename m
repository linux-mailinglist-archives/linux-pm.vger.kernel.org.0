Return-Path: <linux-pm+bounces-27236-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721BBABA0EB
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568721C00C08
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B41D63EF;
	Fri, 16 May 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiIxPmTo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3677261B
	for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413815; cv=none; b=Uz2D3YIlOU4aaYeo6Tl13ldN/I8HDwqWFmQlBBxfYu1RRgAp042jRIo1J3JtYD4B373LR2g4v8+dDxKbdnXV2M9K2zeD64hfDLmr3udxlJoE2pZm+qA/tWiaOMHGL2bPdvLzaYqIlMaqqKJ+UaJv0A94Bs86LEN52gfbPPWXATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413815; c=relaxed/simple;
	bh=E1BBp23YN8HELXozivvWnZ9ZPMVG9jJQFFN7Lj43Mb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HafL1InYP1zD3NuCaQK+WcOsu++QD1dr8I97dp3t3XKWP28LjdIDAoNxwf+6HDB1eze0rzMgDod/0N7w4NcV7ZGX8jepYFGdbwsfrKBJKECJ/APU4rb3Jn8e4ZtAOz14vYnG8ybU8gVaoPC3ybmvc5Xhcj4P68neeQBE0AZXjhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiIxPmTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25734C4CEE4
	for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 16:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747413815;
	bh=E1BBp23YN8HELXozivvWnZ9ZPMVG9jJQFFN7Lj43Mb0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZiIxPmTowlBP3NQGTvuYew+qiwcNPOHWcsXSALhXI2YMOAlglfMglYBF/5/Pld/J/
	 iLfuhrUL6vVeQxn2LNmoEo3BuwTF76tg3REAu8lrE9nHAMtVzsZw/xB1UlB+b5p9FJ
	 ycS2UKikAmad2PrCTcXAN117ciYjx3UHPQaIkK30jRw1iRjOtKaMp2gJtEUDIJDbvH
	 JNDb4efnAFZq3kJ3dB7I8hKWs+ZHEyGPozQ9uVhFLP8O/zObGPGkyFoaq3Hx86tHGe
	 6FdwCScvlzmBfT9gVCtNPnpaKh4bX3aQeu/CO5vtyI7yWTX4i830TtAuUQDiuoid2S
	 cb9DtFx3Zte1w==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3feb3f54339so2630033b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2025 09:43:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzh5n+Vs6ppQAS5D2R0Ah4bZagM4zhDsnL9UKxHBc+65fDrotNbVUrCYbpkv6CRltHl3QwI9hHsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmtQbF6S7oydBt9QWK+J/DEzUVRSTBiSIbKL6DU3OLGOZPK/FE
	/jPRfr9ZmVgp+OPYUK+PKgRAkmP7TXq57BBY6K1J3THeWCXW9ZdmBSsgyi7nb1fby08KtaOWjYz
	+aTHHPFKIjXucc0UKcVnTf4ZglPxvc+k=
X-Google-Smtp-Source: AGHT+IHMBiJYn5R2vDjvbdn2kC8DdWi6iemqqEiUxnAso0FZFFcK3u0Wqy+AMPwXXzPZzVSG5JMQEoK3agwsA0h8Roo=
X-Received: by 2002:a05:6808:11d1:b0:403:34b1:878a with SMTP id
 5614622812f47-404d88d34e5mr2353675b6e.35.1747413814477; Fri, 16 May 2025
 09:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bfe60af9-0246-4ae9-a15a-24e10def6d9f@kernel.org>
In-Reply-To: <bfe60af9-0246-4ae9-a15a-24e10def6d9f@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 18:43:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jP5tyRHrzQh-iBCHsJTNi9dd_Qi5o3vb8n522X189v0A@mail.gmail.com>
X-Gm-Features: AX0GCFtj9xEUWCnFJwl4yLNMzPjdTkpo1KPs_y0SpbiWa9tFPUGNZZUtjqF87Fo
Message-ID: <CAJZ5v0jP5tyRHrzQh-iBCHsJTNi9dd_Qi5o3vb8n522X189v0A@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.16 (5/15/25)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 15, 2025 at 10:11=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> Hello,
>
> The following changes since commit d26d16438bc5fd5524121244cc133f9872a632=
10:
>
>    amd-pstate-ut: Reset amd-pstate driver mode after running selftests
> (2025-05-05 12:07:42 -0500)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.16-2025-05-15
>
> for you to fetch changes up to f6b1eebbdbc75377f98fc9774bb86ffc270dae8e:
>
>    cpufreq/amd-pstate: Avoid shadowing ret in
> amd_pstate_ut_check_driver() (2025-05-13 11:12:44 -0500)
>
> ----------------------------------------------------------------
> amd-pstate changes for 6.16 (5/15/25)
>
> Fix an error caught with -Werror in amd-pstate-ut.
>
> ----------------------------------------------------------------
> Nathan Chancellor (1):
>        cpufreq/amd-pstate: Avoid shadowing ret in
> amd_pstate_ut_check_driver()
>
>   drivers/cpufreq/amd-pstate-ut.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Pulled and added to linux-pm.git/linux-next, thanks!

