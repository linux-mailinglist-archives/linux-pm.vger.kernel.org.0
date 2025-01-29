Return-Path: <linux-pm+bounces-21095-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDE0A21CF1
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 13:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541A13A5336
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2025 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974191B6CEC;
	Wed, 29 Jan 2025 12:05:51 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D451D9320
	for <linux-pm@vger.kernel.org>; Wed, 29 Jan 2025 12:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738152351; cv=none; b=cuHipA8XPQ14SW1VD8GmXfaSMxwpz9NIUaTpt0cPKT57YO8f+Qvf5mFxuSU6nibVOdqVGaqWiQzgLpEesN8i5Pm+T9hcG6Q/bQUCtsBkd1K6yWvdMtsy8fO4VHZirgafl7ER0rQrQpFP15sdkOTSdUdcKk6xU0Ax6abx5Cw0fIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738152351; c=relaxed/simple;
	bh=OMSNasQ/l727Tn5e5HeIPtR0C/HUH9P7QAHXwxfQRNo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bUWgeAHuzUe5TExx0L0XaZL0x9yEfB3Yh3/HGv+vHcSoyl8KsTD7Ld7P61jyR3s/3skrJ6p66QMJkA4L2vVpHMh8wO/TGnzElYDo5oY+Zg9UHFVx68SRHtCn4emx2iPr1/EsK7QH6f/pV1JFySd8i5CV24kNb/fH6TwPvqEMRCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1td6oV-00084D-9t; Wed, 29 Jan 2025 13:04:59 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1td6oP-002SPe-2U;
	Wed, 29 Jan 2025 13:04:53 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1td6oP-000561-27;
	Wed, 29 Jan 2025 13:04:53 +0100
Message-ID: <f79109bad50ed926af7ffc06bc3ab155fe6224ed.camel@pengutronix.de>
Subject: Re: [PATCH v4 09/18] reset: thead: Add TH1520 reset controller
 driver
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
Date: Wed, 29 Jan 2025 13:04:53 +0100
In-Reply-To: <20250128194816.2185326-10-m.wilczynski@samsung.com>
References: <20250128194816.2185326-1-m.wilczynski@samsung.com>
	 <CGME20250128194836eucas1p151c4fc83a17173fd1b79bfc959976301@eucas1p1.samsung.com>
	 <20250128194816.2185326-10-m.wilczynski@samsung.com>
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

On Di, 2025-01-28 at 20:48 +0100, Michal Wilczynski wrote:
> Add reset controller driver for the T-HEAD TH1520 SoC that manages
> hardware reset lines for various subsystems. The driver currently
> implements support for GPU reset control, with infrastructure in place
> to extend support for NPU and Watchdog Timer resets in future updates.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
> ---
>  MAINTAINERS | 1 +
>  drivers/reset/Kconfig | 10 ++
>  drivers/reset/Makefile | 1 +
>  drivers/reset/reset-th1520.c | 178 +++++++++++++++++++++++++++++++++++
>  4 files changed, 190 insertions(+)
>  create mode 100644 drivers/reset/reset-th1520.c
>=20
[...]
> diff --git a/drivers/reset/reset-th1520.c b/drivers/reset/reset-th1520.c
> new file mode 100644
> index 000000000000..48afbc9f1cdd
> --- /dev/null
> +++ b/drivers/reset/reset-th1520.c
> @@ -0,0 +1,178 @@
[...]
> +static int th1520_reset_xlate(struct reset_controller_dev *rcdev,
> + const struct of_phandle_args *reset_spec)
> +{
> + unsigned int index =3D reset_spec->args[0];
> +
> + /* currently, only GPU reset is implemented in this driver */
> + if (index =3D=3D TH1520_RESET_ID_GPU)
> + return index;
> +
> + return -EOPNOTSUPP;

It is customary to return -EINVAL for unsupported resets.

Further, you don't have to implement a custom .of_xlate at all.
With nr_resets being set to 1, and because TH1520_RESET_ID_GPU happens
to be 0, the of_reset_simple_xlate() default implementation will do
exactly the same.

[...]
> +static int th1520_reset_probe(struct platform_device *pdev)
> +{
> + struct device *dev =3D &pdev->dev;
> + struct th1520_reset_priv *priv;
> + void __iomem *base;
> +
> + priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> + if (!priv)
> + return -ENOMEM;
> +
> + base =3D devm_platform_ioremap_resource(pdev, 0);
> + if (IS_ERR(base))
> + return PTR_ERR(base);
> +
> + priv->map =3D devm_regmap_init_mmio(dev, base,
> + &th1520_reset_regmap_config);
> + if (IS_ERR(priv->map))
> + return PTR_ERR(priv->map);
> +
> + mutex_init(&priv->gpu_seq_lock);
> +
> + priv->rcdev.owner =3D THIS_MODULE;
> + priv->rcdev.nr_resets =3D 1;
> + priv->rcdev.ops =3D &th1520_reset_ops;
> + priv->rcdev.of_node =3D dev->of_node;
>    A. > + priv->rcdev.of_xlate =3D th1520_reset_xlate;
> + priv->rcdev.of_reset_n_cells =3D 1;

You could just drop these two lines again. With that,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

