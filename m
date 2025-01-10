Return-Path: <linux-pm+bounces-20224-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8157A091BB
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 14:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2697160EDE
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2025 13:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCDB920D4FB;
	Fri, 10 Jan 2025 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QF8j2/B4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CE4206F14
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736515298; cv=none; b=obT7dqjMPDf4jsXV7/Yaz9ILOI1tONPE5KplrqcDu09na8sZVMyemkC3XOqSZl2PfBNfLm4/lkE6i/XLHBk4MlC28VTcQnBxHluStL6gw6Nh3rbBhIsZKKRS11qzZmAc3u21GCiBU8C8aodaFgIWeG9QhyKVvqbgydbhnsYk0gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736515298; c=relaxed/simple;
	bh=9RmVsSLSb1+ZA860nuB6hWS3y1joE6pVuKx7tXB+pkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gY3qsyQENSpz+bbJ5019EgsaTRXA+ITOJT91YP/Qm5fUzBa59IJthc1HMiE16QK6IccO+lGn3AEcoPKEJgAg4f+cSqW06HqKvb0DYf86Sf+BrxfpDYt7KHxBgblb5C9KuW6dxGcRbac+gpFEI8tAX4OwbhQ2EFCwP0D8cd+JtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QF8j2/B4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8EDC4CEE0
	for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736515298;
	bh=9RmVsSLSb1+ZA860nuB6hWS3y1joE6pVuKx7tXB+pkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QF8j2/B48v2BWTU54b6fK0olWwZsR3gHAOa3oNEM5NBXI8jmhwWExHArXzresfhmo
	 lrBrLnj8/0cE4B8V7k7/GTt34EOpvBDsQa7GBU9qgT0cn7l9lwtSb/32ui6/b4TMaI
	 U7KMGc9G6yJJNsXrZHz6+zPT5SPVhO0TYILq1kC7UYzCCmwRAhHdax4ZGotliwQpRo
	 9k2okcgjsrqQWQ3bmlhg79NoPlGcOUzeRUXdso6+AEUVcQfBTLjVMRTKDI5gd8raYW
	 eIsWxanmitcVSIrferqQDbBQuix8TEAuGPgVei4/SkfNFV37QTKJWeDma3Frl08Dd2
	 FY086IiCl0Uew==
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2a383315d96so992198fac.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Jan 2025 05:21:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJz+Mhw9VaIpr8IffMRHBKAJ8IIBb86lNW+C3b7HgL7jfQrzQcLw6pTFF5SJ0jM7gXvB34cSn4nA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGvE5zutvOXftoHe8vozMVeFxxHclcaLRTM1oEfCG9PmumffH
	u5eK7ewXqmtaLIYl9OeWXo6GN8W95ZqlHLI0Vlh3U0m/p6lkAgOgQPb/mDHu8a7La7T/cg4dhk7
	rTcbJfL1OgDsSf1qwmqXZlHMGTaQ=
X-Google-Smtp-Source: AGHT+IH77mu0HXZRtPSf/w/zox+efdXTKMYgx6WKokQuBxyciQiS2LoK2YTKpi8jhGCkEaBR+ELfysfsxsXcCMjTeLA=
X-Received: by 2002:a05:6870:ae85:b0:2a3:8280:c23e with SMTP id
 586e51a60fabf-2aa06970212mr5305839fac.39.1736515297558; Fri, 10 Jan 2025
 05:21:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <913e9c94-4e3b-4c1e-b626-4f2c64068bd0@amd.com>
In-Reply-To: <913e9c94-4e3b-4c1e-b626-4f2c64068bd0@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 Jan 2025 14:21:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g-mVW2PMpcZ4WqrzqUh04WEMfK3A76smGMS9S2XkYoUQ@mail.gmail.com>
X-Gm-Features: AbW1kvZfcHRfZsx7eQ9DSMZjh5Pkdv-uqsGOUA3ZLXzjjI0fTvOlu4xUygj9QIk
Message-ID: <CAJZ5v0g-mVW2PMpcZ4WqrzqUh04WEMfK3A76smGMS9S2XkYoUQ@mail.gmail.com>
Subject: Re: [GIT PULL] amd-pstate-6.14 content 1/7/25
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 7, 2025 at 10:37=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Hello,
>
> The following changes since commit 95fad7fb58cfaa2a295aa54a1f001a16b93249=
63:
>
>    cpufreq/amd-pstate: Drop boost_state variable (2024-12-11 10:44:53 -06=
00)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.14-2025-01-07
>
> for you to fetch changes up to 857a61c2ce74e30fc3b10bc89d68ddd8d05b188c:
>
>    cpufreq/amd-pstate: Refactor max frequency calculation (2025-01-03
> 23:44:07 -0600)
>
> ----------------------------------------------------------------
> amd-pstate-6.14 content 1/7/25
>
> Fix a regression with preferred core rankings not being used.
> Fix a precision issue with frequency calculation.
>
> ----------------------------------------------------------------
> Mario Limonciello (1):
>        cpufreq/amd-pstate: Fix prefcore rankings
>
> Naresh Solanki (1):
>        cpufreq/amd-pstate: Refactor max frequency calculation
>
>   drivers/cpufreq/amd-pstate.c | 15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)

Pulled and added to linux-pm.git/linux-next, thanks!

