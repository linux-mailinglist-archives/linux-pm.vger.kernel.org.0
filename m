Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB411363E6
	for <lists+linux-pm@lfdr.de>; Fri, 10 Jan 2020 00:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgAIXhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Jan 2020 18:37:40 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39084 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgAIXhk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2020 18:37:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so29610wrt.6
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2020 15:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OkiBfAyiea+S3QYPk/Iz+JDLkJR3ttkyrtVdPCTuhPU=;
        b=liRSIkRr92KeTEDlG3OAm2rxJYDe8R3yhU4n/ZHZ/Xu+iUF1C108LnzEMAbElWR9qY
         2+sO7+5psgBa5wVqZ6oFv46a1HPldDhgcy/nbRF+Uc1TchWpufTVJRpTbeepL8MiswEj
         O3iR99E1MiV7eaN9CTTbG2pmTDvMLmbCbwqUmqbg2rZK4zg3A+aCxI/fqYJ6hUAiXpzK
         +IeTJSXR4zChB0mdyFO14eqpYZ8b394x04dmFsGasRMusgzyay6dOsKvdbvK+4xxUIcb
         E3HZtcHrD2gZyhxa0qMmj+LhvjzQ98IzV4K2zXz2W0F5zHXzJkaETm1Z6P2vfdDcuGLq
         itAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OkiBfAyiea+S3QYPk/Iz+JDLkJR3ttkyrtVdPCTuhPU=;
        b=J/Wf9pPx92xqL3kLfqvnsec1FMUzo+3YH76a/Ja/SoM7F3BMev2qx0QAftDh6OeLhP
         MmlkO8zDrEwhO31FF4KrasGwC+GhdkbTrbcat/F8CPebiyLgI88iIRPQD1AmY5LlzeHu
         2I813r+feHteJPOIIsevCxD9O7VOir5eu2/ICsDGr+Q4FI1hNMJFIdcjeNPgBJFeWCem
         DqIROh7UcOAUz1se4ns6HVGnV+C/hRML0hn8Eho38eNGHzi0S99chq3i6zMM+DHjVBnu
         NmfPzqXfhr1ZRl89u4jAvjJ0lOc/4OCpsCbGzxTOvwNVWru3XYahYX9TRD4LkidlbrL5
         Q+SA==
X-Gm-Message-State: APjAAAXMrJlah516egKCoUi0WsgkB7/8znxNLT3IEIRpdeIuPirqUq2Q
        lN0gyqzPNga/tV0F5rhoJ6r19g==
X-Google-Smtp-Source: APXvYqxYFvaY2WIoXqwERtNEGQgr9xw+D8IkqdN3f8YSzogYduorqlUgKM/WxxqJ1p8IglsT7NaFVw==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr269443wrp.182.1578613057624;
        Thu, 09 Jan 2020 15:37:37 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:f1d5:61e0:e9d8:1c3d? ([2a01:e34:ed2f:f020:f1d5:61e0:e9d8:1c3d])
        by smtp.googlemail.com with ESMTPSA id t5sm124922wrr.35.2020.01.09.15.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 15:37:37 -0800 (PST)
Subject: Re: [RESEND][PATCH] thermal: mediatek: add suspend/resume callback
To:     Michael Kao <michael.kao@mediatek.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>, hsinyi@chromium.org,
        linux-pm@vger.kernel.org, srv_heupstream@mediatek.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Louis Yu <louis.yu@mediatek.com>
References: <20191219092431.8935-1-michael.kao@mediatek.com>
 <20191219092431.8935-2-michael.kao@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <7e3506e3-a99e-eb01-ee42-5876b542fe38@linaro.org>
Date:   Fri, 10 Jan 2020 00:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191219092431.8935-2-michael.kao@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/12/2019 10:24, Michael Kao wrote:
> From: Louis Yu <louis.yu@mediatek.com>
> 
> Add suspend/resume callback to disable/enable Mediatek thermal sensor
> respectively. Since thermal power domain is off in suspend, thermal driver
> needs re-initialization during resume.
> 
> Signed-off-by: Louis Yu <louis.yu@mediatek.com>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 134 +++++++++++++++++++++++++++++++---
>  1 file changed, 125 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index acf4854cbb8b..2bb8b13591aa 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -22,6 +22,7 @@
>  #include <linux/thermal.h>
>  #include <linux/reset.h>
>  #include <linux/types.h>
> +#include <linux/iopoll.h>
>  
>  /* AUXADC Registers */
>  #define AUXADC_CON1_SET_V	0x008
> @@ -31,6 +32,8 @@
>  
>  #define APMIXED_SYS_TS_CON1	0x604
>  
> +#define APMIXED_SYS_TS_CON1_BUFFER_OFF	0x30
> +
>  /* Thermal Controller Registers */
>  #define TEMP_MONCTL0		0x000
>  #define TEMP_MONCTL1		0x004
> @@ -38,6 +41,7 @@
>  #define TEMP_MONIDET0		0x014
>  #define TEMP_MONIDET1		0x018
>  #define TEMP_MSRCTL0		0x038
> +#define TEMP_MSRCTL1		0x03c
>  #define TEMP_AHBPOLL		0x040
>  #define TEMP_AHBTO		0x044
>  #define TEMP_ADCPNP0		0x048
> @@ -87,6 +91,9 @@
>  #define TEMP_ADCVALIDMASK_VALID_HIGH		BIT(5)
>  #define TEMP_ADCVALIDMASK_VALID_POS(bit)	(bit)
>  
> +#define TEMP_MSRCTL1_BUS_STA	(BIT(0) | BIT(7))
> +#define TEMP_MSRCTL1_SENSING_POINTS_PAUSE	0x10E
> +
>  /* MT8173 thermal sensors */
>  #define MT8173_TS1	0
>  #define MT8173_TS2	1
> @@ -250,6 +257,10 @@ struct mtk_thermal_data {
>  struct mtk_thermal {
>  	struct device *dev;
>  	void __iomem *thermal_base;
> +	void __iomem *apmixed_base;
> +	void __iomem *auxadc_base;
> +	u64 apmixed_phys_base;
> +	u64 auxadc_phys_base;
>  
>  	struct clk *clk_peri_therm;
>  	struct clk *clk_auxadc;
> @@ -746,6 +757,42 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>  	mtk_thermal_put_bank(bank);
>  }
>  
> +static int mtk_thermal_disable_sensing(struct mtk_thermal *mt, int num)
> +{
> +	struct mtk_thermal_bank *bank = &mt->banks[num];
> +	u32 val;
> +	unsigned long timeout;
> +	void __iomem *addr;
> +	int ret = 0;
> +
> +	bank->id = num;
> +	bank->mt = mt;

Can you explain why this is done?

> +	mtk_thermal_get_bank(bank);

I'm not comfortable with this call. The underlying code is calling
mutex_lock, I suspect it can potentially deadlock the board.

Why do you need a mutex? Isn't a spin_lock enough?

Please take also the opportunity to rename to lock_bank / unlock_bank.
get and put are usually for refcounting.

> +	val = readl(mt->thermal_base + TEMP_MSRCTL1);
> +	/* pause periodic temperature measurement for sensing points */
> +	writel(val | TEMP_MSRCTL1_SENSING_POINTS_PAUSE,
> +	       mt->thermal_base + TEMP_MSRCTL1);
> +
> +	/* wait until temperature measurement bus idle */
> +	timeout = jiffies + HZ;
> +	addr = mt->thermal_base + TEMP_MSRCTL1;
> +
> +	ret = readl_poll_timeout(addr, val, (val & TEMP_MSRCTL1_BUS_STA) == 0x0,
> +				 0, timeout);
> +	if (ret < 0)
> +		goto out;
> +
> +	/* disable periodic temperature meausrement on sensing points */

s/meausrement/measurement/

> +	writel(0x0, mt->thermal_base + TEMP_MONCTL0);
> +
> +out:
> +	mtk_thermal_put_bank(bank);
> +
> +	return ret;
> +}
> +
>  static u64 of_get_phys_base(struct device_node *np)
>  {
>  	u64 size64;
> @@ -868,7 +915,6 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  	struct device_node *auxadc, *apmixedsys, *np = pdev->dev.of_node;
>  	struct mtk_thermal *mt;
>  	struct resource *res;
> -	u64 auxadc_phys_base, apmixed_phys_base;
>  	struct thermal_zone_device *tzdev;
>  
>  	mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
> @@ -904,11 +950,11 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	auxadc_phys_base = of_get_phys_base(auxadc);
> +	mt->auxadc_phys_base = of_get_phys_base(auxadc);
>  
>  	of_node_put(auxadc);
>  
> -	if (auxadc_phys_base == OF_BAD_ADDR) {
> +	if (mt->auxadc_phys_base == OF_BAD_ADDR) {
>  		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
>  		return -EINVAL;
>  	}
> @@ -919,11 +965,12 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	apmixed_phys_base = of_get_phys_base(apmixedsys);
> +	mt->apmixed_phys_base = of_get_phys_base(apmixedsys);
> +	mt->apmixed_base = of_iomap(apmixedsys, 0);
>  
>  	of_node_put(apmixedsys);
>  
> -	if (apmixed_phys_base == OF_BAD_ADDR) {
> +	if (mt->apmixed_phys_base == OF_BAD_ADDR) {
>  		dev_err(&pdev->dev, "Can't get auxadc phys address\n");
>  		return -EINVAL;
>  	}
> @@ -935,19 +982,19 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>  	ret = clk_prepare_enable(mt->clk_auxadc);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
> -		return ret;
> +		goto err_disable_clk_auxadc;
>  	}
>  
>  	ret = clk_prepare_enable(mt->clk_peri_therm);
>  	if (ret) {
>  		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> -		goto err_disable_clk_auxadc;
> +		goto err_disable_clk_peri_therm;
>  	}
>  
>  	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ; ctrl_id++)
>  		for (i = 0; i < mt->conf->num_banks; i++)
> -			mtk_thermal_init_bank(mt, i, apmixed_phys_base,
> -					      auxadc_phys_base, ctrl_id);
> +			mtk_thermal_init_bank(mt, i, mt->apmixed_phys_base,
> +					      mt->auxadc_phys_base, ctrl_id);
>  
>  	platform_set_drvdata(pdev, mt);
>  
> @@ -978,11 +1025,80 @@ static int mtk_thermal_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int __maybe_unused mtk_thermal_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mtk_thermal *mt = platform_get_drvdata(pdev);
> +	int i, ret;
> +
> +	for (i = 0; i < mt->conf->num_banks; i++) {
> +		ret = mtk_thermal_disable_sensing(mt, i);
> +		if (ret)
> +			goto out;
> +	}
> +
> +	/* disable buffer */
> +	writel(readl(mt->apmixed_base + APMIXED_SYS_TS_CON1) |
> +	       APMIXED_SYS_TS_CON1_BUFFER_OFF,
> +	       mt->apmixed_base + APMIXED_SYS_TS_CON1);
> +
> +	clk_disable_unprepare(mt->clk_peri_therm);
> +	clk_disable_unprepare(mt->clk_auxadc);
> +
> +	return 0;
> +
> +out:
> +	dev_err(&pdev->dev, "Failed to wait until bus idle\n");
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused mtk_thermal_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct mtk_thermal *mt = platform_get_drvdata(pdev);
> +	int i, ret, ctrl_id;
> +
> +	ret = device_reset(&pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = clk_prepare_enable(mt->clk_auxadc);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't enable auxadc clk: %d\n", ret);
> +		goto err_disable_clk_auxadc;
> +	}
> +
> +	ret = clk_prepare_enable(mt->clk_peri_therm);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Can't enable peri clk: %d\n", ret);
> +		goto err_disable_clk_peri_therm;
> +	}
> +
> +	for (ctrl_id = 0; ctrl_id < mt->conf->num_controller ; ctrl_id++)
> +		for (i = 0; i < mt->conf->num_banks; i++)
> +			mtk_thermal_init_bank(mt, i, mt->apmixed_phys_base,
> +					      mt->auxadc_phys_base, ctrl_id);
> +
> +	return 0;
> +
> +err_disable_clk_peri_therm:
> +	clk_disable_unprepare(mt->clk_peri_therm);
> +err_disable_clk_auxadc:
> +	clk_disable_unprepare(mt->clk_auxadc);
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mtk_thermal_pm_ops,
> +			 mtk_thermal_suspend, mtk_thermal_resume);
> +
>  static struct platform_driver mtk_thermal_driver = {
>  	.probe = mtk_thermal_probe,
>  	.remove = mtk_thermal_remove,
>  	.driver = {
>  		.name = "mtk-thermal",
> +		.pm = &mtk_thermal_pm_ops,
>  		.of_match_table = mtk_thermal_of_match,
>  	},
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

