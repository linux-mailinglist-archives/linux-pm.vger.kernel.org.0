Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD23643231D
	for <lists+linux-pm@lfdr.de>; Mon, 18 Oct 2021 17:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbhJRPmT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Oct 2021 11:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbhJRPmR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Oct 2021 11:42:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6736EC061745
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 08:40:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e12so42214265wra.4
        for <linux-pm@vger.kernel.org>; Mon, 18 Oct 2021 08:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pjlDidMjUP54gNnWHEztCEIW6CfLvZ4h/Q6wK7PbSKk=;
        b=VLCqQd5lCp6WvwDEA5GFEkCQ5+CNUFltDinOxOC907MtLaXIT3zPBANhDsE+kN5JX4
         asJTtKUMb1XGdoXVRfyK4r8kfe2BPyAGwlAdr75C9BHOoHk/k5VwaUaE04m2tfo9PunI
         6Wzotf50yIxvDiEYI31iRmyuRzp03ORnGdO6j2rgnIPV3iUlFegzOyjH0SLrgudmv238
         a03KzWaoVOEJuwS2y37B29deujv3DSwOM/f+KxuW9NQSDGsnBp2UHqg3NyXnWQ+mJtBl
         0Np2YQwT8YekFnswy0KfM5FQmgy/LkAKJZmApN3TkmIGxirZYE70F+V6C8cqO2NY0hzW
         HliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pjlDidMjUP54gNnWHEztCEIW6CfLvZ4h/Q6wK7PbSKk=;
        b=x0tmV/QJiX1vA7scl+4hB8fLJZNBJNZ5OC5Mg5yxjKn+kRG0MRSlH1ZQXnXHvfPC5g
         GJ+Gu9Mf07RoBP1+3A3TgI8w8eJYc3oLTKxlEx0gwRJWV4ZKVftaMB7mSzrOER4PbDpO
         ufVrDzl0QKCO6lp5qwcerFw253ebpgJZ7I/SBapnoMIO+1CJdG+BetB1l0wGMNUCyAZV
         6wJNW5Dpt79f4qfeHlky8KZER3c1bxc+Ik8n6ywmC1vgbo7tx8DSDDstdbqnFVqDl8QO
         kEiapTrLz5YAYuhmG7cOsYqyC2uMX3WyMEpNO4rExl+5olkE9BuIKD8MkC0wdal++Ex+
         dQCg==
X-Gm-Message-State: AOAM531aFb7pIgjP7vrWviFdMuXBTF70JQlnCIGfnAxtfJN5CiHQlyJp
        dV+kRYtFi/wHO1/m6ppdzaJHHg==
X-Google-Smtp-Source: ABdhPJy/pQcdiOs4mcK3rfZtbnFO8PF2JEU9NxxxCX5B3S5ikVNoWX+n9XNbC5OEjQ4lOu/gwDIDPA==
X-Received: by 2002:a05:6000:1541:: with SMTP id 1mr35650882wry.273.1634571603956;
        Mon, 18 Oct 2021 08:40:03 -0700 (PDT)
Received: from blmsp ([2a02:2454:3e6:c900:5142:5fbb:5821:5dc3])
        by smtp.gmail.com with ESMTPSA id u5sm12227325wmm.39.2021.10.18.08.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 08:40:02 -0700 (PDT)
Date:   Mon, 18 Oct 2021 17:40:01 +0200
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fparent@baylibre.com,
        khilman@baylibre.com
Subject: Re: [PATCH 3/3] thermal: mediatek: add MT8365 thermal driver support
Message-ID: <20211018154001.sj7nc575hln3jkel@blmsp>
References: <20211014135636.3644166-1-msp@baylibre.com>
 <20211014135636.3644166-4-msp@baylibre.com>
 <33815817-0f64-836a-5417-c614e66e231e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33815817-0f64-836a-5417-c614e66e231e@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Sat, Oct 16, 2021 at 10:06:28PM +0200, Daniel Lezcano wrote:
> On 14/10/2021 15:56, Markus Schneider-Pargmann wrote:
> > From: Fabien Parent <fparent@baylibre.com>
> > 
> > mt8365 is similar to the other SoCs supported by the driver. It has only
> > one bank and 3 sensors that can be multiplexed.
> > 
> > Additionally the buffer has to be enabled and connected to AUXADC
> > similar to the V2 version but at a different register offset. That's why
> > I added three new configuration values to define the register, mask and
> > bits to be set to be able to use it for both V2 and mt8365.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > [Added apmixed control register logic]
> > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > ---
> >  drivers/thermal/mtk_thermal.c | 91 ++++++++++++++++++++++++++++++++---
> >  1 file changed, 85 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> > index 93ee043d70da..7a75ae8231f2 100644
> > --- a/drivers/thermal/mtk_thermal.c
> > +++ b/drivers/thermal/mtk_thermal.c
> > @@ -31,6 +31,7 @@
> >  #define AUXADC_CON2_V		0x010
> >  #define AUXADC_DATA(channel)	(0x14 + (channel) * 4)
> >  
> > +#define APMIXED_SYS_TS_CON0	0x600
> >  #define APMIXED_SYS_TS_CON1	0x604
> >  
> >  /* Thermal Controller Registers */
> > @@ -245,6 +246,17 @@ enum mtk_thermal_version {
> >  /* The calibration coefficient of sensor  */
> >  #define MT8183_CALIBRATION	153
> >  
> > +/* MT8365 */
> > +#define MT8365_TEMP_AUXADC_CHANNEL 11
> > +#define MT8365_CALIBRATION 164
> > +#define MT8365_NUM_CONTROLLER 1
> > +#define MT8365_NUM_BANKS 1
> > +#define MT8365_NUM_SENSORS 3
> > +#define MT8365_NUM_SENSORS_PER_ZONE 3
> 
> You can get rid of these macros by using ARRAY_SIZE.
> 
> eg.
> 
> static const int mt8365_bank_data[] = {
> 	MT8365_TS1,
> 	MT8365_TS2,
> 	MT8365_TS3
> };
> 
> ...
> 
> 	.num_sensors = ARRAY_SIZE(mt8365_bank_data);
> ...
> 

Thanks, done, I also used ARRAY_SIZE() on the other array definitions to
enforce that they have the correct size.

> 
> > +#define MT8365_TS1 0
> > +#define MT8365_TS2 1
> > +#define MT8365_TS3 2
> > +
> >  struct mtk_thermal;
> >  
> >  struct thermal_bank_cfg {
> > @@ -271,6 +283,9 @@ struct mtk_thermal_data {
> >  	bool need_switch_bank;
> >  	struct thermal_bank_cfg bank_data[MAX_NUM_ZONES];
> >  	enum mtk_thermal_version version;
> > +	u32 apmixed_buffer_ctl_reg;
> > +	u32 apmixed_buffer_ctl_mask;
> > +	u32 apmixed_buffer_ctl_set;
> >  };
> >  
> >  struct mtk_thermal {
> > @@ -386,6 +401,24 @@ static const int mt7622_mux_values[MT7622_NUM_SENSORS] = { 0, };
> >  static const int mt7622_vts_index[MT7622_NUM_SENSORS] = { VTS1 };
> >  static const int mt7622_tc_offset[MT7622_NUM_CONTROLLER] = { 0x0, };
> >  
> > +/* MT8365 thermal sensor data */
> > +static const int mt8365_bank_data[MT8365_NUM_SENSORS] = {
> > +	MT8365_TS1, MT8365_TS2, MT8365_TS3
> > +};
> > +
> > +static const int mt8365_msr[MT8365_NUM_SENSORS_PER_ZONE] = {
> > +	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2
> > +};
> > +
> > +static const int mt8365_adcpnp[MT8365_NUM_SENSORS_PER_ZONE] = {
> > +	TEMP_ADCPNP0, TEMP_ADCPNP1, TEMP_ADCPNP2
> > +};
> > +
> > +static const int mt8365_mux_values[MT8365_NUM_SENSORS] = { 0, 1, 2 };
> > +static const int mt8365_tc_offset[MT8365_NUM_CONTROLLER] = { 0 };
> > +
> > +static const int mt8365_vts_index[MT8365_NUM_SENSORS] = { VTS1, VTS2, VTS3 };
> > +
> >  /*
> >   * The MT8173 thermal controller has four banks. Each bank can read up to
> >   * four temperature sensors simultaneously. The MT8173 has a total of 5
> > @@ -460,6 +493,40 @@ static const struct mtk_thermal_data mt2701_thermal_data = {
> >  	.version = MTK_THERMAL_V1,
> >  };
> >  
> > +/*
> > + * The MT8365 thermal controller has one bank, which can read up to
> > + * four temperature sensors simultaneously. The MT8365 has a total of 3
> > + * temperature sensors.
> > + *
> > + * The thermal core only gets the maximum temperature of this one bank,
> > + * so the bank concept wouldn't be necessary here. However, the SVS (Smart
> > + * Voltage Scaling) unit makes its decisions based on the same bank
> > + * data.
> > + */
> > +static const struct mtk_thermal_data mt8365_thermal_data = {
> > +	.auxadc_channel = MT8365_TEMP_AUXADC_CHANNEL,
> > +	.num_banks = MT8365_NUM_BANKS,
> > +	.num_sensors = MT8365_NUM_SENSORS,
> > +	.vts_index = mt8365_vts_index,
> > +	.cali_val = MT8365_CALIBRATION,
> > +	.num_controller = MT8365_NUM_CONTROLLER,
> > +	.controller_offset = mt8365_tc_offset,
> > +	.need_switch_bank = false,
> > +	.bank_data = {
> > +		{
> > +			.num_sensors = MT8365_NUM_SENSORS,
> > +			.sensors = mt8365_bank_data
> > +		},
> > +	},
> > +	.msr = mt8365_msr,
> > +	.adcpnp = mt8365_adcpnp,
> > +	.sensor_mux_values = mt8365_mux_values,
> > +	.version = MTK_THERMAL_V1,
> > +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON0,
> > +	.apmixed_buffer_ctl_mask = ~(u32)GENMASK(29, 28),
> > +	.apmixed_buffer_ctl_set = 0,
> > +};
> > +
> >  /*
> >   * The MT2712 thermal controller has one bank, which can read up to
> >   * four temperature sensors simultaneously. The MT2712 has a total of 4
> > @@ -514,6 +581,9 @@ static const struct mtk_thermal_data mt7622_thermal_data = {
> >  	.adcpnp = mt7622_adcpnp,
> >  	.sensor_mux_values = mt7622_mux_values,
> >  	.version = MTK_THERMAL_V2,
> > +	.apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> > +	.apmixed_buffer_ctl_mask = ~0x37,
> > +	.apmixed_buffer_ctl_set = 0x1,
> 
> Please change those literal into macros

done.

> 
> >  };
> >  
> >  /*
> > @@ -958,19 +1028,27 @@ static const struct of_device_id mtk_thermal_of_match[] = {
> >  	{
> >  		.compatible = "mediatek,mt8183-thermal",
> >  		.data = (void *)&mt8183_thermal_data,
> > +	},
> > +	{
> > +		.compatible = "mediatek,mt8365-thermal",
> > +		.data = (void *)&mt8365_thermal_data,
> 
> Is this cast really needed ?

No, removed and created another patch to fix all other ones. Would look
weird otherwise.

> 
> >  	}, {
> >  	},
> >  };
> >  MODULE_DEVICE_TABLE(of, mtk_thermal_of_match);
> >  
> > -static void mtk_thermal_turn_on_buffer(void __iomem *apmixed_base)
> > +static void mtk_thermal_turn_on_buffer(struct mtk_thermal *mt,
> > +				       void __iomem *apmixed_base)
> >  {
> >  	int tmp;
> >  
> > -	tmp = readl(apmixed_base + APMIXED_SYS_TS_CON1);
> > -	tmp &= ~(0x37);
> > -	tmp |= 0x1;
> > -	writel(tmp, apmixed_base + APMIXED_SYS_TS_CON1);
> > +	if (!mt->conf->apmixed_buffer_ctl_reg)
> > +		return;
> > +
> > +	tmp = readl(apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
> > +	tmp &= mt->conf->apmixed_buffer_ctl_mask;
> > +	tmp |= mt->conf->apmixed_buffer_ctl_set;
> 
> What is the goal of these two bits operations ?

mt7622 needs to unset a few bits and set one bit in this register.
mt8365 only unsets bits. For this purpose I created a _mask field to
unset bits and a _set field to set bits.

Would you suggest a different way?

Thanks for your feedback.

Best,
Markus

> 
> > +	writel(tmp, apmixed_base + mt->conf->apmixed_buffer_ctl_reg);
> >  	udelay(200);
> >  }
> >  
> > @@ -1070,8 +1148,9 @@ static int mtk_thermal_probe(struct platform_device *pdev)
> >  		goto err_disable_clk_auxadc;
> >  	}
> >  
> > +	mtk_thermal_turn_on_buffer(mt, apmixed_base);
> > +
> >  	if (mt->conf->version == MTK_THERMAL_V2) {
> > -		mtk_thermal_turn_on_buffer(apmixed_base);
> >  		mtk_thermal_release_periodic_ts(mt, auxadc_base);
> >  	}
> >  
> > 
> 
> 
> -- 
> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
