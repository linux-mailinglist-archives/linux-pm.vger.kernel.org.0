Return-Path: <linux-pm+bounces-26840-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 582DDAAEC7C
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 21:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B2A3BF37C
	for <lists+linux-pm@lfdr.de>; Wed,  7 May 2025 19:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB61B28E59F;
	Wed,  7 May 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbsekDng"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246C1DD877;
	Wed,  7 May 2025 19:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647564; cv=none; b=PatxLJR44zLx+PUcL/TkAwwLVsi6CIZsennLYR+u9LmZL8K3SwcsVzzqCa8k7ObKMBAGpCLExn/4TVgXdYEMsq2iruv2LzBRq+ciJf4cUo9OSfNTX7vFCfF/o/WQAMgQiYqnwUKhxD40HQcuJW5HOfj+4f4J3JBgEwd4iwGXhhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647564; c=relaxed/simple;
	bh=IP1sexJ5AqEl1JL/vrHOkdQGcrLkSGT1/bXaGfYanxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuSHMkUTp6SON3Ky/elsyf/h7Y7XAI98YxlzX1FyUNbIg2AtDtY4LxsBLaWgLgPjID/znWYobki3nUTeICJZnxF41qMSBrMfudrmTiZbq4lfFix8Q7M9zuvkZEE/rZzQHWNyp4aoADkxKti3iLXCRPa4Ps2rJ6G3txH5Sx5sYSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbsekDng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20C0C4CEEB;
	Wed,  7 May 2025 19:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746647564;
	bh=IP1sexJ5AqEl1JL/vrHOkdQGcrLkSGT1/bXaGfYanxs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nbsekDngZRKrUVqYx7v1yG/5qImmvHmnFeURvi1FkbK9TDIStReWx0m0HfLJWwIe/
	 tsWcui3FxqwnL+bdPJ8znI57YVJOLEwSG0ILdzdO780+QZVg1E8CIXc6Tw5Ndow9tg
	 cFuIyMFOD57kBCnFOmHT7XOaf80fCtY9jIx727zsRZlBU4v4HTB/3NHV3PNSOxAe5t
	 aK2YMB1lh3duaavoCgEmastZgtW3eoINTHr5CTKcA7smb2HWjn2vnQNDLCVg9u16To
	 nmeb3bmMljh076MQ0mJL94VT6oHb/893s18B9p+tVqk9Ouvpp9QoBYzDnitkVUCSlP
	 JRNgVJlVdip/g==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2d4f8c42f49so800912fac.1;
        Wed, 07 May 2025 12:52:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8s6vn0rDfen7Mw/XtpKXLTo4Siy7O4XIi9LZJfFEUlZAJvgJCQO1k7/u/p30plmsjNeOV2AjjDQs=@vger.kernel.org, AJvYcCXZ3gxT2PxjIHwA3AGBrZVRv2yWU6actbRO1mN2KArzYlXj0ex8qtrCEgtuksThqQmRzclluBCS9OQrTmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+jZIvWzHtAPHfsa21OGyx1twt+fmNg4UglUpiaXIxWR93rqT
	eWyS1Wuauuwb2ZbLe/Sntlwjs2oAUthbuygt1hrb894+FjJh+yMg7ooaDgVlBQzaYD0gKKZP8wO
	OqUm60Jcpju0QXIV91bwA22ayngM=
X-Google-Smtp-Source: AGHT+IHAYFUsgf5CY68kR+wueNn0ih5PFLRIbTC32kvnqqwU1UTFoomTK2fnfGTP/3v2ZFw4jvaqe8FMVK4n6M0D1JY=
X-Received: by 2002:a05:6871:a694:b0:2d5:307f:cc5f with SMTP id
 586e51a60fabf-2db808814ecmr532228fac.12.1746647563187; Wed, 07 May 2025
 12:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20250429000110.236243-1-srinivas.pandruvada@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 21:52:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ia28dh6xjkef3ADkz6SN6VMp8Lj4Z=Bq665p7xoi_82w@mail.gmail.com>
X-Gm-Features: ATxdqUHpvcMsLo4GDdvPV8Jl8BoqXdx4_PsNfLSva9LUe0tC-bcCgJYhMZsjXbQ
Message-ID: <CAJZ5v0ia28dh6xjkef3ADkz6SN6VMp8Lj4Z=Bq665p7xoi_82w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Platform Temperature Control interface
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: rui.zhang@intel.com, daniel.lezcano@linaro.org, rafael@kernel.org, 
	lukasz.luba@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 2:01=E2=80=AFAM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Platform Temperature Control is a dynamic control loop implemented in
> hardware to manage the skin or any board temperature of a device. The
> reported skin or board temperature is controlled by comparing to a
> configured target temperature and adjusting the SoC (System on Chip)
> performance accordingly.
>
> This series supports optional controls from the user space.
>
> v2:
> Change sysfs folder name and other cleanups
>
> Srinivas Pandruvada (3):
>   thermal: intel: int340x: Add platform temperature control interface
>   thermal: intel: int340x: Enable platform temperature control
>   thermal: int340x: processor_thermal: Platform temperature control
>     documentation
>
>  .../driver-api/thermal/intel_dptf.rst         |  21 ++
>  .../thermal/intel/int340x_thermal/Makefile    |   1 +
>  .../platform_temperature_control.c            | 243 ++++++++++++++++++
>  .../processor_thermal_device.c                |  15 +-
>  .../processor_thermal_device.h                |   3 +
>  .../processor_thermal_device_pci.c            |   5 +-
>  6 files changed, 285 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/thermal/intel/int340x_thermal/platform_temper=
ature_control.c
>
> --

All three patches applied as 6.16 material, thanks!

