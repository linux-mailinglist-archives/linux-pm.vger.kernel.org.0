Return-Path: <linux-pm+bounces-23024-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0AEA46BBB
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 21:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C507A5164
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 20:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9823275606;
	Wed, 26 Feb 2025 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG+lOpeA"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BDC275602;
	Wed, 26 Feb 2025 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599833; cv=none; b=EAPzp9nwWjgVwNW93bQe+nKodQdkhBmh9zJqvJfkYvMNbqn/9gJMql4h6/LRejMN9xQgIRvlm3/uhZyBBBkaSqeTSKwpTu2GlZUv8MP6Dtaq4uNzevaBJOmJ8YecPbZjIPDI6fq6bQ2ypKw+ucYizxWyHEdPZwIT8e0390DsPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599833; c=relaxed/simple;
	bh=kIG+ERIckn5eC2R/vDAFUn4qvcjlEI3cz/8tvhHVb88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFUk4mwEbxXUt/VdPt51LFcHFGU9Sti3u8E4eXdojtrcEVO1lUBvXW9mQ+Ft86YXGuT8Pj+Ukn7QidKI/CD6POxYW/kQmAbA+V+32vC8jvuA2TLekLfJ4u4zFvV221PL+yYPWMxvznisw/jyJ4Ga4VjDYnLlmKd9DUe6bbvkmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG+lOpeA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFDF4C4CEE8;
	Wed, 26 Feb 2025 19:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740599832;
	bh=kIG+ERIckn5eC2R/vDAFUn4qvcjlEI3cz/8tvhHVb88=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mG+lOpeAqN+8Y8D18XBHrwPD0/RL4i2ipinaiDjYHOcK1f5zO4vagZxtvtYZBf2zf
	 qwuutyY1uFKX1uWqBprmNMMNktbvGiZ5eYMOJ+0x3JA6yDXqXKuzwa/F0U4mxEAtPe
	 N9uJ1ALqFI7CIAZ9I6M/GMQTVmTbpVnlano2EbMyghwkdsjlH3P/P0C42tOX53TgYy
	 RgjeCaI6hPhgG8doqUXBXFxCsEMIjbhP3OhcIU8V6dvZ8jxBFJ3yi2x/iYkmWXOleS
	 2gT1ndYmSoECw7U3Msyql6GSbjJ7Hdv5vH6poSllt6dv1+ic91l0E4t5RNjsanjStZ
	 gMFlmAiA9iFcA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2bc79a81e6bso92091fac.0;
        Wed, 26 Feb 2025 11:57:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXJXBnXnrHEuGUQ3kYAQRW8kvQfcWQBZO475dLY5hNTqxxVJGtNHW41U/QU+odVSUI5QhTTdQjCpw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGlCz46Qxsqc4lWH9wf8WX6/twUicu7FFOghD0GvZlnvBPtliu
	VoYtzZ/qFG4YetcET/UVO3V1eiaB9dfF59mCuA6kug1aru4oms6UPbRWs9DG0wPhp4HrGIupHCt
	YB/XkpsRMYjS14e+YueGsKWjpv8E=
X-Google-Smtp-Source: AGHT+IFFqN/GkDn2JKscMKhiV8OGzkookyDLPH2k/d1CKOSDClZwy4YLcKRa4eU7SsOOh+8f0BtPyXXP7wNQZ+R6Uns=
X-Received: by 2002:a05:6870:d147:b0:2b8:82ef:1d15 with SMTP id
 586e51a60fabf-2c10f304ba8mr5135553fac.22.1740599832259; Wed, 26 Feb 2025
 11:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173432.1946070-1-lukasz.luba@arm.com>
In-Reply-To: <20250224173432.1946070-1-lukasz.luba@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 20:57:01 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iaUCXkqkOyBwn2ZwKLFc+ozstf3Rq-n-_eetK6A9vtPA@mail.gmail.com>
X-Gm-Features: AQ5f1JroDiB95lrODpV0nRKpZJLk5Laj38MOw2KvUcXNz-u6kD_347qtzd7UbWA
Message-ID: <CAJZ5v0iaUCXkqkOyBwn2ZwKLFc+ozstf3Rq-n-_eetK6A9vtPA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Thermal: clean-up with kcalloc()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, rafael@kernel.org, 
	daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	srinivas.pandruvada@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:34=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
> Hi all,
>
> This is just small clean-up inspired by this patch [1].
> It aims to keep the thermal framework up-to-date with the
> recommendations in the community [2]. If there are (or will be)
> some static checks in this area, we will be OK.
>
> The patches are on top of latest thermal/linux-next branch
>
> Regards,
> Lukasz Luba
>
> [1] https://lore.kernel.org/lkml/20250222-thermal_kcalloc-v1-1-9f7a747fbe=
d7@ethancedwards.com/
> [2] https://www.kernel.org/doc/html/next/process/deprecated.html#open-cod=
ed-arithmetic-in-allocator-arguments
>
> Lukasz Luba (4):
>   thermal: OF: Use kcalloc() instead of kzalloc() with multiplication
>   thermal: k3_j72xx_bandgap: Use kcalloc() instead of kzalloc()
>   thermal: int340x: Use kcalloc() instead of kzalloc() with
>     multiplication
>   thermal: hisi: Use kcalloc() instead of kzalloc() with multiplication
>
>  drivers/thermal/hisi_thermal.c                               | 4 ++--
>  drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c | 4 ++--
>  drivers/thermal/k3_j72xx_bandgap.c                           | 4 ++--
>  drivers/thermal/thermal_of.c                                 | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>
> --

All applied as 6.15 material, thanks!

