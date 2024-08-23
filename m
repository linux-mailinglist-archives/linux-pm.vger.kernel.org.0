Return-Path: <linux-pm+bounces-12807-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C36195C8AE
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529B52881B2
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2024 08:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CE59187563;
	Fri, 23 Aug 2024 08:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="VhVBZE5L"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D2014D718
	for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403460; cv=none; b=f4FGoQxIsjdk1EFNFZs1palLH+JK1gaC0urUx/R3e2MfazKzEdAXNy55X2AMDp34RFQi22SyEMNBlPPLsS8hTtMcV/G25M9Q1YCrNN5+g4OZwFSvNNYd+yqBe6pwc3ooYR5JUMqabPhVjFcHumP3VI4mSKAw3Odk3+yQ5VPV8ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403460; c=relaxed/simple;
	bh=8lnr6Y8CYYR/tsZAaXobHIHOJeKtPwwM0WSm4dTdVDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlr+GsM3HzyTAQ+xFjU/aJK1P6jgDOwACv/seM35emK44h3slPLYBN/lqYfOJAsApMMKIfz8b84+mht7NvyK1sFKtfPEaSFTXH2YaQ3AKYgyUt4nKF5zfsphRMj9kcqsGT3pdKHJHH2uHbjhFryFLPgACtjx12UDAnt4B4kjZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=VhVBZE5L; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a86910caf9cso271346566b.1
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2024 01:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1724403454; x=1725008254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VK+R1YErGMIO7vYDEQLL4B3Ghiw/eVr2mZ+qQpA7ME=;
        b=VhVBZE5L/aEEE2/7LjYy06WdCtsSgxaG+d6aA7NeA94fGwTS5kX1ydoD8o2qTuYP/B
         IvT5TJ87fAAQybiZKAeGQvZpM/3q4Ca9eXDLUzzDxqxp0M/IKV0POPl4ZTyhVNjyNLxp
         tu7hN056Gk/pr+OwRiZrugubbh89cjJ5rf5U7+c3MjsJRP+pS5VRHhQIb+XizvykEjHo
         LlL+H2lI+kd3hE1Izzz/M7ju5MpUbKzvGK6Yoq1p0q9qs0faP6t3zmyqjCIZTrzs8FdF
         XCin7p/7dHOa0BH9cTIrsjetG1CKTvEg19UyWqtp+wW4hu8G+FdwMkYBn9LH6N+AvelU
         4IOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403454; x=1725008254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VK+R1YErGMIO7vYDEQLL4B3Ghiw/eVr2mZ+qQpA7ME=;
        b=hlu+J9CJetMe63+1GC5hmI21BQzV6Ob694JZghkdzuJpt9740pvdYbfWSyTvLllWKi
         o4GZJ0X5SKrbMpyLIfgpPo6haVRhZxWIm4L1pxG6yQ69fOtGwPcJeycRh0MQ8aztbhe8
         mQKtlEL2q+Wt9iSdwsdcBA1o6VEa/MA0sROwbDNeLvbt0ja3NGq52OpUVxn1O6RpgrOM
         Dizjm5b6lMYrLp08XV7N5tehoE2BQ6QhTySJA88MCSGmFIGV1T6NtzfushjAXv+0k/B7
         DrTU4cl11RVsf/E28IUWdaBQ1FEwyGqI0RmB+SWUECCrPltJfLP7gPSJCzAH4zM9WMjm
         BGwg==
X-Forwarded-Encrypted: i=1; AJvYcCXzlbTejCNQSwd7HYEDl+4U52crf5KRs42n4RwumPMsITEcj7PM3AwPpnbDlab2xK5hcw3PbmkWWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhgwWRQTZNzBqVBkTRuFwtPHmfNdi1q/fGYfaptfItCyCzJC+e
	azrEmJCw6yI9qYBoWmhFth98YPqI6zEAI+C2SsYlzGZkRRi1fNjIro5KvymepDM=
X-Google-Smtp-Source: AGHT+IEuOD6mMoOYP1+ZXn8J654fsnrlqdSXKZuQL602YsnGpaYCCO0kwwL9QjY/ps2l0W7ExxRiUw==
X-Received: by 2002:a17:906:c144:b0:a86:91a5:4d09 with SMTP id a640c23a62f3a-a86a309ae59mr140738466b.26.1724403454000;
        Fri, 23 Aug 2024 01:57:34 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f299e28sm230756866b.56.2024.08.23.01.57.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 01:57:33 -0700 (PDT)
Message-ID: <8faa6b6d-a013-4a71-a8b7-af02ac92d94b@tuxon.dev>
Date: Fri, 23 Aug 2024 11:57:30 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to
 initialize the bus
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "geert+renesas@glider.be" <geert+renesas@glider.be>,
 "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "mturquette@baylibre.com" <mturquette@baylibre.com>,
 "sboyd@kernel.org" <sboyd@kernel.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240822152801.602318-1-claudiu.beznea.uj@bp.renesas.com>
 <20240822152801.602318-11-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113468A6CA4ADBCA577670AD486882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TY3PR01MB113468A6CA4ADBCA577670AD486882@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 23.08.2024 10:35, Biju Das wrote:
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Thursday, August 22, 2024 4:28 PM
>> Subject: [PATCH 10/16] phy: renesas: rcar-gen3-usb2: Add support to initialize the bus
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S need to initialize the USB BUS before transferring data due to hardware limitation.
>> As the register that need to be touched for this is in the address space of the USB PHY, and the UBS
>> PHY need to be initialized before any other USB drivers handling data transfer, add support to
>> initialize the USB BUS.
>>
>> As the USB PHY is probed before any other USB drivers that enables clocks and de-assert the reset
>> signals and the BUS initialization is done in the probe phase, we need to add code to de-assert reset
>> signal and runtime resume the device (which enables its clocks) before accessing the registers.
>>
>> As the reset signals are not required by the USB PHY driver for the other USB PHY hardware variants,
>> the reset signals and runtime PM was handled only in the function that initialize the USB BUS.
>>
>> The PHY initialization was done right after runtime PM enable to have all in place when the PHYs are
>> registered.
> 
> There is no user for this patch. The first user is RZ/G3S and you should merge this patch with
> next one.

I think this is a matter of taste... This is how I usually format the
patches (for scenarios like this) and got no request for squashing.

Anyway, I can do it your way, too.

Thank you,
Claudiu Beznea

> 
> Cheers,
> Biju
> 
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/phy/renesas/phy-rcar-gen3-usb2.c | 50 ++++++++++++++++++++++--
>>  1 file changed, 47 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> index 7594f64eb737..cf4299cea579 100644
>> --- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
>> @@ -19,12 +19,14 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/reset.h>
>>  #include <linux/string.h>
>>  #include <linux/usb/of.h>
>>  #include <linux/workqueue.h>
>>
>>  /******* USB2.0 Host registers (original offset is +0x200) *******/
>>  #define USB2_INT_ENABLE		0x000
>> +#define USB2_AHB_BUS_CTR	0x008
>>  #define USB2_USBCTR		0x00c
>>  #define USB2_SPD_RSM_TIMSET	0x10c
>>  #define USB2_OC_TIMSET		0x110
>> @@ -40,6 +42,10 @@
>>  #define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)	/* For EHCI */
>>  #define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)	/* For OHCI */
>>
>> +/* AHB_BUS_CTR */
>> +#define USB2_AHB_BUS_CTR_MBL_MASK	GENMASK(1, 0)
>> +#define USB2_AHB_BUS_CTR_MBL_INCR4	2
>> +
>>  /* USBCTR */
>>  #define USB2_USBCTR_DIRPD	BIT(2)
>>  #define USB2_USBCTR_PLL_RST	BIT(1)
>> @@ -111,6 +117,7 @@ struct rcar_gen3_chan {
>>  	struct extcon_dev *extcon;
>>  	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
>>  	struct regulator *vbus;
>> +	struct reset_control *rstc;
>>  	struct work_struct work;
>>  	struct mutex lock;	/* protects rphys[...].powered */
>>  	enum usb_dr_mode dr_mode;
>> @@ -125,6 +132,7 @@ struct rcar_gen3_chan {  struct rcar_gen3_phy_drv_data {
>>  	const struct phy_ops *phy_usb2_ops;
>>  	bool no_adp_ctrl;
>> +	bool init_bus;
>>  };
>>
>>  /*
>> @@ -650,6 +658,35 @@ static enum usb_dr_mode rcar_gen3_get_dr_mode(struct device_node *np)
>>  	return candidate;
>>  }
>>
>> +static int rcar_gen3_phy_usb2_init_bus(struct rcar_gen3_chan *channel)
>> +{
>> +	struct device *dev = channel->dev;
>> +	int ret;
>> +	u32 val;
>> +
>> +	channel->rstc = devm_reset_control_array_get_shared(dev);
>> +	if (IS_ERR(channel->rstc))
>> +		return PTR_ERR(channel->rstc);
>> +
>> +	ret = pm_runtime_resume_and_get(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = reset_control_deassert(channel->rstc);
>> +	if (ret)
>> +		goto rpm_put;
>> +
>> +	val = readl(channel->base + USB2_AHB_BUS_CTR);
>> +	val &= ~USB2_AHB_BUS_CTR_MBL_MASK;
>> +	val |= USB2_AHB_BUS_CTR_MBL_INCR4;
>> +	writel(val, channel->base + USB2_AHB_BUS_CTR);
>> +
>> +rpm_put:
>> +	pm_runtime_put(dev);
>> +
>> +	return ret;
>> +}
>> +
>>  static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)  {
>>  	const struct rcar_gen3_phy_drv_data *phy_data; @@ -703,6 +740,15 @@ static int
>> rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>>  		goto error;
>>  	}
>>
>> +	platform_set_drvdata(pdev, channel);
>> +	channel->dev = dev;
>> +
>> +	if (phy_data->init_bus) {
>> +		ret = rcar_gen3_phy_usb2_init_bus(channel);
>> +		if (ret)
>> +			goto error;
>> +	}
>> +
>>  	channel->soc_no_adp_ctrl = phy_data->no_adp_ctrl;
>>  	if (phy_data->no_adp_ctrl)
>>  		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN; @@ -733,9 +779,6 @@ static int
>> rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
>>  		channel->vbus = NULL;
>>  	}
>>
>> -	platform_set_drvdata(pdev, channel);
>> -	channel->dev = dev;
>> -
>>  	provider = devm_of_phy_provider_register(dev, rcar_gen3_phy_usb2_xlate);
>>  	if (IS_ERR(provider)) {
>>  		dev_err(dev, "Failed to register PHY provider\n"); @@ -762,6 +805,7 @@ static void
>> rcar_gen3_phy_usb2_remove(struct platform_device *pdev)
>>  	if (channel->is_otg_channel)
>>  		device_remove_file(&pdev->dev, &dev_attr_role);
>>
>> +	reset_control_assert(channel->rstc);
>>  	pm_runtime_disable(&pdev->dev);
>>  };
>>
>> --
>> 2.39.2
> 

