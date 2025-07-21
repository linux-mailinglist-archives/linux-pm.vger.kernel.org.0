Return-Path: <linux-pm+bounces-31191-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7BCB0C1A9
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 12:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E58C16C335
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D1822156D;
	Mon, 21 Jul 2025 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axRlvRVL"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587EA20F098;
	Mon, 21 Jul 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094841; cv=none; b=Zr5oaQq5/ccC3tA+OLeduwnDkai/NMS8SM2MfNiueei0gWdYqH78UeN1r7UXoQ6AV51EHXPtKOvo0a2cKi/UE8hSoGNXThzQLviLXUUPKfKsURdktUVIymyqqhMZpmLSKiehqPwL2Wa5GhBTbE2CGq9Jb4EhOAye7S1i6gdQadU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094841; c=relaxed/simple;
	bh=3FMPJPp3df9gByQS0Cpx715xJINI9Xitl6FDlUEf6zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLtY48SneWIDouBEDVic0UF/uxbDEqmj8b6tgYCWVdxKAYZh1fkV0iuqrVEBeZhaqxlIgrWJGSD9IXoxZEl6MoKU4yulPLdlqgdmDGBrTWzQJs5AZ0hojWBTpAa7OJKRS6zqbwHiP4XFm05fHa6FlGgRV1N7BVIFMcD6lA1eUVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axRlvRVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1A4C4CEED;
	Mon, 21 Jul 2025 10:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753094840;
	bh=3FMPJPp3df9gByQS0Cpx715xJINI9Xitl6FDlUEf6zQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=axRlvRVLDqeXIGc2Xg4/di/1cpxxWGScS1qcyGJ5SEpSPOB241zUXmHvWpmWcAaoq
	 ieKOXjVS+Qn9pWjUgrrSBPLpjYpvT6SWQD4LiWNHvLx238r8Emo0BjzOhkMHI7/yV9
	 xI+YfSaj3DweQVDJGY7Dcl/S/RV9MPZ2rpv9vr5jVSfGNU+CPF8r7buRvqW2GyBIHh
	 bPkVbcgJTKdXHGzb37jycf2EoRxLczaibZDhYeE36viOsYZ46+rAMCthQjQlzhaKnq
	 PwpOvfYAn0lOnCpi1x4Uqa4HUlHnPPC6HhIOcYpKR9anXJvmEXLgvqMtA2/3jgrfrh
	 loR0O8wvkzrdQ==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-303058a8649so411460fac.3;
        Mon, 21 Jul 2025 03:47:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF0JHMugLL8rBhGhMPaRyBz4hp+6Xxm9Z2s7bOTGqL+7ba7Kwznb7TOjHOJkyRDskw5kOL+Xo3Bb2gbj0=@vger.kernel.org, AJvYcCWHji7ToFVrYIt0/HHgvU7IAJ9epkYImetXE8h7uyCeNodbAek5eiW3TTNG5ZnKxhqdD+vI73NJiW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+HzVtzCHOcTA2KggGA6433UL+7ACKJKIv2PsnwtjCnLh5es0
	x2/5kZGgw+cKnYY2ojccvcFNEXhVQVtzyjaUkYEufqAUsQJ/0WzXYqjIp6Nxv1izgENABlXL/VR
	mFtXdCMHBI9blKKyyG2X76y1EKQu7e84=
X-Google-Smtp-Source: AGHT+IHoA3NB6bGtDLs5HIlXOYswhNHuEDsY4pLw82JzTmx51HqfQuMxqfj5zre25qH3RzQ5oIZKQv2bzMs8n3539ac=
X-Received: by 2002:a05:6871:bb05:b0:2d8:957a:5176 with SMTP id
 586e51a60fabf-2ffb223d877mr15763192fac.5.1753094840034; Mon, 21 Jul 2025
 03:47:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fd09dd9-59f5-4852-b796-e458c89aa193@kernel.org>
In-Reply-To: <2fd09dd9-59f5-4852-b796-e458c89aa193@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 12:47:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gr5MVorUtqJr_wiKL0Q_LYHGMABugSPmnHcxVJ2rc_dQ@mail.gmail.com>
X-Gm-Features: Ac12FXwrBG7MSeCDJdE5b9saITtmL8RLidXvLvyOlCXJrlp55qATP9FQnJPiZlI
Message-ID: <CAJZ5v0gr5MVorUtqJr_wiKL0Q_LYHGMABugSPmnHcxVJ2rc_dQ@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.17
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	"open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chanwoo,

On Sat, Jul 19, 2025 at 5:26=E2=80=AFAM Chanwoo Choi <chanwoo@kernel.org> w=
rote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.17. I add detailed description o=
f
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit 347e9f5043c89695b01e66b3ed111755afcf19=
11:
>
>   Linux 6.16-rc6 (2025-07-13 14:25:58 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/de=
vfreq-next-for-6.17
>
> for you to fetch changes up to 7da2fdaaa1e6062686ac96a9f096c2d7847533e4:
>
>   PM / devfreq: Add HiSilicon uncore frequency scaling driver (2025-07-14=
 20:23:57 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.17
>
> Detailed description for this pull request:
> - Clean devfreq core and fix bugs
>  : Replace sscanf with kstrtoul
>  : Remove redundant devfreq_get_freq_range() on adding devfreq driver
>  : Check missing NULL pointer check on removing devfreq driver
>  : Limit max_freq and min_freq to avoid unreachable value
>  : Fix wrong index on trans_stat sysfs node
>
> - Use devm_* managed function for clock control on sun81-a33-mbus driver
>
> - Add HiSilicon uncore frequencye scaling driver for for HiSilicon Kunpen=
g SoCs
>  : The uncore domain includes shared system resources such as interconnec=
ts
>  and L3 cache, and its frequency has a significant impact on system perfo=
rmance
>  and power consumption. The driver provides the following functions:
>    - Support to scale frequency scaling with governor and user setting
>    - Support to query CPUs whose performance is closely related to the un=
core domain
>    - Communication with the platform controller via an ACPI PCC mailbox
>      to perform actual frequency changes
>
> ----------------------------------------------------------------
> Chanwoo Choi (1):
>       PM / devfreq: Fix a index typo in trans_stat
>
> Jie Zhan (2):
>       PM / devfreq: Allow devfreq driver to add custom sysfs ABIs
>       PM / devfreq: Add HiSilicon uncore frequency scaling driver
>
> Lifeng Zheng (4):
>       PM / devfreq: governor: Replace sscanf() with kstrtoul() in set_fre=
q_store()
>       PM / devfreq: Limit max_freq with scaling_mina_freq
>       PM / devfreq: Remove redundant devfreq_get_freq_range() calling in =
devfreq_add_device()
>       PM / devfreq: Check governor before using governor->name
>
> Uwe Kleine-K=C3=B6nig (1):
>       PM / devfreq: sun8i-a33-mbus: Simplify by using more devm functions
>
>  Documentation/ABI/testing/sysfs-class-devfreq |   9 +
>  drivers/devfreq/Kconfig                       |  11 +
>  drivers/devfreq/Makefile                      |   1 +
>  drivers/devfreq/devfreq.c                     |  23 +-
>  drivers/devfreq/governor_userspace.c          |   6 +-
>  drivers/devfreq/hisi_uncore_freq.c            | 658 ++++++++++++++++++++=
++++++
>  drivers/devfreq/sun8i-a33-mbus.c              |  38 +-
>  include/linux/devfreq.h                       |   4 +
>  8 files changed, 704 insertions(+), 46 deletions(-)
>  create mode 100644 drivers/devfreq/hisi_uncore_freq.c

Pulled, thank you!

