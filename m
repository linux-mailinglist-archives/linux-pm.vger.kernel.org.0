Return-Path: <linux-pm+bounces-32523-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49074B29E3F
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03C437AAEC5
	for <lists+linux-pm@lfdr.de>; Mon, 18 Aug 2025 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8418430F52F;
	Mon, 18 Aug 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="TlcEiIHo"
X-Original-To: linux-pm@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879830EF97;
	Mon, 18 Aug 2025 09:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510222; cv=none; b=GrpDYuoGi18JGlVXnGLzhkbVJ1bCK0Mm9nlSMekQ8W/n6S/t7FVqDXGO6/nZm7BkKYhMKlc3eaM/egYOy1pfer+oIPqAg1NpMGWKlZlG4E6BWigsNwUJ5r0GaT2JoNKNEyJkQfvjLnE/lAi/Z7z3WNd0MGFeXPKFaFTscUMMsnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510222; c=relaxed/simple;
	bh=kvFLkZd49qaINmgLXux3yvrYr/hxKrrvscnAQB/WUng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJ0y2DnAvHST/KsCOs8+YAF7qbrOVSqzUsMhuNlzEKriteDup2UOT9Lmnzicjt9zwitlO/23mBc+fJpLigFVtREMr+Mt9oySO45D1jjPYhkfZ+omP6rbvj+Nms/nSIuG81TTfOZucaDgCrDwzM5eSa+AY4Ttq4oMzsQsNUJCCX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=TlcEiIHo; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 3007720E37;
	Mon, 18 Aug 2025 11:43:31 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H-l89fRMrwVf; Mon, 18 Aug 2025 11:43:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755510210; bh=kvFLkZd49qaINmgLXux3yvrYr/hxKrrvscnAQB/WUng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TlcEiIHoMtlAl2saN8yxYLjXkbcsm6JBdVLGzc+jl2AS1b+an/MmtxcFAE/xU7iYd
	 8jwo4ADl77uY9jj2HxO+oa0lFgL8EDGDKAAj4hgOyN6KhUOqCnBq8VTERoMolFJURT
	 gQ5yClMwtpJ5p/GxejAUoS7yvD4hTDxp2R85+2D8Sw2UULzeltB6AYUT/1dz7fa7yX
	 TUINM9Ab/8mb22RQXEAZvtrw85FZtARc8updoorB/uviX7ICX8dKUir2+2syzhlJm1
	 /ZmnuCr7SpAyQVnEId4dDWa7FodzRHV4dCxwbcnXp081DxwbUzUMlQrQRKK8olBMAE
	 HuSNR/2QyTMWg==
Date: Mon, 18 Aug 2025 09:43:13 +0000
From: Yao Zi <ziyao@disroot.org>
To: Icenowy Zheng <uwu@icenowy.me>, Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,
	Michal Wilczynski <m.wilczynski@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sebastian Reichel <sre@kernel.org>
Cc: Han Gao <rabenda.cn@gmail.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] driver: reset: th1520-aon: add driver for
 poweroff/reboot via AON FW
Message-ID: <aKL1sTutiMZPAd70@pie>
References: <20250818074906.2907277-1-uwu@icenowy.me>
 <20250818074906.2907277-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818074906.2907277-2-uwu@icenowy.me>

On Mon, Aug 18, 2025 at 03:49:05PM +0800, Icenowy Zheng wrote:
> This driver implements poweroff/reboot support for T-Head TH1520 SoCs
> running the AON firmware by sending a message to the AON firmware's WDG
> part.
> 
> This is a auxiliary device driver, and expects the AON channel to be
> passed via the platform_data of the auxiliary device.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  MAINTAINERS                             |  1 +
>  drivers/power/reset/Kconfig             |  7 ++
>  drivers/power/reset/Makefile            |  1 +
>  drivers/power/reset/th1520-aon-reboot.c | 98 +++++++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 drivers/power/reset/th1520-aon-reboot.c

...

> diff --git a/drivers/power/reset/th1520-aon-reboot.c b/drivers/power/reset/th1520-aon-reboot.c
> new file mode 100644
> index 0000000000000..8256c1703ebe8
> --- /dev/null
> +++ b/drivers/power/reset/th1520-aon-reboot.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * T-HEAD TH1520 AON Firmware Reboot Driver
> + *
> + * Copyright (c) 2025 Icenowy Zheng <uwu@icenowy.me>
> + */
> +
> +#include <linux/auxiliary_bus.h>
> +#include <linux/firmware/thead/thead,th1520-aon.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/of.h>
> +#include <linux/reboot.h>
> +#include <linux/slab.h>
> +
> +#define TH1520_AON_REBOOT_PRIORITY 200
> +
> +struct th1520_aon_msg_empty_body {
> +	struct th1520_aon_rpc_msg_hdr hdr;
> +	u16 reserved[12];
> +} __packed __aligned(1);
> +
> +static int th1520_aon_pwroff_handler(struct sys_off_data *data)
> +{
> +	struct th1520_aon_chan *aon_chan = data->cb_data;
> +	struct th1520_aon_msg_empty_body msg = {};
> +
> +	msg.hdr.svc = TH1520_AON_RPC_SVC_WDG;
> +	msg.hdr.func = TH1520_AON_WDG_FUNC_POWER_OFF;
> +	msg.hdr.size = TH1520_AON_RPC_MSG_NUM;
> +
> +	th1520_aon_call_rpc(aon_chan, &msg);

It's possible for th1520_aon_call_rpc() to fail. Should we check for its
return value and emit a warning/error if it fails? Though in case of
failure there may not be much we could do...

> +	return NOTIFY_DONE;
> +}

Best regards,
Yao Zi

