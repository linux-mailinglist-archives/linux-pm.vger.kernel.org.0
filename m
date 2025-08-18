Return-Path: <linux-pm+bounces-32572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7724B2AE71
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 18:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692EE205E19
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 16:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC96341ABE;
	Mon, 18 Aug 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIHgRNEW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762AD341ADF;
	Mon, 18 Aug 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535407; cv=none; b=O/h4+Lip9p7hP4Ekzm4mxTQ3P1WOu4ATnl9eSwALvMnnC9AKRi3p+1jEEPJycl5od7MDIGG1T/3FEvQOYOFf5kqTQTcWrbHcN3bjtK4rHQpH120+T393VHNa/AQWXIJBSd2LPsgldVo7lhSmj1vK7qggHTSjylWRmBbAEQvnnvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535407; c=relaxed/simple;
	bh=WeyPO3+ZUAD0AlyIcOlB3ZMVaY5abfpYRyoTHYpujyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B//7d0SFN/4U7zr72A0V1wHjqcBQqrZ5IL5gidZFfeJh6uX+kVov45BR/uzROc3TY5CmNcHNC+4ylAJFkNqzmWYQqdlxEUuf9I2gta1hD7fLawR5jA12JnpJ2aIXfmXTCtVUKbNP7Rafi4SpCTyfilzD4+SKHUtM7tWXajMKedk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIHgRNEW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A394C113D0;
	Mon, 18 Aug 2025 16:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755535407;
	bh=WeyPO3+ZUAD0AlyIcOlB3ZMVaY5abfpYRyoTHYpujyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WIHgRNEWHVMAEY5FlbXFLfUwos1YWApCPhvcMFUqhovBl7BLLqMLawTiGlymArNFy
	 8pDMD77ukxzplS3Wri2buBiTL+a3UHnZglMmmsS8Ona2IGkcMrCosQm3OHxkbzFYbe
	 M580YVJ5x1O8sSy1BP4iVnAdRS4ECOV4+Y8MOj8Z+h4cjcV0cU0Zc2sKMcMKGflvFZ
	 aGaAzq0w8w59/LKe/nsc9pduVMThLXgOAMWAcgPEFnNuccngqsqu328N6YHiCNf4aY
	 oInuNnwcMZPoP/sUdifqTwLbE8X52j1caWZijhnUp0SE+/j2yXjxmJbcoEDwvmvBSU
	 v0JvZiZXWKACg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30cceb83f85so2380246fac.2;
        Mon, 18 Aug 2025 09:43:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNB4S4rkxv/WZU1QffnLwJuCH9M7eglFb4o4/O5i6FV8BaEaN5XaJ3BCCRnEAUaUmQHMwD99d/zyLByVg=@vger.kernel.org, AJvYcCWtp6jnaPCooOhuYc2bIWQkwL/pvS5oB4pruIxlpYSsKQ39FvIfIVw2L1FVY0V5TTnphGRAs0K4Juw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHIcuWZVsoZRv11xwvGr+PwzFkiLbnYIpJG4PqzyYqTp99Iv+Z
	EzPjER19uNim+4as5cLtbKrIh/2fM8uNwVUj31jYSbxDi9cBi4o4LdgmLsHmqTds+zYHC3tbyim
	75+n2A9wKTXKwOa3Y1Onu0Nc5Esic5cM=
X-Google-Smtp-Source: AGHT+IFe/wkUVJfcYW6EexHcxdcy9kwSIhP8KOneYccYrtP/dac0djtj7ta+9n3S322Uv5AiX1dyEakg6LKkAwUqOjk=
X-Received: by 2002:a05:6870:6712:b0:302:f093:1c1f with SMTP id
 586e51a60fabf-310aacaad82mr8622329fac.6.1755535406399; Mon, 18 Aug 2025
 09:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fab8f3d9-5ce7-4969-b499-488d50235c8f@linuxfoundation.org>
In-Reply-To: <fab8f3d9-5ce7-4969-b499-488d50235c8f@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Aug 2025 18:43:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gHK-zFUPtZWEMyJqEMJqvPOeFfNf-4B1Nofos+eT6_9Q@mail.gmail.com>
X-Gm-Features: Ac12FXyf5r5UH3rayvzDKilNTvYqJWX8z0yQSRifpbeCRmE_0LoVxlhKvuBkQtk
Message-ID: <CAJZ5v0gHK-zFUPtZWEMyJqEMJqvPOeFfNf-4B1Nofos+eT6_9Q@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.17-rc2
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, 
	Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>, "John B. Wyatt IV" <jwyatt@redhat.com>, 
	John Kacur <jkacur@redhat.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Sat, Aug 16, 2025 at 12:19=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.17-rc2 or
> in your next pr to Linus.
>
> Fixes set subcommand -t option and enables boost control feature on
> non-x86 platforms that support boot control.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d5=
85:
>
>    Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.17-rc2
>
> for you to fetch changes up to 357d1fc38aad2cf4ea6626138cbf68299d20170c:
>
>    cpupower: Allow control of boost feature on non-x86 based systems with=
 boost support. (2025-08-15 10:49:14 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.17-rc2
>
> Fixes set subcommand -t option and enables boost control feature on
> non-x86 platforms that support boot control.
>
> ----------------------------------------------------------------
> Shinji Nomoto (2):
>        cpupower: Fix a bug where the -t option of the set subcommand was =
not working.
>        cpupower: Allow control of boost feature on non-x86 based systems =
with boost support.
>
>   tools/power/cpupower/man/cpupower-set.1      |  7 +--
>   tools/power/cpupower/utils/cpufreq-info.c    | 16 +++++-
>   tools/power/cpupower/utils/cpupower-set.c    |  5 +-
>   tools/power/cpupower/utils/helpers/helpers.h | 14 ++---
>   tools/power/cpupower/utils/helpers/misc.c    | 76 ++++++++++++++++++++-=
-------
>   5 files changed, 83 insertions(+), 35 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/fixes, thanks!

