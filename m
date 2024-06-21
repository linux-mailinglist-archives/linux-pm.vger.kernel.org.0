Return-Path: <linux-pm+bounces-9759-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C655912690
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 15:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37983283118
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2024 13:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951822E622;
	Fri, 21 Jun 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kO2j3f4t"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC0D1EA80;
	Fri, 21 Jun 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718976135; cv=none; b=m4S51H9mtpPZMCJc8tZ6W8eD2X3IwCNi3RSoJh/Z4D7fUseRX1dY845d2UUtvd6oGHUIFYb/sfP4ltrd+YKBtvZnwUJ5bof9pcqpOGUBJY8q63Hpv/ekIFswXEggCNALLOagXazpPEoLoCle67ed6tCn3CPIy24BUzSCt3OR+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718976135; c=relaxed/simple;
	bh=u9B2uf3jeT1CuXhSvou1m579jgJPFZC40IH69es/5no=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ysu4Y3IWK8xUUXOQchyJ2UDXdsxG/i9drEoaad6EHyOdOGfvu2hKcvhhIRFwlTUOn83U/PBR/LJnBKlA2SVST2DXf8qQ8JtRnqJqmbNZEB1dpehgEmNjRiJiq1dhhaeivY4AicBScJgUlcKa1Biff15utZ9ji1eqqrTKs8brb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kO2j3f4t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425A8C4AF0A;
	Fri, 21 Jun 2024 13:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718976135;
	bh=u9B2uf3jeT1CuXhSvou1m579jgJPFZC40IH69es/5no=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kO2j3f4tGrQ/5LpRI4qpi9UFsmSDhY+Zmx7TCsjhG5q+neGhBT4mAlqpOFdA3ZhrD
	 zHujrDF4bCej8cP5/UTgIUBAM+8uCEVP52OK28oNHznh6fxHnD3pluzdnJ31M21qV5
	 hbeYWejqHMvNByEcQ1KvSQRO9Gcgw77KcpY+s1yO+jHDAvFO7+5eIa3UIG5m6QS/8X
	 LEuQ17hKN/OYc+XZKIjTA8V6hatg8vO16Bd6HS/xv8Sn3LyL/PmMe6Ihjpt5kBQzrK
	 da6Iq+UrH4f52RY0yWfAOoYp4DDlIG+C2Yxd/5IynheCK9YyjWf5fsXzlmmQusc7nD
	 OzMjfpLO7CaFQ==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d21cb38362so66133b6e.2;
        Fri, 21 Jun 2024 06:22:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWie8MheQUQhkjOxjCiMl+AY5T++1uQ84rVSla8pEYU1a8rjN7bsefQ233rfvWN//q/DPNcE6kuuXWOfKy352Oy9/Q/lh8zMBojOPn7yrMCTMBlesjZQ6lxsK34ESTKk2iPuLzDOZ8=
X-Gm-Message-State: AOJu0YzvsTPCOGOclhW9ncnEz1Lgcl0bX47QnklVJY+2VoJzmlRwI8yz
	+8Uf4vHtfT3eWFcEzYRM4hrcLX9/jmSTSh8pTwF42uQf/zwkzhGVqfbybCBK1ylOxswe9/J9Rte
	QCspo6NZ50Z811hUANGKtOkoNh1Y=
X-Google-Smtp-Source: AGHT+IEIxnLam4yKqd8jVlYHKjtDUyMLO33KJZNTKHK4Ocfj9bJ8Hk/nU9xkJb9V78sbp1jsohxOILYE9kHq1aEloJo=
X-Received: by 2002:a05:6808:1b23:b0:3d2:2755:32f0 with SMTP id
 5614622812f47-3d51bae6170mr8594597b6e.3.1718976134515; Fri, 21 Jun 2024
 06:22:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20240619124600.491168-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 21 Jun 2024 15:22:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcR29aucA5g3R2fasrCmJcSBJYC2owStJhg=d0EeBdbQ@mail.gmail.com>
Message-ID: <CAJZ5v0hcR29aucA5g3R2fasrCmJcSBJYC2owStJhg=d0EeBdbQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Lunar Lake DLVR support
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 2:46=E2=80=AFPM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Support DLVR controls for Lunar Lake. The first two patches are preparato=
ry
> changes to add DLVR support by the third patch.
>
> Srinivas Pandruvada (3):
>   thermal: intel: int340x: Cleanup of DLVR sysfs on driver remove
>   thermal: intel: int340x: Capability to map user space to firmware
>     values
>   thermal: intel: int340x: Add DLVR support for Lunar Lake
>
>  .../processor_thermal_device.c                |   3 +-
>  .../processor_thermal_device_pci.c            |   3 +-
>  .../int340x_thermal/processor_thermal_rfim.c  | 113 +++++++++++++++++-
>  3 files changed, 111 insertions(+), 8 deletions(-)
>
> --

All applied as 6.11 material, thanks!

