Return-Path: <linux-pm+bounces-10781-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C192A5C0
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 17:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5837D281E22
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2024 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC3A1EA6F;
	Mon,  8 Jul 2024 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H895hAnB"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACB1E898;
	Mon,  8 Jul 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452860; cv=none; b=TgFiE8T8A+4oBOFkvthVMCq30z/hkDyYEZzQKZ084UEb8Oz8352IPmhT2XjjrhTde3jlaqKn5rgHqkXs8pyonkGNYCIeEjuO9gAZOqpNWtV6W1IF5SRXF/3VRUtOjT0MRrIOG6UNnQVR5DuNtuXVylGJ3HXKpMpbR97I/kyhbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452860; c=relaxed/simple;
	bh=bjT8YM48i7xRH3wglMs5xcA+3xrehrIEyq+D060lvpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7lrLC+QZx+DiecYzhpO6qp5+jCezgOHLUJD1tTDYXBGrLsHBzV24PWI6V0tOV3TFAoOpUe+UTUR2m9ryO/aN9BOKh2UlRqyISfG+ap9qZlmWcLpbsS49WJzqy43jBhktF8UZ5HvNNevpr34mWbBYETBbN5GZ836ERO4B8mB8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H895hAnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB481C116B1;
	Mon,  8 Jul 2024 15:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452859;
	bh=bjT8YM48i7xRH3wglMs5xcA+3xrehrIEyq+D060lvpk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H895hAnBdi/M0lSbV7Oo2heyJpbJx70i7KuCyrTEb1I3+0Dazmxhs8JiJHoG7EZH3
	 3kHL/6uApPc/df0N9l32y3iejzeDWlotIUiEUkOGx3Yz+aXk8590J1ho6KEh3xSFml
	 TckWcqcJjz5ki01nWx3SZ0DDub2T63kYgsd1d0EqsW+xM5Vkk4l9HcpOFmdncMPAWY
	 L2bKBV3AQZeRQBEdyDImJxz6skyZ31zrYvqdEb5sb6MKs4tAH8T9B3TRDWCO+R5j0X
	 AkvIQDezd4pnFO5k+bNC58X7a3SjVaRAhGv9Wv2y7dMHeQfz4iuf4d+CJaVp+BQQJO
	 VXh1oadTXuw2w==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-25e7408fc4eso103699fac.2;
        Mon, 08 Jul 2024 08:34:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWhIcF+Nm/65yysDPFchNoPM/AXbT0Nk5uE6fYTIv3hjlobmJYLo9ajHDlq33+D3yWlF98JrzDe+yZMyWACEoJze81XuvQN95FM6QDYhjalv3U7D1SgKo83KYg4US5ZqGq6oFgN0Xw=
X-Gm-Message-State: AOJu0YzcCcRJxuyQIWZEPthWdqD+vTWton6mc4xCNWpXayW8ytsf5E+k
	3hJAnawx0oymfCiP0lbLUMi+TtaxYZA1zWl6D9Z+J5lvrAVogsEqHeoAF31BnL4oKGuE+CdUhmZ
	ToUDdygf99KQGyU5EjvCjZjxb2cM=
X-Google-Smtp-Source: AGHT+IFst4ZiFmt+5/OIaJpfKqEk5oW8i8iUO+4zlGE2eshhSVg9925RENqwjRD0D/ms7Df+GGWSrWbU9AXPuKbYPE4=
X-Received: by 2002:a05:6871:24d9:b0:258:4ae8:4aec with SMTP id
 586e51a60fabf-25e2bf90e00mr11134003fac.3.1720452859173; Mon, 08 Jul 2024
 08:34:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00aaf29c-e638-4161-90fa-49eff270598e@linuxfoundation.org>
In-Reply-To: <00aaf29c-e638-4161-90fa-49eff270598e@linuxfoundation.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jul 2024 17:34:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ge_tv_5Nz97drBn2DXdZXRK5ahZvQsuszfibUB+nOKhA@mail.gmail.com>
Message-ID: <CAJZ5v0ge_tv_5Nz97drBn2DXdZXRK5ahZvQsuszfibUB+nOKhA@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower second update for Linux 6.11-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Renninger <trenn@suse.de>, shuah <shuah@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuah,

On Sat, Jul 6, 2024 at 12:45=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> Hi Rafael,
>
> Please pull the following cpupower second update for Linux 6.11-rc1.
>
> This cpupower second update for Linux 6.11-rc1 consists of
>
> -- fix to install cpupower library in standard librray intall
>     location - /usr/lib
> -- disable direct build of cpupower bench as it can only be
>     built from the cpupower main makefile.
>
> diff is attached.
>
> thanks,
> -- Shuah
>
> ----------------------------------------------------------------
> The following changes since commit 3e1f12c26646eb0ad67d3eaefd32f765997da6=
a8:
>
>    cpupower: Change the var type of the 'monitor' subcommand display mode=
 (2024-06-20 10:08:08 -0600)
>
> are available in the Git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-c=
pupower-6.11-rc1-2
>
> for you to fetch changes up to 3a5bb5066f4c7170e850b930e84b1075e25f8e90:
>
>    cpupower: fix lib default installation path (2024-07-02 15:30:32 -0600=
)
>
> ----------------------------------------------------------------
> linux-cpupower-6.11-rc1-2
>
> This cpupower second update for Linux 6.11-rc1 consists of
>
> -- fix to install cpupower library in standard librray intall
>     location - /usr/lib
> -- disable direct build of cpupower bench as it can only be
>    built from the cpupower main makefile.
>
> ----------------------------------------------------------------
> Roman Storozhenko (2):
>        cpupower: Disable direct build of the 'bench' subproject
>        cpupower: fix lib default installation path
>
>   tools/power/cpupower/Makefile       | 10 +---------
>   tools/power/cpupower/bench/Makefile |  5 +++++
>   2 files changed, 6 insertions(+), 9 deletions(-)
> ----------------------------------------------------------------

Pulled and added to linux-pm.git/linux-next, thanks!

