Return-Path: <linux-pm+bounces-10141-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B820F91AFB8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 21:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4055DB213E8
	for <lists+linux-pm@lfdr.de>; Thu, 27 Jun 2024 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEBC19D06D;
	Thu, 27 Jun 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYSLOh7e"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230519DF90;
	Thu, 27 Jun 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719516680; cv=none; b=hfzVoTpUiAqcPYfJiGDdd5n/j1DV50QQ/U96RxYEPWFPe6w7PHT+Eoa9c4AYgnT7KlKbrlXGIFd4zWiGKnAoZbi7+8hKeaS5HrXUmseZF3ZVbxnfC7V5C5duNEkL8zwdQoYcDxdaBoKYkbnHhBWaRsnJBUfrhgE7PgDBztpmsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719516680; c=relaxed/simple;
	bh=3poSqnkU27MlbMUArOdTV7Zd/i8XTuPHTq/gY272ASs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3lujdvmHXPzYjQNHKGO9OORhoIYI+S/UKSMSeAZPZbEFZqq3bH3JJunQuOphm4xdyPfQcOS50rq4LyRiKZ2AcLdEas55iLjI0npz/W1V25j+T6jEWarX9TK45DN+mYrJGhpFy4tCtLv55MAWk2H3fTLzExjS/VC+heBcsfjsbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYSLOh7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56191C2BD10;
	Thu, 27 Jun 2024 19:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719516680;
	bh=3poSqnkU27MlbMUArOdTV7Zd/i8XTuPHTq/gY272ASs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cYSLOh7eesEE/dCEO0mxEyhAZTrTH3Z5MxH2qcFahnSMDbPjrSoQw5p6hwShGBxnp
	 8/wvykNxcZ9UObm/XGdNe4NLxKBbN1xGIVLuh5VXdCZNgR1PXwjSfsZup25Rumb6S0
	 A1xG0CHkxzzzQjPpnw7NNp36gD4clbb3+v7Cw1Loq9NieK6WG/dvo+nl1y3GBqwM+H
	 7TBQiMkaIGvjpJ/928qaM4ODFiXdE9xvrIGu2EW/AdxK9psEB3SkhYzOKF+VtqhGdh
	 kC97oEbHBsA1nLLonVKSaM9tAiedgM9jEdDFbid5XNY0WbUpeukt7jVw6fIw2MnWX0
	 QENwkLoJMq7Ew==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5c1bd1c7baaso371731eaf.0;
        Thu, 27 Jun 2024 12:31:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyYAQopMQgEFtWWZp8zfcTw2xVqB34eStWhibmgGae83Tw7dohJEW+7Cd6PIgnPMkKV3gTROd0v+U/Nqd4zOHHR4n0tHq6ekeB1CiTxg4zz0yFK8qAXShkP8ozYh9CGOXBTQ1Cjng=
X-Gm-Message-State: AOJu0YxuVrwZf4FG2FlN8R9++jWqf5ozgjBxQhCXO8sO7lMW1W+ulxda
	Bi/1EXAIhaVm78F3fQLAwwcgZ14fW4gnlU/pf+CIigunVQ/m9exjkl65LCt5q+xEZfZnXWc5cBg
	ud6OgP9pZ1Ynp/+9iwMVf6wOMTBM=
X-Google-Smtp-Source: AGHT+IHHhllphzFt6NUYtGazmnIKi8U79UcPjh58779psCVSvH7ADdMppyTG63IdsU2A2l3/6GdamGq8aBuuOjBvYAY=
X-Received: by 2002:a4a:a789:0:b0:5c2:20aa:db25 with SMTP id
 006d021491bc7-5c4135bae77mr765841eaf.1.1719516679658; Thu, 27 Jun 2024
 12:31:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b9e0ae38-006f-4c72-bb64-f39e6002fc84@linuxfoundation.org>
In-Reply-To: <b9e0ae38-006f-4c72-bb64-f39e6002fc84@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Jun 2024 21:31:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcVJkpAkY1Y9MkfYRF5=sRGVTuzoerF5M4CPsSYGhqGw@mail.gmail.com>
Message-ID: <CAJZ5v0gcVJkpAkY1Y9MkfYRF5=sRGVTuzoerF5M4CPsSYGhqGw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.11-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, trenn@suse.de, shuah <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Tue, Jun 25, 2024 at 11:10=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower update for Linux 6.11-rc1.
>
> This cpupower update for Linux 6.11-rc1 consists of cleanups to man
> pages, README files, and enhancements to add help to Makefile.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 43cad521c6d228ea0c51e248f8e5b3a6295a28=
49:
>
>    tools/power/cpupower: Fix Pstate frequency reporting on AMD Family 1Ah=
 CPUs (2024-05-28 09:22:57 -0600)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.11-rc1
>
> for you to fetch changes up to 3e1f12c26646eb0ad67d3eaefd32f765997da6a8:
>
>    cpupower: Change the var type of the 'monitor' subcommand display mode=
 (2024-06-20 10:08:08 -0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.11-rc1
>
> This cpupower update for Linux 6.11-rc1 consists of cleanups to man
> pages, README files, and enhancements to add help to Makefile.
>
> ----------------------------------------------------------------
> Roman Storozhenko (5):
>        cpupower: Replace a dead reference link with working ones
>        cpupower: Add 'help' target to the main Makefile
>        cpupower: Improve cpupower build process description
>        cpupower: Remove absent 'v' parameter from monitor man page
>        cpupower: Change the var type of the 'monitor' subcommand display =
mode
>
>   tools/power/cpupower/Makefile                      |  37 ++++-
>   tools/power/cpupower/README                        | 160 ++++++++++++++=
+++++--
>   tools/power/cpupower/man/cpupower-monitor.1        |  13 +-
>   .../cpupower/utils/idle_monitor/cpupower-monitor.c |   2 +-
>   4 files changed, 192 insertions(+), 20 deletions(-)
> ----------------------------------------------------------------

Pulled and added to the linux-next branch in linux-pm.git, thanks!

