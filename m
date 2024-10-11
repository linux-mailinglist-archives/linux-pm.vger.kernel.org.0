Return-Path: <linux-pm+bounces-15548-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 838BA99AB20
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 20:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CF02B21A68
	for <lists+linux-pm@lfdr.de>; Fri, 11 Oct 2024 18:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4F51C8FB7;
	Fri, 11 Oct 2024 18:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMC/rXGR"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAF183CA5
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672097; cv=none; b=PyaZ+NwPazdvl6x9NZd0aaeOnZjSXqmULwHOMIZ/VxGMirxEuhuPwdq9CdFcWktrN6kFkKQksmoKXJM6f9fdcnnZBNG4qIumJTJ5/CC4CGDBtPQuTWhQbP1VJ6yHGgBEg5ZFQCZnIMeRThlODTHULzvdM2AKaiJYVpxVTu4e0is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672097; c=relaxed/simple;
	bh=T9M/rpPOtkvbRIhaGAsLKZVZeOu7tV2xrv1DiO87Nnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JwLDgikBzZJbyZSJlBsyKcI+9YDFaOx+2RaCOmwxZYrg15lbGzjvcu4oHMq/YC1ZaKjiDnWqFF5KcLYipAYUU6031SMuKo5vh/qJcO/RhPwLJz4gk+EqA8XNQDtCA/7oX/pQC/GqNZoqgFLueBqjrcj0lAZakohiIOPPVG/TxJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMC/rXGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FD4C4CEC3
	for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 18:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728672096;
	bh=T9M/rpPOtkvbRIhaGAsLKZVZeOu7tV2xrv1DiO87Nnc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KMC/rXGRaogaDmaoN8/7XkkQSKYZCNfpn5tZaF9uc2BzHjOHXlezeIivfvxFsTLSL
	 V6Thl5mIwj1UpCw2zHhhJt/DmgvEe1cT8aDYcUrIo2ZR8vVhr4RzsPtciFjlDFBbcg
	 UsumuV3j0fuQBDURjxWGEKTvgZXcoNVbkEQPFGhpMZH2UExMeRLFhM4n70upJB9Dg/
	 jEP9OwQHCTGWmJx8ZSnp1MKytjjkpO5umw4zE5wEjGkiPl557Mn23opwOSKrtVY+jp
	 Nb4SITV564qzTkt6rUTZ0UtWtQ2w5ip0PetTBG3VS/BT9mDcT9QmrcZHL//48XbgEf
	 gvIKABZnFGDiw==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e3e590c31aso1088196b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Oct 2024 11:41:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW9xKnPnAfOO8jmjV4/K9fOMzxdPCrOL/4nxyt9YgHrO0ywz/bpFcIAyHlrRhpeh0g2ldqADeZ9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKhtLOvYP7qRI+/H9EUip9tQJM08QzanHu3xRmCYqZUvVd6toR
	e+4FqzNLlkZqvSvv97zDQ6QOzUrXAhufn5ew8S9QyUEbyIq8gbocXb6EAU2PzO3t2pIgs+ctP6O
	gzvS76BJJjG6ZjGakMl+vJxYaLnM=
X-Google-Smtp-Source: AGHT+IHLLIiIRkDYoJlW650oK6rQnAvKT2LuTMrqn3q54LaLStA1Yt/3FyFYXZoH34Jft/pR46NgDH1vRpklqBG4nVA=
X-Received: by 2002:a05:6808:13d6:b0:3e5:c8ee:6e82 with SMTP id
 5614622812f47-3e5d222e343mr482225b6e.25.1728672095777; Fri, 11 Oct 2024
 11:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03f55e79-c1b3-4f2b-af96-6b64b170866f@amd.com>
In-Reply-To: <03f55e79-c1b3-4f2b-af96-6b64b170866f@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Oct 2024 20:41:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gwRuAWucKQEnm7vEgdv5zea85P4egiZV58sMGvd6LYvg@mail.gmail.com>
Message-ID: <CAJZ5v0gwRuAWucKQEnm7vEgdv5zea85P4egiZV58sMGvd6LYvg@mail.gmail.com>
Subject: Re: new amd-pstate content for v6.13-rc1
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 3:44=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hello,
>
> The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d=
7b:
>
>    Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.13-2024-10-10
>
>
>
>                                      for you to fetch changes up to
> 57533bc760ae012eefdac53fb8e1eaf3fe4291ec:
>
>    cpufreq/amd-pstate: Fix non kerneldoc comment (2024-10-07 11:32:40 -05=
00)
>
> ----------------------------------------------------------------
> - Fix the determination of the boost numerator used by the amd-pstate dri=
ver
> on AMD heterogeneous designs.
> - Rename functions in amd-pstate to more intuitive names
>
>
>
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (2):
>        cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory
> systems
>        cpufreq/amd-pstate: Rename MSR and shared memory specific function=
s
>
> Mario Limonciello (2):
>        CPPC: Use heterogeneous core topology for identifying boost numera=
tor
>        cpufreq/amd-pstate: Fix non kerneldoc comment
>
> Perry Yuan (1):
>        x86/cpufeatures: Add feature bits for AMD heterogeneous processor
>
>   arch/x86/include/asm/cpufeatures.h |  1 +
>   arch/x86/include/asm/processor.h   | 13 +++++++++++++
>   arch/x86/kernel/acpi/cppc.c        | 30 ++++++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/amd.c          | 29 +++++++++++++++++++++++++++++
>   arch/x86/kernel/cpu/scattered.c    |  1 +
>   drivers/cpufreq/amd-pstate.c       | 36
> +++++++++++++++++++++++-------------
>   6 files changed, 97 insertions(+), 13 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

