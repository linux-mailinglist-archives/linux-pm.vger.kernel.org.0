Return-Path: <linux-pm+bounces-40505-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA7D060D0
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 21:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4B93031CE2
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 20:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76DD32ED29;
	Thu,  8 Jan 2026 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP78nnAW"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07CD32BF5B
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767904096; cv=none; b=FQSc5b1XK1J/IqyHTafFfMC/CRr3u4ZEOGHGLN94kkQXapw6kBB9vy9FQsK9D1HkTcL2Wlm3E07zyKJHQUM1JnrYlX+ftnrE2b4ZfpwIH/G40JoYIiFdD/SKDWhQTo95lhmVtZbPZGkT2WuaGAfERzTC0x4p1Aj6+0nqBsDjdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767904096; c=relaxed/simple;
	bh=D8kOCax/RNTjo+hlxUwdx7TKUmMeV6yw8olkrFkANgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CIG1eAlig0fL1GUzcjJEngkvCywLKRYSKENNqY9eKs5gF78mkEvMFxEuSEpK7lXVRGt9gUBlzRKM0Lkzf4DucAS4+OIZwBWFYpOSdpiGkrLI1HjDQOabBZalJAQ9LWztWQbk3HqLsWl/os7VfIaPlqSOxqVuU51V4yqw4GNpG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP78nnAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41617C19422
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 20:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767904096;
	bh=D8kOCax/RNTjo+hlxUwdx7TKUmMeV6yw8olkrFkANgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eP78nnAWns8KOPdHjpazB3v/mn/zUOPP6L2hU0+NixUbp+L48KSgch5KurXL3xs/d
	 ruxz7wZcEpX4cxbhJq+TUB99AzAa29wfrqiHNAUAHTq/zMuhW/gEKRwYNIpCkm/o1q
	 2CVURHYMtB04Geera5H0XBZV/YqfYthpymJar49DU41d94i3DgvQMgxPRJOmxU7R8H
	 1UHtNMkYAlzYngEmA2pcd8vrwFLD7Fi1VT+JtfWNMBA9DxOLJYvANHpq9K/yVIT5f3
	 uRQ9z5WCbCZ4tRq5wzSciNPTducuXVDoOpKZOKyYbam4h8WBx82XPAKAu1dieQ9w3K
	 lmNhSnjlQgyug==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so2535485fac.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 12:28:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjF1rGll57LVbBvGu8W30tDVeP1gDWjd1XdTiwxzfNG2KeaJp9bRWJOnvpJPoQtLq/7Fk0ACXEAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaSC8+B6JbLDZy6ZUirM/+1Bv3Plq/kJO5PkYGUHzI2zuWsvgM
	5oFfVMhra7c/eq+136ie5XQMf1BJJuz6S3rov8C02nv6+RWJatjDBKGIeZ64IhxT7eRdP8wBylN
	lU7DnRfvj8IBM+F4Ni5AAvA5ra14gfnk=
X-Google-Smtp-Source: AGHT+IFDZ5eA6abImL8NUdVIdAWg94LO7tkXS6dhB0NlJP7A/A+6UQiNKGL70FD+qlsxvd5j5mV4ooH8ccYuS5PMC/g=
X-Received: by 2002:a05:6871:6286:b0:315:b768:bd1d with SMTP id
 586e51a60fabf-3ffc0967ea5mr3701993fac.6.1767904095408; Thu, 08 Jan 2026
 12:28:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-omap-cpufreq-removal-v1-0-8fe42f130f48@kemnade.info> <7hcy3j6ete.fsf@baylibre.com>
In-Reply-To: <7hcy3j6ete.fsf@baylibre.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Jan 2026 21:28:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jePerpMJR8CbiMKOKmSV6f7BLc0ZO6wTQztLvw9Sj3PQ@mail.gmail.com>
X-Gm-Features: AQt7F2pzPNY50L89-SzxYk921ngz4w4SrcmdZ2faUD5N5yDRK2xJTjtpeDawf7E
Message-ID: <CAJZ5v0jePerpMJR8CbiMKOKmSV6f7BLc0ZO6wTQztLvw9Sj3PQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] cpufreq: omap: remove driver
To: Kevin Hilman <khilman@baylibre.com>, Andreas Kemnade <andreas@kemnade.info>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 9:16=E2=80=AFPM Kevin Hilman <khilman@baylibre.com> =
wrote:
>
> Andreas Kemnade <andreas@kemnade.info> writes:
>
> > The driver is not useable since 10 years, and the affected
> > platforms have alternative drivers, so remove it.
> >
> > To: Rafael J. Wysocki <rafael@kernel.org>
> > To: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> > Cc: Andreas Kemnade <andreas@kemnade.info>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Roger Quadros <rogerq@kernel.org>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap@vger.kernel.org
> >
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
>
> Viresh, this is/was technically maintained by me, but feel free to take
> this via your tree, or let me know if you want me to queue it up.

No need to bother Viresh with this, I've just applied it as 6.20 material.

Thanks!

