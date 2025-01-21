Return-Path: <linux-pm+bounces-20744-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7EA1793B
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 09:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0389B1884D07
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jan 2025 08:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59991B415D;
	Tue, 21 Jan 2025 08:25:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0E1AFB36
	for <linux-pm@vger.kernel.org>; Tue, 21 Jan 2025 08:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737447940; cv=none; b=hkdwAO5FraC7lCmox39o5ODgCVqC3P9WjWknbQuRZT0+W0IpDtO9T01YsThJUR6pdYeYwLePn0D2XJ0QM36NDOuG0uw05+eMn6p8VME+EiaznC7F05g71+sdXvSkhMyYD0fh6CxIZPDU/sLIG7v6eR9Aza+AXFRu2bz0cUJtH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737447940; c=relaxed/simple;
	bh=XO7wqmEVw8nwWxjLiNe3gBRgbB2cNz60Ex69gWJYHyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BweXHhXwocfteBX7yiZvDtY6aS1cHGNsfX5B9QmYc8Gbxy1k1SAUOaDCkz/WyfnWsRWjbwzGEA5iA+GUp2eZy1qZCy8+el7Uhl/EANEGHKoJxV2Mq/HHE1ka7WkaVaoVJakUOlof+9Wd595mujjz+hdKfJsQF6Pb7sxAH5pWDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ta9Z6-0008Ps-UH; Tue, 21 Jan 2025 09:24:52 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ta9Z3-0014lS-0a;
	Tue, 21 Jan 2025 09:24:49 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1ta9Z3-0001U4-0B;
	Tue, 21 Jan 2025 09:24:49 +0100
Message-ID: <518c440a74b592099b1f5dddd95dbc23615dd034.camel@pengutronix.de>
Subject: Re: [RFC v3 09/18] drm/imagination: Add reset controller support
 for GPU initialization
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Michal Wilczynski <m.wilczynski@samsung.com>, mturquette@baylibre.com, 
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  drew@pdp7.com, guoren@kernel.org, wefu@redhat.com,
 jassisinghbrar@gmail.com,  paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu,  frank.binns@imgtec.com, matt.coster@imgtec.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
  airlied@gmail.com, simona@ffwll.ch, ulf.hansson@linaro.org,
 jszhang@kernel.org,  m.szyprowski@samsung.com
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-pm@vger.kernel.org
Date: Tue, 21 Jan 2025 09:24:48 +0100
In-Reply-To: <20250120172111.3492708-10-m.wilczynski@samsung.com>
References: <20250120172111.3492708-1-m.wilczynski@samsung.com>
	 <CGME20250120172131eucas1p1ed7fc14a96c66b1dc9e14e9fc7cbb2b7@eucas1p1.samsung.com>
	 <20250120172111.3492708-10-m.wilczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pm@vger.kernel.org

On Mo, 2025-01-20 at 18:21 +0100, Michal Wilczynski wrote:
> Certain platforms, such as the T-Head TH1520 and Banana Pi BPI-F3,
> require a controlled GPU reset sequence during the power-up procedure
> to ensure proper initialization. Without this reset, the GPU may remain
> in an undefined state, potentially leading to stability or performance
> issues.
>=20
> This commit integrates a dedicated reset controller within the
> drm/imagination driver. By doing so, the driver can coordinate the
> necessary reset operations as part of the normal GPU bring-up process,
> improving reliability and ensuring that the hardware is ready for
> operation.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  drivers/gpu/drm/imagination/pvr_device.c | 21 +++++++++++++++++++++
>  drivers/gpu/drm/imagination/pvr_device.h |  9 +++++++++
>  drivers/gpu/drm/imagination/pvr_power.c  | 15 ++++++++++++++-
>  3 files changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imagination/pvr_device.c b/drivers/gpu/drm/i=
magination/pvr_device.c
> index 1704c0268589..7ae9875d8d74 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.c
> +++ b/drivers/gpu/drm/imagination/pvr_device.c
> @@ -25,6 +25,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/stddef.h>
>  #include <linux/types.h>
> @@ -120,6 +121,21 @@ static int pvr_device_clk_init(struct pvr_device *pv=
r_dev)
>  	return 0;
>  }
> =20
> +static int pvr_device_reset_init(struct pvr_device *pvr_dev)
> +{
> +	struct drm_device *drm_dev =3D from_pvr_device(pvr_dev);
> +	struct reset_control *reset;
> +
> +	reset =3D devm_reset_control_get_exclusive_by_index(drm_dev->dev, 0);

The dt-bindings only specify a single reset. No need to request by
index. Please use:

	reset =3D devm_reset_control_get_exclusive(drm_dev->dev, NULL);

instead. Or devm_reset_control_get_optional_exclusive(), perhaps? See
below.

> +	if (IS_ERR(reset))
> +		return dev_err_probe(drm_dev->dev, PTR_ERR(reset),
> +				     "failed to get gpu reset line\n");
> +
> +	pvr_dev->reset =3D reset;
> +
> +	return 0;
> +}
> +
>  /**
>   * pvr_device_process_active_queues() - Process all queue related events=
.
>   * @pvr_dev: PowerVR device to check
> @@ -509,6 +525,11 @@ pvr_device_init(struct pvr_device *pvr_dev)
>  	if (err)
>  		return err;
> =20
> +	/* Get the reset line for the GPU */
> +	err =3D pvr_device_reset_init(pvr_dev);
> +	if (err)
> +		return err;
> +
>  	/* Explicitly power the GPU so we can access control registers before t=
he FW is booted. */
>  	err =3D pm_runtime_resume_and_get(dev);
>  	if (err)
> diff --git a/drivers/gpu/drm/imagination/pvr_device.h b/drivers/gpu/drm/i=
magination/pvr_device.h
> index 6d0dfacb677b..f6576c08111c 100644
> --- a/drivers/gpu/drm/imagination/pvr_device.h
> +++ b/drivers/gpu/drm/imagination/pvr_device.h
> @@ -131,6 +131,15 @@ struct pvr_device {
>  	 */
>  	struct clk *mem_clk;
> =20
> +	/**
> +	 * @reset: Optional reset line.

This looks like the reset control really should be made optional in
pvr_device_reset_init().

> +	 *
> +	 * This may be used on some platforms to provide a reset line that need=
s to be de-asserted
> +	 * after power-up procedure. It would also need to be asserted after th=
e power-down
> +	 * procedure.
> +	 */
> +	struct reset_control *reset;
> +
>  	/** @irq: IRQ number. */
>  	int irq;
> =20
> diff --git a/drivers/gpu/drm/imagination/pvr_power.c b/drivers/gpu/drm/im=
agination/pvr_power.c
> index ba7816fd28ec..87a955600d8b 100644
> --- a/drivers/gpu/drm/imagination/pvr_power.c
> +++ b/drivers/gpu/drm/imagination/pvr_power.c
> @@ -15,6 +15,7 @@
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/reset.h>
>  #include <linux/timer.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> @@ -252,6 +253,9 @@ pvr_power_device_suspend(struct device *dev)
>  	clk_disable_unprepare(pvr_dev->sys_clk);
>  	clk_disable_unprepare(pvr_dev->core_clk);
> =20
> +	if (pvr_dev->reset)
> +		err =3D reset_control_assert(pvr_dev->reset);

No need for conditional assert, reset_control_assert(NULL) is a no-op.
Just use:

	err =3D reset_control_assert(pvr_dev->reset);

> +
>  err_drm_dev_exit:
>  	drm_dev_exit(idx);
> =20
> @@ -282,16 +286,25 @@ pvr_power_device_resume(struct device *dev)
>  	if (err)
>  		goto err_sys_clk_disable;
> =20
> +	if (pvr_dev->reset) {
> +		err =3D reset_control_deassert(pvr_dev->reset);
> +		if (err)
> +			goto err_mem_clk_disable;
> +	}

Same as above, reset_control_deassert(NULL) returns 0:

	err =3D reset_control_deassert(pvr_dev->reset);
	if (err)
		goto err_mem_clk_disable;

regards
Philipp

