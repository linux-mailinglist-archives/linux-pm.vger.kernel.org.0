Return-Path: <linux-pm+bounces-14031-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 765509755D5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 16:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F58C1F23878
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 14:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4B41A00F4;
	Wed, 11 Sep 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L74e2Vb/"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A419F11A
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065851; cv=none; b=Lx9JyHCTDZQShLEk9fS9pNSB1rz/sokDF3Zmb7p1cQCQnJObMFzJ6YYAt2lotAMv8AV/4riLuofLq7WKw+hQup3AeazrqBGp2JuN1lw73nPhSOaTrHID3Nqvm5UXxEam6sATOLcaciRf2PR/Oumb0AHdAQzN2xNm57oyfrpqio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065851; c=relaxed/simple;
	bh=iqhekQpgF0jHhpw8nJ2/Kn8cdwcAUVS4TkfaIDPmsZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaJRIojCpCR8emYFXKwyg22BhkMK0oiub5LAOvGfEV+MXegfodsIbHI7qSwYMCH/dtDijMfmsmy8+K0RaeKGjFSNPpUynjgNHxRMX5W533ckWgHA+7ayaweWEJMxO2JO4ZoAZSwweAgmx96R9DBh+SD2xro8pc+ths+9QwH2KFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L74e2Vb/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F0A5C4CEC0
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 14:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726065851;
	bh=iqhekQpgF0jHhpw8nJ2/Kn8cdwcAUVS4TkfaIDPmsZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L74e2Vb/dGjqtvugB93zfySrHA5n/OZh45HkOZBp1CzV6dGW1VndcsmiUmLJM3iYD
	 1g2ozFBr4Se3EgwLMnOU5WUQkZSaMqSnk0cn2YZq3aH6dlcEYC93pamT4ty6JxZiS0
	 qUzqajVjmUQbk/7A3bWdlDm3iQScVhGgcs7np/JwSoU6QIXWuwIqVnseItyWDLmUAo
	 W1EcMXt8Xwcnklvo+xhOHOkt/+Owjbzm1Wf3BZnxkDZfFfO+oLwIJ44R8Ae6E6OIu0
	 Jhz6lunaIMxFjZ1R7Wrv3eLZ+p0W3mzWMei4KacPd9cVbXTjDUh/tOuYW/PHhHVcXX
	 5rCHmJdIG6LBQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-277f35c01f5so3215611fac.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 07:44:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVehCMoBUVKxGWoBrAzWKyCLQrqob/k8hZmjVoj3F25JPPYR0cEa2AqeU3gjsZo+35oTzGEClqjoA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hM4bIqj8vRtJtKNY7zSRzR7jrFTBhU/1BFBMtSjvQyQugdGa
	Zp8qz2EbsFQI62Pw6AQTnUogsX24Bn8DcLyYJjM7VbVzjNBZhbpu2Tv5Kg+AoHn3KnEIGDf996b
	85Sasl43KWZHi92FFWm8ExTEh41U=
X-Google-Smtp-Source: AGHT+IEkd5j9KsfnPVUDHh355t7xVr+Uyj2ELaCq+/4ljndyQtmih+aUxf22tW3BLRl9Y/0IVycngjNksA+qNlerXE8=
X-Received: by 2002:a05:6870:1590:b0:277:f5d8:b77b with SMTP id
 586e51a60fabf-27b9dd81873mr11563020fac.32.1726065850439; Wed, 11 Sep 2024
 07:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da6db097-d4a7-425f-8e61-084a2fe15770@amd.com> <CAJZ5v0gzUbiaT5_74NSPv9bbBO4GfCoEfx-M0JHHMqYkn5N+8w@mail.gmail.com>
In-Reply-To: <CAJZ5v0gzUbiaT5_74NSPv9bbBO4GfCoEfx-M0JHHMqYkn5N+8w@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 11 Sep 2024 16:43:59 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jG57Oq_rdoGzXABdxHGvQ9yqeG1f-850LmtmFy+3MFKg@mail.gmail.com>
Message-ID: <CAJZ5v0jG57Oq_rdoGzXABdxHGvQ9yqeG1f-850LmtmFy+3MFKg@mail.gmail.com>
Subject: Re: Second round of amd-pstate 6.12 content
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 6:38=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> Hi Mario,
>
> On Mon, Sep 9, 2024 at 5:52=E2=80=AFPM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> >
> > Hi,
> >
> > The following changes since commit 8cc214312cf8a0c3702edd1aa52e507262ad=
ccb9:
> >
> >    Merge branch 'pm-opp' into linux-next (2024-09-06 20:53:58 +0200)
> >
> > are available in the Git repository at:
> >
> >
> > ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.gi=
t
> > tags/amd-pstate-v6.12-2024-09-09
> >
> > for you to fetch changes up to e121c01c0422fc56033d0dfa1bf3f0366115d2d5=
:
> >
> >    cpufreq/amd-pstate-ut: Add test case for mode switches (2024-09-09
> > 10:26:26 -0500)
> >
> > ----------------------------------------------------------------
> > second round of amd-pstate changes for 6.12:
> >
> > * Move the calculation of the AMD boost numerator outside of
> >    amd-pstate, correcting acpi-cpufreq on systems with preferred cores
> > * Harden preferred core detection to avoid potential false positives
> > * Add extra unit test coverage for mode state machine
> >
> > ----------------------------------------------------------------
> > Mario Limonciello (13):
> >        x86/amd: Move amd_get_highest_perf() from amd.c to cppc.c
> >        ACPI: CPPC: Adjust return code for inline functions in
> > !CONFIG_ACPI_CPPC_LIB
> >        x86/amd: Rename amd_get_highest_perf() to
> > amd_get_boost_ratio_numerator()
> >        ACPI: CPPC: Drop check for non zero perf ratio
> >        ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to=
 warn
> >        x86/amd: Move amd_get_highest_perf() out of amd-pstate
> >        x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator=
()
> >        cpufreq: amd-pstate: Merge amd_pstate_highest_perf_set() into
> > amd_get_boost_ratio_numerator()
> >        cpufreq: amd-pstate: Optimize amd_pstate_update_limits()
> >        cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefco=
re`
> >        amd-pstate: Add missing documentation for
> > `amd_pstate_prefcore_ranking`
> >        cpufreq/amd-pstate: Export symbols for changing modes
> >        cpufreq/amd-pstate-ut: Add test case for mode switches
> >
> >   Documentation/admin-guide/pm/amd-pstate.rst |  15 ++++++++++++++-
> >   arch/x86/include/asm/processor.h            |   3 ---
> >   arch/x86/kernel/acpi/cppc.c                 | 172
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++-----------
> >   arch/x86/kernel/cpu/amd.c                   |  16 ----------------
> >   drivers/cpufreq/acpi-cpufreq.c              |  12 +++++++++---
> >   drivers/cpufreq/amd-pstate-ut.c             |  41
> > ++++++++++++++++++++++++++++++++++++++++-
> >   drivers/cpufreq/amd-pstate.c                | 151
> > +++++++++++++++++++++++++++++++++++++++--------------------------------=
---------------------------------------------------------------------------=
-----
> >   drivers/cpufreq/amd-pstate.h                |  14 ++++++++++++++
> >   include/acpi/cppc_acpi.h                    |  41
> > ++++++++++++++++++++++++++++-------------
> >   9 files changed, 305 insertions(+), 160 deletions(-)
>
> Pulled and added to the linux-next branch in linux-pm.git, thanks!

And unpulled because it was based on the linux-next branch of the day.

Basically, please don't do this.

Please base your pull requests on top of mainline commits and if there
are dependencies out-of-the-mainline dependencies you need to pull in,
please ask for immutable branches to pull from.

Thanks!

