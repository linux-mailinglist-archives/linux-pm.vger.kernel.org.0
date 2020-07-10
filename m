Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03BB821B957
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jul 2020 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgGJPXJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Jul 2020 11:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgGJPXH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 11:23:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85555C08C5CE;
        Fri, 10 Jul 2020 08:23:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so6574578wmg.1;
        Fri, 10 Jul 2020 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hu99yik/gunIHw5BfhF8vhqV9haIVh+NeytR1XoGeRA=;
        b=DE8SOUS5RcaHSbjjZb1KybSnrmWKymVJ3rsaKCuS67uIoVl8Iwp1Q6Aetw98EagTho
         K7TGn2oVEqKmSWnCC+8rl+Wx/4Wknb+cWO5TIg8wblQ/+RlW7J34C+zPNzHiWq2jnf7x
         IB+1ZrHBznT0j1LE80iZ010o6ekMIk9rDe1AHgloGkoE73R3/P8lyUhLnCirZJtf4845
         /WrrjyA09/ewwgAfKLfbCKcls9hpjwQE2SyNRAvsVxwmTHEuxg3yvpyjGIeNs3t1iseq
         nmOy/70K2pDsDRUGBJzchRBT58G3LuP1fSPJj4B70NHZ5FyhfH5wTfRH0ip8yW+GXpCb
         m+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hu99yik/gunIHw5BfhF8vhqV9haIVh+NeytR1XoGeRA=;
        b=SLUqo0Yaq54oTsltuFwKZnjRe/1DzUkV+eclhlVKjtOQitvmok5w+0mFqxBCcWlp2q
         smCUWjP3H5rm6FuDO4J7Yeeku8KiBRjwtL43ppBS7+TcLSe2qsC3esI8mxFRc0tf2n/Q
         VFD1U/i5vai+uLdzUVjo7Zwwup9yH050CczpBjuDs1j6BJuRD44L8zUI5ilp5/TVmRWM
         byfvXuX3wtYZ1QtuPmUqkFjB6QSvlPevhsPpAaxYWpv46f2hxsJ0uuLYziuuUzTcy8BR
         deYMzVnlPBk8JkRCwy8i3ISK7BJg04fpWO53cbWn9dYiDX/KFLz9xBvaVSk+EqmJZLXD
         ITYA==
X-Gm-Message-State: AOAM532/7/DFNMcn1tYVSEgEumSkZ6C/zpiflnIQZRdMjApKutLKdKC5
        R9w9uTXm+zR3O3uQegnwV68=
X-Google-Smtp-Source: ABdhPJzZgO2flgabSfy4bWT7cWrpDZZAvkdQPBx8RI0H+IUB8mJjtZrUVAyWPaZ8YGCNCuQ6or9HdQ==
X-Received: by 2002:a1c:1bc6:: with SMTP id b189mr5434396wmb.166.1594394585953;
        Fri, 10 Jul 2020 08:23:05 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id q7sm11199755wra.56.2020.07.10.08.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 08:23:05 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: mediatek: add tsensor support for V2
 thermal system
To:     Henry Yen <henry.yen@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Liu <steven.liu@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
References: <1588238074-19338-1-git-send-email-henry.yen@mediatek.com>
 <1588238074-19338-3-git-send-email-henry.yen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <f086c86e-7d7b-50c4-baf2-66022301adc7@gmail.com>
Date:   Fri, 10 Jul 2020 17:23:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1588238074-19338-3-git-send-email-henry.yen@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 30/04/2020 11:14, Henry Yen wrote:
> This patch adds full support for ver 2 thermal system (e.g., MT7622 SoC).
> The new changes include reading calibration data, converting temperature
> and hardware initialization which are specific for version 2 system.
> Each platform decides which function to call according to its version.
> 
> Fixes: 3966be3c08c3 ("thermal: mediatek: add support for MT7622 SoC")
> Signed-off-by: Henry Yen <henry.yen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/thermal/mtk_thermal.c | 132 ++++++++++++++++++++++++++++++++--
>   1 file changed, 125 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index 10107d9d56a8..88620f7e9890 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -38,6 +38,7 @@
>   #define TEMP_MONIDET0		0x014
>   #define TEMP_MONIDET1		0x018
>   #define TEMP_MSRCTL0		0x038
> +#define TEMP_MSRCTL1		0x03c
>   #define TEMP_AHBPOLL		0x040
>   #define TEMP_AHBTO		0x044
>   #define TEMP_ADCPNP0		0x048
> @@ -133,6 +134,20 @@
>   #define CALIB_BUF0_O_SLOPE_SIGN_V1(x)	(((x) >> 7) & 0x1)
>   #define CALIB_BUF1_ID_V1(x)		(((x) >> 9) & 0x1)
>   
> +/*
> + * Layout of the fuses providing the calibration data
> + * These macros could be used for MT7622.
> + */
> +#define CALIB_BUF0_ADC_OE_V2(x)		(((x) >> 22) & 0x3ff)
> +#define CALIB_BUF0_ADC_GE_V2(x)		(((x) >> 12) & 0x3ff)
> +#define CALIB_BUF0_DEGC_CALI_V2(x)	(((x) >> 6) & 0x3f)
> +#define CALIB_BUF0_O_SLOPE_V2(x)	(((x) >> 0) & 0x3f)
> +#define CALIB_BUF1_VTS_TS1_V2(x)	(((x) >> 23) & 0x1ff)
> +#define CALIB_BUF1_VTS_TS2_V2(x)	(((x) >> 14) & 0x1ff)
> +#define CALIB_BUF1_VTS_TSABB_V2(x)	(((x) >> 5) & 0x1ff)
> +#define CALIB_BUF1_VALID_V2(x)		(((x) >> 4) & 0x1)
> +#define CALIB_BUF1_O_SLOPE_SIGN_V2(x)	(((x) >> 3) & 0x1)
> +
>   enum {
>   	VTS1,
>   	VTS2,
> @@ -143,6 +158,11 @@ enum {
>   	MAX_NUM_VTS,
>   };
>   
> +enum mtk_thermal_version {
> +	MTK_THERMAL_V1 = 1,
> +	MTK_THERMAL_V2,
> +};
> +
>   /* MT2701 thermal sensors */
>   #define MT2701_TS1	0
>   #define MT2701_TS2	1
> @@ -245,6 +265,7 @@ struct mtk_thermal_data {
>   	const int *controller_offset;
>   	bool need_switch_bank;
>   	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
> +	enum mtk_thermal_version version;
>   };
>   
>   struct mtk_thermal {
> @@ -258,8 +279,10 @@ struct mtk_thermal {
>   
>   	/* Calibration values */
>   	s32 adc_ge;
> +	s32 adc_oe;
>   	s32 degc_cali;
>   	s32 o_slope;
> +	s32 o_slope_sign;
>   	s32 vts[MAX_NUM_VTS];
>   
>   	const struct mtk_thermal_data *conf;
> @@ -398,6 +421,7 @@ static const struct mtk_thermal_data mt8173_thermal_data = {
>   	.msr = mt8173_msr,
>   	.adcpnp = mt8173_adcpnp,
>   	.sensor_mux_values = mt8173_mux_values,
> +	.version = MTK_THERMAL_V1,
>   };
>   
>   /*
> @@ -428,6 +452,7 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
>   	.msr = mt2701_msr,
>   	.adcpnp = mt2701_adcpnp,
>   	.sensor_mux_values = mt2701_mux_values,
> +	.version = MTK_THERMAL_V1,
>   };
>   
>   /*
> @@ -458,6 +483,7 @@ static const struct mtk_thermal_data mt2712_thermal_data = {
>   	.msr = mt2712_msr,
>   	.adcpnp = mt2712_adcpnp,
>   	.sensor_mux_values = mt2712_mux_values,
> +	.version = MTK_THERMAL_V1,
>   };
>   
>   /*
> @@ -482,6 +508,7 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
>   	.msr = mt7622_msr,
>   	.adcpnp = mt7622_adcpnp,
>   	.sensor_mux_values = mt7622_mux_values,
> +	.version = MTK_THERMAL_V2,
>   };
>   
>   /*
> @@ -514,6 +541,7 @@ static const struct mtk_thermal_data mt8183_thermal_data = {
>   	.msr = mt8183_msr,
>   	.adcpnp = mt8183_adcpnp,
>   	.sensor_mux_values = mt8183_mux_values,
> +	.version = MTK_THERMAL_V1,
>   };
>   
>   /**
> @@ -540,6 +568,36 @@ static int raw_to_mcelsius_v1(struct mtk_thermal *mt, int sensno, s32 raw)
>   	return mt->degc_cali * 500 - tmp;
>   }
>   
> +static int raw_to_mcelsius_v2(struct mtk_thermal *mt, int sensno, s32 raw)
> +{
> +	s32 format_1 = 0;
> +	s32 format_2 = 0;
> +	s32 g_oe = 1;
> +	s32 g_gain = 1;
> +	s32 g_x_roomt = 0;
> +	s32 tmp = 0;
> +
> +	if (raw == 0)
> +		return 0;
> +
> +	raw &= 0xfff;
> +	g_gain = 10000 + (((mt->adc_ge - 512) * 10000) >> 12);
> +	g_oe = mt->adc_oe - 512;
> +	format_1 = mt->vts[VTS2] + 3105 - g_oe;
> +	format_2 = (mt->degc_cali * 10) >> 1;
> +	g_x_roomt = (((format_1 * 10000) >> 12) * 10000) / g_gain;
> +
> +	tmp = (((((raw - g_oe) * 10000) >> 12) * 10000) / g_gain) - g_x_roomt;
> +	tmp = tmp * 10 * 100 / 11;
> +
> +	if (mt->o_slope_sign == 0)
> +		tmp = tmp / (165 - mt->o_slope);
> +	else
> +		tmp = tmp / (165 + mt->o_slope);
> +
> +	return (format_2 - tmp) * 100;
> +}
> +
>   /**
>    * mtk_thermal_get_bank - get bank
>    * @bank:	The bank
> @@ -594,9 +652,13 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>   		raw = readl(mt->thermal_base +
>   			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
>   
> -		temp = raw_to_mcelsius_v1(mt,
> -					  conf->bank_data[bank->id].sensors[i],
> -					  raw);
> +		if (mt->conf->version == MTK_THERMAL_V1) {
> +			temp = raw_to_mcelsius_v1(
> +				mt, conf->bank_data[bank->id].sensors[i], raw);
> +		} else {
> +			temp = raw_to_mcelsius_v2(
> +				mt, conf->bank_data[bank->id].sensors[i], raw);
> +		}
>   
>   		/*
>   		 * The first read of a sensor often contains very high bogus
> @@ -698,9 +760,11 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>   	writel(auxadc_phys_base + AUXADC_CON1_CLR_V,
>   	       controller_base + TEMP_ADCMUXADDR);
>   
> -	/* AHB address for pnp sensor mux selection */
> -	writel(apmixed_phys_base + APMIXED_SYS_TS_CON1,
> -	       controller_base + TEMP_PNPMUXADDR);
> +	if (mt->conf->version == MTK_THERMAL_V1) {
> +		/* AHB address for pnp sensor mux selection */
> +		writel(apmixed_phys_base + APMIXED_SYS_TS_CON1,
> +		       controller_base + TEMP_PNPMUXADDR);
> +	}
>   
>   	/* AHB value for auxadc enable */
>   	writel(BIT(conf->auxadc_channel), controller_base + TEMP_ADCEN);
> @@ -803,6 +867,23 @@ static int mtk_thermal_extract_efuse_v1(struct mtk_thermal *mt, u32 *buf)
>   	return 0;
>   }
>   
> +static int mtk_thermal_extract_efuse_v2(struct mtk_thermal *mt, u32 *buf)
> +{
> +	if (!CALIB_BUF1_VALID_V2(buf[1]))
> +		return -EINVAL;
> +
> +	mt->adc_oe = CALIB_BUF0_ADC_OE_V2(buf[0]);
> +	mt->adc_ge = CALIB_BUF0_ADC_GE_V2(buf[0]);
> +	mt->degc_cali = CALIB_BUF0_DEGC_CALI_V2(buf[0]);
> +	mt->o_slope = CALIB_BUF0_O_SLOPE_V2(buf[0]);
> +	mt->vts[VTS1] = CALIB_BUF1_VTS_TS1_V2(buf[1]);
> +	mt->vts[VTS2] = CALIB_BUF1_VTS_TS2_V2(buf[1]);
> +	mt->vts[VTSABB] = CALIB_BUF1_VTS_TSABB_V2(buf[1]);
> +	mt->o_slope_sign = CALIB_BUF1_O_SLOPE_SIGN_V2(buf[1]);
> +
> +	return 0;
> +}
> +
>   static int mtk_thermal_get_calibration_data(struct device *dev,
>   					    struct mtk_thermal *mt)
>   {
> @@ -838,8 +919,15 @@ static int mtk_thermal_get_calibration_data(struct device *dev,
>   		goto out;
>   	}
>   
> -	if (mtk_thermal_extract_efuse_v1(mt, buf))
> +	if (mt->conf->version == MTK_THERMAL_V1)
> +		ret = mtk_thermal_extract_efuse_v1(mt, buf);
> +	else
> +		ret = mtk_thermal_extract_efuse_v2(mt, buf);
> +
> +	if (ret) {
>   		dev_info(dev, "Device not calibrated, using default calibration values\n");
> +		ret = 0;
> +	}
>   
>   out:
>   	kfree(buf);
> @@ -872,6 +960,28 @@ static const struct of_device_id mtk_thermal_of_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
>   
> +static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
> +{
> +	int tmp;
> +
> +	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
> +	tmp &= ~(0x37);
> +	tmp |= 0x1;
> +	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
> +	udelay(200);
> +}
> +
> +static void mtk_thermal_release_periodic_ts(struct mtk_thermal *mt,
> +					    void __iomem *auxadc_base)
> +{
> +	int tmp;
> +
> +	writel(0x800, auxadc_base + AUXADC_CON1_SET_V);
> +	writel(0x1, mt->thermal_base + TEMP_MONCTL0);
> +	tmp = readl(mt->thermal_base + TEMP_MSRCTL1);
> +	writel((tmp & (~0x10e)), mt->thermal_base + TEMP_MSRCTL1);
> +}
> +
>   static int mtk_thermal_probe(struct platform_device *pdev)
>   {
>   	int ret, i, ctrl_id;
> @@ -880,6 +990,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   	struct resource *res;
>   	u64 auxadc_phys_base, apmixed_phys_base;
>   	struct thermal_zone_device *tzdev;
> +	void __iomem *apmixed_base, *auxadc_base;
>   
>   	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>   	if (!mt)
> @@ -914,6 +1025,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> +	auxadc_base = of_iomap(auxadc, 0);
>   	auxadc_phys_base = of_get_phys_base(auxadc);
>   
>   	of_node_put(auxadc);
> @@ -929,6 +1041,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> +	apmixed_base = of_iomap(apmixedsys, 0);
>   	apmixed_phys_base = of_get_phys_base(apmixedsys);
>   
>   	of_node_put(apmixedsys);
> @@ -954,6 +1067,11 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>   		goto err_disable_clk_auxadc;
>   	}
>   
> +	if (mt->conf->version == MTK_THERMAL_V2) {
> +		mtk_thermal_turn_on_buffer(apmixed_base);
> +		mtk_thermal_release_periodic_ts(mt, auxadc_base);
> +	}
> +
>   	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ; ctrl_id++)
>   		for (i = 0; i < mt->conf->num_banks; i++)
>   			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
> 
