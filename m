Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265D1166A35
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 23:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgBTWNn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 17:13:43 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40153 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgBTWNn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 17:13:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id t14so195340wmi.5
        for <linux-pm@vger.kernel.org>; Thu, 20 Feb 2020 14:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jUfFdw2Zfk6+TsIEq3Y3zBZt8xh6o4BAYFw0Cy9piao=;
        b=zQF06bXCl/IGUk7BYlnpWi1JiaBtl7fo/6WBweQAl6ueyW0Jrr/sfglRUq2YLP+zzO
         q1b3rjcbVr0+qgm5GYT+kEKC2fYb8ibYIw0kQ/3RNQ+eBE/19l+62xcnsGxBdLG7CWJK
         QdDuHZNN4+xGYMuep9JOqG4pNYLaYr0x5yoI9vkkQGiN0twvDsK4ag1iL3dzbgsYBQB3
         ASdK2HHYHGnJgcJ6KzylGKiwEv9cO4uXKx1M/4lZkCmllsYLH52L/4DdOWxYmOYxwdyD
         Eh62ASONNhc0enAOnjM1KIcF3dbUhuJFtZML1dTdaFKaCySRJTzitX1THz7aSaEqwBHv
         IjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jUfFdw2Zfk6+TsIEq3Y3zBZt8xh6o4BAYFw0Cy9piao=;
        b=NRgq9xJvCqV8/c6C54ewG+0Du7idphT9xdAw8wuCn3yt+mHKgrfFIyjWhrbXPG9cgD
         7q42G6Jc5hei5IRpC0kK5qVV1UBFCunowm62KQY6zjqmmYTMHBdUBic/MemRvmlm7tgL
         V4lr7KcO3W1ovUSZDsxZHBnE/e9yGOAL+pcjR1Qy9JSkNO+ofgT9O7pkWevtynVPT4Fx
         WsVPspdBq3kuwRwxGZ8OzUyTWgPssjK7YeKhTjYQPrddg3OgcY3i4+1pwn/CVMWZc+na
         enfUfStQWQLSE7hqw+4eFYydWNTqxdJKUbctxf+kJEKRzUDKZdLgcg/B+FTXGgqHEO/6
         13VQ==
X-Gm-Message-State: APjAAAXk0lOYfbEmovtVb/lt0gZUBd9DAWZLoft43x012EDk9ERwhfeM
        nqBtKr032Obo33MsmGrI52PeFw==
X-Google-Smtp-Source: APXvYqwJ0m2BHYbBrNyBeCq8AfsLhyTtxU2RR8idQnaC4wf/hphDZP56noO66Bh678igOeXTb1GQQQ==
X-Received: by 2002:a05:600c:21c5:: with SMTP id x5mr6791923wmj.72.1582236819746;
        Thu, 20 Feb 2020 14:13:39 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:2dfb:b5ce:9043:4adb])
        by smtp.gmail.com with ESMTPSA id d204sm868990wmd.30.2020.02.20.14.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 14:13:39 -0800 (PST)
Date:   Thu, 20 Feb 2020 23:13:34 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Keerthy <j-keerthy@ti.com>
Cc:     rui.zhang@intel.com, robh+dt@kernel.org,
        amit.kucheria@verdurent.com, t-kristo@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH 2/4] thermal: k3: Add support for bandgap sensors
Message-ID: <20200220221334.GA7119@linaro.org>
References: <20200213102440.20539-1-j-keerthy@ti.com>
 <20200213102440.20539-3-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200213102440.20539-3-j-keerthy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Feb 13, 2020 at 03:54:38PM +0530, Keerthy wrote:
> The bandgap provides current and voltage reference for its internal
> circuits and other analog IP blocks. The analog-to-digital
> converter (ADC) produces an output value that is proportional
> to the silicon temperature.
> 
> Currently reading temperatures and trend computing is supported
> as there are no active/passive cooling agent supported.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/thermal/Kconfig      |  12 ++
>  drivers/thermal/Makefile     |   1 +
>  drivers/thermal/k3_bandgap.c | 342 +++++++++++++++++++++++++++++++++++
>  3 files changed, 355 insertions(+)
>  create mode 100644 drivers/thermal/k3_bandgap.c
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 5a05db5438d6..fa598eddc7ac 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -251,6 +251,18 @@ config IMX_THERMAL
>  	  cpufreq is used as the cooling device to throttle CPUs when the
>  	  passive trip is crossed.
>  
> +config K3_THERMAL
> +	bool "Texas Instruments K3 thermal support"
> +	depends on THERMAL

All the Kconfig is under the THERMAL option, so this dependency is not
necessary.

> +	depends on ARCH_K3 || COMPILE_TEST
> +	help
> +	  If you say yes here you get thermal support for the Texas Instruments
> +	  K3 SoC family. The current chip supported is:
> +	   - AM654
> +
> +	  This includes temperature reading functionality and also trend
> +	  computation.
> +

[ ... ]

> +
> +#define K3_VTM_ADC_BEGIN_VAL		540
> +#define K3_VTM_ADC_END_VAL		944
> +
> +static const int k3_adc_to_temp[K3_VTM_ADC_END_VAL - K3_VTM_ADC_BEGIN_VAL
> +				+ 1] = {

No need to specify a size for the array that can be done with:

static const int k3_adc_to_temp[] = {

And then use ARRAY_SIZE macro.

> +	-40000, -40000, -40000, -40000, -39800, -39400, -39000, -38600, -38200,
> +	-37800, -37400, -37000, -36600, -36200, -35800, -35300, -34700, -34200,
> +	-33800, -33400, -33000, -32600, -32200, -31800, -31400, -31000, -30600,
> +	-30200, -29800, -29400, -29000, -28600, -28200, -27700, -27100, -26600,
> +	-26200, -25800, -25400, -25000, -24600, -24200, -23800, -23400, -23000,
> +	-22600, -22200, -21800, -21400, -21000, -20500, -19900, -19400, -19000,
> +	-18600, -18200, -17800, -17400, -17000, -16600, -16200, -15800, -15400,
> +	-15000, -14600, -14200, -13800, -13400, -13000, -12500, -11900, -11400,
> +	-11000, -10600, -10200, -9800, -9400, -9000, -8600, -8200, -7800, -7400,
> +	-7000, -6600, -6200, -5800, -5400, -5000, -4500, -3900, -3400, -3000,
> +	-2600, -2200, -1800, -1400, -1000, -600, -200, 200, 600, 1000, 1400,
> +	1800, 2200, 2600, 3000, 3400, 3900, 4500, 5000, 5400, 5800, 6200, 6600,
> +	7000, 7400, 7800, 8200, 8600, 9000, 9400, 9800, 10200, 10600, 11000,
> +	11400, 11800, 12200, 12700, 13300, 13800, 14200, 14600, 15000, 15400,
> +	15800, 16200, 16600, 17000, 17400, 17800, 18200, 18600, 19000, 19400,
> +	19800, 20200, 20600, 21000, 21400, 21900, 22500, 23000, 23400, 23800,
> +	24200, 24600, 25000, 25400, 25800, 26200, 26600, 27000, 27400, 27800,
> +	28200, 28600, 29000, 29400, 29800, 30200, 30600, 31000, 31400, 31900,
> +	32500, 33000, 33400, 33800, 34200, 34600, 35000, 35400, 35800, 36200,
> +	36600, 37000, 37400, 37800, 38200, 38600, 39000, 39400, 39800, 40200,
> +	40600, 41000, 41400, 41800, 42200, 42600, 43100, 43700, 44200, 44600,
> +	45000, 45400, 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600,
> +	49000, 49400, 49800, 50200, 50600, 51000, 51400, 51800, 52200, 52600,
> +	53000, 53400, 53800, 54200, 54600, 55000, 55400, 55900, 56500, 57000,
> +	57400, 57800, 58200, 58600, 59000, 59400, 59800, 60200, 60600, 61000,
> +	61400, 61800, 62200, 62600, 63000, 63400, 63800, 64200, 64600, 65000,
> +	65400, 65800, 66200, 66600, 67000, 67400, 67800, 68200, 68600, 69000,
> +	69400, 69800, 70200, 70600, 71000, 71500, 72100, 72600, 73000, 73400,
> +	73800, 74200, 74600, 75000, 75400, 75800, 76200, 76600, 77000, 77400,
> +	77800, 78200, 78600, 79000, 79400, 79800, 80200, 80600, 81000, 81400,
> +	81800, 82200, 82600, 83000, 83400, 83800, 84200, 84600, 85000, 85400,
> +	85800, 86200, 86600, 87000, 87400, 87800, 88200, 88600, 89000, 89400,
> +	89800, 90200, 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400,
> +	93800, 94200, 94600, 95000, 95400, 95800, 96200, 96600, 97000, 97500,
> +	98100, 98600, 99000, 99400, 99800, 100200, 100600, 101000, 101400,
> +	101800, 102200, 102600, 103000, 103400, 103800, 104200, 104600, 105000,
> +	105400, 105800, 106200, 106600, 107000, 107400, 107800, 108200, 108600,
> +	109000, 109400, 109800, 110200, 110600, 111000, 111400, 111800, 112200,
> +	112600, 113000, 113400, 113800, 114200, 114600, 115000, 115400, 115800,
> +	116200, 116600, 117000, 117400, 117800, 118200, 118600, 119000, 119400,
> +	119800, 120200, 120600, 121000, 121400, 121800, 122200, 122600, 123000,
> +	123400, 123800, 124200, 124600, 124900, 125000,
> +};
> +
> +struct k3_thermal_data;
> +
> +struct k3_bandgap {
> +	struct device *dev;

This field is useless, the function using it can use the local dev variable

> +	void __iomem *base;
> +	const struct k3_bandgap_data *conf;
> +	spinlock_t lock; /* shields this struct */

Where is used this lock?

> +	int ts_cnt;

This field is unused.

> +	u32 errata;
> +	struct k3_thermal_data *ts_data[K3_VTM_MAX_NUM_TS];

This field is unused.

> +};
> +
> +struct k3_vtm_driver_data {
> +	u32 errata;
> +};
> +
> +/* common data structures */
> +struct k3_thermal_data {
> +	struct thermal_zone_device *ti_thermal;
> +	struct thermal_cooling_device *cool_dev;

This field is unused

> +	struct k3_bandgap *bgp;
> +	enum thermal_device_mode mode;

This field is unused

> +	struct work_struct thermal_wq;

Where is used this workq?

> +	int sensor_id;
> +	u32 ctrl_offset;
> +	u32 stat_offset;
> +	int prev_temp;
> +};
> +
> +static unsigned int vtm_get_best_value(unsigned int s0, unsigned int s1,
> +				       unsigned int s2)
> +{
> +	int d01 = abs(s0 - s1);
> +	int d02 = abs(s0 - s2);
> +	int d12 = abs(s1 - s2);
> +
> +	if (d01 <= d02 && d01 <= d12)
> +		return (s0 + s1) / 2;
> +
> +	if (d02 <= d01 && d02 <= d12)
> +		return (s0 + s2) / 2;
> +
> +	return (s1 + s2) / 2;
> +}
> +
> +static int k3_bgp_read_temp(struct k3_thermal_data *devdata,
> +			    int *temp)
> +{
> +	struct k3_bandgap *bgp;
> +	unsigned int dtemp, s0, s1, s2;
> +
> +	bgp = devdata->bgp;

nit: missing line

> +	/**
> +	 * Errata is applicable for am654 pg 1.0 silicon. There
> +	 * is a variation of the order for 8-10 degree centigrade.
> +	 * Work around that by getting the average of two closest
> +	 * readings out of three readings everytime we want to
> +	 * report temperatures.
> +	 *
> +	 * Errata workaround.
> +	 */

nit: extra line

> +	if (bgp->errata) {

Right now only am654 is supported and has the errata. This test is pointless
because no other compatible string is defined. If you want to set the scene for
more platforms I suggest to add a get_temp function in the drvdata which does
this 3 points averaging and get rid of this test (and the errata field).

> +		s0 = readl(bgp->base + devdata->stat_offset) &
> +			K3_VTM_TS_STAT_DTEMP_MASK;
> +		s1 = readl(bgp->base + devdata->stat_offset) &
> +			K3_VTM_TS_STAT_DTEMP_MASK;
> +		s2 = readl(bgp->base + devdata->stat_offset) &
> +			K3_VTM_TS_STAT_DTEMP_MASK;
> +		dtemp = vtm_get_best_value(s0, s1, s2);
> +	} else {
> +		dtemp = readl(bgp->base + devdata->stat_offset) &
> +				K3_VTM_TS_STAT_DTEMP_MASK;
> +	}
> +
> +	if (dtemp < K3_VTM_ADC_BEGIN_VAL || dtemp > K3_VTM_ADC_END_VAL)
> +		return -EINVAL;
> +
> +	*temp = k3_adc_to_temp[dtemp - K3_VTM_ADC_BEGIN_VAL];
> +
> +	return 0;
> +}
> +
> +/* thermal zone ops */
> +/* Get temperature callback function for thermal zone */

Fix comment format

/*
 *
 */

> +static int k3_thermal_get_temp(void *devdata, int *temp)
> +{
> +	struct k3_thermal_data *data = devdata;
> +	int ret = 0;
> +
> +	ret = k3_bgp_read_temp(data, temp);
> +	if (ret)
> +		return ret;
> +
> +	data->prev_temp = *temp;
> +
> +	return ret;
> +}
> +
> +static int k3_thermal_get_trend(void *p, int trip, enum thermal_trend *trend)
> +{
> +	struct k3_thermal_data *data = p;
> +	struct k3_bandgap *bgp;
> +	int ret = 0, temp = 0;
> +
> +	bgp = data->bgp;
> +
> +	ret = k3_bgp_read_temp(data, &temp);
> +	if (ret)
> +		return ret;
> +
> +	if (temp > data->prev_temp)
> +		*trend = THERMAL_TREND_RAISING;
> +	else if (temp < data->prev_temp)
> +		*trend = THERMAL_TREND_DROPPING;
> +	else
> +		*trend = THERMAL_TREND_STABLE;
> +
> +	return 0;
> +}

This function get_trend() is not really useful, it does what the governors do.

It can be dropped.

> +static const struct thermal_zone_of_device_ops k3_of_thermal_ops = {
> +	.get_temp = k3_thermal_get_temp,
> +	.get_trend = k3_thermal_get_trend,
> +};
> +
> +static void k3_thermal_work(struct work_struct *work)
> +{
> +	struct k3_thermal_data *data = container_of(work,
> +					struct k3_thermal_data, thermal_wq);
> +
> +	thermal_zone_device_update(data->ti_thermal, THERMAL_EVENT_UNSPECIFIED);
> +
> +	dev_dbg(&data->ti_thermal->device, "updated thermal zone %s\n",
> +		data->ti_thermal->type);
> +}
> +
> +static const struct of_device_id of_k3_bandgap_match[];
> +
> +static int k3_bandgap_probe(struct platform_device *pdev)
> +{
> +	int ret = 0, cnt, val, id, reg_cnt = 0;
> +	struct resource *res;
> +	struct device *dev = &pdev->dev;
> +	struct k3_bandgap *bgp;
> +	struct k3_thermal_data *data;
> +	const struct k3_vtm_driver_data *drv_data;
> +
> +	bgp = devm_kzalloc(&pdev->dev, sizeof(*bgp), GFP_KERNEL);
> +	if (!bgp)
> +		return -ENOMEM;
> +
> +	drv_data = of_device_get_match_data(&pdev->dev);
> +	if (drv_data)
> +		bgp->errata = drv_data->errata;
> +
> +	bgp->dev = dev;
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	bgp->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(bgp->base))
> +		return PTR_ERR(bgp->base);
> +
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(dev);
> +		pm_runtime_disable(dev);
> +		return ret;
> +	}
> +
> +	/* Get the sensor count in the VTM */
> +	val = readl(bgp->base + K3_VTM_DEVINFO_PWR0_OFFSET);
> +	cnt = val & K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK;
> +	cnt >>= __ffs(K3_VTM_DEVINFO_PWR0_TEMPSENS_CT_MASK);
> +	bgp->ts_cnt = cnt;
> +
> +	data = devm_kcalloc(bgp->dev, cnt, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	/* Register the thermal sensors */
> +	for (id = 0; id < cnt; id++) {
> +		data[id].sensor_id = id;
> +		data[id].bgp = bgp;
> +		data[id].ctrl_offset = K3_VTM_TMPSENS0_CTRL_OFFSET +
> +					id * K3_VTM_REGS_PER_TS;
> +		data[id].stat_offset = data[id].ctrl_offset + 0x8;
> +		INIT_WORK(&data[id].thermal_wq, k3_thermal_work);
> +
> +		val = readl(data[id].bgp->base + data[id].ctrl_offset);
> +		val |= (K3_VTM_TMPSENS_CTRL_SOC |
> +			K3_VTM_TMPSENS_CTRL_CLRZ |
> +			K3_VTM_TMPSENS_CTRL_CLKON_REQ);
> +		val &= ~K3_VTM_TMPSENS_CTRL_CBIASSEL;
> +		writel(val, data[id].bgp->base + data[id].ctrl_offset);
> +
> +		bgp->ts_data[id] = &data[id];
> +		data[id].ti_thermal =
> +		devm_thermal_zone_of_sensor_register(bgp->dev, id,
> +						     &data[id],
> +						     &k3_of_thermal_ops);
> +		if (IS_ERR(data[id].ti_thermal)) {
> +			dev_err(bgp->dev, "thermal zone device is NULL\n");
> +			ret = PTR_ERR(data[id].ti_thermal);
> +			goto err_alloc;
> +		}
> +
> +		reg_cnt++;
> +
> +		/* Initialize Previous temp */
> +		k3_thermal_get_temp(&data[id], &data[id].prev_temp);
> +	}
> +
> +	platform_set_drvdata(pdev, bgp);
> +
> +	return 0;
> +
> +err_alloc:
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return ret;
> +}
> +
> +static int k3_bandgap_remove(struct platform_device *pdev)
> +{
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static const struct k3_vtm_driver_data am654_data = {
> +	.errata = 1,
> +};
> +
> +static const struct of_device_id of_k3_bandgap_match[] = {
> +	{
> +		.compatible = "ti,am654-vtm",
> +		.data = &am654_data,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, of_k3_bandgap_match);
> +
> +static struct platform_driver k3_bandgap_sensor_driver = {
> +	.probe = k3_bandgap_probe,
> +	.remove = k3_bandgap_remove,
> +	.driver = {
> +		.name = "k3-soc-thermal",
> +		.of_match_table	= of_k3_bandgap_match,
> +	},
> +};
> +
> +module_platform_driver(k3_bandgap_sensor_driver);
> +
> +MODULE_DESCRIPTION("K3 bandgap temperature sensor driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
> -- 
> 2.17.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
