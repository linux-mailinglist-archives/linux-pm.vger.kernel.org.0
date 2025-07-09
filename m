Return-Path: <linux-pm+bounces-30472-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2FAFE7D2
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9FE17725D
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1D62D9ED7;
	Wed,  9 Jul 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ5Tk9/i"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC812D97B8
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060695; cv=none; b=U8C0cax1KBzc5Uz6WMskPh8XxiGuA2uDnwHYr6umPt3dr2MmiYOXPRlSc/DoDNSVMOUR7e5SSJXhs+0lZ0rmJ0ioI/c06TRbdniYqAWzuL6zTko0GA2asw6WOZPcZYgUg3RLipvmDbszlG6939mAcjYsxLoydvl7PRr8Losi0sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060695; c=relaxed/simple;
	bh=eaFq9gWWTxEjM3UTumvG5t2cF6D7OUJx6+dlbUGCjxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLKUpM0vXa2yG5wSqC280aKNQNnwtalta3ihFXuhCwToriHeYpfTm4x4w63Tz42p2p7QgWXUmmzqru2duy262FJ9jAqdYUE2omz8xzw8uCPA2RLsDfEXmeIh88PeH64aOeQTXh63xEkT5X/d0uoJNSAjmRdq/tBzL2THqr84qPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQ5Tk9/i; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-714067ecea3so39152527b3.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752060693; x=1752665493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNiQ1+5y2VFFZCNEkl5wzPIEOOAGrk6ZMXzGD1167g8=;
        b=IQ5Tk9/i+fJhBdfeD0E2ZeHduy403dhKzse9YTsCatOUAgVmbblFr2ouV4+ZBArH2U
         u1fn6FzWe5RkWgyNUW0IeHvSoDT5XocZDdT8PJ9exAF+vOydSJfcwtR5Go2XR8oCXy++
         Nuc3fEWW6/0g9xGLR6bHxpuq90lhVL9JM/Q6IPHUW/8kGm1+84tvv6ALmkEWY5G19tyZ
         aBfHeqtElyZvW5UBSmaJlufi5qPhT1IcYXvJZteQzn3iidfx8lMd5poS5Oz6Eqdz6YRh
         JvpskF9JQFFd1kViv/KPI0IAN4YEMcBDUhKk5VnjEHCVGJ/KT+9o9xFc0Toi7KZ/egs9
         kfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060693; x=1752665493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNiQ1+5y2VFFZCNEkl5wzPIEOOAGrk6ZMXzGD1167g8=;
        b=EN+8UsxreZvnXAfj1V9VC5R47fV1BYRlRxuo0mIYX56jJ2KQH2iR7n09sELjQtfW/M
         cLDGX1+55CthsRBsTWeqFdJ7JGG9CALSWO+yqOhD0LB9z9hKYOFZMSykCCFXmyVLW3Vn
         qk1LRyKOzyGvg6E6yuinnKVXJdBgTvU/HnNRY2EaT/T3VzO5I5xFs4bF9grQ8E5fAwK4
         Eip/psSNo1PUyUE0XeHfnOwr/3BS1RXRu719+pqoHb8XEUTcw7qjwZH8XS3WvZIKPyfJ
         mP/M20cON5r+EIdSJWlBTE/LNoS4D3hgAPm0Jf5m2O+t9fMC3WnfNM3rQBTFp9C8nEP2
         b9aA==
X-Forwarded-Encrypted: i=1; AJvYcCW8n7/3mMvqnm20yAZWUCi+EtzjEF+m/Lt/e7Su10l5EvT5R4BxNZYOKqueBvNkIZ9ZaqTZL2QRAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyYbQDrUTluKfLV6P1WNRPgDGL1t+8EAEColJ07ha0vmt76u7bY
	xTpC2Ch6EcZydWRjZXDyyC7x+zVpnkPnEWqz/0UFLNDmkwQyBY5ld1mDfees95qBe0NYwtN5udT
	iCK1eB9OxwZfrgYROlxeLKX0+tytReE7jfVFx3aiNwA==
X-Gm-Gg: ASbGncvRdMCTzKP4uymTuPkL9Z313UiyzXWynu8iTVJBtXtM6IUZdH7VbXfmKeCDfcb
	l9iWxPla/6KrZrAl81g3uVXjJYY4t7bNekgcUgDtt6LUWS4yLTr7+P2oRQuJYMQD3VQa8WSMEwB
	6yqNEbBSEa0d1ZCYP+YimF/q2eeWcpPEa+EnEWQ5qS8vaWPuwX4u7rzNI=
X-Google-Smtp-Source: AGHT+IFsS/ASN7bZj//LEOdFtJiqcKW9aOOwexSDyjzYRjOXer6dnb2P/mGTPna4qIWw/UGl9cHvGrgqRWogtZJ+2Ik=
X-Received: by 2002:a05:690c:6b0e:b0:70f:8884:17af with SMTP id
 00721157ae682-717b16723f0mr33351387b3.6.1752060693143; Wed, 09 Jul 2025
 04:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701114733.636510-1-ulf.hansson@linaro.org>
In-Reply-To: <20250701114733.636510-1-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Jul 2025 13:30:57 +0200
X-Gm-Features: Ac12FXwPPsq7QQFWnJjGj5aeIXDZuRVVIUPoQyxowJKYffEpQh6cBhizErrlUZ0
Message-ID: <CAPDyKFr=u0u2ijczExkntHK1miWZ6hRrEWBMiyUwShS3m6c29g@mail.gmail.com>
Subject: Re: [PATCH v3 00/24] pmdomain: Add generic ->sync_state() support to genpd
To: Saravana Kannan <saravanak@google.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@oss.nxp.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Johan Hovold <johan@kernel.org>, 
	Maulik Shah <maulik.shah@oss.qualcomm.com>, Michal Simek <michal.simek@amd.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Hiago De Franco <hiago.franco@toradex.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Jul 2025 at 13:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> Changes in v3:
>         - Added a couple of patches to adress problems on some Renesas
>         platforms. Thanks Geert and Tomi for helping out!
>         - Adressed a few comments from Saravanna and Konrad.
>         - Added some tested-by tags.

I decided it was time to give this a try, so I have queued this up for
v6.17 via the next branch at my pmdomain tree.

If you encounter any issues, please let me know so I can help to fix them.

Kind regards
Uffe


>
> Changes in v2:
>         - Well, quite a lot as I discovered various problems when doing
>         additional testing of corner-case. I suggest re-review from scratch,
>         even if I decided to keep some reviewed-by tags.
>         - Added patches to allow some drivers that needs to align or opt-out
>         from the new common behaviour in genpd.
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
> Ulf Hansson (23):
>   pmdomain: renesas: rcar-sysc: Add genpd OF provider at
>     postcore_initcall
>   pmdomain: renesas: rmobile-sysc: Move init to postcore_initcall
>   pmdomain: renesas: rcar-gen4-sysc: Move init to postcore_initcall
>   pmdomain: core: Prevent registering devices before the bus
>   pmdomain: core: Add a bus and a driver for genpd providers
>   pmdomain: core: Add the genpd->dev to the genpd provider bus
>   pmdomain: core: Export a common ->sync_state() helper for genpd
>     providers
>   pmdomain: core: Prepare to add the common ->sync_state() support
>   soc/tegra: pmc: Opt-out from genpd's common ->sync_state() support
>   cpuidle: psci: Opt-out from genpd's common ->sync_state() support
>   cpuidle: riscv-sbi: Opt-out from genpd's common ->sync_state() support
>   pmdomain: qcom: rpmpd: Use of_genpd_sync_state()
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
>  drivers/pmdomain/core.c                     | 211 ++++++++++++++++++--
>  drivers/pmdomain/qcom/rpmhpd.c              |   2 +
>  drivers/pmdomain/qcom/rpmpd.c               |   2 +
>  drivers/pmdomain/renesas/rcar-gen4-sysc.c   |   2 +-
>  drivers/pmdomain/renesas/rcar-sysc.c        |  19 +-
>  drivers/pmdomain/renesas/rmobile-sysc.c     |   3 +-
>  drivers/pmdomain/xilinx/zynqmp-pm-domains.c |  16 --
>  drivers/soc/tegra/pmc.c                     |  26 ++-
>  include/linux/device.h                      |  13 ++
>  include/linux/firmware/xlnx-zynqmp.h        |   6 -
>  include/linux/pm_domain.h                   |  17 ++
>  15 files changed, 291 insertions(+), 80 deletions(-)
>
> --
> 2.43.0
>

