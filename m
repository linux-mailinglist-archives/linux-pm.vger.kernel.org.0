Return-Path: <linux-pm+bounces-22303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD3FA39C6F
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 13:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B6C3A3DED
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2025 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AEE2594AA;
	Tue, 18 Feb 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDihVnEx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746331ABEA5
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739882910; cv=none; b=NlQoGb7nVUdt1PGA7vz44kNnB/ECdwzJ1C13rrNIgF38vH91uKezMj3+0AMqSheI0gtbQI6rtZM5OK1Vu84zEwsACYwLVTiPZW5ay2+uMgpV98wKGxKgVqakOxiCv3QaEY51JQkRqBt7SSuhQVPmHVJiGqw9jiZntAi0zMj7Iks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739882910; c=relaxed/simple;
	bh=4Wajts5C4DVOytCToa0HcW4DaOFuKIZvesYTgTXzOSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh/jwj/UKIXhiSq3pvU315sqjxE3Npy9X53qdTCAlbH69NQ9DjKb8nphH2Li3tD8zIQXCjj42JGKvLbrZpW6Hy+0FfU2y34XP28+wNtxRuwkZkY3MLZwqEneVMsjuWCqZ7hn8WltBmr2QONcR7r/M64Rk8VIZcb1C30o3vABwWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDihVnEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555CDC4CEE7
	for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739882910;
	bh=4Wajts5C4DVOytCToa0HcW4DaOFuKIZvesYTgTXzOSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eDihVnEx3HUauYFMprB5jlADzXlQRCUGDy1BUcFFKDVNIqNny1SZcqHR2rcj3c+t9
	 Gaz3dKRzirmUQBOcHnk9B6raRd1XJ9uGJSTwBxR8sBI6laRYaAfik0K8gS3oyvfa3J
	 sXhGqShfZP9LX8GHJmQ8az7qpzHAIENKhIlOA0Szn+/NuAq/RTqmNZ+MDB0oyyvv1S
	 t3W3JJhre0ATwOo05Qv95PINUv2wPFJ+vLvwPywz2obPTXV3GNz7gyi88+XrfwAV5s
	 egr7cpGFbw/VLoSA17NCMb3YBC1mMa+21iMPAJbQ7DTC0Pt/R+6Ii0g8XR3KEeoNX0
	 MJ58OCkpM8Jew==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3f3edbef7d2so637428b6e.2
        for <linux-pm@vger.kernel.org>; Tue, 18 Feb 2025 04:48:30 -0800 (PST)
X-Gm-Message-State: AOJu0YzkRFz+LAY2jiYCcPdEZdK81GpTD730vdzX8/YUELr2BA4EZrYO
	MmDsv5OUg//yrZFg75H3HZy/6k5aNbSxjnDKSPeLaOAF2dv13dFhIGWJ7HdG17EJ6WsqrpHYqwv
	9YbNY8supsgn2M5MRpXZowv10ymA=
X-Google-Smtp-Source: AGHT+IFAYYdRnV3mctnMWkpa/mSLAZA9eUJ1KqvAVCirPkNMGgK5Hg7hNNr+eFEwkqTEOOzk7sp2eQjor9qoX5WgBUk=
X-Received: by 2002:a05:6808:108:b0:3f3:f90b:f1b3 with SMTP id
 5614622812f47-3f3f90bf3cdmr5389012b6e.5.1739882909678; Tue, 18 Feb 2025
 04:48:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140145.117086-1-ulf.hansson@linaro.org>
In-Reply-To: <20250217140145.117086-1-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 13:48:18 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hi=zCuhmVRf2HVRWkR53U7xqxC3oQDs8-JN-cyQ+ZX1w@mail.gmail.com>
X-Gm-Features: AWEUYZnnvYFMyqphU69gZtzfxM7ILKlQw4ij5EP7oNNdsC9rL2vp247xH18uGKk
Message-ID: <CAJZ5v0hi=zCuhmVRf2HVRWkR53U7xqxC3oQDs8-JN-cyQ+ZX1w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update section for cpuidle-psci
To: Ulf Hansson <ulf.hansson@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 3:01=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> Add myself as a co-maintainer for the cpuidle-psci driver and the
> corresponding git-tree, which I am already using for this.

Lorenzo, Sudeep, any objections?

Ulf, do you want me to pick this up?

> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25c86f47353d..f2be70dec4ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6087,9 +6087,11 @@ F:       include/linux/platform_data/cpuidle-exyno=
s.h
>  CPUIDLE DRIVER - ARM PSCI
>  M:     Lorenzo Pieralisi <lpieralisi@kernel.org>
>  M:     Sudeep Holla <sudeep.holla@arm.com>
> +M:     Ulf Hansson <ulf.hansson@linaro.org>
>  L:     linux-pm@vger.kernel.org
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribe=
rs)
>  S:     Supported
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.g=
it
>  F:     drivers/cpuidle/cpuidle-psci.c
>
>  CPUIDLE DRIVER - ARM PSCI PM DOMAIN
> --
> 2.43.0
>

