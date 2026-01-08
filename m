Return-Path: <linux-pm+bounces-40482-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C34D045D6
	for <lists+linux-pm@lfdr.de>; Thu, 08 Jan 2026 17:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 14FD53060686
	for <lists+linux-pm@lfdr.de>; Thu,  8 Jan 2026 16:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4B61F9ECB;
	Thu,  8 Jan 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9JSI/b4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA29A1D9346
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888195; cv=none; b=DDiD6M4Jugh4HPPEJD10OFTdh7+RlwtYuzZuT99sq3njrmVvDQGjli5sb2H7gdpDYzbk+YL2ioFnA+t5uOuFIk8U17JrgG6P7ykcJBzGVjLGHlBrfKWUx5rjMfbUkYteQemXarOqGmmfrcgbqHRNChzPSTfg2YXJnffip6eRgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888195; c=relaxed/simple;
	bh=WOrDqkrbtqUutTWM0pWGFIS7f+HTw+Gh0txq1j68ahY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GWjFpNBH53EkEiuRv44LLTyDBCmX+1UpLbRWV0Uimqhy39R+ZDnq0qRo1cysIteMUqByJQynx+wZm63+Dvl5c1OpF1JXkyRg8/SEczXydB9Ek24oZ01Ze0Kytkqi9Dcja99UyeD47vSPLsSvQtS6emxIPu/Y0dGUB78+LE+r3Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9JSI/b4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE47C19422
	for <linux-pm@vger.kernel.org>; Thu,  8 Jan 2026 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767888195;
	bh=WOrDqkrbtqUutTWM0pWGFIS7f+HTw+Gh0txq1j68ahY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B9JSI/b4eogoWAxOearWoM3Jlzz+Jl5l/KLbNeYkwjw8ESQWykwgpEYmHh8KUKi+d
	 I9m446Gask8LYGO8MgxOSQErnoSqJb4dQvmIc70j2uN4Pg9hjh0Ro2ZU5xFb11XuZn
	 Om24OiUun1maM5qbaZHATJids5qnvA2SmED8MFV+W4Wh0FHA3kR+rnroLqY7DPh+86
	 3PDTb0otJiWXzwJ1nPL6v3vsumLNY/T8iNJAg8Mhihj7IvY9VozdrwmpM8cejl4HGM
	 rl3GjMQSrZx4XT1uG+gcs1VaNHR6apNmTncXIH9kXxrv25sOqj0ZwlGbXF+aizV4Ie
	 l+7uLPItsVAAg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so2343000fac.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Jan 2026 08:03:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBLzNXwpYgferFkcgKE9YwCDrkFE0r3Qph6ky/JrWyOCupr9FBMJ2cobq6gm9hu48lM/8r/EMuTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0iWIIxx+XXBoZLNSSxZmuwK8uPv/vm2GwvxdT9fSelypVy3Mn
	lQOWyZ9xk3PmH6720QsMkpf6qRv8mbDu5DP9SyTPPmOXo9fj46u5/JtNkgvK3OrpSNcUgvi6VW6
	nobWEa6cNsXMpplDuHkECSDv4uqRDeu0=
X-Google-Smtp-Source: AGHT+IFdzqiCe7RIHHaWEsERHuwzsSvp8CWqwQ2VNmrFgtTfDfr+3e5NybL5ySqbTnDZN9dadmogaBkX8BCDTs1RRpU=
X-Received: by 2002:a05:6871:d3ca:b0:3f5:4d73:1420 with SMTP id
 586e51a60fabf-3ffc09d4c69mr2986228fac.16.1767888194719; Thu, 08 Jan 2026
 08:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105-libthermal-pkgconfig-v2-1-e086bdeddb41@bootlin.com>
In-Reply-To: <20260105-libthermal-pkgconfig-v2-1-e086bdeddb41@bootlin.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 8 Jan 2026 17:03:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i_s2AQ5_Uze3SRrkMWvOOHa77wiE+iD_uaJ1HeYHWNrA@mail.gmail.com>
X-Gm-Features: AQt7F2qiVxYbUC26y87250FAsT-c4QHdYgQwtch72NoISkebnY1meKe5msFegws
Message-ID: <CAJZ5v0i_s2AQ5_Uze3SRrkMWvOOHa77wiE+iD_uaJ1HeYHWNrA@mail.gmail.com>
Subject: Re: [PATCH v2] tools: lib: thermal: Correct CFLAGS and LDFLAGS in
 pkg-config template
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 1:31=E2=80=AFPM Romain Gantois
<romain.gantois@bootlin.com> wrote:
>
> There are two issues with the current pkg-config template.
>
> Firstly, the -lthermal linker flag is missing.
>
> Secondly, the libnl3 include directory compiler flag references "include"
> instead of "includedir", which leads to an unexpanded variable when
> pkg-config is called. Moreover, it isn't necessary to add this flag here,
> since the "Requires" field will cause pkg-config do add it automatically.
> The same logic applies to the LDFLAGS for libnl3.
>
> Add the missing -lthermal flag and remove unnecessary and incorrect libnl=
3
> flags.
>
> Fixes: 47c4b0de080a ("tools/lib/thermal: Add a thermal library")
> Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
> ---
> Changes in v2:
> - Removed unnecessary libnl3 flags.
> - Added "Fixes" tag.
> - Link to v1: https://lore.kernel.org/r/20251226-libthermal-pkgconfig-v1-=
1-3406de5ca8ea@bootlin.com
> ---
>  tools/lib/thermal/libthermal.pc.template | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/thermal/libthermal.pc.template b/tools/lib/thermal=
/libthermal.pc.template
> index ac24d0ab17f5..b984c5ecd20a 100644
> --- a/tools/lib/thermal/libthermal.pc.template
> +++ b/tools/lib/thermal/libthermal.pc.template
> @@ -8,5 +8,5 @@ Name: libthermal
>  Description: thermal library
>  Requires: libnl-3.0 libnl-genl-3.0
>  Version: @VERSION@
> -Libs: -L${libdir} -lnl-genl-3 -lnl-3
> -Cflags: -I${includedir} -I${include}/libnl3
> +Libs: -L${libdir} -lthermal
> +Cflags: -I${includedir}
>
> ---

Applied as 6.20 material, thanks!

