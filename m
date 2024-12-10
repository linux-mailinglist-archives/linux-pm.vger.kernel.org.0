Return-Path: <linux-pm+bounces-18940-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59539EB9C2
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 20:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825C128356A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 19:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459C20469D;
	Tue, 10 Dec 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drBGaFYM"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A953A94D;
	Tue, 10 Dec 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733857387; cv=none; b=XJ8t7HtJc6B9iMh1jOZIwqQYpyAykYxrYgmcHtxdvPEEXyhA1eGUR/hBsMOUUb76Mq/J/ACeSwHULnmlvkitVz5e99zvU7JrlNnvlOZCF2kwGkIWpnXiTzpKw9wtsqFSyFGjAjl52W/1eJQbaQzjxWTtPcNzCdyBIo/1wujPkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733857387; c=relaxed/simple;
	bh=d6ROkkJrqNfgyixg9hx2zDBh0CYKajb8GtnqVhhCW4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CaSycBfbU6dVeUzF73nBerwGy2CSlbr+irzw++Mq0wWHzrzPDvOPK76DYnFfaPDZ9J9kYlYR8gULjIvnOy3SGOhcLzqXSVbj5IrU0vS0iKrVN4Hqeoh7eEiffk8dbzY19Ut2POxtowhjibT5DzlEFgX/Rn9RQ01H4npM6MMkvRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drBGaFYM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2BAC4CEDD;
	Tue, 10 Dec 2024 19:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733857385;
	bh=d6ROkkJrqNfgyixg9hx2zDBh0CYKajb8GtnqVhhCW4o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=drBGaFYM20iRv91K05nnf9KZY0a9wRZZP1650dl6f++TAUL7QOCsWH78St0cV8pjD
	 b5D9FU/SBXAeGentGyCokV3f1CTIIXsDQCpuIcDZTawTbvUeKEEX7PiAQfd+qPBE7+
	 oX9grfYYF3VLaGOKMwN9+Mo8W3u9bmxqQqHjB2V0x0s4OJeoOSyVcMzjCETccSr2Ny
	 HqrsKrowTmXxyuyF1L04MhywufTdTfkQ95P3PHfzY0mKEyASsAoDQRgWCgGsaGW1au
	 /i4SgCiHzePIufk8FLOTCN1aPE7bbvCA2BvewoT/a/9AXKFl641uo987aPYy9KfZTT
	 CBrSE5EOggPJA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f2ba68b40aso973701eaf.1;
        Tue, 10 Dec 2024 11:03:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUd4aHyJoWdfp2sAsuAvD1IONn5qvn5/zMlZvHPeIke3WYqC6EZFJ8mCUpdJZXApC4NXHHkkSJd1mcA//Y=@vger.kernel.org, AJvYcCX249J94/LsQ4y8+aPNwuEFg+Rhd+bZ4HMAao1lyh3ePZuLXHpyaVzeEmuLc6hvAVNvBLEdg5n2I/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTvA9UQJXnu56VIYkaEaz8V+NzZjFc5NEgTdfyk3QV4jLlkHH
	xBuLwHNh3CXKiyFi32fQktM2pqESjvgSKxhMZWej7LFDYaHVbsMBbRDLT4wfVgz1WSRehLRhHo/
	+U5U40c5WGLEGG3J1ulCXBZR3vZY=
X-Google-Smtp-Source: AGHT+IG7/ZJyrVp7WSUfRkKlrMa8ovsO4i/bL/jbEw1fNfRq7T80SzE9HpRlAaD6DuPTci5BdmAuTg26uNQjo6hh/6w=
X-Received: by 2002:a05:6820:2604:b0:5f2:9d29:2c4c with SMTP id
 006d021491bc7-5f2da147485mr41456eaf.6.1733857384917; Tue, 10 Dec 2024
 11:03:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203075802.584741-1-rui.zhang@intel.com>
In-Reply-To: <20241203075802.584741-1-rui.zhang@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 20:02:54 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hwAz_9avAMhyY6AfAg2ZdffrhnS5EUPi-pU7LyQfdKHA@mail.gmail.com>
Message-ID: <CAJZ5v0hwAz_9avAMhyY6AfAg2ZdffrhnS5EUPi-pU7LyQfdKHA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add RAPL/DPTF support for Pantherlake
To: Zhang Rui <rui.zhang@intel.com>
Cc: rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 8:58=E2=80=AFAM Zhang Rui <rui.zhang@intel.com> wrot=
e:
>
> There is an effort on going to avoid per CPU model ID enabling for RAPL
> support. But this takes some time and requires sufficient test to make
> sure no regression introduced. So enable PantherLake RAPL support before
> any rework.
>
> Zhang Rui (3):
>   powercap: intel_rapl: Add support for PantherLake platform
>   thermal: intel: int340x: processor: Enable MMIO RAPL for PantherLake
>   ACPI: DPTF: Support Panther Lake
>
>  drivers/acpi/dptf/dptf_pch_fivr.c                           | 1 +
>  drivers/acpi/dptf/dptf_power.c                              | 2 ++
>  drivers/acpi/dptf/int340x_thermal.c                         | 6 ++++++
>  drivers/acpi/fan.h                                          | 1 +
>  drivers/powercap/intel_rapl_common.c                        | 1 +
>  drivers/thermal/intel/int340x_thermal/int3400_thermal.c     | 1 +
>  drivers/thermal/intel/int340x_thermal/int3403_thermal.c     | 1 +
>  .../intel/int340x_thermal/processor_thermal_device.h        | 1 +
>  .../intel/int340x_thermal/processor_thermal_device_pci.c    | 1 +
>  9 files changed, 15 insertions(+)
>
> --

All applied as 6.14 material, thanks!

