Return-Path: <linux-pm+bounces-25578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ACAA90CFA
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 22:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AD219E003B
	for <lists+linux-pm@lfdr.de>; Wed, 16 Apr 2025 20:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBC4229B1A;
	Wed, 16 Apr 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcOZ3WWM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B277219A79
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 20:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834701; cv=none; b=GFFUH97im9/HbXUxcG5/YBL9bQZkqG3d7rBGkAx2ihs1vQzxxn+9jG5qsmdm3zUIXPIrTV1qudtSiHI+8GUOxFPiNT5JPytKwUW+sTcEc2ehxsWjyLenwZyiMBMDqsVtClsQT9HPHQaJ3mB+UYjYXM5zbz+rgI7MlbctVFnQjLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834701; c=relaxed/simple;
	bh=0SmEON0Tw+ZzqwBF2QPH0kEjZgsLnEhgxvYjYRg4ye0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LH/zUYxfpE7qBRJVKHeGfFzF/jNgSVYzLzLzMnP4eDXG2SapIRnDPGoHjHz+dGbSPxCcxm29Dtz1yXYadRVlyj68vPfwD8u+KBvZYgXk2EPqvuuLJYFtdBtivUaNnPvjViS0x1Wc9F+YZBHdJolPwyFHOYu6uHa7vMAuuWBIBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcOZ3WWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2563C4CEE2
	for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744834700;
	bh=0SmEON0Tw+ZzqwBF2QPH0kEjZgsLnEhgxvYjYRg4ye0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bcOZ3WWMnixM4FANu/OD2oz3ruZGJuTV5zqnUeJb+MkkWIofHYuXw+3ucQwGpjq6t
	 usfFcWAlMflJZWm6sgjgZQKciVHp8OLrGFUu6z7JczlKHsAQQ2LRYj6LwChi22Sxau
	 VNnfg2+2XItEysBkKVSBsxAI4L6p1HKJfIQEii5xyWoIrCqR0ljzPk3GHNi6XX2+ur
	 H8G/ZNYhcQKWZByxniZlMfTsB2BwyQhjsY+IdV6ij/4yUw0158Jta/Rw7QZ97D5DjK
	 JhueRQPVEWetBxP1AIPwBXU8890vEkogQ5eUjWjPcLdOwLfGzHSxUUE2dU813/ogzK
	 AyVKFAyphoVGw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2c2504fa876so2034089fac.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Apr 2025 13:18:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUuYwcUR/fLjBGPotvVVEFjST9O4IJk1F1mpIdrPlOvnjO/psX0OhQcuJFmRZXonerfdJwicDYjmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbj7NYPnmlrOdnbskjFr0LR+eRU0YGh76JfHrbe4LdEFenRtKT
	f/eKeV9ho/eeL2jwuI8kIrW1+bWy+tuLcYPKp0jHWax9GUew3x4I1j9gzxFEczPzWiaJP8vyIeG
	Pc+XIIXRaKOZ3jsZ4CaPAJAvT0/U=
X-Google-Smtp-Source: AGHT+IEXa2aduTrtJnKLVgDfMJZEG/0fAQ9rBK/JLb8BuXZK/qu0gCYcYGEDRjjmSyqSQeoKyZ2HZzkRFLSOFjTK/7c=
X-Received: by 2002:a05:6870:fe8a:b0:2b8:ec17:66e9 with SMTP id
 586e51a60fabf-2d4d2aa3809mr2138299fac.11.1744834700040; Wed, 16 Apr 2025
 13:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <51d02a58-433b-470f-86ee-618994cecb22@infradead.org>
In-Reply-To: <51d02a58-433b-470f-86ee-618994cecb22@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 22:18:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jOtYC+5SnY5eM3ys0frwXYJ9oWAC-aBASOT8YBJw6Sqw@mail.gmail.com>
X-Gm-Features: ATxdqUF8RWa3N-MP8eJ5tilT-grwcdjkD2lFL-4bhOBrOlN4CvubkEP6QVMq2io
Message-ID: <CAJZ5v0jOtYC+5SnY5eM3ys0frwXYJ9oWAC-aBASOT8YBJw6Sqw@mail.gmail.com>
Subject: Re: cpufreq governors
To: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Thu, Apr 10, 2025 at 10:39=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
> Hi Rafael,
>
> My little (Intel) laptop needs some performance improvement (IMO) so I se=
t out
> to read Documentation/admin-guide/pm/cpufreq.rst. I still have some
> questions that I hope you can give me some insights into.
>
>
> 1. Can I use the schedutil policy governor even though the P-state govern=
or
> seems to be the default?

Yes, you can.

Change /sys/devices/system/cpu/intel_pstate/status to "passive" and
you'll be able to use regular cpufreq governors, including schedutil.

> 2. Or should I just continue to use the P-state governor? Is it preferred=
?
> If so, why?

That really depends on what you're going to run.

The default intel_pstate internal governor (in the "powersave" mode)
lets the processor adjust itself to the utilization expected by it,
while schedutil gives hints on what utilization is expected by the
kernel to it.  The latter may help it to avoid rising the frequency
too eagerly or to make other similar mistakes sometimes.

It generally is reasonable to try both and see which one works better for y=
ou.

> 3. Can a cpufreq policy governor be changed by whether a laptop is runnin=
g
> on battery power or A/C power?

Yes, this is technically possible, but the kernel doesn't do it.  An
agent in user space that detects configuration changes and makes
adjustments is necessary for that.

> Thanks for your help.

No problem.

