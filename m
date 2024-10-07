Return-Path: <linux-pm+bounces-15292-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDC59935CB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 20:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF6C1C23845
	for <lists+linux-pm@lfdr.de>; Mon,  7 Oct 2024 18:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5608E1DDC32;
	Mon,  7 Oct 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n96XyOHJ"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3000B1DDC2E;
	Mon,  7 Oct 2024 18:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324818; cv=none; b=opx8d8hsm4EO/nFpgeNyNdrH4sxEZ1C4aC7YQO6/BZUWjbkfvbEl6dDvcfpWIlqmdN6QySYlSbNwqJFaAuiWTg8QdR2keFIKzuZdMMqSTLZKtaUj90vQLGxFoz34IQHDdEIDZjewrWZrdlT3AgqBjMEUDSaCmsRqVXoyI+sxIfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324818; c=relaxed/simple;
	bh=RoaOZw2RvsJv6LzJHadLOhp0ZgYcPu0LNgK2+e+ZaQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qn1N/Zkfh5VOEfgtoubrax7bELr0BKjPlS79KF0rPm5iBVy9BSXiIP74pf/xxiHQt3QpY/vH57muSY4K4cANK6750QIFU4dMrP88zBosYlVdfnaaiilk7wobj4kVAQIpsWqnGM56r4stqt8zTeNO3pyV1m2vsSPojNhnn9XSuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n96XyOHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A11C4CEC7;
	Mon,  7 Oct 2024 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728324817;
	bh=RoaOZw2RvsJv6LzJHadLOhp0ZgYcPu0LNgK2+e+ZaQk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n96XyOHJeB1m4hmIJFOR3XflgQMmsfAtsJf0xNna6Bmg6k2VXIO7nzu6U7Imrq/DI
	 e/Ht6PgyuvoAi+yWcCB2WfuYGwdTLE5Q8jsoa/d8fa4TJoBnvs28vEJxsLcpXUls08
	 O+q5cA8q1FuBMldVT8eDV2t7ccoRnehPde7rzvEpeU7UqniOueVWy6O9SajnKOqPks
	 AQUSAqXlyLZ6PWSvP40LE1youI+cOdgxa1K8z7WCsXqIba8FkawJM94L0QdLbk5wz6
	 b3V07salmIFLj5m97jViPZAocXF2DdwYqs9FJZVXB7YJXNKcu9moqG9m16NKfo3wb3
	 em5ffv5pDtFAg==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3e16d974030so2377521b6e.1;
        Mon, 07 Oct 2024 11:13:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZ03v2Rp2puxi7CnoT2KDdJj7izOcOJ28TjDnCOYc7/do1/Qygi1aLdpzv4NQzsVM7yFHvO6xc476epys=@vger.kernel.org, AJvYcCXUoKuyoYnvx1m7V886NFjk0KFMIrq7Kht2Xld+6mjUAvZXqeiFO7WHrX/SMQ8X/btFCknIVK+PkWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1+OC82xe/I9gkIb2jldbxd9Yko8C9DzCByFMfOdZEut37vS90
	Gx1cXfqbPmII3AYdJT6EmhklBB7W+USU9yTPau1og4zMH06rcHnbcswjZKahLAXsxmFJuf1IXf8
	9YP1bJEu3/x6Vvliw7ojs96hvl+s=
X-Google-Smtp-Source: AGHT+IErHU+4mJjbwcz3Nmo+Ou41JoAM0YCNgm7oWGlrYjQvR+bKaEafs7TV9S9QE6QWJ5Pzx1BAV6jTvkRJMFS4Uyo=
X-Received: by 2002:a05:6808:14d4:b0:3e3:9fb0:23a with SMTP id
 5614622812f47-3e3db5d7a34mr331930b6e.16.1728324817059; Mon, 07 Oct 2024
 11:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930081801.28502-1-rui.zhang@intel.com>
In-Reply-To: <20240930081801.28502-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 7 Oct 2024 20:13:25 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jN+MBN2gFhUxhQ-NXYtR=ShDxNJSxECSQ9Bu=t-bytpQ@mail.gmail.com>
Message-ID: <CAJZ5v0jN+MBN2gFhUxhQ-NXYtR=ShDxNJSxECSQ9Bu=t-bytpQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] thermal/rapl: fixes, improvements and cleanups
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:19=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wr=
ote:
>
> The patches in this series are independent of each other. Keep them in
> one series just for easy review and tracking.
>
> Patch 1/6 fixes a bug introduced recently. In my test, reading the
> domain info at a bogus address returns all 'f'. So the psys domain is
> always probed both before and after the broke commit and there should be
> no visible impact.
>
> Patch 2/6 fixes a WARNING since 6.11-rc1. But the underlying problem is
> there since the proc thermal driver was introduced. Lastest code still
> handles it but with an extra WARNING. So I'm not sure if this should be
> considered as -stable material or not.
>
> Patch 3 - 6 are general improvements and cleanups.
>
> thanks,
> rui
>
> Sumeet Pawnikar (1):
>   powercap: intel_rapl_msr: Add PL4 support for Arrowlake-U
>
> Zhang Rui (5):
>   powercap: intel_rapl_tpmi: Fix bogus register reading
>   thermal: proc_thermal: Fix WARNING during module unload
>   powercap: intel_rapl_tpmi: Ignore minor version change
>   thermal: proc_thermal: Remove MMIO RAPL cpu hotplug support
>   thermal: proc_thermal: Add MMIO RAPL PL4 support
>
>  drivers/powercap/intel_rapl_msr.c             |  1 +
>  drivers/powercap/intel_rapl_tpmi.c            | 19 +++--
>  .../processor_thermal_device_pci.c            |  2 -
>  .../int340x_thermal/processor_thermal_rapl.c  | 70 +++++++------------
>  4 files changed, 40 insertions(+), 52 deletions(-)
>
> --

All applied as 6.12-rc material, thanks!

