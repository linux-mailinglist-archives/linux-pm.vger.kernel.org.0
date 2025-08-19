Return-Path: <linux-pm+bounces-32637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EB3B2C409
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C21017375F
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 12:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34D43101BB;
	Tue, 19 Aug 2025 12:42:48 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AC31FC0ED;
	Tue, 19 Aug 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755607368; cv=none; b=HR8Sh8FfD+sTUliCHABdBmRNShQcXntrUkXQgLGHCCx1DBrh9qqTTVIqtshbEfQBoU3AculWpvmDTmZIQfpUMBPRVKqeMTJ1BcKlnWeabbRXHLjU9ykheVLkpg8fSdUZTagMF5gIeqWRY0rOSW9RY0AVg7UkZrFhwAtH3KFeZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755607368; c=relaxed/simple;
	bh=ib2TGbiQ87HiWZQ8FfbbKV34nhMhuHwRV3L/Cy9UUrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyOG76GwQ/CCmSbRc7R+ah7WAlCWIdeuhnCmHQN/HS2bH3k8JsD2zzYoXWCWSf89+3qHW0Vq9KPzxDKdPFI5aJ8qohxdFtnv/RxVVINRsIEouknGrPMWjzOBXcJPTs9AfHnpK+3B6ifz1Enw1BLSLUJdIA1QUkRseLviNeT/jzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 678E016A3;
	Tue, 19 Aug 2025 05:42:36 -0700 (PDT)
Received: from [10.1.196.50] (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 538723F63F;
	Tue, 19 Aug 2025 05:42:43 -0700 (PDT)
Message-ID: <2c7301cd-9c86-47fd-8b79-05f3e1a89e47@arm.com>
Date: Tue, 19 Aug 2025 13:42:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: rockchip: shut up GRF warning
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
References: <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250818-thermal-rockchip-grf-warning-v1-1-134152c97097@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/08/2025 6:26 pm, Sebastian Reichel wrote:
> Most of the recent Rockchip devices do not have a GRF associated
> with the tsadc IP. Let's avoid printing a warning on those devices.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/thermal/rockchip_thermal.c | 53 +++++++++++++++++++++++++++++++++-----
>   1 file changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 3beff9b6fac3abe8948b56132b618ff1bed57217..1e8091cebd6673ab39fa0c4dee835c68aeb7e8b5 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -50,6 +50,18 @@ enum adc_sort_mode {
>   	ADC_INCREMENT,
>   };
>   
> +/*
> + * The GRF availability depends on the specific SoC
> + * GRF_NONE: the SoC does not have a GRF associated with the tsadc
> + * GRF_OPTIONAL: the SoC has a GRF, but the driver can work without it
> + * GRF_MANDATORY: the SoC has a GRF and it is required for proper operation
> + */
> +enum tsadc_grf_mode {
> +	GRF_NONE,
> +	GRF_OPTIONAL,
> +	GRF_MANDATORY,
> +};
> +
>   #include "thermal_hwmon.h"
>   
>   /**
> @@ -97,6 +109,9 @@ struct rockchip_tsadc_chip {
>   	enum tshut_mode tshut_mode;
>   	enum tshut_polarity tshut_polarity;
>   
> +	/* GRF availability */
> +	enum tsadc_grf_mode grf_mode;
> +
>   	/* Chip-wide methods */
>   	void (*initialize)(struct regmap *grf,
>   			   void __iomem *reg, enum tshut_polarity p);
> @@ -1099,6 +1114,8 @@ static const struct rockchip_tsadc_chip px30_tsadc_data = {
>   	.chn_offset = 0,
>   	.chn_num = 2, /* 2 channels for tsadc */
>   
> +	.grf_mode = GRF_MANDATORY,
> +
>   	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
>   	.tshut_temp = 95000,
>   
> @@ -1123,6 +1140,8 @@ static const struct rockchip_tsadc_chip rv1108_tsadc_data = {
>   	.chn_offset = 0,
>   	.chn_num = 1, /* one channel for tsadc */
>   
> +	.grf_mode = GRF_NONE,
> +
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1148,6 +1167,8 @@ static const struct rockchip_tsadc_chip rk3228_tsadc_data = {
>   	.chn_offset = 0,
>   	.chn_num = 1, /* one channel for tsadc */
>   
> +	.grf_mode = GRF_NONE,
> +
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1173,6 +1194,8 @@ static const struct rockchip_tsadc_chip rk3288_tsadc_data = {
>   	.chn_offset = 1,
>   	.chn_num = 2, /* two channels for tsadc */
>   
> +	.grf_mode = GRF_NONE,
> +
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1198,6 +1221,8 @@ static const struct rockchip_tsadc_chip rk3328_tsadc_data = {
>   	.chn_offset = 0,
>   	.chn_num = 1, /* one channels for tsadc */
>   
> +	.grf_mode = GRF_NONE,
> +
>   	.tshut_mode = TSHUT_MODE_CRU, /* default TSHUT via CRU */
>   	.tshut_temp = 95000,
>   
> @@ -1222,6 +1247,8 @@ static const struct rockchip_tsadc_chip rk3366_tsadc_data = {
>   	.chn_offset = 0,
>   	.chn_num = 2, /* two channels for tsadc */
>   
> +	.grf_mode = GRF_OPTIONAL,
> +
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1247,6 +1274,8 @@ static const struct rockchip_tsadc_chip rk3368_tsadc_data = {
>   	.chn_offset = 0,
>   	.chn_num = 2, /* two channels for tsadc */
>   
> +	.grf_mode = GRF_NONE,
> +
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1272,6 +1301,8 @@ static const struct rockchip_tsadc_chip rk3399_tsadc_data = {
>   	.chn_offset = 0,
>   	.chn_num = 2, /* two channels for tsadc */
>   
> +	.grf_mode = GRF_OPTIONAL,
> +
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1297,6 +1328,8 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
>   	.chn_offset = 0,
>   	.chn_num = 2, /* two channels for tsadc */
>   
> +	.grf_mode = GRF_OPTIONAL,
> +
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1321,6 +1354,7 @@ static const struct rockchip_tsadc_chip rk3576_tsadc_data = {
>   	/* top, big_core, little_core, ddr, npu, gpu */
>   	.chn_offset = 0,
>   	.chn_num = 6, /* six channels for tsadc */
> +	.grf_mode = GRF_NONE,
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1345,6 +1379,7 @@ static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
>   	/* top, big_core0, big_core1, little_core, center, gpu, npu */
>   	.chn_offset = 0,
>   	.chn_num = 7, /* seven channels for tsadc */
> +	.grf_mode = GRF_NONE,
>   	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
>   	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
>   	.tshut_temp = 95000,
> @@ -1572,7 +1607,7 @@ static int rockchip_configure_from_dt(struct device *dev,
>   				      struct device_node *np,
>   				      struct rockchip_thermal_data *thermal)
>   {
> -	u32 shut_temp, tshut_mode, tshut_polarity;
> +	u32 shut_temp, tshut_mode, tshut_polarity, ret;
>   
>   	if (of_property_read_u32(np, "rockchip,hw-tshut-temp", &shut_temp)) {
>   		dev_warn(dev,
> @@ -1621,12 +1656,16 @@ static int rockchip_configure_from_dt(struct device *dev,
>   		return -EINVAL;
>   	}
>   
> -	/* The tsadc wont to handle the error in here since some SoCs didn't
> -	 * need this property.
> -	 */
> -	thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> -	if (IS_ERR(thermal->grf))
> -		dev_warn(dev, "Missing rockchip,grf property\n");
> +	if (thermal->chip->grf_mode != GRF_NONE) {
> +		thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
> +		if (IS_ERR(thermal->grf)) {
> +			ret = PTR_ERR(thermal->grf);
> +			if (thermal->chip->grf_mode == GRF_OPTIONAL)
> +				dev_warn(dev, "Missing rockchip,grf property\n");
> +			else
> +				return dev_err_probe(dev, ret, "Missing rockchip,grf property\n");
> +		}
> +	}

Nit: Does the lookup itself need to be made conditional? I think I'd
also agree that the "optional" mode seems suspect, so potentially it
could be a whole lot simpler, e.g.:

	thermal->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
	if (IS_ERR(thermal->grf) && thermal->chip->grf_required)
		return dev_err_probe(dev, PTR_ERR(thermal->grf),
				     "Missing rockchip,grf property\n");

Thanks,
Robin.

>   
>   	rockchip_get_trim_configuration(dev, np, thermal);
>   
> 
> ---
> base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
> change-id: 20250818-thermal-rockchip-grf-warning-05f7f56286a2
> 
> Best regards,


