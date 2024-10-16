Return-Path: <linux-pm+bounces-15798-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C5B9A1426
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 22:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D264F1F211FE
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 20:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BC02144CD;
	Wed, 16 Oct 2024 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMQS1ea/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F7F9C1
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 20:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729111114; cv=none; b=liPGQXGGE/mAat647vurdFpWu+NneLBbLWKvbTIVSH1w78NLR0PdS1FJFxCuT1DCQ3dMT7dfYHl1E5PSBPPgJs6oOfym9VxUB3bdEyVmuLf3nhZ0nDTxjlxIw525eLZbRFAD7UCDruMV3scvQJfJ07rzfqek2AyJJcBQJ/nF3vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729111114; c=relaxed/simple;
	bh=V1pUvQwk4o+EVtTgXpUUyfg0t6vdXJcxl66hUr9cydE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yub7vsrN8vf/OJq5nxhCgJm+J4wkXFkYCj08zszgUX1YBA3aX2tf2k4aJjjRzLyludJOYLyJ6M40helS3gkKjjPhMBqibzArbzQDLfz0MG45fZrpG1oql1GSPiujLxLiQcPfppYubEJEB4VHHS6X/JthAb4wY7c5yTgM5+JqhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMQS1ea/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4980CC4CED0
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 20:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729111114;
	bh=V1pUvQwk4o+EVtTgXpUUyfg0t6vdXJcxl66hUr9cydE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AMQS1ea/VIAunBjeeIZGL1slqemZoWl6bs7mjKGb8EDZLs+711EI5PHif7ZkiTsr7
	 vNfNgcmSs3gPGckCX2nKtM6mGm9oPpsQFsFHOpf4SxrCgcmoPrGqYQc3jSHy16VKKl
	 m5ePl+k5/RXTcY8zIuiRsI5HyKPOaaWP10xPBrBtChnohWKsFxSbCLE8iwvWZG9p03
	 3NTyzw+iEquWeConpC+QR1axyUvlnWPbECnrqnBIpS1P5tAUQanmQXlOPADhko4G8M
	 GML7ydz50g294optW9hZ55vxrPLfaEXI0/xSnAzzfFAQw4WXyt9K66/FkeGKpcCB0Y
	 +IK0yh9e8p1jQ==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7157c2aca3eso125459a34.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 13:38:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWGurlndDEsTFoVGpc1yBu3x/aTLr4l0nwp2zKRTcbwQzCYQMHsnsAf83wfvjS2H+9bYwyvLpFihg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRZTTy8jbY7WZqKJhK4HGhvFklNpz9plR+n9qGL4ElA1Mnk9gV
	2M9wUFVaYMjZzi+kZ7ogNkGiok5g6UWSo0zBHDGhbFC6/O1Qo4pYZT5FqRXpwszjRUW5yyOlKEb
	ooIOTO1w6ciKp+kmgqURWiESirMg=
X-Google-Smtp-Source: AGHT+IENApk8PoHr0Kzy4KS2OmK2BByWTaZxuscrl7TyDkZpRWiXzdHUE4TLvVqX2bPc9+cMOngMhQ+QzTuApRWzDsk=
X-Received: by 2002:a05:6871:205:b0:277:fe14:e68c with SMTP id
 586e51a60fabf-288edfb6ea0mr4680500fac.33.1729111113551; Wed, 16 Oct 2024
 13:38:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5fe5144-f014-4786-9f56-a04743d1a6d2@amd.com>
In-Reply-To: <c5fe5144-f014-4786-9f56-a04743d1a6d2@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Oct 2024 22:38:22 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iJyzKNCgVuk2EZ7xWr-QtxkLb079kvP6BFRKUKUBjGQg@mail.gmail.com>
Message-ID: <CAJZ5v0iJyzKNCgVuk2EZ7xWr-QtxkLb079kvP6BFRKUKUBjGQg@mail.gmail.com>
Subject: Re: Second round of amd-pstate fixes for 6.12
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 7:49=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit c10e50a469b5ec91eabf653526a22bdce03a9b=
ca:
>
>    cpufreq/amd-pstate: Fix amd_pstate mode switch on shared memory
> systems (2024-10-07 11:32:05 -0500)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.12-2024-10-16
>
>
>
>                                                                  for you
> to fetch changes up to 18d9b52271213890da295a7c63ef8880ed570cd8:
>
>    cpufreq/amd-pstate: Use nominal perf for limits when boost is
> disabled (2024-10-15 23:54:15 -0500)
>
> ----------------------------------------------------------------
> Fix a regression introduced where boost control malfunctioned in amd-psta=
te
>
>
>
>
> ----------------------------------------------------------------
> Mario Limonciello (1):
>        cpufreq/amd-pstate: Use nominal perf for limits when boost is
> disabled
>
>   drivers/cpufreq/amd-pstate.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

