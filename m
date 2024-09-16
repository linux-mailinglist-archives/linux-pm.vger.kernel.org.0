Return-Path: <linux-pm+bounces-14336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C8997A268
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 14:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19F3B20B1A
	for <lists+linux-pm@lfdr.de>; Mon, 16 Sep 2024 12:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603921553BB;
	Mon, 16 Sep 2024 12:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="c+q5vCko"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8327154C14;
	Mon, 16 Sep 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490274; cv=none; b=buECpNMxdZt3JIy3K4tNklWDFrWm9K8lGa2yGmAKwiFR2Nb53m2QHI3mud6OVoekKIFcXpLwsdinThl141n1X1OU86p+WFdvYuetv+2+v/f9fQ8eCsARZE67J6SwOhR4WG97PwYqWiLdVljOvtnZyenyfo+80Nkrgjg1+WrihVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490274; c=relaxed/simple;
	bh=y65NSrgbmh96g6Fzzy4doa1no9mY2zsJ/nVburEBCEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQQCP7+O3OAAAgHIyq0JUIBgXZeoMPIm9Zhzy/CCm6MprZ3+QvNxieA+E42GgfolurPeifzjzvbWzjQgm7akesPdvLTK2UN3c658UF6EYauyy967mzs2/I4HHKo5hIYSeRhK9bqSQvrax9SfAwUoMGEeuB1EE9sPYFwYWUrhOOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=c+q5vCko; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PLzXIHIxZWgoYaUEXDx3PwMb1pxlvF2RUqJddmVU4kw=; b=c+q5vCkowBNHuV4tex9LjcCmi3
	braWOndU5d3d00Sbzf6scWHTZovCzaCH9BqZ6jpSrDCkWu80S94KSRhj5EO3xOH525BRQktlOZNoC
	kTRy/bAQTAR8q8g+e0iqLSfUlRKX90ZIZZn95/4JdoplDQUcoaq11goen/MHt7B21MgtC+/XrieKX
	XK/GlB7DeK7TIRWv9hBWoJXtwCuGiEIMRLW9LrdtTf6sJPcWGLJjvCrnapooGyOmXa9EvGfsZaWM7
	7mbC4w99cOtVUW0mK7D0Z4bJhs3vEbYlOjTxNYZzBJu2XzDKE5axxXNjvgm/7cWrKJTSgu2BiY1iB
	n1jivncg==;
Received: from [83.68.141.146] (helo=phil.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sqAyy-0000uk-5l; Mon, 16 Sep 2024 14:37:32 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH v1 5/6] pmdomain: rockchip: add regulator support
Date: Mon, 16 Sep 2024 14:37:31 +0200
Message-ID: <2197494.irdbgypaU6@phil>
In-Reply-To: <20240910180530.47194-6-sebastian.reichel@collabora.com>
References:
 <20240910180530.47194-1-sebastian.reichel@collabora.com>
 <20240910180530.47194-6-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. September 2024, 19:57:14 CEST schrieb Sebastian Reichel:
> Some power domains require extra voltages to be applied. For example
> trying to enable the GPU domain on RK3588 fails when the SoC does not
> have VDD GPU enabled.
> 
> The solution to temporarily change the device's device tree node has
> been taken over from the Mediatek power domain driver.
> 
> The regulator is not acquired at probe time, since that creates circular
> dependencies. The power domain driver must be probed early, since SoC
> peripherals need it. Regulators on the other hand depend on SoC
> peripherals like SPI, I2C or GPIO.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 57 +++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 663d390faaeb..ae6990897928 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -18,6 +18,7 @@
>  #include <linux/of_clk.h>
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/mfd/syscon.h>
>  #include <soc/rockchip/pm_domains.h>
>  #include <dt-bindings/power/px30-power.h>
> @@ -89,6 +90,8 @@ struct rockchip_pm_domain {
>  	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
>  	int num_clks;
>  	struct clk_bulk_data *clks;
> +	struct device_node *node;
> +	struct regulator *supply;
>  };
>  
>  struct rockchip_pmu {
> @@ -571,18 +574,67 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>  	return 0;
>  }
>  
> +static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
> +{
> +	return pd->supply ? regulator_disable(pd->supply) : 0;
> +}
> +
> +

nit: double-empty line

other than that, this looks ok for the time being and as Sebastian
mentioned in Vienna, this also blocks actually testing
the Panthor-GPU driver right now.

So while we will likely convert to the hopefully soon existing
regulator stuff, this change is helpful for right now

Reviewed-by: Heiko Stuebner <heiko@sntech.de>



