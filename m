Return-Path: <linux-pm+bounces-25555-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 298B8A8B9B8
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 15:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5B941903DD9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DB22087;
	Wed, 16 Apr 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMNGWDJH"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE81E2F56
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744808423; cv=none; b=LcDWAn0hOlInV5fKynFA5hNdhEa8DxpsXY5wl6wFiG9x/1/3ZhQ8KNq3W7DwNHGyllcItbFzFEH+fxVK8C5JEQABuMM2qbZpaOz0bHnEKHfdarJw9QbhqzeZQ2bwj3vPQgUGbX7uskTr0gyt5SlhNsYgRx9ILXJQ7Qp5G3MItmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744808423; c=relaxed/simple;
	bh=cKIfsARnMUIhoY9fffBNnv92iNasXZJU5oFiFWPysPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hPku0LzcOw6Kfm3Pdg8PvM/mL9tG4h8El7o6bfZjDN52jNlwaer7kuAv5nYQUzwjK2TAXjY1Rikfdq/U4Q2xPKNn8Vy4KLj3o8MTljX//uY6WKOoSJjK3LsIk1dAFMF+KnVoPohDThtIwZmXWxCiwlJWqwyZd2iRSdFWiNNXnLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMNGWDJH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22653C4CEED
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744808423;
	bh=cKIfsARnMUIhoY9fffBNnv92iNasXZJU5oFiFWPysPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NMNGWDJHPzdt0idRqjSBCdu4WAhZp7kGy5mpYzCVTcg2nRZoTJS26allgGqxy61Wk
	 gMBRu3ZDLeTTfAASzF7n4u1RqAi+SnS9xWoLX/UqF5H1WPPKqCS76I9tTVMOBUdr4S
	 kSq6xJCunK0s1K9pepQBF+TU5QMymgV18LyrEm7ppJ0pvWLoTtVvUNQkz7UW8m+Vt+
	 pjOjA4KtAi9H1chATqZ3HyDHs3TdgBjuHK7waf8HN34wK9hYuWpnaHrp/COXcU3lrn
	 +u4sHUSV36FYko/fKKCaRBpLaD9VK7FvCUd2QFEpLFDEUC7o9exokeKbHMpQi1jCgR
	 KLdrnaRycFQpg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso4301509fac.2
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 06:00:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVF9u1r56ZTcVNF+Cabwx7StiF3I1C15AawaqiMIp/LrKiAxPCBUdb4ctJ1evOVlpET6F/Ei0FYYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL5o4a+MG/t+f8MO7QzL1bn+aWUc1TKcVgx1PczgaZazHUHwNA
	sHt8Lg6S+ALVqUT93nWdnlIEl/wjpsm3b0BpwNF3Wmuw+kugJ7dUdTGOl1ejRO0KaAFxty+p9Qb
	wFcoW1vw5VL3E4BMPGyHc4sPmy3w=
X-Google-Smtp-Source: AGHT+IE/FWA/GoieSsxtLFzi9LCSe4WmQCU/HIyhAMPALGAQ29cWpHsE2RgvjLrqSQfEJIsL6cW+NZz+gOTMhwmeYPI=
X-Received: by 2002:a05:6870:64a4:b0:2bc:9787:affe with SMTP id
 586e51a60fabf-2d4d2a56ffemr845357fac.10.1744808422373; Wed, 16 Apr 2025
 06:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <57a8a0a9-170a-439d-80f6-3351f0416eb2@kernel.org>
In-Reply-To: <57a8a0a9-170a-439d-80f6-3351f0416eb2@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 15:00:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h7oFNjBqcHEW64Sg7FFtLuGYptkCpSdFuDwmAeMDotxg@mail.gmail.com>
X-Gm-Features: ATxdqUF8zcNEgbQquIR9g5DYf_MqwkwLg5E3UWByK94YxbI-nYJd6y8yFOWdypM
Message-ID: <CAJZ5v0h7oFNjBqcHEW64Sg7FFtLuGYptkCpSdFuDwmAeMDotxg@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate content for 6.15 (4/15/25)
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 11:04=E2=80=AFPM Mario Limonciello <superm1@kernel.=
org> wrote:
>
> The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089a=
c8:
>
>    Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.15-2025-04-15
>
> for you to fetch changes up to d87e4026d1b20e4f237b29e0c956ad415f533de2:
>
>    cpufreq/amd-pstate: Enable ITMT support after initializing core
> rankings (2025-04-11 12:49:57 -0500)
>
> ----------------------------------------------------------------
> amd-pstate content for 6.15 (4/15/25)
>
> Add a fix for X3D processors where depending upon what BIOS was
> set initially rankings might be set improperly.
>
> Add a fix for changing min/max limits while on the performance
> governor.
>
> ----------------------------------------------------------------
> Dhananjay Ugwekar (1):
>        cpufreq/amd-pstate: Fix min_limit perf and freq updation for
> performance governor
>
> K Prateek Nayak (1):
>        cpufreq/amd-pstate: Enable ITMT support after initializing core
> rankings
>
>   drivers/cpufreq/amd-pstate.c | 36 +++++++++++++++---------------------
>   1 file changed, 15 insertions(+), 21 deletions(-)

Pulled and added to linux-pm.git/fixes, thanks!

