Return-Path: <linux-pm+bounces-40401-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFB5CFFFD5
	for <lists+linux-pm@lfdr.de>; Wed, 07 Jan 2026 21:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF2FD30060E8
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jan 2026 20:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A575337BA3;
	Wed,  7 Jan 2026 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aq8jhRyJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB6318BA5
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767817178; cv=none; b=V5xNV7f/kkJJO9bqm/TbZDZWZEaczPi8u7xoBIYHrEpjFchBOXFVvg7QDemy/OvjQuxu+QrfLs0OfGoBHatzl+gwKWzR1jKuuTsGWBlGhEURXa9rexlHN0xGwh+erXhHF0gkYdIxTXrSEiXcI9MNU6ao72QkrUgH+OAgHQhO9Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767817178; c=relaxed/simple;
	bh=XWOJZY1KI1938/VQ5jGsEuyvxOUY6Racr3XgT7JgVjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEJ4b4CxPtJbtxBUYWh/MxZlfleUDyVqd5T0VdgLGyNJRhfy6Gap1oAA2iXHo1xL4UZsvR5mHHLsziOZ3Z5nEe+vBezsIe0FcIxSasY5PlYYMwbRo5+1KzieZUEXsta8y+DpFaQLN6GnvTRNw9oTZE8CJDapoenuiblYIXX8lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aq8jhRyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC745C19423
	for <linux-pm@vger.kernel.org>; Wed,  7 Jan 2026 20:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767817178;
	bh=XWOJZY1KI1938/VQ5jGsEuyvxOUY6Racr3XgT7JgVjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Aq8jhRyJVXh9qu0Xl7X1nALXvlY0eLw+gLYwlEFoMewDZFUtvYiPyAhsKR4Jdn234
	 LG1Xr+D3zbUzbuuHEE50XYPBKfjlVLYrXx1g5pNiTR54HJa3g28+YlCu+SJxSoODCq
	 PnlTXrV7Xd7DnY65zmbxr754H522mfLTPbbekfai7Xt5RHrHYkpZ2GjrjhHeX97gqz
	 9xaRG2c/odEcmFma3wFUhwGoLx4eXadAeVD5nqAOZkxYlA775LQFNInSUCtJOEOH26
	 vPr8oei1nDQHsY57agN2lJArr6CEd70kqZ3QgiY/cUKnQzKIFu1lj/8ftNbW/X4SIB
	 XT0kKOwd+ajqQ==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3f4f9ea26aaso1857731fac.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Jan 2026 12:19:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVsGLSDOxQTK483k6wtGdCQkJ78GHNy6zVcJDyjZiw4//hQxmbtU1Kbb5cNYWFK8xC2uI0PGfiBWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyThVWSdcMtQPRQn0x9llW252ObeayOIoevqZxvxkCjlI4pfKm
	yoDFuUzm/hh/U2fnzsuGgZBsBn8OIhW/kH9hRclnXqHxNiP92xUVJgIW6mR5E0MrSJUyNN1U4Nv
	6LlRP360C5+lTDwsz/l7k0hPsR2/G+Vk=
X-Google-Smtp-Source: AGHT+IFHUn6avikGUvv7Ul+Jkyxbcqm50BoxszjxHg3D0KjEcui7gBF6o2+fS2hjyiAvewjiKAEAax1MvEZjAUhJnm0=
X-Received: by 2002:a05:6820:2207:b0:659:9a49:9022 with SMTP id
 006d021491bc7-65f55098a40mr1476114eaf.79.1767817177795; Wed, 07 Jan 2026
 12:19:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216080402.156988-1-dedekind1@gmail.com>
In-Reply-To: <20251216080402.156988-1-dedekind1@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 21:19:26 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j3RN4UyJB8HV+kQ8dSLfErXPWPx1oTsog4dYB1z_AExg@mail.gmail.com>
X-Gm-Features: AQt7F2o-KQi8dBuYGD3B4oMfayW4AxwNobZneLVPmZVT4OV6s_ohQ7pHgQ53MYM
Message-ID: <CAJZ5v0j3RN4UyJB8HV+kQ8dSLfErXPWPx1oTsog4dYB1z_AExg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] intel_idle: Add cmdline option to adjust C-states table
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 9:04=E2=80=AFAM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Add a new module parameter to customize the C-states table configuration =
used
> by the intel_idle driver.
>
> * Patch 1/3: Small preparation step for the new feature.
> * Patch 2/3: Implement the new module parameter.
> * Patch 3/3: Add validation for data passed via the new parameter.
>
> Refer to patch 2/3 for details on the parameter name and syntax.
>
> Patches are based on top of v6.19-rc1.
>
> Artem Bityutskiy (3):
>   intel_idle: Initialize sysfs after cpuidle driver initialization
>   intel_idle: Add cmdline option to adjust C-states table
>   intel_idle: Add C-states validation
>
>  drivers/idle/intel_idle.c | 227 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 225 insertions(+), 2 deletions(-)
>
> --

Whole series applied as 6.20 material, thanks!

