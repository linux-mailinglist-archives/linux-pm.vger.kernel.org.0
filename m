Return-Path: <linux-pm+bounces-9201-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C3D908EC3
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 17:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8991F2273D
	for <lists+linux-pm@lfdr.de>; Fri, 14 Jun 2024 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF4216B720;
	Fri, 14 Jun 2024 15:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uirsK12G"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868C3B1AB
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379007; cv=none; b=ItpwgK6wHE78Zfhz5raKkdqYEpRorsAZNSLP54/2huriVbhEu5DKAbbmSC9Cbl3ChK+2I3S/6vgWNWQddURP9BrdwiArr5m9MCXxe6ssxzqPzwSP92vjMKYrMHcNQKXF0fWIk0mGHc8ZN8PhARf+L1NThk2/zoLKeCgh5eyfUZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379007; c=relaxed/simple;
	bh=INYaHGQZsDSr1w19/9z+7V91Pvd9XYP417oIMYNM03I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZNic1CZLQ3Yz7luexrGr9hq6VBxoZ5dUNylRyqTv9jr9dGfXvN/54Pq5j1oOmQ4Y6t9Z8eHy71wt8d2nhQ+Q2l91UuO5AWoEd+PfNBRorJHW/zmKfGeJimuWeQ5X/dtHN9bZvLlva7YfPcAHq8HF/fACZ/8jXXXrmxr9M5bVMBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uirsK12G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C3AC2BD10
	for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 15:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718379006;
	bh=INYaHGQZsDSr1w19/9z+7V91Pvd9XYP417oIMYNM03I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uirsK12GQSvouoNTiRpx2LPAx0Ho6uNdPw10XdrppIa4rL2UqG2IE2aNBSs3SQWoh
	 xqz029CncHpgJKA1Ipgk0Q8Pii7nSLXkEfoiEQd1FLgS2orAVYDduyS1hajgQ+P/0w
	 o7AtmyaRKcZmA/URty70wHPHNEPkzyVIHLmPUJ18uA4lJmWL7oEeXGWpowDjBFn9zw
	 QPhATJDzDhMacFIngUDFz9fwL7aOuBYk32J6jpCYdPDxqEkcpUvWg+hkoZPZg+kAq3
	 hD3pZ4J97BPVAw6WaC2azPmkwfipnQZOCWrJPZ+PLRI6aj667XOAz+3s0yODnv5xVP
	 0SYG+T+2nV6XQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5bb10cfe7daso191996eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Jun 2024 08:30:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcsL84jvqhEbBNFj+Uhy4nCHd/CHpeIkXa+niQKOG1t7Wfl6pc3awTBuD7aoAl+WnYGc0aRgSLgP1RldWFe2vUV2ti3iPb96c=
X-Gm-Message-State: AOJu0YxGL6CJ23mfq2/M3Aq9l8caLV1vdbFK+oUc309Jqsl55Zhj7Z8k
	FFHh0yJ4F8E8B5KdWR6NXQV8liUgXwdcaWTW73rfs94+SE8P9c3Xz1Cupvhse0IFlz2j29O7hVd
	ug7GeF4mq19iwDbMt68AgjHWKlHM=
X-Google-Smtp-Source: AGHT+IEabitnZUzKvTtIZHCsRaQv56Ufzwk1bVoHI+1GtKyJdy+4iw73VflTRawr3LcUTzZKXc4FaxuiySZBuoz6+/Y=
X-Received: by 2002:a4a:c482:0:b0:5bd:ad72:15d3 with SMTP id
 006d021491bc7-5bdadc0905fmr3201463eaf.1.1718379005922; Fri, 14 Jun 2024
 08:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d8de3761-6fa1-477e-8ed8-71abf115eb60@amd.com>
In-Reply-To: <d8de3761-6fa1-477e-8ed8-71abf115eb60@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Jun 2024 17:29:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jw5_pSoutfvTOrMjQOzcFkiKGvwOPpuJXModbSue6eSw@mail.gmail.com>
Message-ID: <CAJZ5v0jw5_pSoutfvTOrMjQOzcFkiKGvwOPpuJXModbSue6eSw@mail.gmail.com>
Subject: Re: AMD-Pstate new content for v6.11 (2024-06-11)
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:36=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa6=
70:
>
>    Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git
> tags/amd-pstate-v6.11-2024-06-11
>
> for you to fetch changes up to c00d476cbcef4cbcf0c7db8944df7e98a36bdbfa:
>
>    cpufreq: amd-pstate: change cpu freq transition delay for some models
> (2024-06-11 16:12:12 -0500)
>
> ----------------------------------------------------------------
> Add support for "Fast CPPC" which allows some CPUs to operate a tighter
> loop for passive mode.
>
> ----------------------------------------------------------------
> Perry Yuan (1):
>        x86/cpufeatures: Add AMD FAST CPPC feature flag
>
> Xiaojian Du (1):
>        cpufreq: amd-pstate: change cpu freq transition delay for some mod=
els
>
>   arch/x86/include/asm/cpufeatures.h | 1 +
>   arch/x86/kernel/cpu/scattered.c    | 1 +
>   drivers/cpufreq/amd-pstate.c       | 9 +++++++--
>   3 files changed, 9 insertions(+), 2 deletions(-)

Pulled and added to the linux-next branch in linux-pm.git, thanks!

