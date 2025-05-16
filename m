Return-Path: <linux-pm+bounces-27251-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B15DABA485
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 22:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75408A26222
	for <lists+linux-pm@lfdr.de>; Fri, 16 May 2025 20:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D3E27FB18;
	Fri, 16 May 2025 20:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpQ1GXoA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D922B8AA;
	Fri, 16 May 2025 20:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426249; cv=none; b=Mnrvn8Zz5t/IvRkaNHCf870dj0fstoGf0sDMfggfMop2h5lwroGuRb5VUSMLBtbOQXFSmf3QS8mJJih3aniTjjBHwRJ58JYfoYqKkGmcwZKdBwc4lpgW+nRApV0V3F9XhhI7UCBfQjAMH2hZPNrw/zQmZTGdKVojmAQzcmWHPGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426249; c=relaxed/simple;
	bh=RsJnEiGMfY8ySPPNgglNSloP9TqnLcQUKwlGcW87ldA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/lT+2kFjG68ruWR32TsD/CoGKyPK/Y2yH43g4D6JU7LIO5KQHHBabBvV4VYfMzd2aNiit7YR/NlruGbmt+gIjnTTv6NmcJK9L0ZbGpXbLmMmJHQJzYF+BHLbGbjPSRTa2v0+n6l8CU9Dz8BdE9GYScEayOJGK1D/8uYyODal90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpQ1GXoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5230C4AF09;
	Fri, 16 May 2025 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747426248;
	bh=RsJnEiGMfY8ySPPNgglNSloP9TqnLcQUKwlGcW87ldA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dpQ1GXoAtxByNY2ZegVsAqN9huV9U6VbzhWIV9j1VvjENDgsosiB/3OefOuneZ4AW
	 mSLyewjWf6bvu/Yu6fWExozEYiFNqCci8BD2Rk2/DcBa2YLs2Y1c+EZORhvch+z5/g
	 9VlWiMZRIuB266v+zS1JYIhS/B+s1szWhqhjnrOckY3FuOFy6Iqf/q3Nr88yAk6pzQ
	 YYJIrUyhF/9tIKD6ypxZYy6r0OMNpe3DfBmXMcPhSb2uXozDsTHKQ53Dsl3Warqnus
	 kxOjKsEq1pdJmS6mrzMmKe5DX54mKKqzbj9Ds2cLySVQ6gM3jzkFwYk8gcDk4rMwVI
	 ex1VMxg5Jj1/g==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3feaedb531dso900248b6e.3;
        Fri, 16 May 2025 13:10:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2MkJtG+Lqn6Mkc/cIpFA8bJpGdFB/h0Nu4dIEeY3AM9SSiXOa/ODb7mLC78IlmsacqPkRxUSt/TvIbA8=@vger.kernel.org, AJvYcCUr/L/1xJdchBoqHfwMVevMatFpMH45Cy4cNpj/Q1G89NQvK1rwLZokYjHk/xINeCxAwhBelK5mu14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/S0v18RphxE0qBGWpN5OKaNkygDO9Z9pnnc6ZRmpBACuZGiYs
	3gKIc5UuXri/I/ReoQsg2vdWNeU1rgS1L/ndXHB12qj1/UnMu09vkvOHTJBua6D3nkpcA4reETP
	zcKVHfIyHK1aGxXSPmfLjpGqcVjyWY/M=
X-Google-Smtp-Source: AGHT+IF3WM6A+G1l0V7kg3GZor06elBl/cpIa0xxStoGLdD/RWX+Anzm256mOdkT+SoLG5OELZwYv0iqxnO//JumcbM=
X-Received: by 2002:a05:6808:6b98:b0:3f9:aeb6:6eac with SMTP id
 5614622812f47-404da7debffmr2431834b6e.30.1747426247985; Fri, 16 May 2025
 13:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b8f0f04d-ce16-4be0-93fe-b2416ee08653@linuxfoundation.org>
In-Reply-To: <b8f0f04d-ce16-4be0-93fe-b2416ee08653@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 16 May 2025 22:10:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gEewLNomFKbyDMa523ED3MD9Stx9dpvBF6g4mihCHBTw@mail.gmail.com>
X-Gm-Features: AX0GCFsxXUTiWWuqOnKuEDb718Hw4Jfanz2ARfvgl3Fepv2GL7-5-l1Aw0fl78o
Message-ID: <CAJZ5v0gEewLNomFKbyDMa523ED3MD9Stx9dpvBF6g4mihCHBTw@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 6.16-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.com>, 
	Thomas Renninger <trenn@suse.de>, "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Fri, May 16, 2025 at 10:06=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower  update for Linux 6.16-rc1.
>
> Adds systemd service to run cpupower and changes binding's makefile
> to use -lcpupower.
>
>          cpupower: add a systemd service to run cpupower
>          cpupower: do not write DESTDIR to cpupower.service
>          cpupower: do not call systemctl at install time
>          cpupower: do not install files to /etc/default/
>          cpupower: change binding's makefile to use -lcpupower
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit b4432656b36e5cc1d50a1f2dc15357543add53=
0e:
>
>    Linux 6.15-rc4 (2025-04-27 15:19:23 -0700)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.16-rc1
>
> for you to fetch changes up to e5174365c13246ed8fd2d40900edec37be6f7a34:
>
>    cpupower: do not install files to /etc/default/ (2025-05-13 16:06:28 -=
0600)
>
> ----------------------------------------------------------------
> linux-cpupower-6.16-rc1
>
> Adds systemd service to run cpupower and changes binding's makefile
> to use -lcpupower.
>
>          cpupower: add a systemd service to run cpupower
>          cpupower: do not write DESTDIR to cpupower.service
>          cpupower: do not call systemctl at install time
>          cpupower: do not install files to /etc/default/
>          cpupower: change binding's makefile to use -lcpupower
>
> ----------------------------------------------------------------
> Francesco Poli (wintermute) (4):
>        cpupower: add a systemd service to run cpupower
>        cpupower: do not write DESTDIR to cpupower.service
>        cpupower: do not call systemctl at install time
>        cpupower: do not install files to /etc/default/
>
> John B. Wyatt IV (1):
>        cpupower: change binding's makefile to use -lcpupower
>
>   tools/power/cpupower/Makefile                 | 13 +++++++++++
>   tools/power/cpupower/README                   | 28 ++++++++++++++++++++=
+++
>   tools/power/cpupower/bindings/python/Makefile |  8 +++----
>   tools/power/cpupower/bindings/python/README   | 13 ++++++-----
>   tools/power/cpupower/cpupower-service.conf    | 32 ++++++++++++++++++++=
+++++++
>   tools/power/cpupower/cpupower.service.in      | 16 ++++++++++++++
>   tools/power/cpupower/cpupower.sh              | 26 ++++++++++++++++++++=
++
>   7 files changed, 126 insertions(+), 10 deletions(-)
>   create mode 100644 tools/power/cpupower/cpupower-service.conf
>   create mode 100644 tools/power/cpupower/cpupower.service.in
>   create mode 100644 tools/power/cpupower/cpupower.sh
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!

