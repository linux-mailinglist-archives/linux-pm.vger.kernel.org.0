Return-Path: <linux-pm+bounces-9956-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B80916ACA
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 16:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B1DDB2326E
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFD616D9B4;
	Tue, 25 Jun 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odto6c8B"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A3A16D4FD
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 14:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326467; cv=none; b=WiaubpbWa2OPK4RD1wQSUH+tIIFvwmn9ZdGfziSk+K1JTMgiCHb+kvjZhy7z9L1h4b01T39DSeg930tpG9iX0xa4Rmz2cBwg2EJFBmu/CiBvYnQmFwqz39HfSxTMSg6ei06NsqrJxVxww4l1Le4mxjNkEFFh3omYYEbuANfyUNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326467; c=relaxed/simple;
	bh=tXEqWf/YOg9qC0QElcuuFgnioP9IBAVtHme0Q+BioKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OitnT1r3btdQrJ6F6F2Mp6iezTgOd0uQWL9jOiq/2dKdcnm88dVj+lIv8DkNKwwZcEVZui8guRoDrXrQ8c5Ji4NRNVlIBVjHpPEZxnr0q7smYGaQQESC5GfK+hP+UMJthXHSoLYFFN8+u5HMUwnyv1DBLxs+i2ebdFKNFYFTIUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odto6c8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E194C4AF09
	for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 14:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719326467;
	bh=tXEqWf/YOg9qC0QElcuuFgnioP9IBAVtHme0Q+BioKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=odto6c8BM24MyJuhcaKWFjxf3c5iR2H7Qpx1TnK11wsEXoJiWrgsIM55j0nBI+LFf
	 Mx3bNy9jmyabkGpWyvNYaUY5L8/So4ZjDS9PsMd4vXpdkhzmW7B0UsUt54z2Z/qNwI
	 bwiYQsLOz/iYBzYoZjCni6UEpDXjy9z4pp12inC+gZhHfa38ahltTn6goQszJisj0r
	 0PIhswYTMOwhmmhSDrEoJeNgfKreEDieXM26/6ubbq3sTttE39GcOSVM7bhnMjFBmi
	 LBr3+9sJWeImlApQdU1E2ogyIDAvxEyDN39B2mIOdLcf/4ofXuFZ7UFQp3JlcN8Vkd
	 rLeqauDuizM9w==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-25cb022c0e6so647073fac.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Jun 2024 07:41:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKEhGpWegul9UOEJJE8JofuyqleWiXLkqW9mONYVHyP2fdiawoUGjkQ0RU75Bd9WHRXyi5ZqDJSOIBZT1mfUXKBSIvM/agk9c=
X-Gm-Message-State: AOJu0Yw5eN089eikMIiIj+WaGoJ6Tx842MrRiejMgyLNYQw8qFiDuxRp
	J6zfwT1jW63LPQBtBrxde3AU1tLAtFIc9Q7+hNBhVh53cBeRDYbzQhc/0LYR7ppGAuF/4GAxoZR
	Gt4e6e3sxtEy0DrEO8v4GIOgTtio=
X-Google-Smtp-Source: AGHT+IEPafqeuc2+BxuUZrP/yRK7sYO8mATiEChxwPdnx4ImZj1/cXkuiIdkjbqRJDIdwwNDF0vebPiDivxHw5jyRz4=
X-Received: by 2002:a05:6870:5589:b0:250:826d:5202 with SMTP id
 586e51a60fabf-25cf3f2d0bbmr9979592fac.3.1719326466351; Tue, 25 Jun 2024
 07:41:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <111b995d-b99e-416e-85a9-39c144c8b23c@amd.com>
In-Reply-To: <111b995d-b99e-416e-85a9-39c144c8b23c@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 25 Jun 2024 16:40:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0huXc550F7VoMd7FQjExp5TVt9vKB3dqwfQfgZf4unQ4g@mail.gmail.com>
Message-ID: <CAJZ5v0huXc550F7VoMd7FQjExp5TVt9vKB3dqwfQfgZf4unQ4g@mail.gmail.com>
Subject: Re: Second set of amd-pstate changes for 6.11
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 11:31=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit c00d476cbcef4cbcf0c7db8944df7e98a36bdb=
fa:
>
>    cpufreq: amd-pstate: change cpu freq transition delay for some models
> (2024-06-11 16:12:12 -0500)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.11-2024-06-24
>
>                                                                      for
> you to fetch changes up to 2240d3e60bb3e7a00422596412d012aeb54c1573:
>
>    cpufreq: simplify boolean parsing with kstrtobool in store function
> (2024-06-24 16:16:16 -0500)
>
> ----------------------------------------------------------------
> The second round of changes for amd-pstate in 6.11:
> * Enables amd-pstate by default in "shared memory" designs without a
> dedicated MSR.
> * Adds extra infrastructure for debugging problems.
> * Bug fixes found for init/unload failure
>
>
> ----------------------------------------------------------------
> Mario Limonciello (3):
>        cpufreq: amd-pstate: Allow users to write 'default' EPP string
>        cpufreq: amd-pstate: Make amd-pstate unit tests depend on amd-psta=
te
>        cpufreq: amd-pstate: Don't create attributes when registration fai=
ls
>
> Meng Li (1):
>        cpufreq/amd-pstate: fix setting policy current frequency value
>
> Perry Yuan (9):
>        cpufreq: amd-pstate: optimize the initial frequency values
> verification
>        cpufreq: amd-pstate: remove unused variable nominal_freq
>        cpufreq: amd-pstate: show CPPC debug message if CPPC is not suppor=
ted
>        cpufreq: amd-pstate: add debug message while CPPC is supported
> and disabled by SBIOS
>        Documentation: PM: amd-pstate: add guided mode to the Operation mo=
de
>        cpufreq: amd-pstate: switch boot_cpu_has() to cpu_feature_enabled(=
)
>        cpufreq: amd-pstate: enable shared memory type CPPC by default
>        cpufreq: amd-pstate: auto-load pstate driver by default
>        cpufreq: simplify boolean parsing with kstrtobool in store functio=
n
>
>   Documentation/admin-guide/pm/amd-pstate.rst |   2 +-
>   drivers/cpufreq/Kconfig.x86                 |   1 +
>   drivers/cpufreq/amd-pstate.c                | 176
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------=
---------------
>   drivers/cpufreq/amd-pstate.h                |   1 +
>   drivers/cpufreq/cpufreq.c                   |  11 +++---
>   5 files changed, 122 insertions(+), 69 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

