Return-Path: <linux-pm+bounces-28026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C534ACC8F4
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 16:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8D11883FAF
	for <lists+linux-pm@lfdr.de>; Tue,  3 Jun 2025 14:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3C322F765;
	Tue,  3 Jun 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/olB6ci"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5874E555;
	Tue,  3 Jun 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960428; cv=none; b=Xrayw9GgNM8Bmid3UKuW56s4rtzE8zn0Iy+fFNvO7ZvHjPRlMRhxzKn3DWxhbyTNJ+oihyXPRZdQljw6VGO1PvOzP8KTmK7yuYdntS3svLlKKVQZL81+gZg4RNZZ+98H5KrbxB4G4wHZRaXFs3hVrS7ASc2grmG3QTOuq5wHJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960428; c=relaxed/simple;
	bh=pny6+7B47hdK844DaMKOETSSgS6JzHSx0lLeISbzsv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPaPToK0nbT7qA+KbDZIlRP0p1/OXJYsjPimkbwmwC6MvpF0aAha6UXRhjuzeyyJhqyNJZah/4K6n35OsGncDV+UHe0yHLd8zMDXSpiSSqsC4Ii88YVN0Vvg5VXobBV8AVBpB8c7UlV9s6LF2eiufZ4b67elXnrNqiw3dWFotIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/olB6ci; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4e45ebe7ac1so1456982137.2;
        Tue, 03 Jun 2025 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748960426; x=1749565226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx/bk9ru7EKbU1ykEfllBQeyaqERs6GMpKJf8LWkPkY=;
        b=O/olB6ciomqrh/H5BEYcnXcGwVK9EfyBY86YQ7MRO9dqAGz0PGZDO0ynx0IBV2S2eH
         JK7pbSs7K8U7OvRUK6Aovc0/LDzZFDvACUGBwqZYmVGlP8GVvgtanWG0e6t6vIQD7Bzx
         upMEXarce0fGZUSlYcRgK9AM106x6L1ioG4L82Cme/+mlYCfAGFCpDNtU1R9MHLwUVQN
         lWuMPz+oE2G/44xgQeLX1ZhSNKXNWDS8gYza2T/MF0XvskBIHco1mcJpl9QGl4CWzN25
         hAJ6xvCullKCQTYQ/hdnzJjF/OEwVfeauSsYEOb5viD/u3EAyXHhrgBnj/LGT+mKp/Z4
         1GXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960426; x=1749565226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dx/bk9ru7EKbU1ykEfllBQeyaqERs6GMpKJf8LWkPkY=;
        b=TC3JNfz2TN5/usknCnpLePhBaEFqf0kpyhS3N6/3/BevMAvaZ/gstsPi+u7Ehc5NZ2
         vC2pr3EgEAehC17EK4ifYvFqRUu5zHh3IBqattBs8PST73aHgUlhk6gKbI2qLnugRUlK
         Nqel5QaIU4yCAPO8zEs4ckdzYv4Vt6dcKkXKcn86kNHFLqkmhThcP08zXNx1n3mXmTSB
         9ly0TjQDxmhleCxhooJVM6GPFlkseUBn6Kdrhgo1FqyRox53UQHjnDr2JtfxAn3QWccb
         Y2eyBBTzsBcUJg7VeFOFMZYgXQjf+MTBTU4gi4ZcNeoVJphrNVkVA3xTcpkwTiQ8TELg
         FWhg==
X-Forwarded-Encrypted: i=1; AJvYcCWNM0heeArTfs7GPvZ6+aB3swsMJiruYwn3WE/9ECpFIl1K/7l+gbHlG04aOJPN1W7ykaMDyhoGmH8=@vger.kernel.org, AJvYcCX2Tz1DwoodD1YTM5sKC3Hsr/qGvD9GVtgtDyHmHfZ/9WUfY0IlJEffvUpHKbXOYfExziDmTu96qTb3noY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH2hsgV8pWGz1MXy7YIILy/NRZsBxZjjF1X785oBTl8xEtrGBv
	Ugn7E8xv4+p72z1DiVukKCldQd181R7dp3qdHeuIrJhnhfJbb3t8bHK2
X-Gm-Gg: ASbGnctaG5jR/dEw/PhqiPJR0+hsqCvhN3Lah/lqtXbaw4s1iqbRzMsZHKgxJrReBZn
	edrDQg4pT7SdcZq4BYWkqOkfxDj0980eRe/7RgGEcDfaNjB+tnmy3PQYu4NMAQVtjaFJR8xAYhC
	aiZi/ds2HxmgDC1S3hZjNTpBIWlMJGB9GLxBSf02vXmP8VDuEQPc4gTakY4LArYBd5i5Rn4XJOp
	ss19alYMqJdUNMyEsPbn/+fGSCuWv1J4j8HX4vF7WK++LQAUtpmcXrsyZM1SKkmzC5+dHZUB0Eq
	odTBnrddkHgc4sdn0PspZPhTKS+82tEUZ+DmSn6GYpYf8D2QVw==
X-Google-Smtp-Source: AGHT+IEKKHGgS071esTvwavLg6yebr4hxGtYaniLmSj088LELmB0xeGF4iugMnsLA9Zd/YeN/VvuJw==
X-Received: by 2002:a05:6102:291f:b0:4e6:d911:dd89 with SMTP id ada2fe7eead31-4e6ece53479mr12894234137.21.1748960425449;
        Tue, 03 Jun 2025 07:20:25 -0700 (PDT)
Received: from hiago-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4e64e9f28a2sm8676818137.26.2025.06.03.07.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 07:20:24 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:20:18 -0300
From: Hiago De Franco <hiagofranco@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>,
	linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Johan Hovold <johan@kernel.org>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Michal Simek <michal.simek@amd.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/21] pmdomain: Add generic ->sync_state() support to
 genpd
Message-ID: <20250603142018.zrb66ldkal5d5op7@hiago-nb>
References: <20250523134025.75130-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523134025.75130-1-ulf.hansson@linaro.org>

Hi Ulf,

On Fri, May 23, 2025 at 03:39:57PM +0200, Ulf Hansson wrote:
> Changes in v2:
> 	- Well, quite a lot as I discovered various problems when doing
> 	additional testing of corner-case. I suggest re-review from scratch,
> 	even if I decided to keep some reviewed-by tags.
> 	- Added patches to allow some drivers that needs to align or opt-out
> 	from the new common behaviour in genpd.
> 
> If a PM domain (genpd) is powered-on during boot, there is probably a good
> reason for it. Therefore it's known to be a bad idea to allow such genpd to be
> powered-off before all of its consumer devices have been probed. This series
> intends to fix this problem.
> 
> We have been discussing these issues at LKML and at various Linux-conferences
> in the past. I have therefore tried to include the people I can recall being
> involved, but I may have forgotten some (my apologies), feel free to loop them
> in.
> 
> I have tested this with QEMU with a bunch of local test-drivers and DT nodes.
> Let me know if you want me to share this code too.
> 
> Please help review and test!
> Finally, a big thanks to Saravana for all the support!
> 
> Kind regards
> Ulf Hansson
> 
> 
> Saravana Kannan (1):
>   driver core: Add dev_set_drv_sync_state()
> 
> Ulf Hansson (20):
>   pmdomain: core: Use of_fwnode_handle()
>   pmdomain: core: Add a bus and a driver for genpd providers
>   pmdomain: core: Add the genpd->dev to the genpd provider bus
>   pmdomain: core: Export a common ->sync_state() helper for genpd
>     providers
>   pmdomain: core: Prepare to add the common ->sync_state() support
>   soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
>   cpuidle: psci: Opt-out from genpd's common ->sync_state() support
>   cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
>   pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
>   pmdomain: qcom: rpmhpd: Use of_genpd_sync_state()
>   firmware/pmdomain: xilinx: Move ->sync_state() support to firmware
>     driver
>   firmware: xilinx: Don't share zynqmp_pm_init_finalize()
>   firmware: xilinx: Use of_genpd_sync_state()
>   driver core: Export get_dev_from_fwnode()
>   pmdomain: core: Add common ->sync_state() support for genpd providers
>   pmdomain: core: Default to use of_genpd_sync_state() for genpd
>     providers
>   pmdomain: core: Leave powered-on genpds on until late_initcall_sync
>   pmdomain: core: Leave powered-on genpds on until sync_state
>   cpuidle: psci: Drop redundant sync_state support
>   cpuidle: riscv-sbi: Drop redundant sync_state support
> 
>  drivers/base/core.c                         |   8 +-
>  drivers/cpuidle/cpuidle-psci-domain.c       |  14 --
>  drivers/cpuidle/cpuidle-riscv-sbi.c         |  14 --
>  drivers/firmware/xilinx/zynqmp.c            |  18 +-
>  drivers/pmdomain/core.c                     | 239 ++++++++++++++++++--
>  drivers/pmdomain/qcom/rpmhpd.c              |   2 +
>  drivers/pmdomain/qcom/rpmpd.c               |   2 +
>  drivers/pmdomain/xilinx/zynqmp-pm-domains.c |  16 --
>  drivers/soc/tegra/pmc.c                     |  26 ++-
>  include/linux/device.h                      |  13 ++
>  include/linux/firmware/xlnx-zynqmp.h        |   6 -
>  include/linux/pm_domain.h                   |  17 ++
>  12 files changed, 294 insertions(+), 81 deletions(-)
> 
> -- 
> 2.43.0
>

Tested-by: Hiago De Franco <hiago.franco@toradex.com> # Colibri iMX8X

Best Regards,
Hiago.

