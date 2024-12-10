Return-Path: <linux-pm+bounces-18936-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AE89EB8AC
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D4D1888C84
	for <lists+linux-pm@lfdr.de>; Tue, 10 Dec 2024 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4575E1AA786;
	Tue, 10 Dec 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="DzHcu05s"
X-Original-To: linux-pm@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0577386336;
	Tue, 10 Dec 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853113; cv=none; b=evFcUWSDq3hPoaxe4yXyLEs8+ji9z2gvPwvjYDYPurZ8FMVgNbhAIv/VIZ+Nie8Mp7eBCuXIcPn2mpMO9jg5GLjgPX9CLczYZx9kB9a5Bv6Yu8yaWToqG6o+Wn8Tv61pNna33hG6Ti6tiLrTo77gX6cowKft42DJw2nDop0paFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853113; c=relaxed/simple;
	bh=kIUfhctXtHp/HILQ548PNDcOS8oDknHHSfOedoQ6L/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NflRNxi6S9LNx25/0l4QPHqk+h/fOX5+d2toSxd1bgOQmuM5KJyVKylvRUPfjiGjlkKD1VtTq6Kc8QgR7oD3Z+WDV/C81FDQLBs4+6THTvbLgsNtA04kmUShN2qO1DsGC5R1wuVStbGu5CWRzF16f07L/UlXgYbUl1wIgzkClfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=DzHcu05s; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WoKlAx2lCcPCu7/whr69+RY7ecshkhAuKHIc6JJIKNM=; b=DzHcu05sWfX6pdzjMZLdq+T7DV
	nmGtLf+z+G+qdBtlrUlkYHGgB34pcga1S7HYighWzIZq8QNsSDuEnY9HW1pTSQG7gXs1jKY3jTK/b
	0flnPv1NbqbNGrqnaFPONGw8nkz9T8fQYsq045bulbwfSGIeGW1S1bG77vwrI5p1WaqeDk+d41oeg
	obIoukA/vxqioHKyu3zXQ4B+ui1THJoZ3qHJXzIVKMZOOHiBirycxIxfUGwhVocmY/FnPg8GF8U10
	h9ubijuPHp+lBnqsBhUTJ/mxTGxrAo+ukmCv4FZ8GuTbiaoGYL8YBq4ghB9YBl4g1+veWQSF8UP3N
	whgwynhw==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tL4OV-0000DD-Tt; Tue, 10 Dec 2024 18:51:36 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 =?ISO-8859-1?Q?Adri=E1n_Mart=EDnez?= Larumbe <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com
Subject: Re: [PATCH v4 6/7] pmdomain: rockchip: add regulator support
Date: Tue, 10 Dec 2024 18:51:34 +0100
Message-ID: <4082877.3daJWjYHZt@diego>
In-Reply-To: <20241210171023.141162-7-sebastian.reichel@collabora.com>
References:
 <20241210171023.141162-1-sebastian.reichel@collabora.com>
 <20241210171023.141162-7-sebastian.reichel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 10. Dezember 2024, 18:06:46 CET schrieb Sebastian Reichel:
> Some power domains require extra voltages to be applied. For example
> trying to enable the GPU power domain on RK3588 fails when the SoC
> does not have VDD GPU enabled. The same is expected to happen for
> the NPU, which also has a dedicated supply line.
> 
> We get the regulator using devm_of_regulator_get(), so a missing
> dependency in the devicetree is handled gracefully by printing a warning
> and creating a dummy regulator. This is necessary, since existing DTs do
> not have the regulator described. They might still work if the regulator
> is marked as always-on. It is also working if the regulator is enabled
> at boot time and the GPU driver is probed before the kernel disables
> unused regulators.
> 
> The regulator itself is not acquired at driver probe time, since that
> creates an unsolvable circular dependency. The power domain driver must
> be probed early, since SoC peripherals need it. Regulators on the other
> hand depend on SoC peripherals like SPI, I2C or GPIO. MediaTek does not
> run into this, since they have two power domain drivers.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


sidenote:
part of me is asking, why we're limiting regulator handling only to
specific individual domains when all domains sort of have supplying
regulators - just ones that normally always stay on.

But, the binding is generic, so we can extend that later on in the driver
if needed. Especially as this fixes a problem that happens right now.


Heiko


> ---
>  drivers/pmdomain/rockchip/pm-domains.c | 113 +++++++++++++++++--------
>  1 file changed, 79 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index f4e555dac20a..31c71b6fddf1 100644
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
> @@ -44,6 +45,7 @@ struct rockchip_domain_info {
>  	int idle_mask;
>  	int ack_mask;
>  	bool active_wakeup;
> +	bool need_regulator;
>  	int pwr_w_mask;
>  	int req_w_mask;
>  	int clk_ungate_mask;
> @@ -92,6 +94,8 @@ struct rockchip_pm_domain {
>  	u32 *qos_save_regs[MAX_QOS_REGS_NUM];
>  	int num_clks;
>  	struct clk_bulk_data *clks;
> +	struct device_node *node;
> +	struct regulator *supply;
>  };
>  
>  struct rockchip_pmu {
> @@ -129,7 +133,7 @@ struct rockchip_pmu {
>  	.active_wakeup = wakeup,			\
>  }
>  
> -#define DOMAIN_M_O_R(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, wakeup)	\
> +#define DOMAIN_M_O_R(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, wakeup, regulator)	\
>  {							\
>  	.name = _name,					\
>  	.pwr_offset = p_offset,				\
> @@ -145,6 +149,7 @@ struct rockchip_pmu {
>  	.idle_mask = (idle),				\
>  	.ack_mask = (ack),				\
>  	.active_wakeup = wakeup,			\
> +	.need_regulator = regulator,			\
>  }
>  
>  #define DOMAIN_M_O_R_G(_name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, ack, g_mask, wakeup)	\
> @@ -303,8 +308,8 @@ void rockchip_pmu_unblock(void)
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pmu_unblock);
>  
> -#define DOMAIN_RK3588(name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, wakeup)	\
> -	DOMAIN_M_O_R(name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, idle, wakeup)
> +#define DOMAIN_RK3588(name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, wakeup, regulator)	\
> +	DOMAIN_M_O_R(name, p_offset, pwr, status, m_offset, m_status, r_status, r_offset, req, idle, idle, wakeup, regulator)
>  
>  static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
>  {
> @@ -619,18 +624,57 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>  	return 0;
>  }
>  
> +static int rockchip_pd_regulator_disable(struct rockchip_pm_domain *pd)
> +{
> +	return IS_ERR_OR_NULL(pd->supply) ? 0 : regulator_disable(pd->supply);
> +}
> +
> +static int rockchip_pd_regulator_enable(struct rockchip_pm_domain *pd)
> +{
> +	struct rockchip_pmu *pmu = pd->pmu;
> +
> +	if (!pd->info->need_regulator)
> +		return 0;
> +
> +	if (IS_ERR_OR_NULL(pd->supply)) {
> +		pd->supply = devm_of_regulator_get(pmu->dev, pd->node, "domain");
> +
> +		if (IS_ERR(pd->supply))
> +			return PTR_ERR(pd->supply);
> +	}
> +
> +	return regulator_enable(pd->supply);
> +}
> +
>  static int rockchip_pd_power_on(struct generic_pm_domain *domain)
>  {
>  	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
> +	int ret;
> +
> +	ret = rockchip_pd_regulator_enable(pd);
> +	if (ret) {
> +		dev_err(pd->pmu->dev, "Failed to enable supply: %d\n", ret);
> +		return ret;
> +	}
>  
> -	return rockchip_pd_power(pd, true);
> +	ret = rockchip_pd_power(pd, true);
> +	if (ret)
> +		rockchip_pd_regulator_disable(pd);
> +
> +	return ret;
>  }
>  
>  static int rockchip_pd_power_off(struct generic_pm_domain *domain)
>  {
>  	struct rockchip_pm_domain *pd = to_rockchip_pd(domain);
> +	int ret;
>  
> -	return rockchip_pd_power(pd, false);
> +	ret = rockchip_pd_power(pd, false);
> +	if (ret)
> +		return ret;
> +
> +	rockchip_pd_regulator_disable(pd);
> +	return ret;
>  }
>  
>  static int rockchip_pd_attach_dev(struct generic_pm_domain *genpd,
> @@ -711,6 +755,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
>  
>  	pd->info = pd_info;
>  	pd->pmu = pmu;
> +	pd->node = node;
>  
>  	pd->num_clks = of_clk_get_parent_count(node);
>  	if (pd->num_clks > 0) {
> @@ -1174,35 +1219,35 @@ static const struct rockchip_domain_info rk3576_pm_domains[] = {
>  };
>  
>  static const struct rockchip_domain_info rk3588_pm_domains[] = {
> -	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false),
> -	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false),
> -	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false),
> -	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false),
> -	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false),
> -	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false),
> -	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false),
> -	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false),
> -	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false),
> -	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false),
> -	[RK3588_PD_VDPU]	= DOMAIN_RK3588("vdpu",    0x0, BIT(10), 0,       0x0, BIT(18), BIT(9),  0x0, BIT(8),  BIT(8),  false),
> -	[RK3588_PD_RGA30]	= DOMAIN_RK3588("rga30",   0x0, BIT(11), 0,       0x0, BIT(19), BIT(10), 0x0, 0,       0,       false),
> -	[RK3588_PD_AV1]		= DOMAIN_RK3588("av1",     0x0, BIT(12), 0,       0x0, BIT(20), BIT(11), 0x0, BIT(9),  BIT(9),  false),
> -	[RK3588_PD_VI]		= DOMAIN_RK3588("vi",      0x0, BIT(13), 0,       0x0, BIT(21), BIT(12), 0x0, BIT(10), BIT(10), false),
> -	[RK3588_PD_FEC]		= DOMAIN_RK3588("fec",     0x0, BIT(14), 0,       0x0, BIT(22), BIT(13), 0x0, 0,       0,       false),
> -	[RK3588_PD_ISP1]	= DOMAIN_RK3588("isp1",    0x0, BIT(15), 0,       0x0, BIT(23), BIT(14), 0x0, BIT(11), BIT(11), false),
> -	[RK3588_PD_RGA31]	= DOMAIN_RK3588("rga31",   0x4, BIT(0),  0,       0x0, BIT(24), BIT(15), 0x0, BIT(12), BIT(12), false),
> -	[RK3588_PD_VOP]		= DOMAIN_RK3588("vop",     0x4, BIT(1),  0,       0x0, BIT(25), BIT(16), 0x0, BIT(13) | BIT(14), BIT(13) | BIT(14), false),
> -	[RK3588_PD_VO0]		= DOMAIN_RK3588("vo0",     0x4, BIT(2),  0,       0x0, BIT(26), BIT(17), 0x0, BIT(15), BIT(15), false),
> -	[RK3588_PD_VO1]		= DOMAIN_RK3588("vo1",     0x4, BIT(3),  0,       0x0, BIT(27), BIT(18), 0x4, BIT(0),  BIT(16), false),
> -	[RK3588_PD_AUDIO]	= DOMAIN_RK3588("audio",   0x4, BIT(4),  0,       0x0, BIT(28), BIT(19), 0x4, BIT(1),  BIT(17), false),
> -	[RK3588_PD_PHP]		= DOMAIN_RK3588("php",     0x4, BIT(5),  0,       0x0, BIT(29), BIT(20), 0x4, BIT(5),  BIT(21), false),
> -	[RK3588_PD_GMAC]	= DOMAIN_RK3588("gmac",    0x4, BIT(6),  0,       0x0, BIT(30), BIT(21), 0x0, 0,       0,       false),
> -	[RK3588_PD_PCIE]	= DOMAIN_RK3588("pcie",    0x4, BIT(7),  0,       0x0, BIT(31), BIT(22), 0x0, 0,       0,       true),
> -	[RK3588_PD_NVM]		= DOMAIN_RK3588("nvm",     0x4, BIT(8),  BIT(24), 0x4, 0,       0,       0x4, BIT(2),  BIT(18), false),
> -	[RK3588_PD_NVM0]	= DOMAIN_RK3588("nvm0",    0x4, BIT(9),  0,       0x4, BIT(1),  BIT(23), 0x0, 0,       0,       false),
> -	[RK3588_PD_SDIO]	= DOMAIN_RK3588("sdio",    0x4, BIT(10), 0,       0x4, BIT(2),  BIT(24), 0x4, BIT(3),  BIT(19), false),
> -	[RK3588_PD_USB]		= DOMAIN_RK3588("usb",     0x4, BIT(11), 0,       0x4, BIT(3),  BIT(25), 0x4, BIT(4),  BIT(20), true),
> -	[RK3588_PD_SDMMC]	= DOMAIN_RK3588("sdmmc",   0x4, BIT(13), 0,       0x4, BIT(5),  BIT(26), 0x0, 0,       0,       false),
> +	[RK3588_PD_GPU]		= DOMAIN_RK3588("gpu",     0x0, BIT(0),  0,       0x0, 0,       BIT(1),  0x0, BIT(0),  BIT(0),  false, true),
> +	[RK3588_PD_NPU]		= DOMAIN_RK3588("npu",     0x0, BIT(1),  BIT(1),  0x0, 0,       0,       0x0, 0,       0,       false, true),
> +	[RK3588_PD_VCODEC]	= DOMAIN_RK3588("vcodec",  0x0, BIT(2),  BIT(2),  0x0, 0,       0,       0x0, 0,       0,       false, false),
> +	[RK3588_PD_NPUTOP]	= DOMAIN_RK3588("nputop",  0x0, BIT(3),  0,       0x0, BIT(11), BIT(2),  0x0, BIT(1),  BIT(1),  false, false),
> +	[RK3588_PD_NPU1]	= DOMAIN_RK3588("npu1",    0x0, BIT(4),  0,       0x0, BIT(12), BIT(3),  0x0, BIT(2),  BIT(2),  false, false),
> +	[RK3588_PD_NPU2]	= DOMAIN_RK3588("npu2",    0x0, BIT(5),  0,       0x0, BIT(13), BIT(4),  0x0, BIT(3),  BIT(3),  false, false),
> +	[RK3588_PD_VENC0]	= DOMAIN_RK3588("venc0",   0x0, BIT(6),  0,       0x0, BIT(14), BIT(5),  0x0, BIT(4),  BIT(4),  false, false),
> +	[RK3588_PD_VENC1]	= DOMAIN_RK3588("venc1",   0x0, BIT(7),  0,       0x0, BIT(15), BIT(6),  0x0, BIT(5),  BIT(5),  false, false),
> +	[RK3588_PD_RKVDEC0]	= DOMAIN_RK3588("rkvdec0", 0x0, BIT(8),  0,       0x0, BIT(16), BIT(7),  0x0, BIT(6),  BIT(6),  false, false),
> +	[RK3588_PD_RKVDEC1]	= DOMAIN_RK3588("rkvdec1", 0x0, BIT(9),  0,       0x0, BIT(17), BIT(8),  0x0, BIT(7),  BIT(7),  false, false),
> +	[RK3588_PD_VDPU]	= DOMAIN_RK3588("vdpu",    0x0, BIT(10), 0,       0x0, BIT(18), BIT(9),  0x0, BIT(8),  BIT(8),  false, false),
> +	[RK3588_PD_RGA30]	= DOMAIN_RK3588("rga30",   0x0, BIT(11), 0,       0x0, BIT(19), BIT(10), 0x0, 0,       0,       false, false),
> +	[RK3588_PD_AV1]		= DOMAIN_RK3588("av1",     0x0, BIT(12), 0,       0x0, BIT(20), BIT(11), 0x0, BIT(9),  BIT(9),  false, false),
> +	[RK3588_PD_VI]		= DOMAIN_RK3588("vi",      0x0, BIT(13), 0,       0x0, BIT(21), BIT(12), 0x0, BIT(10), BIT(10), false, false),
> +	[RK3588_PD_FEC]		= DOMAIN_RK3588("fec",     0x0, BIT(14), 0,       0x0, BIT(22), BIT(13), 0x0, 0,       0,       false, false),
> +	[RK3588_PD_ISP1]	= DOMAIN_RK3588("isp1",    0x0, BIT(15), 0,       0x0, BIT(23), BIT(14), 0x0, BIT(11), BIT(11), false, false),
> +	[RK3588_PD_RGA31]	= DOMAIN_RK3588("rga31",   0x4, BIT(0),  0,       0x0, BIT(24), BIT(15), 0x0, BIT(12), BIT(12), false, false),
> +	[RK3588_PD_VOP]		= DOMAIN_RK3588("vop",     0x4, BIT(1),  0,       0x0, BIT(25), BIT(16), 0x0, BIT(13) | BIT(14), BIT(13) | BIT(14), false, false),
> +	[RK3588_PD_VO0]		= DOMAIN_RK3588("vo0",     0x4, BIT(2),  0,       0x0, BIT(26), BIT(17), 0x0, BIT(15), BIT(15), false, false),
> +	[RK3588_PD_VO1]		= DOMAIN_RK3588("vo1",     0x4, BIT(3),  0,       0x0, BIT(27), BIT(18), 0x4, BIT(0),  BIT(16), false, false),
> +	[RK3588_PD_AUDIO]	= DOMAIN_RK3588("audio",   0x4, BIT(4),  0,       0x0, BIT(28), BIT(19), 0x4, BIT(1),  BIT(17), false, false),
> +	[RK3588_PD_PHP]		= DOMAIN_RK3588("php",     0x4, BIT(5),  0,       0x0, BIT(29), BIT(20), 0x4, BIT(5),  BIT(21), false, false),
> +	[RK3588_PD_GMAC]	= DOMAIN_RK3588("gmac",    0x4, BIT(6),  0,       0x0, BIT(30), BIT(21), 0x0, 0,       0,       false, false),
> +	[RK3588_PD_PCIE]	= DOMAIN_RK3588("pcie",    0x4, BIT(7),  0,       0x0, BIT(31), BIT(22), 0x0, 0,       0,       true, false),
> +	[RK3588_PD_NVM]		= DOMAIN_RK3588("nvm",     0x4, BIT(8),  BIT(24), 0x4, 0,       0,       0x4, BIT(2),  BIT(18), false, false),
> +	[RK3588_PD_NVM0]	= DOMAIN_RK3588("nvm0",    0x4, BIT(9),  0,       0x4, BIT(1),  BIT(23), 0x0, 0,       0,       false, false),
> +	[RK3588_PD_SDIO]	= DOMAIN_RK3588("sdio",    0x4, BIT(10), 0,       0x4, BIT(2),  BIT(24), 0x4, BIT(3),  BIT(19), false, false),
> +	[RK3588_PD_USB]		= DOMAIN_RK3588("usb",     0x4, BIT(11), 0,       0x4, BIT(3),  BIT(25), 0x4, BIT(4),  BIT(20), true, false),
> +	[RK3588_PD_SDMMC]	= DOMAIN_RK3588("sdmmc",   0x4, BIT(13), 0,       0x4, BIT(5),  BIT(26), 0x0, 0,       0,       false, false),
>  };
>  
>  static const struct rockchip_pmu_info px30_pmu = {
> 





