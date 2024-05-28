Return-Path: <linux-pm+bounces-8309-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC68D2583
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 22:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5323B28B9F
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4717839C;
	Tue, 28 May 2024 20:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mf2N1bev"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DC6178393;
	Tue, 28 May 2024 20:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926954; cv=none; b=sz9SYCHzreutPOQIi+PpKdPI6Jtf2KV8jo4j5tIzq5getv/M2zjqS6H9FsmWGSviWdD++kLKK3D9gOGvfeMIVrZ9XfrIQvj+D05k+OarmsZy4XmZQ41fo7jMImh5o9yU8gLjuGWGR5Cw8EuN63uc7TGhQYlwOHJcdh4i6mimydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926954; c=relaxed/simple;
	bh=8QnMZFZKFg20MQCYf8ihjmTnHQooY3pQYkCguY3HAj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUwCDQDl7KxUE2PgHGJRidD13+t8dYRE26yBo0alwC9osOgmoZWC3FBl/O2ZMiUS3/qrox/Z78DOTlmtBAeBXAO4Wjmzg9/Hmc5rw9oS48lA57KR5okV7mWVYYVdBbBvJFlrnGtUIIlS8HcVOUIz9gcrr47odZnI3qjnFbAMQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mf2N1bev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979F1C3277B;
	Tue, 28 May 2024 20:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716926953;
	bh=8QnMZFZKFg20MQCYf8ihjmTnHQooY3pQYkCguY3HAj4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mf2N1bev3AlP9AvPEWPr/P7AEWl9Fg2oA1hGeMXB/T2lX/GL/1JBbgNaq5qIoJhGR
	 5P6wu7IZq9dnLMfEkajMwXYEGTG2zQsU4EXUcxscspcjXcloYrOV2Sb92W//+iRo7L
	 E2QaAfGRxGFaig8nLkByY2A8WlfNNpTmn373WoFDlLYmO95mx+u07eH/MHloGWaTDl
	 R2z/oIy/Mc7Rw2ozN2D3/UVTBgJuP/NYWKpq0zHiMeN65vkmtqfKUAD+I+3NRkB4Ed
	 soHhRhx+cjjcDMN+GN91ISauK2Yf4hjwV4j5/87dFQPiqRqqptmjb1Jbk7HVUWTnmB
	 B1Qa7dokY5fgw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b9b2af488bso25988eaf.3;
        Tue, 28 May 2024 13:09:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXeB238T4yvdWAXPWgNGYLvdPafyGMKsSw4eQQpAmHipGipKJI+xsQkcl8/hzc4CE9C8iZ0SfMyuLYCDOoynl056IIqGuSDDoiTR1mNkPSpRscNaQ7Doa2IgQnlbLcvGeyk43caW1A=
X-Gm-Message-State: AOJu0Yw3oOhbqTZ+qpG0UULZ+Ah8jRmmjp0WcL3wLlITWMs/YAZFrXtC
	2+kN/AQufAtmXx5F47VnZopZ5dlPBMW5RYeJQQa5Cncbbfft3PEJRjSFePT4oXnkkeY1pbZnL/L
	2e6woLBco2eZDOhPbdSdL8yODEAI=
X-Google-Smtp-Source: AGHT+IFscTCEYQVZ2h1RefS9hDmcYwWjJK0/UTeztgw+1BDQuEZKmDKwZMM7y6LOzHb7+DxkFZ5dkdSJ+t9fUq7Ra44=
X-Received: by 2002:a4a:5501:0:b0:5b2:7d9f:e708 with SMTP id
 006d021491bc7-5b96166a3dcmr15658098eaf.1.1716926952878; Tue, 28 May 2024
 13:09:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ff1faf8-eec4-4776-a590-4efbc141fe93@linuxfoundation.org>
In-Reply-To: <9ff1faf8-eec4-4776-a590-4efbc141fe93@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 22:09:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jy66cKMQ=C4Wfk6rxLDg7Lt4vn7nkQRAtNn6pbvd_o3A@mail.gmail.com>
Message-ID: <CAJZ5v0jy66cKMQ=C4Wfk6rxLDg7Lt4vn7nkQRAtNn6pbvd_o3A@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.10-rc2
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, May 28, 2024 at 5:34=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower fixes update for Linux 6.10-rc2.
>
> This cpupower fixes update for Linux 6.10-rc2 consists of one single
> fix to cpupower's P-State frequency calculation and reporting with
> AMD Family 1Ah+ processors, when using the acpi-cpufreq driver.
>
> diff is attached.

Pulled, thanks!

> ----------------------------------------------------------------
>
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>
>    Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.10-rc2
>
> for you to fetch changes up to 43cad521c6d228ea0c51e248f8e5b3a6295a2849:
>
>    tools/power/cpupower: Fix Pstate frequency reporting on AMD Family 1Ah=
 CPUs (2024-05-28 09:22:57 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.10-rc2
>
> This cpupower fixes update for Linux 6.10-rc2 consists of one single
> fix to cpupower's P-State frequency calculation and reporting with
> AMD Family 1Ah+ processors, when using the acpi-cpufreq driver.
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (1):
>        tools/power/cpupower: Fix Pstate frequency reporting on AMD Family=
 1Ah CPUs
>
>   tools/power/cpupower/utils/helpers/amd.c | 26 +++++++++++++++++++++++--=
-
>   1 file changed, 23 insertions(+), 3 deletions(-)
> ----------------------------------------------------------------

