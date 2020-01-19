Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD33141CDC
	for <lists+linux-pm@lfdr.de>; Sun, 19 Jan 2020 08:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgASHhk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 19 Jan 2020 02:37:40 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34644 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgASHhk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 19 Jan 2020 02:37:40 -0500
Received: by mail-qk1-f193.google.com with SMTP id j9so27165291qkk.1;
        Sat, 18 Jan 2020 23:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sQlkgm79WGoIWETmPQFCd9M6iRMmjRgwgIkAakW/+c=;
        b=h1cn4v3VVndWVOkwr+/WfQHckHgOClCe0TFEuCNrEn0Me4pdBT+BMa2oDc+PNhCNqu
         iYAVZ9gLmXjCMgg0gtE/xgMrYXv2N8JdqkZ0IhEAN7nasKILmc/TrYekYAbxRuQORZNR
         4I7jGB/lqZYJOL+EgrxPx3vLMomyU6Q0kuyXG2HU11BzTBl166omNkC7sStsquzDwAfy
         U7suNKbF2fmYV2XbE4UelnXaCFmAk4MI8dmIN4b6j31s9UGhLrTOYXCUEBgMI74UzKy8
         RvncQ/jeAmLZ2UDN3fBgaASQK/LHdJUrWvV+TJClvDrzB5jkGTJK85ciXFYqSsdXFSR6
         mrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sQlkgm79WGoIWETmPQFCd9M6iRMmjRgwgIkAakW/+c=;
        b=CC51qyEL76g6gP4jftciXUt0Yt/vBzJ+sTZ0r8AoHJcDiPH8qdaH2Ve3T/9itu8+3z
         TEFJ1LogR4VjvGaeJyZywSUpQ8C3fSnrY6H7h7DRBkn1819+ViNC1kSvmAM7FonDvEyj
         SWIPHvWclLHVDL5OfqnXQ+Xix71gskIH43KMwCqnj0U/WktQmlQsp50T83RdEWZEBiVO
         aDZDGzhSg0ga9bgi57LYj/L4Y92l7l5a586vj7Z5ZBnc8AbRveI1UcRpPkidtzTLrNBX
         m1Clj8nAo7EZjqOOddATCducnDMH2G7I5OCNXpY4+hvyzTW1u+vR/glRmXI2gNyxfNGu
         4REQ==
X-Gm-Message-State: APjAAAVbBXaQvAq8sASPoeB9xXeeSp7ogNjO2Mj6wbKGVdd12BA22RD+
        tG5VVJg6187a3nkK2glxSBENAFAhi/f92HuIa3A=
X-Google-Smtp-Source: APXvYqzyh/qFVp9njLbzx0sFowOdZZeFjHQN6WIAlqdEsGSEp8/Hr19ghP+ad3tyBEd7OwhHO6ar27Q99WeyAsKk0PY=
X-Received: by 2002:a05:620a:1298:: with SMTP id w24mr45415455qki.170.1579419458776;
 Sat, 18 Jan 2020 23:37:38 -0800 (PST)
MIME-Version: 1.0
References: <8d5358a67746b2aff5f6995cabd11d0d7c9e579e.1575978484.git.baolin.wang7@gmail.com>
 <dd3303a956e7dd5c065ac2b92b1dea7ee5d1df17.1575978484.git.baolin.wang7@gmail.com>
 <b653521a-0296-786c-072d-7f1962f3021a@linaro.org>
In-Reply-To: <b653521a-0296-786c-072d-7f1962f3021a@linaro.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Sun, 19 Jan 2020 15:37:26 +0800
Message-ID: <CADBw62pz7bYO7scSnO35QX2x7NPZ69o6=_zX-rSHAKprbZMbvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: sprd: Add Spreadtrum thermal driver support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>, freeman.liu@unisoc.com,
        Chunyan Zhang <zhang.lyra@gmail.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Daniel,

On Fri, Jan 17, 2020 at 7:52 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 10/12/2019 13:07, Baolin Wang wrote:
> > From: Freeman Liu <freeman.liu@unisoc.com>
> >
> > This patch adds the support for Spreadtrum thermal sensor controller,
> > which can support maximum 8 sensors.
> >
> > Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> > ---
> > Changes from v1:
> >  - None.
> > ---

> > +
> > +struct sprd_thermal_sensor {
> > +     struct thermal_zone_device *thmzone_dev;
> > +     struct sprd_thermal_data *data;
> > +     struct device *dev;
> > +     bool ready;
> > +     int cal_slope;
> > +     int cal_offset;
> > +     int last_temp;
> > +     int id;
> > +};
> > +
> > +struct sprd_thermal_data {
> > +     const struct sprd_thm_variant_data *var_data;
> > +     struct sprd_thermal_sensor *sensor[SPRD_THM_MAX_SENSOR];
> > +     struct clk *clk;
> > +     void __iomem *base;
> > +     u32 ratio_off;
> > +     u32 ratio_sign;
> > +     int nr_sensors;
> > +};
> > +
> > +/*
> > + * The conversion between ADC and temperature is based on linear relationship,
> > + * and use idea_k to specify the slope and ideal_b to specify the offset.
> > + *
> > + * Since different Spreadtrum SoCs have different ideal_k and ideal_b,
> > + * we should save ideal_k and ideal_b in the device data structure.
> > + */
> > +struct sprd_thm_variant_data {
> > +     u32 ideal_k;
> > +     u32 ideal_b;
> > +};
> > +
> > +static const struct sprd_thm_variant_data ums512_data = {
> > +     .ideal_k = 262,
> > +     .ideal_b = 66400,
> > +};
> > +
> > +static inline void sprd_thm_update_bits(void __iomem *reg, u32 mask, u32 val)
> > +{
> > +     u32 tmp, orig;
> > +
> > +     orig = readl(reg);
> > +     tmp = orig & ~mask;
> > +     tmp |= val & mask;
> > +     writel(tmp, reg);
>
> Please have a look at linux/bitops.h and check if a macro does not fit
> your need (eg. set_mask_bits and set_bit). AFAICT, most of the operation
> are clear/set bits.

We are updating a register here, not updating a vriable. So I think it
is not helpful with using set_mask_bits or set_bit.

>
> > +}
> > +
> > +static int sprd_thm_cal_read(struct device_node *np, const char *cell_id,
> > +                          u32 *val)
> > +{
> > +     struct nvmem_cell *cell;
> > +     void *buf;
> > +     size_t len;
> > +
> > +     cell = of_nvmem_cell_get(np, cell_id);
> > +     if (IS_ERR(cell))
> > +             return PTR_ERR(cell);
> > +
> > +     buf = nvmem_cell_read(cell, &len);
> > +     nvmem_cell_put(cell);
> > +     if (IS_ERR(buf))
> > +             return PTR_ERR(buf);
> > +
> > +     memcpy(val, buf, min(len, sizeof(u32)));
>
> I'm probably nitpicking but what if the len is different from the u32,
> the result will be inconsistent. If that can happen, wouldn't make sense
> to bail out before with an error ?

OK. Will change to give some error.

>
> > +     kfree(buf);
> > +     return 0;
> > +}
> > +
> > +static int sprd_thm_senor_calibration(struct device_node *np,
> > +                                   struct sprd_thermal_data *thm,
> > +                                   struct sprd_thermal_sensor *sen)
>
> "senor_calibration" or "sensor_calibration" ?

Sure.

>
> > +{
> > +     int ret;
> > +     /*
> > +      * According to thermal datasheet, the default calibration offset is 64,
> > +      * and the default ratio is 1000.
> > +      */
> > +     int dt_offset = 64, ratio = 1000;
> > +
> > +     ret = sprd_thm_cal_read(np, "sen_delta_cal", &dt_offset);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (thm->ratio_sign == 1)
> > +             ratio = 1000 - thm->ratio_off;
> > +     else
> > +             ratio = 1000 + thm->ratio_off;
>
> Store ratio_sign = -1 | 1 at init time, then :
>
>   ratio += ratio_sign * thm->ratio_off

OK.

>
> > +     /*
> > +      * According to the ideal slope K and ideal offset B, combined with
> > +      * calibration value of thermal from efuse, then calibrate the real
> > +      * slope k and offset b:
> > +      * k_cal = (k * ratio) / 1000.
> > +      * b_cal = b + (dt_offset - 64) * 500.
> > +      */
> > +     sen->cal_slope = (thm->var_data->ideal_k * ratio) / 1000;
> > +     sen->cal_offset = thm->var_data->ideal_b + (dt_offset - 128) * 250;
> > +
> > +     return 0;
> > +}
> > +
> > +static int sprd_thm_rawdata_to_temp(struct sprd_thermal_sensor *sen,
> > +                                 u32 rawdata)
> > +{
> > +     if (rawdata < SPRD_THM_RAW_DATA_LOW)
> > +             rawdata = SPRD_THM_RAW_DATA_LOW;
> > +     else if (rawdata > SPRD_THM_RAW_DATA_HIGH)
> > +             rawdata = SPRD_THM_RAW_DATA_HIGH;
>
> check clamp() macro in kernel.h

Yes, will do.

>
> > +     /*
> > +      * According to the thermal datasheet, the formula of converting
> > +      * adc value to the temperature value should be:
> > +      * T_final = k_cal * x - b_cal.
> > +      */
> > +     return sen->cal_slope * rawdata - sen->cal_offset;
> > +}
> > +
> > +static int sprd_thm_temp_to_rawdata(int temp, struct sprd_thermal_sensor *sen)
> > +{
> > +     u32 val;
> > +
> > +     if (temp < SPRD_THM_TEMP_LOW)
> > +             temp = SPRD_THM_TEMP_LOW;
> > +     else if (temp > SPRD_THM_TEMP_HIGH)
> > +             temp = SPRD_THM_TEMP_HIGH;
>
> check clamp() macro in kernel.h

OK.

>
> > +     /*
> > +      * According to the thermal datasheet, the formula of converting
> > +      * adc value to the temperature value should be:
> > +      * T_final = k_cal * x - b_cal.
> > +      */
> > +     val = (temp + sen->cal_offset) / sen->cal_slope;
> > +
> > +     return val >= SPRD_THM_RAW_DATA_HIGH ? (SPRD_THM_RAW_DATA_HIGH - 1) : val;
>
> check clamp() macro in kernel.h

OK.

>
> > +}
> > +
> > +static int sprd_thm_read_temp(void *devdata, int *temp)
> > +{
> > +     struct sprd_thermal_sensor *sen = devdata;
> > +     int sensor_temp;
> > +     u32 data;
> > +
> > +     data = readl(sen->data->base + SPRD_THM_TEMP(sen->id)) &
> > +             SPRD_THM_RAW_READ_MSK;
> > +
> > +     if (sen->ready) {
> > +             sensor_temp = sprd_thm_rawdata_to_temp(sen, data);
> > +             sen->last_temp = sensor_temp;
> > +             *temp = sensor_temp;
>
> If the initialization is done in the right order and using the
> THERMAL_DEVICE_DISABLED, this test should not be needed. And de facto,
> neither the last_temp.
>
> As a side note, if the sensor is not ready it should return an error
> like -EBUSY instead of the previous value.

OK. Will use THERMAL_DEVICE_DISABLED and remove 'last_temp'.

>
> > +     } else {
> > +             /*
> > +              * If the sensor is not ready, then just return last
> > +              * temperature value.
> > +              */
> > +             *temp = sen->last_temp;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct thermal_zone_of_device_ops sprd_thm_ops = {
> > +     .get_temp = sprd_thm_read_temp,
> > +};
> > +
> > +static int sprd_thm_poll_ready_status(struct sprd_thermal_data *thm)
> > +{
> > +     u32 val;
> > +     int ret;
> > +
> > +     /*
> > +      * Wait for thermal ready status before configuring thermal parameters.
> > +      */
> > +     ret = readl_poll_timeout(thm->base + SPRD_THM_CTL, val,
> > +                              !(val & SPRD_THM_SET_RDY_ST),
> > +                              SPRD_THM_RDYST_POLLING_TIME,
> > +                              SPRD_THM_RDYST_TIMEOUT);
> > +     if (ret)
> > +             return ret;
> > +
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_MON_EN,
> > +                          SPRD_THM_MON_EN);
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_SET_RDY,
> > +                          SPRD_THM_SET_RDY);
> > +     return 0;
> > +}
> > +
> > +static int sprd_thm_wait_temp_ready(struct sprd_thermal_data *thm)
> > +{
> > +     u32 val;
> > +
> > +     /* Wait for first temperature data ready before reading temperature */
> > +     return readl_poll_timeout(thm->base + SPRD_THM_INTERNAL_STS1, val,
> > +                               !(val & SPRD_THM_TEMPER_RDY),
> > +                               SPRD_THM_TEMP_READY_POLL_TIME,
> > +                               SPRD_THM_TEMP_READY_TIMEOUT);
> > +}
> > +
> > +static int sprd_thm_set_ready(struct sprd_thermal_data *thm)
> > +{
> > +     int ret;
> > +
> > +     ret = sprd_thm_poll_ready_status(thm);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * Clear interrupt status, enable thermal interrupt and enable thermal.
> > +      */
> > +     writel(SPRD_THM_INT_CLR_MASK, thm->base + SPRD_THM_INT_CLR);
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_INT_EN,
> > +                          SPRD_THM_BIT_INT_EN, SPRD_THM_BIT_INT_EN);
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_CTL,
> > +                          SPRD_THM_EN, SPRD_THM_EN);
>
> Why enabling the interrupt while there is no handler for it?

Our thermal controller integrates a hardware interrupt signal, which
means if the temperature is overheat, it will generate an interrupt
and notify the event to PMIC automatically to shutdown the system. So
we should enable the interrupt bits, but no need to register handler.

I will add some comments to explain this in next verison.

>
> > +     return 0;
> > +}
> > +
> > +static void sprd_thm_sensor_init(struct sprd_thermal_data *thm,
> > +                              struct sprd_thermal_sensor *sen)
> > +{
> > +     u32 otp_rawdata, hot_rawdata;
> > +
> > +     otp_rawdata = sprd_thm_temp_to_rawdata(SPRD_THM_OTP_TEMP, sen);
> > +     hot_rawdata = sprd_thm_temp_to_rawdata(SPRD_THM_HOT_TEMP, sen);
> > +
> > +     /* Enable the sensor' overheat temperature protection interrupt */
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_INT_EN,
> > +                          SPRD_THM_SEN_OVERHEAT_ALARM_EN(sen->id),
> > +                          SPRD_THM_SEN_OVERHEAT_ALARM_EN(sen->id));
> > +
> > +     /* Set the sensor' overheat and hot threshold temperature */
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_THRES(sen->id),
> > +                          SPRD_THM_THRES_MASK,
> > +                          (otp_rawdata << SPRD_THM_OTP_TRIP_SHIFT) |
> > +                          hot_rawdata);
> > +
> > +     /* Enable the corresponding sensor */
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_CTL, SPRD_THM_SEN(sen->id),
> > +                          SPRD_THM_SEN(sen->id));
> > +}
> > +
> > +static void sprd_thm_para_config(struct sprd_thermal_data *thm)
> > +{
> > +     /* Set the period of two valid temperature detection action */
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_DET_PERIOD,
> > +                          SPRD_THM_DET_PERIOD_MASK, SPRD_THM_DET_PERIOD);
> > +
> > +     /* Set the sensors' monitor mode */
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_MON_CTL,
> > +                          SPRD_THM_MON_MODE_MASK, SPRD_THM_MON_MODE);
> > +
> > +     /* Set the sensors' monitor period */
> > +     sprd_thm_update_bits(thm->base + SPRD_THM_MON_PERIOD,
> > +                          SPRD_THM_MON_PERIOD_MASK, SPRD_THM_MON_PERIOD);
> > +}
> > +
> > +static int sprd_thm_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *np = pdev->dev.of_node;
> > +     struct device_node *sen_child;
> > +     struct sprd_thermal_data *thm;
> > +     struct sprd_thermal_sensor *sen;
> > +     const struct sprd_thm_variant_data *pdata;
> > +     int ret, i;
> > +
> > +     pdata = of_device_get_match_data(&pdev->dev);
> > +     if (!pdata) {
> > +             dev_err(&pdev->dev, "No matching driver data found\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     thm = devm_kzalloc(&pdev->dev, sizeof(*thm), GFP_KERNEL);
> > +     if (!thm)
> > +             return -ENOMEM;
> > +
> > +     thm->var_data = pdata;
> > +     thm->base = devm_platform_ioremap_resource(pdev, 0);
> > +     if (!thm->base)
> > +             return -ENOMEM;
> > +
> > +     thm->nr_sensors = of_get_child_count(np);
> > +     if (thm->nr_sensors == 0 || thm->nr_sensors > SPRD_THM_MAX_SENSOR) {
> > +             dev_err(&pdev->dev, "incorrect sensor count\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     thm->clk = devm_clk_get(&pdev->dev, "enable");
> > +     if (IS_ERR(thm->clk)) {
> > +             dev_err(&pdev->dev, "failed to get enable clock\n");
> > +             return PTR_ERR(thm->clk);
> > +     }
> > +
> > +     ret = clk_prepare_enable(thm->clk);
> > +     if (ret)
> > +             return ret;
> > +
> > +     sprd_thm_para_config(thm);
> > +
> > +     ret = sprd_thm_cal_read(np, "thm_sign_cal", &thm->ratio_sign);
> > +     if (ret)
> > +             goto disable_clk;
> > +
> > +     ret = sprd_thm_cal_read(np, "thm_ratio_cal", &thm->ratio_off);
> > +     if (ret)
> > +             goto disable_clk;
> > +
> > +     for_each_child_of_node(np, sen_child) {
> > +             sen = devm_kzalloc(&pdev->dev, sizeof(*sen), GFP_KERNEL);
> > +             if (!sen) {
> > +                     ret = -ENOMEM;
> > +                     goto disable_clk;
> > +             }
> > +
> > +             sen->ready = false;
> > +             sen->data = thm;
> > +             sen->dev = &pdev->dev;
> > +
> > +             ret = of_property_read_u32(sen_child, "reg", &sen->id);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "get sensor reg failed");
> > +                     goto disable_clk;
> > +             }
> > +
> > +             ret = sprd_thm_senor_calibration(sen_child, thm, sen);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "efuse cal analysis failed");
> > +                     goto disable_clk;
> > +             }
> > +
> > +             sprd_thm_sensor_init(thm, sen);
> > +
> > +             sen->thmzone_dev =
> > +                     devm_thermal_zone_of_sensor_register(sen->dev, sen->id,
> > +                                                          sen, &sprd_thm_ops);
> > +             if (IS_ERR(sen->thmzone_dev)) {
> > +                     dev_err(&pdev->dev, "register thermal zone failed %d\n",
> > +                             sen->id);
> > +                     ret = PTR_ERR(sen->thmzone_dev);
> > +                     goto disable_clk;
> > +             }
> > +
> > +             thm->sensor[sen->id] = sen;
> > +     }
> > +
> > +     ret = sprd_thm_set_ready(thm);
> > +     if (ret)
> > +             goto disable_clk;
> > +
> > +     ret = sprd_thm_wait_temp_ready(thm);
> > +     if (ret)
> > +             goto disable_clk;
> > +
> > +     for (i = 0; i < thm->nr_sensors; i++)
> > +             thm->sensor[i]->ready = true;
>
> You should replace 'ready' by the THERMAL_DEVICE_ENABLED/DISABLED (grep
> it on the other drivers for reference) and/or call
> devm_thermal_zone_of_sensor_register() here.

Sure. I think we missed THERMAL_DEVICE_ENABLED/DISABLED flag.

Thanks for your comments.
